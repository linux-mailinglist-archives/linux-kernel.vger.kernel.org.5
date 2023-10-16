Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 344077C9D3E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 03:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbjJPBzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 21:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbjJPBzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 21:55:11 -0400
X-Greylist: delayed 310 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 15 Oct 2023 18:55:08 PDT
Received: from cnc.isely.net (cnc.isely.net [192.69.181.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B124AA9;
        Sun, 15 Oct 2023 18:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=isely.net; s=deb;
        t=1697420997; bh=kS0RTd3CYTDBCJcqdUFcBC+zypJLcH4lZRAhcLFcZb8=;
        h=Date:From:To:cc:Subject:In-Reply-To:References;
        b=BU2P7bfwss2/P+6aqWSIk9NJvJoB13SWtKIlBfGLT7svcwvSlZDnlIJUXIhcYjjUb
         b2yTdAX8rOy6iZa101JPW+Bc+nwQbYEQKFp3f9+9B49/hOZ2SbHpO7cpq1+gWKSUJb
         Rk7iL1Zq3+Cn2TaFXegiEyyVUkaKHoyDguYGqL/XaVeVnjnJupWJ7O9/dgH6O
Original-Subject: Re: [PATCH] media: pvrusb2: fix use after free on context
 disconnection
Author: Mike Isely <isely@isely.net>
Original-cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
  linux-media@vger.kernel.org,
  Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
  syzbot+621409285c4156a009b3@syzkaller.appspotmail.com,
  linux-kernel-mentees@lists.linuxfoundation.org
Received: from sheridan.isely.net (sheridan.isely.net [::ffff:192.168.24.5])
  (AUTH: PLAIN isely, TLS: TLS1.3,256bits,ECDHE_RSA_AES_256_GCM_SHA384)
  by cnc.isely.net with ESMTPSA
  id 0000000000080091.00000000652C96C5.00000BA0; Sun, 15 Oct 2023 20:49:57 -0500
Date:   Sun, 15 Oct 2023 20:49:57 -0500 (CDT)
From:   Mike Isely <isely@isely.net>
To:     "Ricardo B. Marliere" <ricardo@marliere.net>
cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzbot+621409285c4156a009b3@syzkaller.appspotmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] media: pvrusb2: fix use after free on context
 disconnection
In-Reply-To: <20231012230911.48113-2-ricardo@marliere.net>
Message-ID: <5f652494-1e4f-4965-f9b7-0f2bf05f718f@isely.net>
References: <20231012230911.48113-2-ricardo@marliere.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Acked-by: Mike Isely <isely@pobox.com>

  -Mike

On Thu, 12 Oct 2023, Ricardo B. Marliere wrote:

> Upon module load, a kthread is created targeting the
> pvr2_context_thread_func function, which may call pvr2_context_destroy
> and thus call kfree() on the context object. However, that might happen
> before the usb hub_event handler is able to notify the driver. This
> patch adds a sanity check before the invalid read reported by syzbot,
> within the context disconnection call stack.
> 
> Fixes: e5be15c63804 ("V4L/DVB (7711): pvrusb2: Fix race on module unload")
> Reported-and-tested-by: syzbot+621409285c4156a009b3@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/000000000000a02a4205fff8eb92@google.com/
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> ---
>  drivers/media/usb/pvrusb2/pvrusb2-context.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/usb/pvrusb2/pvrusb2-context.c b/drivers/media/usb/pvrusb2/pvrusb2-context.c
> index 14170a5d72b3..1764674de98b 100644
> --- a/drivers/media/usb/pvrusb2/pvrusb2-context.c
> +++ b/drivers/media/usb/pvrusb2/pvrusb2-context.c
> @@ -268,7 +268,8 @@ void pvr2_context_disconnect(struct pvr2_context *mp)
>  {
>  	pvr2_hdw_disconnect(mp->hdw);
>  	mp->disconnect_flag = !0;
> -	pvr2_context_notify(mp);
> +	if (!pvr2_context_shutok())
> +		pvr2_context_notify(mp);
>  }
>  
>  
> 
