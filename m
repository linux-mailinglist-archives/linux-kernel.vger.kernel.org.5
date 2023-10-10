Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD3C7BF2AE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 08:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442193AbjJJGAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 02:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442205AbjJJGAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 02:00:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 391BDC1
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 23:00:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55CBAC433C9;
        Tue, 10 Oct 2023 06:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696917616;
        bh=gQXf/DuKE3gdQ2bmNkAQyrlr4ASiicMGR3NvmU6Ghj0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kjaij1CKbBcWr5w+jLQM24tkojhInog/OnyxdeL0kg/slP8FbEbkGncR/r9nYxeqW
         ysMPNeBz5JXnRjPWZdGt+aTOt31YPue6ncmY0qwFC8LXR6MQsnGYSNFkSnCSfjanZh
         HHCFIloNqqwiFhP7RA/f/p89E1Cr3jR58uNLd18I=
Date:   Tue, 10 Oct 2023 08:00:14 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc:     Peter Korsgaard <peter@korsgaard.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        syzbot+1f53a30781af65d2c955@syzkaller.appspotmail.com,
        netdev@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: usb: dm9601: fix uninitialized variable use in
 dm9601_mdio_read
Message-ID: <2023101036-fleshy-dude-aec0@gregkh>
References: <20231009-topic-dm9601_uninit_mdio_read-v2-1-f2fe39739b6c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009-topic-dm9601_uninit_mdio_read-v2-1-f2fe39739b6c@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 12:26:14AM +0200, Javier Carrasco wrote:
> syzbot has found an uninit-value bug triggered by the dm9601 driver [1].
> 
> This error happens because the variable res is not updated if the call
> to dm_read_shared_word returns an error. In this particular case -EPROTO
> was returned and res stayed uninitialized.
> 
> This can be avoided by checking the return value of dm_read_shared_word
> and propagating the error if the read operation failed.
> 
> [1] https://syzkaller.appspot.com/bug?extid=1f53a30781af65d2c955
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> Reported-and-tested-by: syzbot+1f53a30781af65d2c955@syzkaller.appspotmail.com
> ---
> Changes in v2:
> - Remove unnecessary 'err == 0' case
> - Link to v1: https://lore.kernel.org/r/20231009-topic-dm9601_uninit_mdio_read-v1-1-d4d775e24e3b@gmail.com
> ---
>  drivers/net/usb/dm9601.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

What commit id does this fix?

thanks,

greg k-h
