Return-Path: <linux-kernel+bounces-154027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A88068AD643
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 23:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63E7B281832
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 21:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05891C69A;
	Mon, 22 Apr 2024 21:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1ASENwX5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Tinc4AlQ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8B11BC2F
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 21:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713819695; cv=none; b=ho+b5PvUG3ArRJg2maF5GCUSU+lldzXIll78mTEiegdP0pZh+XgkJvkIqEZewrXeRU6L5EQrTBIYRbD75k72+u4zXrN0vysx18EwuPaDPCBJkCKE2xhgJfyzNuHC7bC/19I6nrtgTC5Ws4MWGuVVAxHq0Y0dlGrD8/nIJtpQL9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713819695; c=relaxed/simple;
	bh=P9tlWVK03HHRVR0tC6CzlRkK98bzbO2aLk8UJH3mta0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bEda7z9dbOKKXURPgGaoXjjkfpze89EHb31dag4mpJc8Zx1fa0DcsARvrRPdMv6L8JvBIKDhgZxQf9CTIwxMo/KvUez/IwUWbeI/odz/DB/Jzg2hcRO3WzcLoxD+aW2UU4qYHVuJ9A7KDnS3V20w75B9yAgoG/khKkAqCUka4Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1ASENwX5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Tinc4AlQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713819692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=abZRkZYHaRlLT6W1Ts1dsblSbaybz8XvJ+AU+HGstm8=;
	b=1ASENwX5bLFOcgs4FdtFyKE/xVBFFpXnySOMNiiAyvTQ5m0peZnlFp2+I79p24TbrqScIl
	y1dDn+aoYGnudsnV1dpNr9AWzJt8r8z50v0u6suLlV35xP+MzWaSqNtuE3Xfsg9wry5ldp
	KAP/rgOhlNW1NGtHvQnys4eo5xd/Zqfx80hjj31IdG3VgKjRuFyFUN8ryi9INDsKkiEMqk
	4GS6Lobuz9BOigBFbtP3raYkbmIR0SUkQUY7VTi9X+iZV4Otz3XUc0fhvvGh5F2atwxvyK
	8BhGvehcOK5NW05S4+gmcg4u1Ubf3Ol7PCLeowptvTT20mCGaBFd5AplatZSOg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713819692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=abZRkZYHaRlLT6W1Ts1dsblSbaybz8XvJ+AU+HGstm8=;
	b=Tinc4AlQdLMVfOtM0E9FyPF42kUCCqtXWf7OHksEhmMbYWCRQz3Gdqr0DSSr0t+NMa8EDU
	2XJ4JGFmdnCC+PBA==
To: Jinjie Ruan <ruanjinjie@huawei.com>, linux-kernel@vger.kernel.org
Cc: ruanjinjie@huawei.com
Subject: Re: [PATCH -next] genirq: Reuse irq_is_nmi()
In-Reply-To: <20240417085616.3785647-1-ruanjinjie@huawei.com>
References: <20240417085616.3785647-1-ruanjinjie@huawei.com>
Date: Mon, 22 Apr 2024 23:01:29 +0200
Message-ID: <87r0exun6e.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Apr 17 2024 at 16:56, Jinjie Ruan wrote:
>  
> +static bool __maybe_unused irq_is_nmi(struct irq_desc *desc)

Seriously? What's wrong with static inline?


