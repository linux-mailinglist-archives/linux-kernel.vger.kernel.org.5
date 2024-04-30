Return-Path: <linux-kernel+bounces-164515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 059E88B7E79
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 19:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 347E61C2104B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4BE17F39A;
	Tue, 30 Apr 2024 17:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W9IDIH33"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BAC1802A0
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 17:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714498207; cv=none; b=ZBdGZcmyseds57qX0mvFgIDLoQfSBWiFHGEGOGQP27iF+MIq+1SnNAoeqJB5jbeGkisrJR4UkI3ogHVAcIMW8an8ND7wCfg0vnM0SvA/ATyafdduL+eQJKvwHMkAAojERZsWRrTlePdHPbltDhsnMNAr3eoTwAvHGAG5kSEzizs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714498207; c=relaxed/simple;
	bh=lm5P6IOa3RMwDfuQvPxY3o2hNKAu49zNJupUAM6VZ+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t2Wr0YPrIDcELRojKyT2/z4tBzt6mvJjrdKO/OjhSsr3mKUJ/qckx/b+W/hg7Ub/wcpPjaN4viegNOFk961W/uwSz5bazSbq9or646By71IthNuPiA33ADT2J9AvYLl8eNskiCBWhbr5vANYOL9Ql40TzB/ha1y/QbbybbzcS4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W9IDIH33; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-de54b28c41eso6755957276.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 10:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714498205; x=1715103005; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lm5P6IOa3RMwDfuQvPxY3o2hNKAu49zNJupUAM6VZ+I=;
        b=W9IDIH33u0Eqt1gX9uUTV/DdJQj9koKEbIakUP/rLgyhFiC3nSeqvXsOcbQ2/0kaQl
         stwJpqSXOI+MzALeIiDQarURxOZ2h8DtWQsg+8woGkGIII5JcKHhDcbH61vmQvH73yza
         8MmhP2c6z65BAvWuZRGk1t0LVXCAP2mro92k6U4CSBE55mw6FNiJp/HkikbfNjagmjrp
         dHJT9WE7oaYkq9X2Z2CciIPaqouML3+imVqSdbyCrTqRqdaS3e1YSzb20uoqzcK2Td1K
         6Se4kR0v04UyGiuAIJhA0PVk62qA0TJetF/qCgCl7FxhyoTAo+WLkBPJKykpgQTm1iv3
         e1Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714498205; x=1715103005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lm5P6IOa3RMwDfuQvPxY3o2hNKAu49zNJupUAM6VZ+I=;
        b=GppGwiAUZA5tBCJlfkbu4Fmq6/kaXE554YYwEWUHoc/lUg+tNd5ymjh3XM1DWtXZnu
         DhK4jNTkGXes2s/JQZkyFYgjSobqRddvDIoK753bMXfNbsIYCldad2Ca+3JGYxUD4bKy
         PMZ0tuiWq1t2qEu7l1CDlqKBsvhSTq68Mp+l059Si5pmMW9K5ryh4LK2WSmkXXpryDaN
         B6XLnL2I6PauxM/2m2mLtiilRlS4jQnFx3nOgdzqYdk6YkRxE37YY0t0vEXlgdoKkFKs
         nZ1M53zqdVY1NRLcK63wZm+80TnumrTGldBZYqrlIlBzfO4GQinlLVpHp/uRC+7dHWOm
         /tPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxESAp2rYevn71af+agCa9YvI08rI0VVx+c8C2ygY1TjqM5UCt9bLApg2CtlxTjV1fqr6/tQkqhIsgaHneqWWMbLrl7dPSTfb6bMzp
X-Gm-Message-State: AOJu0Yz29TWp9gyqUe+IOcP1c1017iZo0aVZyWBNOKeIpuDx0nzB2vx/
	xG0RCVWNTDLYoZErKQKSs/sZCD4IJe8OwLzreigRUfGcJIr0LAXptg1WjJvcTC5pOQyGI/1kWZN
	XByygt9bB/SkSZRpqOER29d01liNoVxpONOGg
X-Google-Smtp-Source: AGHT+IGLCMJMaJ8vivYqAqjYqyClXYQKm02ht9XqedwsjAbByqHfmkONanDJ93jtdsZ7VdK7yIACdV6MuXJx8gG8bIY=
X-Received: by 2002:a05:6902:2491:b0:de4:7816:e7b9 with SMTP id
 ds17-20020a056902249100b00de47816e7b9mr288420ybb.17.1714498205222; Tue, 30
 Apr 2024 10:30:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240430060612.2171650-1-shakeel.butt@linux.dev> <20240430060612.2171650-3-shakeel.butt@linux.dev>
In-Reply-To: <20240430060612.2171650-3-shakeel.butt@linux.dev>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Tue, 30 Apr 2024 10:29:52 -0700
Message-ID: <CABdmKX15GMPuxoP7pA4uHBo00mVB82zvoQZZ9YDsG4NSTanYaw@mail.gmail.com>
Subject: Re: [PATCH v3 2/8] memcg: dynamically allocate lruvec_stats
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Yosry Ahmed <yosryahmed@google.com>, kernel-team@meta.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 11:06=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.d=
ev> wrote:
>
> To decouple the dependency of lruvec_stats on NR_VM_NODE_STAT_ITEMS, we
> need to dynamically allocate lruvec_stats in the mem_cgroup_per_node
> structure. Also move the definition of lruvec_stats_percpu and
> lruvec_stats and related functions to the memcontrol.c to facilitate
> later patches. No functional changes in the patch.
>
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> Reviewed-by: Yosry Ahmed <yosryahmed@google.com>

Reviewed-by: T.J. Mercier <tjmercier@google.com>

