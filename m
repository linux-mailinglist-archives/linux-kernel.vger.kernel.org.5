Return-Path: <linux-kernel+bounces-141375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B5A8A1D6D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 20:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 816DA1C24040
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B458A1D8EDA;
	Thu, 11 Apr 2024 17:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z2PpZh/m"
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09931DB556
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 17:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712855179; cv=none; b=qvW34sBp4RKZONZ49/Mcj7C0DfK8FlehcfkQETjyj1jAFeW0qcNs/ZtFyyhLUw4oeYbg5kqYAEb5ZAGfjILeHB0Q5wJq/eunyD8rovsPVESoCd/uN7YQdhddlzQrTUIBnDOKlQUSnSfAg1iZufRIpMDdhh9xKUSqCE26mhSO86w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712855179; c=relaxed/simple;
	bh=lts7IF4O3wh+oACzNnyW3TMbFIhfWZAEPaIt7vwWKBA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HLoMydyfZcFsj7mpEfa/YgfOb0vez2Awo31DhZSdPMzTX7nppazXsE2AYPdNY6NlvMLrFm7vj0d9vVBtFap5ewi/0ts+gHHZk9S9m/+oKERKv5VELaFQbrxSMMhMgcb5PlDJxagbkdQADUj4o/fsxaQfEGfmbCAWYPxwUqjQOb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z2PpZh/m; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-222a9eae9a7so49051fac.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 10:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712855177; x=1713459977; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lts7IF4O3wh+oACzNnyW3TMbFIhfWZAEPaIt7vwWKBA=;
        b=Z2PpZh/mCljvtnqxyokGhgFUccpxAjg28a/QCJoBE3X/lxoidTafb8sU+Y3EkxobBy
         dP40tR6shESvMSZ5KOygulnUIbmNL1swOfQAKrtXPUT3Sl6qIth44nQJhePNxpi03FR6
         yMt3C4V6zNWIqbYAtip3fmNcldWnPfpnCdu3QJONsxbNtWQiy+HDeFfM98aaRciGQGp3
         DdezzOUCVQkx8AyraxOjDMeNsf0WEgLCz2nLM9NgP7zw3A96oMKZBhEsYSqZAml6bNMF
         pARQhTX8acNCtIqb1mVMyKMnUVuFj5ouKZoDT18FWSg0cZLePDPRXoYpsHkn3huHzxFx
         JNDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712855177; x=1713459977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lts7IF4O3wh+oACzNnyW3TMbFIhfWZAEPaIt7vwWKBA=;
        b=qDbYaKNW8QlsCD5rLuTPQcZaXlIPdCUIbJvallkKwPv3YP3R/DVNcFgSIKOVE8irKO
         yzBevVLVDCOEQeM3bVn26WFeGxtttNjHB5XBYytQEpcJnF58B8CLvyqgOi9nQVWfmtpa
         g7OTYQmFyWHfNRi84SbGLomlIFeznsqEuCuvCCsg/vRDeYH/kz9EzAZUJkpXQ4V7tj+N
         ho31L91fwHY2Cp1Nj2Eo+gBTwBg8Bef7HOAKBmsjV6h3VUOeMNSlYxnGgLHJ9B+ES1TV
         0/pRLlwXy9LrahwewQ2T514qAejXg/QPR6acDxoS/kqLhrWuwBpfsethuKvn1Baz0qG1
         bp5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUND0EaOLQygtZB9sPZjG5U+s3XzVCHmt8ufBd4oAPv2tcJwJ/7RahQd4LcktwlS3NY7by7xrdEp+I/V6wKP64cj1LCxloAbEgbSXWg
X-Gm-Message-State: AOJu0YxNGVB8KI7pA7blC+18vmgI+P4d2WVwS4YCdw9kjsQ0XBHqlNx+
	RdBBGhdoTYzmEjkdhHO4t1I8LBgxV/wSJ1fx6I2BdJvmt8Or3qJDQZLNS7ZCIF4/Jq/7ZGIuJrE
	9Li9+/xOeUpImutvd6fKTch7yqeYOlHTss3gC
X-Google-Smtp-Source: AGHT+IFxZAwM5lscGOOxViCGPaFGQ6+rp1WtH1LHvLtTGxM3d+4WQ+OijdKn8+T80A2LN6pU7d0HQjw/vH20HZ1YHlY=
X-Received: by 2002:a05:6871:203:b0:232:fa6d:c5bf with SMTP id
 t3-20020a056871020300b00232fa6dc5bfmr89066oad.45.1712855176417; Thu, 11 Apr
 2024 10:06:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240409061043.3269676-1-debug@rivosinc.com> <20240409061043.3269676-9-debug@rivosinc.com>
In-Reply-To: <20240409061043.3269676-9-debug@rivosinc.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Thu, 11 Apr 2024 17:05:38 +0000
Message-ID: <CABCJKud622jAHZGiYed-2veynA6rd_=1mnTwnTT1WNQ6203q6A@mail.gmail.com>
Subject: Re: [RFC PATCH 08/12] riscv: dynamic (zicfiss) shadow call stack support
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
	paulmck@kernel.org, broonie@kernel.org, rick.p.edgecombe@intel.com, 
	Ard Biesheuvel <ardb@kernel.org>, Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Deepak,

Thanks for the patches!

On Tue, Apr 9, 2024 at 6:12=E2=80=AFAM Deepak Gupta <debug@rivosinc.com> wr=
ote:
>
> Adding support for dynamic shadow call stack on riscv. zicfiss ISA extn.
> enables protection for shadow stack against stray writes. This patch
> enables scs_* macros to use zicfiss shadow stack pointer (CSR_SSP) instea=
d
> of relying on `gp`.

CONFIG_DYNAMIC_SCS implies that runtime patching is used to select
between software SCS and an alternative hardware implementation (in
arm64's case, PAC instead of hardware shadow stacks). I understand
this series is still an RFC, but I didn't see runtime patching
support. Are you planning on implementing this later?

If there's no plan to actually patch between Zicfiss and SCS at
runtime, CONFIG_DYNAMIC_SCS doesn't seem like the appropriate choice
and we might need a separate config option that still allows you to
reuse most of the software SCS code.

Sami

