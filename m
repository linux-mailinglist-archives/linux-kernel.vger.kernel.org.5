Return-Path: <linux-kernel+bounces-35608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65AC28393F3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:59:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98F781C25583
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E659C612F0;
	Tue, 23 Jan 2024 15:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kZdO96ol"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1E760ECD;
	Tue, 23 Jan 2024 15:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706025531; cv=none; b=dWTjdM8O8oivlwCEJIc4M31R2gRHEdFYyKjEI+amXlGxGCYMfkfBeNTDo9MnRsI8zMMdpdQYpemAh8LqIOeDkU1yRpBk61aKsXRw6nPzqKyWHgVErs3p73yRYlfIIh2BAh59aYHenDp/aQWtSaHNTc04EF+Q0jgpUhE2fhX0DqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706025531; c=relaxed/simple;
	bh=5Lo26p2BpVdwCeFrkN3E+EK5VQ1TdGxsdoYHArJPJv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZsFWI4TgS7Hrc4q23YS7ye7NG8c3TeKHrVVUMpKE/A+Wfyx8KaRfEABTHHpM+mD8JlqNur7AL0DBD/jIzcTP8P+pvsuunuPsN70nI7IcvXxRxIRhLV4Cy6zquwM4XHvrK8VmwZxrfVaKT06/nIDfWR5DMzMqW94sucNrpksa0/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kZdO96ol; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94DA3C433C7;
	Tue, 23 Jan 2024 15:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706025530;
	bh=5Lo26p2BpVdwCeFrkN3E+EK5VQ1TdGxsdoYHArJPJv0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kZdO96ol5hx+zTwE6sAa3AUq/SmZUKUc60N8g7DawZD6NgIxbPBDNRpe5SJjEgdon
	 ScBRO9xwfIWrGxDY2jR8eboFXZid1EGVqJgqiWpiJ6dOEFUJTfewDxM1pd8l5meUxO
	 KlOJu5p8ZyKnjy8gmVWwx/4YlaewNy9p30qTjRyC6STaK/AXndwgF512gkAM6cZE5g
	 ELQwD7GYdnX4mp87e7gqFSgs961su9LzbTN7LLEWXnZmm8Z1hUyuD3kzYQVBPUbL29
	 pbNdXt5OEBZI22efs/AaujMs8A7gu4ZGBBVcNxu4s0a3G7kySzZD6Pqyvl4q2wzF6t
	 L5ssgIGAqOO9A==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rSJB1-000000004kg-3HBY;
	Tue, 23 Jan 2024 16:59:03 +0100
Date: Tue, 23 Jan 2024 16:59:03 +0100
From: Johan Hovold <johan@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Xilin Wu <wuxilin123@gmail.com>
Subject: Re: [PATCH v2] power: supply: qcom_battmgr: Ignore notifications
 before initialization
Message-ID: <Za_iR0ctkgYO0W5L@hovoldconsulting.com>
References: <20240103-topic-battmgr2-v2-1-c07b9206a2a5@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240103-topic-battmgr2-v2-1-c07b9206a2a5@linaro.org>

On Wed, Jan 03, 2024 at 01:36:08PM +0100, Konrad Dybcio wrote:
> Commit b43f7ddc2b7a ("power: supply: qcom_battmgr: Register the power
> supplies after PDR is up") moved the devm_power_supply_register() calls
> so that the power supply devices are not registered before we go through
> the entire initialization sequence (power up the ADSP remote processor,
> wait for it to come online, coordinate with userspace..).
> 
> Some firmware versions (e.g. on SM8550) seem to leave battmgr at least
> partly initialized when exiting the bootloader and loading Linux. Check
> if the power supply devices are registered before consuming the battmgr
> notifications.

So this clearly was not tested properly as the offending commit breaks
both the Lenovo ThinkPad X13s and the SC8280XP CRD.

I spent some time this afternoon tracking down and considering the best
way to address this before I checked lore and found this proposed fix
(why was I not CCed?).

> Fixes: b43f7ddc2b7a ("power: supply: qcom_battmgr: Register the power supplies after PDR is up")
> Reported-by: Xilin Wu <wuxilin123@gmail.com>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
> Changes in v2:
> - Fix the commit title
> - Link to v1: https://lore.kernel.org/linux-arm-msm/d9cf7d9d-60d9-4637-97bf-c9840452899e@linaro.org/T/#t
> ---
>  drivers/power/supply/qcom_battmgr.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
> index a12e2a66d516..7d85292eb839 100644
> --- a/drivers/power/supply/qcom_battmgr.c
> +++ b/drivers/power/supply/qcom_battmgr.c
> @@ -1271,6 +1271,10 @@ static void qcom_battmgr_callback(const void *data, size_t len, void *priv)
>  	struct qcom_battmgr *battmgr = priv;
>  	unsigned int opcode = le32_to_cpu(hdr->opcode);
>  
> +	/* Ignore the pings that come before Linux cleanly initializes the battmgr stack */

Nit: I know you have a wide-screen monitor but please follow the coding
style and break your lines at 80 columns for readability. ;)

> +	if (!battmgr->bat_psy)
> +		return;

This is not a proper fix. You register 3-4 class devices and only check
one. Even if your checked the last one, there's no locking or barriers
in place to prevent this from breaking.

Deferred registration of the class devices also risks missing
notifications as you'll be spending time on registration after the
service has gone live.

I'm sure all of this can be handled but as it is non-trivial and the
motivation for the offending commit is questionable to begin with, I
suggest reverting for now.

I'll send a revert for Sebastian to consider.

> +
>  	if (opcode == BATTMGR_NOTIFICATION)
>  		qcom_battmgr_notification(battmgr, data, len);
>  	else if (battmgr->variant == QCOM_BATTMGR_SC8280XP)

Johan

