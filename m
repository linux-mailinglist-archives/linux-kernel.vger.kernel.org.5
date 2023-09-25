Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 848487AD3F3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 10:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233142AbjIYI66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 04:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233081AbjIYI6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 04:58:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7BF6D3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 01:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695632280;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9jYoDjvuIiF2NPGNNFR7POpOKaph301yFE9PJUJP/aA=;
        b=fCimPoqy1XdpgxlA7aUyWSK8RSlObGiHYSVJ95Oeecj5+0SATVu9SBVwjKeTXMRWhOLjIp
        TVeXlNlHPolRsx/3v9ORMdcFEWlBiNryRaVDhZM9ZRmtsNiDRm8YrwmiyfCiAKcdzI01Df
        pLLmO6VrwIspWdcYiHBmuIOc/xebiXw=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355-qSDV-ArYOQy7xZNFyI2ZsQ-1; Mon, 25 Sep 2023 04:57:59 -0400
X-MC-Unique: qSDV-ArYOQy7xZNFyI2ZsQ-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5218b9647a8so4277902a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 01:57:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695632278; x=1696237078;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9jYoDjvuIiF2NPGNNFR7POpOKaph301yFE9PJUJP/aA=;
        b=hl70lV8UQI167uxuFHsa312JIBLQ8M3Wba+ICziDHp2XU5RpVHLt5ABLKonVM8EIwE
         oVwdWxhVsc1TuXa2o6y2oLbHjmD9njefAAXPRx91BKI/u1FQ6eLiTGIKg+8YlYW6HW3X
         1F9L1ivk2OMEETWB49t0hMXWD/FU4KeYiW01s34LIkw1pbkR9pbqI1/0zMoFrr4x3vCT
         E2tjyDnbE77//tvuta+5xE13NpgvyL59iXtNSlISoGGW9NCENdKPsqiBhqBxpDgPuL2G
         yQ8otzYVKqBtR+LBHHDmDGz4E3O2Cx5jryef2V16PwR/kn0qLUPPmYFeoVFRuEXRub2C
         19vQ==
X-Gm-Message-State: AOJu0YwzLt23Y3CoR3usTtI6dEolvKzNnd878RzyTyTmgSi0ksc5b9uE
        6+I7NNJvO/c8zYovqKyvL9FmNmvqEE2L7r3ZV1kd06gm95mLtObBATXURwgIPqoazUggprMnpcb
        Cp569JzVJM0xwbdOk2UFE2w9X
X-Received: by 2002:aa7:d7d4:0:b0:52f:a42a:85a3 with SMTP id e20-20020aa7d7d4000000b0052fa42a85a3mr5145199eds.0.1695632278263;
        Mon, 25 Sep 2023 01:57:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWi9IMy9qmd+fxRBkEfI4zNh3gSWBYXC8dXmPklh/1AUGyK3RZVi4CUBMQfEKDMBdqZ0ZdKg==
X-Received: by 2002:aa7:d7d4:0:b0:52f:a42a:85a3 with SMTP id e20-20020aa7d7d4000000b0052fa42a85a3mr5145189eds.0.1695632277950;
        Mon, 25 Sep 2023 01:57:57 -0700 (PDT)
Received: from [192.168.43.127] ([109.37.149.50])
        by smtp.gmail.com with ESMTPSA id n18-20020a05640206d200b005224d960e66sm5201641edy.96.2023.09.25.01.57.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Sep 2023 01:57:55 -0700 (PDT)
Message-ID: <74ad10fa-f0f6-f80f-7db3-fb01aae6f2d5@redhat.com>
Date:   Mon, 25 Sep 2023 10:57:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: WARNING at drivers/acpi/platform_profile.c:74 in
 platform_profile_show()
To:     Jiri Slaby <jirislaby@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, hmh@hmh.eng.br,
        Mark Pearson <mpearson-lenovo@squebb.ca>
Cc:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <047d3c51-0a9e-4c3e-beef-625a7aa4f3c3@kernel.org>
 <505264f5-cbbb-4ffe-a3e4-93d2397e80da@kernel.org>
 <beeab87b-820a-475a-b0c6-99b1b8e491ea@kernel.org>
 <207922c7-7a56-499b-bbfd-9e8d6a0a06df@kernel.org>
Content-Language: en-US
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <207922c7-7a56-499b-bbfd-9e8d6a0a06df@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Cc Mark Pearson for thinkpad_acpi dytc support

Jiri,

On 9/25/23 09:38, Jiri Slaby wrote:
> On 25. 09. 23, 9:19, Jiri Slaby wrote:
>> But convert_dytc_to_profile() doesn't handle this at all. Do I have a newer DYTC interface? Or a broken one?
> 
>                 Case (0x00)
>                 {
>                     Local1 = 0x0100
>                     Local1 |= 0x80000000
>                     Local1 |= 0x00
>                     Local1 |= 0x01
>                 }
> 
> I.e. version 8.0, it seems.
> 
> Full DSDT for reference:
> https://decibel.fi.muni.cz/~xslaby/n/DSDT.dsl

Mark, can you please take a look at this (it is a thinkpad_acpi dytc issue)?

Jiri, Thank you for all the debugging you have done on this. Can you please file
a bug with the details / summary here:

https://bugzilla.kernel.org/enter_bug.cgi?product=Drivers

Using Platform_x86 as component so that Mark has all the info in one place ?


Regards,

Hans

p.s.

Mark, maybe should add you to the MAINTAINERS section for thinkpad_acpi ?

