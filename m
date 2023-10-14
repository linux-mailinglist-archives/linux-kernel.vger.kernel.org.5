Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9357C9334
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 09:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232842AbjJNH2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 03:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJNH23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 03:28:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1728C0
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 00:28:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36973C433C7;
        Sat, 14 Oct 2023 07:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697268508;
        bh=G5pBXaikKy5eZl79Bhi0g0REKTXJ2KpCpRRBmh/PXQU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oMEATjnk4N9ELAngiomINc1CaPU1jqZ830cOQrefLc/MRELm28PC7n1A3890dssT+
         p7AhUNEb+Z2jYl61CMyaW1PYZivJnJxBmwKO+EZHLWtdZwUFhWUNMqMPUmkLZG/GPF
         pS2kNPnjFI4juE/C9JJpm8IW9zHmqPASLKGEwT0IDX3DitX0jxsraGXZjyV4GV6nAF
         gHuGdbwWdN6vjvdlxh2t2GxxUMfP9HS7YpQ3A5Kut20tNk7iptIcAGs772IvcLfX36
         6Z0zAn8HoCBZbkILL3EqiNIrMOvHk+s9fTmWxk1V/5dBBqeT+OxsijqEYGGdjAP7oI
         56nHXhiI3hgOg==
Date:   Sat, 14 Oct 2023 09:28:24 +0200
From:   Simon Horman <horms@kernel.org>
To:     Edward AD <twuufnxlz@gmail.com>
Cc:     bpf@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com,
        syzbot+225bfad78b079744fd5e@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] media: imon: fix stall in worker_thread
Message-ID: <20231014072824.GU29570@kernel.org>
References: <20231013105909.GC29570@kernel.org>
 <20231014035114.1057686-2-twuufnxlz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231014035114.1057686-2-twuufnxlz@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 14, 2023 at 11:51:15AM +0800, Edward AD wrote:
> On Fri, 13 Oct 2023 12:59:09 +0200 Simon Horman wrote:
> > The code is already switching based on urb->status,
> > so unless the warning message is really desired,
> > perhaps this is more appropriate?
> > 
> > diff --git a/drivers/media/rc/imon.c b/drivers/media/rc/imon.c
> > index 74546f7e3469..0e2f06f2f456 100644
> > --- a/drivers/media/rc/imon.c
> > +++ b/drivers/media/rc/imon.c
> > @@ -1799,6 +1799,7 @@ static void usb_rx_callback_intf1(struct urb *urb)
> > 
> >  	switch (urb->status) {
> >  	case -ENOENT:		/* usbcore unlink successful! */
> > +	case -EPROTO:		/* XXX: something goes here */
> >  		return;
> > 
> >  	case -ESHUTDOWN:	/* transport endpoint was shut down */
> 
> Hi Simon Horman, 
> 
> Who added the above code where?

Maybe I misunderstand your question but
I am suggesting the above change as an alternative approach.
