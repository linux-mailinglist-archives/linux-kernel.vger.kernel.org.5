Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 352607A4873
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 13:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241388AbjIRLbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 07:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241825AbjIRLb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 07:31:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C182CF6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 04:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695036542;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+JU4zQ6vwcJPw/MJSyGmREAeGnbs/q0yibAmczn8vMQ=;
        b=YyR0PquGhcqsKIuBMAshjChkKaLeOPzYsLCRCGQ8D/6354ey2z7j79MqiM9kFIAAuEi9WE
        +amZrWeOVoR2WolG0DrYKpbfl2vxDV9YU7QNg0RHRRDQy+T4HLZH4eJQi6G9/uQSTHWwCI
        3Ok9WDYJ7uRuHvLeO3+YtPYF30CmMFU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-539-ry_HWSK2MjGYCsWP3_Ty5A-1; Mon, 18 Sep 2023 07:29:00 -0400
X-MC-Unique: ry_HWSK2MjGYCsWP3_Ty5A-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-31fed999e27so2190637f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 04:29:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695036539; x=1695641339;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+JU4zQ6vwcJPw/MJSyGmREAeGnbs/q0yibAmczn8vMQ=;
        b=BK9xokXWRHNzdYOGx18R1T6Eukly4csVm19w+VARTeItbLMJyj0Pn2okilq7V4KxD1
         GDtiqqpbBCLj/2I4DaMR7lIEVeM5RW1WCqfOPW/2xc7WpyKJYoGSZqo71JLImlmh0KA/
         SEPAx4xwfqdahJJJVMy1E6psk+cICoNNgw8ZrHVnkY1MtziHT1LAw8VksmY5r893wTuq
         E64WSAE8EgG0IALRUWECSR1u8orYhSF9VtAka/IBDoPHMMAyIlqVo8skmajMuBJu10IP
         dvOnaSkfLNnCXkBvOpDG7FKO6kr1OFH9QysX9LsTKzGe8UkSekZ0/3yds2S4h+zu4adF
         aJ7g==
X-Gm-Message-State: AOJu0YxWviuKFyPVTKgpN6csjx3v+XV7y53EeTqupyEga+vWJD+VPLhl
        F1Xac5q4VgpHG6boXczc50QQ9Nepk0np/W4GRsGuH4I4drwZcb9MqMJ3pPAsFarfVEAatxCdPFk
        og2MvtjhwUkNSDEqumZysuhb2
X-Received: by 2002:a5d:4a50:0:b0:314:1ebc:6e19 with SMTP id v16-20020a5d4a50000000b003141ebc6e19mr6842460wrs.64.1695036539298;
        Mon, 18 Sep 2023 04:28:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGs2dWf5Uesq10RnFNCiyKwtcm5JygQS+f8+YrTrn4MzgvGUvxx7a7LrepSWv59AZFdsPkvOQ==
X-Received: by 2002:a5d:4a50:0:b0:314:1ebc:6e19 with SMTP id v16-20020a5d4a50000000b003141ebc6e19mr6842443wrs.64.1695036538909;
        Mon, 18 Sep 2023 04:28:58 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74b:3400:ec51:7a3a:274e:cbee? (p200300cbc74b3400ec517a3a274ecbee.dip0.t-ipconnect.de. [2003:cb:c74b:3400:ec51:7a3a:274e:cbee])
        by smtp.gmail.com with ESMTPSA id n7-20020a7bcbc7000000b003fef3180e7asm15029850wmi.44.2023.09.18.04.28.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 04:28:58 -0700 (PDT)
Message-ID: <f803a588-f9a5-99fb-7c6f-b375d6ec7460@redhat.com>
Date:   Mon, 18 Sep 2023 13:28:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 4/4] mm/ksm: document pages_skipped sysfs knob
Content-Language: en-US
To:     Stefan Roesch <shr@devkernel.io>, kernel-team@fb.com
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, riel@surriel.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20230912175228.952039-1-shr@devkernel.io>
 <20230912175228.952039-5-shr@devkernel.io>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230912175228.952039-5-shr@devkernel.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.09.23 19:52, Stefan Roesch wrote:
> This adds documentation for the new metric pages_skipped.
> 
> Signed-off-by: Stefan Roesch <shr@devkernel.io>
> ---
>   Documentation/admin-guide/mm/ksm.rst | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/admin-guide/mm/ksm.rst b/Documentation/admin-guide/mm/ksm.rst
> index 1762219baf51..27d949250b67 100644
> --- a/Documentation/admin-guide/mm/ksm.rst
> +++ b/Documentation/admin-guide/mm/ksm.rst
> @@ -178,6 +178,8 @@ pages_unshared
>           how many pages unique but repeatedly checked for merging
>   pages_volatile
>           how many pages changing too fast to be placed in a tree
> +pages_skipped
> +        how many pages did the "smart" page scanning algorithm skip
>   full_scans
>           how many times all mergeable areas have been scanned
>   stable_node_chains

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

