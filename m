Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 459B87A4F9F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 18:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbjIRQsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 12:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbjIRQrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 12:47:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 456A5182
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 09:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695055458;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4TTxQOCDOWFA0p2jwGlB97ue19qCIKfMgOp8dZqLo94=;
        b=YQbYTQaa6NJ0ERMgmZ+TcB8ZPHCy2o/CQo/oVGcJkax4tlAdXLy83l/2kJIjaXuesi/hN2
        4ojlTp/AGKgSl2wi0lZehnOCucmgPZlplykdZhVhNs2o6r788sVXWZiRjebvMp9jW77Mo+
        OPQN6AHG3zZ5gjRR3pY7ir/D52cAXPI=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-vKmLerSjNpiLS7dYSCsRKg-1; Mon, 18 Sep 2023 09:41:30 -0400
X-MC-Unique: vKmLerSjNpiLS7dYSCsRKg-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2bfe5e88d85so27298501fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 06:41:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695044489; x=1695649289;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4TTxQOCDOWFA0p2jwGlB97ue19qCIKfMgOp8dZqLo94=;
        b=eRk6lh2RAF4aEKUyMcHjrNcu3fiUYpaTN8LeKF1bfxLKWEazKE9BGuzcfJNaq/NPRT
         l0z4B0IlyBaG0L/ZPt7go2nUnddrAjIQzQO3xDtmiLTDXxHEc+u2honvIiQvi6UmNsv8
         WZNYiD5VCRtxVX9e6NGs3Hpw4eEzDZZ9z3ocwjdCN6lvCv/id8vx+ICM7zMGIldxK1YG
         7+VDk4v5cFfOtqYoE1w9Km0lhm+kVZKJfSP4ysQnG5ybziU6Lxd3Mn9PLbOGV25WEhxL
         IMbcfHg+iyaUsCE/OOEaytRg7LitaYn36QXuDrdrR9vwV9RQRQQrGl7Z8cAoUASx7HP3
         TJlw==
X-Gm-Message-State: AOJu0YwvdLD4eADHjJbYvSBaw1uM3W8SjYr1HYL5FF+zhkK4q6BY+vzt
        gs+BeFuMYvdOft8cihKcOY0ogCxqPTenDFgESsVpZs9qZ7zD9eqKMh6KoKbh829a2GxvliBTTtK
        09IO8jyi9yeJgg54YDg28Zu78
X-Received: by 2002:a2e:854e:0:b0:2bd:bc9:30aa with SMTP id u14-20020a2e854e000000b002bd0bc930aamr7755911ljj.23.1695044489206;
        Mon, 18 Sep 2023 06:41:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgqBmH2hwom+Lx5lEzqnk0cF22EnYtz2nqSN55UwRLMM+A4J8u3a+gcEep0pBcMiR7e0h5Gw==
X-Received: by 2002:a2e:854e:0:b0:2bd:bc9:30aa with SMTP id u14-20020a2e854e000000b002bd0bc930aamr7755897ljj.23.1695044488880;
        Mon, 18 Sep 2023 06:41:28 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id s7-20020a17090699c700b009adcb6c0f0dsm5133635ejn.38.2023.09.18.06.41.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 06:41:26 -0700 (PDT)
Message-ID: <6a4a9acf-aa1d-dc73-b171-76654e1b9d47@redhat.com>
Date:   Mon, 18 Sep 2023 15:41:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] platform/x86: thinkpad_acpi: sysfs interface to auxmac
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Fernando Eckhardt Valle <fevalle@ipt.br>
Cc:     Mark Pearson <mpearson-lenovo@squebb.ca>, corbet@lwn.net,
        hmh@hmh.eng.br, markgross@kernel.org, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org
References: <20230915123136.4286-1-fevalle@ipt.br>
 <97ac516a-5d9f-f58d-2313-d7d3453f58cb@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <97ac516a-5d9f-f58d-2313-d7d3453f58cb@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/15/23 18:18, Ilpo Järvinen wrote:
> On Fri, 15 Sep 2023, Fernando Eckhardt Valle wrote:

<snip>

>> +		goto auxmacinvalid;
>> +	}
>> +
>> +	if (strncmp(obj->string.pointer + 0x8, "#", 1) != 0 ||
>> +	    strncmp(obj->string.pointer + 0x15, "#", 1) != 0) {
> 
> Why use strncmp with (..., 1)? These offsets should defines above and not 
> use literals.

Right, good point.

To be extra clear here, this should be replaced by != '#' statements, e.g.:

	if (obj->string.pointer[AUXMAC_BEGIN_MARKER] != '#' ||
	    obj->string.pointer[AUXMAC_END_MARKER] != '#') {
		...

Regards,

Hans

