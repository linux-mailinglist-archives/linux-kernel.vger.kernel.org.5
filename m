Return-Path: <linux-kernel+bounces-1549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D622F814FF7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 20:06:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 040321C21A14
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 19:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA7B3FB37;
	Fri, 15 Dec 2023 19:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DCgKKAs9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="M/ib60cs"
X-Original-To: linux-kernel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7E73FB34
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 19:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702667161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I0hHN3RnKj4ClKstTe8LPIswNpLId53VLjBBZOC5iHs=;
	b=DCgKKAs9oL7sERRcO8sIomMuOWsEMgeyqtxUPX9sx9sXSsABGqpSHt1MpK7pGPv6GydrZL
	OyRUIn92ltypPaAqPNi9tMsPpMA9ZyuVW/4UX6lEhTyiwhaq1p6JN4Ac8qOhBeTtd9hGok
	fLVX4MYPqWNZ3/4c7xRwgLiilEzjR+2JGKRrRZL/ixPVcwsKBRUtCOkha5Dk60IZBN81R2
	bM8mGaKFTF5GxTgsiHGvZSgzogZpzIeJKk9+aCg30Kfyj7pukdplmkHYT84NhNtfkq+wGv
	MTbDmKjgVVNrp02I4mYlqChmZOmE7FKaTBfITb1asjE+UWLLKwDyTbbdR/HszA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702667161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I0hHN3RnKj4ClKstTe8LPIswNpLId53VLjBBZOC5iHs=;
	b=M/ib60csaRtPn3fF/G22mmT0S5E/sVbk0NqIHN4+WrCQjp6pfJM13TKqt8PHbI1KOM9qKx
	els4oGs/fA2RVZDQ==
To: Sven Schnelle <svens@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski
 <luto@kernel.org>, linux-kernel@vger.kernel.org, Heiko Carstens
 <hca@linux.ibm.com>
Subject: Re: [PATCH 0/3] entry: inline syscall enter/exit functions
In-Reply-To: <yt9do7etw5se.fsf@linux.ibm.com>
References: <20231205133015.752543-1-svens@linux.ibm.com>
 <20231206110202.GD30174@noisy.programming.kicks-ass.net>
 <yt9do7etw5se.fsf@linux.ibm.com>
Date: Fri, 15 Dec 2023 20:06:00 +0100
Message-ID: <87ttojmgkn.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Dec 14 2023 at 09:24, Sven Schnelle wrote:
> Peter Zijlstra <peterz@infradead.org> writes:
>>> so the time required for one syscall dropped from 94.8ns to
>>> 84.7ns, which is a drop of about 11%.
>>
>> That is obviously very nice, and I don't immediately see anything wrong
>> with moving the lot to header based inlines.
>>
>> Thomas?

No objections in principle. Let me look at the lot

