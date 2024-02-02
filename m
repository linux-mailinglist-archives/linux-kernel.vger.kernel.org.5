Return-Path: <linux-kernel+bounces-50653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D31847C1F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 23:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C2B3B22B17
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 22:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87FB885928;
	Fri,  2 Feb 2024 22:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MZnUZhRh"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363F6839FA
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 22:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706912161; cv=none; b=e4f00l3GrSRNCHbrdegsid4JnM9i/hNl6xUg0st68Q6XzlDDREeuED9mgIL20U8ONv6AMD3uDeW2jjaj5DvCsL9Sr1DfNWSW37WFlK0QLhj/uFMNv+IoHq/hwiMhyykFyS96ESzi7zoBZPUduAx+lBpSkPBz0kZ+HIl3cLcRGKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706912161; c=relaxed/simple;
	bh=8pw1Cnd6ggE/qSWHGj+1Pwn5+jqq1Ywaxo6TYUiW/5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qVF0Nr1uS951/e6JC//YincsQFy0Fva8KoBjdWvUFExgbvVfC3A78hJL1OinxuzaTRf1GQ9mY2+JjPBFdVjJZuH7wY7SliSXjGYxD2FlZa4Zl8KFS7hM3FCm/adLdwI7DmtQ7A68pe83VHi8JsDeXNM7ILM/qzcPD660eqqwOg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MZnUZhRh; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a3122b70439so356009166b.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 14:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706912157; x=1707516957; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PCVD0Cf1Do5W0DWqD5HKqZh07wW2qlZPmybdlhb8yiw=;
        b=MZnUZhRhJDwVpztZIMo7kw3fZ36GO4Z6WLLmt5nMBmlwo8zdQxeRvTPq+QlJd3XqGr
         WR74YzFR4nroGsGsoMYiQMXOw3hJA25si0rTiN/PSZPiAdYn8fAYZNfFz33w7MV6Vx9g
         9LCcdZp/3IIwEj6OiZ2c2d7iYEHGdTE0H7NFoLu3w0/S25/vqJLg7zA9k4k3uhrUmnlt
         5BEek3dl3QVJAAqifIeAlJul5oXq9uxBwRucE1BPpaNvZQpmRh+BVTaaU8kj0T0K6bnU
         JI+lXKw5GrNkH/JIqGREPxBrk9zLbkNRYStN3onK/1C8MS91LNNjUI6lIM5kz0yHjTXu
         aT+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706912157; x=1707516957;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PCVD0Cf1Do5W0DWqD5HKqZh07wW2qlZPmybdlhb8yiw=;
        b=gPUFKx+rxbDn5EAmxXNLDSXTWA1+wFBb92O3iMB8/zk1DmlFNHEIuicLVBTd6OE1+9
         8JqstttWhjLL/VfB5tB5XS7DTrB0Apyd6z9eDM7xGHOY8sYrw7wm4iNHxkNA4ms6KXJE
         k101r5xefAu5PRivdLCMG3gXxOUbPuaJnBSrsuD/SWAzmf+7XdGc4iDwPIOdMyVcl0St
         sLRvrjl3CNZiNDlnhNKX/yJdxQFG91u3Ytfo/5WNpw0OcR5+c5Uw5+3vKDNPwqwVuDIN
         MbKp6KD1Lq09oRKCUyHON9pi3tebf4iTF0XzwD+zUZcrEXypLIdc6cy7dn9/U8E2D8gS
         PK2A==
X-Gm-Message-State: AOJu0Yy+UbVhTYwNbF23v8MyHLb4eVtXO8mmZTxuI/VucUfW0dm2tKE1
	+FH4vPNfrLlbJNWtcbfNQJZMdkwa9E78q5nf5uMuwUe36YK/tjzSqYVJpe8ubkBOhc0pRSfxQwI
	A+FhsGBAPRqDlvN4i3CPgksgidz2RjBeFZnia
X-Google-Smtp-Source: AGHT+IHhCwYQ0fHFpy+88NTrFV9TFaUez9IFTRwHY18XPpRICXORb+lu/PENlfo69PtNBocvU6jZtVXQ7bV16MWte7g=
X-Received: by 2002:a17:906:3bdb:b0:a28:c5dc:4802 with SMTP id
 v27-20020a1709063bdb00b00a28c5dc4802mr6921315ejf.31.1706912157344; Fri, 02
 Feb 2024 14:15:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201-b4-zswap-invalidate-entry-v1-0-56ed496b6e55@bytedance.com>
 <20240201-b4-zswap-invalidate-entry-v1-5-56ed496b6e55@bytedance.com>
 <20240201181240.GE321148@cmpxchg.org> <d5455b43-aa22-4931-a6b3-062128f4d30f@bytedance.com>
In-Reply-To: <d5455b43-aa22-4931-a6b3-062128f4d30f@bytedance.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Fri, 2 Feb 2024 14:15:19 -0800
Message-ID: <CAJD7tkb-GZriP6+HdgbkvcGTAAO=YZmGtQ1=AAhJkQJj_CmoYQ@mail.gmail.com>
Subject: Re: [PATCH 5/6] mm/zswap: only support zswap_exclusive_loads_enabled
To: Chengming Zhou <zhouchengming@bytedance.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

> I just A/B test kernel building in tmpfs directory, memory.max=2GB.
> (zswap writeback enabled and shrinker_enabled, one 50GB swapfile)
>
> From the below results, exclusive mode has fewer scan and refault.
>
>                               zswap-invalidate-entry        zswap-invalidate-entry-exclusive
> real                          63.80                         63.01
> user                          1063.83                       1061.32
> sys                           290.31                        266.15
>                               zswap-invalidate-entry        zswap-invalidate-entry-exclusive
> workingset_refault_anon       2383084.40                    1976397.40
> workingset_refault_file       44134.00                      45689.40
> workingset_activate_anon      837878.00                     728441.20
> workingset_activate_file      4710.00                       4085.20
> workingset_restore_anon       732622.60                     639428.40
> workingset_restore_file       1007.00                       926.80
> workingset_nodereclaim        0.00                          0.00
> pgscan                        14343003.40                   12409570.20
> pgscan_kswapd                 0.00                          0.00
> pgscan_direct                 14343003.40                   12409570.20
> pgscan_khugepaged             0.00                          0.00

I think the numbers look really good, and as I mentioned, we have been
doing this in production for many years now, so:

Acked-by: Yosry Ahmed <yosryahmed@google.com>

