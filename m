Return-Path: <linux-kernel+bounces-49050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26EA9846549
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 02:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC9C628B620
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 01:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF2263CB;
	Fri,  2 Feb 2024 01:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jAADPaSb"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA0763AA
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 01:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706836307; cv=none; b=hBr0JgmHqTtzImC5nVEBV+JQPP+T1zWGksSnjFR6dcLYQ3J8JMPfS/iQvlfEqxRArWyY2uTzG48h2Qf7ph5DEHPbymMxTM2CL7uLKVaUJxDDYRYEl6rfEkigUu/fM4v0+RZniRyyseScxi3Tv5dlvnT9qNHB9nNsKwj9s9mbh5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706836307; c=relaxed/simple;
	bh=QyaMTcp16hH0iJqwNBS4cciHIkIu8+v3VnPUlVNCZUE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lRj5myHcuLZQgR7sw0EZyWTP4ltbCHJdQzUUIvv+YG8DZkm0LOyQPYFZJLTEi7NQ7cPLwurGpzhiy9e2tFNbuK57zZPzV1eJOpaw0a7XCywOjgtgXYhXNUe+JrFVCHHCWs5imjqM2CjmG+q9/te71DUMl0oEcv/YuG9DihDG36Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jAADPaSb; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-603c0e020a6so23114097b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 17:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706836305; x=1707441105; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5wTI5por6UkHgJmYtmcJhLkhPMr6uJPPJ6ylUKRgo0M=;
        b=jAADPaSbCZRkXjJvRi4rjKo3ZADxsTtMn7DavXWrQrZC12HWv5wzKCvEQ7diIcldwH
         VWUDW/LKoRrn3ur1Q20HBUluRaOmp6bnZvWDx2kVVehB4csjcDvLZFkAyzNffUHbd/Gh
         Ndm5D0jF6HhVJx7vYGX0cua8XLgnnZDLSwsMmuFsjYWiveT1X2A6U+RmAOcPdPR3Y5bl
         jU9KX+kdy0knXxY7CB8DTUwgIHe2zeRS9bHvDx0oMiCfaFD4WdIUrcTH+3oKcZTjOgt7
         ssB2gU5ghapRG4vVdFnOmoBmXuJbU/VrvjhISThTl9BiAc+Qd4NSDts2qzxAfVn909Ad
         pl+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706836305; x=1707441105;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5wTI5por6UkHgJmYtmcJhLkhPMr6uJPPJ6ylUKRgo0M=;
        b=vduiHBFueTHUWWcdtgOZT9fxjIdF4GisTkhF0u8iCwQdVtJBB0BKY7IXXsyvfcIcBP
         q5o98i6tjS26aUS7siaBXktJtSVNGanxiFf5Vq6EwEjHqrh1RFPeQhNaDmRZjE3QCJkv
         x9MxF0se4Ylspwa32b3zLotTYZ/tdlQg9hQzf+vYrqdGazYEHFG60EZn87ygz3dkJ/7X
         Wzi7NDekOffsu6zlmvCl6estSRvWJiGpmb4YpeVfPt7n0JArc/GEMaQtY6IapOPeq1YU
         cmN924a2rmpbT890JNP8LrzCLbfPEOyZzfWrrVB3CIAdh4NoB7WqhFTnJertWbCdZ3NY
         0OiQ==
X-Gm-Message-State: AOJu0YxNF2q4hMv3M18EAzfrWo/1p8iJVBywKOKlvkjGOioimd60Qi/t
	Ip0DVUbJgXZLDKItcqdAf8MLnbD7uiIkyNN9P+KZvAGa3yZzpVG2ugMvVmp/9wCYlU9VhaaGaL2
	N4VIR7GNyYnm4ZitBIQ==
X-Google-Smtp-Source: AGHT+IGdNK+C7pghP6+H+HztU3yyWwYdjHBtYqFFAZm7I9D1rud4Li3ClrDAMeIUq4i6P+9+h3i93CnqrW6Ix6Pj
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a81:4c14:0:b0:5ff:a885:65b with SMTP id
 z20-20020a814c14000000b005ffa885065bmr665836ywa.10.1706836305085; Thu, 01 Feb
 2024 17:11:45 -0800 (PST)
Date: Fri, 2 Feb 2024 01:11:43 +0000
In-Reply-To: <20240201-b4-zswap-invalidate-entry-v1-6-56ed496b6e55@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240201-b4-zswap-invalidate-entry-v1-0-56ed496b6e55@bytedance.com>
 <20240201-b4-zswap-invalidate-entry-v1-6-56ed496b6e55@bytedance.com>
Message-ID: <ZbxBT98Ctjvd0XPG@google.com>
Subject: Re: [PATCH 6/6] mm/zswap: zswap entry doesn't need refcount anymore
From: Yosry Ahmed <yosryahmed@google.com>
To: Chengming Zhou <zhouchengming@bytedance.com>
Cc: Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="us-ascii"

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

This looks like a great simplification, and a good motivation to only
support exclusive loads. Everything is more straightforward because
every tree lookup implies a removal and exclusive ownership.

Let's see if removing support for non-exclusive loads is agreeable first
though :)

