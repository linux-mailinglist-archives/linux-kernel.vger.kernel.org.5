Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A47E803AAE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 17:46:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232105AbjLDQqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 11:46:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346026AbjLDQfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 11:35:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D67116
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 08:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701707752;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N9zFr5Z7rzhpztBFsVSLe9WUlFhYIprACtGJe/dj4Fs=;
        b=VFWapF2aCWTIGpVjwTspfQLU7Vw9qh0avCorSvHRSIQ+3aQ0Rf0LqlIYSzvzh6LsgsUstz
        y6quNpux7dAxmjA0PCs47ySsQqm6Sgadz+mUaa4XtBB8uqtbjjEAVbVlJKrVk51gdadPzy
        5zOzfKxL3vNj+si4ipG6Jz83ufPBpS0=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-xiNkm-E7MKOyWnTnYxTxkg-1; Mon, 04 Dec 2023 11:35:51 -0500
X-MC-Unique: xiNkm-E7MKOyWnTnYxTxkg-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-54bfb101ef8so3519073a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 08:35:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701707750; x=1702312550;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N9zFr5Z7rzhpztBFsVSLe9WUlFhYIprACtGJe/dj4Fs=;
        b=w8uDJG0WET7VVstTui5JeDAf/qle5VxkxbW7PeSO2Avy7wl0fMimKsV3eeiWyFskX/
         UKvRAKeQkbHVeSn7WamvP1Oc1UsfMFdw0jckpTvdaP5J1l6ip/qHfAYivl3vnn+2ikpn
         QwzrCSbNfPCwHxGI41b5Xkl2a3w0TfJMSxV5zUF+nqVVC7pyNcm06T9WUTCHoHOaWAg5
         k85eHtZ5LcvGir6JHwHjvkKgGUzPcOKBbOLcRuY2fRu1a+rWtpBc5InZMF8Scqce6t0l
         O4KnZVLLPSxRJK2Dk+ZJf2WaSE/Z9IFkW/JIcrzldtp3u1qqkmTcB1fi7sd+UYWgsoG5
         DJsw==
X-Gm-Message-State: AOJu0YxH8xKLH/D/+mUVCbxrQlaCxRvD/rbzZuJKBWlNTrmgiWz8BPTa
        VQ9pg1CU182OThntyIlHbONtpuevd2tj7jlne3CQ0sW8I/CdL/bDJlaHatYhlgFFneaC5Qw2rXj
        zNVWx7h3nXYbmo49yVcQ1SQ+a
X-Received: by 2002:a50:d0c3:0:b0:54c:e4fc:3a6 with SMTP id g3-20020a50d0c3000000b0054ce4fc03a6mr783285edf.57.1701707750166;
        Mon, 04 Dec 2023 08:35:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHvspMP4litz4PtJIqqNzNDS7Utl2A/0i6mBHzjqm4dZ53/GQNcL+SpJK1ptjLrLe0FmzpJ6A==
X-Received: by 2002:a50:d0c3:0:b0:54c:e4fc:3a6 with SMTP id g3-20020a50d0c3000000b0054ce4fc03a6mr783273edf.57.1701707749900;
        Mon, 04 Dec 2023 08:35:49 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id v25-20020a509559000000b0054cacb41abasm2081677eda.60.2023.12.04.08.35.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Dec 2023 08:35:49 -0800 (PST)
Message-ID: <de6f1787-8e41-4b5b-a704-bac9cb71c1bf@redhat.com>
Date:   Mon, 4 Dec 2023 17:35:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/4] ACPI: OSL: acpi_os_execute() improvements
Content-Language: en-US, nl
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Michal Wilczynski <michal.wilczynski@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Mario Limonciello <mario.limonciello@amd.com>
References: <3281896.aeNJFYEL58@kreacher>
 <61ef73e6-e633-47e1-b599-ee66aa179227@redhat.com>
 <CAJZ5v0j1fHebN0w0oYFv0CapkF1XvQ-0xWtQtuLtx0So50hzsw@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAJZ5v0j1fHebN0w0oYFv0CapkF1XvQ-0xWtQtuLtx0So50hzsw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

On 12/4/23 17:32, Rafael J. Wysocki wrote:
> Hi Hans,
> 
> On Sat, Dec 2, 2023 at 3:31 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi,
>>
>> On 11/29/23 14:45, Rafael J. Wysocki wrote:
>>> Hi Everyone,
>>>
>>> This series improves acpi_os_execute() on top of
>>>
>>> https://patchwork.kernel.org/project/linux-acpi/patch/5745568.DvuYhMxLoT@kreacher/
>>>
>>> but only the last patch really depends on it.
>>>
>>> The first two patches clean up the code somewhat and the third one modifies
>>> the function to allow Notify () handlers to run on all CPUs (not on CPU0 only).
>>>
>>> The last patch changes it to use GFP_KERNEL for memory allocations, as it does
>>> not run in interrupt context any more after the change linked above.
>>
>> I have added this series, as well as the preceding
>> "ACPI: OSL: Use a threaded interrupt handler for SCI"
>> patch to my personal tree now, so that it will get tested on various
>> devices when I run my personal tree on them.
>>
>> I'll let you know if I hit any issues caused by this series.
> 
> As stated here
> 
> https://lore.kernel.org/linux-acpi/CAJZ5v0jkHLGa2XxB4TMqzrBBdZYXY79+sh1Z0ZF6keYdLDyfkg@mail.gmail.com/
> 
> the last patch in this series is not really a good idea just yet, so
> please drop it.

Ack, done.

Regards,

Hans


