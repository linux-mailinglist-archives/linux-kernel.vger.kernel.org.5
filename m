Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 404977AAA59
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 09:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbjIVHe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 03:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbjIVHe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 03:34:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3650CCA
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 00:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695368044;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QnuzTByB/vSrTjtucgIkKmwnZD2DFvpkLn05+be6TBw=;
        b=Win/DEQPti95eONQuk8EjYCih9F+d0xBb1+DTfCc/7Mj1rQKMQ7UjysM/jL5Wd2pbfHryj
        igs9RgxSMiptTJ5HQVSZYhIDvCGQgAvqMM8wmcSwCQkXoBK5kS5dQkVgh6VG05OAUA3aYD
        iHdQYYoCFJinVK/CvMTwYsst/Hf8BxI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-KI_vqPnWOtmYbSYbxBbLAA-1; Fri, 22 Sep 2023 03:34:02 -0400
X-MC-Unique: KI_vqPnWOtmYbSYbxBbLAA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-320095a13deso1353136f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 00:34:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695368041; x=1695972841;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QnuzTByB/vSrTjtucgIkKmwnZD2DFvpkLn05+be6TBw=;
        b=KWAGln9deg6OzZ7L2jw/DvnoCoHXQeWmKjXXYQRZ55jXbnvH4ntjjO7Us7nQQsehMC
         wtj8jxweFoPNN1HG1SneWpdtpG/krr/mH2UDzy8yD31fKYBl+j4rmYxAsMgOkGVVkiSy
         px6V3QEglcdXOg5v3phtSTeUPEc8NZzDR/Zfp5uA23ITCfuJ2xUIE7j9VL9lMzfcjYUO
         fVqEA4587pPg/smSET9QK1F7CAPhWw/2/gRiCW5maR2e8oFf3Z/rxpCZVAeYQTQSKwcL
         +6lfw2WEf59/2NKqX5wbLIp+NQFDHXWYKUlIOHYePVgJSQwlnN/Ed3CXJ3YxIUm3Lg7M
         jPXg==
X-Gm-Message-State: AOJu0YxqsH1unTgisae+X1g4Ew2mSlJt4pKiQE/E8yFcOYU12R9nlaEc
        UrUXNh/IejlYbeMetnbXZ1XnpSg90HzkcwkODZeNn021d28z3ovxA57f5FOmmT0ZyaNbF1IUqwp
        6x4qmm84Rrr+kBTG8r5/GfoAfzmP5625k
X-Received: by 2002:a5d:5091:0:b0:31a:ddf0:93b with SMTP id a17-20020a5d5091000000b0031addf0093bmr6520791wrt.33.1695368041352;
        Fri, 22 Sep 2023 00:34:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGlrK6HVEsmfxQZ3b0CKEuUpZOYux0eIwIRK0gdYOWVMPTNQXhp2nrg796fdOrs66TfYlXBxQ==
X-Received: by 2002:a5d:5091:0:b0:31a:ddf0:93b with SMTP id a17-20020a5d5091000000b0031addf0093bmr6520777wrt.33.1695368040979;
        Fri, 22 Sep 2023 00:34:00 -0700 (PDT)
Received: from ?IPV6:2003:cb:c71a:7100:dfaf:df8b:54b9:7303? (p200300cbc71a7100dfafdf8b54b97303.dip0.t-ipconnect.de. [2003:cb:c71a:7100:dfaf:df8b:54b9:7303])
        by smtp.gmail.com with ESMTPSA id z8-20020adfd0c8000000b00317a29af4b2sm3708207wrh.68.2023.09.22.00.34.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Sep 2023 00:34:00 -0700 (PDT)
Message-ID: <8df8d6dd-d0fc-908e-77c7-a67167e1c74f@redhat.com>
Date:   Fri, 22 Sep 2023 09:33:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] memory-hotplug.rst: fix wrong /sys/device/ path
Content-Language: en-US
To:     Wang Jinchao <wangjinchao@xfusion.com>,
        Oscar Salvador <osalvador@suse.de>,
        Jonathan Corbet <corbet@lwn.net>, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     xulei <stone.xulei@xfusion.com>
References: <ZQz1NUATBMOb3RT+@fedora>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <ZQz1NUATBMOb3RT+@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.09.23 04:00, Wang Jinchao wrote:
> Actually, it should be /sys/devices/
> 
> Signed-off-by: Wang Jinchao <wangjinchao@xfusion.com>
> ---
>   Documentation/admin-guide/mm/memory-hotplug.rst | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/admin-guide/mm/memory-hotplug.rst b/Documentation/admin-guide/mm/memory-hotplug.rst
> index cfe034cf1e87..01595965734a 100644
> --- a/Documentation/admin-guide/mm/memory-hotplug.rst
> +++ b/Documentation/admin-guide/mm/memory-hotplug.rst
> @@ -250,15 +250,15 @@ Observing the State of Memory Blocks
>   The state (online/offline/going-offline) of a memory block can be observed
>   either via::
>   
> -	% cat /sys/device/system/memory/memoryXXX/state
> +	% cat /sys/devices/system/memory/memoryXXX/state
>   
>   Or alternatively (1/0) via::
>   
> -	% cat /sys/device/system/memory/memoryXXX/online
> +	% cat /sys/devices/system/memory/memoryXXX/online
>   
>   For an online memory block, the managing zone can be observed via::
>   
> -	% cat /sys/device/system/memory/memoryXXX/valid_zones
> +	% cat /sys/devices/system/memory/memoryXXX/valid_zones
>   
>   Configuring Memory Hot(Un)Plug
>   ==============================
> @@ -326,7 +326,7 @@ however, a memory block might span memory holes. A memory block spanning memory
>   holes cannot be offlined.
>   
>   For example, assume 1 GiB memory block size. A device for a memory starting at
> -0x100000000 is ``/sys/device/system/memory/memory4``::
> +0x100000000 is ``/sys/devices/system/memory/memory4``::
>   
>   	(0x100000000 / 1Gib = 4)
>   

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

