Return-Path: <linux-kernel+bounces-62942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 502AD852833
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 06:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2EEE285882
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 05:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E07D11C8B;
	Tue, 13 Feb 2024 05:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MVeF1qwS"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA79F11725
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 05:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707801638; cv=none; b=qczTCSOJLki1JZpiBg1UqIz6MevxZXMU9Ci7JdKUxm1fZy14BTsn2GIbUzVv172zAtR7blKNhHeIJKisX4uDM+TfBAcMxubYVc4juwsBY7T6oPBI0xI8rOZpd8d70njyJmZTlvz7r45+WISNBKBuYzkosOmMGQh9Ls6ExU11Mg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707801638; c=relaxed/simple;
	bh=6UxNgBbLmEd9k8EtkUtoBRblPssIxgoKWBIO4OHyBlw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ys9l82n4Zod1sa+kwIpynl9xJg5B/qWRtcj+CwkfwQKen8uCHcSgw9NM6FrSS3QND0a/EIclKI2OTH0FB8gKJZqCkVYz1KftJbqWPyq9rezZOAEhNtCvVRDyqncLeTphQgd/Yimp5yJgmHnbfc7YISYAPUNQGVv6MnilwO8WH6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MVeF1qwS; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40f0218476aso23355e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 21:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707801635; x=1708406435; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jsA6Vin23ehyR7Ij/sBXeXrDTbKj+YLFziDzOlAwThM=;
        b=MVeF1qwS9Mu2eFkSSW1/CQZo96kHekDmB0UuB0K8zVnlu3iNEi5hrBiRTkBlJy7e9q
         F6ADhSAAInm1SUHDiwM7QbrJ7FjYAPOUcWMqnDOHv9ooFB8euOrw8AbPthAzvoRTCti0
         9OKT5tz37SjrUhvik7gjkJlaGdXYlXLVQaHVc8Jq8zFoPbeb2wtwjtgLH35AdabNNt+3
         uFbo+UQb7bsg8lhfb6GrFCrxAUxm19nv4eIck0VMh/qs5PFE6K179/0R0Hu48WU6eTo8
         AdnBktQlbZOo88cjMWNePMJ4QbNKoj2QxB8Sp6xpRcffsyBLRcWON6eroGtYZQZ2Bku+
         Mfmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707801635; x=1708406435;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jsA6Vin23ehyR7Ij/sBXeXrDTbKj+YLFziDzOlAwThM=;
        b=jLNDJtrWOiOGURjx1jho90dydVcYikgdC6zXW2PBaZz+3osyedgMe310+8JeVRlGBX
         PVaGF9pGSEFQF2RKy9bdlsuZ+0kM0WTzaejxp8LPrH9ivCk2oXMrjoSBP5G0PzFvhLxj
         nIEwxNCb+p6Vbqujmo4IsMI/EAN8Eg4bgJDnS9tEMyGcjFY1VPW0RvogkvABioNxJOgK
         y7b60HA8+cRSzZgQUzefp6JBAhgC3RR/fuojm25q7nzbhaS6HROG/BTIXD5k3KGFPevs
         Abp9dCCR5aI4GQrNm5twtLZwVgXSwPVNjNTMsO/EXlp2/xhfmIYkwNh9NaIWGWmnYN7z
         nP0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVXdHdJjb0wobOCmfS5yeeuyU4Qh5JugBNRoddavhfAzgAJtR0w3TotaVADIQAWZ8/AXvMQMvgsSSnmGQeOVMqOei5V7KE5FfS4FhMC
X-Gm-Message-State: AOJu0Yxd0FFcOTh3NuWMAe3b6DD7Udw5EeZlKixgqzRMIdwjlqk2mnMn
	nfhrRKSfHheQODNt6pPMQLiqRBl3nidCrhCs0sMuA2BfKQnNMM4DlEl3S0gmlS05wX7C6bpRxez
	50C7p2z9yQpnxw63fUkY/NgJdpAKtubaqgvSP
X-Google-Smtp-Source: AGHT+IHFi6Ul8/IpSL5dH9UF36vlNNuEWfYaVHz0ux89RLv8jLsict9IUa3/bcTp+oAhjprbpCQkEDOI202dHtcpqvw=
X-Received: by 2002:a05:600c:1d92:b0:411:c715:667 with SMTP id
 p18-20020a05600c1d9200b00411c7150667mr1145wms.5.1707801634918; Mon, 12 Feb
 2024 21:20:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207-s390-lld-and-orphan-warn-v1-0-8a665b3346ab@kernel.org> <20240207-s390-lld-and-orphan-warn-v1-11-8a665b3346ab@kernel.org>
In-Reply-To: <20240207-s390-lld-and-orphan-warn-v1-11-8a665b3346ab@kernel.org>
From: Fangrui Song <maskray@google.com>
Date: Mon, 12 Feb 2024 21:20:21 -0800
Message-ID: <CAFP8O3LhKW4Cg5LQQVmAmFtT4Psap+izrDV+6Bb1zp4yC1WrNg@mail.gmail.com>
Subject: Re: [PATCH 11/11] s390: Link vmlinux with '-z notext'
To: Nathan Chancellor <nathan@kernel.org>
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com, 
	borntraeger@linux.ibm.com, svens@linux.ibm.com, ndesaulniers@google.com, 
	linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 4:15=E2=80=AFPM Nathan Chancellor <nathan@kernel.org=
> wrote:
>
> ld.bfd defaults to '-z notext' (although it is customizable with the
> '--enable-textrel-check' configure option) but ld.lld defaults to '-z
> text', which causes issues with building the kernel due to the presence
> of dynamic relocations in sections that are not writable.
>
>   ld.lld: error: relocation R_390_64 cannot be used against local symbol;=
 recompile with -fPIC
>
> Add '-z notext' to avoid these errors, as this is expected, which
> matches other architectures.
>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

This follows arm64/powerpc/loongarch/riscv.
LGTM.

Reviewed-by: Fangrui Song <maskray@google.com>

> ---
>  arch/s390/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/s390/Makefile b/arch/s390/Makefile
> index 73873e451686..994f9b3d575f 100644
> --- a/arch/s390/Makefile
> +++ b/arch/s390/Makefile
> @@ -15,7 +15,7 @@ KBUILD_CFLAGS_MODULE +=3D -fPIC
>  KBUILD_AFLAGS  +=3D -m64
>  KBUILD_CFLAGS  +=3D -m64
>  KBUILD_CFLAGS  +=3D -fPIE
> -LDFLAGS_vmlinux        :=3D -pie
> +LDFLAGS_vmlinux        :=3D -pie -z notext
>  aflags_dwarf   :=3D -Wa,-gdwarf-2
>  KBUILD_AFLAGS_DECOMPRESSOR :=3D $(CLANG_FLAGS) -m64 -D__ASSEMBLY__
>  ifndef CONFIG_AS_IS_LLVM
>
> --
> 2.43.0
>


--=20
=E5=AE=8B=E6=96=B9=E7=9D=BF

