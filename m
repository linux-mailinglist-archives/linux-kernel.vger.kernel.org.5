Return-Path: <linux-kernel+bounces-111574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A54EC886DFC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:07:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C3121F22369
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD43A47A48;
	Fri, 22 Mar 2024 14:07:40 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E174652D;
	Fri, 22 Mar 2024 14:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711116460; cv=none; b=pnSmE/KKZhji4tIhlqjTW7vldCm31tQdu8Yg+lOscCgijSJr9ByQaTDZHPNAvWLI3LsW6AkxgEgYy8HzDKuvrrWkhA8OtwxH6CYZdjv+8BVKz0tdCxM6p/+qvrfRhcZCkRl2Yu01ZQy9Hr/GsqlmXDsBImxJjx1D/B1HBde8KKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711116460; c=relaxed/simple;
	bh=z1Cr+EJ5/KwlaRetChwu63heoXdWVRo7U/kJnQ2pDc0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eUmiCl/YvsiT9hRht/8hY/2THDqfj5fI3MIpbF5zBgxbgpiA+IV+zXJtsR0m2Tx3a4uWNovavD1Rl0Q6fbRCeCjKaIYqo9U7iL9BJ+diRCY1uHgUiq4+l9WmW47mdtH/Ax/FJnVPrEgB3noZfLThCc9k798r9HJDgIW8Kd7Nlek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7AC001007;
	Fri, 22 Mar 2024 07:08:09 -0700 (PDT)
Received: from [10.1.27.56] (e133047.arm.com [10.1.27.56])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D140E3F762;
	Fri, 22 Mar 2024 07:07:31 -0700 (PDT)
Message-ID: <32608c6b-df94-4dc8-be66-97a90b6eeac4@arm.com>
Date: Fri, 22 Mar 2024 14:07:29 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/2] mmc: sdhci-of-dwcmshc: Add CQE support
Content-Language: en-US
To: Maxim Kiselev <bigunclemax@gmail.com>, serghox@gmail.com
Cc: adrian.hunter@intel.com, jyanchou@realtek.com,
 open list <linux-kernel@vger.kernel.org>, linux-mmc@vger.kernel.org,
 quic_asutoshd@quicinc.com, ritesh.list@gmail.com, shawn.lin@rock-chips.com,
 Ulf Hansson <ulf.hansson@linaro.org>
References: <CALHCpMiUfa0j46HcorZGPDPV5Zg5ZFdWukT+5jTediuKJuoB5w@mail.gmail.com>
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <CALHCpMiUfa0j46HcorZGPDPV5Zg5ZFdWukT+5jTediuKJuoB5w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/03/2024 10:36, Maxim Kiselev wrote:
> Subject: [PATCH v7 0/2] mmc: sdhci-of-dwcmshc: Add CQE support
> 
> Hi Sergey, Adrian!
> 
> First of all I want to thank Sergey for supporting the CQE feature
> on the DWC MSHC controller.
> 
> I tested this series on the LicheePi 4A board (TH1520 SoC).
> It has the DWC MSHC IP too and according to the T-Head datasheet
> it also supports the CQE feature.
> 
>> Supports Command Queuing Engine (CQE) and compliant with eMMC CQ HCI.
> 
> So, to enable CQE on LicheePi 4A need to set a prop in DT
> and add a IRQ handler to th1520_ops:
>> .irq = dwcmshc_cqe_irq_handler,
> 
> And the CQE will work for th1520 SoC too.
> 
> But, when I enabled the CQE, I was faced with a strange effect.
> 
> The fio benchmark shows that emmc works ~2.5 slower with enabled CQE.
> 219MB/s w/o CQE vs 87.4MB/s w/ CQE. I'll put logs below.
> 
> I would be very appreciative if you could point me where to look for
> the bottleneck.
> 
> Without CQE:

I would also suspect some bus issues here, either read out ios or ext_csd
after enabling CQE, it could be helpful.
OTOH the CQE could just be limiting the frequency, which you wouldn't be
able to see without a scope. Does the TRM say anything about that?

Are you limited to <100MB/s with CQE for HS400(non-ES) and HS200, too?

What about sequential reads but smaller bs? like 256K sequential?

FWIW your fio call should be on par with non-CQE performance-wise at best,
as you just have one IO in-flight, i.e. no CQE performance improvement
possible, see your warning:

> both iodepth >= 1 and synchronous I/O engine are selected, queue
> depth will be capped at 1

Kind Regards,
Christian

