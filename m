Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64475807A8F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 22:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbjLFVfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 16:35:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbjLFVfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 16:35:41 -0500
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F93098;
        Wed,  6 Dec 2023 13:35:46 -0800 (PST)
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6d9d21959aaso150889a34.2;
        Wed, 06 Dec 2023 13:35:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701898545; x=1702503345;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bUl/NKtFWY2Pbxm24jhjwpwyECFZQPzTNZTNK5JPvSo=;
        b=hnXaAU2AuAhrz8U9ShrH4M2Y/U6T4h04qH1Cpd2fqRz3Z8UxBAAEN55sufyv6dfn5O
         Qd84nHen+GOdtp4/5Ak6CYXk0A+7MYMVIL51oCzy8EJ/G6NnElkAmVmMrykWteAoTRDj
         3Df7XDjfqKaPGeIpEoIfz9tmUirb7WV0yqlWCgxhKcSFXRcogjv/b2MvkChfS1hJWsIp
         8lYgBkWkvQp0eNbm9A1uvz7LDBi0m6ndiYc+KSOJP+OTeqki52q/2GJ4UMObITEy2Des
         wDBbld1ZH++GdNDS/jzWWc7kF5DS4L2eQjYTFDcSrdtc+UnM9N4ErnJxdK9bzK78wz7F
         tOpA==
X-Gm-Message-State: AOJu0YzdR0RgcMX6j26SNMqXRACEf+Qk/xoe9aJFSyicCeX+QSevoyYH
        iqxwAP63J0YVWm8FbKjJuA==
X-Google-Smtp-Source: AGHT+IGHBQtY2ZCMQH40OjOJ13+Qp+jdVac/J+rmapcPibZzkALYHXrCY/oe6cfQHnvMLu7oUDa+xg==
X-Received: by 2002:a05:6870:7e01:b0:1fb:75b:2baf with SMTP id wx1-20020a0568707e0100b001fb075b2bafmr1430168oab.107.1701898545570;
        Wed, 06 Dec 2023 13:35:45 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id x4-20020a05683000c400b006d8811cbc3csm116925oto.29.2023.12.06.13.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 13:35:45 -0800 (PST)
Received: (nullmailer pid 3364587 invoked by uid 1000);
        Wed, 06 Dec 2023 21:35:43 -0000
Date:   Wed, 6 Dec 2023 15:35:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     Oreoluwa Babatunde <quic_obabatun@quicinc.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, frowand.list@gmail.com,
        dinguyen@kernel.org, chenhuacai@kernel.org,
        tsbogend@alpha.franken.de, jonas@southpole.se,
        stefan.kristiansson@saunalahti.fi, shorne@gmail.com,
        mpe@ellerman.id.au, ysato@users.sourceforge.jp, dalias@libc.org,
        glaubitz@physik.fu-berlin.de, richard@nod.at,
        anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net,
        chris@zankel.net, jcmvbkbc@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        kernel@quicinc.com
Subject: Re: [RFC PATCH v2 0/6] Dynamic allocation of reserved_mem array.
Message-ID: <20231206213543.GB3345785-robh@kernel.org>
References: <20231204185409.19615-1-quic_obabatun@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204185409.19615-1-quic_obabatun@quicinc.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2023 at 10:54:03AM -0800, Oreoluwa Babatunde wrote:
> The reserved_mem array is used to store the data of the different
> reserved memory regions specified in the DT of a device.
> The array stores information such as the name, node, starting address,
> and size of a reserved memory region.
> 
> The array is currently statically allocated with a size of
> MAX_RESERVED_REGIONS(64). This means that any system that specifies a
> number of reserved memory regions greater than MAX_RESERVED_REGIONS(64)
> will not have enough space to store the information for all the regions.
> 
> Therefore, this series extends the use of a static array for
> reserved_mem, and introduces a dynamically allocated array using
> memblock_alloc() based on the number of reserved memory regions
> specified in the DT.
> 
> Memory gotten from memblock_alloc() is only writable after paging_init()
> is called, but the reserved memory regions need to be reserved before
> then so that the system does not create page table mappings for them.
> 
> Reserved memory regions can be divided into 2 groups.
> i) Statically-placed reserved memory regions
> i.e. regions defined in the DT using the @reg property.
> ii) Dynamically-placed reserved memory regions.
> i.e. regions specified in the DT using the @alloc_ranges
>     and @size properties.
> 
> It is possible to call memblock_reserve() and memblock_mark_nomap() on
> the statically-placed reserved memory regions and not need to save them
> to the array until after paging_init(), but this is not possible for the
> dynamically-placed reserved memory because the starting address of these
> regions need to be stored somewhere after they are allocated.
> 
> Therefore, this series achieves the allocation and population of the
> reserved_mem array in two steps:
> 
> 1. Before paging_init()
>    Before paging_init() is called, iterate through the reserved_mem
>    nodes in the DT and do the following:
>    - Allocate memory for dynamically-placed reserved memory regions and
>      store their starting address in the static allocated reserved_mem
>      array.
>    - Call memblock_reserve() and memblock_mark_nomap() on all the
>      reserved memory regions as needed.
>    - Count the total number of reserved_mem nodes in the DT.
> 
> 2. After paging_init()
>    After paging_init() is called:
>    - Allocate new memory for the reserved_mem array based on the number
>      of reserved memory nodes in the DT.
>    - Transfer all the information that was stored in the static array
>      into the new array.
>    - Store the rest of the reserved_mem regions in the new array.
>      i.e. the statically-placed regions.
> 
> The static array is no longer needed after this point, but there is
> currently no obvious way to free the memory. Therefore, the size of the
> initial static array is now defined using a config option.

A config option is not going to work here.

> Because the array is used only before paging_init() to store the
> dynamically-placed reserved memory regions, the required size can vary
> from device to device. Therefore, scaling it can help get some memory
> savings.
> 
> A possible solution to freeing the memory for the static array will be
> to mark it as __initdata. This will automatically free the memory once
> the init process is done running.
> The reason why this is not pursued in this series is because of
> the possibility of a use-after-free.
> If the dynamic allocation of the reserved_mem array fails, then future
> accesses of the reserved_mem array will still be referencing the static
> array. When the init process ends and the memory is freed up, any
> further attempts to use the reserved_mem array will result in a
> use-after-free.

If memory allocation for the reserved_mem array fails so early in boot, 
you've got much bigger problems. Use __initdata, and just WARN if 
allocation fails and continue on (so hopefully the console is brought 
up and someone can see the WARN).

Rob
