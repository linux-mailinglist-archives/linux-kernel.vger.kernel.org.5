Return-Path: <linux-kernel+bounces-2825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41013816280
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 22:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E83BB1F21802
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 21:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579F448CEF;
	Sun, 17 Dec 2023 21:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AI1u+MRL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C81648CC3;
	Sun, 17 Dec 2023 21:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4E807E0003;
	Sun, 17 Dec 2023 21:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1702849163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/O7tnrRXiqNnUS6mB8Em3vnSBAxRarOdTJFbfYRuCB8=;
	b=AI1u+MRLUMEHXuabkyu74D8nNbH7zXPzRi0YtHOdhTuXfPoe8wK3Csr0bfMSJypkfpf3Gk
	NuquSwx4srQXHt6OFsA1K+NbTlLzStRyQmCcyfeUX0pcx9uGiFaUeo5n55I2sVcpCRiqUi
	Z+9jJSlYqBlOSPfrGRSSsg4EG/9rfB7NS4R4FoxK0cqAScnEsTgefMiEuLkd5fWEMlX10g
	9jXnllhnOm7wd1ovkkwVsXjTA23uWx3JTMYh/QNAI63YeZH/bUlDVJ6VzqcH9F1xgcl/gM
	gApJCLDm9ZQOTguKSjzNwQXw7TCs9rC+jUtkvdoPa8roLGYviMRTsEVTVL/74A==
Date: Sun, 17 Dec 2023 22:39:17 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Mateusz =?utf-8?Q?Jo=C5=84czyk?= <mat.jonczyk@o2.pl>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Mario Limonciello <mario.limonciello@amd.com>
Cc: "open list:REAL TIME CLOCK (RTC) SUBSYSTEM" <linux-rtc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org,
	tobrohl@gmail.com, aalsing@gmail.com, Dhaval.Giani@amd.com,
	xmb8dsv4@gmail.com, x86@kernel.org, dhaval.giani@gmail.com,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH v4 0/4] Extend time to wait for UIP for some callers
Message-ID: <170284892664.25661.2800776178102384405.b4-ty@bootlin.com>
References: <20231128053653.101798-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231128053653.101798-1-mario.limonciello@amd.com>
X-GND-Sasl: alexandre.belloni@bootlin.com


On Mon, 27 Nov 2023 23:36:49 -0600, Mario Limonciello wrote:
> A number of users have reported their system will have a failure reading
> the RTC around s2idle entry or exit.
> 
> This failure manifests as UIP clear taking longer than 10ms.
> 
> By a debugging patch provided by Mateusz Jończyk it is shown that this
> has taken upwards of 300ms in some cases.
> 
> [...]

Applied, thanks!

[1/4] rtc: mc146818-lib: Adjust failure return code for mc146818_get_time()
      commit: af838635a3eb9b1bc0d98599c101ebca98f31311
[2/4] rtc: Adjust failure return code for cmos_set_alarm()
      commit: 1311a8f0d4b23f58bbababa13623aa40b8ad4e0c
[3/4] rtc: Add support for configuring the UIP timeout for RTC reads
      commit: 120931db07b49252aba2073096b595482d71857c
[4/4] rtc: Extend timeout for waiting for UIP to clear to 1s
      commit: cef9ecc8e938dd48a560f7dd9be1246359248d20


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

