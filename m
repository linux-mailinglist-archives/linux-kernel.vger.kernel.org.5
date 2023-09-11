Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB53079BEF9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353642AbjIKVrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237483AbjIKMxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 08:53:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A752CEB
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 05:52:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18D7CC433C7;
        Mon, 11 Sep 2023 12:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694436775;
        bh=FLzPw3p0kQxrFTa14LvGrYlCQW3W/+6yIDuqpLfXJFc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pWXgRRNQTEZLQUVmks5n63JKpzn1IcUYG0nZctUPAA9+QHguHMvUYqfSO79BAailm
         tjrPUycJio4JW3o+rLHZRQbQeZEOpBz3IibOEMimFqgpb3jzcsEIUo2QqUP/lyOpEp
         tspRxpDXjkxt7FRdoOhak7UBji2B6ICw0qU8SY+BKNTgffpaUmzIcbTCWZfeJ/6dGs
         O809Qedx5NwqRDA/pzs0dkhzC0FEXSI2seAulU/5pP/HZgJVahsFttDupx9NMP0DmK
         nGh0ofetXAk3krk/2na8dlV1gJy9SYaRVuHTLoePxX72/f/vXnXAyYntDQwzGFB1E3
         w06WJOmO4ETEQ==
Date:   Mon, 11 Sep 2023 14:52:51 +0200
From:   Simon Horman <horms@kernel.org>
To:     Jeremy Cline <jeremy@jcline.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+c1d0a03d305972dbbe14@syzkaller.appspotmail.com
Subject: Re: [PATCH net] net: nfc: llcp: Add lock when modifying device list
Message-ID: <20230911125251.GA23672@kernel.org>
References: <20230908235853.1319596-1-jeremy@jcline.org>
 <20230910152812.GJ775887@kernel.org>
 <ZP5L6/zF6fE+ogbz@dev>
 <20230911055904.GN775887@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230911055904.GN775887@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 07:59:04AM +0200, Simon Horman wrote:
> On Sun, Sep 10, 2023 at 07:06:19PM -0400, Jeremy Cline wrote:
> > On Sun, Sep 10, 2023 at 05:28:12PM +0200, Simon Horman wrote:
> > > On Fri, Sep 08, 2023 at 07:58:53PM -0400, Jeremy Cline wrote:
> > > > The device list needs its associated lock held when modifying it, or the
> > > > list could become corrupted, as syzbot discovered.
> > > > 
> > > > Reported-and-tested-by: syzbot+c1d0a03d305972dbbe14@syzkaller.appspotmail.com
> > > > Closes: https://syzkaller.appspot.com/bug?extid=c1d0a03d305972dbbe14
> > > > Signed-off-by: Jeremy Cline <jeremy@jcline.org>
> > > 
> > > Hi Jeremy,
> > > 
> > > thanks for your patch.
> > > 
> > > I don't think you need to resubmit for this,
> > > I think this patch warrants a fixes tag:
> > > 
> > > Fixes: d646960f7986 ("NFC: Initial LLCP support")
> > > 
> > 
> > My bad, indeed. The lock in question looks to have been added in
> > 6709d4b7bc2e ("net: nfc: Fix use-after-free caused by
> > nfc_llcp_find_local") which itself includes a couple fix tags, should
> > this reference that commit instead as it won't backport without that
> > one?
> 
> Yes, I think that is likely.
> Sorry for not noticing that.

And further, sorry for being vague in my previous email.
Having now looked over 6709d4b7bc2e I agree it is
the correct commit for a fixes tag for this patch.

> 
> > > Otherwise, this looks good to me.
> > > 
> > > Reviewed-by: Simon Horman <horms@kernel.org>
> > > 
> > 
> > Thanks,
> > Jeremy
> > 
> 
