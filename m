Return-Path: <linux-kernel+bounces-97171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD02876671
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 15:38:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 718411F22814
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 14:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A4D1FB3;
	Fri,  8 Mar 2024 14:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="S4R9Tdfy"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C9A15AF
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 14:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709908679; cv=none; b=tjVvNq/OmYbSnP/snQOkdAi7Bmwq+b5cWVjlUDl6JsOjzp6Lyo4reojZruqLGBdUu+XGnS/4RtTkW9l9a1E98UPIQQNLljUA0bwoeB9tSrPWpyxaCLmDWdnfhQkT0OWx3WAmMxk6x/6dgMVDqZUpZvb0OKMrsCJ2PklZNYBMYH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709908679; c=relaxed/simple;
	bh=4zIPCFN1AXWsYUD1rswmD8zDUKpUwF66ovwF4Z3fSqI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SZrkF1fbvdI6R7GthsAgu9JZ6KmDBirVFovyib2CLOmQ4MAdNLxavZB7y0C67DacG6DjMABa0aH4LaaP0SsM5lyivxGOUP2KFZHS91sQcEUqqZLLDY1f6xKJ4pBmPVUkEjIwUJRfVV4X0y+AR+sMZRf1HPhKkanlNrbD4TtQf4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=S4R9Tdfy; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709908676;
	bh=4zIPCFN1AXWsYUD1rswmD8zDUKpUwF66ovwF4Z3fSqI=;
	h=Date:From:To:Cc:Subject:From;
	b=S4R9TdfyaMdsZC9aIRjbpi/QDIJoWA9SsoPnNRpEx1tcvJ1m/JvlObUCxxWMmyeMC
	 TWw1CuopTw+KezJtLJmqLIL3LMHzq9NiY/msIVetY1tI2Ov0YklXlYEBj2RP5O7dW7
	 TzRdMtPlFhl1VqgKMFltgQC84rDJMhtVqdDQtefT6cYz1cC/cdYZsDgZLhaClf9m+c
	 kVLxI9L/JXdRaRPQdZyPmdkpZoTROVGQE1CUaD2CeoIXchVoAEzibpM2AeZp1PYMA4
	 HsZw5x7JEKjBVb9oU6hUQODOnHL66hBmkT8Z+foZ27CXyFJRatr3cXnrIIM29LYoHT
	 xJX8xewaJUPVQ==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sebastianfricke)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 1BF4F37820C3;
	Fri,  8 Mar 2024 14:37:56 +0000 (UTC)
Date: Fri, 8 Mar 2024 15:37:55 +0100
From: Sebastian Fricke <sebastian.fricke@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, maz@kernel.org, bartosz.golaszewski@linaro.org
Subject: RFC: fake IRQchip
Message-ID: <20240308143755.jey6kr3ftlzxt6lg@basti-XPS-13-9310>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline

Hey,

I am one of the maintainers of the media subsystem and we are currently
reviewing a patch [1], where the author has developed a polling
mechanism for a driver, while the hardware (Wave5 Codec) actually always
expects an interrupt line to be present and the only reason why this
isn't uphold is because the SoC has a defect, causing the interrupt line
to be disabled.
As I am a bit reluctant to litter a driver with workarounds for defective
hardware, I suggested to the author, that he could implement fake
IRQchip, which does polling in the background. This could first be
implemented in the driver directory and then later possibly upstreamed
to /drivers/irqchip.
So, far I've got a few approving comments for that idea, but I would
really like to know what the irqchip folks think about this.

Now my question is basically, what do you think about such a solution? Would
you accept such a fake irqchip driver, that can be used by
hardware without an interrupt line to fake one? Do you think there is a
better solution or do you think that my suggestion has hidden traps?

Thomas has already pointed me to IRQ sim, any further help is highly
appreciated.

[1][https://patchwork.linuxtv.org/project/linux-media/patch/20240125130833.1953617-1-devarsht@ti.com/#155281]

Greetings,
Sebastian

