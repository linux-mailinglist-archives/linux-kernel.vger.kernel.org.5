Return-Path: <linux-kernel+bounces-48669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E578845F97
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:13:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 419041F28D5D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F70584FDF;
	Thu,  1 Feb 2024 18:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tw7Un+XD"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A6284FBF
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 18:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706811026; cv=none; b=MW4+esa43P4sQmrvuvSrxaXB/blPCfu31O5qYOntXkwJT48DWscmSZy6EZ8E1S/vjqLtoMtam7nuGCOa9nE4CbEuPJhQgV8Va74aL6BTjerksdjIgDQF3k99szakMJu3aduVDtUI47pRlIm/IKgxSlEgJZ0+UoM6GAgNgMniUbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706811026; c=relaxed/simple;
	bh=wQYi758VcG6rfwo5YK3Vo8ZUKysOs4ztBsO95stpGRw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jHZHaEQiT1w/e+jOm1eBpg8zw6hwVTs4RutS66KUhvpWPyen/sWkUrFEZD9O2CtnzREZmwifAiYzHdZdOUnxQ5U28IXsL3yg4inTejSi4Ei+PqyZrcewxYc9aJSi0CoE0fmV0jT0+amk57fPW0wyfhIesXAye5DxQ14c6XhDZfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tw7Un+XD; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7bf7e37dc60so44535639f.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 10:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706811023; x=1707415823; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wQYi758VcG6rfwo5YK3Vo8ZUKysOs4ztBsO95stpGRw=;
        b=Tw7Un+XDN+onITpoqleDJ50toA2UPpjjBFDWWjDs+f8uUzKa4CcdsfS1q1cCvxd+Wq
         KAor+jMFManI/LgXOrKHu6zzV9jXPfNFRtbat3306VD4TLaswk7H5OrcFH0JWgppXZJG
         yHbXMk51YfveayhM6J9Hp10t22WnfAodONMoMsRWlsAVALUR0QuCf7xWzPFxRsG3d17a
         xxiLiB2TCY9w/6iexmc48qB+0EfjzMG+wh2PwxxdmVa+lw2pDmxcrtATkQrzdhQxUTpJ
         55TZnwf5OO762MSNlWOqApCyX4iqL6CKw35rq29cF4fxmGwdobpuKRCEK+HLHcmVZsGE
         yAYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706811023; x=1707415823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wQYi758VcG6rfwo5YK3Vo8ZUKysOs4ztBsO95stpGRw=;
        b=QSroCMDKx5EuBTo8nHIM3mmTvrYNIKtabfsTMAc/iMaUqrI1kpqtcsRvjIVSId9KoX
         SGW67je2mbn1LaFLGkodsdp6PbHFIROvzu59a0akFC43p4zxIGZ+qhpd3kq++oJSKpmX
         +EwcmzgFshV5e2aSjAn3+20FcaZSPh5ipFIiadCVzPUiItTjtlSX9LKhL1GX2b8DNoKW
         9EjxMxUX4sDGupN54owZkrfjy/UZcerUcEWl0ahOUSDy+VPkWuTTQ9GkbahDH4xygRQ1
         g+r4gtreBhEJ5t6RorhExNr+yEb10pef6sOWonEwEBCKtPaJUBSj7W+Pb++gWo1UCw4H
         AwLA==
X-Gm-Message-State: AOJu0Yxbf/cXX22CXhj6AqySAkYoEXQFjmCyEyqMIS/o9UdtdKIVCdVJ
	iAOsTxCXSqd/e7jZBHNqIc8+wtZR6tgBZKZCHQmJPcJxnIJvT+athVbujr3C2QVqDo83bo4cpJR
	UiZMrj1Ip4x6NtlaubvplP0uDybs=
X-Google-Smtp-Source: AGHT+IFjKML2ehvzAKSPla2cVJ9tAYkQJGqCAeqe8VWjfKhsultsWpjv6i+KLYmKqqLEsuZPAo6pzTXcN73G0qR0IFs=
X-Received: by 2002:a5e:d507:0:b0:7bf:87b6:623d with SMTP id
 e7-20020a5ed507000000b007bf87b6623dmr6427451iom.13.1706811023642; Thu, 01 Feb
 2024 10:10:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201-b4-zswap-invalidate-entry-v1-0-56ed496b6e55@bytedance.com>
 <20240201-b4-zswap-invalidate-entry-v1-3-56ed496b6e55@bytedance.com>
In-Reply-To: <20240201-b4-zswap-invalidate-entry-v1-3-56ed496b6e55@bytedance.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Thu, 1 Feb 2024 10:10:12 -0800
Message-ID: <CAKEwX=OSrj5nwspuO7jyR4h5iZkKsP4P-mQbZt67OC1G=wgLYQ@mail.gmail.com>
Subject: Re: [PATCH 3/6] mm/zswap: stop lru list shrinking when encounter warm region
To: Chengming Zhou <zhouchengming@bytedance.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Yosry Ahmed <yosryahmed@google.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 7:50=E2=80=AFAM Chengming Zhou
<zhouchengming@bytedance.com> wrote:
>
> When the shrinker encounter an existing folio in swap cache, it means
> we are shrinking into the warmer region. We should terminate shrinking
> if we're in the dynamic shrinker context.
>
> This patch add LRU_STOP to support this, to avoid overshrinking.
>
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

Nice!
Acked-by: Nhat Pham <nphamcs@gmail.com>

