Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21DBA7B7CAA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 11:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241216AbjJDJ4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 05:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232913AbjJDJ4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 05:56:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C66983
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 02:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696413344;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4X/b1d2pkgLp5p3YIRE7ps+4IziH+AFeELkbhS8aDOo=;
        b=MxIr6mw9gN6TIoYBKBvj6sIwR5WWI7LpGlVEZhf+BZ15YY0Hye3bzoDOXGRdDjp7b6IZa6
        Yd9Gt6wUPpMjHnkTFhbJpP53PwGpTVRUpGyhTYS6IKE7wijGGHyt8H9uIuayFj/BD/OMG0
        J247eErfF5/FnSH9npV1KlmS7oIi8yc=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-bhGxFOv3MOeDxXEaF3WtXQ-1; Wed, 04 Oct 2023 05:55:42 -0400
X-MC-Unique: bhGxFOv3MOeDxXEaF3WtXQ-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9b274cc9636so173334166b.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 02:55:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696413341; x=1697018141;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4X/b1d2pkgLp5p3YIRE7ps+4IziH+AFeELkbhS8aDOo=;
        b=fhd47/15o8huhu+JjFf+KgfWwkF+eOIIWtPgksgu1y0UY2Jfpk5xgNN3Td5s+YApWS
         UxNAWyvWH+o2IAJZocPMUDYjUrFX7gIqwQdJ7MqFXBC2Dez4bB9p6XjjG4IcS1MUJGem
         EUPf0ybPlNMEcxFf3J5IKtU2z9PFYeiEXeM8PgHDPAx9Ju/SyroLSZPB/D1/r+i8+0A6
         S5q1AvUAEapNJw4qhA6GOUeG20yd7QkohvMqTwUEwZ/vf0D0iLY0gAAhFU+j0Z1wQtL5
         6+iv5/Mvxr6bftkR79exwJQESqkMLIsP4FCM6Jp5o2xv/3T9uOCTluHi9utHKnENoPf+
         MtfA==
X-Gm-Message-State: AOJu0YxZ8m9N9QNaRwCoxA5/bwBJLhhIcMdr2hgqLy2suhV7tZygO7b6
        Ulz0vm+fGdzA9IecUQPeB2gG1bdvkVTo/8ECVMLQYfwStKsh56tmd5wbKbrBX0ur3igzxhknlDd
        0I1uL5Q6S99Su6784bZo6LLB1
X-Received: by 2002:a17:906:3282:b0:9a5:846d:d81f with SMTP id 2-20020a170906328200b009a5846dd81fmr1434587ejw.17.1696413340902;
        Wed, 04 Oct 2023 02:55:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4NJH4WV0usT3nmC3sZlXOvlzpHK2MaHCMZaLc9JRwL4fNL5dxmTSxCV4ADpMGmpxFMMnJpw==
X-Received: by 2002:a17:906:3282:b0:9a5:846d:d81f with SMTP id 2-20020a170906328200b009a5846dd81fmr1434578ejw.17.1696413340630;
        Wed, 04 Oct 2023 02:55:40 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id i7-20020a1709063c4700b0098884f86e41sm2494828ejg.123.2023.10.04.02.55.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Oct 2023 02:55:40 -0700 (PDT)
Message-ID: <52413aa9-054a-d0db-e240-bdddd31f3d79@redhat.com>
Date:   Wed, 4 Oct 2023 11:55:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 0/2] platform/x86: Fix reference leaks
Content-Language: en-US, nl
To:     Armin Wolf <W_Armin@gmx.de>, markpearson@lenovo.com,
        jorge.lopez2@hp.com
Cc:     markgross@kernel.org, ilpo.jarvinen@linux.intel.com,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230925142819.74525-1-W_Armin@gmx.de>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230925142819.74525-1-W_Armin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/25/23 16:28, Armin Wolf wrote:
> If a duplicate attribute is found using kset_find_obj(), a reference
> to that attribute is returned which needs to be disposed accordingly
> using kobject_put(). This issue likely first appeared inside the
> dell-wmi-sysman driver, see
> commit 7295a996fdab ("platform/x86: dell-sysman: Fix reference leak").
> However, it also seems that the bug was copied from this driver into
> the think-lmi and hp-bioscfg drivers. Maybe a more abstract
> fw_attr_class could prevent such issues in the future by abstracting
> away the kobject handling?
> 
> Armin Wolf (2):
>   platform/x86: think-lmi: Fix reference leak
>   platform/x86: hp-bioscfg: Fix reference leak

Thank you for your patch/series, I've applied this patch
(series) to the pdx86 fixes branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=fixes

Note it will show up in the pdx86 fixes branch once I've pushed
my local branch there, which might take a while.

I will include this patch in my next fixes pull-req to Linus
for the current kernel development cycle.

Regards,

Hans




>  drivers/platform/x86/hp/hp-bioscfg/bioscfg.c | 14 ++++++++----
>  drivers/platform/x86/think-lmi.c             | 24 ++++++++++++++++----
>  2 files changed, 30 insertions(+), 8 deletions(-)
> 
> --
> 2.39.2
> 

