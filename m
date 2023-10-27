Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 695B37D95A4
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 12:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345610AbjJ0KyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 06:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345602AbjJ0KyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 06:54:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F40B129
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 03:54:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D37DC433C9;
        Fri, 27 Oct 2023 10:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698404044;
        bh=lUoVkVRWYboaXOG1iSFoxBHubtU45Ewvbk18Js/2Bg8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xoX6gomj/9mhYXVTBg0WYsqQKuKyr/cCGDcj3ekj/ALzPQpaoQSEEMNE2DSrDnmOl
         N79GV9602oBVR0q38BAO2GuXqARKoN3uG2rNmUN02EFlo0E+NAeq/qTdPqZ1QzMoSo
         NwUqvLDPbhrGUxhpJ4nWsWrPTrDmSgJ4n3PaeXUQ=
Date:   Fri, 27 Oct 2023 12:54:02 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Xingxing Luo <xingxing.luo@unisoc.com>
Cc:     b-liu@ti.com, keescook@chromium.org, nathan@kernel.org,
        ndesaulniers@google.com, trix@redhat.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, llvm@lists.linux.dev,
        xingxing0070.luo@gmail.com, Zhiyong.Liu@unisoc.com,
        Cixi.Geng1@unisoc.com, Orson.Zhai@unisoc.com, zhang.lyra@gmail.com
Subject: Re: [PATCH] usb: musb: Check requset->buf before use to avoid crash
 issue
Message-ID: <2023102742-barmaid-doorframe-3731@gregkh>
References: <20231023093153.6748-1-xingxing.luo@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023093153.6748-1-xingxing.luo@unisoc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 05:31:53PM +0800, Xingxing Luo wrote:
> When connecting USB to PC, there is a very low probability of kernel
> crash. The reason is that in ep0_txstate(), the buf member of struct
> usb_request used may be a null pointer. Therefore, it needs to
> determine whether it is null before using it.
> 
> [ 4888.071462][T597@C0] Call trace:
> [ 4888.071467][T597@C0]  musb_default_write_fifo+0xa0/0x1ac [musb_hdrc]
> [ 4888.087190][T597@C0]  musb_write_fifo+0x3c/0x90 [musb_hdrc]
> [ 4888.099826][T597@C0]  ep0_txstate+0x78/0x218 [musb_hdrc]
> [ 4888.153918][T597@C0]  musb_g_ep0_irq+0x3c4/0xe10 [musb_hdrc]
> [ 4888.159663][T597@C0]  musb_interrupt+0xab4/0xf1c [musb_hdrc]
> [ 4888.165391][T597@C0]  sprd_musb_interrupt+0x1e4/0x484 [musb_sprd]
> [ 4888.171447][T597@C0]  __handle_irq_event_percpu+0xd8/0x2f8
> [ 4888.176901][T597@C0]  handle_irq_event+0x70/0xe4
> [ 4888.181487][T597@C0]  handle_fasteoi_irq+0x15c/0x230
> [ 4888.186420][T597@C0]  handle_domain_irq+0x88/0xfc
> [ 4888.191090][T597@C0]  gic_handle_irq+0x60/0x138
> [ 4888.195591][T597@C0]  call_on_irq_stack+0x40/0x70
> [ 4888.200263][T597@C0]  do_interrupt_handler+0x50/0xac
> [ 4888.205196][T597@C0]  el1_interrupt+0x34/0x64
> [ 4888.209524][T597@C0]  el1h_64_irq_handler+0x1c/0x2c
> [ 4888.214370][T597@C0]  el1h_64_irq+0x7c/0x80
> [ 4888.218525][T597@C0]  __check_heap_object+0x1ac/0x1fc
> [ 4888.223544][T597@C0]  __check_object_size+0x10c/0x20c
> [ 4888.228563][T597@C0]  simple_copy_to_iter+0x40/0x74
> [ 4888.233410][T597@C0]  __skb_datagram_iter+0xa0/0x310
> [ 4888.238343][T597@C0]  skb_copy_datagram_iter+0x44/0x110
> [ 4888.243535][T597@C0]  netlink_recvmsg+0xdc/0x364
> [ 4888.248123][T597@C0]  ____sys_recvmsg.llvm.16749613423860851707+0x358/0x6c0
> [ 4888.255045][T597@C0]  ___sys_recvmsg+0xe0/0x1dc
> [ 4888.259544][T597@C0]  __arm64_sys_recvmsg+0xc4/0x10c
> [ 4888.264478][T597@C0]  invoke_syscall+0x6c/0x15c
> [ 4888.268976][T597@C0]  el0_svc_common.llvm.12373701176611417606+0xd4/0x120
> [ 4888.275726][T597@C0]  do_el0_svc+0x34/0xac
> [ 4888.279795][T597@C0]  el0_svc+0x28/0x90
> [ 4888.283603][T597@C0]  el0t_64_sync_handler+0x88/0xec
> [ 4888.288548][T597@C0]  el0t_64_sync+0x1b4/0x1b8
> [ 4888.292956][T597@C0] Code: 540002c3 53027ea8 aa1303e9 71000508 (b840452a)
> [ 4888.299789][T597@C0] ---[ end trace 14a301b7253e83cc ]---
> 
> Signed-off-by: Xingxing Luo <xingxing.luo@unisoc.com>
> ---
>  drivers/usb/musb/musb_gadget_ep0.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/usb/musb/musb_gadget_ep0.c b/drivers/usb/musb/musb_gadget_ep0.c
> index 6d7336727388..5d0629866128 100644
> --- a/drivers/usb/musb/musb_gadget_ep0.c
> +++ b/drivers/usb/musb/musb_gadget_ep0.c
> @@ -531,6 +531,11 @@ static void ep0_txstate(struct musb *musb)
>  
>  	request = &req->request;
>  
> +	if (!requset->buf) {
> +		musb_dbg(musb, "request->buf is NULL");
> +		return;
> +	}
> +
>  	/* load the data */
>  	fifo_src = (u8 *) request->buf + request->actual;
>  	fifo_count = min((unsigned) MUSB_EP0_FIFOSIZE,
> -- 
> 2.17.1

This patch does not even build, how did you test it?

And what commit id does this fix?

thanks,

greg k-h
