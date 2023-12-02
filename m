Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58F2E801CB0
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 13:43:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232678AbjLBMnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 07:43:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232138AbjLBMnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 07:43:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25C32188
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 04:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701520997;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h4DJq4T+U4J3l6LPK0uojmAyF6LfoimHRqrF4QgIogY=;
        b=KG77iw4gEsvW24mBlBhdUg9P30FufCmID/o9t9SzhnkVt8YnbdygplZAiZHRcr2UyupV7m
        zzgLhlHLxGYoSiTl0pf1rKrzF+IhURz61Y3VY7NvJ2XGYU51lSFVKh1UvLxQJr2+WVdxq9
        Nxn7RY3P/+9YXvGEqn1WnFJ1pxsFk/A=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-TWpg7M6QNJCAkJjyyRF_-g-1; Sat, 02 Dec 2023 07:43:15 -0500
X-MC-Unique: TWpg7M6QNJCAkJjyyRF_-g-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a02cc56af16so272115566b.3
        for <linux-kernel@vger.kernel.org>; Sat, 02 Dec 2023 04:43:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701520994; x=1702125794;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h4DJq4T+U4J3l6LPK0uojmAyF6LfoimHRqrF4QgIogY=;
        b=roFAHQJAWZsJgU7h198t/HmvKtulqa8bJMLEIsl1Ol2107GpTPDBnOYlh2x2O+23I8
         t3sQZ1HtvMU6BpaY1o5q4z0N/+d7A7Y1mWnPToujyxs/xCarzlvM2phKa7DCHA43WDv3
         deYWbUp4hkSFr8hmsnYXANvEH/mN6LXtrn/o+YrhX0zc+YqMWYZMLa8JZCs49Io3cOdW
         1Yb6ccLGdIIIS1F5JrQluHRBbPrpcmZZXqCvDkHzzOC3oMBtLwYrFsVRP3CiZTh5UQV3
         c3qtzM7Mi6pLqzQYADybjQZ5F++g7unxp+lzJ/VsowplBQpTPaoLkNirQhxinirWwtEC
         bicA==
X-Gm-Message-State: AOJu0YySOIdvnEDbV3QMLPGBsF6qqjcZbkBieoTOtBdjhdaMtyxdqZc6
        IQS5IhKWAPNGmiSL1I7pTdNdOXIuqFDrtHdgPaSBwH8WYVwHTur2vTd4KERyCxTOLo8dckk/gtM
        Yp3pORLm1s2EcyD8PQmxcs1zI
X-Received: by 2002:a17:906:d295:b0:a19:a19b:55f6 with SMTP id ay21-20020a170906d29500b00a19a19b55f6mr1716428ejb.134.1701520994691;
        Sat, 02 Dec 2023 04:43:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEkw8ECvyYB005RuSFu+FKenCisiOosr0lIXRvYlHHyXKgGxBCWlDX8Hlv33kA9TEyha+zm5A==
X-Received: by 2002:a17:906:d295:b0:a19:a19b:55f6 with SMTP id ay21-20020a170906d29500b00a19a19b55f6mr1716421ejb.134.1701520994397;
        Sat, 02 Dec 2023 04:43:14 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id m25-20020a170906235900b009fcb10eecb2sm2985850eja.84.2023.12.02.04.43.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Dec 2023 04:43:13 -0800 (PST)
Message-ID: <61ef73e6-e633-47e1-b599-ee66aa179227@redhat.com>
Date:   Sat, 2 Dec 2023 13:43:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/4] ACPI: OSL: acpi_os_execute() improvements
Content-Language: en-US, nl
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Michal Wilczynski <michal.wilczynski@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Mario Limonciello <mario.limonciello@amd.com>
References: <3281896.aeNJFYEL58@kreacher>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <3281896.aeNJFYEL58@kreacher>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/29/23 14:45, Rafael J. Wysocki wrote:
> Hi Everyone,
> 
> This series improves acpi_os_execute() on top of
> 
> https://patchwork.kernel.org/project/linux-acpi/patch/5745568.DvuYhMxLoT@kreacher/
> 
> but only the last patch really depends on it.
> 
> The first two patches clean up the code somewhat and the third one modifies
> the function to allow Notify () handlers to run on all CPUs (not on CPU0 only).
> 
> The last patch changes it to use GFP_KERNEL for memory allocations, as it does
> not run in interrupt context any more after the change linked above.

I have added this series, as well as the preceding
"ACPI: OSL: Use a threaded interrupt handler for SCI"
patch to my personal tree now, so that it will get tested on various
devices when I run my personal tree on them.

I'll let you know if I hit any issues caused by this series.

Regards,

Hans


