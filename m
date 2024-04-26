Return-Path: <linux-kernel+bounces-160480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 077D88B3E13
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 19:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38CC41C223A3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057C21802AE;
	Fri, 26 Apr 2024 17:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fqf2dZBV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gMdtoM3w"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9ED1635DD
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 17:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714152195; cv=none; b=D+XIhMIzC21VEcVBma5/auQGRj/SRONRJSHjOYKEB9LjbQfzHKxaXCmN/4XgtVSueAhMGj0ZxDQ/RV34kexusVOzI/dW/Z5/9lmMz0DOymdM0h8YwWCQcbXCp3XhoavZvB6gE0lKNDbCg4txpJWDcc36mgsg/+gNz8h3+Zfho70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714152195; c=relaxed/simple;
	bh=8c14yDAPeO5YUURLeNl2uwUPQd2O+PB2Dd7K4zo3CIk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mZQIxrTCV8zrv4KeABHngP6gAJEP8iA29IYINXafBxFiu81JYH0jBMdLm8QjEjUO8a1Lu7mwala8pD4liIyqajX6I44DiswImB6SgZg7whMYKcUOIaOI9ysHA6KaMblKlMe9rAIkgpnbVmP3y9GsskQeFHD2e3Ut3uDEetA3Nko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fqf2dZBV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gMdtoM3w; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1714152185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Phh2SQgb1fDjrQMMKRxrCqZZm1HdbdAFSSyGdV9+ugA=;
	b=fqf2dZBVlGkKUbdpZcudTUm0uT1c1sMhmWzvD/QNDKLEDyIwgBtrTpKV1lwZI/YY2nR3CY
	c/x3uaE4VnMCTLR7+Xe6ujJN86J9gaSFaAP0T2kQfKnODpGOZwu50T2fWfT6G/YyDdLWLI
	5M689pfHpDsC7o0ZMj7WHfeXALLR7NBXytpN4uE4tT/Jmp81Rntq1baUJkpPDrU1MtBbME
	Ud7MrNHSBEBVQemvwbwTXuwzNOM60PWEZnj+yNd6OGaux+PUZVNIpZiF1ZDnfReqHcFeOm
	APuYvUeBTiEVmxNJGn91j/HPf2geAduKl9OJYLrjIF6DdE5F2jzzi9PB4+OB+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1714152185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Phh2SQgb1fDjrQMMKRxrCqZZm1HdbdAFSSyGdV9+ugA=;
	b=gMdtoM3wBIlQpsXyJoq2ixOBd+w1J5liSuqrNWF1n+43jaL3sfpG6Xia2mYierh5gkafjH
	1rxMnsBoofjEodCw==
To: Z qiang <qiang.zhang1211@gmail.com>, paulmck@kernel.org
Cc: syzbot <syzbot+dce04ed6d1438ad69656@syzkaller.appspotmail.com>,
 linux-kernel@vger.kernel.org, peterz@infradead.org,
 syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [kernel?] WARNING: suspicious RCU usage in __do_softirq
In-Reply-To: <CALm+0cVvM56xse8ejf7+Wro+XBkFwY-MO1jyhWcVU8BWaZ2qjg@mail.gmail.com>
References: <CALm+0cWx1kYtftE4nj7Jjgx2_bmNmSrBAgd36ksSvxJtNVhxHg@mail.gmail.com>
 <CALm+0cWRC1kqLJvmEqda4O97PZ-n0R0UQ35=fi6oA3rLsPoUSQ@mail.gmail.com>
 <8f281a10-b85a-4586-9586-5bbc12dc784f@paulmck-laptop>
 <CALm+0cWN0+cCsYddBUefya3aUw9c9Xn89GVV=Ys1_UPjS19WrQ@mail.gmail.com>
 <4c09abb6-4f6e-42d7-9944-c5da995649cb@paulmck-laptop>
 <CALm+0cVaLfE2ieK9aqh9yHkPDyO7zWbMe9K6WjTUgm4t9SnSFQ@mail.gmail.com>
 <ac7bf2c3-c752-46db-a5c8-0c55a1af8561@paulmck-laptop>
 <CALm+0cXGBPWxiNOkAoQG4hdnKCeVVR-APbfBPk9OGeU2RW+bKA@mail.gmail.com>
 <87o7a1umj3.ffs@tglx>
 <CALm+0cUesD9KaWyfsRUyGdErbrU11sAfRgRR=Qjyz7Boq9Vt=g@mail.gmail.com>
 <b735d174-8ad9-4ace-86ee-75dc09852537@paulmck-laptop>
 <CALm+0cVvM56xse8ejf7+Wro+XBkFwY-MO1jyhWcVU8BWaZ2qjg@mail.gmail.com>
Date: Fri, 26 Apr 2024 19:23:04 +0200
Message-ID: <8734r8t4w7.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Apr 26 2024 at 10:09, Z qiang wrote:
>> This looks quite nice to me, especially given that it avoids changing
>> all the other calls to __do_softirq().  Some architectures might want
>> to directly call handle_softirqs(), but if so, they can send the patches.
>
>
> Can you send an official patch? or I will send and add you to
> Co-developed-by tags.

Just send it along with a nice changelog and add:

Suggested-by: Thomas Gleixner <tglx@linutronix.de>

That's good enough.

