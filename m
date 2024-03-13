Return-Path: <linux-kernel+bounces-102578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1D287B429
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 23:07:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F768B23414
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 22:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0888259176;
	Wed, 13 Mar 2024 22:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jf5v6EFO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD2D59B43
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 22:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710367615; cv=none; b=t85JjBhDBMUMgCNMeIKeXtZRxfx+3BFiFoADZqHfBqj3sE8dQvkqQlGqJBSwmkfw2K5h9vMh6T3rmZUlCszTye8gVKwip6PYcDRsUaarQm3Rq8O7Ek4tA/fQEqk//9hZMr99olI0SX3tZu0QCD2wxueoLWuwEoOsME/mzo8eXjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710367615; c=relaxed/simple;
	bh=N7r0G7B9q/oyyJ7Dmyn3sKZrxXNeqRMYC837/sBRDCs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mwvRBjzM1GKp7wRdkcZS+cl8pup3o6iFWzKA+WcoeO5EBHmRSJE32GE+smRJRdlVmbp8xnXLFgMrmhTejdPVSjr8Ct1spReOW4gmlvn9u7f/mSN4zXSaPTAeHQYxAi2r2ykJyU37FnKVPMeXbsa161f3bI9KhW2OP+cnVSI4zmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jf5v6EFO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710367612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=euRtFSTUhVmhnZxiO/6tHfKYbzxwPzGW5Dtxe0N8J6U=;
	b=Jf5v6EFO0xMyBHw+8nFCn7P3YF638Y49s5ylglTcohPy51nKrMmZ+Fj3IACmzHgPab6Yrh
	6v/fJWN5Hl5TtbLWvExug65IJPXVq2juGUjIRyUZBq2K2RtnQh69tdnfy75Dc2fs04rgqJ
	5Qz5QjYfB7KnEnpb0guaPJCd/zpTymM=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-sO4ERJeFOteAtNO1o2R8Sg-1; Wed, 13 Mar 2024 18:06:51 -0400
X-MC-Unique: sO4ERJeFOteAtNO1o2R8Sg-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5687a5239f7so137014a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 15:06:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710367610; x=1710972410;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=euRtFSTUhVmhnZxiO/6tHfKYbzxwPzGW5Dtxe0N8J6U=;
        b=p+Q+azs5+1BOmiasB5LPcE89Md1NkiJZSp+q5HMg0U5+9LCt1XNirIc2cCZX7ZeAcY
         n45kYiPg2qrvHZjpaJJy5Z8Ci3iCOOMp9sRfmm4BaOoYH9WLAzFDShTUEy82Sq/JGKSP
         Rd7vYTC1ywQgl2/gPND3o6kIIqMaGu+rWWAdzVcD/lzKc2XWUQaTm3VQJyL8yrRJUW0i
         guHk1htK8rqnJsdSHxCN06vk9KeVoHdDGwLRKhueFsssO0akFbU7E02FKQahBJUZyveP
         RnPVfFtdXLnL9esNP0FAbGGEo1PTQixGrqPaveOZ9o331gj30X6xj3WNTBeP0Xn75o/W
         SDXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjVIYAtmlVhm+l2WIMaWq2riac3tU5ok1aYa/RSXJQnUqUToC+IczbnQRYMlq/sa6F9BeFsCTGbcVdwKVY0EBcY/qjYKhmDT2WNEO7
X-Gm-Message-State: AOJu0YzzzHzBTgRsIyWUA4DXl58a/x7aI2gKDUkbAs8nKreYTVaN4cy4
	rRg+B6lEX7ap2RCOMfrDNgy3N9qaDT/GZGAEexO4ThN0c/5Pnnn/qF96IxK5ZnVWtzvH/jj7N+Z
	D1aJqp4n87/XBrjfANvTCm+qFUa3DGTTVDhYeEVkVt1zFb31YRbDw9G+8T1OWwQ==
X-Received: by 2002:a50:bb29:0:b0:568:3362:ccdc with SMTP id y38-20020a50bb29000000b005683362ccdcmr3152557ede.16.1710367610245;
        Wed, 13 Mar 2024 15:06:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGieN1VorljanQZcYQgfoyll+3URJEZ2SfEhkgMK0qTOVapjEmHcBmywc0ixjYtXwfQ4nko1g==
X-Received: by 2002:a50:bb29:0:b0:568:3362:ccdc with SMTP id y38-20020a50bb29000000b005683362ccdcmr3152549ede.16.1710367609901;
        Wed, 13 Mar 2024 15:06:49 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a9-20020aa7cf09000000b0056671c5c1a1sm43033edy.80.2024.03.13.15.06.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Mar 2024 15:06:49 -0700 (PDT)
Message-ID: <cf0a0dbe-0df9-40c3-affd-ddf9b499d03d@redhat.com>
Date: Wed, 13 Mar 2024 23:06:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ahci: asm1064: asm1166: don't limit reported ports
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, dlemoal@kernel.org, cryptearth@googlemail.com
References: <20240313214650.2165-1-conikost@gentoo.org>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240313214650.2165-1-conikost@gentoo.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 3/13/24 10:46 PM, Conrad Kostecki wrote:
> Previously, patches have been added to limit the reported count of SATA
> ports for asm1064 and asm1166 SATA controllers, as those controllers do
> report more ports than physical having.
> 
> Unfortunately, this causes trouble for users, which are using SATA
> controllers, which provide more ports through SATA PMP
> (Port-MultiPlier) and are now not any more recognized.
> 
> This happens, as asm1064 and 1166 are handling SATA PMP transparently,
> so all non-physical ports needs to be enabled to use that feature.
> 
> This patch reverts both patches for asm1064 and asm1166, so old
> behavior is restored and SATA PMP will work again, so all physical and
> non-physical ports will work again.
> 
> Fixes: 0077a504e1a4 ("ahci: asm1166: correct count of reported ports")
> Fixes: 9815e3961754 ("ahci: asm1064: correct count of reported ports")
> Cc: stable@vger.kernel.org
> Reported-by: Matt <cryptearth@googlemail.com>
> Signed-off-by: Conrad Kostecki <conikost@gentoo.org>

Thank you for the quick patch, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans







> ---
>  drivers/ata/ahci.c | 13 -------------
>  1 file changed, 13 deletions(-)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 78570684ff68..562302e2e57c 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -669,19 +669,6 @@ MODULE_PARM_DESC(mobile_lpm_policy, "Default LPM policy for mobile chipsets");
>  static void ahci_pci_save_initial_config(struct pci_dev *pdev,
>  					 struct ahci_host_priv *hpriv)
>  {
> -	if (pdev->vendor == PCI_VENDOR_ID_ASMEDIA) {
> -		switch (pdev->device) {
> -		case 0x1166:
> -			dev_info(&pdev->dev, "ASM1166 has only six ports\n");
> -			hpriv->saved_port_map = 0x3f;
> -			break;
> -		case 0x1064:
> -			dev_info(&pdev->dev, "ASM1064 has only four ports\n");
> -			hpriv->saved_port_map = 0xf;
> -			break;
> -		}
> -	}
> -
>  	if (pdev->vendor == PCI_VENDOR_ID_JMICRON && pdev->device == 0x2361) {
>  		dev_info(&pdev->dev, "JMB361 has only one port\n");
>  		hpriv->saved_port_map = 1;


