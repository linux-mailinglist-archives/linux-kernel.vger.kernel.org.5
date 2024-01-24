Return-Path: <linux-kernel+bounces-37594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C993983B24D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 20:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 083E61C21E99
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 19:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6501E132C27;
	Wed, 24 Jan 2024 19:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tmK96nxQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LHhBzUXa"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A55132C17;
	Wed, 24 Jan 2024 19:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706124633; cv=none; b=FnFbxhmI7K1HcTxFI7uuBs9tsb0RGmhZTHVGKn/IyK7v/nckKjTiXojh2YunQI74sJvbB9y94wgpWwYcIQQkB1S+/wdgiKI5ot1tbhMN7oHWq1wY546fkYt6fQXAe+HN/TQQvUp+MJTBfRZDhcZc8jUjkmgqpoJCWtJ3/kRReDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706124633; c=relaxed/simple;
	bh=1u3OHFUKsLMoj6nNo/lLaEWYCD4x2GtPNzi9YSZpphQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h9NNuq1BEU2j2IMaD/sqTqP9ZG3+03uY+MScLS77k3gmFt6R0Ghi044sEmP7mYoY/40SHJ/2bKILmaFu6z59hXYVgNkTe4HQFCXqlD6pca3nubpbz5JITb23hKqYzNHPkvd0YbsArLrrWRozfj1+j3i7i2vfEJ1cUqiuf1oGHUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tmK96nxQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LHhBzUXa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706124629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1u3OHFUKsLMoj6nNo/lLaEWYCD4x2GtPNzi9YSZpphQ=;
	b=tmK96nxQAX/YB9+fjrx/OJ5hmlwi7UueA1eWVCTsAvFTR4jaLBUtlg3k+ax3366rffDZ57
	qowSgUkwUUgY7cPihGEXKTi9QWqmrPoMdNAmykSKbsY6FLfqiTH7W6LImy90uD+5I7zDwy
	eA9PsvKgy1E4yWmWcc9jWg9cR9mMR0Nk/cdZsTYYueH0uKnwZ6Nh80tNEYS9l/iEQmQfru
	UvOjUDlzPoI2d7XbUZv+z8Dy38vEmO5iEurjEmkBSaWMrlZ3Na9B8b6c/fPjlUAloEmlns
	0G3FuWhZIqjTZVSTvpdtieEh40koAZqbvy66L50XrcrN+LE52jyMe3WRamz2FA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706124629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1u3OHFUKsLMoj6nNo/lLaEWYCD4x2GtPNzi9YSZpphQ=;
	b=LHhBzUXaptA/mhKIl/gKimUtGYuZxk2bTTbsYVnU4nXrnh9W9x/j/j00smv5GIipiOrrcO
	Sq3QHV1zy11gKADA==
To: Tim Chen <tim.c.chen@linux.intel.com>, Heiko Carstens
 <hca@linux.ibm.com>, Ingo Molnar <mingo@kernel.org>, Frederic Weisbecker
 <frederic@kernel.org>
Cc: Tim Chen <tim.c.chen@linux.intel.com>, Gerald Schaefer
 <gerald.schaefer@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH] tick-sched: Preserve number of idle sleeps across CPU
 hotplug events
In-Reply-To: <20240122233534.3094238-1-tim.c.chen@linux.intel.com>
References: <20240122233534.3094238-1-tim.c.chen@linux.intel.com>
Date: Wed, 24 Jan 2024 20:30:28 +0100
Message-ID: <87v87ijzqj.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Jan 22 2024 at 15:35, Tim Chen wrote:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=71fee48fb772ac4f6cfa63dbebc5629de8b4cc09


