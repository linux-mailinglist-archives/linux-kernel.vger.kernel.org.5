Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA7E08057C7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 15:49:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232270AbjLEOm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 09:42:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232141AbjLEOmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 09:42:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 571E0183
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 06:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701787381;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VYD0X3rZjwpNcX0tntI2wIO2stB+eIozlFrReCKadJ0=;
        b=B4cX3LgGd8FZA6W5Z7u/JO19cQJIJQZIlomXMpgToA4eD3M7EFMGemZIg8K3nraF/PcJVP
        2Xsjmib2iVN7EgmskYpTcVDC+t8Byrp0axcl8uz4SM4akGdU/L+X+S2SgR+NDyyf2szMnF
        X2D8Jdy8oIerolbjrC3uig4VRskIqvA=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-tlusCb-VONuv5OpnNCP1XQ-1; Tue, 05 Dec 2023 09:42:58 -0500
X-MC-Unique: tlusCb-VONuv5OpnNCP1XQ-1
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-58794776af4so7993169eaf.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 06:42:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701787378; x=1702392178;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VYD0X3rZjwpNcX0tntI2wIO2stB+eIozlFrReCKadJ0=;
        b=c+S/vjmJ74xQJ9T8c9dMbGK7lRoVhJ7eq8tOa//TF7BmT/pX0jhIgD8eZdBQwGO374
         I0Qk6eIwuUuYunhxQE5rSZtXyvBM9Mbbq2G0hMs1hBVmgl2XrfQzJ7tnOrIHaYBoyWO9
         4Brcul+RNIHDBchqoFlzxLUvdeEeTnL/jvRK9emK9JCO27iwVBTdw5DGHCecKP8huU1G
         96Ck3sOpLFDLTyuIjQCUqigx/cUVvUUO14Bh5pEBg56tgw1zTe9dRgYAKXb4YkSERqxa
         x4cdma2Ezc/B070fKRnOuhMehOorgWCj2XfkNMfGwoQE4s/yVO0BZdOIM21A4XvwdHld
         65rQ==
X-Gm-Message-State: AOJu0YzCtL4Pj48Q32LrSqqXIPZe6Gn+yGiBWZr40b0Y0CgzTu6BHmlt
        cg2UGTZiow5Zr77A3IVTQIcwT38aQ5A8LWqE0L/UXeWopiPCQmL1GWRVslqumGKOWsB99/P/nC3
        RBKwwbaJUk0huzFyqBcJPBaHH
X-Received: by 2002:a05:6820:1623:b0:58d:9e35:aa01 with SMTP id bb35-20020a056820162300b0058d9e35aa01mr5371110oob.3.1701787377922;
        Tue, 05 Dec 2023 06:42:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHBHHg6NoZv9mMdXT1Vy8JkTAhVr4Tf9B3BabZKgCRGd05NVkUVu36IPh2i2Hf6nWLHeTXNSw==
X-Received: by 2002:a05:6820:1623:b0:58d:9e35:aa01 with SMTP id bb35-20020a056820162300b0058d9e35aa01mr5371101oob.3.1701787377598;
        Tue, 05 Dec 2023 06:42:57 -0800 (PST)
Received: from [10.16.200.42] (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id r66-20020a4a4e45000000b0058d8325fc60sm2377796ooa.0.2023.12.05.06.42.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 06:42:57 -0800 (PST)
Message-ID: <7dd6f44c-0f4b-4127-83fc-a8cf7e6314c1@redhat.com>
Date:   Tue, 5 Dec 2023 09:42:55 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] watchdog: Provide a better stop error message
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        David Arcari <darcari@redhat.com>,
        linux-watchdog@vger.kernel.org
References: <20231205140926.397956-1-prarit@redhat.com>
 <856c571a-41be-4e5e-9bde-72a192b14801@roeck-us.net>
From:   Prarit Bhargava <prarit@redhat.com>
In-Reply-To: <856c571a-41be-4e5e-9bde-72a192b14801@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/5/23 09:32, Guenter Roeck wrote:
> On 12/5/23 06:09, Prarit Bhargava wrote:
>> Provide a better stop error message for the case where the watchdog does
>> not stop.
>>
> 
> Please, no such patches. We are busy enough as is, and we don't need
> people to change log messages they don't like.
> 

It is impossible to tell what actually happened without the additional 
information (specifically the current thread).  That's not a "don't 
like" as much as it is a "provide better debug output".

P.

> Guenter
> 

