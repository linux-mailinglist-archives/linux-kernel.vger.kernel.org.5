Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9912779CAC6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 10:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233106AbjILI7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 04:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233146AbjILI7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 04:59:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 67085E79
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 01:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694509110;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Et4XrSW8efLvThc1V89jDZFB/myxZezLXAdDv36HbvY=;
        b=Vc5Sbm3TPiwZkCXKy5DfnS7iZk6zmm6Hl1UI3EpLPfOgcXE9wWYxnQSMER1CIMEtLNG0AI
        4zjQDHoe8vWGqYGFYvBObnkHs2iNqT5E/+Bbw9vOitoWkf4DGE8RJgyrUjzJRLiEESf1/w
        xcLN7vNnBoN+j1MsI9jTwq2teDoFpSE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-rsMG-IYpNnGnu56AGTA_Rw-1; Tue, 12 Sep 2023 04:58:29 -0400
X-MC-Unique: rsMG-IYpNnGnu56AGTA_Rw-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-99388334de6so354648766b.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 01:58:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694509108; x=1695113908;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Et4XrSW8efLvThc1V89jDZFB/myxZezLXAdDv36HbvY=;
        b=kUZsvCukW/1yiFazLQdkANykG0hFU6cy9YeVSJIok3vxtz7hUQY2sh7Ug+Qx8AdCzx
         ia+Zd1/+Qz8qCuKgpLgfWJxjpRg/HWA5O6u76pAwjD5AFi2hX6F+raRkMXUDvzh7qD7y
         NaPm4IlonQYO0knup5sal8jc+sloe9j+pK98VQUjnm5cbhU7LTSAIPRa+jDRK89tAQKm
         XQtrE0lijk/PHu0W/oLY4BCAtn64QbGgZ28ilO4SeTVvrE2tGPnsbVyY5wtAQwvwg14G
         1p4DDqgv+G80YPIsdvm6+kdzHcscbmviIN1Mv25TovVl97XHWuArxKcbhca44ZJjvcCp
         2xUA==
X-Gm-Message-State: AOJu0Yw3zGxVqRVe3nUw1mGWlW+yIV4VF5hvnpyNd+uiZHpxv7IpMFnv
        JYUCQGvpg6ypJfplb17f5gbW4tdZI8vGssgQzvRL4ob8D9RvLE/1bCJ4M4oIuerA3LlB5DJ06Qr
        uqBux3ompibMZvMqBVc2dxIfD
X-Received: by 2002:a17:907:2c59:b0:9a1:af6f:e375 with SMTP id hf25-20020a1709072c5900b009a1af6fe375mr9077125ejc.35.1694509108239;
        Tue, 12 Sep 2023 01:58:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFGcKLf77LasWyQfqqzucp8Wj0iTzjDeVCvR4PK9N9Sl0R5dh6jR9ZhKvk/teVxGmkfyYmNg==
X-Received: by 2002:a17:907:2c59:b0:9a1:af6f:e375 with SMTP id hf25-20020a1709072c5900b009a1af6fe375mr9077114ejc.35.1694509107930;
        Tue, 12 Sep 2023 01:58:27 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id gs9-20020a170906f18900b0099bd5d28dc4sm6585633ejb.195.2023.09.12.01.58.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 01:58:27 -0700 (PDT)
Message-ID: <4246946d-40e3-7df7-3fc4-9aa10e1dee10@redhat.com>
Date:   Tue, 12 Sep 2023 10:58:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 3/3] pinctrl: amd: Add a quirk for Lenovo Ideapad 5
Content-Language: en-US, nl
To:     Linus Walleij <linus.walleij@linaro.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Cc:     Shyam-sundar.S-k@amd.com, Basavaraj.Natikar@amd.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        regressions@lists.linux.dev, lucapgl2001@gmail.com
References: <20230829165627.156542-1-mario.limonciello@amd.com>
 <20230829165627.156542-4-mario.limonciello@amd.com>
 <1d891d34-053a-368d-cf47-bcaf35284c79@redhat.com>
 <07353676-bad0-44f8-a15a-4877f1898b6b@amd.com>
 <811225f8-c505-7344-ac18-882472ee0348@redhat.com>
 <d232c11d-901f-4ebc-b408-bed042ed8da9@amd.com>
 <6734c409-89f1-89a1-3096-4054be29faf1@redhat.com>
 <f0ceff1c-ba5f-4c6b-ac0e-c4195f477500@amd.com>
 <CACRpkdYGxreyD8NVuKs2G44htR8EixdvGr3+ma=HrxHUP3NDQg@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CACRpkdYGxreyD8NVuKs2G44htR8EixdvGr3+ma=HrxHUP3NDQg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/12/23 09:08, Linus Walleij wrote:
> On Thu, Aug 31, 2023 at 7:53 PM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
> 
>> Linus - please disregard version 1.
> 
> OK!
> 
>> I provided Luca a new series that implements this approach that Hans and
>> I discussed and they confirmed it works.
>>
>> I have some minor modifications to it to narrow where it's applied so we
>> don't have needless notifications and will send it for review after the
>> new modifications are tested as well.
> 
> OK standing by, I'll wait for Hans' ACK and then merge it for fixes.

AFAICT Mario has not posted a new version (yet),
so there is nothing for me to ack (yet).

Regards,

Hans


