Return-Path: <linux-kernel+bounces-141480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B428A1EC7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A27DA1F2A7F8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F03243171;
	Thu, 11 Apr 2024 18:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3DZwwiso"
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FFD41C60
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 18:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712860451; cv=none; b=C6jI0MUQ0m2RNknOkEkieLUbcgp0vMxVQwxg6F7owkJdpOnnfOx0ujcgi3JaJB1g3N2BiYsJ3Z2wgQo9tNKgpgPW9Vre/KfZ4GyCczFvkFmKVxENnmpf8W4nbtA5zi1eiGL1YoEVpAaMyBfN0Lhzv+Xasey2ZErnpyzQWXVzEQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712860451; c=relaxed/simple;
	bh=stMEsNBdhDZHN0AAsq6vgx6+Ts1oyq4oANVAhdK9098=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fBQjwlA0RF68rvHuyQncbq/LsWunle8Fmy/4Q/6WM6sAhSmlUJkN9PyOEiIW7ulfKLMLW35sdbB0rtCIqQzPMkDC0+GuSteCWrnggxqss2aWkNLhbh2Qc1JIpOA4X0joJ0WhMKaELo8xVN0zcmOtGTzClDxlXLw9pG0TNNHYSZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3DZwwiso; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-47a21267aa8so50913137.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 11:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712860449; x=1713465249; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=stMEsNBdhDZHN0AAsq6vgx6+Ts1oyq4oANVAhdK9098=;
        b=3DZwwisoypGW2BVzYpUw21eDqbM/TXMUrPPPs68zem63cVgbeqALGNB//KCdmNNbpO
         DwvJyNh2TWOS+zExTuwjsNuKP/2UwH9PYPy4QBLZJmM7jrowlMLEpmfLRXWx4qxrMrnH
         Hb3RJTnt119t6JDLM++LHs41MQg0LpOCVoril9qoqsT78fICJRANx2VlDSiNuYdPVWXk
         fQg4HqB8DWn0wHr2EXZh/Vbsfcg2lBesdqLmlw6EiGOcNMLUzQ5uN18q+JwVc0+MFfsJ
         AZGVnL0fs1aw0MMTC3pQw2dQnN67eQcgrtfsrWpsHTfdfDe44zP3tRVfJS8qv44iNwWK
         zotA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712860449; x=1713465249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=stMEsNBdhDZHN0AAsq6vgx6+Ts1oyq4oANVAhdK9098=;
        b=fzh4qx8692ToCOxKlOdjPskXStthqCREJbWLIOdDSoCRkW+/IRE0lMY2ptezNF9+bj
         Bcc3zz3UAqsfZ3QY6Y7CMOqc6Ac1w4eqeoHqCDL6yLuLF4tngKsUZ/+StMcQ1onfT42I
         gp/8BzuAEnn6donSRPJ42M5cfKoKJcTx6Ge541I88lD9XImMxHOLxbtviQh0Lb3Oz0TA
         3LUywEx0F7o61xIWdNnqhVWI+zgFoCf94OstoxFyNeIzuaZ2EpgJkfijL1jbE86lzf35
         Vvm5uwYhO1yEv8RFppll9lvRMjPml7BvEPNDAMBwmQAsxgBWv9JOxOdD58MVOiMLDIdT
         JdiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWs09/Hp4dzzTTsC8m4CS8XgQm99ZywYcMq1bDtvZupenmdnzyQWFwll2XqFkQcHvWxVxjYZK99hsB+Tul+MBVCLgWVByHNi+O0SwqK
X-Gm-Message-State: AOJu0YwWOqE34QbgPRmJ6q0Ym/A8tUciG0nhr5KAD0Nl5/7/SPbcRPX3
	bK4VMPY7IYhQ6ahF/sFv84d6r9541nIxOSmXcmFMbe/G7/LIfg3H2wdIuSzKcT3I6IUx+wASERe
	n+j1wLRDqA2jLUcxQV1zDIkWCuSymErmRyK9E
X-Google-Smtp-Source: AGHT+IFfuK5+fQsC0QczQeo6WuoykTwpS5Kk4PpmnlC1hN0dL/Pi0+fTSQq1O1Njt6aog/wFbvvhl3lV/7VPrJZJ6bQ=
X-Received: by 2002:a05:6102:b08:b0:47a:36b9:160b with SMTP id
 b8-20020a0561020b0800b0047a36b9160bmr819522vst.16.1712860449222; Thu, 11 Apr
 2024 11:34:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240409061043.3269676-1-debug@rivosinc.com> <20240409061043.3269676-3-debug@rivosinc.com>
 <CABCJKuee-6GGDDjvByCkikR02gka2BNhwRVBw6UAwEcmSQposQ@mail.gmail.com> <ZhgjoyObf+nMihA4@debug.ba.rivosinc.com>
In-Reply-To: <ZhgjoyObf+nMihA4@debug.ba.rivosinc.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Thu, 11 Apr 2024 18:33:33 +0000
Message-ID: <CABCJKuf5Jg5g3FVpU22vNUo4UituPEM7QwvcVP8YWrvSPK+onA@mail.gmail.com>
Subject: Re: [RFC PATCH 02/12] riscv: add landing pad for asm routines.
To: Deepak Gupta <debug@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, nathan@kernel.org, ndesaulniers@google.com, 
	morbo@google.com, justinstitt@google.com, andy.chiu@sifive.com, 
	hankuan.chen@sifive.com, guoren@kernel.org, greentime.hu@sifive.com, 
	cleger@rivosinc.com, apatel@ventanamicro.com, ajones@ventanamicro.com, 
	conor.dooley@microchip.com, mchitale@ventanamicro.com, 
	dbarboza@ventanamicro.com, waylingii@gmail.com, sameo@rivosinc.com, 
	alexghiti@rivosinc.com, akpm@linux-foundation.org, shikemeng@huaweicloud.com, 
	rppt@kernel.org, charlie@rivosinc.com, xiao.w.wang@intel.com, 
	willy@infradead.org, jszhang@kernel.org, leobras@redhat.com, 
	songshuaishuai@tinylab.org, haxel@fzi.de, samuel.holland@sifive.com, 
	namcaov@gmail.com, bjorn@rivosinc.com, cuiyunhui@bytedance.com, 
	wangkefeng.wang@huawei.com, falcon@tinylab.org, viro@zeniv.linux.org.uk, 
	bhe@redhat.com, chenjiahao16@huawei.com, hca@linux.ibm.com, arnd@arndb.de, 
	kent.overstreet@linux.dev, boqun.feng@gmail.com, oleg@redhat.com, 
	paulmck@kernel.org, broonie@kernel.org, rick.p.edgecombe@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 5:53=E2=80=AFPM Deepak Gupta <debug@rivosinc.com> w=
rote:
>
> In principle, I agree it should converge with software based kcfi scheme
> as much as possible. However blocker that I see is `hash` is placed just
> before function. This breaks for code mapped as execute only scenarios.
> And ideally would like to have immediates at callsites instead of loads
> (purely perf reason and not security).

I'm not saying the schemes have to be compatible, just that it would
be great to avoid reinventing type annotations etc. For example, when
you implement the fine-grained variant, you could simply override
SYM_TYPED_ENTRY (defined in include/linux/cfi_types.h) to move
__CFI_TYPE inside the function, and then redefine __CFI_TYPE to emit a
landing pad with the correct label. This allows SYM_TYPED_* in
assembly code to work with both KCFI and fine-grained Zicfilp. For the
coarse-grained variant, your current macros are perfectly fine.

> But yes in next version, I'll take a look and try to converge as much as
> possible.

Great, sounds good!

Sami

