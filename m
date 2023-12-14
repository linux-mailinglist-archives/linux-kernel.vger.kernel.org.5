Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32410813940
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 19:00:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235629AbjLNR74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 12:59:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbjLNR7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 12:59:54 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60739CF
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 09:59:59 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1d0b40bb704so5935ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 09:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702576799; x=1703181599; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PZ9x6kLcBYiEdBJWGUfxINmlIVM3g2sEltrcooCIdH0=;
        b=db3UtXdY8aBQieI3huxs2sGIoL44TLlJEKvRJ9MvuvbUxHU3JVbetHrCOko0PxaYDd
         SQzKmE6QChugPbwUT8s/lxkPf0UkAvt13KrFtZEXZX4rMQQ650K0dr3DZdsC3NRgB36i
         pBHhOCpCZ3YMqMvG6wGirj87knntUgZv78I8GG5CeRAJcy1ANUplXaVb8+Y5jpz0dz+l
         xnzL/RKfGWhpmAsEroo7eEdvUqC+IZ2x6mUqhBBS8m17QwES3aBg/C28cZhbTAzVNMwY
         udJ6WpTCp61nq+q2eb+sqa8Fv5xeOHLW8EmjI0dSzAwryZO613j/HxQP66J/x51yjoM5
         64oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702576799; x=1703181599;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PZ9x6kLcBYiEdBJWGUfxINmlIVM3g2sEltrcooCIdH0=;
        b=kmjUw/m1KyxA3ELYs7P8uxTEry5Dzr4pG2cnDUp1cO/kXJhtAAVU9HTlZvsae7hbmy
         LmZj5ECYpKhsHdvFfK3+wedXEEum5lJg/tJFH1bDoOuexCoKjOns2WNLy/JZ1QjYryi2
         FS4kzvfLgwooTsDEx1vUNoIxeMfyA7pSvYtRGh/EU1cx9FjpsAgDNeK/zcBGys82RF+t
         4hdzXtIMToPrSa8cq5GJmRY5Z2OeSIFKZuaPmSi7a3Pe3/VADuVny3PRGCW1biIYH7mu
         GhtRDsgpEgbml+BSzvXEajJpInPrCeM0zOZZTzaUGv4DrAX+FcJGVRa4dwK7Xvw8nRSB
         oeKQ==
X-Gm-Message-State: AOJu0Yyu1ar9MqoC3yE/ePDv7ZHUzj57YcZPkveoZWjSVzEMmRTUgAo5
        gk5okll/2sZ6nm5j9vnJynHUrQ==
X-Google-Smtp-Source: AGHT+IH5RplbwvbCKQv+ptuR7ZWj127uLmsE7SQkvEwRe0Gbuexa/KME9clMyovQW6MkVTsfPUZxog==
X-Received: by 2002:a17:902:d2d2:b0:1d3:7d54:be3d with SMTP id n18-20020a170902d2d200b001d37d54be3dmr49997plc.6.1702576798577;
        Thu, 14 Dec 2023 09:59:58 -0800 (PST)
Received: from [2620:0:1008:15:740b:4c24:bdb6:a42a] ([2620:0:1008:15:740b:4c24:bdb6:a42a])
        by smtp.gmail.com with ESMTPSA id y18-20020a170902b49200b001cfc2e0a82fsm12675679plr.26.2023.12.14.09.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 09:59:58 -0800 (PST)
Date:   Thu, 14 Dec 2023 09:59:57 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     Pasha Tatashin <pasha.tatashin@soleen.com>
cc:     akpm@linux-foundation.org, alim.akhtar@samsung.com,
        alyssa@rosenzweig.io, asahi@lists.linux.dev,
        baolu.lu@linux.intel.com, bhelgaas@google.com,
        cgroups@vger.kernel.org, corbet@lwn.net, david@redhat.com,
        dwmw2@infradead.org, hannes@cmpxchg.org, heiko@sntech.de,
        iommu@lists.linux.dev, jernej.skrabec@gmail.com,
        jonathanh@nvidia.com, joro@8bytes.org,
        krzysztof.kozlowski@linaro.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-tegra@vger.kernel.org, lizefan.x@bytedance.com,
        marcan@marcan.st, mhiramat@kernel.org, m.szyprowski@samsung.com,
        paulmck@kernel.org, rdunlap@infradead.org, robin.murphy@arm.com,
        samuel@sholland.org, suravee.suthikulpanit@amd.com,
        sven@svenpeter.dev, thierry.reding@gmail.com, tj@kernel.org,
        tomas.mudrunka@gmail.com, vdumpa@nvidia.com, wens@csie.org,
        will@kernel.org, yu-cheng.yu@intel.com
Subject: Re: [PATCH v2 09/10] iommu: observability of the IOMMU allocations
In-Reply-To: <20231130201504.2322355-10-pasha.tatashin@soleen.com>
Message-ID: <88519685-abfb-e2f8-38b4-d94340b40d1d@google.com>
References: <20231130201504.2322355-1-pasha.tatashin@soleen.com> <20231130201504.2322355-10-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Nov 2023, Pasha Tatashin wrote:

> Add NR_IOMMU_PAGES into node_stat_item that counts number of pages
> that are allocated by the IOMMU subsystem.
> 
> The allocations can be view per-node via:
> /sys/devices/system/node/nodeN/vmstat.
> 
> For example:
> 
> $ grep iommu /sys/devices/system/node/node*/vmstat
> /sys/devices/system/node/node0/vmstat:nr_iommu_pages 106025
> /sys/devices/system/node/node1/vmstat:nr_iommu_pages 3464
> 
> The value is in page-count, therefore, in the above example
> the iommu allocations amount to ~428M.
> 
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Acked-by: David Rientjes <rientjes@google.com>
