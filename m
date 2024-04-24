Return-Path: <linux-kernel+bounces-156400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 778FA8B025B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 08:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E6C7281F93
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 06:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210FE15748B;
	Wed, 24 Apr 2024 06:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="jlAnsaql"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D4FEC0
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 06:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713941089; cv=none; b=NjAjryUwisgZCg+IWH30Nf87CrbzYxn4Jc/BBPevMtCaQYa9aK/unooFcWxv4v8Gs5kKOamhM+gebibwOuNUIrfpQqv5XdGxD7XqdBxenDkeWMfSX8DIl1nXNiGsGAzAJyn/6PC7HV+xhO6lqOGU/ttxd+CCoGXrH8hjNb8Baiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713941089; c=relaxed/simple;
	bh=qywyNAqtfmH3XPM3wc3C3h0jJnNuoDFJUlD0uSHfGJ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X9MvpOmNZS4zIOGiesre0kgiqINAMpbuGM8KshnTmqtCQekvPqtxL5kL00l2DOv807avDMPwuXpj3Qdin0hxmbK9TIQ7b1lZzbpRVmUGCQO6BV/NkOKp4S/mu9gMoPlNMnCf+vnxe/9aT+ZiaAlXCzxK3WEvIVI2TCNhl5IPg1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=jlAnsaql; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7dddba0f02fso84852039f.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 23:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1713941087; x=1714545887; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sf3+5YALiCVsfizYQ3BDSn74CJsGH44UmM4ytaiZ8LM=;
        b=jlAnsaqlvlEt9FPwcwjDy9IaN+Fcxx1QE37nTGGAN00ggG/w4NZa6KYzTaIN+9yxhU
         CWQXSzSmlJLk8fGRrfKvoXIMWcSiAw+AjakMZ5ranb9IVAdFnOqObRxebJSxPIKOB69B
         hrg8bNVq62xrNQ++nsxQsiVC2nu5wkP0i8MDKS45cWk+UVRZvgwNgmP62tIAxWQ1g/n+
         U6Kc2n1y4emKUWVHkOGbwEM11geG+UveZrLR/HrOzdoawpeK2vcGvu4prxQDV0Fj0PR+
         J0Vw77Il66M0/6CSAThn8tj1hFwf4pnp+At5d8fgXhZor5TzMSavAlHysIVZNtCYMlkO
         MvZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713941087; x=1714545887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sf3+5YALiCVsfizYQ3BDSn74CJsGH44UmM4ytaiZ8LM=;
        b=gsFY0mEcL/a1kxhhKwmQQB0n4WaBZRYi9ssh70n8UWfrtwmHHti5ihN3edJ+yXz5Us
         wkzKOSlJhxNMHp5GS1yiE02SKPvPjIkEhLXfy0xJGkbqkHDPEpODZwFFosXFON9Jp90r
         2uU7RYVzs/xinno1QqyB5EUJUVvK/vfSLj2M+wse3zo4TqkVXzqukHgyM1P/GC4DGbUw
         fTyBAMfl7GYCpzeCTGOPCgOyYi7qjIVUN62FsUn6JnBZyRt5O1P3Xg2P+zwC1i68gQ2w
         MfwOCDVeyFNS5asPHlQZwF644Tzwsld+UMMbMHwy1isSBbhgS1y5ocem+wipTVIkU75g
         5Nxg==
X-Forwarded-Encrypted: i=1; AJvYcCW7DYLnaKI8e55kidlr9+NZhl4RuqA07WiE4vUooqR9Q7wftKFtapv4GvpAFmyjzsjvciFHb4u1tDyG009vDIHcSf6WGtn/QqoDKdsU
X-Gm-Message-State: AOJu0Yxra0Xp31Rb1cu7tjQ9EK+mFf13+6MPOOJIXB1bKDZ4K5XyaCUl
	0pQidmyO+CzXKSQspssOHDvwXrcS69AE6ru2y5NXRCY2NSH1vD6UsnI6oL4DXr7KavvVjdvMqtJ
	PLKsVmgGIvRboQb38Y2l/MEk5RcVRoisYNNufpw==
X-Google-Smtp-Source: AGHT+IErBzM2ZvKYjC/kgSDBdh9xGud9im9ZtDYytTVq3cZLIALDpKA6oVcIv+vfvAqc+qjjb0Q4f5CdYvyjEl60vMI=
X-Received: by 2002:a6b:7e46:0:b0:7da:836:5d82 with SMTP id
 k6-20020a6b7e46000000b007da08365d82mr1731542ioq.7.1713941086645; Tue, 23 Apr
 2024 23:44:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416013138.28760-1-zong.li@sifive.com> <Zia29wYvScRVdXUP@ghost>
In-Reply-To: <Zia29wYvScRVdXUP@ghost>
From: Zong Li <zong.li@sifive.com>
Date: Wed, 24 Apr 2024 14:44:35 +0800
Message-ID: <CANXhq0qN-SsC=iO_5gAea=FqQqztmVUHaGxE5Z2me0h10jBU+Q@mail.gmail.com>
Subject: Re: [PATCH] Revert "riscv: disable generation of unwind tables"
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	schwab@suse.de, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 3:14=E2=80=AFAM Charlie Jenkins <charlie@rivosinc.c=
om> wrote:
>
> On Tue, Apr 16, 2024 at 09:31:38AM +0800, Zong Li wrote:
> > This reverts commit 2f394c0e7d1129a35156e492bc8f445fb20f43ac.
> >
> > RISC-V has supported the complete relocation types in module loader by
> > '8fd6c5142395 ("riscv: Add remaining module relocations")'.
> > Now RISC-V port can enable unwind tables in case eh_frame parsing is
> > needed.
> >
> > Signed-off-by: Zong Li <zong.li@sifive.com>
> > ---
> >  arch/riscv/Makefile | 3 ---
> >  1 file changed, 3 deletions(-)
> >
> > diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> > index 5b3115a19852..9216bf8a2691 100644
> > --- a/arch/riscv/Makefile
> > +++ b/arch/riscv/Makefile
> > @@ -94,9 +94,6 @@ ifeq ($(CONFIG_CMODEL_MEDANY),y)
> >       KBUILD_CFLAGS +=3D -mcmodel=3Dmedany
> >  endif
> >
> > -# Avoid generating .eh_frame sections.
> > -KBUILD_CFLAGS +=3D -fno-asynchronous-unwind-tables -fno-unwind-tables
> > -
>
> There are a lot of orphaned sections created by this, which throws a lot
> of warnings. These warnings will only be present on GCC-13+ since
> -fno-asynchronous-unwind-tables was a default before GCC-13.
>
> The .eh_frame orphaned sections can be resolved by including
>
> .eh_frame : {*(.eh_frame)}
>
> in arch/riscv/kernel/vmlinux.lds.S. arm64 places it in the init section,
> but outside init_data and init_text, so right after the .alternative
> definition seems like a good place.
>
> .init.eh_frame sections in drivers/firmware/efi/libstub also complain
> about being orphaned, and other architectures have disabled unwind
> tables for that compilation unit, so -fno-unwind-tables and
> -fno-asynchronous-unwind-tables should be added to
> drivers/firmware/efi/libstub/Makefile for riscv.
>
> This also causes the resulting image (with defconfig) to increase from
> 22M to 24M. There are currently no users of unwind tables in riscv so
> this should be hidden behind a config. arm64 uses this config as:
>
> # Avoid generating .eh_frame* sections.
> ifneq ($(CONFIG_UNWIND_TABLES),y)
> KBUILD_CFLAGS   +=3D -fno-asynchronous-unwind-tables -fno-unwind-tables
> KBUILD_AFLAGS   +=3D -fno-asynchronous-unwind-tables -fno-unwind-tables
> else
> KBUILD_CFLAGS   +=3D -fasynchronous-unwind-tables
> KBUILD_AFLAGS   +=3D -fasynchronous-unwind-tables
> endif
>
> Using this same config name for riscv would allow riscv to use the
> standard .eh_frame code introduced in
> https://lore.kernel.org/linux-arm-kernel/20221027155908.1940624-2-ardb@ke=
rnel.org/.
>
> This config is only enabled if some other config selects it in arm64,
> but riscv does not contain any users so maybe this config can be left
> unselected until there is a user of unwind tables in riscv.
>

Hi Charlie,
Thanks a lot for the tips and information, I will use gcc-13+ to
verify the next patch.

> - Charlie
>
> >  # The RISC-V attributes frequently cause compatibility issues and prov=
ide no
> >  # information, so just turn them off.
> >  KBUILD_CFLAGS +=3D $(call cc-option,-mno-riscv-attribute)
> > --
> > 2.17.1
> >
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv

