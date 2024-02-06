Return-Path: <linux-kernel+bounces-54632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9862484B1C3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 539B2286423
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 09:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA3812DD89;
	Tue,  6 Feb 2024 09:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="CN8aUZeq"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C576312DD8B;
	Tue,  6 Feb 2024 09:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707213560; cv=none; b=nlvgnr96YilrNzphjW/Tt9VUn4Hf9Odv7SHr83/xRvGXQMZVt9HIpuzp1JSI2zepHht7Mj5i+sI3kYgDldokEhmgrilgA0YEHigir44fZ9kLlq6Jm3XN3kAkxwR76noP9gODyS5Pv8l3lVtmwjl4PhRU8VqCbpYoJPp6cIwEggc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707213560; c=relaxed/simple;
	bh=LATC3GHoWk4vcKrr195GbFLPo1L9HxJmDR8iymTwdaM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ApS87gg10NV+9CRBxhN2T0V2ZFY45kB+aboLYOT8I8gG0rxWjHuDZzxPU2ivwvmdpDjq/eKPqv2xig1OahIPMpr8k+ffwNyZ0FJVfES+AcrhaXl/R7OMSTqfauVL487d84zJ/o3KRleuY7pygIjhXh5tu/y/p+bQbqUDTlvOyLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=CN8aUZeq; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4166xSAC022910;
	Tue, 6 Feb 2024 03:58:53 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=PODMain02222019; bh=v5p55IOITpqmhF7
	sZSnOxfOy/BsQIdVVFm5xhqj7f9s=; b=CN8aUZeqvFd31h49unpgQ89je93VaRH
	rrRbjFcRdvJI7Wgt+s6nVW5BCmZk3kbVOwu/CNVLRLufi+5MpG0xYDqxTb+6FGR1
	o9Z5Tgj1grqrrtHgHitQltAZFv+FlcF78BNTWogNQGy0jcjoRvRBTMp+qYGKcyKV
	XNDICT/OwcoiEoN5lqMTQvkzBMfp+afdgbGJ3JbvaGKz8NqjjJWipW4mj1Jxnuzl
	zV/KdBSpOsXYlEhP/chL66QeINs8nWkqGzvCzBvxVMGhAB+swBUB0wHEydjeg+4f
	DUmUgJYKr9SezvgEgFSr8PTmX+JsuzS5ZkVX/kvEhcim+tQrksQp1zg==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3w1ks2b7fk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Feb 2024 03:58:53 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 6 Feb
 2024 09:58:51 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.40 via Frontend Transport; Tue, 6 Feb 2024 09:58:51 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPS id E135E820241;
	Tue,  6 Feb 2024 09:58:50 +0000 (UTC)
Date: Tue, 6 Feb 2024 09:58:49 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Bo Liu <liubo03@inspur.com>
CC: <lee@kernel.org>, <wens@csie.org>, <marek.vasut+renesas@gmail.com>,
        <support.opensource@diasemi.com>, <neil.armstrong@linaro.org>,
        <rf@opensource.cirrus.com>, <mazziesaccount@gmail.com>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>,
        <linux-kernel@vger.kernel.org>, <linux-renesas-soc@vger.kernel.org>,
        <linux-amlogic@lists.infradead.org>, <patches@opensource.cirrus.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 09/18] mfd: lochnagar-i2c: convert to use maple tree
 register cache
Message-ID: <ZcIC2V/hM8nnekJr@ediswmail9.ad.cirrus.com>
References: <20240206071314.8721-1-liubo03@inspur.com>
 <20240206071314.8721-10-liubo03@inspur.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240206071314.8721-10-liubo03@inspur.com>
X-Proofpoint-GUID: VCnUsQ6Tbcxl1dxM9nGNsPvgd74iHvZt
X-Proofpoint-ORIG-GUID: VCnUsQ6Tbcxl1dxM9nGNsPvgd74iHvZt
X-Proofpoint-Spam-Reason: safe

On Tue, Feb 06, 2024 at 02:13:05AM -0500, Bo Liu wrote:
> The maple tree register cache is based on a much more modern data structure
> than the rbtree cache and makes optimisation choices which are probably
> more appropriate for modern systems than those made by the rbtree cache.
> 
> Signed-off-by: Bo Liu <liubo03@inspur.com>
> ---

Tested-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles

