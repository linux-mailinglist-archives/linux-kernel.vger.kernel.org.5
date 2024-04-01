Return-Path: <linux-kernel+bounces-126746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1822F893C3B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 16:32:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49B061C2144B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 14:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C6F3A29B;
	Mon,  1 Apr 2024 14:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cmzoixu9"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F6F446A0
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 14:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711981922; cv=none; b=Jz7x/AUE6Mpox7WqOxv8LDY+feg59LFyXMi0Ip/3921OHpvjQ+2ct8Sv3OFxImWAdHgXm0sadYS7lnGADI8ihlBGkH1JgRdRCGEJAsYdnaWPFF7uDL2+zA9/86uKZLBVa8enXJGmHraY8A79LGWIbQlwvOoYV2zRJBMLB6aekSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711981922; c=relaxed/simple;
	bh=1KOTRfdlb96wg3JQvEVXeDDrjwIrXhXgqbZ+oZikD30=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SJAPzQoZkLTU+rgFP7qB9PdvAhrubNjl5zHpCMki9V+ySwvu+GYJ9cxiL00tFlc1JlJK3PgRVy+ztV1lc+PcqSg2I8NnufQh5z1M/gjLcXum3Bl8sR+8BjSItv9fPdhQn0qLJJrpV2zH29Ja4z6djlgtSfsSjNzH+B3a4qDISBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Cmzoixu9; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4154d38ce9dso187255e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 07:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711981919; x=1712586719; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1KOTRfdlb96wg3JQvEVXeDDrjwIrXhXgqbZ+oZikD30=;
        b=Cmzoixu9AMLpk2V/m/xqSRu4jmcW3CLSkFga5nbQa7W9AMmdrReCNkJ8i22vNDY1VO
         +BtKsJ1Ml4NSFpUVUuSHD4oVrENl0+1FesO1ZskCpk57M66UaS6W/gWxMJ8sf2T14XA3
         ZABuPBTT8KjkLw88sHsXRkQH6JoWr3HrmkandYkuoV+IL17xBv/tQKMl9+ChuhuHI51K
         xXvp/mIwIe4JOL75X+DMUIYIKI5ZaBc1UbCCvN4fApGw7G3Bzdmx7gNFvgYuLaMg4BRF
         NufAZA9vyJbnZJGcbSvfH2CTsVrJqncvPluAI9P/hdQT1+DdRpELQP9tusSgb+Jc0s6K
         pMsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711981919; x=1712586719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1KOTRfdlb96wg3JQvEVXeDDrjwIrXhXgqbZ+oZikD30=;
        b=Q62SaFOyhCkSoTtOgHFqPlO1FGiirgTFcW9n8E9/Q+sNluTJnZINY0wLcKnJjJN8hm
         wOeVqJlpS/rmhj/GskWxExMcQY39Mxcumh7Nytd2g4+2gB+s8RatjGG0rxU0sOlnPYtD
         fnphT8RK6JKOcvSSNQApkVi3WsGmA45BjXPrxBXFB92efFMTrV2BMApF42H+JQIpaWrz
         Ri9Apl+d3zwaVhIQqIY6XcE1qNlFuNZcsd+ViUfP+mYyIR+xBkdRdIlX3Gar/hB1020m
         Ksd+0rWn+pffxCC30/gN2Rc5EE6JfpTLAC0Wdydj0Jq29psJHHTAcqf8tBQNRqN/kiBL
         TP7w==
X-Forwarded-Encrypted: i=1; AJvYcCWZTRz9JsEm4WB0B5c37ZqT3hgNn5zhHmEXwSZH3yyK63WWFtrTyyqW8lz92MWfzT6cGl/uzKDa8MC2zvVev/XJUQ162I1kRCG/aQq3
X-Gm-Message-State: AOJu0YzMKiNGIG/ef9LpAxfeK9QM66iC/2Hg84wh0noZlgWEPZorQ+pl
	4MHhrxBeifpAjG4Tl0LQYJut+qfJZbhN2Esay0hAntEMB2Ap9ONEmtpn8yr9vR5JwY7DwM3sdQP
	0a2gl2xhtPDVgOhm1V55HH6AA5UX9Sf5j4XtO
X-Google-Smtp-Source: AGHT+IG+u23aU1rXzBPhKteiMq1T1djcdv7lhCX1QEg+e0SJ7XlBGeCeRCs/T8iztgcvI52c5nLJlVws6uRQkVJeEO8=
X-Received: by 2002:a05:600c:4754:b0:414:7f73:6158 with SMTP id
 w20-20020a05600c475400b004147f736158mr566112wmo.4.1711981919221; Mon, 01 Apr
 2024 07:31:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329073750.20012-1-21cnbao@gmail.com>
In-Reply-To: <20240329073750.20012-1-21cnbao@gmail.com>
From: Yu Zhao <yuzhao@google.com>
Date: Mon, 1 Apr 2024 10:31:20 -0400
Message-ID: <CAOUHufbPAAY5WqcxZ8qk2DPG1Yv_Z6iSg6BC_YgfdRJLb+YNDA@mail.gmail.com>
Subject: Re: [PATCH] mm: alloc_anon_folio: avoid doing vma_thp_gfp_mask in
 fallback cases
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, 
	John Hubbard <jhubbard@nvidia.com>, David Hildenbrand <david@redhat.com>, 
	Alistair Popple <apopple@nvidia.com>, Anshuman Khandual <anshuman.khandual@arm.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, David Rientjes <rientjes@google.com>, 
	"Huang, Ying" <ying.huang@intel.com>, Hugh Dickins <hughd@google.com>, 
	Itaru Kitayama <itaru.kitayama@gmail.com>, 
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>, Yang Shi <shy828301@gmail.com>, 
	Yin Fengwei <fengwei.yin@intel.com>, Zi Yan <ziy@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2024 at 3:38=E2=80=AFAM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> From: Barry Song <v-songbaohua@oppo.com>
>
> Fallback rates surpassing 90% have been observed on phones utilizing 64Ki=
B
> CONT-PTE mTHP. In these scenarios, when one out of every 16 PTEs fails
> to allocate large folios, the remaining 15 PTEs fallback. Consequently,
> invoking vma_thp_gfp_mask seems redundant in such cases. Furthermore,
> abstaining from its use can also contribute to improved code readability.

Acked-by: Yu Zhao <yuzhao@google.com>

