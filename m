Return-Path: <linux-kernel+bounces-139099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D6289FE8A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 845751C220E8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0520A17BB2C;
	Wed, 10 Apr 2024 17:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="1uyU8lgt"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949C9178CEE;
	Wed, 10 Apr 2024 17:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712770181; cv=none; b=hFPnpgR/yQo36uNVoWpsIuY73yTjUOwLn36+N4S+oGGcx8bz+Ncl/iqWC8NGx1MgyysvzqisppPc+LcQM7EkXcxOAIBocvDLihwcg13yU5OfzNcMPcOMtt5CmBDq4eqEhS5yd36LPStCHP1kqmnKGkScRUgCuC6q7i8pXxfiKVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712770181; c=relaxed/simple;
	bh=FOUarcCd37+mdyoB5X+/EZhHU0hgvYzQS2orUbaNveg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ppttTWivc+J6lANqpqLIlrhjssByJPnMYmdY7Bo5T5XxncQfs4uHuSim4f7fFAwgo9jsA/BaV+JM2+anGQYxfdkjd6XxUqM5WQ+VvLOeen6rLfuxrfUZ2V7Pi+9d31Yg6C0uAmqTGTR8qtaNE4kDsv7v3caio/YuVuIRI+/b62A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=1uyU8lgt; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4VF8vx1X6NzlgVnF;
	Wed, 10 Apr 2024 17:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:references:content-language:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1712770171; x=1715362172; bh=/ejLhzmQMUqK5UmgZEEMQYhm
	2HOU1qT+IdJIitt7/54=; b=1uyU8lgtDUWhSfRwtwlS+jbrXEXd/mro0Fa9pG2a
	BnDV8TDIVggxjeOCobxsdRGEq5v7oZWJ0iMyaNHJNuwwFPP3/h0WU03w22GCGc+X
	Ulgvb4Jdp9JdIVCfaUx3Ezmf3OiCx1tzpX5BPBIen02Uy4IT9JXruG8OPeEm1n+c
	LR6c0VLnJItLeGtFU4GKHd3OBqG//RDV1RhaxVSWPKWvG1MdVRA4hXodOYwlVd8/
	QFaRJlByCB0q9U3gVbC12yT2kM/9OXRCFqRrUH7Orx3DIGNLgZfe2NQkG2s+0cRS
	Y2UnJHrxlpBznDCsTMZrJQfFmIrb+e5/3tQ359JvYF01XQ==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Lhg5OmLnP2t5; Wed, 10 Apr 2024 17:29:31 +0000 (UTC)
Received: from [100.125.77.89] (unknown [104.132.0.89])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4VF8vs1DCxzlgTsK;
	Wed, 10 Apr 2024 17:29:28 +0000 (UTC)
Message-ID: <8b3fd7b3-3fad-4baf-8df5-55fe0fdc9438@acm.org>
Date: Wed, 10 Apr 2024 10:29:26 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] scsi: ufs: Remove support for old UFSHCI versions
Content-Language: en-US
To: Avri Altman <Avri.Altman@wdc.com>,
 "James E . J . Bottomley" <jejb@linux.ibm.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: "hch@infradead.org" <hch@infradead.org>, Bean Huo <beanhuo@micron.com>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20240407060412.856-1-avri.altman@wdc.com>
 <20240407060412.856-2-avri.altman@wdc.com>
 <37c51970-1408-4a71-926a-780c663e5572@acm.org>
 <DM6PR04MB657551A7FAB39883B3D890F1FC062@DM6PR04MB6575.namprd04.prod.outlook.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <DM6PR04MB657551A7FAB39883B3D890F1FC062@DM6PR04MB6575.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/10/24 00:06, Avri Altman wrote:
> And the commit log say:
> To be extra cautious, leave out support for
> UFSHCI2.0 as well, and just remove support of host controllers prior
> to UFS2.0.
> 
> Isn't that clear enough?

In the description of this patch I see "leave out support for
UFSHCI2.0 as well". I read this as "leave out UFSHCI 2.0 support from
the driver". Apparently you meant "leave out removal of UFSHCI 2.0 
support from this patch"?

Thanks,

Bart.


