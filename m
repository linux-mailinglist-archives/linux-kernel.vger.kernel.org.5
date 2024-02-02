Return-Path: <linux-kernel+bounces-50133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB458474AB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FEB31C2627D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D45E1474DF;
	Fri,  2 Feb 2024 16:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="c2aGuKCX"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA861474D4
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 16:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706891317; cv=none; b=ZZnuo5mK1SI1Q2Krvif3irRLBHzHOZydgB4Up2v7bwsnreecZOO1YVnEdFoHHKcRxPQNM4Srv5tZIObBhsl9XNDLlseMVpGK1UgnDuFbA5LFUTajKZsmySMApkeai3QMf91dgFl/VD1JcCVHfJp9zyFw4XraPVUarLtrbnNGN3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706891317; c=relaxed/simple;
	bh=5yYC4y/j2Ds43j/qHcRx+bDc0zNlOrkeMfXYSwO9OjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FJOo6LbDmoH63XiL31KFabgMb0DbIctAOwum4ddOTWwIGZCnjT/l3keyG0c9qG6w8ccYd9wDyVx4PDrd62X01MSFwQd7sgkVEKIAKZPs3X0qflCZqjKeh2GbDiDC6n52BL3T5OQOSLmx7fC1RBtfGmA8/WntziS0yjHExlzOVgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=c2aGuKCX; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-68c53ed6c56so11323686d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 08:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1706891314; x=1707496114; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+vB5lFwDU+FKoGu9kvAW1CsOhCAQU/iwir8iM70P+fY=;
        b=c2aGuKCXE6lUgCIEeHUUpBScGnMIPnN2e6l8xIwWHE09U8B46FxyrH3iLPZ1f3Xqsw
         +VetaUqXWD7PzuzZ455WWS9ynnflMXCaXPch3yelwQiJDoo6WhAVajxMu4vkP9VzxPy/
         jcjj9rPhm3coVpsgVHXE/CWr6sz1Bs9oeW3xAYHOe2mKc/0LNS9WNY4V3JBOookEylKW
         doom2g3q7fb6MWoA8ODhsPwE0600YTGFsPEoMzdyBzmtBZgyEdKI145R1k706RVn9XPb
         Wn/YI/8k/ghsBLjzbgDElBas1O+SRUXjoStt9jkJy1PvtIlr38mKMWmk2O/7QTg6WV5V
         BtBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706891314; x=1707496114;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+vB5lFwDU+FKoGu9kvAW1CsOhCAQU/iwir8iM70P+fY=;
        b=YklZQHA+2IIUbWSzorH+tTzxmB5hDShR1db3Cg3e9b6xRxob0JKDpZVm49iAD1tol3
         FI8W0cQI+ZDMXy6lJYAHkHmFDl25h+7wt/O0LhU+sJvUjViYtiPiNy+nSWnltldE8Yrq
         SQMUVgGbUERJexmxhHCA5wQei2NaFGD7Y97hZ/pRyWXrbfR2OXjvvWmtDiWSgGmXIttP
         Vl8C80IKW14bPTdYsZ2X1xlcF+VBi2zcHTHxZCGPU+pMSHZqS1TgaqP/P3HJf5QVEUTY
         mhxsaqd9H1s+I1Cd8xLGyobmJFma8xkmUAmqrhJMcVyrVgVXP8u+H+dg3ZtR7V8oPzaS
         O8xQ==
X-Gm-Message-State: AOJu0YzppKUD0uTRMCpb+Gpfvxkg5z6dyrTtVppzMu4HAO7ZXysLNA+R
	pCowW2BqXRrVSl41lUkIqgOaMaxuJKmGtL7A0gwS3ZjhiDwDwIhfIz7fZgcQMPg=
X-Google-Smtp-Source: AGHT+IGX1nJL1CEpXPXvvCHG2ODO0sZJp2qTXUC+Z+2UUOZk3p0QLVKm9j/eFYlepi2ohUVChHDwGA==
X-Received: by 2002:a05:6214:cc8:b0:685:61c2:cf7c with SMTP id 8-20020a0562140cc800b0068561c2cf7cmr8108448qvx.45.1706891314409;
        Fri, 02 Feb 2024 08:28:34 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWHUmdx0pK8SJqR9uwMKLTe0ERXQUBQWQNQGplWTJLjnOLq4XZG1xfTcbo7IIYJey+vzmmFPOjP31GQVGSQBBjsRfNGkUfeAHdNRLaGAhQcXhln9hxvHvHBHjCOKBNY0Nydyhrvx7QMVwPgSmfWNeHbrBV46YMsM+bpXwE5UWtt0oNXSEPuEa0SMHYrPhSDIpa35g==
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id nf8-20020a0562143b8800b0068c3b1bcf6bsm940617qvb.95.2024.02.02.08.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 08:28:34 -0800 (PST)
Date: Fri, 2 Feb 2024 11:28:33 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Chengming Zhou <zhouchengming@bytedance.com>
Cc: Nhat Pham <nphamcs@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Yosry Ahmed <yosryahmed@google.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 6/6] mm/zswap: zswap entry doesn't need refcount anymore
Message-ID: <20240202162833.GG1227330@cmpxchg.org>
References: <20240201-b4-zswap-invalidate-entry-v1-0-56ed496b6e55@bytedance.com>
 <20240201-b4-zswap-invalidate-entry-v1-6-56ed496b6e55@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201-b4-zswap-invalidate-entry-v1-6-56ed496b6e55@bytedance.com>

On Thu, Feb 01, 2024 at 03:49:06PM +0000, Chengming Zhou wrote:
> Since we don't need to leave zswap entry on the zswap tree anymore,
> we should remove it from tree once we find it from the tree.
> 
> Then after using it, we can directly free it, no concurrent path
> can find it from tree. Only the shrinker can see it from lru list,
> which will also double check under tree lock, so no race problem.
> 
> So we don't need refcount in zswap entry anymore and don't need to
> take the spinlock for the second time to invalidate it.
> 
> The side effect is that zswap_entry_free() maybe not happen in tree
> spinlock, but it's ok since nothing need to be protected by the lock.
> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

