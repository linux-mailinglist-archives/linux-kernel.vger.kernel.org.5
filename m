Return-Path: <linux-kernel+bounces-133564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10BAB89A5AA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 22:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD0AA282D43
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 20:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA0A174EEA;
	Fri,  5 Apr 2024 20:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a/EVNn90"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8B91C6A8
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 20:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712349021; cv=none; b=K+zYx14e6CejUSb9JwQiOIc6a2IdC6HOLr44hoYmYzeXJGD12RBqMp3Yy03/KJOz8CM1wF11rTLe5psm75kduAyqzJJpKAd1gbZnmrEsVa0p1GbAz0p1i79JFEwuCnU6F70LqjlpNFMUOJ11NOvzFDHSA9jpf4Vjmi3Y5RRoYvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712349021; c=relaxed/simple;
	bh=nV9Y5sZu3ZPCtOva3EsmstVhIY4akSsXCrbWmGpcqII=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UoWaT2bjggaE2/7adqswUTkmIugxsk5iM5zIOcfOy7IUEEx9qq0mDy34ithJ7yUBxMdqoTfqU1Ah4gJuKGwtWTzB3Z6fB8Stp613X8dLFEzdA5KPymFsEYegbKhrcMalv36T1hg6uC6LP+4vhnn9rQUJ7orEWDzzMAdhVubn64A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a/EVNn90; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-516c97ddcd1so3198366e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 13:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712349017; x=1712953817; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M+jEmOFEjTU7lwjjt1V5FPrXRPUYL1ukEXhP8ohspNk=;
        b=a/EVNn90WRiXj9Vw0QiTi8Q6AErYMnjvoCvIFDXeoV3Xy5iRGFT1jHIlKhwgl5YyOh
         YNWctOY2eOqx+dT053BAiWSYDrOrhWVX4C3iDbdDwkjpIvVTr8OX0Umxhc5/Mpm9Wu1D
         jW+4j/LOI4coMyvjrX17DhRv0X1zH7UFjLfb3Hy+4ckwf5eIv6Kv0n5r++H/ydniIFkD
         h7tTa+ugZ0o1yGrxPkjCj3aDnkdAp6BDfrO3bnt6p5pk8rcMMw8tOq6yNXipiFK0ANsq
         tiFQFXk+6Bwzd72jihCiSZota+UB8dtKKfck1yMwIMCAs3IQPg9KHwjuWfyHUQ4hePeh
         ip8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712349017; x=1712953817;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M+jEmOFEjTU7lwjjt1V5FPrXRPUYL1ukEXhP8ohspNk=;
        b=vyvupwbr/sWd2EybnR0EWq9vI8s90O2pKilqBU1EuYLAuzB7rU7JInoi7Va4uJQspV
         T09akuafCU06cZRNSpS8O6Rc0Qb1GueljVpJ1VxKw6EhA2PX7FC7+pEUw9xVh0oaFJ5w
         V2snjjB+LXpXnRD5v7Bt5gokR8ysmXQZqwHjmbPckfFZqG8EdZVgiMOnmuIMFaTrecU8
         uY8jWWY8y4gtYIjQQfNb0Nssffpwgi+Ut2riXaIsVLKDNJEI7ICVeV83FZeCmW4XAkUM
         GMmPhknqnSB/9g+8mTW8cCTJtVioY/snuXrP6hMS/GLtvUCnKsb+J5MmvsDlztwpULUf
         UfwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVG3nCAoKyjWVpeCs2zkCohZBqZPPtvOOEAp3D4IaGkgNhE/67ZZllLMwQQZ4LZev+DeNwxSQRQhYzQSNnptQvltlMki6Jy1mBw+Nr/
X-Gm-Message-State: AOJu0Yy7/H5GgtStMYZ/+iW+KtrJwnA47TcAjHOBo1Vuvm/2SKaLGb5p
	QweRQgMLuNnJRs/QhAl6/bUw19A80h9j/6xedU0SjK+u811o582Yd5NLDOlI8GIOk8f2DBr/Ecz
	C9LueOxmC9+b+adSr4lm5zBaIAXjCw5kfkW8I
X-Google-Smtp-Source: AGHT+IEctCIw+qSiNBMbysTxNZa7FXusQuq+U7LwmIXIiKndMkDSxEkCWBXPlF0xCd7GX4Brs7t/yyuAjdtpKpywhjM=
X-Received: by 2002:ac2:5964:0:b0:513:edf4:6f20 with SMTP id
 h4-20020ac25964000000b00513edf46f20mr1622327lfp.54.1712349016554; Fri, 05 Apr
 2024 13:30:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240405053510.1948982-3-yosryahmed@google.com> <202404060445.zMPxumi9-lkp@intel.com>
In-Reply-To: <202404060445.zMPxumi9-lkp@intel.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Fri, 5 Apr 2024 13:29:38 -0700
Message-ID: <CAJD7tkZ20wwnM2PXTUS+VMvEXcNU5xrpBCjs4LT=Ds0gLpopLw@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] mm: zswap: calculate limits only when updated
To: kernel test robot <lkp@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, oe-kbuild-all@lists.linux.dev, 
	Linux Memory Management List <linux-mm@kvack.org>, Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 5, 2024 at 1:24=E2=80=AFPM kernel test robot <lkp@intel.com> wr=
ote:
>
> Hi Yosry,
>
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on akpm-mm/mm-everything]
> [also build test WARNING on next-20240405]
> [cannot apply to linus/master v6.9-rc2]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Yosry-Ahmed/mm-zsw=
ap-always-shrink-in-zswap_store-if-zswap_pool_reached_full/20240405-133623
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-ev=
erything
> patch link:    https://lore.kernel.org/r/20240405053510.1948982-3-yosryah=
med%40google.com
> patch subject: [PATCH v2 2/5] mm: zswap: calculate limits only when updat=
ed
> config: i386-randconfig-061-20240405 (https://download.01.org/0day-ci/arc=
hive/20240406/202404060445.zMPxumi9-lkp@intel.com/config)
> compiler: gcc-10 (Ubuntu 10.5.0-1ubuntu1) 10.5.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20240406/202404060445.zMPxumi9-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202404060445.zMPxumi9-lkp=
@intel.com/
>
> sparse warnings: (new ones prefixed by >>)
> >> mm/zswap.c:132:15: sparse: sparse: symbol 'zswap_accept_thr_pages' was=
 not declared. Should it be static?

Yes, I already have it static for v3, which will be sent after the
discussion on this patch settles.

