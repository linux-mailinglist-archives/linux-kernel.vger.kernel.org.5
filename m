Return-Path: <linux-kernel+bounces-99721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A08D9878C3D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 02:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 147BAB21312
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 01:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443541842;
	Tue, 12 Mar 2024 01:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+C6M9/C"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DC07E2;
	Tue, 12 Mar 2024 01:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710206786; cv=none; b=IJw9Sv55kVnettdj1ndjEPm9vy/Ll2QO6vZLbN3rSGBUKGm0BBMHcU9gGMHxPo+vtC5IBWqZZvDglkVovopPi5I2haqCEPqHqdiCS3yyCvYv/0bMXZNXHtN/9iyg+yFayh9kpTKAlozVDxp5IZmzOJ/oU7L+THGd2qYErQKk/Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710206786; c=relaxed/simple;
	bh=GyA2AfVBUEUaHKxyGNy7I8OR2zGDzYXGB8bS0wH502E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JDD6i+/ZbcPlaGxzmYrbHv/7lZLV8h66I9223vDJTkcs5fOAj5BzJKwyG+uEgvIHlv2icACna11q6b4ogalDbEMFVVI8Xmv65QexAbAAPHKa8X8WQykcfQfhWQqv3VyRddzfxWcZ2VlVLJSMnU7NxmFVzDr2zm5fA2WL3wvVIT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G+C6M9/C; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-413328344acso2183165e9.3;
        Mon, 11 Mar 2024 18:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710206783; x=1710811583; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kscZcOUOHWXZr8d7Aotv9yaf5lVIDmR/3s4rt3vEiJE=;
        b=G+C6M9/CvNcFPVWzOo3s/Up8DWBySnEx4afjJKWshiJ2S0ShzhciD45zw995Sn7uis
         K+bG+ccVBqex/o5Xh/BTSoB4U69ct9pRo9Yist/LnIy+2PWxBDECCy8inZMhWaTxJlQP
         8X6HIWOMAwFO7wpNRSuIbyG6LmQ7QRToPyengeVItakieyqDpRtucZO1RAQUCghSM7Qy
         mlxHrHHJE+vKhvrG5ITeriOA4aA0YhnCKSHTpK0H8owajfe9V1FPmo0EGA+EL7HJJGoK
         taI0lpE1Ug6nVo+deyxiyUeT1GFHJRo9GK0QxFV9CZrD+73srxolbkOaUu2pxIVKM8EM
         PgKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710206783; x=1710811583;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kscZcOUOHWXZr8d7Aotv9yaf5lVIDmR/3s4rt3vEiJE=;
        b=pTXMy/UjWAR1SplmhBbxuTkvZNZkHvId7Uu54qpshTAlkHpuUzPYXhR2McdRtcqVkw
         zlC7HCPbOWC6vsyOJYzTakVQA5Ny11MyE8rds3LKBJyZMMlwKYUNfmHnldNKZKoStlCJ
         VdbfkwueR+f+5qGav6xwEeCNB+yh286YskFtdoo3nc/A9ExHSdSfzyVmWb8SbSs+vuEA
         Kjb9eLQTk56Pj31VPKj29AZMt2KkvqQ8p20P/mQ4JWjB9pI3+Ogdq0yi8vDCYHpeZMT/
         mhCk7GCE0Irv8349TFlvz9X4h6FoqnW7ygMRvMpoKI/LbEF/MbtypWuG3U1SMk92c+zP
         CBBA==
X-Forwarded-Encrypted: i=1; AJvYcCXThmdKkQKLNsvpfYGMInSoSiLAtIhsfBZCIK30zz/4pacqI4vtQUDr1XuvswEP+CCVojvtaEf8StnhiYs38C3w52Dq0Aw7pdvnvahFRjmYvGWrUXsW5yuDgXOb7JboMYxj
X-Gm-Message-State: AOJu0YxxGgEM7Z4qzEr1dkFJRD1VCo67ZPOI8cvZUGeqf8EJUcZN9Ckw
	KS+XN/EmXiYLyi/kP/GTSuIqom5lJ3oDk/hteW4pDH424XK36YG9uuSdk2wNV9PIqHDYF/i0yHP
	tL37oCy9wnGHX1TOcWwhkJAYqEdU=
X-Google-Smtp-Source: AGHT+IFKW6cUCi0saeWKoL0AaPNypvf3M3iB9lYDups/lcLoaLFuXEDNeokVJOWFfqCOeeGiVXcf3F0gL0U6FksOyb4=
X-Received: by 2002:adf:f50f:0:b0:33e:7a7c:a058 with SMTP id
 q15-20020adff50f000000b0033e7a7ca058mr4928022wro.18.1710206783102; Mon, 11
 Mar 2024 18:26:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227151115.4623-1-puranjay12@gmail.com>
In-Reply-To: <20240227151115.4623-1-puranjay12@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 11 Mar 2024 18:26:11 -0700
Message-ID: <CAADnVQLPf2-saMJxv65zqDAjc8JX-08dRUP3hbrAh=q+2xiqzg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/1] Support kCFI + BPF on arm64
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Zi Shen Lim <zlim.lnx@gmail.com>, 
	Mark Rutland <mark.rutland@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Mark Brown <broonie@kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)" <bpf@vger.kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 7:11=E2=80=AFAM Puranjay Mohan <puranjay12@gmail.co=
m> wrote:
>
> On ARM64 with CONFIG_CFI_CLANG, CFI warnings can be triggered by running
> the bpf selftests. This is because the JIT doesn't emit proper CFI prolog=
ues
> for BPF programs, callbacks, and struct_ops trampolines.
>
> Example Warning:
>
>  CFI failure at bpf_rbtree_add_impl+0x120/0x1d4 (target: bpf_prog_fb8b097=
ab47d164a_less+0x0/0x98; expected type: 0x9e4709a9)
>  WARNING: CPU: 0 PID: 1488 at bpf_rbtree_add_impl+0x120/0x1d4

..

> Running the selftests causes no CFI warnings:
> ---------------------------------------------
>
> test_progs: Summary: 454/3613 PASSED, 62 SKIPPED, 74 FAILED
> test_tag: OK (40945 tests)
> test_verifier: Summary: 789 PASSED, 0 SKIPPED, 0 FAILED

Catalin, Mark,

Could you please review and hopefully ack arm64 generic bits ?

The JIT changes largely mimic x86 changes and look correct to me.

