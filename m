Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85FE079EF6B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 18:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjIMQyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 12:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjIMQyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 12:54:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 51280B7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 09:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694624031;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EUAQM9nUVDpynXNTWZkPqYipd38tYN+dKS0WVUg2qcc=;
        b=VeTPCGHIsqZjnHz3UFDpzjbRcws5NXTSViA4/I4m8kj97VyeBZVmtnIhQ4n0pYGJPlerlD
        lsngGchpti5dYDlomb1y/Yzx+pHLqYd2trsF89m7BuAsEd5rqqngJ0hOnniQhipiW8UycQ
        Q9P70EydHuY6c8dJJOD1rjGMhI/SX9Q=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-Z7u4_OUeM9G3zYzju-YFOA-1; Wed, 13 Sep 2023 12:53:50 -0400
X-MC-Unique: Z7u4_OUeM9G3zYzju-YFOA-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-5009f4c933cso7543597e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 09:53:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694624028; x=1695228828;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EUAQM9nUVDpynXNTWZkPqYipd38tYN+dKS0WVUg2qcc=;
        b=CynT6LunMbxRGlwAa3LYMfphPojnTrMMRdKXARX1Ar8Cis68/6ceb9CFvOgWWDOP19
         PPxhyAAupNj33bIh2lZcu74lpXT/r4Eo0c9cUGkSQfDAN65//+0+d35/miCjB6ZP8FAp
         tzrgUTiJwOgGS7Z7N/Rh2nQR0IFMrlOKoz188DYBKfpRloL7kYEIRJfgpiJYLbLk2zRE
         e6yR9OREkQHw3390IkAUHRvKM13ohrIiwbVi91Z78ZTjxs95V5Rn7e0hwLqS55xMO0ob
         RNstQrHXWtvvvc4cp3Q0rm7W+dFsEvH7XHj7x7EbWfkEESExkefrHGZ06AH6uA5BKMhE
         TN1w==
X-Gm-Message-State: AOJu0YxBbouj7L+HIly3tkKykEBodBSGlHI88UbUNwOR+DeopoWQ93RT
        2zalmXGOEp9kKyMQa5IfuQ0skibtYb9Wvx6wHvxjefTlQDxcXqkxRYIu1rbmgLfBwgwar7pkc3j
        JqCCsGP7Sc2vskXiec7tBaI8Y
X-Received: by 2002:a05:6512:3050:b0:4fe:49d:6ae2 with SMTP id b16-20020a056512305000b004fe049d6ae2mr3681520lfb.0.1694624028524;
        Wed, 13 Sep 2023 09:53:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGp8B1gEI/3ZQ9C3N8IdbLVsl6t5HP7MRJGoKh3mgc6mi3ZCeY0JqdjSTaCUnx7fBbgv42XOQ==
X-Received: by 2002:a05:6512:3050:b0:4fe:49d:6ae2 with SMTP id b16-20020a056512305000b004fe049d6ae2mr3681506lfb.0.1694624028147;
        Wed, 13 Sep 2023 09:53:48 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id sb5-20020a170906edc500b0099bc0daf3d7sm8758990ejb.182.2023.09.13.09.53.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 09:53:47 -0700 (PDT)
Message-ID: <50da04e3-5e12-89d3-e3ad-f2ff4533a615@redhat.com>
Date:   Wed, 13 Sep 2023 18:53:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] platform/x86: thinkpad_acpi: sysfs interface to auxmac
To:     Mark Pearson <mpearson-lenovo@squebb.ca>,
        Fernando Eckhardt Valle <fevalle@ipt.br>,
        Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        "markgross@kernel.org" <markgross@kernel.org>,
        ibm-acpi-devel@lists.sourceforge.net,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>, linux-kernel@vger.kernel.org
References: <20230906195204.4478-1-fevalle@ipt.br>
 <d26d4b15-765b-a444-b740-97f95f2db58d@redhat.com>
 <c05afb18-bca5-4500-877d-d44ef3abc310@app.fastmail.com>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <c05afb18-bca5-4500-877d-d44ef3abc310@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark, Fernando,

On 9/13/23 18:41, Mark Pearson wrote:
> 
> 
> On Wed, Sep 13, 2023, at 11:58 AM, Hans de Goede wrote:
>> Hi Fernando,
>>
>> On 9/6/23 21:52, Fernando Eckhardt Valle wrote:
>>> Newer Thinkpads have a feature called Mac Address Passthrough.
>>> This patch provides a sysfs interface that userspace can use
>>> to get this auxiliary mac address.
>>>
>>> Signed-off-by: Fernando Eckhardt Valle <fevalle@ipt.br>
>>
>> Thank you for your patch. 
>>
>> At a minimum for this patch to be accepted you will need
>> to document the new sysfs interface in:
>>
>> Documentation/admin-guide/laptops/thinkpad-acpi.rst
>>
>> But I wonder if we should export this information to
>> userspace in this way ?
>>
>> The reason why I'm wondering is because mac-address passthrough
>> in case of using e.g. Lenovo Thunderbolt docks is already
>> supported by the kernel by code for this in drivers/net/usb/r8152.c :
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/usb/r8152.c#n1613
>>
>> So I'm wondering if we really need this, is there a planned
>> userspace API consumer of the new sysfs interface ?
>>
>> Or is this only intended as a way for a user to query this, iow
>> is this purely intended for informational purposes ?
>>
> Hi Hans,
> 
> We've previously had strong pushback from the maintainers in the net tree that the MAC passthru should not be done there and should be done in user-space. I'd have to dig up the threads, but there was a preference for it to not be done in the kernel (and some frustrations at having vendor specific changes in the net driver).
> 
> We've also seen various timing issues (some related to ME FW doing it's thing) that makes it tricky to handle in the kernel - with added delays being needed leading to patches that can't be accepted.
> 
> This approach is one of the steps towards fixing this. Fernando did discuss and review this with me beforehand (apologies - I meant to add a note saying I'd been involved). If you think there is a better approach please let us know, but we figured as this is a Lenovo specific thing it made sense to have it here in thinkpad_acpi.
> 
> There will be a consumer (I think it's a script and udev rule) to update the MAC if a passthru-MAC address is provided via the BIOS. This will be open-source, but we haven't really figured out how to release it yet.
> 
> Fernando - please correct anything I've gotten wrong!

Ah that is all good to know. That pretty much takes care of
my objections / answers my questions.

Fernando can you please submit a v2 which:

1. Adds documentation as mentioned already
2. Moves the special handling of "XXXXXXXXXXXX" from show()
   to init() (writing to auxmac[] in show() is a bit weird,
   also we only need to do this once, so it is init code)

Regards,

Hans

