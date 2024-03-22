Return-Path: <linux-kernel+bounces-111986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F33E48873C2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 20:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59A8928459E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 19:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60ED78B7C;
	Fri, 22 Mar 2024 19:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="XBx6eZgU"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BCA78B47;
	Fri, 22 Mar 2024 19:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711135205; cv=none; b=fUF+i2G0+lr5n5rdBSYNXBRMBVr21y6h5mGAaxMvGQ/ZlwXVsWA3yhdFmCHGWAMkBBkjoBhJf3ZMrEMwOHLdnd60mZ3N7Z3+zR1CcbDX2yktv/V6+E5CO1AkbMHMxzQ7SgzU6D4IWxs0evOmfrmryhpz6oQvRBXT4oT9tGIQYBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711135205; c=relaxed/simple;
	bh=Djvbgk8eOBHycf42hxOtBMANTsV5hvKlJFnxU1y09+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Td0mizmsc+VWXRslY3ErCgbQUGKOENn7tTeWazD7S75OEDYGc8nDsOlB21J9d7F2F/Yls8yTSYumcmZs28IoQILxhXZHkyHcEbVBubpi37m2P852a66C9SmFiItoOGCXiQ9dN9tAluHOBe3a7wSp4lfo3kakPLtR+orkdSmhQW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=XBx6eZgU; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4V1XGB2MyVzlgVnF;
	Fri, 22 Mar 2024 19:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:references:content-language:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1711135191; x=1713727192; bh=25gd1LQ6Hyviw81xPbwTGNqw
	rAIn+WLE53FkTKTaE5Q=; b=XBx6eZgU3JSstw3QF+AJu+rKZ05Lqh4HGRUUSQeI
	X68GeC6FZ7jEibaQuYEjMF8A5aTvsoySUdZXnjNtGsHi13xFW3X1FTewwtIIxP7F
	NyM+AULWwWqL3Vk5lQnBMtkn2RWES5BKse1KSWtOuhnUGSuyimxCpfkfBVdU3UZr
	76L0RRTR+U/i6BJ/Xg0ZAwruLOvOpAR0fgxL7mRPA9bSEryHrfVGK1E4oEjimN5e
	rG/6Cjdu2fvBVoWdoW+XlifFZn00CfSO45xrgxy7IoSgN7odLpWblDz7BhD1AVTi
	IOe5/zg20Dw+s3XcctoXnDQwDljdFLALYin39RWs44gUsw==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id RPnP1GeUiYtK; Fri, 22 Mar 2024 19:19:51 +0000 (UTC)
Received: from [100.96.154.173] (unknown [104.132.1.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4V1XFw69BpzlgTGW;
	Fri, 22 Mar 2024 19:19:48 +0000 (UTC)
Message-ID: <6a59ac6e-cc1f-46de-92d7-f017082d99d2@acm.org>
Date: Fri, 22 Mar 2024 12:19:47 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] block: implement NVMEM provider
Content-Language: en-US
To: Daniel Golle <daniel@makrotopia.org>
Cc: Rob Herring <robh@kernel.org>,
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
 <e5fb3e70-8f3c-4dda-b642-401d9d047a03@acm.org>
 <Zf3HylHNrrj20mBO@makrotopia.org>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <Zf3HylHNrrj20mBO@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/22/24 11:02, Daniel Golle wrote:
> On Fri, Mar 22, 2024 at 10:52:17AM -0700, Bart Van Assche wrote:
>> On 3/21/24 12:31, Daniel Golle wrote:
>>> On embedded devices using an eMMC it is common that one or more (hw/sw)
>>> partitions on the eMMC are used to store MAC addresses and Wi-Fi
>>> calibration EEPROM data.
>>>
>>> Implement an NVMEM provider backed by a block device as typically the
>>> NVMEM framework is used to have kernel drivers read and use binary data
>>> from EEPROMs, efuses, flash memory (MTD), ...
>>>
>>> In order to be able to reference hardware partitions on an eMMC, add code
>>> to bind each hardware partition to a specific firmware subnode.
>>>
>>> Overall, this enables uniform handling across practially all flash
>>> storage types used for this purpose (MTD, UBI, and now also MMC).
>>>
>>> As part of this series it was necessary to define a device tree schema
>>> for block devices and partitions on them, which (similar to how it now
>>> works also for UBI volumes) can be matched by one or more properties.
>>
>> Since this patch series adds code that opens partitions and reads
>> from partitions, can that part of the functionality be implemented in
>> user space? There is already a mechanism for notifying user space about
>> block device changes, namely udev.
> 
> No. Because it has to happen (e.g. for nfsroot to work) before
> userland gets initiated: Without Ethernet MAC address (which if often
> stored at some raw offset on a partition or hw-partition of an eMMC),
> we don't have a way to use nfsroot (because that requires functional
> Ethernet), hence userland won't come up. It's a circular dependency
> problem which can only be addressed by making sure that everything
> needed for Ethernet to come up is provided by the kernel **before**
> rootfs (which can be nfsroot) is mounted.

How about the initial RAM disk? I think that's where code should occur
that reads calibration data from local storage.

Thanks,

Bart.

