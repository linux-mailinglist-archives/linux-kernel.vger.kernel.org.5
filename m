Return-Path: <linux-kernel+bounces-129299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B351896854
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46540287CD0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 08:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1ED13E6D0;
	Wed,  3 Apr 2024 08:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="K4uUM64U"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118D413E6B6
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 08:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712131845; cv=none; b=WEQ4yAoGaTgPRUFo8y4o8gSQyX+Ch0qx0SESkGD3JvWQi8Kia2SzQPoVKtBpdsPs/mwnqvyBHpB+qF+NvmQ9qh2w7BI3DPw4HUBF9hL8ty/afueRbX7fzD5naqzZNwh97yZyGY8+x88MQXD5IxijKdt0Hi2d0sgX7aWnzw+XZx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712131845; c=relaxed/simple;
	bh=JQej1iAsVr2TqEOU6xUOK3SA6orz4U3TJduit2FBqSI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FCjVYMah+qf2hA6Grgd1C0rKoQJDPkm++/sA4jMT/1ArD3KNBbVKMVd66UqwlE79MYfTh9/9P/vXBOMMxOM7y8vXDqbGGeLL29AVtUWzl9kmY9rCVjNUnCfRHEu0SCRDrUbItgzJzGpvkAVGSiosyD96lB+auZaoQSmht/5Q530=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=K4uUM64U; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d718efedb2so91768441fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 01:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1712131842; x=1712736642; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gqLYHHBoVd2DZSBiZsMfamZXMWNtMZVCVqKJsSa6oQo=;
        b=K4uUM64UFlfgANoIJWSvhYSvkEGVOob3LufjwZUSk+PZ8X+ZDF7hl9ZQQan+UQ5c/F
         PcbZEj26LsIobyR64eR6UI294DnaUqF8DaKlQD3T6F9kyrcBT/aB+MAhC3HWPMosZJrp
         lQq+znn05uQjN+yX6KCTkzA/MxpdrK1C5/V2HQIJy86i5WpN09rqw40luZkObXTAyNnh
         7lJCHmGbYuBUsRIIPbLT66Q7E8Cfi8itmj9RxGeybI8LRpoTNNPlOYWFCfs02jzP2M3X
         zGuDubfqgfQdcmIVUWR5KhqbZSHRaF9YlyilHUc0IsO8j24nwNhkycXTUZhwkd0RUSm8
         Ojzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712131842; x=1712736642;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gqLYHHBoVd2DZSBiZsMfamZXMWNtMZVCVqKJsSa6oQo=;
        b=Ivwuk5bVO6mTAtFa4YRbFjNKAbxbiMicL3bS4RikmW/iP6eR4lB4/rKTt4RC4z9QpG
         GNOU1j6NhzgbSN4YzTwmj9/f5BTIyNVdPt48enp1ny8WAQqxzUFMDWQuNq3ChDooqxXF
         IAlKr8npUg576g8SxjKi63j1HGv9+1gghBgU6hFxhRfTGEQ73529s4U0OZ9rtuVUGJFH
         WXSRap5Zn1KX3SBB3yt5xbdJNSSIHnZxLD1IFR3xJcGFUsF92MmB80XZoZqHFY86o6cC
         v5jLmXX2Kg82kaENLc1tHlWqYHlrxfpIb3jOXF/KzcRnXWF7+J/57CiR+LVplAbEcrG7
         WciQ==
X-Gm-Message-State: AOJu0YzyDghMPRVIW/1GkZjdkGUT38Oymp8MbWfPYI9sq0nb5ZWEvhPk
	7t/SQKKqmRz835fJNC+M5TpDa22/HTuWWMlAhNxVqzllkYnzyVdItIibVg9BL1DUFAopDLx1tvf
	9nwajhcNEs32pYitQ2RcLmbJKbu7QH5vdcjZ6Gg==
X-Google-Smtp-Source: AGHT+IHPLv/xQnUbFIUE+E5TYWgeyNX14zVo3bYPItcgeCHpJd9YtvoRLtdQKSVHg9o25tQy5l1Xqdog/FZOgL7D2E4=
X-Received: by 2002:a05:651c:503:b0:2d8:2766:d66b with SMTP id
 o3-20020a05651c050300b002d82766d66bmr3707003ljp.3.1712131842238; Wed, 03 Apr
 2024 01:10:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYtsoP51f-oP_Sp5MOq-Ffv8La2RztNpwvE6+R1VtFiLrw@mail.gmail.com>
In-Reply-To: <CA+G9fYtsoP51f-oP_Sp5MOq-Ffv8La2RztNpwvE6+R1VtFiLrw@mail.gmail.com>
From: Anton Protopopov <aspsk@isovalent.com>
Date: Wed, 3 Apr 2024 10:10:31 +0200
Message-ID: <CAPyNcWeu+bzyQg9S3wDb43jbfk95Su5XcSRFPzUbS2ofZ=+5Fg@mail.gmail.com>
Subject: Re: include/linux/build_bug.h:78:41: error: static assertion failed:
 "struct bpf_fib_lookup size check"
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>, Arnd Bergmann <arnd@arndb.de>, 
	Anders Roxell <anders.roxell@linaro.org>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, David Ahern <dsahern@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, aleksander.lobakin@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 10:03=E2=80=AFAM Naresh Kamboju
<naresh.kamboju@linaro.org> wrote:
>
> The arm footbridge_defconfig failed with gcc-13 and gcc-8 on Linux next
> starting from next-20240328..next-20240402.
>
> arm:
>   build:
>     * gcc-8-footbridge_defconfig - Failed
>     * gcc-13-footbridge_defconfig - Failed
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> In file included from include/linux/bitfield.h:10,
>                  from arch/arm/include/asm/ptrace.h:13,
>                  from arch/arm/include/asm/processor.h:14,
>                  from include/linux/prefetch.h:15,
>                  from arch/arm/include/asm/atomic.h:12,
>                  from include/linux/atomic.h:7,
>                  from net/core/filter.c:20:
> include/linux/build_bug.h:78:41: error: static assertion failed:
> "struct bpf_fib_lookup size check"
>    78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
>       |                                         ^~~~~~~~~~~~~~

Thanks, I will take a look today

> Steps to reproduce:
> ------
> # tuxmake --runtime podman --target-arch arm --toolchain gcc-13
> --kconfig footbridge_defconfig
>
> Links:
>  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-202404=
02/testrun/23264362/suite/build/test/gcc-13-footbridge_defconfig/details/
>  - https://storage.tuxsuite.com/public/linaro/lkft/builds/2eWtBPKv1yM8gfZ=
JC8GkEkxN2j8/
>
> --
> Linaro LKFT
> https://lkft.linaro.org

