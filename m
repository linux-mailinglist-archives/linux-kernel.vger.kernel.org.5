Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB927EB19A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 15:09:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233366AbjKNOJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 09:09:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233252AbjKNOJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 09:09:08 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C1E8D59
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 06:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699970943;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nBPr2/qhlVXy/Hyc/g7DaWfZI781K10TZ78qXMh6iek=;
        b=IV2H61I1TN125dRkFa/oNSXUxGN9/rMjXXOO452bhBaS/WwGD/Xy3x94gFUDj0aokX3TnY
        9HRbJMdfvAPP1Ylw5dSsWcp/2IRyk5Kkr+E6shlSRPjcxhNXN4wGtppN58dslcY3Jrvz8F
        pH9yHxiW8kEzhw7VVpLd9QvwZzXJzNs=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-FQymK-w2NgKrQ3-JHigK1A-1; Tue, 14 Nov 2023 09:09:01 -0500
X-MC-Unique: FQymK-w2NgKrQ3-JHigK1A-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-544b5d65a1aso3873778a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 06:09:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699970940; x=1700575740;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nBPr2/qhlVXy/Hyc/g7DaWfZI781K10TZ78qXMh6iek=;
        b=BxA+G6bOw0kyktnXSfgoQ+TeATZmzmcQlXH5ldIPdKyTq+8BKWzZnIw2bO9szB2fYH
         /cqKP3cl0RohjAm9njXET6HsTpT5aQf+dQL0Jzn6iqxHvU6GqiLywmv4KKFwtpH90jEW
         vKRNSk0q5Sy3jmnA948hMUeDRP2rMBuS6zrCPpuKgnPhxoJsmqL16Lag66gWwn0eICU+
         gXRIPxvMHhjAKvR/BdcRfbDVVuYDrw7uIxX1+9dwPJDabJ2AB6a6ZeQq36NJwUTNM9F0
         k3KwbFD4v/+pDUsbboFRYJhneviHUS2Mqh9JZcCCPqEuec9esCy3UzZSfkbjLsFDhOD3
         Ma8w==
X-Gm-Message-State: AOJu0Yw3xCMCtcKNk3nYQgOG8PAk4EId95t97yuVjkvqxVPcYi3hvVMZ
        WhmfBSCaQ3acbx+Qg5QSMdj09vkP3mgyjhqebPKelXlm5HhcOyHdDM7dvBiAYGk+AVFTU6h0p3N
        5/0ofjh1yX7J/g/F4+qhtZ/Ob
X-Received: by 2002:aa7:cd78:0:b0:544:a26b:dfa3 with SMTP id ca24-20020aa7cd78000000b00544a26bdfa3mr6474538edb.6.1699970940454;
        Tue, 14 Nov 2023 06:09:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHTbfNeRRfGbes8c0XvK7c0uIL0u9sxP/QgJnnaVnOeP3LCEOzo5wP7J/yWyaceeceittbAaQ==
X-Received: by 2002:aa7:cd78:0:b0:544:a26b:dfa3 with SMTP id ca24-20020aa7cd78000000b00544a26bdfa3mr6474526edb.6.1699970940203;
        Tue, 14 Nov 2023 06:09:00 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id r30-20020a50aade000000b005434e3d8e7bsm5276674edc.1.2023.11.14.06.08.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Nov 2023 06:08:58 -0800 (PST)
Message-ID: <d2cf4587-d6d3-4c77-a263-aefb01d93c5e@redhat.com>
Date:   Tue, 14 Nov 2023 15:08:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/9] hwmon: (dell-smm) Add support for WMI SMM
 interface
Content-Language: en-US, nl
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Armin Wolf <W_Armin@gmx.de>, pali@kernel.org, markgross@kernel.org,
        ilpo.jarvinen@linux.intel.com, jdelvare@suse.com,
        platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231106064351.42347-1-W_Armin@gmx.de>
 <3ec0496d-3b89-46f5-9faf-9fcce78f6b38@gmx.de>
 <8c25dfec-b0ca-4e2f-964a-5ae62452e141@redhat.com>
 <149a31b1-f5b8-438c-8883-987cb4224944@roeck-us.net>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <149a31b1-f5b8-438c-8883-987cb4224944@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

On 11/14/23 14:57, Guenter Roeck wrote:
> On Mon, Nov 13, 2023 at 09:17:48PM +0100, Hans de Goede wrote:
>>
>> I plan to review and hopefully merge this and your
>> other series sometime this week.
>>
> 
> What warrants merging this series through your tree(s) instead of
> through hwmon ?

My bad, I was not paying attention to what the patches were touching
(just a quick reply to Armin's status request), I agree that this
should be merged through the hwmon tree, sorry about the confusion.

Regards,

Hans



