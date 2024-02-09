Return-Path: <linux-kernel+bounces-59275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C06084F468
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 12:18:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEEB11C22250
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 11:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4E82C1B8;
	Fri,  9 Feb 2024 11:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="JX8PFc+H"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC9C28DC9;
	Fri,  9 Feb 2024 11:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707477510; cv=none; b=rcd0tnzTioyPUQJTj9tkzSUb0xHrmLbDBBmOcNpzc8eg/efGL1TqW5EKCIBimAZPQ1e0hNMLKAiQNooUfZzdzN69Kpp8LSlQuv+DgzpTr1q6DFeTMwTwAOlzzO3SQVkUyNYz5Ps/wf6lSK/zVEAkUG+nNjXQRZ02pGdY5YY1B90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707477510; c=relaxed/simple;
	bh=MntDz3frSWPLI1b8XC6BskO076LR1R1lCkWAh6YNv0Q=;
	h=From:To:CC:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=jcL13NV5pd8U96ykXRQsji3ax/5gXs2f6DbLGuL4IACTzLG/EoI1axeUySPEKQdPm5rF6uAkaIDcHD/cQBJRroxMBuvppunHCS9p/lhXfYyGaJi1l5mlU3ZwFUBtMpOPDnTMSUq1hQxRohyAmpl1LWG+jhM9FUd4LyH+emN9RME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=JX8PFc+H; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4198UKwV014537;
	Fri, 9 Feb 2024 05:18:10 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:references:in-reply-to:subject:date:message-id
	:mime-version:content-type:content-transfer-encoding; s=
	PODMain02222019; bh=coVRnRrQs3z5qP4mCx2uQbZTGohzfwN2TLzDPTaxh8M=; b=
	JX8PFc+HFV4adL6eiQsxtlZhMNnqtpYnpgdNhTK4MGVkwoU2UoJTpLR5JkWQrJMa
	r9TLc8B4eK81Mk+NZ3/CYK4hLf8z0PvcIEQ15tY7W6X8ZUzfsJve9SHDiYmQ8IK6
	adyoLf9U6LLTaQ9nXbVfJBriSCIdG5jeR4UYquwJIqX/FBrieu/GC2S9Q9sMTxru
	RCZ1+vckdXA+DgUP2I0aXa0kBXbIfpmSndYDqMCGN+p3ve/EooRHKa9gKFHAxlkP
	6cFlyj2w16zrE/fO0WWORcM/np8kUTieMlB/DJajqEwmr+mo6Q+YM46p2u72bC4K
	/vp/d4bYey9Vpfm+VJ91Jw==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3w1ks2ftsy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Feb 2024 05:18:10 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 9 Feb
 2024 11:18:08 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40 via Frontend Transport; Fri, 9 Feb 2024 11:18:08 +0000
Received: from EDIN6ZZ2FY3 (EDIN6ZZ2FY3.ad.cirrus.com [198.61.64.128])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id CA2E3820243;
	Fri,  9 Feb 2024 11:18:07 +0000 (UTC)
From: Simon Trimmer <simont@opensource.cirrus.com>
To: 'Lukas Bulwahn' <lukas.bulwahn@gmail.com>,
        'Jaroslav Kysela'
	<perex@perex.cz>, 'Takashi Iwai' <tiwai@suse.com>,
        'Richard Fitzgerald'
	<rf@opensource.cirrus.com>,
        <linux-sound@vger.kernel.org>
CC: <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240209082044.3981-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20240209082044.3981-1-lukas.bulwahn@gmail.com>
Subject: RE: [PATCH] ALSA: hda/cs35l56: select intended config FW_CS_DSP
Date: Fri, 9 Feb 2024 11:18:07 +0000
Message-ID: <001801da5b49$a89be460$f9d3ad20$@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-gb
Thread-Index: AQIj8QOMXSB51XGLfZZGXWCY5rrZsLBusJ+A
X-Proofpoint-GUID: o36hZYTiQqh1B2u0fp3WbmugxjGk6opz
X-Proofpoint-ORIG-GUID: o36hZYTiQqh1B2u0fp3WbmugxjGk6opz
X-Proofpoint-Spam-Reason: safe

> -----Original Message-----
> From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> 
> Commit 73cfbfa9caea ("ALSA: hda/cs35l56: Add driver for Cirrus Logic
> CS35L56 amplifier") adds configs SND_HDA_SCODEC_CS35L56_{I2C,SPI},
> which selects the non-existing config CS_DSP. Note the renaming in
> commit d7cfdf17cb9d ("firmware: cs_dsp: Rename KConfig symbol CS_DSP ->
> FW_CS_DSP"), though.
> 
> Select the intended config FW_CS_DSP.
> 
> This broken select command probably was not noticed as the configs also
> select SND_HDA_CS_DSP_CONTROLS and this then selects FW_CS_DSP. So,
> the
> select FW_CS_DSP could actually be dropped, but we will keep this
> redundancy in place as the author originally also intended to have this
> redundancy of selects in place.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Thanks!

Reviewed-by: Simon Trimmer <simont@opensource.cirrus.com>


