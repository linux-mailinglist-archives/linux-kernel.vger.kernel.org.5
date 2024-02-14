Return-Path: <linux-kernel+bounces-65974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1779855497
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 22:17:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FC1D1C22069
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 21:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 370B913EFF0;
	Wed, 14 Feb 2024 21:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UKF+PNn8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0aU+Oy+C"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E39513DBBC
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 21:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707945472; cv=none; b=uCoFYN1DoblVUjYv8fQSJBSE1jL+tGxr/D66QRwGKhq5vcmsUL38+Uqy7CTxcFJYJ+axQfkh4SHWn8oJ+X7ZiczOmvG7DqvRPDH86K2EoiP8dM4YkYOzIZ/gzL0PepRVdp3Fnn/ymyCNgjgXKsD0C9CVNOKobHLz5feFp2NpwHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707945472; c=relaxed/simple;
	bh=bLK1FUTfjfjqJ+XMlBoekFKEfUom6YwKZGbKITi11Es=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YS0bitQRDUmQJP+Bo1ZSQoEDJdrYHw4OtNSFIHCzlKGqUQdp2ejIJdRDpZ8nbzuNRzqLywl/B+sQZIZSfnU2N0auRBXzFGqr8BhJXzOvgensclumeDCN5rzOKVQCWjzSsXi286mXHJRe2lHxNsXBDJ8dr9JgsCcV7JiOgGFS/y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UKF+PNn8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0aU+Oy+C; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707945468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=opSllZKUk7NWC9U/6M8Qt76Bf2i6F6gWzjl2KYfUpMk=;
	b=UKF+PNn8pGTPSvlFFheeKZQwKtYQHSzW5wAzGa4OJAGlCLG7mUl6sSQCZTPym2FzqM3gmD
	YBQTgiVIwnL3G192RppEcrRMbHYgx8lci2kJvVSnAgSOLISMe7CFk1BrUI7bCo7r600NPg
	rSgbGOV5f3BmLVESGu/NEVV5di/S1kzHlO8vMdG3Zw6B3PLtlO/8YWJ5hiPp5nwaEubinB
	FHD3WNkI47IN9DE6C3Bc/F6DAtgIQayMdMr9VvaiZr/Ey+FHom/pHyOkUOuWP1xn9+rvjs
	F447toqylCJXQnYRvQjaSJtdHeeua3lMt288wWYrfDnuXZ2sa3prJn4R7FaJNg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707945468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=opSllZKUk7NWC9U/6M8Qt76Bf2i6F6gWzjl2KYfUpMk=;
	b=0aU+Oy+CbfFNIV7H0+b6rcJUANEn2ck+M5MTFSDJ42fJQMPG5g3YyDADxIB3Dqov/bOqhm
	VfD3mwCB4fD6zcCQ==
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [RFD] Remove irq_timings
Date: Wed, 14 Feb 2024 22:17:48 +0100
Message-ID: <875xyqg2yr.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Daniel!

It's 7 years now that we merged irq timings into the kernel, but we
still have zero users for this.

I'm tempted to declare this experiment failed and remove the whole thing
for good.

Comments?

Thanks,

        tglx

