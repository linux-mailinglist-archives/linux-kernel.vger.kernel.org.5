Return-Path: <linux-kernel+bounces-134508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 562E389B25B
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 15:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB1261F2147B
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 13:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3CA39AEB;
	Sun,  7 Apr 2024 13:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XmxrPP5E";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="81qsvsI7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B6F38F9A;
	Sun,  7 Apr 2024 13:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712497784; cv=none; b=BXG3jD/IqsmttrACwX+O7qJPOCodOUZn31h9G4VW/3jGOkioyPMhQ8xMt2VLYHZDNWbUA+CfdEOJ5NzbY2ToDlMR0OiDhTQ8FrIqbXJ3vLonXYze81y3RZ8OMDWIkfN6BbrhpDsTOQzNHkcj1/JoLmTEBEMPcjenQHz6dZfPAU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712497784; c=relaxed/simple;
	bh=v3i75iLJScUhKZfBYfcOQN24IW7bHaC626D7DjAAoPc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EIfAMuKe/G2ktkvG6pCA4zNFzSmBdkwT8vbFQFJ0+0XFgr9536NOnYGzglJuXeKbc+q1O0T/C4gDR07uhxSjxKHzuNSEVb7tT7RGDXByxgOuXEdu6plxqFQCjXqK3j5yGaBIJlkVJRfmr+JtjOkV7F/PL/NMyFPURokVU9ZyssE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XmxrPP5E; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=81qsvsI7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712497781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v3i75iLJScUhKZfBYfcOQN24IW7bHaC626D7DjAAoPc=;
	b=XmxrPP5EwmxtS63LFefDo0n5JjMRFTZi4spv3XIcauRCiOCFMMzaiX6+tUaMyXw13vTrQS
	bxu9V1M3vp0OcqDsc+IFxESOoeRZvlj14vSmHzXXl9UQABh6XnXS88Vz+40gnRMQ4ga7bt
	MRLZB6orCIvdJBJaGGaJ5zSX/Rn9yGvZ7B1tuXIP7QPYDgL4XNGnmRMHwxX7pBmIpuSMHe
	RAid6DZLf6tiVIkrN8SxxKdgcjFlwRAlqvTOTwAtQZAyO1m2lefCjedmjxnwpuuDonNBHq
	puDytO5UWqsGzuwdHPr1wANuELTME95+CptzXB5sAJs9zMPTnyOi9W1bPdAhFw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712497781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v3i75iLJScUhKZfBYfcOQN24IW7bHaC626D7DjAAoPc=;
	b=81qsvsI7t3qDkcxG48dCw2FqgWztUfZyWdgvqVs/zGUukDyxP1s2vdd55phQQbVw4CNyG+
	+EtKFN2wsieMjPBQ==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>, linux-kernel@vger.kernel.org
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>,
 Len Brown <len.brown@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>,
 linux-pm@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>,
 x86@kernel.org, Anna-Maria Behnsen <anna-maria@linutronix.de>, Mario
 Limonciello <mario.limonciello@amd.com>, stable@kernel.org
Subject: Re: [PATCH] PM: s2idle: Make sure CPUs will wakeup directly on resume
In-Reply-To: <87jzlb8zov.ffs@tglx>
References: <20240405083410.4896-1-anna-maria@linutronix.de>
 <87jzlb8zov.ffs@tglx>
Date: Sun, 07 Apr 2024 15:49:40 +0200
Message-ID: <875xwt8eq3.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Apr 05 2024 at 19:52, Thomas Gleixner wrote:
> On Fri, Apr 05 2024 at 10:34, Anna-Maria Behnsen wrote:
>> queued on those CPUs and should expire directly after resume, are
>> handled. Also timer list timers which are remotely queued to one of those
>> CPUs after resume will not result in a reporgramming IPI as the tick is
>
> s/reporgramming/reprogamming/

Haha. I can't spell either. reprogramming obviously.

