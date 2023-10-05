Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0B757BA3EE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236685AbjJEQA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237812AbjJEP5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:57:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C763C57EC8
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 07:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696514762;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H+dL1KNRLmzSbL5JPUc0aKfIeaA78X3WrQS6IGVzbKs=;
        b=E8dEfBpxl0qhLBZX3LLR0IY7bek8WgGA3fDVfcmdCd6k1emXNuodWfFyTKLpp+yvr2T0Ee
        7Ragxa4J/MuRxZLQDQ1/ga3sbvtDAvgBsttdTvaFKbTsWhpl1qWtjvkm2WvpgyNTQjDWFa
        dcSFmu9QgNJB5SYDkMw3oNHnopDmoig=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-346-a00fWFPKOma4bPrOn8Tj9g-1; Thu, 05 Oct 2023 03:03:23 -0400
X-MC-Unique: a00fWFPKOma4bPrOn8Tj9g-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9a5d86705e4so58167366b.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 00:03:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696489402; x=1697094202;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H+dL1KNRLmzSbL5JPUc0aKfIeaA78X3WrQS6IGVzbKs=;
        b=Lw79iyfzi2PR8j8YMJj8AiI1/T+RMrpbVr6GBKI1zGE8i8eniQt90XwmCMKN5QEGwo
         HVOY2fyIei/U0kja5hKeQncCJF3eWNAR0OD3M3xsW3tA1Jw3eb2UtKiT9gtZB1QIC4F8
         rL8gpw6pKVjpcJvFdcgXrBXpVYBqMdzTOU68m5vxCbU5b0Qxb25LpCbmI7h95edVrys1
         P2tU2FEpUIAUx/kjkfxg32+HBwXNmhp8kYoZ4jbZi6ECqRjhgEjQGzcTVsvhB9h6pi45
         kCPagmAFKRs+e3oVoTeMCSYNhbtmaMOy0JtBT+9X6l2oHogdX2oToSbfmrel/Xk9jEIm
         ECuQ==
X-Gm-Message-State: AOJu0YwybRvaeoCRm7E27SNBW//fe5R68PqPWhr2GKz2OTuMiy845CFV
        zBHHQfu6rl/37+B67RCQss/t6eRIyoJ7c6O7shNHIWswGt8zCQTGRWWjgjobs0htAcv3QLzA9I0
        GKAF31PdyJHQQf5Kdm5Au4S52
X-Received: by 2002:a17:907:760f:b0:9ad:78b7:29ea with SMTP id jx15-20020a170907760f00b009ad78b729eamr4046561ejc.44.1696489402706;
        Thu, 05 Oct 2023 00:03:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1Rc1hKtAv9AbyjDBdjArCvg7E8aI+Ubhssmr7NRq4YBr1jS0x6lbR/m9GaK/OyCzetgeJbg==
X-Received: by 2002:a17:907:760f:b0:9ad:78b7:29ea with SMTP id jx15-20020a170907760f00b009ad78b729eamr4046544ejc.44.1696489402388;
        Thu, 05 Oct 2023 00:03:22 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id o6-20020a17090611c600b009ad875d12d7sm644357eja.210.2023.10.05.00.03.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Oct 2023 00:03:21 -0700 (PDT)
Message-ID: <e84bc80e-1fd9-f07b-526a-b4eb4780ea9b@redhat.com>
Date:   Thu, 5 Oct 2023 09:03:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [UPDATE][PATCH] platform/x86/intel-uncore-freq: Conditionally
 create attribute for read frequency
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        markgross@kernel.org, ilpo.jarvinen@linux.intel.com,
        andriy.shevchenko@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231004181915.1887913-1-srinivas.pandruvada@linux.intel.com>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20231004181915.1887913-1-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srinivas,

On 10/4/23 20:19, Srinivas Pandruvada wrote:
> When the current uncore frequency can't be read, don't create attribute
> "current_freq_khz" as any read will fail later. Some user space
> applications like turbostat fail to continue with the failure. So, check
> error during attribute creation.
> 
> Fixes: 414eef27283a ("platform/x86/intel/uncore-freq: Display uncore current frequency")
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
> Added fixes tag which added current_freq_khz. But after this
> tag there is reorg of code, so need manual backport for some versions.
> I will separately submit to stable trees after merge.

Can you for future updated patches please use the ususal [PATCH v2],
[PATCH v3], etc. prefix ?

Also please document the changes per version after the cutline, e.g. :

```
---
Changes in v2:
- Added fixes tag which added current_freq_khz. Note after this
  tag there is reorg of code, so need manual backport for some versions.
  I will separately submit to stable trees after merge.
```

Regards,

Hans




> 
>  .../x86/intel/uncore-frequency/uncore-frequency-common.c  | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c
> index 1152deaa0078..33ab207493e3 100644
> --- a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c
> +++ b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c
> @@ -176,7 +176,7 @@ show_uncore_data(initial_max_freq_khz);
>  
>  static int create_attr_group(struct uncore_data *data, char *name)
>  {
> -	int ret, index = 0;
> +	int ret, freq, index = 0;
>  
>  	init_attribute_rw(max_freq_khz);
>  	init_attribute_rw(min_freq_khz);
> @@ -197,7 +197,11 @@ static int create_attr_group(struct uncore_data *data, char *name)
>  	data->uncore_attrs[index++] = &data->min_freq_khz_dev_attr.attr;
>  	data->uncore_attrs[index++] = &data->initial_min_freq_khz_dev_attr.attr;
>  	data->uncore_attrs[index++] = &data->initial_max_freq_khz_dev_attr.attr;
> -	data->uncore_attrs[index++] = &data->current_freq_khz_dev_attr.attr;
> +
> +	ret = uncore_read_freq(data, &freq);
> +	if (!ret)
> +		data->uncore_attrs[index++] = &data->current_freq_khz_dev_attr.attr;
> +
>  	data->uncore_attrs[index] = NULL;
>  
>  	data->uncore_attr_group.name = name;

