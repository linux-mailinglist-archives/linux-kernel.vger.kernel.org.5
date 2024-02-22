Return-Path: <linux-kernel+bounces-76716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B8E485FB71
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:41:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C36BE287614
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94ECE1474C2;
	Thu, 22 Feb 2024 14:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="qguk+Ih8"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532C113340A;
	Thu, 22 Feb 2024 14:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708612873; cv=none; b=C1q1OMZqJfyo3CDW9kkwNZivsQiC01RLTWyQBpD/uxWrPNrTBUAl8NB9fFJ8K+xGYBDPovhRK8dpDkKETtHZcKPM2S/5oIV3rmJp5+yrmcNsHOPJqkpQ0tRaLWe6Kcp2rpXSe+DGvLI7FqcVX3hHHRpzEUeENeyYbpdrvkVaN+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708612873; c=relaxed/simple;
	bh=5G6p4CsZj5y8xjTo5u6g1DmV7f13kIan+NI5DrjzCKU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=m89wrgQe0Od+csXH0Ant0O0aLzm36r5tqn2MvOy4alO6H3b56so2jcY3Z14RpueqfRuoxYTs9IDu147Vn8q+fNq3xoZGJ6re6uS6EAhoa2W7izls8O2ZePGkgbjtq6xDSQO4vUGX6f9DjWGVAUNIWUcfJI6ujnlXvvYANF169Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=qguk+Ih8; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41M6aL7N011439;
	Thu, 22 Feb 2024 08:40:53 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	PODMain02222019; bh=GZdoxlRn/2MPxlEY4hTnWJTeSg5WxNCGjx0Who2o+Qc=; b=
	qguk+Ih8VW8nQ4KMHCGyKrmBgPn8H6/cv2mPEGqsxDlvpckIVYF5ArN4Etr5w/RT
	+Zbysbe7rD5zzrz17o+uDuUnyQQattKY1INkLTXi8uY2jJQYC9yPvs6CIC32FWIO
	GeKrIFGsMyXGv3s/VdKXhE3Q7L8vtUc7uHgpqBUr321ENU8wxS8ZFYktkDzk1Ex1
	b2z1bQy/jVihlun1vofgZifwMpTnkJ+orOkevtLE/QJnOhTLZq1FVigMukx+r9AQ
	EldlMp1UbWQfJoc/P5r7fSE/g7c1HqifzZZtgoDPYQFywJsPuuXbNKwbGx9MUy03
	W4JDpr/Qd91ArXhcgivTfA==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3wd205jmyc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 08:40:52 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 22 Feb
 2024 14:40:50 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40 via Frontend Transport; Thu, 22 Feb 2024 14:40:50 +0000
Received: from [198.90.208.18] (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id AD855820243;
	Thu, 22 Feb 2024 14:40:50 +0000 (UTC)
Message-ID: <8edbbb9b-f07a-4cd5-a6ce-c46ee3acffe6@opensource.cirrus.com>
Date: Thu, 22 Feb 2024 14:40:50 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] ALSA: cs35l56: Apply calibration from EFI
To: <broonie@kernel.org>, <tiwai@suse.com>
CC: <linux-sound@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
References: <20240221150507.1039979-1-rf@opensource.cirrus.com>
Content-Language: en-GB
From: Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <20240221150507.1039979-1-rf@opensource.cirrus.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: zf4bQVLxDraNpc8et0FaVvviX6rn0oeh
X-Proofpoint-GUID: zf4bQVLxDraNpc8et0FaVvviX6rn0oeh
X-Proofpoint-Spam-Reason: safe

On 21/02/2024 15:04, Richard Fitzgerald wrote:
> Factory calibration of the speakers stores the calibration information
> into an EFI variable.
> 
> This set of patches adds support for applying speaker calibration
> data from that EFI variable.
> 

STOP! Don't merge.

I found a potential lockdep error in this code.
Will send a V2.


