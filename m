Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 169937BE92E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 20:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377562AbjJISYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 14:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377556AbjJISYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 14:24:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B431CF;
        Mon,  9 Oct 2023 11:24:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 664CFC433C7;
        Mon,  9 Oct 2023 18:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696875886;
        bh=cA9zXUwr+O+u3uWbzx70nCVbti4LuB6boGArEX9Q3RE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PfdZFu/C8JNmrQsIt2qj2kRI6/McNSt9ay3mBcvJ13bYFFeccg4Q3M4PboH9ScOex
         OQoBhu3ZusKUR9gmWPg+zAStrb1QaLECSuBBTwhOnc1cmB7Z4xT1envBojnMRAmGMo
         B9DpauW6CF61E7KVJ+BI+xIOHfvA1yH9zN/wMuPc=
Date:   Mon, 9 Oct 2023 20:24:43 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org, lwn@lwn.net,
        jslaby@suse.cz
Subject: Re: Linux 4.14.324
Message-ID: <2023100914-flaccid-staining-19c9@gregkh>
References: <2023083037-conceded-candle-b9e8@gregkh>
 <ZSQeA8fhUT++iZvz@ostr-mac>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSQeA8fhUT++iZvz@ostr-mac>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 11:36:35AM -0400, Boris Ostrovsky wrote:
> On Wed, Aug 30, 2023 at 05:02:37PM +0200, Greg Kroah-Hartman wrote:
> > I'm announcing the release of the 4.14.324 kernel.
> > 
> > All users of the 4.14 kernel series must upgrade.
> > 
> > The updated 4.14.y git tree can be found at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-4.14.y
> > and can be browsed at the normal kernel.org git web browser:
> > 	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary
> > 
> ...
> > 
> > Ido Schimmel (1):
> >       rtnetlink: Reject negative ifindexes in RTM_NEWLINK
> 
> 
> The above commit (69197b2 rtnetlink: Reject negative ifindexes in RTM_NEWLINK)
> appears to has been applied icorrectly, causing some regressions (like attaching
> a VF to a running guest). The change needs to be made in rtnl_newlink(), not
> rtnl_setlink().
> 
> I didn't check all other branches but at least 5.4 looks OK.
> 
> I believe 69197b2 needs to be reverted and instead this applied:
> 
> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> index a76f3024..f4b98f7 100644
> --- a/net/core/rtnetlink.c
> +++ b/net/core/rtnetlink.c
> @@ -2547,9 +2547,12 @@ static int rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
>                 ifname[0] = '\0';
>  
>         ifm = nlmsg_data(nlh);
> -       if (ifm->ifi_index > 0)
> +       if (ifm->ifi_index > 0) {
>                 dev = __dev_get_by_index(net, ifm->ifi_index);
> -       else {
> +       } else if (ifm->ifi_index < 0) {
> +               NL_SET_ERR_MSG(extack, "ifindex can't be negative");
> +               return -EINVAL;
> +       } else {
>                 if (ifname[0])
>                         dev = __dev_get_by_name(net, ifname);
>                 else
> 
> 

Ick, good catch!  4.19 also looks wrong, let me go revert the original
and then use this version again instead, many thanks for this!

greg k-h
