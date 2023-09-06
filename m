Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEA68793C99
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 14:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239297AbjIFMZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 08:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbjIFMZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 08:25:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD011717
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 05:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694003092;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fpEP7eH7p6PGUrXCwQfHrJq9V0cB5XCkjVODkwSfBbU=;
        b=SMA9X+dCPTflnATPUcQg8cvkZVQYL2hswU0h99lNvBecT5X/h5wxPLRPFz8glulqz/cAao
        VLLOXi21vDbIQR1IuOYseQ4al3dj6ekYTbqEme0a59uwy3gXL1Vors+phxsDG74ByvaCWP
        rr0HHeXvztPxt8ExGXgtMNpw0uRN9Dw=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-524--GDi8RrzNTa02u70itoF-A-1; Wed, 06 Sep 2023 08:24:51 -0400
X-MC-Unique: -GDi8RrzNTa02u70itoF-A-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9a5944adecbso266248366b.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 05:24:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694003090; x=1694607890;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fpEP7eH7p6PGUrXCwQfHrJq9V0cB5XCkjVODkwSfBbU=;
        b=d4IlqydhA64DilQOIOE6/2GnzS2cMW3bGenzHHmzVpI8RLNacqw0tbT058jpmvxGkF
         pToUA++270SLF4OXRpQr99hTQW2awxLkU0/tE7R+ZCQi12H11qseRdwori/8ROjSFis6
         r1evJg6KKpvwlGpXf36xviuGgriS6bFpR1mpX3/alrkVEl5DxG5hhw2ZBGFroUoG7Nwo
         rrOBhE6CC69MfoTqajkA3qtrlU4K96BcId/VV+ijRqj8Pa6VG3FhMpOEeSh2dUjiWbYt
         FI07GYZAwgUm4EEp6pDkm+4wq4KLCPpIn72KYTqPz1OEXV4xjGGYG2GFv7rmQYmZmFgt
         T93g==
X-Gm-Message-State: AOJu0YzRfmRVudz+t1xdJo00kHE8wjPf/0lbrBbC+aFNvTTyyJdqzHOZ
        NlP02chInSzf2mJX639G/bMRwE3w+GoLBc/6AnWYPIfLf2i79R6yY/vZFU5mUHLcVt71P5FvE+/
        qUS80H3vTcHB840I0Uc7XJNmYrcwsJMoJ
X-Received: by 2002:a17:906:31c9:b0:99d:e617:abeb with SMTP id f9-20020a17090631c900b0099de617abebmr1998999ejf.23.1694003089778;
        Wed, 06 Sep 2023 05:24:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8McvsYPtH8mp1unsy6hlf5lpannjZACIlzzfb/Y+VPmof8anNrPDD73gRo/spHjYrPL7AqA==
X-Received: by 2002:a17:906:31c9:b0:99d:e617:abeb with SMTP id f9-20020a17090631c900b0099de617abebmr1998975ejf.23.1694003089423;
        Wed, 06 Sep 2023 05:24:49 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id lt20-20020a170906fa9400b009a193a5acffsm8834912ejb.121.2023.09.06.05.24.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Sep 2023 05:24:48 -0700 (PDT)
Message-ID: <fbd1369e-1738-3346-19ad-e291da491f12@redhat.com>
Date:   Wed, 6 Sep 2023 14:24:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v16 0/3] Avoid PCIe D3 for AMD PCIe root ports
Content-Language: en-US, nl
To:     Mario Limonciello <mario.limonciello@amd.com>, bhelgaas@google.com,
        rafael@kernel.org, Shyam-sundar.S-k@amd.com
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
References: <20230829171212.156688-1-mario.limonciello@amd.com>
 <6ce36e6e-726a-69f3-882c-0790d311eee1@redhat.com>
 <4c80cda2-82e4-4eb3-99c5-f2be3bfa96ed@amd.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <4c80cda2-82e4-4eb3-99c5-f2be3bfa96ed@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mario,

On 9/5/23 14:45, Mario Limonciello wrote:
> On 9/5/2023 05:13, Hans de Goede wrote:
>> Hi Mario,
>>
>> On 8/29/23 19:12, Mario Limonciello wrote:
>>> D3 on PCIe root ports isn't used on Windows systems in Modern Standby.
>>> This series adjusts the amd-pmc driver to choose the same strategy
>>> for Rembrandt and Phoenix platforms in Linux with s2idle.
>>>
>>> LPS0 constraints are the basis for it; which if they are added for
>>> Windows would also apply for Linux as well.
>>>
>>> This version doesn't incorporate a callback, as it's pending feedback
>>> from Bjorn if that approach is amenable.
>>>
>>> NOTE:
>>> This series relies upon changes that are both in linux-pm.git and
>>> platform-x86.git. So it won't be able to apply to either maintainer's
>>> tree until later.
>>>
>>> Mario Limonciello (3):
>>>    ACPI: x86: s2idle: Export symbol for fetching constraints for module
>>>      use
>>>    platform/x86/amd: pmc: Adjust workarounds to be part of a switch/case
>>>    platform/x86/amd: pmc: Don't let PCIe root ports go into D3
>>
>> Thank you for the new version.
>>
>> I understand you wanted to get this new approach "out there" but
>> this does not address my remarks on v15:
>>
>> https://lore.kernel.org/platform-driver-x86/53d26a63-64f3-e736-99f5-32bf4b5ba31d@redhat.com/
>>
> 
> Right; I called out in the cover letter this is pending feedback from Bjorn.
> 
>> Bjorn, I suggest to allow platform code to register a callback
>> to influence pci_bridge_d3_possible() results there. Can you
>> take a look at this and let us know what you think of this
>> suggestion ?
>>
>> Looking at this problem again and rereading the commit message
>> of "platform/x86/amd: pmc: Don't let PCIe root ports go into D3"
>>
>> I see that the problem is that the PCIe root ports to which
>> the USB controllers connect should not be allowed to go
>> into D3 when an USB child of them is configured to wakeup
>> the system.
>>
>> It seems to me that given that problem description,
>> we should not be directly messing with the bridge_d3
>> setting at all.
>>
>> Instead the XHCI code should have an AMD specific quirk
>> where it either unconditionally calls pci_d3cold_disable()
>> on the XHCI PCIe device; or it could even try to be smart
>> and call pci_d3cold_enable() / pci_d3cold_disable()
>> from its (runtime)suspend handler depending on if any
>> USB child is configured as a system wakeup source.
>>
>> Note that it is safe to repeatedly call pci_d3cold_enable()
>> / _disable() there is no need to balance the calls.
>>
> 
> It's only the PCIe root port that is used for XHCI tunneling that has this issue.  This specific problem is NOT for the root port of "any" AMD XHCI controllers.  There is no problem with any of the XHCI controllers
> going into D3hot.

"XHCI tunneling" is an unfamiliar term for me. Are we talking about a XHCI controller inside a USB4/thunderbold dock here which is connected to the laptop over PCIe tunneling over thunderbolt ?

Or do you mean the XHCI controller inside the laptop which is connected to a USB4/thunderbolt capable Type-C port which is used when that port is in USB3/USB2 mode ?

As long as the XHCI controller is inside the laptop (and not in the dock), presumably you can identify it by say a set of PCI device-ids of the "tunneling" XHCI controllers on affected AMD platforms. So you could then still call pci_d3cold_disable() from the XHCI driver on only those controllers.

Note I'm not saying this is the best solution. I'm just trying to understand what you mean with " the PCIe root port that is used for XHCI tunneling" .

I also see that Rafael has said elsewhere in the thread that he needs to think a bit about how to best handle this ...

Regards,

Hans

