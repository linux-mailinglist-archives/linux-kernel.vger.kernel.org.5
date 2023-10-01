Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4C027B466C
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 10:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234637AbjJAI4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 04:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234530AbjJAI4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 04:56:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94051B9
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 01:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696150553;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mPE10IJGRNlrwSUAgF3AKhKtgeEbRkyMBAYmLJmNRH8=;
        b=bl4cfWP5Ek2oSij3OhkB633ddUj2ZHxEQ2sJh04a430UDAcBA9fRaU2HbcwuppTtXWKQPc
        F3XUhq/58fGbu1Neq4adP/dg74eDKWhNra70bkQDd0y5KCPGlhd85JieK0YIgCMSpLhibg
        8ikKb8/iW5c+hgg/+0ppoahmbLerSsE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-cy4dVQFlN66MVZ8vv5Uv7g-1; Sun, 01 Oct 2023 04:55:42 -0400
X-MC-Unique: cy4dVQFlN66MVZ8vv5Uv7g-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3231fceb811so9132606f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 01 Oct 2023 01:55:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696150541; x=1696755341;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mPE10IJGRNlrwSUAgF3AKhKtgeEbRkyMBAYmLJmNRH8=;
        b=vB1/yNV6uE3dm5jMWjWXyEH1x4bowfjVv4tpAAClgF1LzSNb4e31kOj2I6EbsBTNld
         8ZV8fIXzMAPvnojCFl+ONdXVttvKuRNUfzCn1MuERMr109z5Ivk3EilgycIJw1j6+b60
         RS5+HmK7JOMEOOghOMZtlfjRqIpR/SjGM0+jZNCxZOG/EM22bMsymJUmxVC83aAkXyfU
         aDi7UISg8z2ZfmfiGKmPDHm3sgyAdUEi5Q64kn3A+bmwMefWSopcNLwzC14HU2Dwr6TC
         57K7WgzQbC4cV+sJuA0xweiBABMuxqydgcnvwkcJAMionvkOQXxZ7pRUnPR+p7pBlTGd
         b6Iw==
X-Gm-Message-State: AOJu0Yyk7sJCtgwWMMEJeBPBDIOzfrNpZA7uk4OuGkZXTG21ct4lg9i5
        Hzq0fwdRPbYKxp1exCuE1YHBpe7aDUK4mjhuutDeDY5Qde49R7bYbFMdscIkAtVV+oDdoUbE/7L
        TQyjTfehuCthB+7rVVtVGKxLc
X-Received: by 2002:a5d:610a:0:b0:314:1f1e:3a85 with SMTP id v10-20020a5d610a000000b003141f1e3a85mr6980688wrt.61.1696150541540;
        Sun, 01 Oct 2023 01:55:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSbH8Wg2khX9CeFAnrk0hxbXqrpe4hXgd+vt+57kWKXw4u/QLJ4vSOzdVhttX79b9XtDi9qw==
X-Received: by 2002:a5d:610a:0:b0:314:1f1e:3a85 with SMTP id v10-20020a5d610a000000b003141f1e3a85mr6980679wrt.61.1696150541268;
        Sun, 01 Oct 2023 01:55:41 -0700 (PDT)
Received: from [10.10.158.202] ([213.144.205.82])
        by smtp.gmail.com with ESMTPSA id t10-20020adff60a000000b0031c5e9c2ed7sm25367214wrp.92.2023.10.01.01.55.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Oct 2023 01:55:40 -0700 (PDT)
Message-ID: <b72b3fbf-36d1-2551-ac4a-f98808e1e4dd@redhat.com>
Date:   Sun, 1 Oct 2023 10:55:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 2/5] platform/x86: int3472: Add new
 skl_int3472_gpiod_get_from_temp_lookup() helper
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Daniel Scally <djrscally@gmail.com>,
        Mark Gross <markgross@kernel.org>, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20230926145943.42814-1-brgl@bgdev.pl>
 <e6817d30-b443-1a73-efae-84415604b19f@redhat.com>
 <b8b1a3f0-3aca-341c-07ee-389b077a01f7@redhat.com>
 <ZRkw5FfhSq3J+Wb8@smile.fi.intel.com>
Content-Language: en-US
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <ZRkw5FfhSq3J+Wb8@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/1/23 10:42, Andy Shevchenko wrote:
> On Thu, Sep 28, 2023 at 02:42:50PM +0200, Hans de Goede wrote:
>> Add a new skl_int3472_gpiod_get_from_temp_lookup() helper.
>>
>> This is a preparation patch for removing usage of the deprecated
>> gpiod_toggle_active_low() and acpi_get_and_request_gpiod() functions.
>>
>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>> [hdegoede@redhat.com] use the new skl_int3472_fill_gpiod_lookup() helper
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> 
> Something wrong between authorship and committer and SoB chain.
> I believe you need to preserve the authorship and add yourself as
> Co-developed-by: ?

Yes you are correct, I'll prepare a new version of the series
with this fixed.

Regards,

hans


