Return-Path: <linux-kernel+bounces-49010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 537C68464A6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 00:55:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85B181C21AFE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 23:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544DF47F68;
	Thu,  1 Feb 2024 23:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qu5pl20a"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10AA736134
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 23:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706831711; cv=none; b=mxJ3THVVGqq3135OQbpGozCmMmtqq9XGSU9PI4xL3d0RAyHGZ7eiUqSE+aWc0VTwl7K6kn0evQI+0JBuPNnfWa5uZqmn1L9/bLcTSVv0HipD6KnaqYk8GYwKABrauAhW3w025Syo7hcRw1Ify2oWemW78Bui42hIPWf6Mp1gYqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706831711; c=relaxed/simple;
	bh=4I8+ID/QCgVbvpHEKkPVczMNuLT5+SxOXot/zYU2Ycs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=liyr/nv0g1x7knND6pmL3eWEG72cEsaMln0SOOBHjEs79bMsR/EwYv/DE/zSN+4M/yKFo7Gs0g96bPshkPR6jdgjtwGcLYUK/Ea3bHDVNCD6magUudEWxV7UPilk6KPU2vQ+WzlvZckjr2EvPqr6ih+XA65XQlIAWo4llLLPuBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qu5pl20a; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5fc6463b0edso25221077b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 15:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706831709; x=1707436509; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oPoNxScY22KtGi7I65v3KQkSSA7OlIpnXFGU1MLqXvc=;
        b=Qu5pl20aOA3bFv/3ii4sGPTwWQSTp3llVv36NnUaOg5bsGzD9SBdEL417RsF2aARX8
         f8/O8QBc+AGH/Zv7+0h3MYl1BV4zaqFqr4Lvh+gn0I0B0DQV1o6BfQ1YxG3VUuM9NjS9
         3AOV8Ip0pQdHE8iRZ3e0Koq0Zs1EWRlaEPPXoiJkBE9TTnm6FpcWYGcjEfXuivgM8Rzj
         q0QAnw+FDxdIivDFTD5R0KdffonuOe7gSA3UxsfPpaa4MfRoT23qJGvsXHTjl+PLr+qd
         VSVS48PL+YMLuZwKwfc36gj+OgBGPd9tNnc601hQ/dTafHYEH7i9Ym+E8NsKWBz/4Sgd
         HC/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706831709; x=1707436509;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oPoNxScY22KtGi7I65v3KQkSSA7OlIpnXFGU1MLqXvc=;
        b=Xi9mfHorV4Ic0eUODfhNSwxerEKuxXEyxBSsgvCgL3+IaukNF2MGYgumBiV/F7tVsp
         zK9AeD4zcZrelWcC16qLpz4U6sxlwndn4rdjdYpcTHRSQ5uIwet3yiBHN/yBtl67fSfA
         Jm5G14uHMbNZNsDJS0QerHtwChHruP39OqZG1dgmwlUdRVBZJ/0OBbbeO8gPdTpzP8UW
         VVBN9CELoUIutng2B2dW6RHJMm4yO/vakbl6wwEpom9u71XRbzuT9SWQ6QOQIjcn67nn
         xgAMxGeKGI7/IpSlANZJOYX4efIXWq0eK4TgkgT/DOE6NBhbqWUEfv+PpW1o3+ZVlNiS
         C4Mg==
X-Forwarded-Encrypted: i=0; AJvYcCW7Y3kpQMpqox+opPclr/ffq3sTilBzRa65hTSdIBlbwCqhKk44LQ2/JWlEkgOuUyW4V3yAao2sXqmEHvxDzXuehSIjVOMZ/fp9WKmR
X-Gm-Message-State: AOJu0YwjLZ0ajwNnmwspq6WDJBlh+8Dt8gJ1qbNrUWKYE987lWk5CYA/
	qe4V/JhInrdd0bBfLnlT6w4uHazV4NoGYfJgvaXoMKpbD/UP9CHzT5g2HGGYpgBtrDDDkKlVKeP
	uviB1tvJd6lEHHj86rw==
X-Google-Smtp-Source: AGHT+IG0Fv23ZgCY0CHImU4dZeK5t4BDFJrvm5cDaOWQ1ybBxaiIZOJmLus4rv7+9kwhmE0sOETzG495mLcxEt5r
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:690c:12:b0:5fc:4ef9:9d6b with SMTP
 id bc18-20020a05690c001200b005fc4ef99d6bmr116493ywb.9.1706831709102; Thu, 01
 Feb 2024 15:55:09 -0800 (PST)
Date: Thu, 1 Feb 2024 23:55:07 +0000
In-Reply-To: <20240201-b4-zswap-invalidate-entry-v1-1-56ed496b6e55@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240201-b4-zswap-invalidate-entry-v1-0-56ed496b6e55@bytedance.com>
 <20240201-b4-zswap-invalidate-entry-v1-1-56ed496b6e55@bytedance.com>
Message-ID: <ZbwuAyAYi_XxMEn_@google.com>
Subject: Re: [PATCH 1/6] mm/zswap: add more comments in shrink_memcg_cb()
From: Yosry Ahmed <yosryahmed@google.com>
To: Chengming Zhou <zhouchengming@bytedance.com>
Cc: Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Feb 01, 2024 at 03:49:01PM +0000, Chengming Zhou wrote:
> Add more comments in shrink_memcg_cb() to describe the deref dance
> which is implemented to fix race problem between lru writeback and
> swapoff, and the reason why we rotate the entry at the beginning.
> 
> Also fix the stale comments in zswap_writeback_entry(), and add
> more comments to state that we only deref the tree after we get
> the swapcache reference.
> 
> Suggested-by: Yosry Ahmed <yosryahmed@google.com>
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

Acked-by: Yosry Ahmed <yosryahmed@google.com>

Thanks!

