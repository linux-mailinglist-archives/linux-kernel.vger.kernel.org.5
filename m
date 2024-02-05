Return-Path: <linux-kernel+bounces-52739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C85849C19
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:41:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C41071C23BE9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A762260A;
	Mon,  5 Feb 2024 13:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="Z9XEH17V"
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8D4210E0
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 13:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707140504; cv=none; b=JgQ2HnIaSww+osSgZZlHZlz/3ygjKN3JuUCiXeVsJS/rTX25Da0JKHCEu9Ii6X45cPT3PlgMAFbar0Fk90igVeh9gL18xCXEr7/VeMHX2u39EYWfFXEkcZtNYLig5Yyn0nTquxvR4qVm6wGkKOR2eNkchoHDjeJRGu2T+XKleTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707140504; c=relaxed/simple;
	bh=YDCpBdBH44n875Uo+Dp3bavm/xtQGfLpbCMNSBVJmnM=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Gfl5JWF4J+EvnidaXetnVcNUXiQpMKRq00GjRWrzuw1hy3MI57/0UYOiXwoHrtIMIvIYpJog0VeexJi7trCG8yJdrvlyvSXwnFGg0qFmxXKlC5V+q3jhkRaB3N+pdQpy4ikuT/guaDa12sfLw5/TVAhizXqtrg2vopXT4NPaCqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=Z9XEH17V; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from [10.10.2.52] (unknown [10.10.2.52])
	by mail.ispras.ru (Postfix) with ESMTPSA id 69A4B40F1DC3;
	Mon,  5 Feb 2024 13:41:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 69A4B40F1DC3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1707140497;
	bh=YDCpBdBH44n875Uo+Dp3bavm/xtQGfLpbCMNSBVJmnM=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
	b=Z9XEH17V488MN4orxS8XupWyLBttTuNEfX6vlHM0qtvrEDQcHVfOz/eF5MUDbxdfe
	 rP3kfIIx/oU8hqAS5AiAaVdjGCKkQWinaQz69DXbGJYLves2mq7ysAmS/ulwIjEvDT
	 pnE+hOQf2UjxwuFxnMnN+SF3n8DK4wPQlMN9OlLM=
Subject: Re: [lvc-project] [PATCH] drm/amd/pm: check return value of
 amdgpu_irq_add_id()
To: Igor Artemiev <Igor.A.Artemiev@mcst.ru>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: lvc-project@linuxtesting.org, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 Evan Quan <evan.quan@amd.com>, David Airlie <airlied@gmail.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20240205122522.81627-1-Igor.A.Artemiev@mcst.ru>
From: Alexey Khoroshilov <khoroshilov@ispras.ru>
Message-ID: <ac1c1709-8bb0-6713-132e-d9b149063169@ispras.ru>
Date: Mon, 5 Feb 2024 16:41:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240205122522.81627-1-Igor.A.Artemiev@mcst.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 05.02.2024 15:25, Igor Artemiev wrote:
> amdgpu_irq_ad_id() may fail and the irq handlers will not be registered.
> This patch adds error code check.

But what is about deallocation of already allocated memory?

--
Alexey




