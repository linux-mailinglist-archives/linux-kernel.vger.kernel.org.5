Return-Path: <linux-kernel+bounces-35967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E22283993D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 20:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F2AD1C276B5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146A0811F3;
	Tue, 23 Jan 2024 19:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h2K4ezdB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2507FBC5
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 19:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706036700; cv=none; b=n3bg6H9SI7P+ffp+3W2VapH2xvIONQVO/p61nlR0s+cgXZ0PBPPt3tjL5VP2aFw/oRbXT/q0+JOKQwNWbjpeo+b9/fDtQUtZUFNObW9cc+1B3shsWJYJLZxTVzGRbYedIEOClG5gRTE1yYtbBx8BRKOrdn0I65DHrhsfUAgUTsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706036700; c=relaxed/simple;
	bh=inpYRunu7a+/P69OHKJdfPr+xzfMvH62XScswjJIiSA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SDgucBj8wRpK8onqwcWQWfTPbpULdei6jA7At5lRDJb+R92GM6C/E+QaycgBWZWLzo4S4Y0fBB2tOK4wp4SZ0m3v5rpKwDDSDM5EKIEFylXRBusQ3lGD+/HU7JvDTbqrb1j/TEfJkCfeZB48X8RDjvQ1scIZe+7xa3wqpapeYmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h2K4ezdB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706036697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L/sN5hulO719YCIZsmMNq+K6W2dI39cuVDmxC+XWuWg=;
	b=h2K4ezdBmLUc/XeWusRR+m6nC7UuFwtLY/t/z4qjtpdmFmNAaAMuHuHR0N2XIrpJ65o/es
	AHYWoZykL9jWNUQ2qEXgRQ4JvcW6rR9tzDm4ePmbBGC1hPr9LmdoJrx5isV0a90L7OU+uo
	ZrdTIfGtflQe36WWB+ktu79O/iuzc60=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-qVIQZkS4NkuJCX-ldSG-mA-1; Tue, 23 Jan 2024 14:04:55 -0500
X-MC-Unique: qVIQZkS4NkuJCX-ldSG-mA-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-50e7b2ac430so3388434e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 11:04:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706036694; x=1706641494;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L/sN5hulO719YCIZsmMNq+K6W2dI39cuVDmxC+XWuWg=;
        b=t2HfT272+vTZEnRD11ss1n0AnbCPIA6tK46CqvTwyssCDUE7mI8worSpB5FaQiuTtt
         /bZXXFkLjdSwzW4j5qjNzEXrWFpa96huHrLIUcui7QuJSYBNTCFB4iEHLhgUJJm6xBMG
         UjWEp5wh7oiZnJAhXn6WMryf1G67t9sUb9HsJye0pzfBeZhtKZdzDO4fTUQNsmp2ziaR
         tiCVQ2KkGsY88v1EVZufYIVBCta0uJoucczOkYuJU1nuXSL0BkgaudTJ78o/QiysXxZ6
         7il3OGvZI4tvZ2IVdz6DiA4+g3DwdJETTbLj5vJ33ODGtvgqe9tzblgsKTquhWmMC6j1
         q56Q==
X-Gm-Message-State: AOJu0YzprY4Hg4I+A+MbsPLTw/zam+cUXK/hFenwK+2NkdrKInDkAH8H
	lW/Y6KV7pkUAEqv79K1FsFiAzj+Qtg1VVyXMPinqKI8sejrQRsOPRdbBPzU+BSZWJU6juwBq/fX
	rv6UEpa19erVqpGw159RKPaxP4UIV24Z6eXE2Dc2213WB9M06DshGVVff0FXQvg==
X-Received: by 2002:a05:6512:2256:b0:510:e05:4361 with SMTP id i22-20020a056512225600b005100e054361mr160053lfu.3.1706036694487;
        Tue, 23 Jan 2024 11:04:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IELdDdUxhnmzOyCMSiWHb7nJmmPa4jYjqQ90Y7Q/9boZpyaEPI4tuKbVIU7sH1yj2FDxMnD/Q==
X-Received: by 2002:a05:6512:2256:b0:510:e05:4361 with SMTP id i22-20020a056512225600b005100e054361mr160048lfu.3.1706036694162;
        Tue, 23 Jan 2024 11:04:54 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id vs7-20020a170907a58700b00a2caa85c0c1sm13758772ejc.30.2024.01.23.11.04.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 11:04:53 -0800 (PST)
Message-ID: <c0d59d12-edf3-44eb-adfd-29c3dc1bde23@redhat.com>
Date: Tue, 23 Jan 2024 20:04:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ahci: asm1166: correct count of reported ports
Content-Language: en-US, nl
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: dlemoal@kernel.org
References: <20240123183002.15499-1-conikost@gentoo.org>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240123183002.15499-1-conikost@gentoo.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Conrad,

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

Looks like this is a double submission of the earlier
version (which did make it to the list).

Anyways this version looks good to me too:

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




