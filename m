Return-Path: <linux-kernel+bounces-58983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 638B784EF60
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 04:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 848491C2394D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 03:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79E15221;
	Fri,  9 Feb 2024 03:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0YDOK4By"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863324C90
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 03:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707449266; cv=none; b=L2suIODsf5RIoPEXrcyE0oqnbLsLuOCxZBX1LDCVFPm/IJn65q8ujhNmw4dIlAectuWYpHosztaO+88t8iUEX6uV6X2/TwvL5DMeU7Ykk2Ld8OOdnHr1RLI+5IuIVsB5wzLYBuJCJJWp5x45fQw+VDCd6q2Mb/fJFhShpBM1B5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707449266; c=relaxed/simple;
	bh=CnzXbLP8fwq3ByoC/2D+hROvO4S4gKJoV+4iyJuc2MQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=fdlgVYqWKNfDX437G8rS2+HdaE69XVGjaxNg0kiYWjBKEIoGKgYRmRyLyL3/NNlrQTurkLLj63n+E8ZUhVldhDe7KlBhfphMOxAFefwvyWYz+/RVg/BkfdlnfMTjAsS0LiuLRhA+CyvxrooAXbwsfgd4WZFbyvLrOax7tOrphK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0YDOK4By; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a3122b70439so55461066b.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 19:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707449263; x=1708054063; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sa0RzQIqD7432NEO+GqK+/rOERGjcn66Rl0jrulcCc4=;
        b=0YDOK4ByppcNqpVZXzjRMxomUlR/vojudAIQ2jrTVekZbM4BmAPYmqDvS/eScPAy8h
         XxQMG/dSVnSiCi+vhVy0DBUAn49ppzKZESKK5REE9VXiehiAE4IxTwpKpfQIxtEvFg82
         PVTheA2KXSbsVc9mHtdrgFopupyLznpKYZjgNBCo3WmiD3GsolLn11a3oPJYFY9yWfcC
         c7tMEZmNjcLhLZjQ6eACNKyd7HtQJbp9bw7hcfQnI5x+VAaCsT9RVcSkUMNNAPyOhSbi
         9eYgPcxtJHVNF8SfaBj65I84gjGPuDOJS8H22zWgMFgx/pqr29mDe+pUxZYUwfjfSbTg
         zALQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707449263; x=1708054063;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sa0RzQIqD7432NEO+GqK+/rOERGjcn66Rl0jrulcCc4=;
        b=elENMJqrpY6GDT3ZurXmiqa1j2ZrWr4PRHTscNSTCwkjCdjC4nOs/996sV+q+k3qFb
         VdeNXD7nsHiYedCDiLr0HpMlhfcjf4oHeoiF/WY4MB4F3XBS/GaXAjutadgnGGtCgOFH
         wY7HTTyLt+i3NHRpGPlDqUdK0XSJcNAWpe/wIZlEOUfvtHbeppnqsXbMgA+56mPqlnnz
         xuiMgkqEwBk0tLr2Hc1kAZkLmhuaRpvp21j+97ATJBczXns2U2PwxNIMrvFpnPPCxieG
         4nU5cuPUqeXiqhgGEIJFwpL3wh52xaR7luSJL8ACibaqVYdPVD1bu9FgEW2/1PXtjbIU
         3j7w==
X-Forwarded-Encrypted: i=1; AJvYcCWRBDfCin6WHhdFec/qHIYZr7ZQ4ILz18D/zGJpG/2PH0VXhuDdvkHidUFgkmxLD7fUtiQRo86vuEJSzd0AZFwvcH+188NdfZ5t/5rC
X-Gm-Message-State: AOJu0YwYQZSRRs7zHec8jAXDctt3AR9q052R3dJqmvasKg8fHh8nrtVx
	8b/8HTG4brL2rPiDfGIX6io2K9qgx720+WpiZmMNmP2Xo+P+tyLP6AKD5HjUDuIE/lKcEw+gYRm
	0iial8HUpEnmhldwRqN3AzDPRfW0tXnDWzBV7
X-Google-Smtp-Source: AGHT+IFR4RXUL3ZbEyvEO8UE3u9ltGV+aRD30/6Yu4Da6g+mhUubiJzFvveg91GR1oL3ZZ9XnxowGXWxMsI8bzKZGac=
X-Received: by 2002:a17:906:34cd:b0:a39:99b8:1fba with SMTP id
 h13-20020a17090634cd00b00a3999b81fbamr167011ejb.56.1707449262594; Thu, 08 Feb
 2024 19:27:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 8 Feb 2024 19:27:04 -0800
Message-ID: <CAJD7tkbRF6od-2x_L8-A1QL3=2Ww13sCj4S3i4bNndqF+3+_Vg@mail.gmail.com>
Subject: [RFC] Analyzing zpool allocators / Removing zbud and z3fold
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Vitaly Wool <vitaly.wool@konsulko.com>, Miaohe Lin <linmiaohe@huawei.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, Linux-MM <linux-mm@kvack.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Minchan Kim <minchan@kernel.org>, 
	Chris Down <chris@chrisdown.name>, Seth Jennings <sjenning@redhat.com>, 
	Dan Streetman <ddstreet@ieee.org>, Chris Li <chrisl@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey folks,

This is a follow up on my previously sent RFC patch to deprecate
z3fold [1]. This is an RFC without code, I thought I could get some
discussion going before writing (or rather deleting) more code. I went
back to do some analysis on the 3 zpool allocators: zbud, zsmalloc,
and z3fold.

[1]https://lore.kernel.org/linux-mm/20240112193103.3798287-1-yosryahmed@goo=
gle.com/

In this analysis, for each of the allocators I ran a kernel build test
on tmpfs in a limit cgroup 5 times and captured:
(a) The build times.
(b) zswap_load() and zswap_store() latencies using bpftrace.
(c) The maximum size of the zswap pool from /proc/meminfo::Zswapped.

Here are the results I have. I am using zsmalloc as the base for all
comparisons.

-------------------------------- <Results> --------------------------------

(a) Build times

*** zsmalloc ***
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80
 LABEL   =E2=94=82 MIN      =E2=94=82 MAX      =E2=94=82 MEAN     =E2=94=82=
 MEDIAN   =E2=94=82 STDDEV
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80
 real    =E2=94=82 108.890  =E2=94=82 116.160  =E2=94=82 111.304  =E2=94=82=
 110.310  =E2=94=82 2.719
 sys     =E2=94=82 6838.860 =E2=94=82 7137.830 =E2=94=82 6936.414 =E2=94=82=
 6862.160 =E2=94=82 114.860
 user    =E2=94=82 2838.270 =E2=94=82 2859.050 =E2=94=82 2850.116 =E2=94=82=
 2852.590 =E2=94=82 7.388
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80

*** zbud ***
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80
 LABEL   =E2=94=82 MIN      =E2=94=82 MAX      =E2=94=82 MEAN     =E2=94=82=
 MEDIAN   =E2=94=82 STDDEV
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80
 real    =E2=94=82 105.540  =E2=94=82 114.430  =E2=94=82 108.738  =E2=94=82=
 108.140  =E2=94=82 3.027
 sys     =E2=94=82 6553.680 =E2=94=82 6794.330 =E2=94=82 6688.184 =E2=94=82=
 6661.840 =E2=94=82 86.471
 user    =E2=94=82 2836.390 =E2=94=82 2847.850 =E2=94=82 2842.952 =E2=94=82=
 2843.450 =E2=94=82 3.721
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80

*** z3fold ***
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80
 LABEL   =E2=94=82 MIN      =E2=94=82 MAX      =E2=94=82 MEAN     =E2=94=82=
 MEDIAN   =E2=94=82 STDDEV
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=BC=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80
 real    =E2=94=82 113.020  =E2=94=82 118.110  =E2=94=82 114.642  =E2=94=82=
 114.010  =E2=94=82 1.803
 sys     =E2=94=82 7168.860 =E2=94=82 7284.900 =E2=94=82 7243.930 =E2=94=82=
 7265.290 =E2=94=82 42.254
 user    =E2=94=82 2865.630 =E2=94=82 2869.840 =E2=94=82 2868.208 =E2=94=82=
 2868.710 =E2=94=82 1.625
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80

Comparing the means, zbud is 2.3% faster, and z3fold is 3% slower.

(b) zswap_load() and zswap_store() latencies

*** zsmalloc ***

@load_ns:
[128, 256)           377 |                                                 =
   |
[256, 512)           772 |                                                 =
   |
[512, 1K)            923 |                                                 =
   |
[1K, 2K)           22141 |                                                 =
   |
[2K, 4K)           88297 |                                                 =
   |
[4K, 8K)         1685833 |@@@@@                                            =
   |
[8K, 16K)       17087712 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@=
@@@|
[16K, 32K)      10875077 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@                =
   |
[32K, 64K)        777656 |@@                                               =
   |
[64K, 128K)       127239 |                                                 =
   |
[128K, 256K)       50301 |                                                 =
   |
[256K, 512K)        1669 |                                                 =
   |
[512K, 1M)            37 |                                                 =
   |
[1M, 2M)               3 |                                                 =
   |

@store_ns:
[512, 1K)            279 |                                                 =
   |
[1K, 2K)           15969 |                                                 =
   |
[2K, 4K)          193446 |                                                 =
   |
[4K, 8K)          823283 |                                                 =
   |
[8K, 16K)       14209844 |@@@@@@@@@@@                                      =
   |
[16K, 32K)      62040863 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@=
@@@|
[32K, 64K)       9737713 |@@@@@@@@                                         =
   |
[64K, 128K)      1278302 |@                                                =
   |
[128K, 256K)      487285 |                                                 =
   |
[256K, 512K)        4406 |                                                 =
   |
[512K, 1M)           117 |                                                 =
   |
[1M, 2M)              24 |                                                 =
   |

*** zbud ***

@load_ns:
[128, 256)           452 |                                                 =
   |
[256, 512)           834 |                                                 =
   |
[512, 1K)            998 |                                                 =
   |
[1K, 2K)           22708 |                                                 =
   |
[2K, 4K)          171247 |                                                 =
   |
[4K, 8K)         2853227 |@@@@@@@@                                         =
   |
[8K, 16K)       17727445 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@=
@@@|
[16K, 32K)       9523050 |@@@@@@@@@@@@@@@@@@@@@@@@@@@                      =
   |
[32K, 64K)        752423 |@@                                               =
   |
[64K, 128K)       135560 |                                                 =
   |
[128K, 256K)       52360 |                                                 =
   |
[256K, 512K)        4071 |                                                 =
   |
[512K, 1M)            57 |                                                 =
   |

@store_ns:
[512, 1K)            518 |                                                 =
   |
[1K, 2K)           13337 |                                                 =
   |
[2K, 4K)          193043 |                                                 =
   |
[4K, 8K)          846118 |                                                 =
   |
[8K, 16K)       15240682 |@@@@@@@@@@@@@                                    =
   |
[16K, 32K)      60945786 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@=
@@@|
[32K, 64K)      10230719 |@@@@@@@@                                         =
   |
[64K, 128K)      1612647 |@                                                =
   |
[128K, 256K)      498344 |                                                 =
   |
[256K, 512K)        8550 |                                                 =
   |
[512K, 1M)           199 |                                                 =
   |
[1M, 2M)               1 |                                                 =
   |

*** z3fold ***

@load_ns:
[128, 256)           344 |                                                 =
   |
[256, 512)           999 |                                                 =
   |
[512, 1K)            859 |                                                 =
   |
[1K, 2K)           21069 |                                                 =
   |
[2K, 4K)           53704 |                                                 =
   |
[4K, 8K)         1351571 |@@@@                                             =
   |
[8K, 16K)       14142680 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@=
@@@|
[16K, 32K)      11788684 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@      =
   |
[32K, 64K)       1133377 |@@@@                                             =
   |
[64K, 128K)       121670 |                                                 =
   |
[128K, 256K)       68663 |                                                 =
   |
[256K, 512K)         120 |                                                 =
   |
[512K, 1M)            21 |                                                 =
   |

[512, 1K)            257 |                                                 =
   |
[1K, 2K)           10162 |                                                 =
   |
[2K, 4K)          149599 |                                                 =
   |
[4K, 8K)          648121 |                                                 =
   |
[8K, 16K)        9115497 |@@@@@@@@                                         =
   |
[16K, 32K)      56467456 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@=
@@@|
[32K, 64K)      16235236 |@@@@@@@@@@@@@@                                   =
   |
[64K, 128K)      1397437 |@                                                =
   |
[128K, 256K)      705916 |                                                 =
   |
[256K, 512K)        3087 |                                                 =
   |
[512K, 1M)            62 |                                                 =
   |
[1M, 2M)               1 |                                                 =
   |

I did not perform any sophisticated analysis on these histograms, but
eyeballing them makes it clear that all allocators have somewhat
similar latencies. zbud is slightly better than zsmalloc, and z3fold
is slightly worse than zsmalloc. This corresponds naturally to the
build times in (a).

(c) Maximum size of the zswap pool

*** zsmalloc ***
1,137,659,904 bytes =3D ~1.13G

*** zbud ***
1,535,741,952 bytes =3D ~1.5G

*** z3fold ***
1,151,303,680 bytes =3D ~1.15G

zbud consumes ~32.7% more memory, and z3fold consumes ~1.8% more
memory. This makes sense because zbud only stores a maximum of two
compressed pages on each order-0 page, regardless of the compression
ratio, so it is bound to consume more memory.

-------------------------------- </Results> -------------------------------=
-

According to those results, it seems like zsmalloc is superior to
z3fold in both efficiency and latency. Zbud has a small latency
advantage, but that comes with a huge cost in terms of memory
consumption. Moreover, most known users of zswap are currently using
zsmalloc. Perhaps some folks are using zbud because it was the default
allocator up until recently. The only known disadvantage of zsmalloc
is the dependency on MMU.

Based on that, I think it doesn't make sense to keep all 3 allocators
going forward. I believe we should start with removing either zbud or
z3fold, leaving only one allocator supporting MMU. Once zsmalloc
supports !MMU (if possible), we can keep zsmalloc as the only
allocator.

Thoughts and feedback are highly appreciated. I tried to CC all the
interested folks, but others feel free to chime in.

