Return-Path: <linux-kernel+bounces-35877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2FE88397FF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:41:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BF07284368
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7CB823C3;
	Tue, 23 Jan 2024 18:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A6X/Mbqi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D960881AAA
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 18:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706035298; cv=none; b=PV5Dzh3hORkX4i4sZoGbdJpNTDhjHuS2K2dgoTdWFDuCxdUDSJDNP7EOaT1LQ9GBr08q0w2L8L4ipTrHMLdE9vjrT/r71egi0lsnZo8kuqgiQxiDRlz8DbX3cMnoZB/o2dRFiQKwS3/SJDdA5sd/DX20HOCQ7jScfwu6yptH5uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706035298; c=relaxed/simple;
	bh=ckAqz4et9lSFLsJorrvqjyjEG3gH8tYqrFit4l7uedI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YEGT9glK+cud8cOrC3gCKjZ2jkUDAi5QmjtX7E1wYPpEik5F1vIHD33lB5NPB6TlvNQrE7/x84AdK4mh3xD2xtEc84UFSRONg2Agi/I9KrYGgXcnTioSGjDs3msl55HK8WIJfenUN8JqXfVpPgPVWcczWQ+VAbE8hF6pFDDq+Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A6X/Mbqi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706035295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vg/uqbZoTrsSlKS8IoprBAUYcnSyOGvCkbfDVP4S0ko=;
	b=A6X/Mbqikz5E7z9mUVVTb8GEUX5cx+onwDOGlO/WkFAsFqH6tbcit4NrxMxy8WpisAATyU
	3D5E0dySbu/BhQVGy5qTNoMW0Drd9V67o7NC9c9Xxx4lHFOfjuCoBfXIUwhqJSS677OMPB
	LELxLGWIg6EzRJSnrHnyARaCKU/FWbY=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-ahbNQ00PNnC_0d1BRj5JWA-1; Tue, 23 Jan 2024 13:41:33 -0500
X-MC-Unique: ahbNQ00PNnC_0d1BRj5JWA-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a2888d63b80so180776066b.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 10:41:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706035292; x=1706640092;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vg/uqbZoTrsSlKS8IoprBAUYcnSyOGvCkbfDVP4S0ko=;
        b=YAXK2qgY/qMzPP9Wxwgb1Dc0z5jAPBL/ZsT5OwCUcHPjqOz8CVrO4dYABsP7afZckV
         ImP9jrm8yQ24yaZdtCM/U4V3A/OK8Brei5fbYR6Z0oDJ8/urbGD6QcepOwYICC0JpUve
         bUwkZFOXg5XKmJMjzGV9hak2ZIwVfJe5pjn8C1hQ/ERacDf3qtwuFqA00gJHiln+MmOA
         k9DYiVoEavp4CMoyriD+ih7rFGQikp2XIIV8rvjavhAhOryK1fYAL91pYQWBJmav3+AR
         rXcFwVc872TkxKUQstlzhSY+N3tLZ8bt1y6ksPQDlfADQqNatqd7JVcOJyV+uXX5jput
         ZNcA==
X-Gm-Message-State: AOJu0YyA5uUzLrx+W14WSCvshsJyoqDTMK9aBeBdIuqsQhub3sBbV5bt
	8XkQ00/G63plBz8pj6zQbGGR0xIUAL8rxun7eVSAL4SQhshuQ7XgqSqFKv6Ca9QTdH3VEAQdyzT
	scStobYoEuahR+N9aTVehrOiyCmh6TvfTN5lZrxOt8zVLT5vh5QQyz54DP7ZBa3x/QNFZCg==
X-Received: by 2002:a17:906:e212:b0:a2f:cd67:32f8 with SMTP id gf18-20020a170906e21200b00a2fcd6732f8mr182663ejb.84.1706035292292;
        Tue, 23 Jan 2024 10:41:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHFTZM38PkaEhlGSaQgFhiQmH/t/JCGY5C0+hgF4qoiSsNuehPxqLGBffq9i6qI+AxDQ3zL7A==
X-Received: by 2002:a17:906:e212:b0:a2f:cd67:32f8 with SMTP id gf18-20020a170906e21200b00a2fcd6732f8mr182657ejb.84.1706035291946;
        Tue, 23 Jan 2024 10:41:31 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id j25-20020a1709066dd900b00a26af4d96c6sm14712314ejt.4.2024.01.23.10.41.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 10:41:31 -0800 (PST)
Message-ID: <1776d48f-6bc8-4636-af7e-ee54800845b2@redhat.com>
Date: Tue, 23 Jan 2024 19:41:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ahci: asm1166: correct count of reported ports
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: dlemoal@kernel.org
References: <20240123183002.15499-1-conikost@gentoo.org>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240123183002.15499-1-conikost@gentoo.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 1/23/24 19:30, Conrad Kostecki wrote:
> The ASM1166 SATA host controller always reports wrongly,
> that it has 32 ports. But in reality, it only has six ports.
> 
> This seems to be a hardware issue, as all tested ASM1166
> SATA host controllers reports such high count of ports.
> 
> Example output: ahci 0000:09:00.0: AHCI 0001.0301
> 32 slots 32 ports 6 Gbps 0xffffff3f impl SATA mode.
> 
> By adjusting the port_map, the count is limited to six ports.
> 
> New output: ahci 0000:09:00.0: AHCI 0001.0301
> 32 slots 32 ports 6 Gbps 0x3f impl SATA mode.
> 
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=211873
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218346
> Signed-off-by: Conrad Kostecki <conikost@gentoo.org>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans





> ---
>  drivers/ata/ahci.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 3a5f3255f51b..762c5d8b7c1a 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -663,6 +663,11 @@ MODULE_PARM_DESC(mobile_lpm_policy, "Default LPM policy for mobile chipsets");
>  static void ahci_pci_save_initial_config(struct pci_dev *pdev,
>  					 struct ahci_host_priv *hpriv)
>  {
> +	if (pdev->vendor == PCI_VENDOR_ID_ASMEDIA && pdev->device == 0x1166) {
> +		dev_info(&pdev->dev, "ASM1166 has only six ports\n");
> +		hpriv->saved_port_map = 0x3f;
> +	}
> +
>  	if (pdev->vendor == PCI_VENDOR_ID_JMICRON && pdev->device == 0x2361) {
>  		dev_info(&pdev->dev, "JMB361 has only one port\n");
>  		hpriv->saved_port_map = 1;


