Return-Path: <linux-kernel+bounces-130612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 960A7897A86
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 23:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C76791C2556B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 21:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8BD156673;
	Wed,  3 Apr 2024 21:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="rJZZhzP/"
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864C52F24;
	Wed,  3 Apr 2024 21:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712179080; cv=none; b=XsH//9nLFO4blr/ygfTxT7EuA976oofN7BPzewum+EqOaXR9X1J+3hBYSN7Q9d93C/gwlxdtWVgm+PvHKlBDoYo4j5L+p3UGjm/sUQDAd1fewIzrl2/PN5yjQq+ceNxCNJbNYhzi0cGJhU/ZiZlTOXA3mi5lZqfem7JrPsQVCeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712179080; c=relaxed/simple;
	bh=dNO3G1cmq/dc4uXnd299NV+NJSgPbmV3EuF/+cdW3sg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jLmRPUoonjwqYjlVicXl+01skEKX1eIqnnU/j14Rtqjdnrc1hBkZ7pKBRTh+ZuOUR4sBK5FXSNDr7cl4Mo532G/6a/6VIpHgfUrQKa7ABybRag37c1nGqsLA1HQLBfYvxcfQNWXbEXIxxGloZX5f6YH5J6JHrvTlib1p6SXzaQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=rJZZhzP/; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4V8yJj5gSnz6Cnk90;
	Wed,  3 Apr 2024 21:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1712179074; x=1714771075; bh=qlJqcWYZ8uLyD/G2oJ0GBpcH
	FHOQOHmXJ9SlPfBC4Hw=; b=rJZZhzP/tcPcRNimWDA6jZRibk9mYq983mGfaXmG
	o6YBMEy3GPdO0LTLYe6XIJ4QPBTO5FhJ6OIKHDG1q3JJbNASJi1q1AMqO86YCwzD
	1+zJWMJaCLYgfOkz1PMbLW+AzeCo6mU3pW+Qfbd0FTRwy742YKy1nOAeTdRjmz3c
	CmVh/v0hzWQIo+J8EuT9QpS4eqqVzEndkKRyKeDS+eAK8S2RzLE/8+TjMiAcFc9g
	sXTq/WIH2b8HuOA5edKh6hEK0A32Y5AFK3QrC49pyLtdDMycSse4JMDldejqqfpO
	sjOGhjK5xehrJQ9tFCmpfUIy0/AK13UCRlA7Ou/tk5Kuyg==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id GHddmEJaR5ZG; Wed,  3 Apr 2024 21:17:54 +0000 (UTC)
Received: from [100.96.154.173] (unknown [104.132.1.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4V8yJc1cDWz6Cnk8y;
	Wed,  3 Apr 2024 21:17:51 +0000 (UTC)
Message-ID: <4b90d403-b18c-42c9-99b4-013eb7fcf8a8@acm.org>
Date: Wed, 3 Apr 2024 14:17:49 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] scsi: ufs: Remove support for old UFSHCI versions
To: Avri Altman <Avri.Altman@wdc.com>,
 "James E . J . Bottomley" <jejb@linux.ibm.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: "hch@infradead.org" <hch@infradead.org>, Bean Huo <beanhuo@micron.com>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20240327071714.757-1-avri.altman@wdc.com>
 <20240327071714.757-2-avri.altman@wdc.com>
 <66431679-26f0-48eb-8303-35e151481292@acm.org>
 <DM6PR04MB6575BEBF605C9095E62F49E3FC3D2@DM6PR04MB6575.namprd04.prod.outlook.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <DM6PR04MB6575BEBF605C9095E62F49E3FC3D2@DM6PR04MB6575.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/3/24 12:24, Avri Altman wrote:
>> On 3/27/24 00:17, Avri Altman wrote:
>>> UFS spec version 2.1 was published more than 10 years ago. It is
>>> vanishingly unlikely that even there are out there platforms that uses
>>> earlier host controllers, let alone that those ancient platforms will
>>> ever run a V6.10 kernel.  Thus, remove support of host controllers prior
>>> to UFS2.1.
>>
>> According to this website, Pixel 1 devices have a UFSHCI 2.0 controller:
>> https://www.gsmarena.com/google_pixel-8346.php. There may be other
>> smartphones that have a UFSHCI 2.0 controller. Hence, I'm not sure we
>> can drop support for UFSHCI 2.0 controllers from the kernel.
> Actually the Pixel 1 is an excellent example why we can and should -
> It was announced in 2016, running Android 7 with a v4.4 kernel.
> Even if you would be able to find a working specimen of that device -
> It is not realistic it would ever run a 6.10 kernel.

v4.4 is the kernel version of the kernel included in the original
software. Multiple users of older smartphones switch to alternative
distributions once their device is no longer supported by the
manufacturer. These alternatives often include a more recent kernel.
See e.g. https://en.wikipedia.org/wiki/List_of_custom_Android_distributions.

Thanks,

Bart.


