Return-Path: <linux-kernel+bounces-141471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 113C28A1F03
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 21:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 620F6B33AE6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71FA54662;
	Thu, 11 Apr 2024 18:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="ztVqzLNc"
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBC629416;
	Thu, 11 Apr 2024 18:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712859798; cv=none; b=Pv108EgrcrXzzxVpUDsK3jUdH4d3EolwUxhlY4uLmy9CZBO6+6DwHxzUHj1ehV+JG4YsdQ6QGoqWUNRSLneQ2AAETJibse3EbjqDzhhg76i4yCvG4DV71ORDQGtPvW2fDqi2P3vcJ/6IOu/w8SmtE9IUoFuHhSOCUfHHE6jY3jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712859798; c=relaxed/simple;
	bh=FRIggP1YvWWV3rj+5WU1Cj2nMoZrQOSbDSPE/2jMC40=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=uJApwUQdkMU2LVnA3kOAdmT5QabOQmsc4DpkWamx54uHIY7xr2B6n9oFUQTqNeCOBPV4huteUp8c3jRd4vThSlzQEpfio9y7T3bwgiXGM6Xj/azWTq/6MbrpILtxDY0H5uPYV5QGnb7FDW/bJboLAdTFjMNC0Pj3l3q4CV142wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=ztVqzLNc; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4VFp3L30MYz6Cnk8t;
	Thu, 11 Apr 2024 18:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1712859787; x=1715451788; bh=FRIggP1YvWWV3rj+5WU1Cj2n
	MoZrQOSbDSPE/2jMC40=; b=ztVqzLNcki93qPYwl22dc3jRpgrZo5cKjYRQ4Bf2
	W0+E8Uhn4JBUUmVyEPYlp6qI+lHns4xGuIHTWiWR3nTD3cvm7biTShu6x4hocQxF
	gFIlD1uxRzTJVktZSgZ0Gr+JlxtHmoZn4ywiD+NQe/rxbdfACNdpHWPpueB1zvH5
	1e66aOsdJQtPp+er3Wxnq/ZHDRi18Cwly6fyAxc2sgKdkj2F3Tl4+7hhhi06r0S/
	Dwp9/6D5W8v4gXgY2vuiaun9m9iwpe5Oooqbn8ofqHafXbllD5vyDkNVmOtOwqig
	rSauuP6Tz7D3/luY1aHG3s05ur0cL10kUsYkpQG3FVp7qw==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id L8PhjzVZZJ8Z; Thu, 11 Apr 2024 18:23:07 +0000 (UTC)
Received: from [100.96.154.26] (unknown [104.132.0.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4VFp3C5dfhz6Cnk8m;
	Thu, 11 Apr 2024 18:23:03 +0000 (UTC)
Message-ID: <7c546232-0ad5-4ad3-bb12-2927c1b65c0e@acm.org>
Date: Thu, 11 Apr 2024 11:23:01 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] scsi: ufs: core: changing the status to check inflight
To: SEO HOYOUNG <hy50.seo@samsung.com>, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org, alim.akhtar@samsung.com, avri.altman@wdc.com,
 jejb@linux.ibm.com, martin.petersen@oracle.com, beanhuo@micron.com,
 kwangwon.min@samsung.com, kwmad.kim@samsung.com, sh425.lee@samsung.com,
 quic_nguyenb@quicinc.com, cpgs@samsung.com, h10.kim@samsung.com
References: <CGME20240411071042epcas2p4b2e6937a952e6dfa879db166983b1c54@epcas2p4.samsung.com>
 <20240411071444.51873-1-hy50.seo@samsung.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240411071444.51873-1-hy50.seo@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

