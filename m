Return-Path: <linux-kernel+bounces-44124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE70C841D92
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D1FC1C27639
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 08:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30272605CC;
	Tue, 30 Jan 2024 08:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L+yUd3mr"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6615475D
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 08:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706602591; cv=none; b=MFmF04o354wBCSQi5T99fzCbEpshiATArZyJO5R9ZObnaNu6II5caSVdRqIU7fUqmGNC7pg6VKMmU2p0rmRvru+BPUFqoyEJq6JPuUApboDOnRKSU1ClJRxUu7VbBTL6uXyn0SxPmNaqp4U1GiaR0haZI6e8YjIdJlgR7n0/hCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706602591; c=relaxed/simple;
	bh=W/6HBbPlz0lU8PR8pUWua1EAdYFoTclxuLxUjM9mxHQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qxBYEWwIgYTSrotd7zlzKrEJkxyWH18vzfJiVUz66o7ZXZD6gZJx0yOcvwTOPrlrxUdZQ/pWV7dVswJaMkO9D1966UmsbYClC28zgUiJkZZ75VJ+i44q5mvCrjKOxr9crEpo1ePmoXopa1VQkcyJ3JNDZ870fdejThD+JNwFR24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L+yUd3mr; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6029c85922dso73704037b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 00:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706602589; x=1707207389; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4RCvAVC7tbgz/hFRMYluBTQ9bVEmXnGW4IADGAZt7Hk=;
        b=L+yUd3mrZ1fp5ChQyKs5Was/PbosQfoUOY3kK1HOMKHMB29i8kjGGrwWmaLJPvHj3Y
         /XlaIlszxlhuB0t7HkV8lusBAwuBl4NnxQmA9eQ7H7tJBhB8Ho4r5KMh9He8nQGpBrI4
         nDWVeDKX364YRL6/appYNC0/wKr4it+JDgn608DkMmmxqiIYCSdvxFgZxlRPo6n7dwt+
         kSUnpIJnziCqQMxpNNYOhkL1JIJanlhu6XY0f9ygoWIOlbJgnYQKMkTiMUVutOBQees4
         aK5T/U+hqBzTBFeVTk3B0B8ffFuir0/rlKy52tzHBjC3PiWNtnAOfA0is3CYqLRWC8zF
         65Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706602589; x=1707207389;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4RCvAVC7tbgz/hFRMYluBTQ9bVEmXnGW4IADGAZt7Hk=;
        b=WHtjo8U99IVboE99J2n7YlMCW+jUeTSkqgdOmjBCrcTBh/UoZB1EzvR3QQ7/ya3Jb+
         mOTRCqmnnwUNPEsv5e2y7ShCqvg19/CaShfBVZCubmCvSdMwX/0xSW4ovPWxhkTAmrL4
         DWH9u39wm/d4UktcymDx0GRnSw9MYLUt5nZ693j8LqY/pqBZRSS1NjHJ27meqeD2um9H
         8R6DPF7lSHYdxEotlZzdGnH1WMxGlTdZhYfNZi5OXF6ljNTn83rAQxuQ51AZ/SkFd7kP
         /GAx2mjxfOL5yW3gTUoP+icMy82VzEhsFmYxNwULMR7as9W+gJSlAd33I0AYZHsv5sF3
         25cQ==
X-Gm-Message-State: AOJu0YwQSAgNcWde61YGqrioiHV+nzbUoL8JR8VUoOMFa84DVBtiO04d
	MryW/2kog6EDXVrsqGHDD8DIeCyl0GVbwCc5KEFbfRbVTas2G/2VXDbeSL5E+5/geWf/KwE0tI2
	p+VTXs0O1MJBJ3LgcMg==
X-Google-Smtp-Source: AGHT+IGsw4ahRTH+FppmK72b9mJT3O6kGJo/9A82RiTOwc5FThLF65wAN8WNRlKZrrnPjH1+X0DUWXdYHAADyvDy
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a81:5743:0:b0:5ff:88f9:96f1 with SMTP
 id l64-20020a815743000000b005ff88f996f1mr2361516ywb.9.1706602588977; Tue, 30
 Jan 2024 00:16:28 -0800 (PST)
Date: Tue, 30 Jan 2024 08:16:27 +0000
In-Reply-To: <20240130014208.565554-1-hannes@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240130014208.565554-1-hannes@cmpxchg.org>
Message-ID: <ZbiwW5BJhFeGc2Bd@google.com>
Subject: Re: [PATCH 00/20] mm: zswap: cleanups
From: Yosry Ahmed <yosryahmed@google.com>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <zhouchengming@bytedance.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

Hey Johannes,

On Mon, Jan 29, 2024 at 08:36:36PM -0500, Johannes Weiner wrote:
> Cleanups and maintenance items that accumulated while reviewing zswap
> patches. Based on akpm/mm-unstable + the UAF fix I sent just now.

Patches 1 to 9 LGTM, thanks for the great cleanups!

I am less excited about patches 10 to 20 though. Don't get me wrong, I
am all of logically ordering the code. However, it feels like in this
case, we will introduce unnecessary layers in the git history in a lot
of places where I find myself checking the history regularly.
Personally, I tend to jump around the file using vim search or using a
cscope extension to find references/definitions, so I don't feel a need
for such reordering.

I am not objecting to it, but I just find it less appealing that the
rest of the series.

> 
>  mm/zswap.c | 1961 +++++++++++++++++++++++++++++-----------------------------
>  1 file changed, 971 insertions(+), 990 deletions(-)
> 

