Return-Path: <linux-kernel+bounces-125453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E81892659
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 22:49:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 534B21C21478
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 21:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F5C13CAA1;
	Fri, 29 Mar 2024 21:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="NvrFdpa8"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E161E897;
	Fri, 29 Mar 2024 21:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711748972; cv=none; b=imRoeGH5xl/m3DLOY7eCKUi7sprzA+ulAK+xbNkaFo1euIRtzYwvf3H4dlb7hLHe045/baQJ6cSZTbqo4R0pL5Iq5tUuITKZmKpTYKmEOpE+WR28JBkuvtdReqGO578erBnsayEER+gE0FpTbm2ORQ89kva6JAlO77OMhce+VuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711748972; c=relaxed/simple;
	bh=FRIggP1YvWWV3rj+5WU1Cj2nMoZrQOSbDSPE/2jMC40=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aJ5QcVIvIx+WnKyttgMHvYUQSlytXOS/S8mBHQM9Hu5SDmV6w8EaoneOQybOr2ia90h2pcCFuJ1qFgW2XHSKtq+rRo65+VyKB6HL7YMvKRvWoAljPnBIY1gT3eXWaHgGvBhyjfxIlHgqm5rqfVcUscZbRMZfQIZ/pKdrt3mA6mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=NvrFdpa8; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4V5vFQ6PQmzlgVnN;
	Fri, 29 Mar 2024 21:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1711748967; x=1714340968; bh=FRIggP1YvWWV3rj+5WU1Cj2n
	MoZrQOSbDSPE/2jMC40=; b=NvrFdpa8pcA9cG+NIiJnuoeRqa/nPyhvnOtdKtLd
	WqtQBmfv5Xxa/dgMQibjBYWpMQXU99b6524nnJyI8pR/Q1lbHWv1wXDr0wGHEsNl
	MnIwbJxL0DpSjF8SNG2GSqM2pNOxYN5q/Qkk1lddJBYelx8ypgvgvClefq1Mhl24
	H0gUpQPwbjzLn0glITC1tXYRk/I87LnqCSGaNh3fPf4IJnFVILDFulxZED+xaII6
	iBr5thFOG0UqWCqaTUezS8lMnQIdJZ40OgJlZMfMAGoHuNfec/Jn1agU0vb5QT1L
	9pHLevDlEg286EulZVVF/0rInaBlREIxgEGvUz37Avt+XA==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id cjt8OaaFumuO; Fri, 29 Mar 2024 21:49:27 +0000 (UTC)
Received: from [192.168.3.219] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4V5vFH3TRbzlgTGW;
	Fri, 29 Mar 2024 21:49:23 +0000 (UTC)
Message-ID: <ecd24b64-0f27-486b-a7aa-b4b51b7b16de@acm.org>
Date: Fri, 29 Mar 2024 14:49:21 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/11] scsi: ufs: core: Remove unnecessary wmb() prior
 to writing run/stop regs
To: Andrew Halaney <ahalaney@redhat.com>, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Hannes Reinecke <hare@suse.de>, Janek Kotas <jank@cadence.com>,
 Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>,
 Can Guo <quic_cang@quicinc.com>, Anjana Hari <quic_ahari@quicinc.com>
Cc: Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240329-ufs-reset-ensure-effect-before-delay-v5-0-181252004586@redhat.com>
 <20240329-ufs-reset-ensure-effect-before-delay-v5-11-181252004586@redhat.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240329-ufs-reset-ensure-effect-before-delay-v5-11-181252004586@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

