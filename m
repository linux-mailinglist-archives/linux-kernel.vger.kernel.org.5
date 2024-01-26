Return-Path: <linux-kernel+bounces-39498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8104883D219
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 02:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 692A11C20A22
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 01:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12AF810F7;
	Fri, 26 Jan 2024 01:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IanaUHsb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B7964F
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 01:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706232896; cv=none; b=qf6SlzrgmuYCHVmoWzcEJf+zl/rKktAPvJ2ANPJu0+5OHZpzGIMeSZotWYP40hARd9gF59PQjVOxpV7xnahP7XG8Bm8itKJm2gKjjct3C+j76+LPAj4T9V0LZxtI6Wsxwaz7N3hkYOICA+HDdlkxBIF6GEIJugTb9VZc3SLlUQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706232896; c=relaxed/simple;
	bh=afoAW89H08rslmzulqbZV8XGWxbnFdKdmZKuI1WAsP4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=m0CW7DgR4AneTIBst+BzHiQPzLSdjFoUEQeP/9yRoWxnhgtesMj69ODUMSBIJuZkbtcLRPgjllQNYYGE3ZLR3N9ETAh90my4bcrTfaCwptMIDOMRAUmoQQFaIg6aE3e+Bpozld8PWWEJ/LllpU484VaDwCT4BH3ZAkLtyPew5B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=IanaUHsb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 963F9C433F1;
	Fri, 26 Jan 2024 01:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1706232895;
	bh=afoAW89H08rslmzulqbZV8XGWxbnFdKdmZKuI1WAsP4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IanaUHsbwsrPyXz0XY9VEXXk/gyZBy4mrUr33oo2NC24Ta1Q3FzFfradVZuC9IRKZ
	 knaIeGfU+HOmh2HFBoWNHLsUxN2b6q33uRtLmh74swNkkK5ys4VU8Xtsk3e2esq4gz
	 UeDCfGv8BTlY7sD2R/k5eipIs/M0lXV7Bf0LGB4E=
Date: Thu, 25 Jan 2024 17:34:48 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Alexander Potapenko <glider@google.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 kasan-dev@googlegroups.com, Marco Elver <elver@google.com>, Dmitry Vyukov
 <dvyukov@google.com>, Ilya Leoshkevich <iii@linux.ibm.com>, Nicholas
 Miehlbradt <nicholas@linux.ibm.com>
Subject: Re: [PATCH v2] mm: kmsan: remove runtime checks from
 kmsan_unpoison_memory()
Message-Id: <20240125173448.e866d84cda146145cbc67c93@linux-foundation.org>
In-Reply-To: <20240124173134.1165747-1-glider@google.com>
References: <20240124173134.1165747-1-glider@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Jan 2024 18:31:34 +0100 Alexander Potapenko <glider@google.com> wrote:

> Similarly to what's been done in commit ff444efbbb9be ("kmsan: allow

I make that 85716a80c16d.

> using __msan_instrument_asm_store() inside runtime"), it should be safe
> to call kmsan_unpoison_memory() from within the runtime, as it does not
> allocate memory or take locks. Remove the redundant runtime checks.
> 
> This should fix false positives seen with CONFIG_DEBUG_LIST=y when
> the non-instrumented lib/stackdepot.c failed to unpoison the memory
> chunks later checked by the instrumented lib/list_debug.c
> 
> Also replace the implementation of kmsan_unpoison_entry_regs() with
> a call to kmsan_unpoison_memory().
> 

"false positives" sound unpleasant.  Should this fix be backported into
earlier kernels?  And can we identify a suitable Fixes: target?


