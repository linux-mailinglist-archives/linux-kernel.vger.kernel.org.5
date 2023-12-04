Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F68280363D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 15:19:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234189AbjLDOTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 09:19:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbjLDOTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 09:19:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A0B583
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 06:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701699567;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CVxcuA5O7vtHxh6BDYzSDk/ZrvKnBNgsg9DsBQMzwt4=;
        b=Z+bK1SI4IQrYpF41cd5T6gHyOTrd7KSb6wdLM6TbT94CfCax0FpjBNddzeC2GY2sFcev/U
        NB8OKJUH89R4ROMRGoNfV3N/I+US4cjnMC5NLBNBI4VoP517Y1JS3xh27n1qRzDlrI9j9z
        YFnIg9Jbg+BqxvdgydNs+wAZmIsSbok=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-vZHMhj1hMcmqbVk7arzpDA-1; Mon, 04 Dec 2023 09:19:26 -0500
X-MC-Unique: vZHMhj1hMcmqbVk7arzpDA-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-54455e2a5c8so3351486a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 06:19:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701699565; x=1702304365;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CVxcuA5O7vtHxh6BDYzSDk/ZrvKnBNgsg9DsBQMzwt4=;
        b=pMKoAim/LLqJFQ7Oqp9Sk4ypEjvw8g1kDXsVATNYA5NKq1k51GrHNK+tlsANvMxel1
         vHsXfT5q66uV05OpKMhXJ2JWyd+Y2N8V6g6wSMPsY/d3D08W9oB/4sPvO11Z4+enae9v
         y2lbzjX1JEd64qEXCI5S1xujeUJdL7k+azJxx/u409iWU0reZ2pM4Ru9wWwtJzNg1wR8
         NVZ8+plrWGqsn3bMMNi2l9NQYhnwC8XK/DSB67fOY4PNhxeOKY4wQIB9TFA22CGPlQDo
         BzTIU+RZ0GySokVZ59R0stvZ9OouD2MV6FI6isG/57frXuCgiyGpkQmuBrJR321dNvjf
         UDHg==
X-Gm-Message-State: AOJu0YxZpsnmXe+5iBpnFQ0L4ayNzWPum12BqpL5FFSbKuvO0bqOcXCo
        1L9D892mvqZW7L7oILbv1wjn6Q03R5Uec6daURysj59SzIdAbowNs7JbiU6x+oqu7hXO4vNoxBp
        YSsy0TY98DSDUb2yh2Q3OEy4e
X-Received: by 2002:a17:906:51de:b0:a19:a19b:55f0 with SMTP id v30-20020a17090651de00b00a19a19b55f0mr284930ejk.128.1701699565256;
        Mon, 04 Dec 2023 06:19:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE/EGVsdST4KQF6EyBnFKk8CMoutzazJzlTXbos+FVQn2CFyvQ/oSKstzczb4hmwV+z2HH0sw==
X-Received: by 2002:a17:906:51de:b0:a19:a19b:55f0 with SMTP id v30-20020a17090651de00b00a19a19b55f0mr284924ejk.128.1701699565007;
        Mon, 04 Dec 2023 06:19:25 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id cb26-20020a170906a45a00b00a0958af2387sm5291092ejb.201.2023.12.04.06.19.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Dec 2023 06:19:24 -0800 (PST)
Message-ID: <5601c760-dc79-4131-99f0-961d5cdcfbc2@redhat.com>
Date:   Mon, 4 Dec 2023 15:19:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] platform/x86: ISST: Process read/write blocked
 feature status
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        markgross@kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        platform-driver-x86@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
References: <20231130214751.3100418-1-srinivas.pandruvada@linux.intel.com>
 <20231130214751.3100418-5-srinivas.pandruvada@linux.intel.com>
 <d3b0dd08-4eca-4268-8b13-e60bd3d85524@redhat.com>
 <e64acb49-608b-a673-c145-7b6bf4c38d5a@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <e64acb49-608b-a673-c145-7b6bf4c38d5a@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/4/23 15:11, Ilpo Järvinen wrote:
> On Mon, 4 Dec 2023, Hans de Goede wrote:
>> On 11/30/23 22:47, Srinivas Pandruvada wrote:
>>> When a feature is read blocked, don't continue to read SST information
>>> and register with SST core.
>>>
>>> When the feature is write blocked, continue to offer read interface for
>>> SST parameters, but don't allow any operation to change state. A state
>>> change results from SST level change, feature change or class of service
>>> change.
>>>
>>> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
>>> ---
>>> v2
>>> - Change read_blocked, write_blocked to bool
>>> - Move the check for power_domain_info->write_blocked for SST-CP
>>> to only write operations
>>
>> Thanks, patch looks good to me:
>>
>> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>>
>> Did you drop Ilpo's Reviewed-by from v1 on purpose
>> because of the changes ? Or did you forget to add it ?
> 
> No he didn't because this patch had an issue in v1 so I never gave my 
> rev-by for this patch. ;-)

Ah, there are 2 patches with "Process read/write blocked feature status"
as part of the subject, that confused me :)

> But here it's now for v2:
> 
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Thanks & Regards,

Hans


