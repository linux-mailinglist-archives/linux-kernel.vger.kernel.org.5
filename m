Return-Path: <linux-kernel+bounces-37322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6F383AE63
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16DCCB31FEB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14B27CF35;
	Wed, 24 Jan 2024 16:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MZuIvdus"
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576121A702
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 16:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706113155; cv=none; b=eDlcdEWA+JHyX3JtVhT0mKNEcp7I4eys+ftFA5X9Vk00p4ZX9tNP1GouJ2J41xmWbaJ4uwWfl+A4/DUZusdB+qIV1LvGyUXlERUEM7tVP+9wxVF20pj1JjG7iWAW3F6CTjkrq6i2nc+JTZ92tb1OsFpRgr3hwVJNHaMhA7LBkSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706113155; c=relaxed/simple;
	bh=40XQOYtPCjyB1xPaE3CSwJD38yBvVKSwSOB/CBE/KqE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S/HgY2tVGWPBHlUa/aMcwkvE1xUGzMplZsuP+/w5ZagBIcEIQG9hbuNWlkLxBRqEEDx91TyS1VQIDTe3TzHayvkPsTTUbaPLvirt19iR7H/pKIofUSiNHzZXpSHYLdG8bNg/pll4YemhqljAvUqLsRl+Mfx8ky0BOQMm58TWfKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MZuIvdus; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c8b3c672-864b-497a-9348-383412632a3d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706113150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T7nuOJoOmUuNlLsb7W1RUqVrxhJT9IAhy3vPZcivD/I=;
	b=MZuIvdus+xtMhzYerD1BMQmgJbGcBrj5pn4Z0ucLu1/71jxF5Cscc8r/KuSfTEpRSm1nSW
	H1LF8UzaGhvZYjGnOGoRJKeRBNW4h3ZGETfUWj/DUvjdpcD2EOPetvR0xBWhn4+GKkzOG4
	mYRsBNdeKut6M/thnO7yA83MG+7raEA=
Date: Wed, 24 Jan 2024 16:19:03 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 3/4] net: wan: fsl_qmc_hdlc: Add runtime timeslots changes
 support
Content-Language: en-US
To: Herve Codina <herve.codina@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Andrew Lunn <andrew@lunn.ch>, Mark Brown <broonie@kernel.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20240123164912.249540-1-herve.codina@bootlin.com>
 <20240123164912.249540-4-herve.codina@bootlin.com>
 <fc421c38-66b7-4d4e-abfa-051eccbf793c@linux.dev>
 <20240124162646.24bf9235@bootlin.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20240124162646.24bf9235@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 24/01/2024 15:26, Herve Codina wrote:
> Hi Vadim,
> 
> On Wed, 24 Jan 2024 10:10:46 +0000
> Vadim Fedorenko <vadim.fedorenko@linux.dev> wrote:
> 
> [...]
>>> +static int qmc_hdlc_xlate_slot_map(struct qmc_hdlc *qmc_hdlc,
>>> +				   u32 slot_map, struct qmc_chan_ts_info *ts_info)
>>> +{
>>> +	u64 ts_mask_avail;
>>> +	unsigned int bit;
>>> +	unsigned int i;
>>> +	u64 ts_mask;
>>> +	u64 map;
>>> +
>>> +	/* Tx and Rx masks must be identical */
>>> +	if (ts_info->rx_ts_mask_avail != ts_info->tx_ts_mask_avail) {
>>> +		dev_err(qmc_hdlc->dev, "tx and rx available timeslots mismatch (0x%llx, 0x%llx)\n",
>>> +			ts_info->rx_ts_mask_avail, ts_info->tx_ts_mask_avail);
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	ts_mask_avail = ts_info->rx_ts_mask_avail;
>>> +	ts_mask = 0;
>>> +	map = slot_map;
>>> +	bit = 0;
>>> +	for (i = 0; i < 64; i++) {
>>> +		if (ts_mask_avail & BIT_ULL(i)) {
>>> +			if (map & BIT_ULL(bit))
>>> +				ts_mask |= BIT_ULL(i);
>>> +			bit++;
>>> +		}
>>> +	}
>>> +
>>> +	if (hweight64(ts_mask) != hweight64(map)) {
>>> +		dev_err(qmc_hdlc->dev, "Cannot translate timeslots 0x%llx -> (0x%llx,0x%llx)\n",
>>> +			map, ts_mask_avail, ts_mask);
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	ts_info->tx_ts_mask = ts_mask;
>>> +	ts_info->rx_ts_mask = ts_mask;
>>> +	return 0;
>>> +}
>>> +
>>> +static int qmc_hdlc_xlate_ts_info(struct qmc_hdlc *qmc_hdlc,
>>> +				  const struct qmc_chan_ts_info *ts_info, u32 *slot_map)
>>> +{
>>> +	u64 ts_mask_avail;
>>> +	unsigned int bit;
>>> +	unsigned int i;
>>> +	u64 ts_mask;
>>> +	u64 map;
>>> +
>>
>> Starting from here ...
>>
>>> +	/* Tx and Rx masks must be identical */
>>> +	if (ts_info->rx_ts_mask_avail != ts_info->tx_ts_mask_avail) {
>>> +		dev_err(qmc_hdlc->dev, "tx and rx available timeslots mismatch (0x%llx, 0x%llx)\n",
>>> +			ts_info->rx_ts_mask_avail, ts_info->tx_ts_mask_avail);
>>> +		return -EINVAL;
>>> +	}
>>> +	if (ts_info->rx_ts_mask != ts_info->tx_ts_mask) {
>>> +		dev_err(qmc_hdlc->dev, "tx and rx timeslots mismatch (0x%llx, 0x%llx)\n",
>>> +			ts_info->rx_ts_mask, ts_info->tx_ts_mask);
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	ts_mask_avail = ts_info->rx_ts_mask_avail;
>>> +	ts_mask = ts_info->rx_ts_mask;
>>> +	map = 0;
>>> +	bit = 0;
>>> +	for (i = 0; i < 64; i++) {
>>> +		if (ts_mask_avail & BIT_ULL(i)) {
>>> +			if (ts_mask & BIT_ULL(i))
>>> +				map |= BIT_ULL(bit);
>>> +			bit++;
>>> +		}
>>> +	}
>>> +
>>> +	if (hweight64(ts_mask) != hweight64(map)) {
>>> +		dev_err(qmc_hdlc->dev, "Cannot translate timeslots (0x%llx,0x%llx) -> 0x%llx\n",
>>> +			ts_mask_avail, ts_mask, map);
>>> +		return -EINVAL;
>>> +	}
>>> +
>>
>> till here the block looks like copy of the block from previous function.
>> It worth to make a separate function for it, I think.
>>
>>> +	if (map >= BIT_ULL(32)) {
>>> +		dev_err(qmc_hdlc->dev, "Slot map out of 32bit (0x%llx,0x%llx) -> 0x%llx\n",
>>> +			ts_mask_avail, ts_mask, map);
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	*slot_map = map;
>>> +	return 0;
>>> +}
>>> +
> [...]
> 
> I am not so sure. There are slighty differences between the two functions.
> The error messages and, in particular, the loop in qmc_hdlc_xlate_slot_map() is:
> 	--- 8< ---
> 	ts_mask_avail = ts_info->rx_ts_mask_avail;
> 	ts_mask = 0;
> 	map = slot_map;
> 	bit = 0;
> 	for (i = 0; i < 64; i++) {
> 		if (ts_mask_avail & BIT_ULL(i)) {
> 			if (map & BIT_ULL(bit))
> 				ts_mask |= BIT_ULL(i);
> 			bit++;
> 		}
> 	}
> 	--- 8< ---
> 
> whereas it is the following in qmc_hdlc_xlate_ts_info():
> 	--- 8< ---
> 	ts_mask_avail = ts_info->rx_ts_mask_avail;
> 	ts_mask = ts_info->rx_ts_mask;
> 	map = 0;
> 	bit = 0;
> 	for (i = 0; i < 64; i++) {
> 		if (ts_mask_avail & BIT_ULL(i)) {
> 			if (ts_mask & BIT_ULL(i))
> 				map |= BIT_ULL(bit);
> 			bit++;
> 		}
> 	}
> 	--- 8< ---
> 
> ts_map and map initializations are not the same, i and bit are not used for
> the same purpose and the computed value is not computed based on the same
> information.
> 
> With that pointed, I am not sure that having some common code for both
> function will be relevant. Your opinion ?

I see. I'm just thinking if it's possible to use helpers from bitops.h
and bitmap.h here to avoid open-coding common parts of the code.

> Best regards,
> Hervé


