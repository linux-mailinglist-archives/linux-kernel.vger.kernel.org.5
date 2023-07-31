Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0BF769911
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 16:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbjGaOKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 10:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjGaOKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 10:10:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C23E6
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 07:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690812568;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WD2g6uj+bczangBD0M6t4+N3tf+625pl7skoKavki5M=;
        b=Y84A6mWPWtvvUcZ2pGjEdrM7DMoJB5bX57excPX1Nkirrx7SOBWBnbKAym3/nRg0z7ByrR
        Nr6kWKuoROJOI48oaEmVYjVPlCRC9Y8iEyIN2zOeq+2+PpZ0luhvBtY7pGNRnALJ0Rl6Ci
        /n1z3AmBR1JjvxH3TamiO5SFbH/+DQA=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-336-tPcVfcK5OgiBdw8aFneG-g-1; Mon, 31 Jul 2023 10:09:27 -0400
X-MC-Unique: tPcVfcK5OgiBdw8aFneG-g-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2b8405aace3so40683991fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 07:09:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690812565; x=1691417365;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WD2g6uj+bczangBD0M6t4+N3tf+625pl7skoKavki5M=;
        b=KxdPyR22O77swLOnUgHHZd7orCcyajp0Z9OA9EjOdRaqXXS8ERzJ/4kGWCdNSL1AWD
         vFtd8vd2brFRIQ1gMj9OIRhvZWcR2T/myjOycjDm4PMQD7M2nJomIqNFBNkIIs/foMY2
         dDM+IwCxwrDk0+Zo/K43NX4RAyEwwisDyuh3sQx0j+kkWCyqQyqHSm7KuLLnd9QJDptL
         YqfLdVxdvQLbAirgXw/foSqAXHUuUYb8uBnNdKNKc7ktQy070bKEpGckxXKvEvoj4Twr
         4nBfd2B6HpWaySWS6awRS+dCylzAFUS7ttbip1vo02mBuSCiYr1KPF1LX/Z87DSoX/qI
         sIWQ==
X-Gm-Message-State: ABy/qLYc9UFyi3GuRWiNQBdrv7Gul7MBtprDFVqwLVRSYWpeghUGXyRv
        Yyb3CHjJodG+Si3XdT5g3RbmhhUhmg6eQoIYPtGUmWIG0lmH9jS2yE6gGyrOPT9YjO6TdwJk9II
        avbZqkgFOOPNj2m+c1RjYSPfs
X-Received: by 2002:a2e:3e07:0:b0:2b9:dd5d:5d0c with SMTP id l7-20020a2e3e07000000b002b9dd5d5d0cmr35013lja.52.1690812565533;
        Mon, 31 Jul 2023 07:09:25 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF97yOz7HL49mkqe4euZC2DWJ1w3zEkXD2P098ai/agoHgCZ9grdbaWYw8ZmQ8KTF5KXSvw7A==
X-Received: by 2002:a2e:3e07:0:b0:2b9:dd5d:5d0c with SMTP id l7-20020a2e3e07000000b002b9dd5d5d0cmr35001lja.52.1690812565150;
        Mon, 31 Jul 2023 07:09:25 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id m17-20020a170906849100b00992d70f8078sm6206032ejx.106.2023.07.31.07.09.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 07:09:23 -0700 (PDT)
Message-ID: <f4497997-83eb-3739-f3b9-e674aec97e08@redhat.com>
Date:   Mon, 31 Jul 2023 16:09:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3] ACPI: scan: Create platform device for CS35L56
Content-Language: en-US
To:     Richard Fitzgerald <rf@opensource.cirrus.com>, rafael@kernel.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, patches@opensource.cirrus.com,
        Simon Trimmer <simont@opensource.cirrus.com>
References: <20230728111345.7224-1-rf@opensource.cirrus.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230728111345.7224-1-rf@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/28/23 13:13, Richard Fitzgerald wrote:
> From: Simon Trimmer <simont@opensource.cirrus.com>
> 
> The ACPI device CSC3556 is a Cirrus Logic CS35L56 mono amplifier which
> is used in multiples, and can be connected either to I2C or SPI.
> 
> There will be multiple instances under the same Device() node. Add it
> to ignore_serial_bus_ids and handle it in the serial-multi-instantiate
> driver.
> 
> There can be a 5th I2cSerialBusV2, but this is an alias address and doesn't
> represent a real device. Ignore this by having a dummy 5th entry in the
> serial-multi-instantiate instance list with the name of a non-existent
> driver, on the same pattern as done for bsg2150.
> 
> Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>

Thank you for your patch, I've applied this patch to my fixes
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=fixes

Note it will show up in my fixes branch once I've pushed my
local branch there, which might take a while.

I will include this patch in my next fixes pull-req to Linus
for the current kernel development cycle.

Regards,

Hans




> ---
>  drivers/acpi/scan.c                             |  1 +
>  drivers/platform/x86/serial-multi-instantiate.c | 14 ++++++++++++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 5b145f1aaa1b..87e385542576 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -1714,6 +1714,7 @@ static bool acpi_device_enumeration_by_parent(struct acpi_device *device)
>  		{"BSG1160", },
>  		{"BSG2150", },
>  		{"CSC3551", },
> +		{"CSC3556", },
>  		{"INT33FE", },
>  		{"INT3515", },
>  		/* Non-conforming _HID for Cirrus Logic already released */
> diff --git a/drivers/platform/x86/serial-multi-instantiate.c b/drivers/platform/x86/serial-multi-instantiate.c
> index 2c2abf69f049..8158e3cf5d6d 100644
> --- a/drivers/platform/x86/serial-multi-instantiate.c
> +++ b/drivers/platform/x86/serial-multi-instantiate.c
> @@ -329,6 +329,19 @@ static const struct smi_node cs35l41_hda = {
>  	.bus_type = SMI_AUTO_DETECT,
>  };
>  
> +static const struct smi_node cs35l56_hda = {
> +	.instances = {
> +		{ "cs35l56-hda", IRQ_RESOURCE_AUTO, 0 },
> +		{ "cs35l56-hda", IRQ_RESOURCE_AUTO, 0 },
> +		{ "cs35l56-hda", IRQ_RESOURCE_AUTO, 0 },
> +		{ "cs35l56-hda", IRQ_RESOURCE_AUTO, 0 },
> +		/* a 5th entry is an alias address, not a real device */
> +		{ "cs35l56-hda_dummy_dev" },
> +		{}
> +	},
> +	.bus_type = SMI_AUTO_DETECT,
> +};
> +
>  /*
>   * Note new device-ids must also be added to ignore_serial_bus_ids in
>   * drivers/acpi/scan.c: acpi_device_enumeration_by_parent().
> @@ -337,6 +350,7 @@ static const struct acpi_device_id smi_acpi_ids[] = {
>  	{ "BSG1160", (unsigned long)&bsg1160_data },
>  	{ "BSG2150", (unsigned long)&bsg2150_data },
>  	{ "CSC3551", (unsigned long)&cs35l41_hda },
> +	{ "CSC3556", (unsigned long)&cs35l56_hda },
>  	{ "INT3515", (unsigned long)&int3515_data },
>  	/* Non-conforming _HID for Cirrus Logic already released */
>  	{ "CLSA0100", (unsigned long)&cs35l41_hda },

