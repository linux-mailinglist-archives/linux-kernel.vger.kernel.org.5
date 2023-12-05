Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12101805FDE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 21:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346366AbjLEU4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 15:56:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346365AbjLEU4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 15:56:19 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB1B181
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 12:56:25 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-285d1101868so4158245a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 12:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1701809784; x=1702414584; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E2KQkDlpQRo0MCp9j2V0+RBGz8TceljCRwngTg/XlnU=;
        b=2CqCGmXsP9gSbX/IHi6spws+MeDCJxIndw9mH8ay999Dq/fFQqXAsgfJifhRntGeG4
         rogprNoRTrq8z+xmJZlq4wfnA60pU28HQMkrQEiUYI/Y8F2sxAAM3dJ7q3I0cxG8bp8M
         ClBJ1LhU9Fkx7Kk6k+56jfNbr64QkOWGX3PzqLTVClsRgbuSiIhl9sVzofZIneaNCAco
         oLBIN+xn8jNQID2TzVGUycgrEy7ZIUyPde5Plq8uvmjlb38CDMcidusrpTew0yc9iDIw
         mZxMdJf3W8qksJUWLgkCTD5fS0Xq9vcprtV1esSfizGvUTTUB61ECa4vdz9EVt+zH3Ft
         P+HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701809784; x=1702414584;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E2KQkDlpQRo0MCp9j2V0+RBGz8TceljCRwngTg/XlnU=;
        b=qFBw/ojC0lLlUtQ2jI4haH51sgRdQoc+uauqe4pq43/rxodokeMO+JGmgvSScS/5et
         6cwTTwEk//NbzE2rP6bxetDqa98UdYd1ctxU2RfapGawXNRMhzDU4tMGDsSqqn2+wEcO
         vLV/k5U9mIJIq3xVJOvf/2qCaTV69JjYATNA1FMMK8fAqL+Xc4YdfaTeLgukBL0pcnbB
         VzYLG6HpELPr9sXvaSVTogJHDp249kYbQGylB7T/8nn1eGHbvHC64iNgsC+/fJjtrQ47
         lzcPIMapuPPUvqeTJvSPjRD4Md3dcFVPvG+Up36tBhVqFO1M4/ZPHyz1JGFiHClKobJr
         7QMQ==
X-Gm-Message-State: AOJu0YzytyQhSGK8g5ideoICNKE3/svFh80W/DJ8Lb4iS1vV0vzLGX2Y
        OBEvTBA0CBB+AMs5JeckJH82lw==
X-Google-Smtp-Source: AGHT+IHJ2QQq1W0s+4W68nHNT2RcgaE+sJSOd55rgtsizRLkIZMXF8n7EVlvS48Z3DgmlOCbtwrlqw==
X-Received: by 2002:a17:90b:1c88:b0:286:a708:cd25 with SMTP id oo8-20020a17090b1c8800b00286a708cd25mr1547414pjb.39.1701809784580;
        Tue, 05 Dec 2023 12:56:24 -0800 (PST)
Received: from ghost ([12.44.203.122])
        by smtp.gmail.com with ESMTPSA id o5-20020a17090ab88500b0026f4bb8b2casm6156227pjr.6.2023.12.05.12.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 12:56:24 -0800 (PST)
Date:   Tue, 5 Dec 2023 12:56:19 -0800
From:   Charlie Jenkins <charlie@rivosinc.com>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] riscv: introduce RISCV_EFFICIENT_UNALIGNED_ACCESS
Message-ID: <ZW+Oc8sJNcPLWk1Q@ghost>
References: <20231203135753.1575-1-jszhang@kernel.org>
 <20231203135753.1575-2-jszhang@kernel.org>
 <ZW4lUDpl0eZVNjrp@ghost>
 <20231205021406.GD1168@sol.localdomain>
 <ZW8rbgsTqmuLTvoK@xhacker>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZW8rbgsTqmuLTvoK@xhacker>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 09:53:50PM +0800, Jisheng Zhang wrote:
> On Mon, Dec 04, 2023 at 06:14:06PM -0800, Eric Biggers wrote:
> > On Mon, Dec 04, 2023 at 11:15:28AM -0800, Charlie Jenkins wrote:
> > > > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > > > index 7f8aa25457ba..0a76209e9b02 100644
> > > > --- a/arch/riscv/Kconfig
> > > > +++ b/arch/riscv/Kconfig
> > > > @@ -654,6 +654,18 @@ config RISCV_MISALIGNED
> > > >  	  load/store for both kernel and userspace. When disable, misaligned
> > > >  	  accesses will generate SIGBUS in userspace and panic in kernel.
> > > >  
> > > > +config RISCV_EFFICIENT_UNALIGNED_ACCESS
> > > 
> > > There already exists hwprobe for this purpose. If kernel code wants to
> > > leverage the efficient unaligned accesses of hardware, it can use static
> > > keys. I have a patch that will set this static key if the hardware was
> > > detected to have fast unaligned accesses:
> > > 
> > > https://lore.kernel.org/linux-riscv/20231117-optimize_checksum-v11-2-7d9d954fe361@rivosinc.com/
> > 
> > Is the plan to make the get_unaligned* and put_unaligned* macros expand to code
> > for both cases, and select between them using a static key?  Note that there are
> > a very large number of callers of these macros in the kernel.  And what about
> > kernel code that checks CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS directly?
> > 
> > AFAIK, no other Linux architecture supports kernel images where the unaligned
> > access support is unknown at compile time.  It's not clear to me that such an
> > approach is feasible.  A static key can easily be provided, but it's unclear
> > what code would use it, given that currently lots of kernel code assumes that
> > unaligned access support is known at compile time.
> > 
> > Meanwhile, there are people building kernels they know will only be deployed on
> > systems where unaligned accesses are supported.  To me, it seems useful to
> > provide a kconfig option for them to build a more efficient kernel.
> 
> Generally, I agree with Eric's above points. Various subsystem such as net, mm,
> lib and so on have different code path for CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS,
> while Charlie's patch only touch partial code of arch/riscv, and even if those
> subsystem maintainers agree with dynamic code patching(I still believe
> persuading those subsystem maintainers is not easy), that's still a
> huge task which needs to be done step by step. So before that, we'd
> better let this series merged and benefit all efficient unaligned access
> riscv systems. When the huge task is completed, we can remove the config
> option.
> 
> Thanks

It would be best to enable all of the paths that leverage
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS at runtime (using hwprobe)
instead of using a compile-time flag to do so. However, as you say, that
is large task and doesn't need to be done immediately. For now I agree
it is sufficient to use this new RISCV_EFFICIENT_UNALIGNED_ACCESS
config.

- Charlie

Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>

