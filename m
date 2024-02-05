Return-Path: <linux-kernel+bounces-52775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 031D0849C89
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:02:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 340BC1C2532A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 084922C1AD;
	Mon,  5 Feb 2024 14:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="nhvuxBxD"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39B028DD1;
	Mon,  5 Feb 2024 14:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707141705; cv=none; b=bqguUDMIsMhnAcCn04wG7RA4p3ulTrMwu1XuTW5/0e/PxOBjJ1XxCkqSQkOcR0QDSqane1B7TPPA9sWKXBsTuWaGIZHQoSjrhRQqzBFPYWZFcRawErb7FYQsdraSO4K2mMBbTbrc+bc+Tm/Oal7dY2iWVLWgX3lyWj+zyE+SiAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707141705; c=relaxed/simple;
	bh=AQ9rJJsSMiX+vo7iSm3VkhpLNuASv5tw8v6zztJtpa8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TjYTv2H38q8ZD/p7fr8O9uJyLFM9Gn53trc0Ebi8jaLeohknm6XfspzxBtp3u2WfxEI+PxmbtvAHLQelNj3WEdpwFzGKOEZUbBnxr9MfnL1dihlAP6uvTnZ6DXjTf56H452nLdostGkL1o5/G4U4oZPVCb3xWMVu4p+DuxPIJ/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=nhvuxBxD; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4155VpcZ002122;
	Mon, 5 Feb 2024 08:01:08 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	PODMain02222019; bh=KkdSVvZBpNy6UICQTjzXbhDmnHH8Se+KrDnsL2G3J/E=; b=
	nhvuxBxD495qcJk3Dwfn+Er1TmmkZ7aJl4efkUIbbRZgzbGmi15fN6u6L0pQsS8m
	oizA2n3YqQi918+XB4wYEvGZbCAZERLf6z7PoPWBL6CgeUn6VnT6NmDupNW9GTvT
	1OutoakT1s0SKSbllebVm5FLZy+RPSpylL3B8goAarXiDQeLi9Yu5opBm006u0vh
	Rin8D06cqaadWvMwBHLeKHYsAlC1Ai1/JzEvNBGygzmXFKBcMTCXDg34tPFL74JS
	da4YSkg3HXId+hWhheJZBLCFkmgPuukxddu7ePknDbuGLoiTJSsKW9cZyuuPBjEM
	GZ4YM+x5ksEclSEt6EyFIg==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3w1ks29ybc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Feb 2024 08:01:05 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 5 Feb
 2024 14:01:03 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40 via Frontend Transport; Mon, 5 Feb 2024 14:01:03 +0000
Received: from [198.90.208.18] (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 8A88B820241;
	Mon,  5 Feb 2024 14:01:03 +0000 (UTC)
Message-ID: <5a2872d4-7eb3-465a-aace-c848919b1f2a@opensource.cirrus.com>
Date: Mon, 5 Feb 2024 14:01:03 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: cs35l56: fix reversed if statement in
 cs35l56_dspwait_asp1tx_put()
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
References: <0c254c07-d1c0-4a5c-a22b-7e135cab032c@moroto.mountain>
Content-Language: en-GB
From: Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <0c254c07-d1c0-4a5c-a22b-7e135cab032c@moroto.mountain>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 5xdR__uDpewbfPRVIWR6S2KgtvLy6a5n
X-Proofpoint-ORIG-GUID: 5xdR__uDpewbfPRVIWR6S2KgtvLy6a5n
X-Proofpoint-Spam-Reason: safe

On 05/02/2024 12:44, Dan Carpenter wrote:
> It looks like the "!" character was added accidentally.  The
> regmap_update_bits_check() function is normally going to succeed.  This
> means the rest of the function is unreachable and we don't handle the
> situation where "changed" is true correctly.
> 
> Fixes: 07f7d6e7a124 ("ASoC: cs35l56: Fix for initializing ASP1 mixer registers")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>>From static analysis and review, not tested.
> ---
>   sound/soc/codecs/cs35l56.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/codecs/cs35l56.c b/sound/soc/codecs/cs35l56.c
> index c23e29da4cfb..ebed5ab1245b 100644
> --- a/sound/soc/codecs/cs35l56.c
> +++ b/sound/soc/codecs/cs35l56.c
> @@ -115,7 +115,7 @@ static int cs35l56_dspwait_asp1tx_put(struct snd_kcontrol *kcontrol,
>   
>   	ret = regmap_update_bits_check(cs35l56->base.regmap, addr,
>   				       CS35L56_ASP_TXn_SRC_MASK, val, &changed);
> -	if (!ret)
> +	if (ret)
>   		return ret;
>   
>   	if (changed)

Reviewed-by: Richard Fitzgerald <rf@opensource.cirrus.com>


