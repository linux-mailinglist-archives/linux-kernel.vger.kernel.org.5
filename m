Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 986307DDF9D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 11:42:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbjKAKm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 06:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjKAKm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 06:42:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3715118
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 03:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698835300;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NE33NF3mXCJn7/JgALO/3kltwy3JmlInth66aTdiYDo=;
        b=G4L8XWL4a9uhZep0T+A88UH6DaPdZ+f5mQpvzDP+bq0u1i7d6/BgODTU+Eqd67S5Ad5LrZ
        J4wppjZpwsJjfwQF1KdigNrmaRQwqeNuvBxIwydYx64B5ZwUT5hYvE15PlbWkS0NjyPdeE
        m6AVKBwX5KGjC2HZ/BZR/bpxISBgX78=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-387-OM_pIKHuOI-URhSkDtOw4g-1; Wed, 01 Nov 2023 06:41:39 -0400
X-MC-Unique: OM_pIKHuOI-URhSkDtOw4g-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9ae7663e604so454892566b.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 03:41:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698835298; x=1699440098;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NE33NF3mXCJn7/JgALO/3kltwy3JmlInth66aTdiYDo=;
        b=kKxuuLexz0U5ZhGLr3/2Z+AtJG5/JWnUQpjr7CdhpzXWeWmS4N9aJp2t8KiQUz0Qiq
         BoGrvyPLtVf4Fpb5hSp8kBtcHhEW5RCzMn7dIT066o9yhgJm4ZBzJphA0WjLInqwa5R3
         JknmaxWqlpnaY7x2M1ceQva6odHQnInn5LfHLSkS3HRbxSPnbZtpZDDz8vt5H4+yQK8X
         xghBw/x4jFDdAep33N1DOxF0jSdxnN+VPVBzx0tUgiEQjnF7mfDsX3rYB7PFltX8+utG
         45mHrqGfuPb3+egKqTWV0jjj2ieybl9XnpNYlW0YKOfIMYyLv5LVNaSiO+a39S849ZhH
         0QdA==
X-Gm-Message-State: AOJu0YzQjdbxJEy/mvZb1t4GAsL7KZSPWWkZZI0f42NyTs1meGwI/LoB
        U/AWoOCDQqy4FogpWxqMJkWjARTVegxcBE7ojHGpURqyw7H2K0T38DP8rWIQ2Jf/2JNXu2TvlcU
        AZpglZElPrO39Le5lZnhfxsJ9
X-Received: by 2002:a17:907:7ea5:b0:9ad:9225:ced2 with SMTP id qb37-20020a1709077ea500b009ad9225ced2mr1588450ejc.62.1698835298050;
        Wed, 01 Nov 2023 03:41:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEFbqHZnTFZ45AIMOkgDWx9bV7cNKgKd2vkdeGZdJmfKi6wK2TpEIMVD7N0w3VLFJkt/1i1g==
X-Received: by 2002:a17:907:7ea5:b0:9ad:9225:ced2 with SMTP id qb37-20020a1709077ea500b009ad9225ced2mr1588432ejc.62.1698835297742;
        Wed, 01 Nov 2023 03:41:37 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id um17-20020a170906cf9100b009d0be9be6e2sm2222995ejb.43.2023.11.01.03.41.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Nov 2023 03:41:37 -0700 (PDT)
Message-ID: <c097e11b-8cec-1b04-141a-c8713bf56461@redhat.com>
Date:   Wed, 1 Nov 2023 11:41:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/1] Revert "media: imx290: Convert to new CCI register
 access helpers"
Content-Language: en-US, nl
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Alain Volmat <alain.volmat@foss.st.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231101100900.224567-1-alexander.stein@ew.tq-group.com>
 <ZUIpEJmmdGTFdx09@kekkonen.localdomain>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <ZUIpEJmmdGTFdx09@kekkonen.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/1/23 11:31, Sakari Ailus wrote:
> Hi Alexander,
> 
> On Wed, Nov 01, 2023 at 11:09:00AM +0100, Alexander Stein wrote:
>> cci_write() unconditionally writes multi-byte data in big-endian format.
>> But IMX290 and IMX327 use little-endian format for multi-byte registers.
>> Revert the CCI usage until little-endian is supported by CCI register
>> access helpers.
>> This reverts commit af73323b97702e53b0a336972aaf23e7dd92c850.
>>
>> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
>> ---
>> The difference is subtile, but imx290_write() uses put_unaligned_le24(),
>> while cci_write() uses put_unaligned_be24().
>>
>> I assume this should go into stable as well. How to deal with that?
>> Shall a revert get the fixes tag as well?
> 
> I'd very much prefer addressing this in v4l2-cci instead. It should also be
> a much smaller patch (or patches).

I was under the impression the v4l2-cci conversion was already
reverted because this breakage has been known for a while now.

Anyways, if someone wants to fix this directly this has been
discussed in this thread:

https://lore.kernel.org/linux-media/20231030173637.GA2977515@gnbcxd0016.gnb.st.com/

and the consensus is that the best way to fix this is to
add CCI_REG16_LE(x) CCI_REG24_LE(x), etc. macros to
mirror the existing CCI_REG16(x), etc. macros.

The _LE macros would then look something like this:

#define CCI_REG_LE		BIT(20)

#define CCI_REG16_LE(x)                (CCI_REG_LE | (2 << CCI_REG_WIDTH_SHIFT) | (x))

etc.

And then the get_unaligned_beXX() and put_unaligned_beXX()
calls in drivers/media/v4l2-core/v4l2-cci.c would need
to be made conditional on a check for the CCI_REG_LE flag
and if that flag is set use the _le_ versions of those
functions instead.

The reason to go this way instead of a global LE flag
somewhere is that some sensors have mixed endianness
for different registers, so encoding this in the
register-address high bits is the best solution.

Alexander, perhaps you can prepare 2 patches:

1. Adding the discussed CCI_REGXX_LE(x) macros to v4l2-cci
described above.

2. Patch the imx290 code to use the _LE versions for the
registers which are 2 or more bytes wide.

?

Note I know that Alain (added to the Cc) from the thread
linked above is also looking into implementing 1. 

Regards,

Hans





