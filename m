Return-Path: <linux-kernel+bounces-89613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D732386F2B8
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 23:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57C57B22474
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 22:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870CB4AEE1;
	Sat,  2 Mar 2024 22:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BXxFN3PQ"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4F34177B
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 22:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709419776; cv=none; b=umu+B93WzNXIL8uYwXEwp7f7AFIS4QmNmJ+wdjGLh+f5zMfxtMaxqEFGkvh+fz32f67H3uv6tRAguSI5p+knZkc6c3n9MG07nR3LoNIyh1JTnZ/879xluPl/bDPhMoyeqo0j02ItUyHlxJlFi6/vt1HGUp+9LvrGmDTo7de5/xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709419776; c=relaxed/simple;
	bh=yvElCY4n79Px/TYdKRnwrreP/LvNLE515QJnoH8nICI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AKFS4mtxPu134sAVRpt5HGgN0nTGZso5DuilXl9pAjLXuFeflwVH+4hPk3i7DJuRQQHnuHp+8jEXJfGKg4ATrwPjhBu1iFtjJsNzUMJGOS5mcyR6b6eYOhjYqhD2OXahLxk8BIoVKj8cTKTlZNWwH3XH7YrxHfc883fbgX5NfJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=BXxFN3PQ; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5132010e5d1so3411397e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 02 Mar 2024 14:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1709419773; x=1710024573; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=U0O313/N/H96x2BCcFEncXqBwotYwnAA6fTUaOEPtLE=;
        b=BXxFN3PQS1jC4C+k9NlDq4oCn8MW0vXg7EfcldewcYZoeCFlT+XIDXlJSfhMxwWdrL
         CSa5ST+5jbeAd9ztbquHi9JkuYjSKnTQZv6jEqeMbyrfbuOdBRtfFb/VH6Ciw/D1YWVc
         MGvcuxEdo20dsRBKxHEB7IJahcD1EXvB6zKbw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709419773; x=1710024573;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U0O313/N/H96x2BCcFEncXqBwotYwnAA6fTUaOEPtLE=;
        b=GRU0XFIRiPvT99qazgadM2qshnBGnKEwx8OTZmImmMZyJWpOoNnSq+qm0mjgukapKV
         fAB2WE3SBiI65LrBSMipg46+PQCFqnmIzfHJualjmSj9cSxtUJ5UcpJddOtYAK6yyeey
         G21dZHqQ2b+wh3HgEPetUyAxDGgZW76zyGpfn2+Gy6qxbAfPV4G5F2DSUeQSE3Kr6Xb9
         rZIR6n9enepxx5kAqAo1UyOkUYMZKsVyBJpZWnXil/6yK3MsSeKqtXxSbO4Ir1kTyPxt
         JGUl6g0miBlRnd1Aosf3Z1BhULNQJDhgeYOKKrC/vItcO1hvUTdQs/kGfL68+l8T7/wh
         UkwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnz5VqXTqrd/+qNJ+oPsvAsFs3Pvz/W6IX3pQ/Cci07/a1DMgSC9GBT7qzMOAScu+YkgVlIepoN9awHM15BJmeyGJbYUp1Ecr0WXgo
X-Gm-Message-State: AOJu0Yxcd/r13ysqxZzeSLSTRutrTmrMQpVuAybhrtaE5DQqnqPijJih
	ntAsTQuX/fJU8GDmcYPF3LTCZqUsrfwHomEcuolmt7C87MWR9mMK7IX58hzeXBkvvJfFJeKqYwl
	IX8Z0oA==
X-Google-Smtp-Source: AGHT+IGKXSiEihY+S10Dg0d3TwcQz6uKjhda2L1kFYAH/j7pyatTVOskrfHoS2qLcTLAFlXBVK2C7w==
X-Received: by 2002:a05:6512:39c3:b0:513:33a8:f80e with SMTP id k3-20020a05651239c300b0051333a8f80emr3919750lfu.66.1709419772738;
        Sat, 02 Mar 2024 14:49:32 -0800 (PST)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id d25-20020a1709067f1900b00a440e2ada28sm3099301ejr.201.2024.03.02.14.49.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Mar 2024 14:49:31 -0800 (PST)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a3122b70439so533930566b.3
        for <linux-kernel@vger.kernel.org>; Sat, 02 Mar 2024 14:49:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXc6w0hlQpLPcZ5shzCAOJz99yZyMTKhnEOHZdbTIY+r7dUCA0fFYmd1lzHSAucvNCS+uzF03Z8ENPWqY7+BwNdM4UmARH2t2hD0E86
X-Received: by 2002:a17:906:3416:b0:a45:1951:acb9 with SMTP id
 c22-20020a170906341600b00a451951acb9mr52187ejb.13.1709419771531; Sat, 02 Mar
 2024 14:49:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202403020457.RCJoQ3ts-lkp@intel.com> <87edctwr6y.ffs@tglx>
 <87a5nhwpus.ffs@tglx> <87y1b0vp8m.ffs@tglx> <87sf18vdsq.ffs@tglx> <87le70uwf0.ffs@tglx>
In-Reply-To: <87le70uwf0.ffs@tglx>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 2 Mar 2024 14:49:15 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiWhfdc4Sw2VBq_2nL2NDxmZS32xG4P7mBVwABGqUoJnw@mail.gmail.com>
Message-ID: <CAHk-=wiWhfdc4Sw2VBq_2nL2NDxmZS32xG4P7mBVwABGqUoJnw@mail.gmail.com>
Subject: Re: arch/x86/include/asm/processor.h:698:16: sparse: sparse:
 incorrect type in initializer (different address spaces)
To: Thomas Gleixner <tglx@linutronix.de>
Cc: kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@linux.intel.com>, x86@kernel.org, 
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, 
	Sparse Mailing-list <linux-sparse@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 2 Mar 2024 at 14:00, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> I had commented out both. But the real reason is the EXPORT_SYMBOL,
> which obviously wants to be EXPORT_PER_CPU_SYMBOL_GPL...

Side note: while it's nice to hear that sparse kind of got this right,
I wonder what gcc does when we start using the named address spaces
for percpu variables.

We actively make EXPORT_PER_CPU_SYMBOL_XYZ be a no-op for sparse
exactly because sparse ended up warning about the regular
EXPORT_SYMBOL, and we didn't have any "real" per-cpu export model.

So EXPORT_PER_CPU_SYMBOL_GPL() is kind of an artificial "shut up
sparse". But with __seg_gs/fs support for native percpu symbols with
gcc, I wonder if we'll hit the same thing. Or is there something that
makes gcc not warn about the named address spaces?

Because in many ways the gcc named address spaces _should_ be pretty
much equivalent to the sparse ones.

            Linus

