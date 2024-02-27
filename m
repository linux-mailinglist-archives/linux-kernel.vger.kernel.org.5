Return-Path: <linux-kernel+bounces-83876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AEB2869FCD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 20:04:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 988C7B2A25C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 706FB14A081;
	Tue, 27 Feb 2024 18:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d0RXiuux"
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4DC4F896
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 18:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709060234; cv=none; b=Sr44M1h4e0+DDxYvwpA7vYKkBYD3oBqgPRYD70Nr6Skj1CoRpbjtgCVv3Ou62inIi1dpEgFGzgIRH9ZDjpIywWayIGcnPxdO6er9sgWo6M+MJcrB0HZogE/PT1mlDgoyLnzWbXCjKeLj2oM5fX1FrpcvxLpwWMwDGJljWLnQ+AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709060234; c=relaxed/simple;
	bh=7bDI1xqKClmZu2LPydV/rKtOY3Pk36/Y/7eFyMlkBAo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CFZvqpWsOxN72LoLlGM4PhCy8Ky3z1AKTcJOZXMC95Av2rEiVM0nsPgOzirRgcqlznGViyo3cK2VVn+YqCg7btGz+OPtDXujqPSyDq9ojlFhTE26rcNwcX+abZTloSL4G/rKCGEkIUPHSa8fD6mclCn5LIbAmy1SH2sHOikqlvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d0RXiuux; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-7dac7cfbea0so193689241.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 10:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709060232; x=1709665032; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7bDI1xqKClmZu2LPydV/rKtOY3Pk36/Y/7eFyMlkBAo=;
        b=d0RXiuuxe2LdK+dWXitetYxezIqjAJ+StcCpW7nJ30xWymwgfMaemXy+BHGxmYKnfe
         Xd4IuckLq8MiRELjlXy3UteqxdQ2V1XMXa+iycrMw710egDZRBHOrETs+HKu7+XcAzm5
         UoN4/ThLC5vBaKZ1etJ4LsAd9Gjtup84fj3ZqQp3Ce4pNlS3M4OP0ec6ZlxSEkWCiwVQ
         TLtG64P7YPjJ+LALK6zgV8Kd8xrCL4A3gCnqcJ2sZhbPqf0ZlWMJ4Lq2LgN6/hsCa5sr
         L870zH+T9A+izH1QN1QPdaasj6GONn492iwq92W5nh4LWDRKvFd6jJytu+mPenfEbST9
         rtdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709060232; x=1709665032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7bDI1xqKClmZu2LPydV/rKtOY3Pk36/Y/7eFyMlkBAo=;
        b=NQBMoGTtJdYZAd4CuFfo5gPiuDslitF6gLCu1XKzqbLcGlWFqqINlTvsvvpgQPh6/I
         zbAvPOOGAU7BGhQF9pQGQ17f5VkXlQJHfkJsrgTho1mMwhtU4SS00TpKST9iG+evDWyL
         qRhgVXGkonrQOcm9l9a6okkK9DFK3jIVObGobluAg2XBIzn9vC2ZEtFFehybs+PzLW6e
         s8c7ww479q/USNO/YnVG4atUhMcOP5qc3Z3na2O1fShou7BG9JNAyIKvHXC5PSmdB6IK
         MZNbL+QDKCh6xQLfrJadhGNPFVGnAjd9nD2OpUdf5dqT9fwVjkrKXRhKshdsAjT9QrPc
         Nt2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUmmDczWksnqJCVokfRhBRqnhhbdFHoMA0FamMGtEWXgkDqefmAMsEB5Ul3ZJOUu8fIvaCjL/Ksm2JCu4G9VeTHWnmlaoPX6n1oMqfO
X-Gm-Message-State: AOJu0YwL17/Z3zUKLvzsAgr6gMBd5Q2p03aJNCxSacCC7nPLWVPyRZdZ
	n6ky0IHkHHMS45AO+XaNfbfS8jYDc7JylMurVHHzrMCcpBmUARvz558BPgWmuZYR1IOGBpyOsf+
	j/V3ZHS+Revuwatzo/0bLhGIiH5k=
X-Google-Smtp-Source: AGHT+IFI0YgIIOGA9JXPsfi6w0tZFAzpyfy2Ov7owXRmf5vfZnvBgPfma/FnOvSe9vaFciOzIzi2AJpgR+oux7j04jg=
X-Received: by 2002:a05:6102:f0f:b0:470:547b:6f98 with SMTP id
 v15-20020a0561020f0f00b00470547b6f98mr10672145vss.18.1709060232084; Tue, 27
 Feb 2024 10:57:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231025144546.577640-1-ryan.roberts@arm.com> <20240118111036.72641-1-21cnbao@gmail.com>
 <20240118111036.72641-7-21cnbao@gmail.com> <3a3461fc-4b30-4ba1-94c9-c048d08d40c0@arm.com>
In-Reply-To: <3a3461fc-4b30-4ba1-94c9-c048d08d40c0@arm.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 28 Feb 2024 07:57:00 +1300
Message-ID: <CAGsJ_4xFgcf8+ZqKUqQ3gQt63JXtn-VifAk5mTA6dopYvNqGqA@mail.gmail.com>
Subject: Re: [PATCH RFC 6/6] mm: madvise: don't split mTHP for MADV_PAGEOUT
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: akpm@linux-foundation.org, david@redhat.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, mhocko@suse.com, shy828301@gmail.com, 
	wangkefeng.wang@huawei.com, willy@infradead.org, xiang@kernel.org, 
	ying.huang@intel.com, yuzhao@google.com, surenb@google.com, 
	steven.price@arm.com, Chuanhua Han <hanchuanhua@oppo.com>, 
	Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 3:40=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> On 18/01/2024 11:10, Barry Song wrote:
> > From: Chuanhua Han <hanchuanhua@oppo.com>
> >
> > MADV_PAGEOUT and MADV_FREE are common cases in Android. Ryan's patchset=
 has
> > supported swapping large folios out as a whole for vmscan case. This pa=
tch
> > extends the feature to madvise.
> >
> > If madvised range covers the whole large folio, we don't split it. Othe=
rwise,
> > we still need to split it.
> >
> > This patch doesn't depend on ARM64's CONT-PTE, alternatively, it define=
s one
> > helper named pte_range_cont_mapped() to check if all PTEs are contiguou=
sly
> > mapped to a large folio.
>
> I'm going to rework this patch and integrate it into my series if that's =
ok with
> you?

This is perfect. Please integrate it into your swap-out series which is the
perfect place for this MADV_PAGEOUT.

Thanks
Barry

