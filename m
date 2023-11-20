Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DACD87F107E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 11:35:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232941AbjKTKfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 05:35:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233085AbjKTKfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 05:35:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25066E3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 02:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700476511;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WDa5Zifa699JA7DgA6NqBUl602nqWvF/0Qs0z1ItO6s=;
        b=XSX1aJAVxBnOE2QsM2OlWcbguDnWIqcnzEwk4C6NS2+mS729v+8oKcOCLdy1Juu1GZQQNc
        KxatyVcpqvAGDK8EfbhR7yZp8tCmMBkZKQDVyK/DFpwo/E7DQEzxvxFO1Mt65zQxxSaZGZ
        E5holZuu05dxMyNK0CdKu6eLLPrL+vc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-X5P8J74zNMWnh4hjRfu_sw-1; Mon, 20 Nov 2023 05:35:09 -0500
X-MC-Unique: X5P8J74zNMWnh4hjRfu_sw-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9d30a6a67abso304559566b.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 02:35:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700476508; x=1701081308;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WDa5Zifa699JA7DgA6NqBUl602nqWvF/0Qs0z1ItO6s=;
        b=gUQMp+EMUN0YlDmnop2sVTStBExjEz0K170OyzWon9S1DPRoypW1YAF5PmB2qN68Pn
         lUurRe65UIaQbatmOiHHhm6C0f10yludn9SYkOUifgIHc4rgXk01rSPXca3nbMtkg2iQ
         8dK0JtWlfCIrQgfgkg+4UrzlzZxhWhtWHPMTZ7RQvVyZYoqjmOg7z/KfBXUJA4CaW2Ex
         Ax3lF8cz3YGfvIdPPMLkBqWbVvR5YsXE3Si2Sy1kSMZG/djeIqGQbpg9YPW4TUTTPJkd
         hwGSEidh/GLqx1hKzZ2ZaVRuGVq5f5KfCjZBRn3CYoG6SM8tUzRnu6q3m1z7WQWetcdi
         1O2A==
X-Gm-Message-State: AOJu0YyV7ZU5/eERxRVgW8sovADJx3SHg2aME1hOgX+IpaJzyhautulj
        8HFnjDS+DuLQlOyWJep5dvVZcvFrW65Pl5e1wpREM/EBMQKu0nW/LJAD2EnvoqZCURwGZyUIdZX
        W2i4dL6SPNgsDQfkWZu/3muo7
X-Received: by 2002:a17:907:c24b:b0:9ae:6ad0:f6db with SMTP id tj11-20020a170907c24b00b009ae6ad0f6dbmr6930270ejc.71.1700476508610;
        Mon, 20 Nov 2023 02:35:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFtYB3LpQ2jUhXembvmGnwIAULaeNK5MwYtq0w1lhRVzSiXtm7qVIWAoEoosVuqDagxql3aow==
X-Received: by 2002:a17:907:c24b:b0:9ae:6ad0:f6db with SMTP id tj11-20020a170907c24b00b009ae6ad0f6dbmr6930238ejc.71.1700476507968;
        Mon, 20 Nov 2023 02:35:07 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id p27-20020a1709060ddb00b009fc50ebb062sm1745968eji.4.2023.11.20.02.35.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Nov 2023 02:35:07 -0800 (PST)
Message-ID: <db2051d0-c847-4d3b-98da-4f4f68a5b30b@redhat.com>
Date:   Mon, 20 Nov 2023 11:35:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 1/9] Documentation/driver-api: Add document about WBRF
 mechanism
Content-Language: en-US, nl
To:     Ma Jun <Jun.Ma2@amd.com>, amd-gfx@lists.freedesktop.org,
        lenb@kernel.org, johannes@sipsolutions.net, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        alexander.deucher@amd.com, Lijo.Lazar@amd.com,
        mario.limonciello@amd.com
Cc:     majun@amd.com, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20231017025358.1773598-1-Jun.Ma2@amd.com>
 <20231017025358.1773598-2-Jun.Ma2@amd.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20231017025358.1773598-2-Jun.Ma2@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/17/23 04:53, Ma Jun wrote:
> Add documentation about AMD's Wifi band RFI mitigation (WBRF) mechanism
> explaining the theory and how it is used.
> 
> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
> ---
>  Documentation/driver-api/wbrf.rst | 73 +++++++++++++++++++++++++++++++
>  1 file changed, 73 insertions(+)
>  create mode 100644 Documentation/driver-api/wbrf.rst
> 
> diff --git a/Documentation/driver-api/wbrf.rst b/Documentation/driver-api/wbrf.rst
> new file mode 100644
> index 000000000000..8561840263b3
> --- /dev/null
> +++ b/Documentation/driver-api/wbrf.rst
> @@ -0,0 +1,73 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +=================================
> +WBRF - Wifi Band RFI Mitigations
> +=================================
> +Due to electrical and mechanical constraints in certain platform designs
> +there may be likely interference of relatively high-powered harmonics of
> +the GPU memory clocks with local radio module frequency bands used by
> +certain Wifi bands.
> +
> +To mitigate possible RFI interference producers can advertise the
> +frequencies in use and consumers can use this information to avoid using
> +these frequencies for sensitive features.
> +
> +When a platform is known to have this issue with any contained devices,
> +the platform designer will advertise the availability of this feature via
> +ACPI devices with a device specific method (_DSM).
> +* Producers with this _DSM will be able to advertise the frequencies in use.
> +* Consumers with this _DSM will be able to register for notifications of
> +frequencies in use.
> +
> +Some general terms
> +==================
> +Producer: such component who can produce high-powered radio frequency
> +Consumer: such component who can adjust its in-use frequency in
> +           response to the radio frequencies of other components to
> +           mitigate the possible RFI.
> +
> +To make the mechanism function, those producers should notify active use
> +of their particular frequencies so that other consumers can make relative
> +internal adjustments as necessary to avoid this resonance.
> +
> +ACPI interface
> +==============
> +Although initially used by for wifi + dGPU use cases, the ACPI interface
> +can be scaled to any type of device that a platform designer discovers
> +can cause interference.
> +
> +The GUID used for the _DSM is 7B7656CF-DC3D-4C1C-83E9-66E721DE3070.
> +
> +3 functions are available in this _DSM:
> +
> +* 0: discover # of functions available
> +* 1: record RF bands in use
> +* 2: retrieve RF bands in use
> +
> +Driver programming interface
> +============================
> +.. kernel-doc:: drivers/platform/x86/amd/wbrf.c
> +
> +Sample Usage
> +=============
> +The expected flow for the producers:
> +1) During probe, call `acpi_amd_wbrf_supported_producer` to check if WBRF
> +can be enabled for the device.
> +2) On using some frequency band, call `acpi_amd_wbrf_add_remove` with 'add'
> +param to get other consumers properly notified.
> +3) Or on stopping using some frequency band, call
> +`acpi_amd_wbrf_add_remove` with 'remove' param to get other consumers notified.
> +
> +The expected flow for the consumers:
> +1) During probe, call `acpi_amd_wbrf_supported_consumer` to check if WBRF
> +can be enabled for the device.
> +2) Call `amd_wbrf_register_notifier` to register for notification
> +of frequency band change(add or remove) from other producers.

> +3) Call the `amd_wbrf_retrieve_freq_band` intentionally to retrieve
> +current active frequency bands considering some producers may broadcast
> +such information before the consumer is up.

"intentionally" in this sentence should be "initially" (I presume).

With that fixed and Ilpo's review comments addressed you may add my:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

to this patch.

Regards,

Hans




> +4) On receiving a notification for frequency band change, run
> +`amd_wbrf_retrieve_freq_band` again to retrieve the latest
> +active frequency bands.
> +5) During driver cleanup, call `amd_wbrf_unregister_notifier` to
> +unregister the notifier.

