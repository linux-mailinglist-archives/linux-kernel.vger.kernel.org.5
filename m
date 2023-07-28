Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAFAF766F68
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 16:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237023AbjG1OYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 10:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237131AbjG1OWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 10:22:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB3F744B3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 07:22:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0145362160
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 14:22:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A798C433C7;
        Fri, 28 Jul 2023 14:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690554167;
        bh=Q4/k4P2dqUmrtwh4epIswDRV1O6WVzXd1ZzdcykMzQs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HXgwWVobIMhag8kRKa1fpslTUp8NIm0uFxXJVqWplVIfERV1wUu5snDIro91YqCPh
         pQaRHAc97m2qXmslbXzjvHe3CifDgMGf4QMgduyI5W4kYmqYmW6idB3/+wl8ZppDN5
         tLctMrSfoGi4SbksNsd2jLItjoZfsaDcFcOrGXS43pZ1k9hPdNX1vjasiuSkyLg7r9
         +e3mZC0pC2IGdboXVdXpdhWgBNDobBC+zmGDHRuaMBHbwTchhFifWEXBrU+YshcYXN
         t7tkNTUDBZjM743N3dIwFNR0EpQmkdc8JPB1y9SvBgWNADz8EiXE9uT5S90jC4oXOT
         /02TYAXwfAq/Q==
Date:   Fri, 28 Jul 2023 22:11:08 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Andrew Jones <ajones@ventanamicro.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] riscv: vdso.lds.S: merge .data section into .rodata
 section
Message-ID: <ZMPMfMPoG/KnuWLN@xhacker>
References: <20230726173024.3684-1-jszhang@kernel.org>
 <20230726173024.3684-3-jszhang@kernel.org>
 <20230728-cec389a85a7dc8dcca803e06@orel>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230728-cec389a85a7dc8dcca803e06@orel>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 02:57:03PM +0200, Andrew Jones wrote:
> On Thu, Jul 27, 2023 at 01:30:23AM +0800, Jisheng Zhang wrote:
> > The .data section doesn't need to be separate from .rodata section,
> > they are both readonly.
> > 
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > ---
> >  arch/riscv/kernel/vdso/vdso.lds.S | 15 +++++++--------
> >  1 file changed, 7 insertions(+), 8 deletions(-)
> > 
> > diff --git a/arch/riscv/kernel/vdso/vdso.lds.S b/arch/riscv/kernel/vdso/vdso.lds.S
> > index d43fd7c7dd11..671aa21769bc 100644
> > --- a/arch/riscv/kernel/vdso/vdso.lds.S
> > +++ b/arch/riscv/kernel/vdso/vdso.lds.S
> > @@ -29,7 +29,13 @@ SECTIONS
> >  	.eh_frame_hdr	: { *(.eh_frame_hdr) }		:text	:eh_frame_hdr
> >  	.eh_frame	: { KEEP (*(.eh_frame)) }	:text
> >  
> > -	.rodata		: { *(.rodata .rodata.* .gnu.linkonce.r.*) }
> > +	.rodata		: {
> > +		*(.rodata .rodata.* .gnu.linkonce.r.*)
> > +		*(.got.plt) *(.got)
> > +		*(.data .data.* .gnu.linkonce.d.*)
> > +		*(.dynbss)
> > +		*(.bss .bss.* .gnu.linkonce.b.*)
> 
> Looking at other architectures, it appears the last three lines of
> sections could be discarded, but I don't know enough about this to

Hi Andrew,

I checked x86, they still keep those sections. From another side,
even if those sections are not needed, removing unused sections could
be an independent patch, for safe reason or bisect reason.

Thanks


> state they should be.
> 
> Thanks,
> drew
> 
> 
> > +	}
> >  
> >  	/*
> >  	 * This linker script is used both with -r and with -shared.
> > @@ -44,13 +50,6 @@ SECTIONS
> >  	.alternative : {
> >  		*(.alternative)
> >  	}
> > -
> > -	.data		: {
> > -		*(.got.plt) *(.got)
> > -		*(.data .data.* .gnu.linkonce.d.*)
> > -		*(.dynbss)
> > -		*(.bss .bss.* .gnu.linkonce.b.*)
> > -	}
> >  }
> >  
> >  /*
> > -- 
> > 2.40.1
> > 
