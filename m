Return-Path: <linux-kernel+bounces-44090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0655841D38
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:09:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90A3C1F28646
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 08:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ACEB56745;
	Tue, 30 Jan 2024 08:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c3+qteXU"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2006256458
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 08:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706602153; cv=none; b=PTwRQ5MZAbcVg9/BXO8nZv05+sT/Gs1pIoOkxqM8YruyrKaJ5/zhYZEZiyXrANAeXQp65pd9kuMMSVamjgiYOw8j5K78zKWyBrITSEPsOzXa1jznZpbkH80Fm16jD7fDZNkC4Q8MR9nh1XXt1+eWaIxIbY1S1qeIg38MCfv2c7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706602153; c=relaxed/simple;
	bh=2hdEfOzmfy/PAu/6/sRbuPHsG9WwBSuTwelhKhCYlSg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=So/drT/8DHbEJu7PUabeJPzBcyjPLNZIFI9L4zZuV57ybznO5nVELIiNe0e+5kmE9aK+/sOd3VKFoDrXaFkuMv/XfWVDPP7/TN9FwqBW56OgWCc0FyGVf9Rjil7PXnL8qjkGGKzpSpxSKMeIbP535ERM0gIX4Tzh6uHD941dEFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c3+qteXU; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbf216080f5so6924477276.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 00:09:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706602151; x=1707206951; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wadulOai/RifuJLDJH2jCf6SHw9z6KefnQWpuLynjGw=;
        b=c3+qteXUABj+7gz4gqXGLEg/fbou5l3J3kg8Gq3OcOtH84tc5DKaWopWu5WDx1Iazn
         EBrAYi5/K/IZyirrQt2D1cBLwJ+cLgrMqV37gQeecVwfZeo68OTQzGPnlN4V5gZdLG+j
         teRBzxrymKV8quQpAZHozFp4yOd/n8RhZGCuIhC1CP0H3pbjc7u/VVHxiv5l8seqetpk
         LUst0qasW74BOP+x0IAUiTzsDNH8MqP+OPgiicYlyD2s4i6qeEMAcy+ddbrw+ByaGPsz
         2hBT+S7n/AxgBPrw24BDjrKFVeBYr9Pgj0HEQPa84o6gfye682rgU5u0DdC9RxiHyIHO
         ffEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706602151; x=1707206951;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wadulOai/RifuJLDJH2jCf6SHw9z6KefnQWpuLynjGw=;
        b=eshP93OMjyh3p4NsCLci6SQaRBSYrGeWwUO1SaOQYMiMJMEUfErgydqKKf0oUEkrXw
         2fWVoxnCCp/2YMbHIntU6gBo/h/z73qadwughHbqNmcWNQ/q1iVmU2fFvdo98M0X0K3C
         GXyP3GIUMqeyPittqZspiUOxJtNsup9Mo+jwMxUBvwcL9davFSPEQCwgCjoMIcYqo80C
         ls5aad9HamIgPxdm4ncsBl0z8jpjpNsIJHlWkxCXpv3ckOTHfbYzwUQ+gF6EzkMtBMkC
         K//d08x/kozWwaTjMlhz0DwwctqHobGiE+nAFc9rdztAN//S6Y16We2Wlmm5QXiLH/Rg
         iZNw==
X-Gm-Message-State: AOJu0Yxcu4H4fDiiUcfzSKc5BMraXHbXtvSpQImqk+7HvF02TV3zjqcr
	o4hwf6nTwbwtV1jJ1ojUic22C69UUn6mw/azRtSmc5TlRJ10V/z5rdT4pQtbVbSwBSQ5nC/BRrA
	KscRjZv9YU5eER+1+Dg==
X-Google-Smtp-Source: AGHT+IHL/5Lz097nGM8zB4P1A/2LKJrP96zKj54PtSx7SVH3g6r9JXbeydvgbaKwh9g3E/qpgEaQb2wpe7WFLfQW
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:6902:118e:b0:dc2:550b:a4f4 with
 SMTP id m14-20020a056902118e00b00dc2550ba4f4mr2673421ybu.1.1706602151135;
 Tue, 30 Jan 2024 00:09:11 -0800 (PST)
Date: Tue, 30 Jan 2024 08:09:09 +0000
In-Reply-To: <20240130014208.565554-3-hannes@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240130014208.565554-1-hannes@cmpxchg.org> <20240130014208.565554-3-hannes@cmpxchg.org>
Message-ID: <ZbiupWuqcdlpadqk@google.com>
Subject: Re: [PATCH 02/20] mm: zswap: inline and remove zswap_entry_find_get()
From: Yosry Ahmed <yosryahmed@google.com>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <zhouchengming@bytedance.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Jan 29, 2024 at 08:36:38PM -0500, Johannes Weiner wrote:
> There is only one caller and the function is trivial. Inline it.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Yosry Ahmed <yosryahmed@google.com>

