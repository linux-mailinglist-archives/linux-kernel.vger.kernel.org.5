Return-Path: <linux-kernel+bounces-127666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D37F1894F2D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 738FF1F2593A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 09:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48AE55914C;
	Tue,  2 Apr 2024 09:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HE2I2LN9"
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3430358AD7
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 09:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712051614; cv=none; b=VdLfeNGhK5xfJrjvCtLHi2gddBj5CKCbWcHVz7i9VAdNCllR40D+c8FcWAZg932On32fUtpaDnVJl5uqGKcd2lKFkLZ/KWpZZ9WW/a+dApcy353FqyZB9noprLUbuI1TS6RS8dvKLe3CnXrRrGLzbC3m/EDX+Nkgz67zPdH1yhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712051614; c=relaxed/simple;
	bh=xu5d6ilrg438VZeAHFA1DnM5oIEMmJTgRmgxdRzegpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K6DNEo+o9i7NenpH9YnPBSBvjD0RrU8PfwmEojfDPl/z2FWFREwr4vc+sJBHPP9qJ6wvGmCq0cN77UXgUtLB3T4qSyU+860+f2nPWyQViVAUvTJTeJwuWgnhTxTwnJ2H42+aAh/6xhSQn07F1sRU84JLrSSh0d1l0XY3VfMg4ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HE2I2LN9; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6e675181ceaso3237410a34.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 02:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712051612; x=1712656412; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xu5d6ilrg438VZeAHFA1DnM5oIEMmJTgRmgxdRzegpg=;
        b=HE2I2LN9IyeNySiNdoa6ybwgT3ASxgR9gFumAe55h/dCpfcMBtWM5+rxS2vv8jBBto
         SAoM2bUocrxcuB2t8h1Hjlbourmw11v+b4uqw2pfdWv8ZKrd2jUATk3JqF5p2KOG3Cb8
         sRWdB/hPw94cz8OU5y0lIUFraEj4PvN+qc/gwW9fdfR24yInU1lua0iJnQmUpUPYtqCm
         oPaLR6/XBROTFBPcu3daXi7d9McviZFoRkw5m9lbmIOUmcwLeEA3IBLE4MmIPJ25Y7Y3
         Rspyzs9pyCZk2mlmKXztQ3c2CcvZrjsWxPxWVwwQvbuxfk0/+mVnVlPXEtVey+x3I5pm
         eJjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712051612; x=1712656412;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xu5d6ilrg438VZeAHFA1DnM5oIEMmJTgRmgxdRzegpg=;
        b=TyUmDOwBRmRUSKnUgBwGoYugl46lsCEmV86nr8xM2D/MRhfG9nlFIzobwgiVZk661z
         C8F1mmUD8Ge5lvNRvlxopbhbRaNfEJXYfMvbY26QQZH74UPJGqHW9e5szgrmWqYW4U2W
         Okb927KPoC6eP7iBB+PGiObCni3f+MrzvnYMIPwnpOuIpaYPm7nvPjv5MBEiC7IqTi1s
         ML0ttqADSDPoJTRiqXezCeNV8KoNheszH4S0Q9YnYH+O6tfE+J7/+GEGVyM7x0Gp8MnM
         CRFV8LtlyNfKm4GQR5eYbfoQhyYL2f/b7Wx8vHTZtvUZoZTVqN0xjvCOi6fl6HOEhEEb
         QgmA==
X-Forwarded-Encrypted: i=1; AJvYcCUwtPMh/4riC2QQhN2jRFB/nbNa8E9YSJ6jTzP3nF1qGha8mz4xBEBf2619Qff2EZgJ8Nf5bpO1NyRhj5XMkHZ1U8Kz55MEBsmJPddH
X-Gm-Message-State: AOJu0Yw4f2rMRF3Ruq/mD063U/z4ySXjDgwq1EMRMnLOCbIUIbUJ6nMp
	Hf664jYhsvXv3o8USApkDpnobEfeoOoRkdQe4aiCnnLK6UbtelYcnTDh4YOhl7Wbumi87y36ExS
	IcdQgPutJj+TDncHEJ6BBX1vrm10=
X-Google-Smtp-Source: AGHT+IHOc0heTXgnDITpTt7V9+gWPFuuLZd0ajShe1ZCZWwrv9obr7Eb+XkcEHsbt5VDBKdL91elVYWWdYqFWEOpq+4=
X-Received: by 2002:a05:6808:1706:b0:3c3:d20b:5307 with SMTP id
 bc6-20020a056808170600b003c3d20b5307mr11196283oib.12.1712051612204; Tue, 02
 Apr 2024 02:53:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFGhKbzev7W4aHwhFPWwMZQEHenVgZUj7=aunFieVqZg3mt14A@mail.gmail.com>
 <CAFULd4a75kS=3cJzYKsOcJ3ULjW8k5M1cvPYZQ25zZqTo3QX9Q@mail.gmail.com>
 <CAFGhKbx3dzrMC0euRMNe5=sAhM87v=6gLwOT+c9HwWKZrWc5Gg@mail.gmail.com> <CAFULd4ZNi7eONVu8syiWyA5ek2TgHTf6jTM+Pf7SaSG6WyHoNw@mail.gmail.com>
In-Reply-To: <CAFULd4ZNi7eONVu8syiWyA5ek2TgHTf6jTM+Pf7SaSG6WyHoNw@mail.gmail.com>
From: Charlemagne Lasse <charlemagnelasse@gmail.com>
Date: Tue, 2 Apr 2024 11:53:21 +0200
Message-ID: <CAFGhKbwqrr=_bOnKW+wqtX2OyW0xpS_9wkJnHpwxmwx7MHGhfg@mail.gmail.com>
Subject: Re: warning: cast removes address space '__percpu' of expression
To: Uros Bizjak <ubizjak@gmail.com>
Cc: x86@kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	Luc Van Oostenryck <lucvoo@kernel.org>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Brian Gerst <brgerst@gmail.com>, Denys Vlasenko <dvlasenk@redhat.com>, 
	"H . Peter Anvin" <hpa@zytor.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Borislav Petkov <bp@alien8.de>, Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Am Di., 2. Apr. 2024 um 11:43 Uhr schrieb Uros Bizjak <ubizjak@gmail.com>:
[snip]
> Please try the attached patch that informs sparse about this action.

I've tested it using

```
git reset --hard v6.9-rc2
patch -p1 -i ~/p.diff.txt
git clean -dfx
make allnoconfig -j$(nproc)
make kvm_guest.config
make prepare -j$(nproc)
touch include/linux/netdevice.h
make C=1 net/core/dev.o CHECK="sparse -Wcast-from-as"
```

And it seems to work. Thanks

