Return-Path: <linux-kernel+bounces-110606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 638D1886135
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 20:40:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1994B284B74
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 19:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC51A134435;
	Thu, 21 Mar 2024 19:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="EgrRMSNc"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880A31E500;
	Thu, 21 Mar 2024 19:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711049993; cv=none; b=o7lb6V3BlciJvvc5zFDEBT1RvgvyVihkU367BKM9hneApVmjlHt5rl+VEFSFLri9Pb6xB5IneuNEC/7Mz/nk9ZB/1SstPir3/ORO+t9HQHVu3YCIrdDx8ATol3ADg7knz+qW0OQ1lggfFrN5WXYpnnUbXB+MQwr3l+7oj/5zMtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711049993; c=relaxed/simple;
	bh=GjHlfCNvLtLaYhBRLOZv2mrE5/DNMisJ2TJ1GxHA2ZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tTP+1U0wpWZoOEwQ4KKZncKTPCYtMVPGp+HnuU03+PmTfGfzeon5mAilev6KpOfHoCjHLGkgUC3Gd5q2L8rERoOcLLIq6TRxVhQlNU4U6oai1uvPuwzSQoh30eOgP7bvie7ns528Sdvlvr5mGI02ry2jLpLtCcSpleNnOreLLmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=EgrRMSNc; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4V0wlV4m5XzlgVnF;
	Thu, 21 Mar 2024 19:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:references:content-language:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1711049980; x=1713641981; bh=ZwBvmeDuFy6qzsqAXoJIv3bY
	FPMnT5rPGXQS2NHLAx4=; b=EgrRMSNcPkgZtJmWOb+uXikse00Y/vshM3pH52aX
	MaEiEf0WCgJKPshbGc7+vad8a5qYbW5MwOfh8P9qegGUsccTrc166O9UrcxL4rX3
	YPl7sb1VYdOCrYOJI7yyRPOncHhVrISycbdmD5dYhcHpZ1ofkXfiyXHNuc/YPYRP
	fPdB1ei66eutNFDhXZlUHhgvV/pjvSYHcfEPGU8tgF/qcTkcY0idWYKoKl2Rs/ik
	8vy8fn4b84k2jNc2RkQeiIl9TRF5hGWw1sc4jlbY9s9nuTZu4SWjX603enthCDXk
	ZoTzAnQFaxdCcmRXWr/WJ4kJsziZfRJs3/yLDnyHnE2fyw==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id VNP5YjymPFIX; Thu, 21 Mar 2024 19:39:40 +0000 (UTC)
Received: from [100.96.154.173] (unknown [104.132.1.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4V0wlF4WF9zlgTGW;
	Thu, 21 Mar 2024 19:39:37 +0000 (UTC)
Message-ID: <38efd4e4-0421-4318-8b2d-ca2603d482f5@acm.org>
Date: Thu, 21 Mar 2024 12:39:33 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] dt-bindings: block: add basic bindings for block
 devices
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
 <28dcc69ecf9d55e95991d8f2a8e19f71bbd32af0.1711048433.git.daniel@makrotopia.org>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <28dcc69ecf9d55e95991d8f2a8e19f71bbd32af0.1711048433.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/21/24 12:32, Daniel Golle wrote:
> +$id: http://devicetree.org/schemas/block/partition.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Partition on a block device
> +
> +description: |
> +  This binding describes a partition on a block device.
> +  Partitions may be matched by a combination of partition number, name,
> +  and UUID.
> +
> +maintainers:
> +  - Daniel Golle <daniel@makrotopia.org>
> +
> +properties:
> +  $nodename:
> +    pattern: '^block-partition-.+$'
> +
> +  partnum:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Matches partition by number if present.
> +
> +  partname:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description:
> +      Matches partition by PARTNAME if present.
> +
> +  partuuid:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description:
> +      Matches partition by PARTUUID if present.
> +
> +  nvmem-layout:
> +    $ref: /schemas/nvmem/layouts/nvmem-layout.yaml#
> +    description:
> +      This container may reference an NVMEM layout parser.

Does the above imply that only systems with a single block device are
supported?

Supporting partition numbers seems unfortunate to me. Partition numbers
will change if the partition scheme changes.

Bart.

