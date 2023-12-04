Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D095D803E31
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 20:15:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232992AbjLDTP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 14:15:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbjLDTPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 14:15:25 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79BE0F0
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 11:15:31 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1d08a924fcfso15053355ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 11:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1701717331; x=1702322131; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gLNCTARupzyNgRT6x18YzDTNwf+kcKqpIPYo+HCBokw=;
        b=Ff0SszFkRDHFuTfqGrKUu8hQOK7Psn8nGd2wZVcpKcdDbaNH6gMsMxR40SSVoFumnO
         jOM83kFfOTqUCajK3wdVPs7nXTtzJqWxQdq3VgC4PWSNsA6ozw8IDVtxSQ5MDwP3otWA
         pnqkaV9PPTm4V2fFnAI5rTfAaqDdLVQWndcipU4HTD0vPbeidHe5Pnzez1ZtN2RuQFuf
         tTMRZOPoWkN9C6vnCMIZxJF9/m9ZGBfxUe87+x1uy5v9M8VAzllo81tracMPmCrkDWx+
         5MFj4cuDEseksoZy2DSvEQIv0iZhPO+Tm3qvKoNqud/wuQMjL+7gCh4oxpT0vT3513OI
         aJqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701717331; x=1702322131;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gLNCTARupzyNgRT6x18YzDTNwf+kcKqpIPYo+HCBokw=;
        b=xCbgCE2T9yJsBS8UXius5xC4iWgYJPP82e6kdoq7ju/MFXn6K9oTmY1UxCuOk05oCt
         avkugjlXCLubFOaPAoVKhj+Xu7jJCTTvhqJRF0PmFqq3+Kal8Z0zQaC1Sck0zHdcPZ6V
         4/WEYblx0fctZZtn7+Ve4Yq4cpucXeVd0O0O6NE1QSbayZq++TlR6FNacc00jHialFb4
         g2meqeK+hOAGsvoUyskqInue5S+0n2EA7qcAIvtQDvU6iZPjoB6rqExiBZMLdHJo6ZJv
         o4VcMJslzlyOJbKtbbTBv9XncXA3WKU49zJOv+TX4cXe5QCeYxkRsoJQiD31y8KP9Q1+
         bv6Q==
X-Gm-Message-State: AOJu0YzD8OAX+YjAr4yxBykIs0HdJmmiG4PpGP9UxK8a80ZIhQosR3Z9
        NzKlBHZDfh7VehcQ+avUbsXwfw==
X-Google-Smtp-Source: AGHT+IF1+hncDnlwONOq3K7JGHXoxT4PeNTA0x9QpCTjznLkr3m+MBONU0GdZwrvEODd/Q7iRl/euA==
X-Received: by 2002:a17:902:e74f:b0:1d0:b503:2edb with SMTP id p15-20020a170902e74f00b001d0b5032edbmr1448349plf.69.1701717330853;
        Mon, 04 Dec 2023 11:15:30 -0800 (PST)
Received: from ghost ([12.44.203.122])
        by smtp.gmail.com with ESMTPSA id t11-20020a170902e84b00b001d076c2e346sm4731423plg.51.2023.12.04.11.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 11:15:30 -0800 (PST)
Date:   Mon, 4 Dec 2023 11:15:28 -0800
From:   Charlie Jenkins <charlie@rivosinc.com>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] riscv: introduce RISCV_EFFICIENT_UNALIGNED_ACCESS
Message-ID: <ZW4lUDpl0eZVNjrp@ghost>
References: <20231203135753.1575-1-jszhang@kernel.org>
 <20231203135753.1575-2-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231203135753.1575-2-jszhang@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 03, 2023 at 09:57:52PM +0800, Jisheng Zhang wrote:
> Some riscv implementations such as T-HEAD's C906, C908, C910 and C920
> support efficient unaligned access, for performance reason we want
> to enable HAVE_EFFICIENT_UNALIGNED_ACCESS on these platforms. To
> avoid performance regressions on other non efficient unaligned access
> platforms, HAVE_EFFICIENT_UNALIGNED_ACCESS can't be globally selected.
> 
> To solve this problem, runtime code patching based on the detected
> speed is a good solution. But that's not easy, it involves lots of
> work to modify vairous subsystems such as net, mm, lib and so on.
> This can be done step by step.
> 
> So let's take an easier solution: add support to efficient unaligned
> access and hide the support under NONPORTABLE.
> 
> Now let's introduce RISCV_EFFICIENT_UNALIGNED_ACCESS which depends on
> NONPORTABLE, if users know during config time that the kernel will be
> only run on those efficient unaligned access hw platforms, they can
> enable it. Obviously, generic unified kernel Image shouldn't enable it.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/riscv/Kconfig | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 7f8aa25457ba..0a76209e9b02 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -654,6 +654,18 @@ config RISCV_MISALIGNED
>  	  load/store for both kernel and userspace. When disable, misaligned
>  	  accesses will generate SIGBUS in userspace and panic in kernel.
>  
> +config RISCV_EFFICIENT_UNALIGNED_ACCESS

There already exists hwprobe for this purpose. If kernel code wants to
leverage the efficient unaligned accesses of hardware, it can use static
keys. I have a patch that will set this static key if the hardware was
detected to have fast unaligned accesses:

https://lore.kernel.org/linux-riscv/20231117-optimize_checksum-v11-2-7d9d954fe361@rivosinc.com/

- Charlie

> +	bool "Use unaligned access for some functions"
> +	depends on NONPORTABLE
> +	select HAVE_EFFICIENT_UNALIGNED_ACCESS
> +	default n
> +	help
> +	  Say Y here if you want the kernel only run on hardware platforms which
> +	  support efficient unaligned access, then unaligned access will be used
> +	  in some functions for optimized performance.
> +
> +	  If unsure what to do here, say N.
> +
>  endmenu # "Platform type"
>  
>  menu "Kernel features"
> -- 
> 2.42.0
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
