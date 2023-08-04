Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 147C576FBB3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 10:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234420AbjHDIK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 04:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234044AbjHDIKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 04:10:24 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719C0468A
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 01:10:23 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-686d8c8fc65so1377116b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 01:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691136623; x=1691741423;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FPclhZ1vg5BDdpiOr1u3K1Ic3Xgw+vDCd6qqGZUuLuY=;
        b=Xg1YSkUWTEELpuPN48acofrZk3+QrBO6d0XcLgYJA/tkuU/LF+8yZ1sqBBB3tLKMxL
         OMDCpGK/CzI/Xrz/h7eFc5BxRXxREm8GZvJ/CimkLqKEMExr/0uoK+TOV94iUHezdWr+
         elU3NLstZDNTu3TO9p3r34hqo8Px+VBt0SJCU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691136623; x=1691741423;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FPclhZ1vg5BDdpiOr1u3K1Ic3Xgw+vDCd6qqGZUuLuY=;
        b=HWICoN523buvOA42iavyNFHG6a260a6R7krwUiGE4C2WVq+iyNQWf1RELLgO8cTmxi
         284rNu+1qN2tME7uu6x0QSprJxcut38cabWgwLK41gB8K8oxPdhkpRt8VmWePiiSyH9Z
         dodF3S/EFJAFs0rP8UYx/djMPupbPSbds/Je5i25NMIDQW3JBbbmZwbtEzC/hGDrCGOj
         E9T9kuFz0C4dD4YF6K1XQByCg+RUWDLWSE7b8gQwy2ozeRJjfXBZyaWWaYjaRpWYPDOc
         vX/72gXmOSAJBUNRD7NL+sJOaGBe9GsP1cgnIraQ9ZY76LHVYyQQRD0Vv6xG24jkNF3M
         hN0g==
X-Gm-Message-State: AOJu0YzYFNLaguFAou2z9dtMgnPnM3x91D8Y/GLRzlqMdebNAKseVwtQ
        u8Pd7aX9AS6R0znRflIyI43mew==
X-Google-Smtp-Source: AGHT+IFTdKyk64Z+Qw1u/ZR/fMoekXZZGwOXD7Xzt9eNMul5kG2LNkUw/0hRs7IBbPRxJEUNSPTXxA==
X-Received: by 2002:a05:6a20:158e:b0:127:796d:b70d with SMTP id h14-20020a056a20158e00b00127796db70dmr1002485pzj.61.1691136622890;
        Fri, 04 Aug 2023 01:10:22 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id t17-20020aa79391000000b006827d86ca0csm1046038pfe.55.2023.08.04.01.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 01:10:22 -0700 (PDT)
Date:   Fri, 4 Aug 2023 01:10:21 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Yunlong Xing <yunlong.xing@unisoc.com>
Cc:     tony.luck@intel.com, gpiccoli@igalia.com, joel@joelfernandes.org,
        enlin.mu@unisoc.com, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org, enlinmu@gmail.com,
        yunlong.xing23@gmail.com
Subject: Re: [PATCH 1/1] pstore/ram: Check member of buffers during the
 initialization phase of the pstore
Message-ID: <202308040103.1514A8C3CB@keescook>
References: <20230801060432.1307717-1-yunlong.xing@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801060432.1307717-1-yunlong.xing@unisoc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2023 at 02:04:32PM +0800, Yunlong Xing wrote:
> From: Enlin Mu <enlin.mu@unisoc.com>
> 
> The commit 30696378f68a("pstore/ram: Do not treat empty buffers as valid")
> would introduce the following issue:
> 
> When finding the buffer_size is zero, it would return directly.However, at
> the same time, if the buffer's start is a illegal value, the others would
> panic if access the buffer.

Which "others" do you mean?

> To avoid these happenning, check if the members are legal during the
> initialization phase of the pstore.
> 
> Fixes: 30696378f68a ("pstore/ram: Do not treat empty buffers as valid")
> Cc: stable@vger.kernel.org
> Signed-off-by: Enlin Mu <enlin.mu@unisoc.com>
> ---
>  fs/pstore/ram_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/pstore/ram_core.c b/fs/pstore/ram_core.c
> index 85aaf0fc6d7d..eb6df190d752 100644
> --- a/fs/pstore/ram_core.c
> +++ b/fs/pstore/ram_core.c
> @@ -519,7 +519,7 @@ static int persistent_ram_post_init(struct persistent_ram_zone *prz, u32 sig,
>  	sig ^= PERSISTENT_RAM_SIG;
>  
>  	if (prz->buffer->sig == sig) {
> -		if (buffer_size(prz) == 0) {
> +		if (buffer_size(prz) == 0 && buffer_start(prz) == 0) {
>  			pr_debug("found existing empty buffer\n");
>  			return 0;
>  		}

And in the case of "buffer_size(prz) == 0" but "buffer_start(prz) != 0",
this will be caught by:

                if (buffer_size(prz) > prz->buffer_size ||
                    buffer_start(prz) > buffer_size(prz)) {
                        pr_info("found existing invalid buffer, size %zu, start %zu\n",
                                buffer_size(prz), buffer_start(prz));
                        zap = true;
                }

i.e. it will be detected and zapped back to a sane state.

That sounds correct to me, though I wonder if reporting it as an
"invalid buffer" is inaccurate? Perhaps we should have a separate case:

		if (buffer_size(prz) == 0) {
			if (buffer_start(prz) == 0)
				pr_debug("found existing empty buffer\n");
			else {
				pr_debug("found existing empty buffer with non-zero start\n");
				zap = true;
			}
		} else if ...

What do you think?

-- 
Kees Cook
