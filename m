Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55D08770FD5
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 15:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjHENKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 09:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjHENKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 09:10:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91DDE70
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 06:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691240970;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ehu/P9kMK+ANcrbIAM1h/zk8lNfm0lCws3biHgn8nz4=;
        b=YsNCM6soVxYKMXibxmzXf6bCkonHan+hBURh3d1XWeq9f6wnXWPaBRkjGqz7+G4RNgGCqR
        KZvbVlXsoldiZ/9ls7CB0WTAzMH9jSECw2iQfMqnt8Bkf3j/xx7PoP1Cy6QmBaljTiv9ui
        99GdzjF1OxqH9RgtlZbMNhT/7amT9R8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-46-6NYsgVR0MjeTQwWx-ojBsg-1; Sat, 05 Aug 2023 09:09:28 -0400
X-MC-Unique: 6NYsgVR0MjeTQwWx-ojBsg-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-99bc8f1290eso196341566b.3
        for <linux-kernel@vger.kernel.org>; Sat, 05 Aug 2023 06:09:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691240967; x=1691845767;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ehu/P9kMK+ANcrbIAM1h/zk8lNfm0lCws3biHgn8nz4=;
        b=IKwJNHmiwVAKQQwOy3VE9xfjP8HNoCpLpSSLrUoeNVt7KuC85H0JCp5AkO1z6FsXJ8
         wtaCF7LtFeIVTVllLsgo8is5RRAb3xOS13ZYEOgUyrAHeSkeV/Ye17fmxff4zWTPU3bj
         dRxkWUGNA4AQ1eam6xNX3a5wz7FPXW7tP8+eMDIY/5hZfN5ce29UXDUbYSG3if7MLKbP
         psZJZ+Miz7Xqjb9rWPVpjIyCh6vtK0+Qw5eTXBZlqsmGka3fsZJqoosoB1Ug1YZ0cmMa
         U4YPbywOhdANkZwE8UfVSbUMvtWmU9lpVhuqezSpHYvIZ2UQmiETbAodVT1A3qdn3hmW
         dOJA==
X-Gm-Message-State: AOJu0Yw19INitrc8RE5ttIJZZMxeMS35y9f2k9beJDiK8fU+bhVgPXUU
        KbEtqDpInSt0mn25ub8lLW7m+z7kRrc/fFhUDBmRc4H+ptN0yaOJeI0zbqvs5Ce/OsL05TnvI/3
        V2UixTke4t4NPvBpNYuGsSAzeNJoKNdhu
X-Received: by 2002:a17:906:cc0f:b0:99b:f03d:de37 with SMTP id ml15-20020a170906cc0f00b0099bf03dde37mr3201769ejb.60.1691240966971;
        Sat, 05 Aug 2023 06:09:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxTUJ6UfA+ygtRAtwWtx1Jz30S537FK+47etHoPWUHMHvqfERQhu5bImDIb6Ym41ie3dNhlA==
X-Received: by 2002:a17:906:cc0f:b0:99b:f03d:de37 with SMTP id ml15-20020a170906cc0f00b0099bf03dde37mr3201754ejb.60.1691240966704;
        Sat, 05 Aug 2023 06:09:26 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id kg12-20020a17090776ec00b0098951bb4dc3sm2666439ejc.184.2023.08.05.06.09.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Aug 2023 06:09:25 -0700 (PDT)
Message-ID: <cc9e37b4-b5cb-fd4d-84b8-5b824afe710a@redhat.com>
Date:   Sat, 5 Aug 2023 15:09:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: Fwd: 6.5 - 6.4.7 Regression : ASUS UM5302TA Keyboard don't work
To:     August Wikerfors <git@augustwikerfors.se>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        Linux Input Devices <linux-input@vger.kernel.org>,
        ACPI Asus <acpi4asus-user@lists.sourceforge.net>,
        Linux x86 Platform Drivers 
        <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Corentin Chary <corentin.chary@gmail.com>,
        Guilhem Lettron <guilhem@lettron.fr>
References: <bdc6cb4d-a853-72b2-b132-989b64740ad9@gmail.com>
 <8ee87fe1-684f-ad59-21c7-4401a4e70bee@leemhuis.info>
 <b7df9a02-3b81-4f8c-aeba-222c298180d4@augustwikerfors.se>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <b7df9a02-3b81-4f8c-aeba-222c298180d4@augustwikerfors.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/4/23 17:26, August Wikerfors wrote:
> On 2023-07-30 06:49, Linux regression tracking (Thorsten Leemhuis) wrote:
>> Lo!
>>
>> On 30.07.23 04:41, Bagas Sanjaya wrote:
>>>
>>> I notice a regression report on Bugzilla [1]. Quoting from it:
>>>
>>>> On a kernel 6.4.5 and less, the keyboard is working fine.
>>>>
>>>> Beginning with 6.5 rc1 and 6.4.7 any key don't respond.
>>
>> That is a AMD Ryzen Laptop. And if that really started from
>> v6.4.6..v6.4.7 then I guess there is a decent chance that this is caused
>> by ```ACPI: resource: Remove "Zen" specific match and quirks``` from
>> Mario. Hence adding him to the list of recipients.
> 
> Confirmed now, see https://bugzilla.kernel.org/show_bug.cgi?id=217726#c9
> 
> #regzbot introduced: a9c4a912b7dc7ff922d4b9261160c001558f9755

We just have received 2 bug reports for Fedora which I believe are also
this issue (not confirmed yet):

https://bugzilla.redhat.com/show_bug.cgi?id=2229165
https://bugzilla.redhat.com/show_bug.cgi?id=2229317

I'm going to create a Fedora 6.4.y test-kernel with a9c4a912b7dc7ff
reverted.

IMHO we really should revert a9c4a912b7dc7ff upstream,
at least for the 6.4.y series where it seems to be doing
more harm then good.

And propably also for 6.5-rc# for now until we figure out
a better solution.

Regards,

Hans


