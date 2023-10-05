Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8886B7BA976
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 20:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbjJESub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 14:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbjJESuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 14:50:23 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A7A1A7
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 11:50:15 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-d865854ef96so1426185276.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 11:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1696531814; x=1697136614; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z/15YjTNGO7/laG0/KUBKbnKqMvDPAnAc/F84yDPFqo=;
        b=JL3XZzyfgwmi2r2TClLacdQcIBCCEnjTgXIOMpBROXQjGKDHRQZG5KaNfVIy7Y8TGB
         IN7qyBpNKmxGPTtmAfWElPFQfWhhoq+XeSO/Fm9DuK//0x65238aU/cwVKJ/oZNKdrAI
         NIGams+sV4uK+z7EzcgVw+ZuFL37GuMbHjweeh8qOds8yRDNCihVD1JCE2gZ8cnwC7TU
         XhYdWNAE6wvA8nygTZdXAHDIocRpB0hoS8KRPKeSjYFyHtL43ErQIuDI/hRt9FttgQ4y
         GzxLeIUQLIJz2Lu6gTCezor/ZOh7V6dXp7V2/wbWZZV7KMvzq/yMKvddLxx3GVLpfbe/
         yzyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696531814; x=1697136614;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z/15YjTNGO7/laG0/KUBKbnKqMvDPAnAc/F84yDPFqo=;
        b=DeXFN5DCDhuAePQ1AHahJlNrF/EBzNM4zl+lcMfn3/kWMBSHLiUy0EPypYg8y+uJSS
         996NPKYzjjrAh+Sa9xXxHIl5YLwY95KLQleP/slGtJCgN5GqbfIUhmJQzR8q6H1e4y/s
         opX7TGzTv8ZE0IhsvOfsY3sWCsst2UwFa+DBEu/arjJfj7/gQDIp1gf53Y6zAhNThDye
         EMtkdfmZLgo5KFG7fdx09MniWh4/wzLWABdeqsxTTA4QzUa8BhtqqhByB6NUaiQHZkjH
         HnxXMAzGdF5vJ0xeuf8yiKOg5uXzwG5XtbSNqAmHghARdSgEBUK4rVnF8HyD+VcaUyBh
         OELA==
X-Gm-Message-State: AOJu0YwzC3ZeEEaig/FGlDWG/WklvNwQadkErziqPO2Xln+z7Ib4pzzG
        sGZKSfC7KuVXDlF2RULHBhHLjQ==
X-Google-Smtp-Source: AGHT+IE9vkjVIAkLcNbgY+36PhAH/k/F6DOzSR5t+bI4gIxK41GHXUo5VmRj4PtH+H/Mr0bYRrvrAA==
X-Received: by 2002:a25:8b84:0:b0:d09:34f4:6698 with SMTP id j4-20020a258b84000000b00d0934f46698mr5277131ybl.36.1696531813823;
        Thu, 05 Oct 2023 11:50:13 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id u21-20020a0cb415000000b0065b0771f2edsm711107qve.136.2023.10.05.11.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 11:50:13 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qoTQK-004Z8M-TB;
        Thu, 05 Oct 2023 15:50:12 -0300
Date:   Thu, 5 Oct 2023 15:50:12 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Tina Zhang <tina.zhang@intel.com>
Cc:     Kevin Tian <kevin.tian@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Michael Shavit <mshavit@google.com>,
        Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 6/6] mm: Deprecate pasid field
Message-ID: <20231005185012.GW13795@ziepe.ca>
References: <20230925023813.575016-1-tina.zhang@intel.com>
 <20230925023813.575016-7-tina.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230925023813.575016-7-tina.zhang@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 10:38:13AM +0800, Tina Zhang wrote:
> Drop the pasid field, as all the information needed for sva domain
> management has been moved to the newly added iommu_mm field.
> 
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
> Signed-off-by: Tina Zhang <tina.zhang@intel.com>
> ---
>  include/linux/mm_types.h | 1 -
>  mm/init-mm.c             | 3 ---
>  2 files changed, 4 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
