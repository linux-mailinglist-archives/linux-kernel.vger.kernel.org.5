Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDB157CF8FC
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 14:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345613AbjJSMcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 08:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345587AbjJSMc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 08:32:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB723D42
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 05:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697718682;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B0OGs7K+S9eIE1QjbuJJt5bTyWAq7lCol/WeGX/BQXw=;
        b=aTbWsLIf+DNZPiRUhAHi1yMMqQq4M1zFBls8H/T2Lro8jTmQ3vwnn/98+1G9qwr+aiyE1h
        t/e68WnUcA48GjdUKvG3TAuojCZ3UZc/OEA7spH1WP+ZuUBRan58Nw7BupFspe/sJhTkAT
        8v4SX3/YQv+E7a42fdXGbECZyq/lFIU=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-413-fZdPnIoEOjWQqTC0T-OmKg-1; Thu, 19 Oct 2023 08:31:21 -0400
X-MC-Unique: fZdPnIoEOjWQqTC0T-OmKg-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-52f274df255so835644a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 05:31:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697718680; x=1698323480;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B0OGs7K+S9eIE1QjbuJJt5bTyWAq7lCol/WeGX/BQXw=;
        b=DnAaz6wtEtnaH5jVyXl5ZZLH8zJrZ6ZH216EzoeISX0TO1dtRGnh2EVFQdcPoihhSJ
         chj75SUBQGNca1ggnS1QCR9lVgZFUCgYnVq7B/Yt6NhRKM9BUE0DLlZr20HYSTSpa8zY
         cW+14kQzb1qyAZQhZ7OaFXDrinbyyKrrhuJM9h/xCztmlYw+wfQN34ktT/QeacsibbbB
         +M6rDN7pDjHZsW4rQdW2ee51VlzmV4Ai1L1E5DiAtVqjk4XU/I4RaQ/WEISDp9YQ3AVl
         EMt2UhyrXBDJFM7HgTqMGUZvuE4ecWytXf/nMEzxw8LKo689dnAZ3lgfevOfcFIg64yw
         /npg==
X-Gm-Message-State: AOJu0YyMCpWWcnQbHLM41iVJySfnefeQaosOfzWg4fuzpujAAyTbGV6o
        trVr/DufnOQ3VlXFetj3DqCIKi8AT0EFEcNoGW/cFqOzx6QgxJVq2eL69ZH//Y09Z0KgVHG9roY
        WiAl/HmQ44ipOO2MCNepJ/aF8
X-Received: by 2002:a17:906:6a13:b0:9ad:8a96:ad55 with SMTP id qw19-20020a1709066a1300b009ad8a96ad55mr1776189ejc.14.1697718680413;
        Thu, 19 Oct 2023 05:31:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwcwLPbg3o9WYPnr+SPHS6nCHx6YRoXPt2dKFb8OVbPDZSQybdNykkXiBokW979YQn4Wc61g==
X-Received: by 2002:a17:906:6a13:b0:9ad:8a96:ad55 with SMTP id qw19-20020a1709066a1300b009ad8a96ad55mr1776178ejc.14.1697718680159;
        Thu, 19 Oct 2023 05:31:20 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id ci11-20020a170906c34b00b009ae587ce135sm3454304ejb.223.2023.10.19.05.31.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 05:31:19 -0700 (PDT)
Message-ID: <972d21dc-de29-fbac-bf04-efecfdbe565e@redhat.com>
Date:   Thu, 19 Oct 2023 14:31:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3] platform/x86: inspur-wmi: Add platform profile support
To:     =?UTF-8?B?6Im+6LaF?= <aichao@kylinos.cn>,
        "ilpo.jarvinen" <ilpo.jarvinen@linux.intel.com>,
        markgross <markgross@kernel.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        platform-driver-x86 <platform-driver-x86@vger.kernel.org>
References: <t4mw22in81-t4pfxpcqvm@nsmail7.0.0--kylin--1>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <t4mw22in81-t4pfxpcqvm@nsmail7.0.0--kylin--1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/19/23 04:20, 艾超 wrote:
> Hi.
> 
> 
>> Thanks this is much better.
> 
>> Only remaining question I have is can the platform_profile
>> setting be changed by a hotkey (directly by the hotkey,
>> so upon pressing the hotkey the EC changes the platform_profile
>> itself).
> 
>> If the answer to this is yes, is there then any event which
>> the driver could listen to and then use to notify userspace
>> about the change by calling platform_profile_notify() upon
>> receiving the event ?
> 
>> Or maybe the event will be received by the discussed
>> hotkeys driver, so that can call platform_profile_notify()
>> instead. Note platform_profile_notify() does not require a
>> platform_profile_handler pointer, so it could indeed be
>> called from a separate driver if the events are received
>> elsewhere.
> 
>> Regards,
> 
>> Hans
> 
> There is no any event need to listen by this driver. If user
> 
> pressing the hotkey, desktop applications receive
> 
> hotkeys(Fn+Q) event, then APP get the currently power mode
> and change it. The desktop applications modify brightness
> 
> based on power mode. EC can't changes the power mode
> 
> itself.

OK, that is good to know. Thank you for answering 
my questions about this.

I believe that once the few small remaining review remarks
are addressed this should be ready for merging then.

Regards,

Hans


