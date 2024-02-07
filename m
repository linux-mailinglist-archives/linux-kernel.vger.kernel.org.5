Return-Path: <linux-kernel+bounces-56428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA0184CA05
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 12:56:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F35A1C24016
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02ED1D531;
	Wed,  7 Feb 2024 11:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rtvLJbtk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UbcAGi4+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CA01D526
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 11:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707306963; cv=none; b=QDRnIMaPdVE7aQET24P2dlqB74UPPmRrF2Yd3YcVPgaiFHjogpfvqLHqIVn1i0JUwfrme42vzVvFDr2C5b5huBwAiF5qDmr/kOHCs6AbDvWOOyW1Ie9r5bJ9tjQ6uiPM7nCuviwpFKVlq2ziEvYWmg+ZMLeOfhbNEyknUsHl01I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707306963; c=relaxed/simple;
	bh=p6e5+CcagT7mZdPGxmlcNs00g9JR8KPI7wX6P61SMjA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VB7SIrdIB2TXk6SnlcoCV5qxE/8B5tjQ0NDuXh1AQv0GklwKxo9Y1r3VcVUt+bZFJWQxBfmaDbG/NFGDa/oSc4LQT0ntX4mCBQPlpq7/Qt1B+znwvVBldcQys8e9d8/wwvoQl3OlUTjhawntx/lY3XvGJEZEDv+7REMTLi+prOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rtvLJbtk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UbcAGi4+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707306959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p6e5+CcagT7mZdPGxmlcNs00g9JR8KPI7wX6P61SMjA=;
	b=rtvLJbtku8q1PYV6vYD2/lGmm6JsocTQKtulqqtqHbfq0hga1J7K3F8NDrJ+yQ/SqmXhQ1
	Rw0Ft6PGbY9E0TAFkM+t3VT3GPBV69Ncn1eZZSxUMUBZB4PI5CHaKaYwH0f7Onkh/karpj
	J+w/YAbzijg/VjYc6qDlrW9wSorL9GFmEBZO5oTfIYkcC7wjyXtFzZu7HtoRJI+U4qJYjs
	6witAEz9aVKzs6fv2JmVPt7KAtWiTHgbJ55j56ce9/lL0fW90C718wPHY4iLrGPDJ87cjv
	VKyhYHO/Vc288ql0aD6Kx/di57wYUTSuBLFXpklbok4BPLF+YJW/vpQkLgRt3w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707306959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p6e5+CcagT7mZdPGxmlcNs00g9JR8KPI7wX6P61SMjA=;
	b=UbcAGi4+IISA2RZxscQ6tIffq3Z2YoHSlAhbIjJ+75a5shpMxXqqzD1a91kDi0gcUYalUV
	mb9I55T09QNFRRDw==
To: Marcelo Tosatti <mtosatti@redhat.com>, linux-kernel@vger.kernel.org
Cc: Daniel Bristot de Oliveira <bristot@kernel.org>, Juri Lelli
 <juri.lelli@redhat.com>, Valentin Schneider <vschneid@redhat.com>,
 Frederic Weisbecker <frederic@kernel.org>, Leonardo Bras
 <leobras@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Marcelo
 Tosatti <mtosatti@redhat.com>
Subject: Re: [patch 04/12] clockevent unbind: use smp_call_func_single_fail
In-Reply-To: <20240206185709.928420669@redhat.com>
References: <20240206184911.248214633@redhat.com>
 <20240206185709.928420669@redhat.com>
Date: Wed, 07 Feb 2024 12:55:59 +0100
Message-ID: <87jzngmqsw.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Feb 06 2024 at 15:49, Marcelo Tosatti wrote:
> Convert clockevents_unbind from smp_call_function_single
> to smp_call_func_single_fail, which will fail in case
> the target CPU is tagged as block interference CPU.

Seriously? This is a root only operation. So if root wants to interfere
then so be it.

