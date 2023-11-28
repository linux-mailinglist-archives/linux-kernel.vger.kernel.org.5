Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58BF77FCB06
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 00:52:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376637AbjK1XwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 18:52:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjK1XwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 18:52:10 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0DB1988
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 15:52:16 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6d7eb7ff384so3991052a34.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 15:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1701215536; x=1701820336; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KGeDrNEnimmhtGEyy4xADkNVo65XsrpvCKCPlUM9+8M=;
        b=m3IVwR2oyDwf9bDurHvyXgUEDv38joPWYYywCYsLXcvaCtUyChVXEsFDLqmlrj9tR9
         6SsODG8fd1f7lMOFwx/GLB+Rne1Rp1UofI867dJ+XX6AjWKu24p4qaTPmIvLhoYMR1qx
         HTwFeKWnNZ6h/t1W+3U9AOGUpypBu/RYzMePLZl2s4BMSHLiMkWvvD84lSSpQZQEoYdd
         bn+tyPDPDD1oMlRdA7u8XHP61sAIw5rqEDj/9T4sg3cc/o8t94dm84VBVMq9L+dbXkWD
         nUi/JL0VL5RaviK4pV1E3QEbDy/DmfWL+79AA+iGvWu6lAUAZG5g7uGDy/lJb/AWT/eY
         NMHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701215536; x=1701820336;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KGeDrNEnimmhtGEyy4xADkNVo65XsrpvCKCPlUM9+8M=;
        b=BT3NALL4rFFknqBkYdBkE+6tvCXAkeaBMvfyGr8EE2KCXG/3vcuLnaY6SFYmYSZcZN
         6KHRNbpzEvxbvNO3zNzgcc+apvlu9Ffo7os+2lARaFS+cXzOC+XddInJvDJtHF+YqlPu
         lgo4XFkJ15rXTp82cTA0YTt5dpi1CE6LlCxcsCltHs1YBdzWeLGwEl3WQfQDWvtsvCwx
         6Drx7jVEPwfYO5+MlNY/3x3/ovRd8jVavTm6tjzJZPUw/psdNZWIkDZw7hNLl+tWRulq
         1DiZQrhSp7EI6o645m7V6i/JiuiPlNoc/xmb1HA0FiRpvrLPG+J9tQ6d08sK7L64jmVN
         rYxA==
X-Gm-Message-State: AOJu0YwwG48ARRPdeQSCwdYorx2E8VDUuUZAcTj/iOa7Eq5HWQtYRwgy
        /jWaefEOMEPxaB+lLmCuJ1v/9A==
X-Google-Smtp-Source: AGHT+IH9LmWzJO7y47O3QlJBfbaegvjW4JiiPSyZGlFsMKhzquzPk2K8a5k6oldvIY99Eeb+EHerAg==
X-Received: by 2002:a9d:6403:0:b0:6d6:4972:b7ae with SMTP id h3-20020a9d6403000000b006d64972b7aemr18597902otl.13.1701215536183;
        Tue, 28 Nov 2023 15:52:16 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id v10-20020a056830140a00b006d834fd3399sm504997otp.59.2023.11.28.15.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 15:52:15 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1r87sE-005jI0-V5;
        Tue, 28 Nov 2023 19:52:14 -0400
Date:   Tue, 28 Nov 2023 19:52:14 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Pasha Tatashin <pasha.tatashin@soleen.com>,
        akpm@linux-foundation.org, alex.williamson@redhat.com,
        alim.akhtar@samsung.com, alyssa@rosenzweig.io,
        asahi@lists.linux.dev, baolu.lu@linux.intel.com,
        bhelgaas@google.com, cgroups@vger.kernel.org, corbet@lwn.net,
        david@redhat.com, dwmw2@infradead.org, hannes@cmpxchg.org,
        heiko@sntech.de, iommu@lists.linux.dev, jasowang@redhat.com,
        jernej.skrabec@gmail.com, jonathanh@nvidia.com, joro@8bytes.org,
        kevin.tian@intel.com, krzysztof.kozlowski@linaro.org,
        kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-tegra@vger.kernel.org, lizefan.x@bytedance.com,
        marcan@marcan.st, mhiramat@kernel.org, mst@redhat.com,
        m.szyprowski@samsung.com, netdev@vger.kernel.org,
        paulmck@kernel.org, rdunlap@infradead.org, robin.murphy@arm.com,
        samuel@sholland.org, suravee.suthikulpanit@amd.com,
        sven@svenpeter.dev, thierry.reding@gmail.com, tj@kernel.org,
        tomas.mudrunka@gmail.com, vdumpa@nvidia.com,
        virtualization@lists.linux.dev, wens@csie.org, will@kernel.org,
        yu-cheng.yu@intel.com
Subject: Re: [PATCH 00/16] IOMMU memory observability
Message-ID: <20231128235214.GD1312390@ziepe.ca>
References: <20231128204938.1453583-1-pasha.tatashin@soleen.com>
 <CAJD7tkb1FqTqwONrp2nphBDkEamQtPCOFm0208H3tp0Gq2OLMQ@mail.gmail.com>
 <CA+CK2bB3nHfu1Z6_6fqN3YTAzKXMiJ12MOWpbs8JY7rQo4Fq0g@mail.gmail.com>
 <CAJD7tkZZNhf4KGV+7N+z8NFpJrvyeNudXU-WdVeE8Rm9pobfgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tkZZNhf4KGV+7N+z8NFpJrvyeNudXU-WdVeE8Rm9pobfgQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 03:03:30PM -0800, Yosry Ahmed wrote:
> > Yes, another counter for KVM could be added. On the other hand KVM
> > only can be computed by subtracting one from another as there are only
> > two types of secondary page tables, KVM and IOMMU:
> >
> > /sys/devices/system/node/node0/meminfo
> > Node 0 SecPageTables:    422204 kB
> >
> >  /sys/devices/system/node/nodeN/vmstat
> > nr_iommu_pages 105555
> >
> > KVM only = SecPageTables - nr_iommu_pages * PAGE_SIZE / 1024
> >
> 
> Right, but as I mention above, if userspace starts depending on this
> equation, we won't be able to add any more classes of "secondary" page
> tables to SecPageTables. I'd like to avoid that if possible. We can do
> the subtraction in the kernel.

What Sean had suggested was that SecPageTables was always intended to
account all the non-primary mmu memory used by page tables. If this is
the case we shouldn't be trying to break it apart into finer
counters. These are big picture counters, not detailed allocation by
owner counters.

Jason
