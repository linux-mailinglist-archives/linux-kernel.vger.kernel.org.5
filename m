Return-Path: <linux-kernel+bounces-91784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A88E871689
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 08:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F91728106A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 07:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33D17E103;
	Tue,  5 Mar 2024 07:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZMqeS+yT"
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1477D3F6
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 07:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709622958; cv=none; b=WEhaQXV23KuGCoKjFedR3/iav4VhKN2CFNZ+O02B2M8JyEY8VF+O2/UopfZvYIukyeuyXr6xssB4O8Er8bTEv2NBXVlmvA7B4OtAHm5U4k8tD3LFL+COkDeIeH7RiFmuBFvLoR+1pwZ60X1YLcThX9PKapr2oXk11BxQmMSM+5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709622958; c=relaxed/simple;
	bh=AOBoMHIHXun7k66fDF65ErKjLq+GabAleB2MTw+glUU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JMY2MzEXMLM9kQQ9y8IKUi9MKrn6FWTFDGLXrPRiA+ROkhu0th/leNss7tBSRwnxDyBJ36d/sW4i0ARW+QZCWHONgixq1ypnvDcz1Ipp4NsVvjVvaYmxKeBciFZXsCaxNdL+42U6MMsoO5sR2YuacHPVHiNHlvloCjy/OM7kmYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZMqeS+yT; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-4d365d28456so856129e0c.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 23:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709622954; x=1710227754; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TARH0Ui1EkAQgfJe/ml3tlK/v4h1IpOTk38ByqS9yEA=;
        b=ZMqeS+yTYzxtxk2CYaQjgPddEnNuF7iVVTLXi614A/MiXMqHs/i/0UZx2VwRhe/VHf
         k7LHnvwHyWddKuK6OQ7mZ3Lr9kDlC0RVTSPby1VlTWXUCXy1R/lNC6848oVmyP76yW+X
         8/YqhqAMWlLFDS90v4bCNmkT+t5BdScsOtlBMdN1NQB+nGnccHXJv4cR30sKRDDyc8mE
         8Z7jeNU9dzfW7Gtvd4UqEuRh/djqCp/XtsS3FLI1Xdfq6iFgOXpFtXlOGcngpi/AxtBh
         2H1GM6EZoz6SdTPYLY9LjcFBbrPcCmqMBeUG9cKrbSdCBPIMnw/lpweSDQkEpdEaSkEK
         tbBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709622954; x=1710227754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TARH0Ui1EkAQgfJe/ml3tlK/v4h1IpOTk38ByqS9yEA=;
        b=GhSFcFI/nhoTICpUt79CNQb5/m01iqeaCyVz1i3cMBwYpCgU0rRoI90xKcKUBBl1V7
         hg/1uGFa7irrRd2fLKAwRpz3r66KJRAx9wwGKf2qCZ0lADq9xe1Xhmye0Oty5BTtm1P3
         mpnXvJtLfiTWg9YsttuWt8NtxZLcsuCmHbXe7Pa35fT67vGrRz3ZJnImXOS6zzlERJTz
         zauIGQS5T02ApRaII1wAE7EGkVqzJqPmT41hqNC1bZrrsxkNhHGY7uQ9Ckuq2U2v267B
         NogOnZlt5pqMtO1nQTgzzi2LYWza8ae2ETtJiS9ieZ3aOxj/VVOlpTRbA3frbRUMLLSl
         64lQ==
X-Forwarded-Encrypted: i=1; AJvYcCVam+wfTXaEl7wFN0ZSY6dEW+yRWTGtGwRpC6mUjSkEm8NQcLOwvMaw+JxXfb93ZzA43cigRqAnbh3XohaeekLa6UmWwiyVDLGpxv1u
X-Gm-Message-State: AOJu0Yyjuo9CtkV2xYUkeQfMi7z2blA3l3tPg0OA/nLk9nOZqPRsEYxd
	gFuYt71+qu2ufMWRgL26+KdBtPXl+G+mjX0ILgfo5YDwpoRFH4E3H87CldF2HTcVAza7Zq2rrLT
	mzWPNhBOj7n7MWxqnxCqoMmHyBIY5MQY9liCN
X-Google-Smtp-Source: AGHT+IHptTxwPX9/UM5h2BoqjLBueY0WDDTaOiA3Ztr1dXAm8ZeZc03wH6hlKAe+yDqOUj5D2WRhICaTKs4oBjuERFs=
X-Received: by 2002:ac5:c77a:0:b0:4c0:2abe:d585 with SMTP id
 c26-20020ac5c77a000000b004c02abed585mr921619vkn.6.1709622953794; Mon, 04 Mar
 2024 23:15:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABCJKuem3GbLO-G7+wi8LPA8rFgNzFVjNof7zcAO1UGJR4u44Q@mail.gmail.com>
 <20240304233151.248925-1-kernel@valentinobst.de>
In-Reply-To: <20240304233151.248925-1-kernel@valentinobst.de>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 5 Mar 2024 08:15:42 +0100
Message-ID: <CAH5fLgg0yGbuHnMbMB103Zssg4KSfXUR3kvhr0kuqTSah=6kWg@mail.gmail.com>
Subject: Re: [PATCH] rust: add flags for shadow call stack sanitizer
To: Valentin Obst <kernel@valentinobst.de>
Cc: samitolvanen@google.com, Jamie.Cunliffe@arm.com, a.hindborg@samsung.com, 
	alex.gaynor@gmail.com, ardb@kernel.org, benno.lossin@proton.me, 
	bjorn3_gh@protonmail.com, boqun.feng@gmail.com, broonie@kernel.org, 
	catalin.marinas@arm.com, gary@garyguo.net, keescook@chromium.org, 
	linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mark.rutland@arm.com, masahiroy@kernel.org, 
	maz@kernel.org, nathan@kernel.org, ndesaulniers@google.com, nicolas@fjasle.eu, 
	ojeda@kernel.org, rust-for-linux@vger.kernel.org, wedsonaf@gmail.com, 
	will@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024 at 12:32=E2=80=AFAM Valentin Obst <kernel@valentinobst.=
de> wrote:
>
> > >
> > > Add flags to support the shadow call stack sanitizer, both in the
> > > dynamic and non-dynamic modes.
> > >
> > > Right now, the compiler will emit the warning "unknown feature specif=
ied
> > > for `-Ctarget-feature`: `reserve-x18`". However, the compiler still
> > > passes it to the codegen backend, so the flag will work just fine. On=
ce
> > > rustc starts recognizing the flag (or provides another way to enable =
the
> > > feature), it will stop emitting this warning. See [1] for the relevan=
t
> > > issue.
> > >
> > > Currently, the compiler thinks that the aarch64-unknown-none target
> > > doesn't support -Zsanitizer=3Dshadow-call-stack, so the build will fa=
il if
> > > you enable shadow call stack in non-dynamic mode. However, I still th=
ink
> > > it is reasonable to add the flag now, as it will at least fail the bu=
ild
> > > when using an invalid configuration, until the Rust compiler is fixed=
 to
> > > list -Zsanitizer=3Dshadow-call-stack as supported for the target. See=
 [2]
> > > for the feature request to add this.
> > >
> > > I have tested this change with Rust Binder on an Android device using
> > > CONFIG_DYNAMIC_SCS. Without the -Ctarget-feature=3D+reserve-x18 flag,=
 the
> > > phone crashes immediately on boot, and with the flag, the phone appea=
rs
> > > to work normally.
> > >
> > > Link: https://github.com/rust-lang/rust/issues/121970 [1]
> > > Link: https://github.com/rust-lang/rust/issues/121972 [2]
> > > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> > > ---
> > > It's not 100% clear to me whether this patch is enough for full SCS
> > > support in Rust. If there is some issue where this makes things compi=
le
> > > and work without actually applying SCS to the Rust code, please let m=
e
> > > know. Is there some way to verify that it is actually working?
> >
> > Perhaps you could write a Rust version of the CFI_BACKWARD test in LKDT=
M?
> >
> > Alternatively, the simplest way to verify this is to look at the
> > disassembly and verify that shadow stack instructions are emitted to
> > Rust functions too. In case of dynamic SCS, you might need to dump
> > function memory in a debugger to verify that PAC instructions were
> > patched correctly. If they're not, the code will just quietly continue
> > working without using shadow stacks.
>
> Was just in the process of doing that:
>
> - `paciasp`/`autiasp` pairs are emitted for functions in Rust modules.
> - Rust modules have no `.init.eh_frame` section, which implies that
>   `module_finalize` is _not_ rewriting the pac insns when SCS is dynamic.
>   - Confirmed that behavior in the debugger (C modules and the C part of =
the
>     kernel are correctly rewritten, Rust modules execute with
>     `paciasp`/`autiasp` still in place).
> - Kernel boots just fine with Rust kunit tests, tested with and without d=
ynamic
>   SCS, i.e., on a CPU that supports PAC/BTI and one that does not.
> - Rust sample modules load and unload without problems as well.
> - `x18` is indeed not used in the codegen.
>
> I guess we might be able to get this working when we tweak the build syst=
em
> to emit the missing section for Rust modules.

I suppose the -Cforce-unwind-tables=3Dy flag will most likely do it.
There's also an use_sync_unwind option, but it defaults to no, so it
doesn't seem like we need to set it.

Alice

