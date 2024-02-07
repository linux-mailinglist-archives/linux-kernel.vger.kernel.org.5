Return-Path: <linux-kernel+bounces-56392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EFB784C99A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 12:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA7171C25A03
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5202D1B270;
	Wed,  7 Feb 2024 11:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fcItn1I3"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96901AACC;
	Wed,  7 Feb 2024 11:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707305318; cv=none; b=LJgeQFOl9QAcJtmSJTMmn+B6oCKV2zuN0nceId1/9VOh8NUktGikQRS6L9NVn+cHziEEBw92EgyyifGAUGCVBkMdyfhztKh+03p5Qk7RNo+fwB2DUUPdh+QUtCuW+h72p8HpVfeLzyggtigtl/4TVa8Hkdsv6Vz0Qf1Za/R9id8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707305318; c=relaxed/simple;
	bh=mChLLvfn+WsSX/4Ol3EUABXaUd0ZI/tG6Zz98KwoPc8=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=OBfM5tvUk4HhwVAaWUltDX8WhNvf0cXyBbZhHOBozNOyVmSQ/A+TEoe+frBRr3SDhyqtnN6vLAfc+sw4vyyUqmujV1Ie1j6Eluls0Xrq1nAgir5gNw8R3Eckq0XIN6hwkbL8I0kMaIX4iawfm36zVURCoZWjBNZMmGW9cd0zCow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fcItn1I3; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d0512f6e32so6382881fa.1;
        Wed, 07 Feb 2024 03:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707305315; x=1707910115; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1gcUDslEA/Bw1BsVVSuc8cGc8YlbjxoxUNk/ASpPHtQ=;
        b=fcItn1I34GrrLxVAC3blwnZCWOfGDhkbPiH7wr8aBKBZacDEPfyyruh9Jc+/l/XwKN
         aw+QXgFsC43T3DHpofjL1RJCP0kepJEgyd5mcVlCp2CCsPlfp6BhN3lP5xQ8XO59l4zk
         AKJW0WiUV/QXJatYfM3GxxEu06v9iMPrKCtxVZsT//ndN/qQqvnphTUdUCvpo3FEw+2c
         XZD7jtQKkoXFYklSAMibRu+eviAfX0zUNRM7RA0wHtnmle/HRkevFaD9X28wxQwj9oyi
         40TF820bo65CrI8TXfcdqqmJNaW9cY6WFrStH0AfkMP+Pa/bor/jg/aqbEEZeFOMnJXO
         oaZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707305315; x=1707910115;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1gcUDslEA/Bw1BsVVSuc8cGc8YlbjxoxUNk/ASpPHtQ=;
        b=pqDtjaooSTABkGlPxEw6BcG/IWxweq6GXMgpT5g39ddpGf4wyXIZ7/9Q843WNbUX9t
         K6T2pAFR8bPu56oJCiqbukigrYm25p7j6q9OFgOEWGHAtXzItLDdtFpZiRVBEUqT857s
         /jWsw+vgaz5lk+j7xFPEnFZi3yGO58tP9Hxf7KpJwDib5aE0q+pJ8jeYFCGpLz6KVCFQ
         KAQv1iFwy9eAy7MHJgKhpHsDV4CdfBfUXLg/gHXJTdvPQPkvAUJYUpXQNk1Rtgg7wahp
         raZuGxv9GcV9BRffyPm6r7qszohYjDcc+P9usgB41uWTmCc0bdEryh2PNb8ByIK+kbqg
         aCkQ==
X-Gm-Message-State: AOJu0YzhWP7qP5uOhz0sVGNVkBYK3cSwUUBWZSjh49dCVqEgQszOnsPb
	n56IxCISsCxrp6lghff+1LzlEctXYj1JjW2b+C4fTNrgSIJIr1Mq
X-Google-Smtp-Source: AGHT+IFNRXDFAOkcXrn2c+JUyuqEXiC3mt4GsQhBZg/UU6aYKE28T7UtCDIb7BE3huf/0GRfOqulxA==
X-Received: by 2002:a2e:bb95:0:b0:2d0:c9b5:7257 with SMTP id y21-20020a2ebb95000000b002d0c9b57257mr755754lje.8.1707305314678;
        Wed, 07 Feb 2024 03:28:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVroSiFaR5ihQieFacoRUgcGAmUc85HOb1iiHk5sO3ix0iPsdZpc2MojpiVStXx4aaDY3KCxsbGroSTujTAmDKKXYNV6tGfpjBP3A56EXJXGJfiRkAtnyWOXQl7Y2Y9uRg+e65GwSg2nojmbSTKxo6HJU0PkjoO1SXFf2y+
Received: from [192.168.1.105] ([178.176.77.110])
        by smtp.gmail.com with ESMTPSA id bd9-20020a05651c168900b002d0a10d7618sm148184ljb.75.2024.02.07.03.28.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Feb 2024 03:28:34 -0800 (PST)
Subject: Re: [PATCH] ahci: asm1064: correct count of reported ports
To: "Andrey Jr. Melnikov" <temnota.am@gmail.com>, linux-ide@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: dlemoal@kernel.org, hdegoede@redhat.com
References: <vbpzr7uqpfemb3qa6xy2fxioct44l5vugg2wkywyolfpzqcmau@jgrrhmk2scaj>
From: Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <7559d940-f191-4fe0-e147-17ffa6c1dfc4@gmail.com>
Date: Wed, 7 Feb 2024 14:28:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <vbpzr7uqpfemb3qa6xy2fxioct44l5vugg2wkywyolfpzqcmau@jgrrhmk2scaj>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 2/7/24 12:58 PM, Andrey Jr. Melnikov wrote:

> The ASM1064 SATA host controller always reports wrongly,
> that it has 24 ports. But in reality, it only has four ports.
> 
> before:
> ahci 0000:04:00.0: SSS flag set, parallel bus scan disabled
> ahci 0000:04:00.0: AHCI 0001.0301 32 slots 24 ports 6 Gbps 0xffff0f impl SATA mode
> ahci 0000:04:00.0: flags: 64bit ncq sntf stag pm led only pio sxs deso sadm sds apst 
> 
> after:
> ahci 0000:04:00.0: ASM1064 has only four ports
> ahci 0000:04:00.0: forcing port_map 0xffff0f -> 0xf
> ahci 0000:04:00.0: SSS flag set, parallel bus scan disabled
> ahci 0000:04:00.0: AHCI 0001.0301 32 slots 24 ports 6 Gbps 0xf impl SATA mode
> ahci 0000:04:00.0: flags: 64bit ncq sntf stag pm led only pio sxs deso sadm sds apst 
> 
> 
> Signed-off-by: Andrey Jr. Melnikov <temnota.am@gmail.com>
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index da2e74fce2d9..ec30d8330d16 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -671,9 +671,14 @@ MODULE_PARM_DESC(mobile_lpm_policy, "Default LPM policy for mobile chipsets");
>  static void ahci_pci_save_initial_config(struct pci_dev *pdev,
>  					 struct ahci_host_priv *hpriv)
>  {
> -	if (pdev->vendor == PCI_VENDOR_ID_ASMEDIA && pdev->device == 0x1166) {
> -		dev_info(&pdev->dev, "ASM1166 has only six ports\n");
> -		hpriv->saved_port_map = 0x3f;
> +	if (pdev->vendor == PCI_VENDOR_ID_ASMEDIA) {
> +		if (pdev->device == 0x1166) {

   Maybe *switch* instead?

> +			dev_info(&pdev->dev, "ASM1166 has only six ports\n");
> +			hpriv->saved_port_map = 0x3f;
> +		} else if (pdev->device == 0x1064) {
> +			dev_info(&pdev->dev, "ASM1064 has only four ports\n");
> +			hpriv->saved_port_map = 0xf;
> +		}
>  	}
>  
>  	if (pdev->vendor == PCI_VENDOR_ID_JMICRON && pdev->device == 0x2361) {

MBR, Sergey

