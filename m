Return-Path: <linux-kernel+bounces-9543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CBB281C74B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 10:30:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E045F1F23A1E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 09:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F16CF9D6;
	Fri, 22 Dec 2023 09:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PBSph1q0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="omHPfUkR"
X-Original-To: linux-kernel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C35DF42
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 09:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1703237439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QEyEb4u/8xp+vv+XYt8VRVb3m0bgvQlT7o/+c64PqZU=;
	b=PBSph1q0PDgmtMStXRc65dh2bpBQtJWWYmSZPunDJHf+6XlZP1TYLnlSpCCQUrJRQIrJjS
	gH+wj6EPwHEsVL9Sviy4RbmIFfCHiFff7aFClIFnMOnCVKTKEgHIbCGF/pZ5Eq+WkxuDQZ
	h5uyIRclGDx8GcsBf+SzrRiyyryLL83sI5gJQu69mYaEOixZVm2pJbfIEVjZoLAIdJ1FMR
	iGxA8A+/wrQAC/JwAIVnJJNLA9xS39bPoLf1PpAjbHAB6of7WRMWRstbmB23ezoJWGyMDV
	UiTrfyzwoQoqdC4kHMbcRRGtl8AnGClaMXUKaAyyFCLuDv6HjSmX7XE+evP+mA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1703237439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QEyEb4u/8xp+vv+XYt8VRVb3m0bgvQlT7o/+c64PqZU=;
	b=omHPfUkRisLufNO/lGu829A3yoMxzYg+fTcPV/L4a/y1gw6KSFGOK/PK+JwugYDGRPURIM
	tihysJegaPEeSSAw==
To: Douglas Anderson <dianders@chromium.org>, Andrew Morton
 <akpm@linux-foundation.org>
Cc: Petr Mladek <pmladek@suse.com>, Li Zhe <lizhe.67@bytedance.com>, Pingfan
 Liu <kernelfans@gmail.com>, Lecopzer Chen <lecopzer.chen@mediatek.com>,
 Douglas Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] watchdog/softlockup: Use
 printk_cpu_sync_get_irqsave() to serialize reporting
In-Reply-To: <20231220131534.2.Ia5906525d440d8e8383cde31b7c61c2aadc8f907@changeid>
References: <20231220211640.2023645-1-dianders@chromium.org>
 <20231220131534.2.Ia5906525d440d8e8383cde31b7c61c2aadc8f907@changeid>
Date: Fri, 22 Dec 2023 10:36:37 +0106
Message-ID: <87le9mk2iq.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2023-12-20, Douglas Anderson <dianders@chromium.org> wrote:
> Instead of introducing a spinlock, use printk_cpu_sync_get_irqsave()
> and printk_cpu_sync_put_irqrestore() to serialize softlockup
> reporting. Alone this doesn't have any real advantage over the
> spinlock, but this will allow us to use the same function in a future
> change to also serialize hardlockup crawls.

Thanks for this change. For me, this is the preferred workaround to
best-effort serialize a particular type of output. Hopefully one day we
will get to implementing printk contexts [0] [1] so that message blocks
can be inserted atomically.

> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: John Ogness <john.ogness@linutronix.de>

[0] https://lore.kernel.org/lkml/1299043680.4208.97.camel@Joe-Laptop
[1] https://lore.kernel.org/lkml/b17fc8afc8984fedb852921366190104@AcuMS.aculab.com

