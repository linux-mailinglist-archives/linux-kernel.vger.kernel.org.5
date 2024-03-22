Return-Path: <linux-kernel+bounces-111886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 609CD887230
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 18:52:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10F34280CD9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 17:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B6A60872;
	Fri, 22 Mar 2024 17:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="i8YqWF2a"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860F0605C4;
	Fri, 22 Mar 2024 17:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711129958; cv=none; b=KTqx1Mm3eF3sn2kuLrDC019N8ibn9/u3SCEQ4n+I+YcybRpXJwofVLuJq/Ijsj4zrnUeozNflHCR+vv0cFydy79s0LgZ6kW/rhZeMt6NaEpA+ZytDTl4m5EvrluffACPE42PpqRWgVrstrQgqD2RUFSuAQ3qo/vuaC9Xm5ALGAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711129958; c=relaxed/simple;
	bh=R0UTVnALN8i9q7pNCS16NuGrIkRzqq6HAnmbMi4W1E4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Zw7OnKHR90TgA1Zwu20XS5tXz0xFzlg26BWtt5UamyB29OrGHlsqCR1toP84RP3PzCKemDG9sYJissf5+oVK6FrtYEzcnQ/XPxeAHL9U3mVrHltnMqw1Xbdxx2Oz7XfAGxxWH04NQSKKRzD3aIZW16vZadFlu0HMQ2JV6bMZTN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=i8YqWF2a; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4V1VKH3s1vzlgVnF;
	Fri, 22 Mar 2024 17:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:references:content-language:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1711129946; x=1713721947; bh=oMF6dspJ5VT6lz5tMGmJgcgm
	xGvVlF09dV4q3ULAEJo=; b=i8YqWF2a34cnY8+MS2u2uegVHxWozoKH+EkzvC5+
	ze98H9gxaXVknCmeKi3eF7QOBjv3dy5K1TA0ocdV5dIcl8cIab3g44y9BZlPJ+uP
	NkKqEECYrJ45BG31z2v6hUlJZG2dHvK+cA0IN3teiSqU4r1p1PNJkXe+XS4Zui8c
	5wk8M7IhYbS/uDiKJ0nK+tBgxg79El1pT9YOPoFziWha9yONtz8sCzN0wU43u93H
	WqUId6LuvBLYjT7/6kwus8mCOSkS0TcsLEVe3q3/Ave2TMRY1HD2ACiZnjWE65gp
	qVzZv/MoloXjUa3AiG84fS15AJHFkXJX0sm5kOTczSr7Jw==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id RFjf4buQCww8; Fri, 22 Mar 2024 17:52:26 +0000 (UTC)
Received: from [100.96.154.173] (unknown [104.132.1.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4V1VK021NJzlgTGW;
	Fri, 22 Mar 2024 17:52:19 +0000 (UTC)
Message-ID: <e5fb3e70-8f3c-4dda-b642-401d9d047a03@acm.org>
Date: Fri, 22 Mar 2024 10:52:17 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] block: implement NVMEM provider
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
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <cover.1711048433.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/21/24 12:31, Daniel Golle wrote:
> On embedded devices using an eMMC it is common that one or more (hw/sw)
> partitions on the eMMC are used to store MAC addresses and Wi-Fi
> calibration EEPROM data.
> 
> Implement an NVMEM provider backed by a block device as typically the
> NVMEM framework is used to have kernel drivers read and use binary data
> from EEPROMs, efuses, flash memory (MTD), ...
> 
> In order to be able to reference hardware partitions on an eMMC, add code
> to bind each hardware partition to a specific firmware subnode.
> 
> Overall, this enables uniform handling across practially all flash
> storage types used for this purpose (MTD, UBI, and now also MMC).
> 
> As part of this series it was necessary to define a device tree schema
> for block devices and partitions on them, which (similar to how it now
> works also for UBI volumes) can be matched by one or more properties.

Since this patch series adds code that opens partitions and reads
from partitions, can that part of the functionality be implemented in
user space? There is already a mechanism for notifying user space about
block device changes, namely udev.

Thanks,

Bart.

