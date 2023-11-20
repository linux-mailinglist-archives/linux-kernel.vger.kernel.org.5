Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA0447F10DA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 11:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232741AbjKTKxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 05:53:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232683AbjKTKxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 05:53:32 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9606BD2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 02:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700477607;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=MGmumtEaGvEW7AsfvmsShMkhHVOv2gPmnVvU8Fh6z/I=;
        b=AozNyiUtLy+CrfvDytbfWfUIuaPAC4zj4gC6oyw61hnOnym7gVyN24qCmlphso5muk1OlO
        KyiPGEDIQsNAifT8jcCvCUjTjufJTK3wjKHYbSUm9U0u11dJ/2owuigQTWrWSowTn63u5N
        bp4AxqcMac9v8DDJzAJHNys4zIdD+oU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-Se1SCNkQOBOaG5pcE88qpQ-1; Mon, 20 Nov 2023 05:53:26 -0500
X-MC-Unique: Se1SCNkQOBOaG5pcE88qpQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4095fcbba0aso12546925e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 02:53:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700477605; x=1701082405;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MGmumtEaGvEW7AsfvmsShMkhHVOv2gPmnVvU8Fh6z/I=;
        b=DYsb1LLVYRU9+ze6t5dYbgXQ0NAUkHR+grnOce1aoxKKIFq0NhgiSHgEZCW0xMrRl/
         /btRpVV8IVqPujR8UKC1tK49rYPUDDiDgf+NqQdFlaLhDAkACHdeGTo0CGYtro0TsOXK
         aVC246EapJRAz9H9qv8u15NnJjc6BO9GtJsTZ+itJ7RsEweSlK8VIjn4+aUN59oJQCc/
         fkVH7EJsh4xVKVUVJsNUiK4jexaVamsbY4XsjiGgyNeTo4jEvJ/+j8Bsk08HLz+HdOIJ
         Gqfzf18FyG2g5thJz7UTRTWGKK9IUmUKx/6lC9wXYmVJYjvvM7s70KBNKn0qO+Ad2Rui
         1pbA==
X-Gm-Message-State: AOJu0YweWbSP+jJfjiDjKpr2wg/zodRUhYPcxtQrEgXdSfz6Ae4tJuza
        DaWSHZYiac8HURdSbTamljmxqRhukhb9x+uN+ke6Z6eqkFc/jyYEZB12LiDNq1qiGNqa+UQ4/QN
        OpEAevSAPiNUXkWo2p2a+Xq1v
X-Received: by 2002:a05:600c:354a:b0:401:c338:ab94 with SMTP id i10-20020a05600c354a00b00401c338ab94mr6071691wmq.29.1700477604967;
        Mon, 20 Nov 2023 02:53:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHSjnydWCVDSATGZdSx4sZPX/COstlOFVfn47itDpa9PONE8Uv8+DgMQmp+5UajpvSriJ418A==
X-Received: by 2002:a05:600c:354a:b0:401:c338:ab94 with SMTP id i10-20020a05600c354a00b00401c338ab94mr6071673wmq.29.1700477604490;
        Mon, 20 Nov 2023 02:53:24 -0800 (PST)
Received: from ?IPV6:2003:cb:c746:7700:9885:6589:b1e3:f74c? (p200300cbc746770098856589b1e3f74c.dip0.t-ipconnect.de. [2003:cb:c746:7700:9885:6589:b1e3:f74c])
        by smtp.gmail.com with ESMTPSA id e7-20020a05600c218700b003fee6e170f9sm12877370wme.45.2023.11.20.02.53.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Nov 2023 02:53:24 -0800 (PST)
Message-ID: <b90ba995-5485-4dd3-974b-02453e67686d@redhat.com>
Date:   Mon, 20 Nov 2023 11:53:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] mm/ksm: add sysfs knobs for advisor
Content-Language: en-US
To:     Stefan Roesch <shr@devkernel.io>, kernel-team@fb.com
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, riel@surriel.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20231028000945.2428830-1-shr@devkernel.io>
 <20231028000945.2428830-3-shr@devkernel.io>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20231028000945.2428830-3-shr@devkernel.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.10.23 02:09, Stefan Roesch wrote:
> This adds four new knobs for the KSM advisor to influence its behaviour.
> 
> The knobs are:
> - advisor_mode:
>      0: no advisor (default)
>      1: scan time advisor
> - advisor_min_cpu: 15 (default, cpu usage percent)
> - advisor_max_cpu: 70 (default, cpu usage percent)
> - advisor_min_pages: 500 (default)
> - advisor_max_pages: 30000 (default)
> - advisor_target_scan_time: 200 (default in seconds)
> 
> The new values will take effect on the next scan round.
> 
> Signed-off-by: Stefan Roesch <shr@devkernel.io>
> ---
>   mm/ksm.c | 154 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 154 insertions(+)
> 
> diff --git a/mm/ksm.c b/mm/ksm.c
> index e18fecfb359d..042ecaeb0beb 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -351,6 +351,14 @@ static void init_advisor(void)
>   	advisor_ctx.cpu_time = 0;
>   }


[...]

>    * Use previous scan time if available, otherwise use current scan time as an
>    * approximation for the previous scan time.
> @@ -3719,6 +3727,146 @@ static ssize_t smart_scan_store(struct kobject *kobj,
>   }
>   KSM_ATTR(smart_scan);
>   
> +static ssize_t advisor_mode_show(struct kobject *kobj,
> +				 struct kobj_attribute *attr, char *buf)
> +{
> +	return sysfs_emit(buf, "%u\n", ksm_advisor);
> +}
> +
> +static ssize_t advisor_mode_store(struct kobject *kobj,
> +				  struct kobj_attribute *attr, const char *buf,
> +				  size_t count)
> +{
> +	unsigned int mode;
> +	int err;
> +
> +	err = kstrtouint(buf, 10, &mode);
> +	if (err)
> +		return -EINVAL;
> +	if (mode > KSM_ADVISOR_LAST)
> +		return -EINVAL;
> +
> +	/* Set advisor default values */
> +	ksm_advisor = mode;
> +	init_advisor();
> +	set_advisor_defaults();
> +
> +	return count;

Can we instead use human-readable strings?

"none" and "scan-time" should be clearer.

-- 
Cheers,

David / dhildenb

