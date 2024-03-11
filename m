Return-Path: <linux-kernel+bounces-99595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32319878A94
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 23:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C46DB21311
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 22:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABDB557323;
	Mon, 11 Mar 2024 22:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="loAP312Z"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3684206B
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 22:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710195127; cv=none; b=ECWmenoUzBhPL8tvs9wnvUocwQq95pSBT6tVcwHToPJTTTHefXtDRhPAZp9HkuCbpBYxvRtCHJe6tDkYPU3YfHyB240jL1EMjkIbptf0QNZWWvyt35HJRJ0gwEJmbOs/oOziAspGTI/jKMs2cPpTRVlCn8aLMzxIzCX39EGQtIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710195127; c=relaxed/simple;
	bh=v5GxWvxK/VaGQFMhbfA/trm2HbQ4kyEx9JBhc+nbtKQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JfNzRgwOEDHa546u5iiqkyFXeRPsngJ1scjdVNMRd8zWjQ5S0CHMnmAcehxR0FRkjjDVD31G0QmxpAEwbYp7HYptGMBHBU8ixJWNJZ5suYzgdeTkqAoAbz9XLy0gtwU1gwEUxkGF8uyxuAUuJZaDuXeu9cApvz+oBvudylnxlkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=loAP312Z; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-609ea26233dso79114847b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 15:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710195124; x=1710799924; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=v5GxWvxK/VaGQFMhbfA/trm2HbQ4kyEx9JBhc+nbtKQ=;
        b=loAP312ZmPf1DN7YXsX+EN3bRbvv5Id/Ef2U/Xc8Mk5N7WVnmWUZyOpbrEgVfYVMRk
         lFAJj4TEeanAR0RZIpAw72ueR+5mXxFWfZW0fdKI6ZEsWcz9HIv3ACDDUdxx2Y88bC26
         BDXlPSWDaQLbW4jYWM5HStDDXqFAoMUP8zaIccqWRgnXWNgCicMdxFWRFjvXt5mu/l77
         PYq3GSrkYZVOl7NBQlGwAiX4aNYQpX0GLgEK5VAYwmuhxLsD1FNzpGFau3UHvEf0jzo2
         48HswPbJNqYpwagCzJPwUHpYkvNtzD3cuMU9Eou7cWMN8sjzzxlXolsGHETV447wiEDc
         xuXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710195124; x=1710799924;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v5GxWvxK/VaGQFMhbfA/trm2HbQ4kyEx9JBhc+nbtKQ=;
        b=fWFyA5ko0BbtZQh6xMrlU/6bxMfEMTym/e97prUVx3tGvrr3sCLi0oInByKFVkZBZb
         im0itEC8bINDmKvmkdTF8cOj32hTNvjWPKS4UIKgFXJSYq2nlTeGUYALibhrkUoxNVxV
         yt+TnIuvpwSgU3gqxQGXj1E+TqvZ7jED34yxltMXYxW/UFnTKBt7+uuHdeGzbCRRlEjq
         SOPtWKHNRn9xf897Le+v0jhZAX5UxZ/I6mrQNjEhRZgzFfquC9s+yD34YazVk2u0GCNP
         3Yoosas4J+GfGKAfmhj2T+kdQfzKFYkUDnrrpOr818Xaegyf8FTrjOnsMfT3ETOG48g5
         bOxg==
X-Forwarded-Encrypted: i=1; AJvYcCXg2+QHvBkS8O/Fftk+AOxhFJBrwOSqx1vtaoTthbfU07qo3+x+h4r2ffNXMkA6bzhrh/VyDLc2goJ7I70imi8imu3mysk2xyOtstN+
X-Gm-Message-State: AOJu0YyGEdTKiJcaNQc5BvTIziz5s0V9x5HT4H8T8obFWRwKcLXSJX0R
	PGR2dLyO0m3NrhlMEAiwKZYlbWVYUnKXe7bG8UG2qPBkVvz2S+Ex3fgQW/VCOB7iso3vw/2fWRS
	aBhRAolEpHQXjEZMHFg==
X-Google-Smtp-Source: AGHT+IGgx7xurLeRDpRn80TycPbRzMMOYzvOM2OL4tmAl8caIM9VNaTFrJMB6dBqErDAhQGbxg0elgyIL6von0KR
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a25:81c4:0:b0:dc6:f877:ea7b with SMTP
 id n4-20020a2581c4000000b00dc6f877ea7bmr2168181ybm.9.1710195124585; Mon, 11
 Mar 2024 15:12:04 -0700 (PDT)
Date: Mon, 11 Mar 2024 22:12:02 +0000
In-Reply-To: <20240311161214.1145168-2-hannes@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240311161214.1145168-1-hannes@cmpxchg.org> <20240311161214.1145168-2-hannes@cmpxchg.org>
Message-ID: <Ze-Bsr8lfC1lm1u7@google.com>
Subject: Re: [PATCH 2/2] mm: zpool: return pool size in pages
From: Yosry Ahmed <yosryahmed@google.com>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <zhouchengming@bytedance.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Mar 11, 2024 at 12:12:14PM -0400, Johannes Weiner wrote:
> All zswap backends track their pool sizes in pages. Currently they
> multiply by PAGE_SIZE for zswap, only for zswap to divide again in
> order to do limit math. Report pages directly.

Nice. Although I would prefer renaming the zpool interface to
total_pages and renaming the zpool backends functions as well to use
pages rather than size.

Either way:
Acked-by: Yosry Ahmed <yosryahmed@google.com>

