Return-Path: <linux-kernel+bounces-130192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 101D3897533
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B57D51F2AE79
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07569150990;
	Wed,  3 Apr 2024 16:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="k+KaayxM"
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB7C14F9E1;
	Wed,  3 Apr 2024 16:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712161622; cv=none; b=CcBE1+L5MK6vG8pkC6VelUHfwL3tlqfm43vKY0pg14ehrECtFh15yrlEotvjtcygo4/uZdqLrMO7nqNeolKvncYpOpMM/zNWc8hOKj7XlApycfSbP26i5UKRBywaZ8hVUkM/20FC3nGuLtCu3uilpMnsGid94/YfIjBdI4rLzXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712161622; c=relaxed/simple;
	bh=GQ/Rb2a92J5Ir4blww52T7ahTeQB0Ow+ZtEZv9AjOxk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cbzeBOxkb2mniRYaMBD1ZXYnbKmsUtvL7il2r78qmLQAx8BYDVgnGW/aNDLzn9OXDsb9XXUSioEreYIkwSQxA3ZRfBumvKQhXWcWVhgJ4Bp/pX30ubLL88aT9jnJlDNqurYqlt0Yp49D8xYVFR9EIYAQ10m+zwV0iY5Y+HKXn7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=k+KaayxM; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4V8qs008kHz6Cnk8s;
	Wed,  3 Apr 2024 16:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:references:content-language:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1712161617; x=1714753618; bh=rJr6c2TsvOVSrSHj9bLAu908
	h6x2a2x3rAYmyWwx6bo=; b=k+KaayxMp/CMHphAZmsbICFQjXsFzckonBXBQeAt
	uCYoQJPhL1Fjz+21DpG5HXoJMTh3RsMfpJ1ebaJ6vEFZCka8qHWGCmmmV7s250bg
	UcSUqkqLboAai7LcwYTf3IW17NnRWZrDkuhxFZ3/bG6QRj624kNhTi4cHDtNU7gP
	r4MREbTQt5kbVzIyXskKiGh3xqrlaKNIYzOqKeNJGb5N+7C5ADL1lsEJ73vvn3qT
	qCk5UM0aJvP+ZqoJ9gew+U7YFeAtzpPzcl/C1g2jmtwZmu1WN84q8XXOth2LbwNU
	vD6ZFarWxUQlpO+T8iJ/QfBeriG+KwXxJt3x+oGw/YKOLg==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id gZSzaLgRLrrU; Wed,  3 Apr 2024 16:26:57 +0000 (UTC)
Received: from [100.96.154.173] (unknown [104.132.1.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4V8qrw10xhz6Cnk8m;
	Wed,  3 Apr 2024 16:26:55 +0000 (UTC)
Message-ID: <66431679-26f0-48eb-8303-35e151481292@acm.org>
Date: Wed, 3 Apr 2024 09:26:55 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] scsi: ufs: Remove support for old UFSHCI versions
Content-Language: en-US
To: Avri Altman <avri.altman@wdc.com>,
 "James E . J . Bottomley" <jejb@linux.ibm.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>, Bean Huo <beanhuo@micron.com>,
 linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240327071714.757-1-avri.altman@wdc.com>
 <20240327071714.757-2-avri.altman@wdc.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240327071714.757-2-avri.altman@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/27/24 00:17, Avri Altman wrote:
> UFS spec version 2.1 was published more than 10 years ago. It is
> vanishingly unlikely that even there are out there platforms that uses
> earlier host controllers, let alone that those ancient platforms will
> ever run a V6.10 kernel.  Thus, remove support of host controllers prior
> to UFS2.1.

According to this website, Pixel 1 devices have a UFSHCI 2.0 controller:
https://www.gsmarena.com/google_pixel-8346.php. There may be other
smartphones that have a UFSHCI 2.0 controller. Hence, I'm not sure we
can drop support for UFSHCI 2.0 controllers from the kernel.

Thanks,

Bart.

