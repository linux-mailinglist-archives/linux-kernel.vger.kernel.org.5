Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EEE47C5F08
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 23:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233549AbjJKVVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 17:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233133AbjJKVVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 17:21:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47502A9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 14:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697059250;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c2JKpLabPU19Z4PY1/R2zyWSv93z5Bntvht7KzYGyrY=;
        b=hpNCj/SOb4UMt2bbD2gYA5n95kVy5pbNk8gI7wB9pqhZ7FjOaV9vcuJjJGqibNPrVy61PV
        1yxk6ruIvYsixD7XbyVnPeAclfj5VLCIa04CHhx7QDcLdEq4jClZ3oMf/atETVAxz/BTdK
        PjVAyuTlYub/SScF8YeTarUnkcBwFk4=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-zLPaznz9PBqAyTtIvB-nww-1; Wed, 11 Oct 2023 17:20:49 -0400
X-MC-Unique: zLPaznz9PBqAyTtIvB-nww-1
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3ae65e9d394so335495b6e.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 14:20:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697059249; x=1697664049;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c2JKpLabPU19Z4PY1/R2zyWSv93z5Bntvht7KzYGyrY=;
        b=he1hY9TTCSaYNvxVFTVA9RxFeVN7VEuBcqStSng3Vlx38XQjpX+om5Bm1JmC6QOUIx
         fhUrBO1HYATkDgn6DqYxSDvSnHRUIRVgdZtUJIMFwl3cCMoBMJMFfTfXBbli2zbm+4b8
         oqGzPaI23FGA2p9hdze0bA/6KKJy1QBeTPTB7h7mT+JMp1QL/F5IMr9ERbvXPqgYL8Z4
         swad34bYXoNd1nW1uP0H+LqqufBdpSQhWKVZCmx0cSCyxbOxzAZMqRKN3RmONd1wOldf
         /2wh70LM4KgJn3Wv58OqPisRMDsyQm14zFJETv56w9Baq/CQnr9ww9cIJRqW8+kjeE/e
         oAXw==
X-Gm-Message-State: AOJu0Yw+70dNhA5Y1/RHGwzcmBLQaiId8d07JVqRql7IvYBVJtf6H4SK
        SzWD9/q2zGqYnPrIqSULX/7VKvGG5Cqd+IQO+R7+Uh8NxGDICPcfxbx+/h2CdzuAChKmMSMY2pV
        mipXNpXggvO6s+75rpiXmPpTV
X-Received: by 2002:a05:6808:1b14:b0:3a8:3d5b:aad6 with SMTP id bx20-20020a0568081b1400b003a83d5baad6mr28232889oib.55.1697059248993;
        Wed, 11 Oct 2023 14:20:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2flRVYhqCmKvMACeu6gSf5Yfu7K+cr6BQF49KWiE2ZPbvDYiSc1FkfiNPw1mUZvZs/4a71g==
X-Received: by 2002:a05:6808:1b14:b0:3a8:3d5b:aad6 with SMTP id bx20-20020a0568081b1400b003a83d5baad6mr28232878oib.55.1697059248764;
        Wed, 11 Oct 2023 14:20:48 -0700 (PDT)
Received: from fedora ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id o16-20020ac841d0000000b004195faf1e2csm5627854qtm.97.2023.10.11.14.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 14:20:48 -0700 (PDT)
Date:   Wed, 11 Oct 2023 16:20:45 -0500
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Alex Elder <elder@linaro.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@quicinc.com,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 15/15] arm64: defconfig: enable SHM Bridge support for
 the TZ memory allocator
Message-ID: <vovuloeqzoshlyybypzjyni4cfxtz46rp4pqh4duftai5jhgzr@ked3hl35kx2o>
References: <20231009153427.20951-1-brgl@bgdev.pl>
 <20231009153427.20951-16-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009153427.20951-16-brgl@bgdev.pl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 05:34:27PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Enable SHM Bridge support in the Qualcomm TrustZone allocator by default
> as even on architectures that don't support it, we automatically fall
> back to the default behavior.

Can you give some motivation for the Kconfig? It seems like what you've
wrote should just fallback to the non SHM bridge allocated memory, so I
don't see what having the option to exclude that at build time gives us.

> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 07011114eef8..ebe97fec6e33 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -255,6 +255,7 @@ CONFIG_INTEL_STRATIX10_RSU=m
>  CONFIG_EFI_CAPSULE_LOADER=y
>  CONFIG_IMX_SCU=y
>  CONFIG_IMX_SCU_PD=y
> +CONFIG_QCOM_TZMEM_MODE_SHMBRIDGE=y
>  CONFIG_GNSS=m
>  CONFIG_GNSS_MTK_SERIAL=m
>  CONFIG_MTD=y
> -- 
> 2.39.2
> 

