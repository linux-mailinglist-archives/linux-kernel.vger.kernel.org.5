Return-Path: <linux-kernel+bounces-118732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE57788BEA9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:02:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98FC62E5D6D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E41E548EC;
	Tue, 26 Mar 2024 10:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1xywrusx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CDDf/Q6N"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7834F88C
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 10:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711447326; cv=none; b=eX3psAjTj/FSDIylmqcOef9zP8qXGsbCYnrI5qkez+VOhrytMpo/RwW8sXbpxqkQfi62MA4tbscjfdysrCkGOQCIbxjSwA+Auhpa52RIP4jh/BLHm0x7qCH8G5GOuKD7sMiHFhbChkvxKcBb1VmJ5jd5F3msPd1PmXySoDLQ0Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711447326; c=relaxed/simple;
	bh=cIozTMyMkGTuWmMy5E6bpi3mGnPyoPmFmY+nCcyhY2g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QEpXWTJC0iYnrsQhIKKBSN9ygyZE1Sz+ObIVNsHPzSwa8F71IkumvliJh2S1LJvTEyvuKFMnvfbfHupYWy2K2z1it7OJEuWexAoGTol+Dp6ugFZFXo4WZzsHcxPC3fAqg9qV6X6WMfgpaw9av6cJCYmyIDnh3vXsKeMfZoXhBQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1xywrusx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CDDf/Q6N; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711447320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cIozTMyMkGTuWmMy5E6bpi3mGnPyoPmFmY+nCcyhY2g=;
	b=1xywrusxZYr06kkq2IwgfcCuF1RWn9POjuk+5aOJlDiIbW03sxe3vPh3I+CGoQBnEHc4hk
	cN87ZHKSVqDiJRcj1rrARayNiaYZWRkPUoBHEwboLbPDPwUFgVUEiBRYgW4ZOHCI4++O2p
	A4pMVd88oSG69gaiWAJjjI6k4vtY75AhYyXiyqBrXZpBVbsAO4yh+3BlUU5Uo4KPekY8e1
	MEOZIT4ErHniAw/0ZlJWsk0EvrhU9y7GvulJM8Kgu+Ko0XYbFNZH9sQtAKV0y4ArwoLsXK
	ds25XIzGBCMyNKDSOf0/8QCKDpQsnfxaER1vwq15+ydLlTz9ltGJpwq/5lASvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711447320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cIozTMyMkGTuWmMy5E6bpi3mGnPyoPmFmY+nCcyhY2g=;
	b=CDDf/Q6NBUFXVngr85o+dhunicsYWsdLkdyw7KgGgw6zKC0FXpV+2trQHXEA8DhHuhVwdL
	uYsGEhuIB6pQ61Dw==
To: Tiezhu Yang <yangtiezhu@loongson.cn>, Huacai Chen
 <chenhuacai@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Marc Zyngier
 <maz@kernel.org>
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
 loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH] LoongArch: Give chance to build under !CONFIG_SMP
In-Reply-To: <20240326062101.9822-1-yangtiezhu@loongson.cn>
References: <20240326062101.9822-1-yangtiezhu@loongson.cn>
Date: Tue, 26 Mar 2024 11:02:00 +0100
Message-ID: <87v859e2g7.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Mar 26 2024 at 14:21, Tiezhu Yang wrote:
>
> This patch is based on 6.9-rc1. Please let me know if it is better to
> split it into two patches, the first one is for arch/loongarch and the
> second one is for drivers/irqchip.

Why are you asking? It's documented that patches should be split, no?

