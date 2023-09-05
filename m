Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30FAA792B29
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242605AbjIEQtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354235AbjIEKQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 06:16:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 192A8199
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 03:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693908933;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qwpPqy/Nul6ICV3KsGmrMJGyrANxddxrtAj9ez3IBjE=;
        b=Xy+Wgh1AbbKwmXjLruSN/Hgxg6aGk0dJUGaCDObd0bmhHCbwkFQTyv5VPjCyrRJhJ7T2Hb
        Eyjwmjqvq3GpxYmsu6lhIq7W6x6nbYeLKHwcxPG7Wowen6VPbKkCLIOagQ7tcyU18CxML9
        4489GI3BGeAcxvP4syLIb5x62/CIudg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-ONroLj-aN-28_ruL75vVrQ-1; Tue, 05 Sep 2023 06:15:31 -0400
X-MC-Unique: ONroLj-aN-28_ruL75vVrQ-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-993eeb3a950so194799366b.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 03:15:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693908930; x=1694513730;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qwpPqy/Nul6ICV3KsGmrMJGyrANxddxrtAj9ez3IBjE=;
        b=RjKNpKFrqVPoJMdO0KrusDP3taCJmmmi6gdADRR8wx+LWFTI07XvGVeAMGuYz42DsF
         JvMumMmMtwnwbC2QlfMZ1gNmzWGxBGIJtqkbHMXRkfW/uaZDS/loKHvbkTyMaKtDf66D
         iiF2lcRJq39HFd+IwBNaqWlp0dRZt5p479ZsTkh36TYrsxMPLgTRybC7S8m1c/N4ZQwQ
         0uoUvRwTYfGvk7L4h3t7Zbv/i6prNHElMc2w9P1BlY8UoaA90//lO0yYdZWwFtg4Ry7e
         8m3Geq8iXyzG8SX7ZTExuuDta9UnxmX7e0wcfRgSlw4FzgIj8hbIcVtlbYcGZ3fuhf7M
         mjBg==
X-Gm-Message-State: AOJu0YzV9EFEDUObMl3y5RuiLGiGttRO80d2KW3PyGFOkmGCz27K5/uv
        UlqBFC8s3OWbJVhynsqCpKVa+cVPjGQMY6DsHKLk32G+JuSw608y8KX22T9NEDHJBF8vWp8XbFV
        6ixYNw4OePGh0BjmRP3AkXfaQ
X-Received: by 2002:a17:907:272a:b0:992:7295:61c9 with SMTP id d10-20020a170907272a00b00992729561c9mr9770475ejl.69.1693908930649;
        Tue, 05 Sep 2023 03:15:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOZ3vRjEeXXTTre5eaeA9/5V2DgQpaicUSn9RLKUyLaRClmWMLa5EvQ5id1mZBpcbjlMrHJg==
X-Received: by 2002:a17:907:272a:b0:992:7295:61c9 with SMTP id d10-20020a170907272a00b00992729561c9mr9770461ejl.69.1693908930364;
        Tue, 05 Sep 2023 03:15:30 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id mf25-20020a170906cb9900b0099d804da2e9sm7422886ejb.225.2023.09.05.03.15.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Sep 2023 03:15:29 -0700 (PDT)
Message-ID: <ead0bc03-2008-96d8-c313-5dc4a9e63479@redhat.com>
Date:   Tue, 5 Sep 2023 12:15:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v16 3/3] platform/x86/amd: pmc: Don't let PCIe root ports
 go into D3
Content-Language: en-US, nl
To:     Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        bhelgaas@google.com, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        Iain Lane <iain@orangesquash.org.uk>
References: <20230829171212.156688-1-mario.limonciello@amd.com>
 <20230829171212.156688-4-mario.limonciello@amd.com>
 <ceda84a0-e5cd-f6dc-3e3c-52e85fda8318@amd.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <ceda84a0-e5cd-f6dc-3e3c-52e85fda8318@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shyam,

On 9/5/23 12:08, Shyam Sundar S K wrote:
> 
> 
> On 8/29/2023 10:42 PM, Mario Limonciello wrote:
>> commit 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
>> changed pci_bridge_d3_possible() so that any vendor's PCIe ports
>> from modern machines (>=2015) are allowed to be put into D3.
>>
>> Iain reports that USB devices can't be used to wake a Lenovo Z13
>> from suspend. This is because the PCIe root port has been put
>> into D3 and AMD's platform can't handle USB devices waking from
>> a hardware sleep state in this case.
>>
>> This problem only occurs on Linux, and only when the AMD PMC driver
>> is utilized to put the device into a hardware sleep state. Comparing
>> the behavior on Windows and Linux, Windows doesn't put the root ports
>> into D3.
>>
>> A variety of approaches were discussed to change PCI core to handle this
>> case generically but no consensus was reached. To limit the scope of
>> effect only to the affected machines introduce a workaround into the
>> amd-pmc driver to only apply to the PCI root ports in affected machines
>> when going into hardware sleep.
>>
>> Link: https://lore.kernel.org/linux-pci/20230818193932.27187-1-mario.limonciello@amd.com/
>> Fixes: 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
>> Reported-by: Iain Lane <iain@orangesquash.org.uk>
>> Closes: https://forums.lenovo.com/t5/Ubuntu/Z13-can-t-resume-from-suspend-with-external-USB-keyboard/m-p/5217121
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> 
> See if this change can be moved to pmc-quirks.c, besides that change
> looks good to me. Thank you.
> 
> Acked-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>

Thank you for the review.

I also just replied to this series (to the cover-letter)
with an alternative approach based on making the
XHCI driver call pci_d3cold_disable() on the XHCI
PCIe-device on affected AMD chipsets.

That seems like a cleaner approach to me. I wonder
if you have any remarks about that approach ?

Regards,

Hans


> 
>> ---
>> v15->v16:
>>  * Only match PCIe root ports with ACPI companions
>>  * Use constraints when workaround activated
>> ---
>>  drivers/platform/x86/amd/pmc/pmc.c | 39 ++++++++++++++++++++++++++++++
>>  1 file changed, 39 insertions(+)
>>
>> diff --git a/drivers/platform/x86/amd/pmc/pmc.c b/drivers/platform/x86/amd/pmc/pmc.c
>> index eb2a4263814c..6a037447ec5a 100644
>> --- a/drivers/platform/x86/amd/pmc/pmc.c
>> +++ b/drivers/platform/x86/amd/pmc/pmc.c
>> @@ -741,6 +741,41 @@ static int amd_pmc_czn_wa_irq1(struct amd_pmc_dev *pdev)
>>  	return 0;
>>  }
>>  
>> +/* only allow PCIe root ports with a LPS0 constraint configured to go to D3 */
>> +static int amd_pmc_rp_wa(struct amd_pmc_dev *pdev)
>> +{
>> +	struct pci_dev *pci_dev = NULL;
>> +
>> +	while ((pci_dev = pci_get_device(PCI_VENDOR_ID_AMD, PCI_ANY_ID, pci_dev))) {
>> +		struct acpi_device *adev;
>> +		int constraint;
>> +
>> +		if (!pci_is_pcie(pci_dev) ||
>> +		    !(pci_pcie_type(pci_dev) == PCI_EXP_TYPE_ROOT_PORT))
>> +			continue;
>> +
>> +		if (pci_dev->current_state == PCI_D3hot ||
>> +		    pci_dev->current_state == PCI_D3cold)
>> +			continue;
>> +
>> +		adev = ACPI_COMPANION(&pci_dev->dev);
>> +		if (!adev)
>> +			continue;
>> +
>> +		constraint = acpi_get_lps0_constraint(adev);
>> +		if (constraint != ACPI_STATE_UNKNOWN &&
>> +		    constraint >= ACPI_STATE_S3)
>> +			continue;
>> +
>> +		if (pci_dev->bridge_d3 == 0)
>> +			continue;
>> +		pci_dev->bridge_d3 = 0;
>> +		dev_info(&pci_dev->dev, "Disabling D3 on PCIe root port due lack of constraint\n");
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>  static int amd_pmc_verify_czn_rtc(struct amd_pmc_dev *pdev, u32 *arg)
>>  {
>>  	struct rtc_device *rtc_device;
>> @@ -893,6 +928,10 @@ static int amd_pmc_suspend_handler(struct device *dev)
>>  	case AMD_CPU_ID_CZN:
>>  		rc = amd_pmc_czn_wa_irq1(pdev);
>>  		break;
>> +	case AMD_CPU_ID_YC:
>> +	case AMD_CPU_ID_PS:
>> +		rc = amd_pmc_rp_wa(pdev);
>> +		break;
>>  	default:
>>  		break;
>>  	}
>>
> 

