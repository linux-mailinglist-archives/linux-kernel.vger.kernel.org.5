Return-Path: <linux-kernel+bounces-166031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C02178B94FD
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 09:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0F911C20D0C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 07:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94C621A04;
	Thu,  2 May 2024 07:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JVuQzr6m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CBE1CA80;
	Thu,  2 May 2024 07:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714633396; cv=none; b=SL3Kh7RPjQe2z9GUtM/Ttj5L2XI7GH2Q64oTML5CA4UIdJjzCdgwDv63Q/e3iv4glJYAGfo1GDmNLsl+tXp84GxDEHJNiXUYqPrgpmyWKaNzn0cpBwwCGXaoHWBoSkH8wOUubTlIEMSHOuOoRwwJ10qvdYcj7VBo3gps6F+JD2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714633396; c=relaxed/simple;
	bh=eZHA6dycMEhndlQBEwkVSIH+8uMnPz6SrubKX8jZyiM=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=sxrvH5AGYtyKksU/blHRFlMbcRksQc9KJgE5m1DhdtZp4RU75At+izsA1nssMCE1E4fJZtiBtgrtWiXI9GH52UmCG80CMnHmdRefuQT9jXJDrtMEr5zzq5Lg3VHAoExhbABQq9pT2fqCkmOnKb1L5jEoeBN1pJr4NbOCg1TtrkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JVuQzr6m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44ECDC116B1;
	Thu,  2 May 2024 07:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714633395;
	bh=eZHA6dycMEhndlQBEwkVSIH+8uMnPz6SrubKX8jZyiM=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=JVuQzr6mEr/MJO50qsI7l1mXlXYnodA4CvgsULnCDa8KchLuwMW0knDcr7zxRRMVE
	 I0AdOqI6zxy5MRAipH9IBl/MBaISNGUCeTA63HmRKY/6CCpT5g+cVlcQuQUCO8Gmg5
	 WHSO/CCH39RqdORWIOtWc90DbXVgun3Q87Ta9Y8HJjzFItcJgHK4SdkhexVaFxiT9S
	 Wz80Srs9r1WaaZODKHlFMfZxeG22a0/W5jI66C/l1mY+QA9bVl6UTDV6nas/8lwK8O
	 whcGVM+cId3hrxY8/fxC+4BDGiIp90d9ukPRLrDQuubzmpBfOIkAEUHabFz9Q2Txwp
	 I865jPQt9MpLw==
From: Kalle Valo <kvalo@kernel.org>
To: Larry Finger <Larry.Finger@lwfinger.net>
Cc: Ziyang Huang <hzyitc@outlook.com>,  jjohnson@kernel.org,
  linux-wireless@vger.kernel.org,  ath11k@lists.infradead.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wifi: ath11k: fix remapped ce accessing issue on 64bit OS
References: <TYZPR01MB55563B3A689D54D18179E5B4C9192@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
	<22b0713e-49f2-482a-b145-e460b5632a7c@lwfinger.net>
Date: Thu, 02 May 2024 10:03:12 +0300
In-Reply-To: <22b0713e-49f2-482a-b145-e460b5632a7c@lwfinger.net> (Larry
	Finger's message of "Wed, 1 May 2024 11:55:08 -0500")
Message-ID: <874jbgg0gf.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Larry Finger <Larry.Finger@lwfinger.net> writes:

> On 5/1/24 11:14 AM, Ziyang Huang wrote:
>
>> On 64bit OS, when ab->mem_ce is lower than or 4G far away from ab->mem,
>> u32 is not enough to store the offsets, which makes ath11k_ahb_read32()
>> and ath11k_ahb_write32() access incorrect address and causes Data Abort
>> Exception.
>> Let's use the high bits of offsets to decide where to access, which
>> is
>> similar as ath11k_pci_get_window_start() done. In the future, we can merge
>> these functions for unified regs accessing.
>> Signed-off-by: Ziyang Huang <hzyitc@outlook.com>
>> ---
>>   drivers/net/wireless/ath/ath11k/ahb.c | 34 ++++++++++++++++++++-------
>>   drivers/net/wireless/ath/ath11k/hal.c | 17 +++++---------
>>   drivers/net/wireless/ath/ath11k/hw.c  | 14 +++++------
>>   drivers/net/wireless/ath/ath11k/hw.h  |  7 +++++-
>>   4 files changed, 45 insertions(+), 27 deletions(-)
>> diff --git a/drivers/net/wireless/ath/ath11k/ahb.c
>> b/drivers/net/wireless/ath/ath11k/ahb.c
>> index 7c0a23517949..9e59b4de93a9 100644
>> --- a/drivers/net/wireless/ath/ath11k/ahb.c
>> +++ b/drivers/net/wireless/ath/ath11k/ahb.c
>> @@ -198,12 +198,30 @@ static const struct ath11k_pci_ops ath11k_ahb_pci_ops_wcn6750 = {
>>     static inline u32 ath11k_ahb_read32(struct ath11k_base *ab, u32
>> offset)
>>   {
>> -	return ioread32(ab->mem + offset);
>> +	switch (offset & ATH11K_REG_TYPE_MASK) {
>> +	case ATH11K_REG_TYPE_NORMAL:
>> +		return ioread32(ab->mem + FIELD_GET(ATH11K_REG_OFFSET_MASK, offset));
>> +	case ATH11K_REG_TYPE_CE:
>> +		return ioread32(ab->mem_ce + FIELD_GET(ATH11K_REG_OFFSET_MASK, offset));
>> +	default:
>> +		BUG();
>
> Do you really want to crash the system here? A dev_warn() or something
> similar would log the situation. I suspect this case is never taken,
> but a system crash is not a good response if it is.

Correct, BUG() is more or less banned from all wireless code.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

