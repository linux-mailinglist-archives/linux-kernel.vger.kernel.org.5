Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A028D7F10EA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 11:55:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232738AbjKTKzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 05:55:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232804AbjKTKzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 05:55:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E63D2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 02:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700477717;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=xSIGRF/7VBbZlLtEMWR+fp7S8tCj8dJX1So74Eiu2Zg=;
        b=hYq5PJTpAOyMMxbF5CAcDC6q5lrmOunL3RX95n0PSu+F1Xu6xxxjYaF3GU6AEvJ7t1dBof
        nAGSgXxFLkdNODwZwC4BTDOleJxDm0clHa+IOekpwQD8PB/gvw8i2vZPHCrjPTcooicrUV
        7C5NrAKbusPmtJ1lXJSRW/ekYNZxUvc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-332-Gzxcgw1SNAyI_bowQgty2g-1; Mon, 20 Nov 2023 05:55:15 -0500
X-MC-Unique: Gzxcgw1SNAyI_bowQgty2g-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40853e14f16so10992385e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 02:55:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700477714; x=1701082514;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xSIGRF/7VBbZlLtEMWR+fp7S8tCj8dJX1So74Eiu2Zg=;
        b=dPQM5ERpZystT5jsb7eTryah/5rpVnyVPC2V3o3tEXy2Rcn2rkcS+oJYerog5ocw0V
         DPDTXh/A+mpbrTJ1vBa/+tDhC2Lq8jnPRci2rk4O35tyXHqHhfE90FpD96ZX3xxV/JJW
         wdFaAUHFChUbnQQ8CppUHT/D/h+lDMjFI9MNXKlqHw/dSgV5HvaVifR0LdIzoStsd1JP
         n5hnuP7YRn6Qsu3uIHHrMX5UdIC+Jk2GyIbuhgdJRkAJeYz4+jVuZElGmBhHHsWLRXE/
         j6XHsWO0cHghTJamzjV3cs66/YqUvjvAaI5pH0CaGdLlJoIWYLVqg/sxTME576YOs4P+
         dFRA==
X-Gm-Message-State: AOJu0YwT4J6SKlNGyVrMvz/Lo+azcjca75rGaAhNzJ6bQGosuO+pTd7z
        FYr+40ZUM57cFN5JqiIVNiJW3BmezI36RGz5i2mJUkOtnfA3vJKQNGFCq2upC3slNgvexPXAoUJ
        b6xBfixY94WsQGXslwP84FDIt
X-Received: by 2002:a05:600c:4289:b0:406:8496:bd8b with SMTP id v9-20020a05600c428900b004068496bd8bmr5056522wmc.9.1700477714094;
        Mon, 20 Nov 2023 02:55:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH0McoI7xSESM8bl+W66YBAk/AMaRM4vUIiYOo17Iy5QLcM986P3yoIU3IsHbmFHdqPMzPgGA==
X-Received: by 2002:a05:600c:4289:b0:406:8496:bd8b with SMTP id v9-20020a05600c428900b004068496bd8bmr5056500wmc.9.1700477713627;
        Mon, 20 Nov 2023 02:55:13 -0800 (PST)
Received: from ?IPV6:2003:cb:c746:7700:9885:6589:b1e3:f74c? (p200300cbc746770098856589b1e3f74c.dip0.t-ipconnect.de. [2003:cb:c746:7700:9885:6589:b1e3:f74c])
        by smtp.gmail.com with ESMTPSA id h18-20020a05600c351200b004063ea92492sm13154818wmq.22.2023.11.20.02.55.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Nov 2023 02:55:13 -0800 (PST)
Message-ID: <ae9b6a15-9f9a-45f3-bbe1-bfbbaa45f3b1@redhat.com>
Date:   Mon, 20 Nov 2023 11:55:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] mm: use vmem_altmap code without
 CONFIG_ZONE_DEVICE
Content-Language: en-US
To:     Sumanth Korikkar <sumanthk@linux.ibm.com>,
        linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Oscar Salvador <osalvador@suse.de>, Michal Hocko <mhocko@suse.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
References: <20231120102734.2001576-1-sumanthk@linux.ibm.com>
 <20231120102734.2001576-4-sumanthk@linux.ibm.com>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20231120102734.2001576-4-sumanthk@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.11.23 11:27, Sumanth Korikkar wrote:
> vmem_altmap_free() and vmem_altmap_offset() could be utlized without
> CONFIG_ZONE_DEVICE enabled. For example,
> mm/memory_hotplug.c:__add_pages() relies on that.  The altmap is no
> longer restricted to ZONE_DEVICE handling, but instead depends on
> CONFIG_SPARSEMEM_VMEMMAP.
> 
> When CONFIG_SPARSEMEM_VMEMMAP is disabled, these functions are defined
> as inline stubs, ensuring compatibility with configurations that do not
> use sparsemem vmemmap. Without it, lkp reported the following:
> 
> ld: arch/x86/mm/init_64.o: in function `remove_pagetable':
> init_64.c:(.meminit.text+0xfc7): undefined reference to
> `vmem_altmap_free'
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202311180545.VeyRXEDq-lkp@intel.com/
> Reviewed-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
> Signed-off-by: Sumanth Korikkar <sumanthk@linux.ibm.com>

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

