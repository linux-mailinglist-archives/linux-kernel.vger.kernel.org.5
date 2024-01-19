Return-Path: <linux-kernel+bounces-31601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FAF283309E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 23:05:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 575FD1F22882
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 22:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B79558AA7;
	Fri, 19 Jan 2024 22:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bR29Uwb7"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F38B58AA3
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 22:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705701949; cv=none; b=HAFiLaowKeZ+DKPav+od0LxKZYT1pPw6whRzyeYdhjQLkbVe1vQPkEm0vcMLdhksXZt9ZZeYnuyDC4avGwhgcuRzLwWHOQDC75J+gPbHal9MsrcftDf8Xoawbed1J4ycmtFi3AkZv4B1ZiOEMOXSo9rJn9ohZriCDs42V2/TA0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705701949; c=relaxed/simple;
	bh=p1hTh7UD1WJVTA0jl+hmxaQP6FZFEni/5gYHeYnGWcM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a433nucHdp1938/HoZaNsF0VLzsQ8lpfwfYxRM7WPyI2SXkeJZencjQ+VZc2aKgjkJDsAxSnxVgh2G5g7QzO3xqYY0y2a8tA324dmYLtXmnApNfuWSf/n7CadL+8Qkng3lrtc3o/NP9j1yB+lAPH6Xfs0iJV3SnsAFR7ZkFS0q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bR29Uwb7; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-28e724d9c47so916020a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 14:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705701947; x=1706306747; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JvLEJ5iYwm0j9MPbrk2yPdPy/G2pUyzqxjNRaXk3G/Y=;
        b=bR29Uwb7U3sqnKLcy5PLSBZxTXyNK8i5S8JnNFN2Bg6/UnXHnkRVrKhk+0G9fEGVmW
         lfGbv4m6bOs5XoWqhW40cX8ed/LyWoR5JR0MsHUGASMVSmi10DB6wTvJM3fardjTKbyL
         9snS3RJRaeHu1+yYHoZ00B2sZaCcBOkztC1yfP7AiS0lRWdN4uugD7CRXq6WTG8TlvQF
         4TU7WpYSTpDFIIkvwAMv8GznP6cJo28m6AeM2XAuXtUDFrc80S3p0Kmh95z2FB5BLaz/
         Cr+BbHeN0zfpO4q9uGmNJud4NlqrgC5lQiC/NEmuk9BEVRUyuWdjLypJzTdDje6ARuFa
         xAEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705701947; x=1706306747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JvLEJ5iYwm0j9MPbrk2yPdPy/G2pUyzqxjNRaXk3G/Y=;
        b=pOoix6tAsrPETZoMT1ONciDywruVKr7w0d/1wUSNtvtdLtwWCil2rfhiFwi15jMKgy
         GjxPdfsHfmu18u/d/1c+qc+7KuzUUxccUcKW5GokO8odCYRIx5FUGhuQbhQP9oOl81Am
         vm1B4ImTIE3btmeB4vUIo7k8/iHsTVg1o8YldJGuwvcPC3R1NrGZ73GVOmybyifVa1ER
         JbNLUJyp0ChKLm3maTd/AlFp/UZKKaUAho9rkjfmaToWbz+FpUW28N6wWzcsorxAQ5K2
         Qnhj2ihpMbZjxkhB5/jFDRGHG4rf/Ajz7QdnIIHva5WVPcs2dFNBICGpr5bg3RoRRAab
         kqyw==
X-Gm-Message-State: AOJu0Yytapy7owegQQk1pAKfQCUci6lYaYTGKjQhRbCvdU98sf6RRMKw
	TRspdJOyXYooDddg8AIe6jEFp0LDLKOETvnZeHmXWz8RCPlOl7XoZotvE1J92o/TlTUJd06M/1F
	J1VLrE+WoGMy1q1uQRyfa//xq4OED10siSwXPG4oleDmC6q3fmw==
X-Google-Smtp-Source: AGHT+IHSzp2BR8nz8aHNw/3cc3v/4AitTKYLkGTJHb0M2/oimZxTmZymJV4ZqzphJHWWyrrg+1PN3gZmm6os6nhUlfY=
X-Received: by 2002:a17:90a:d905:b0:28e:7964:1257 with SMTP id
 c5-20020a17090ad90500b0028e79641257mr404465pjv.97.1705701947215; Fri, 19 Jan
 2024 14:05:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117-zswap-xarray-v1-0-6daa86c08fae@kernel.org>
 <20240117-zswap-xarray-v1-1-6daa86c08fae@kernel.org> <CAJD7tkYEx57CPBoaN9GW4M3Mx-+jEsOMWJ02nLKSKD-MLb-WPA@mail.gmail.com>
 <CAF8kJuO5tAqwyKQK7AasWgs3Ohfc2osD9oX0m8YAkfsAZsjjyQ@mail.gmail.com>
 <CAJD7tkY6K8q1t-nzZ7oJu-f3OgS654PiOcQgU=E6f+0joYSzPA@mail.gmail.com>
 <ZarV0Iyq7Wor_Dvc@casper.infradead.org> <CAJD7tkYTU10W4WX3HXzs3t4hKRLZ0saX0Nd8RDcaoYj58bzbsw@mail.gmail.com>
In-Reply-To: <CAJD7tkYTU10W4WX3HXzs3t4hKRLZ0saX0Nd8RDcaoYj58bzbsw@mail.gmail.com>
From: Chris Li <chriscli@google.com>
Date: Fri, 19 Jan 2024 14:05:36 -0800
Message-ID: <CAF8kJuOvOmn7wmKxoqpqSEk4gk63NtQG1Wc+Q0e9FZ9OFiUG6g@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: zswap.c: add xarray tree to zswap
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Matthew Wilcox <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	=?UTF-8?B?V2VpIFh177+8?= <weixugc@google.com>, Yu Zhao <yuzhao@google.com>, 
	Greg Thelen <gthelen@google.com>, Chun-Tse Shao <ctshao@google.com>, 
	=?UTF-8?Q?Suren_Baghdasaryan=EF=BF=BC?= <surenb@google.com>, 
	Brain Geffon <bgeffon@google.com>, Minchan Kim <minchan@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Mel Gorman <mgorman@techsingularity.net>, Huang Ying <ying.huang@intel.com>, 
	Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, Kairui Song <kasong@tencent.com>, 
	Zhongkun He <hezhongkun.hzk@bytedance.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Barry Song <v-songbaohua@oppo.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Chengming Zhou <zhouchengming@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yosry,

On Fri, Jan 19, 2024 at 1:41=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
> > if your code is naturally structured so that you delete the entries
> > after freeing them, you have no reason to call xa_destroy().
>
> Thanks for elaborating. Based on this, I believe doing xas_for_each()
> { zswap_free_entry(); }; xa_destroy(); is both closer to the current
> code structure and more efficient.
>
Can't do that in this case though.  Because you get the RCU read lock
on the tree.
Other threads can still lookup the xarray (also RCU read lock) and get
a pointer to the already freed memory.

Chris

