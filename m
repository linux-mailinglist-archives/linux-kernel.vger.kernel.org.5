Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8BC7B825C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 16:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242863AbjJDOay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 10:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242817AbjJDOax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 10:30:53 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C1DAB;
        Wed,  4 Oct 2023 07:30:49 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id af79cd13be357-7740c8509c8so145239985a.3;
        Wed, 04 Oct 2023 07:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696429848; x=1697034648; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=USpvcRz4CuNcVJmMxyqLmWIPNbgGu4nTDs11HK2klfU=;
        b=SEf/VLBqQnI4WAdtIB4uIhO2hu9mbQLWzky8EsSYZWgccarTABDMukKPHqEMvYIF5s
         tXJRCYEPdlvKcUv/EmzgCCd0hWbrZkrVZKQM0MSKzyd6yYiLL05kTGE3kacfkpGQH81C
         FpGwpAsh3yCbjBZhzSDhM90JTzzUBzUd3AnmtB6TsaStnI2o8QwxkeAkS5wAzp+y98ZX
         nOjkLjIM0189+YSCuDBFnXDR9fkznsZajH3hUluG0UjlelpiNRZnBwzsy3oHcKfpAwB/
         7ED5SjMpHGJhLiGa5bNzG/lksXzMNTjmVF8urmNU0bD+lqkpZzsVe2LvCFvGGY05eN9N
         DTwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696429848; x=1697034648;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=USpvcRz4CuNcVJmMxyqLmWIPNbgGu4nTDs11HK2klfU=;
        b=Lm6KWG7Yoinazt47jNVV1LLBm2i5d57/T1eTc0ZhnafcFDzdLiL//WjejtWeVwjFbD
         GoiELmCAO7jXXI2wZgoYZcgqPUZNlbm/5NisXjQ4dn+PUB5mpwPyyip//tW4/nlk/8WP
         pXfxT/gVn9dDnCkDhJl5h547cncXHOrLtV2iy+reHpd8YrFCi/tQdXZh+bminAS9rMo3
         EVUlHGPb0uLfGhsA6ZQM3DKKUsiHr0SvQgSa/mft9X2K08GgivgCnt9CzaL97uVcdX/0
         3UPkDr84QFbkrTESuyyxrrXaE8Xz/BYehgKd2bZW0cYSU1ILPB+amBa5CcK7Vs88Cz/V
         5+Zg==
X-Gm-Message-State: AOJu0YwBTrRkNrEhiL0mGHoeluzQIfQ3DKuxJ5jIaEuI64TyRKm/0xIH
        CLAufhwBhXmZ25kK5vmTnDI=
X-Google-Smtp-Source: AGHT+IG+XTAVPhruWrJjp9S2MwhU9i5fx+CZeW/QgGdPus3+L6MpEOclSxuLLlQBzjIQYaUWd44Yjw==
X-Received: by 2002:a05:620a:4512:b0:774:9dc7:ce3d with SMTP id t18-20020a05620a451200b007749dc7ce3dmr3215444qkp.12.1696429848376;
        Wed, 04 Oct 2023 07:30:48 -0700 (PDT)
Received: from penguin ([205.220.129.20])
        by smtp.gmail.com with ESMTPSA id m21-20020ae9e715000000b00767da9b6ae9sm1298527qka.11.2023.10.04.07.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 07:30:47 -0700 (PDT)
Date:   Wed, 4 Oct 2023 07:30:21 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+0434ac83f907a1dbdd1e@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] Input: powermate - fix use-after-free in
 powermate_config_complete
Message-ID: <ZR12/VYt0rNL1Lzd@penguin>
References: <20230916-topic-powermate_use_after_free-v2-1-505f49019f2f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230916-topic-powermate_use_after_free-v2-1-505f49019f2f@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Javier,

On Sun, Oct 01, 2023 at 05:35:54PM +0200, Javier Carrasco wrote:
> syzbot has found a use-after-free bug [1] in the powermate driver. This
> happens when the device is disconnected, which leads to a memory free
> from the powermate_device struct.
> When an asynchronous control message completes after the kfree and its
> callback is invoked, the lock does not exist anymore and hence the bug.
> 
> Use usb_kill_urb() on pm->config to cancel any in-progress requests upon
> device disconnection. Given that this action is already done on pm->irq,
> reorder the code to have both calls after the call to
> input_unregister_device(), which is the most common approach.
> 
> [1] https://syzkaller.appspot.com/bug?extid=0434ac83f907a1dbdd1e
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> Reported-by: syzbot+0434ac83f907a1dbdd1e@syzkaller.appspotmail.com
> ---
> Changes in v2:
> - Use usb_kill_urb() on pm->config upon device disconnection.
> - Link to v1: https://lore.kernel.org/r/20230916-topic-powermate_use_after_free-v1-1-2ffa46652869@gmail.com
> ---
>  drivers/input/misc/powermate.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/misc/powermate.c b/drivers/input/misc/powermate.c
> index c1c733a9cb89..c0aea75eb087 100644
> --- a/drivers/input/misc/powermate.c
> +++ b/drivers/input/misc/powermate.c
> @@ -423,8 +423,9 @@ static void powermate_disconnect(struct usb_interface *intf)
>  	usb_set_intfdata(intf, NULL);
>  	if (pm) {
>  		pm->requires_update = 0;
> -		usb_kill_urb(pm->irq);

No, you do not want interrupts coming in while input device is being
destroyed, this one needs to stay where it is.

>  		input_unregister_device(pm->input);
> +		usb_kill_urb(pm->irq);
> +		usb_kill_urb(pm->config);
>  		usb_free_urb(pm->irq);
>  		usb_free_urb(pm->config);
>  		powermate_free_buffers(interface_to_usbdev(intf), pm);

Thanks.

-- 
Dmitry
