Return-Path: <linux-kernel+bounces-157684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F538B1491
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 22:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 791051F229AE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D219E1411F4;
	Wed, 24 Apr 2024 20:26:41 +0000 (UTC)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DA713C9C8
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 20:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713990401; cv=none; b=YrTysMmwUQA02HKcAticbhnQBlFsyblMXE0cWBFxC+QPOj0s2S/fc5xcNagjfWcfNvZuvf0VyBwMyvyAsyqB77Xy8wX6FXw4RlDg1losN4cIjYZ7RWrrTno+ivHwUT25Kue5G4CLnkUNxB4o/RqpqrefQxAiwA5uzP2VgMDzVx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713990401; c=relaxed/simple;
	bh=TurauYeb3cnp03IZkMuKWLmSx568+RI1c15xqqCBVJo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P6n1u0MNljw5pKpDjgQPpZypfdTVBOkKLyVafL/uEE5v07k6Wr0MVAb21eJXnj0Cf1J0In7rFD896E8ZREvNu9NgeitC8O1Gh3DjuIJxX+Nb9GCxR7dJKoXmdTcEeo5yug1ySSWR0s9s5eCS2Q5FjukRv9V0RylOP87HJ8zCF6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id F2F6120003;
	Wed, 24 Apr 2024 20:26:35 +0000 (UTC)
Message-ID: <46925bcd-ad92-4c02-90f3-11da5c627391@ghiti.fr>
Date: Wed, 24 Apr 2024 22:26:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/5] firmware: microchip: don't unconditionally print
 validation success
Content-Language: en-US
To: Conor Dooley <conor@kernel.org>, linux-riscv@lists.infradead.org
Cc: Conor Dooley <conor.dooley@microchip.com>,
 Daire McNamara <daire.mcnamara@microchip.com>,
 Cyril Jean <cyril.jean@microchip.com>, linux-kernel@vger.kernel.org
References: <20240410-opulently-epic-8654bdac3422@spud>
 <20240410-throwing-sandworm-7d03e4e2f4e8@spud>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20240410-throwing-sandworm-7d03e4e2f4e8@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

Hi Conor,

On 10/04/2024 13:58, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
>
> If validation fails, both prints are made. Skip the success one in the
> failure case.
>
> Fixes: ec5b0f1193ad ("firmware: microchip: add PolarFire SoC Auto Update support")
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>   drivers/firmware/microchip/mpfs-auto-update.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/firmware/microchip/mpfs-auto-update.c b/drivers/firmware/microchip/mpfs-auto-update.c
> index 33343e83373c..298ad21e139b 100644
> --- a/drivers/firmware/microchip/mpfs-auto-update.c
> +++ b/drivers/firmware/microchip/mpfs-auto-update.c
> @@ -218,10 +218,12 @@ static int mpfs_auto_update_verify_image(struct fw_upload *fw_uploader)
>   	if (ret | response->resp_status) {
>   		dev_warn(priv->dev, "Verification of Upgrade Image failed!\n");
>   		ret = ret ? ret : -EBADMSG;
> +		goto free_message;
>   	}
>   
>   	dev_info(priv->dev, "Verification of Upgrade Image passed!\n");
>   
> +free_message:
>   	devm_kfree(priv->dev, message);
>   free_response:
>   	devm_kfree(priv->dev, response);


This should go into -fixes, but not sure if you take care of this or if 
Palmer should, please let me know so that I can remove this from my list :)

Thanks,

Alex


