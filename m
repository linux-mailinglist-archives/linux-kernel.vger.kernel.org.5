Return-Path: <linux-kernel+bounces-48618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DAA845EE9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CEA4289E37
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 17:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B227C6E8;
	Thu,  1 Feb 2024 17:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="P5BQVBLy"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B087C6D3
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 17:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706809894; cv=none; b=Kx7YYHl5UE/d6vh29WIPzDb11aiLQEE2KLloHzMXObckLVaTIl4lcuMYb8/cAzWVAv4haVApIcJYpe2eMMtuHB83a2fpoC3J6XOPZP67Fc7H9XLUpeAj4pLNKvTUlWCfnYxK2kY9YEy35deyDwFPuhRNIhG5JN/l1p/KCUyeYv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706809894; c=relaxed/simple;
	bh=HKIiXUe7sVHrdBQlqscSDlvr6L0DL2xU2QpOqjFJ3ZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bb5jJACL6G2Xrqv+17QvtYe4iHWuGmurHOXCVi+bs5WWS+OqvHUuId/dKgi97HmdXDlwj+Z3TjuporPTXuzt7yYdU++S9hzAq4ggk0D6O2Av96mdHyJ1Ihqn+a+TeqnTCV/Kb+0OWCouXrw2Zsf++Z+diKAcYzi16nvVsF2bYGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=P5BQVBLy; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-783dc658bd9so70537785a.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 09:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1706809891; x=1707414691; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+kYGSxw/0pVUP/NyhqBrFQ2NZRrfK98HK4WLJcKdinM=;
        b=P5BQVBLy5WKGVhUvbnFBh+vSj7F3qnaxeIzHN9J4fnNv63rfBAhX3u7XcaoUlyxtON
         +dsRqnLZkx+Y5JGwcJLOy97BuO8SUECyOjLDraZrXKiduDtC0VSpJVmDjUrKUQ97OOjG
         cZNYMtQNel/qrK2l+QlAKdPr2YRVyAeM36e4JvcbkkTgM5LqVsydcklhabWO7zcY3/1d
         gG2j794m5V0vVq2Os3xk+AUhdzYmArGaa+ytzPscUYmhg3apTJTR/grI1vf40aSqOooK
         wkZYoAbpT0tj/FYi8o2gUAc3gfJAnS/G8zOL3lUyuoQe4jHhxv6SRlB2tpZQo7s1sl49
         CB9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706809891; x=1707414691;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+kYGSxw/0pVUP/NyhqBrFQ2NZRrfK98HK4WLJcKdinM=;
        b=Tyba9tva0XgCIsHGkpDdFwBN6y1aW1opCGm6oOf71yQC/AhkRIBOvLdIeB7hMGWlbU
         BqNYHDsRFdZCTayOHroxzXL4DuawYXa+XfspBm1Cdua/Bw/3yiqW3I53K8/Xv7ZgYoHr
         4gIZvJOyDEo8X1uTeEakDL9ZPOA81LEzkzn+IBdXt+Xm93xuB9wfZZsQA+fIFc05KQk9
         dt775tivTlPbq2wJl32QaCFQRZGV0G0W8hA2gQMW48eXwm4XTqvVA9/1bvAVas/JTB+D
         lwY/nGoh8pm0GA9Hbel30CnVHEg1sp5+k1scqHLnPDHL8gvFmKmGeKyiZa6SgotjwooJ
         AQuw==
X-Gm-Message-State: AOJu0Yw0YzKtj08+/s7Y1sZPPSPClHy1ZWd5o7mK+gdMqy9dIUiwGPNq
	vnVEdj2gAhStyd9Wr/9mWqyIQFhexM9x1voxcQfbgHpiM/eMVLAfjkhafFVr6RA=
X-Google-Smtp-Source: AGHT+IF3A1lcUaOO7c/lXY8rz6yXdT7JmIfZvX2NMfbAV/K3cYMuofPlp/431nTYuUvv1HHt9ylzRg==
X-Received: by 2002:a0c:c983:0:b0:68c:8208:cf71 with SMTP id b3-20020a0cc983000000b0068c8208cf71mr1141501qvk.31.1706809890854;
        Thu, 01 Feb 2024 09:51:30 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVxL/p9RoDdK1QuEUqqCFrZbiGpc/objavleFeu1lUXhFE0Lriynlt6mqRwAOppkCw3yWo9iZSRj8bc7qPwyU4t9K+mBpdIG26EVkKMPlYYcK+om5I+Re1tq7E/saShNKa8tfv0MP/fNb36owlQMYlIFNPNKjbRK0B/zeySfvcHQBcyz1kJNXtRfCGN6ZFRMRmaPw==
Received: from localhost (2603-7000-0c01-2716-97cf-7b55-44af-acd6.res6.spectrum.com. [2603:7000:c01:2716:97cf:7b55:44af:acd6])
        by smtp.gmail.com with ESMTPSA id dp2-20020a05621409c200b00686a22aeafasm3857272qvb.18.2024.02.01.09.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 09:51:30 -0800 (PST)
Date: Thu, 1 Feb 2024 12:51:29 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Chengming Zhou <zhouchengming@bytedance.com>
Cc: Nhat Pham <nphamcs@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Yosry Ahmed <yosryahmed@google.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 3/6] mm/zswap: stop lru list shrinking when encounter
 warm region
Message-ID: <20240201175129.GC321148@cmpxchg.org>
References: <20240201-b4-zswap-invalidate-entry-v1-0-56ed496b6e55@bytedance.com>
 <20240201-b4-zswap-invalidate-entry-v1-3-56ed496b6e55@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201-b4-zswap-invalidate-entry-v1-3-56ed496b6e55@bytedance.com>

On Thu, Feb 01, 2024 at 03:49:03PM +0000, Chengming Zhou wrote:
> When the shrinker encounter an existing folio in swap cache, it means
> we are shrinking into the warmer region. We should terminate shrinking
> if we're in the dynamic shrinker context.
> 
> This patch add LRU_STOP to support this, to avoid overshrinking.
> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

LGTM.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

