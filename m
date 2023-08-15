Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B706277CE2F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 16:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237662AbjHOOfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 10:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237666AbjHOOel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 10:34:41 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2DCD93
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 07:34:39 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-688769faa09so170962b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 07:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1692110079; x=1692714879;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mk5Xa7cyeVl1bluWvoXLKdqUAVMQrPcF9EQrApvXWHE=;
        b=U/G7HXJhlv9yn9z1NYj9jDW7/1AAb8yB79vOJK7v78ivtTnBlTcEpgDvKWF5y/NhPS
         GpJMzmsdoh6FhJqrNrtWUU8TnMqpmYViri2nqHhVVLmaG0t65i1QxYxhVmWha6AUIyr0
         3qjJSSXw6JtxgZ9otCLrmRisFh66LKVzrdN/z031ki81CXskjtXltILv/WW3/eeiCta5
         dn+7/MM8A+Cd7dsvia1YnnXADru+vDih2poDzID0R3lfJ8llIEstDvU6+ngVmAhpo97c
         EGPB/FmVHbzziLzxGC+7NaeFdgu0jY9R5CG7kadUbCkcMa3eexZI9nB+UlFaXwQpk6oj
         lR4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692110079; x=1692714879;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mk5Xa7cyeVl1bluWvoXLKdqUAVMQrPcF9EQrApvXWHE=;
        b=Jf5NNjp5d5iSu9J8Z+n0KxgI3FzDyaP0kWZWrAp/VD1X5Cia1k7N/wUNg1mw4r0hQH
         MDujULBpuEDWc1kdfxaUD1hTK0ca+zz/y0IQ4WahlEb0EG9XsOGAYUBFjX8FAARfjhKo
         vPkx8MjN6tem3TGvzFI8MSOKZSOdna/4EYvEP0v1EPCKghgCVmgFCffZNNBwOiy1Nq0k
         XE0ZNEwMad3/TbZp+qi8x2Oew80NMLkCOjkBUxtbWjGxVL/a5eluqgLlpTzhxAdP0h0p
         W3/3UFEQ4+Qv8qlZiKNxHPTpHU+VlDxKHg8TFkSWZ5oU2/DUtSrhsmZHSXgkkbN5mooj
         rUYA==
X-Gm-Message-State: AOJu0Yzc9hTCNAsF5/9fqZmEUUuPXMkO6oA2Mn351NVViW3Twic2iGOr
        r3iUZFcWVAS6Ozx1pqT4StXF5A==
X-Google-Smtp-Source: AGHT+IHouB+tRrvRfpm5u59T/dtmJVgPNdzASQuv8oarIfDSYFlhLff7Ef3Yqu55vCGrO0FZPHhJXw==
X-Received: by 2002:a05:6a00:3a12:b0:687:3e8f:2211 with SMTP id fj18-20020a056a003a1200b006873e8f2211mr12162427pfb.34.1692110079248;
        Tue, 15 Aug 2023 07:34:39 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id q1-20020a63bc01000000b00565eb4fa8d1sm232221pge.16.2023.08.15.07.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 07:34:38 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qVv7z-007bam-SR;
        Tue, 15 Aug 2023 11:34:35 -0300
Date:   Tue, 15 Aug 2023 11:34:35 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jie Ji <jijie.ji@linux.alibaba.com>
Cc:     dwmw2@infradead.org, baolu.lu@linux.intel.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, xianting.tian@linux.alibaba.com,
        kaijieguo@linux.alibaba.com, daishengdong@yeah.net
Subject: Re: [PATCH] iommu/vt-d: Atomic breakdown of IOPT into finer
 granularity
Message-ID: <ZNuM+3R197oRfBer@ziepe.ca>
References: <20230814121016.32613-1-jijie.ji@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814121016.32613-1-jijie.ji@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 08:10:16PM +0800, Jie Ji wrote:
> With the addition of IOMMU support for IO page fault, it's now possible
> to unpin the memory which DMA remapping. However, the lack of support
> for unmapping a subrange of the I/O page table (IOPT) in IOMMU can lead
> to some issues.
> 
> For instance, a virtual machine can establish IOPT of 2M/1G for better
> performance, while the host system enable swap and attempts to swap out
> some 4K pages. Unfortunately, unmap subrange of the large-page mapping
> will make IOMMU page walk to error level, and finally cause kernel crash.

Nothing in-kernel does something like this.

Jason
