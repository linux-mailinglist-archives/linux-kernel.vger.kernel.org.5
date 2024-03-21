Return-Path: <linux-kernel+bounces-110608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 728BD88613E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 20:44:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20B721F22917
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 19:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4B6134435;
	Thu, 21 Mar 2024 19:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="rUgkUQ4p"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E302132C38;
	Thu, 21 Mar 2024 19:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711050274; cv=none; b=NR7imQrWVqHJdc+qWPC2yToodQ2wuba9b+GdfKKCvPELw5nS2BeUX8/W05L3wComR/dhl3M8Q6IvMLxQLQgpcNGNAN6tRpTqtBEjIcabC4jFe7F5EV9hEi1WQV7dS7sJJDOMBpMQJZEHZMZNAYKZ7Wk6bRNOSpKU8dDVDFFEUdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711050274; c=relaxed/simple;
	bh=rbdZgAx5OMc44/b4taFIydsj3IvyxH7jHFsK3TNL/BQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HqMlrV3QkZ9hjlTfoWpFvKWwTbma28aFpmlHk2SeXoZw1+QJHfXlla2lhf8qDBqhUPwZgHTqGiEzr1uaYtIKQ2PzkG10Bv4+oJqk9x5m5TruX2m8RpipXh15+hwfNdfov1A2XmyX6tNxnnt2++4XQGceSwSGtu0n681gSyg4jmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=rUgkUQ4p; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4V0wrw3Y7ZzlgVnF;
	Thu, 21 Mar 2024 19:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:references:content-language:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1711050263; x=1713642264; bh=SpVSKe2FDWsZA6RlvkSY8fUG
	PrZo8UAPmj+w+wT8abY=; b=rUgkUQ4pKvRo0MnKMv8HBajk8pKVG9x3IEojHuPf
	Ksp0ApJU9+XRXIEOYNl6KEdaEMhGZ/HAPli/vwcHJ3F/ghYkYIZmqZYQpzGkFLLA
	KQNMM5bw3tVq5qbSjO5ztqkqXkvgQCTZNc+088HlNcasrDeXjnZve3u8diVNwnkL
	hqJNbyih6MHR/86S2+cBdrEg2Lg1vIrbZBqbl6jo4MUNgw6ifBWs8Avsmr7CmB/Z
	Y4dzECXDa+aqHwSnkL0rh3mcnM2CcTQRtqwjCDZM4KtwTr9JukhvizlTlTjxqfv9
	+ai3/saCPjc9cNvBevTZo+ZGjgvVBRGjnFcymG1fT4BU2w==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id TjaQfJAj6kku; Thu, 21 Mar 2024 19:44:23 +0000 (UTC)
Received: from [100.96.154.173] (unknown [104.132.1.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4V0wrh4tZhzlgTGW;
	Thu, 21 Mar 2024 19:44:20 +0000 (UTC)
Message-ID: <e170642d-9ae8-4d5a-90d9-2837f1bcef9b@acm.org>
Date: Thu, 21 Mar 2024 12:44:19 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] block: implement NVMEM provider
Content-Language: en-US
To: Daniel Golle <daniel@makrotopia.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Jens Axboe <axboe@kernel.dk>, Dave Chinner <dchinner@redhat.com>,
 Jan Kara <jack@suse.cz>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?=
 <linux@weissschuh.net>, Damien Le Moal <dlemoal@kernel.org>,
 Li Lingfeng <lilingfeng3@huawei.com>, Christian Brauner
 <brauner@kernel.org>, Christian Heusel <christian@heusel.eu>,
 Min Li <min15.li@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Avri Altman <avri.altman@wdc.com>, Hannes Reinecke <hare@suse.de>,
 Christian Loehle <CLoehle@hyperstone.com>, Bean Huo <beanhuo@micron.com>,
 Yeqi Fu <asuk4.q@gmail.com>, Victor Shih <victor.shih@genesyslogic.com.tw>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Dominique Martinet <dominique.martinet@atmark-techno.com>,
 "Ricardo B. Marliere" <ricardo@marliere.net>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux-block@vger.kernel.org
References: <cover.1711048433.git.daniel@makrotopia.org>
 <7555db6eb71d4ccb2b9d5ebe3b41dc34088c6316.1711048433.git.daniel@makrotopia.org>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <7555db6eb71d4ccb2b9d5ebe3b41dc34088c6316.1711048433.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/21/24 12:34, Daniel Golle wrote:
> On embedded devices using an eMMC it is common that one or more partitions
> on the eMMC are used to store MAC addresses and Wi-Fi calibration EEPROM
> data. Allow referencing the partition in device tree for the kernel and
> Wi-Fi drivers accessing it via the NVMEM layer.

Why to store calibration data in a partition instead of in a file on a
filesystem?

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8c88f362feb55..242a0a139c00a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3662,6 +3662,11 @@ L:	linux-mtd@lists.infradead.org
>   S:	Maintained
>   F:	drivers/mtd/devices/block2mtd.c
>   
> +BLOCK NVMEM DRIVER
> +M:	Daniel Golle <daniel@makrotopia.org>
> +S:	Maintained
> +F:	block/blk-nvmem.c

Why to add this functionality to the block layer instead of somewhere
in the drivers/ directory?

Thanks,

Bart.

