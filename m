Return-Path: <linux-kernel+bounces-95999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 551C28755E0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E988B1F22F26
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B9C132494;
	Thu,  7 Mar 2024 18:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="bGeBedWF"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A5A13175D;
	Thu,  7 Mar 2024 18:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709835170; cv=none; b=TUOBh6AuhX0yUYdUeiGT+oTWBD2BIiGXohTgDca06gSlss5OOM4f3eCeyL0Dl9cEnnRlfGcgjBuIb/zHC0WW2ErQEnNOvzb6rdvn9nlWRi4Z1PlPLeogcYOcWew+6H4kaplJG227C300xE4TZhhbkhMT8P0V9t+YL6r6+AsjJM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709835170; c=relaxed/simple;
	bh=ptNh2mo3kA8r0uTJ3o5XqNrNxmq8srr28dkdNj40mwY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qilkdDeORi4i9Xh+GxCBaCXv8a5o68pQqwq9TNU7OnL/MMJPVVowfjWuYVSSyX6lWVe8BAw2OQbVlQW5nBsG0ZxNxaa1ZFMcTXIPkv5jCbVuXcl8CGBWt6PNqG29vFtNUlX38mBuGoqihduE2D5zQm4tYTlB/J7cSmT5p+xphu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=bGeBedWF; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4TrHTX1c5hzlgVnN;
	Thu,  7 Mar 2024 18:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:references:content-language:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1709835166; x=1712427167; bh=ptNh2mo3kA8r0uTJ3o5XqNrN
	xmq8srr28dkdNj40mwY=; b=bGeBedWFMRqbp76vxjAOpnqwzbNj+DQKofRH3om3
	AvrM6uAfsoODGZW37FGxT4Y7oFzjBSvfRalw0gtEsm+O6Kfx4NRg6ud2Wi6KB4gt
	3Uf04VXnhLhrg5BOx4QUG/A3GwkSmyCLium8zHnuRRNZT+pT83QmEpTaLV8vbTr2
	MKnqBT46a5P+M5DkkGThZvyOnmzUTFNfO5g5+Zz8Hb7sbbgsEG26qjyv6rJKzhOX
	BT2earSSBnh/3c+V5ZhBOby4SgMdAqLeIRPj5oAzG5Km8DznzPbayoZZcWMN6aGf
	8BZvo/xKjv/pKUzw5y5wXDlLT6zn0Allsxzh9Zm0u5oHTg==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 896gVYegjVWf; Thu,  7 Mar 2024 18:12:46 +0000 (UTC)
Received: from [100.96.154.173] (unknown [104.132.1.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4TrHTT0zTvzlgVnK;
	Thu,  7 Mar 2024 18:12:44 +0000 (UTC)
Message-ID: <44c5fe83-47bd-4117-aafd-1397d95987c3@acm.org>
Date: Thu, 7 Mar 2024 10:12:43 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] scsi: ufs: Re-use compose_dev_cmd
Content-Language: en-US
To: Avri Altman <avri.altman@wdc.com>,
 "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: Bean Huo <beanhuo@micron.com>, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240305210051.10847-1-avri.altman@wdc.com>
 <20240305210051.10847-4-avri.altman@wdc.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240305210051.10847-4-avri.altman@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/5/24 13:00, Avri Altman wrote:
> Move out some of the dev_cmd initializations so it can be used
> elsewhere.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>


