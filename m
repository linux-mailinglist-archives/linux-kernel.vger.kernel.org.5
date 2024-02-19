Return-Path: <linux-kernel+bounces-71458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F49485A593
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:15:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33F5F1F22518
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 14:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5258374C4;
	Mon, 19 Feb 2024 14:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="g3058xB3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dmkN+fQY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2D336B16
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 14:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708352114; cv=none; b=UnMFNNPibtzuNTkp7FATbkILC7nF2Yk6rZjitvyDATyZq18NiyOo3NN2+XdZ18b6ZwKFQ++0McesIs1dYTaAMhjimb7Rd6B0gDydVcnXnvCFYWc/Zd5TpvmbgaDA0VEE4DSFb6phQ5kPSSTFRVToT9hKovMHvrhAzPRMcZkTjII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708352114; c=relaxed/simple;
	bh=Opm59fu5aL0vnD0vEzI9XMh5NvLNjVb0OWvnK+EGUS4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tiiedvHQAf8DLDPa+kLXpmh0lXJuanz1KjgSEBqUxjdXzc96A0pPDA0f20h4D83fQ/fODxt/pK+9XpOyAN9+qiVsvh9HMqkcspVHEiiU8gaxHImJXkg+EWqoWFdKKsbgHsjBNM9RyKFOt9ZgIlwoDilWjTCkg7nxAiTjYP6/F2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=g3058xB3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dmkN+fQY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708352111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZrEhadgcarWSoboKUlIaV5KpZramrM7a8/luxhsynnU=;
	b=g3058xB3g2D4ge8VPLG8xJJ3ubQNmczc5lMx3eRC9WML6Bn/n0R5HS0TcXkrIgDVDQomhd
	rbnZUipWCWWAzdvk/d1MOG4iHLzpoMgdZ2g402d5w/dTLlmvpSfWjjV6/Dat7xHNcFkfIo
	bC9y89arVJKk27Slk53SatrqpgaMQP7pch7FxEohuNwCTop/zq7OEYu6LvQoYgqTr22fWf
	s5dpXaDcfDQU80tz/MVJseYuV3pvKICgy/DmX3YKFxv26Web5onwm1jNQNlZSzEreA0xuL
	vZZRlGDAWyriJtGoMc0tT6Uk+Lshtjfyv4HILPMVaNjKLfCmwZKLyLzsMiFdtA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708352111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZrEhadgcarWSoboKUlIaV5KpZramrM7a8/luxhsynnU=;
	b=dmkN+fQYmwf5MGotNyOZpxemzkw3iNXSBhUamQxxRwjaHM8CUQ2jtRjg0+f+nymsU9UH6B
	SqNXrOuWxewjAjAg==
To: =?utf-8?B?6ZmI6aqP?= <chenjun102@huawei.com>,
 gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org
Cc: xuqiang36@huawei.com, chenjun102@huawei.com
Subject: Re: [PATCH v2] irqchip/mbigen: Fix incorrect null pointer check
In-Reply-To: <20240219085314.85363-1-chenjun102@huawei.com>
References: <20240219085314.85363-1-chenjun102@huawei.com>
Date: Mon, 19 Feb 2024 15:15:10 +0100
Message-ID: <87il2ka6c1.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Chen!

On Mon, Feb 19 2024 at 16:53, =E9=99=88=E9=AA=8F wrote:
> From: Chen Jun <chenjun102@huawei.com>

As I said before, the subject line does not make sense. This is not
about an incorrect NULL pointer check. It's about using a function which
is guaranteed to return NULL on your platform. Something like:

irqchip/mbigen: Don't use bus_get_dev_root() to find the parent

makes it pretty clear what this is about.

> bus_get_dev_root returns sp->dev_root set in subsys_register.
> And subsys_register is not called by platform_bus_init.

Please use '()' when referencing functions. See:

https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#function=
-references-in-changelogs

> For platform_bus_type, bus_get_dev_root always returns NULL.
> This makes mbigen_of_create_domain always return -ENODEV.

This lacks an information how the above problem is solved,
i.e. something like:

Don't try to retrieve the parent via bus_get_dev_root() and
unconditionally hand a NULL pointer to of_platform_device_create() to
fix this.

Hmm?

> Fixes: fea087fc291b ("irqchip/mbigen: move to use bus_get_dev_root()")
> Signed-off-by: Chen Jun <chenjun102@huawei.com>

Needs a

Cc: stable@vger.kernel.org

under the Signed-off-by tag.

Thanks,

        tglx

