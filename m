Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45BBA7D7BD1
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 06:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbjJZEpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 00:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjJZEpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 00:45:03 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D6861A1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 21:44:42 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-32dbbf3c782so945455f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 21:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698295480; x=1698900280; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WmgUqShVRpp/vxWnT3LQDEFmhiSdp+ySB57jdJRdwMo=;
        b=EzVsBXtFyN1XkSFV0MrDDEM7cWiw0VHvKgoRj9K4YRjaAG3NQuKHuoi/9tg/gtW1I9
         mBPwVz23ixCsbH86XQUzPWAr45qS7dqI6daHRSLoEfoHX4qnr7q7O/KHRJgzd/SCSI20
         jS2hhHgZ4i5NiTLLxwnyUiCUbEGluKxs9R4O03zpMMjNaRtwdwRVGLd3qs2bKKJbrdSG
         rcWA4a/VKCtZYdSx9qLRD3l10oU5/13GLzJNPSfcrcEUwX0ZaGuxS0sFW7caegYkpNny
         xCCn6lUhaOABbPfV4YGzKoviR8dGyVtfvUijmdEjXkk/sLsJ6w9Jh/V0mMvCGIAqw/t5
         LkMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698295480; x=1698900280;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WmgUqShVRpp/vxWnT3LQDEFmhiSdp+ySB57jdJRdwMo=;
        b=jV2q5f27Jtogs4Nm7U+tDSSoHr8yp9rXLtiYU5YqY0hIvXCfmYlXE56AeyNLpSNaW5
         ZpdR61+sQt0QeFzQHK7v2neNqqOw7ocHhzhhhyn7kiek6NHQDdFFu20/NeUT7tjpLP1g
         AzuMXlPWJnAyhIo3+pA6zm5x7u4ESjbgxooAQHZxmjmWUYA7/FajLPsVG0DEgo636uPH
         YjAKZoBa993nwYfhRK6s9FN2E5TLOFUyQZw8tAP3eYPX/aSN8X+wn/0HS9FKhHzQef1N
         DGl21Y1Ax2RGWCOJNu+qoR+VJKKGobKcv/UmQIICqXTIRZFnyHRsYGtlFBzV268z6jgO
         HaYA==
X-Gm-Message-State: AOJu0YwAIHgEqlTzuy9ndqmYD4wL4xqtV+Jfd6SrOvaeROoRnC1PTtye
        6PLooTFJcSebhhn5m4ZQP4yaWQ==
X-Google-Smtp-Source: AGHT+IFM0o0/kjpc5CCxbqLAeNT0gKpGFUpYRc2EnPItqfKIOyQ2Q/I0iu16fvKe4xui0rK8KHcMQA==
X-Received: by 2002:adf:d1ca:0:b0:32d:8c67:be05 with SMTP id b10-20020adfd1ca000000b0032d8c67be05mr1572772wrd.22.1698295480221;
        Wed, 25 Oct 2023 21:44:40 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id o12-20020adfe80c000000b0032da49e18fasm13438465wrm.23.2023.10.25.21.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 21:44:39 -0700 (PDT)
Date:   Thu, 26 Oct 2023 07:44:35 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Su Hui <suhui@nfschina.com>
Cc:     lukas@wunner.de, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
        daniel@ffwll.ch, tiwai@suse.de, Jim.Qu@amd.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] vga_switcheroo: Fix impossible judgment condition
Message-ID: <4ec2b80b-f042-4abf-b799-0a9ef364f0fa@kadam.mountain>
References: <20231026021056.850680-1-suhui@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026021056.850680-1-suhui@nfschina.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 10:10:57AM +0800, Su Hui wrote:
> 'id' is enum type like unsigned int, so it will never be less than zero.
> 
> Fixes: 4aaf448fa975 ("vga_switcheroo: set audio client id according to bound GPU id")
> Signed-off-by: Su Hui <suhui@nfschina.com>
> ---
>  drivers/gpu/vga/vga_switcheroo.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/vga/vga_switcheroo.c b/drivers/gpu/vga/vga_switcheroo.c
> index 365e6ddbe90f..d3064466fd3a 100644
> --- a/drivers/gpu/vga/vga_switcheroo.c
> +++ b/drivers/gpu/vga/vga_switcheroo.c
> @@ -375,7 +375,7 @@ int vga_switcheroo_register_audio_client(struct pci_dev *pdev,
>  	mutex_lock(&vgasr_mutex);
>  	if (vgasr_priv.active) {
>  		id = vgasr_priv.handler->get_client_id(vga_dev);
> -		if (id < 0) {
> +		if ((int)id < 0) {

Hi,

I feel like you're using Smatch?  Which is great!  Fantastic!

Have you built the cross function database?  If you have there is a
command that's useful.

$ ~/smatch/smatch_db/smdb.py functions vga_switcheroo_handler get_client_id | tee where
drivers/gpu/drm/nouveau/nouveau_acpi.c | (struct vga_switcheroo_handler)->get_client_id | nouveau_dsm_get_client_id | 1
drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c | (struct vga_switcheroo_handler)->get_client_id | amdgpu_atpx_get_client_id | 1
drivers/gpu/drm/radeon/radeon_atpx_handler.c | (struct vga_switcheroo_handler)->get_client_id | radeon_atpx_get_client_id | 1
drivers/platform/x86/apple-gmux.c | (struct vga_switcheroo_handler)->get_client_id | gmux_get_client_id | 1
$ make cscope
$ vim where
Use cscope to jump to each of those four functions.  Move the cursor to
the nouveau_dsm_get_client_id and hit CTRL-].

They never return negatives.  The enum vga_switcheroo_client_id has a
VGA_SWITCHEROO_UNKNOWN_ID define which I guess these functions are
supposed to return on error.  They never do return that, but I bet
that's what we are supposed to check for.  It honestly might be good
to check for both...

		if ((int)id < 0 || id == VGA_SWITCHEROO_UNKNOWN_ID) {
			mutex_unlock(&vgasr_mutex);
			return -EINVAL;
		}

regards,
dan carpenter

