Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75C9375D4ED
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 21:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbjGUT0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 15:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbjGUT0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 15:26:30 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4AFE3A82
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 12:26:19 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-2640a8ceefdso1308826a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 12:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1689967579; x=1690572379;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xr6a3wPaSbxEaGpekcRzvtgOYy20EpF6cLmCTWGM/d8=;
        b=PapxbFN9nlQZ0hbhKVwwawBN6LdJjW3Jxp3CpwEUvmqx8VSIfzvyAWjZmPM7Kc45gi
         qopDwV5z676Si5veJkfi0qrd8a5xaySsryWYloQnQkx318xKe2pYBW9+lqkzldmdemE1
         99prBRal3lq3NgQTCz4ZW//9sRY8xNIj5NBo9hLhMiknT0FEv9J2i7fnVBCc6RRf9Znf
         uwsKZ1RZ5VKXjQYWscKe/M+wHdFj68hEhUuwbDqS0RyuhUHk9xpOWf2qzUNm03raJDUF
         LRxvhcmz1Sp9N4r1u6RxuFKGIRB8KKPMrUgr5brHzLqEYPIE9mcLBomKV+bnZZ4ylsbl
         XTPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689967579; x=1690572379;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xr6a3wPaSbxEaGpekcRzvtgOYy20EpF6cLmCTWGM/d8=;
        b=AiipNefJ2qtHBnznakxIgFzgSPs9wBPkKUJ+Nu1OpoG4LupWmbtVTy3XnueCgMuzV1
         4drFuD/Rtr1/u7Y1zScPXE8NBzDb/TXisGlpGoPS+PF7VSawvJDfRvoHoGF6qDDvDGEO
         Ey3bBqmuvdq0fN3vScNHRZ+y+HhwNxnzmWpOvAyQ/Io52f2nnWuuvqWSCpt+ipPvKtAh
         egqtwlqzoF5tWTnVGfJ4F/Cc2g1ISLXFzEVSIivSK5C/A7zGvu+h62D8yxvWiftt2m+l
         wDpKBPrEkPcOjJqEHUbuNn/yqSrnOSves0BxhuT4YS6NnYMfxY+wAp2YWiCYn50m1ZFc
         gBgw==
X-Gm-Message-State: ABy/qLa17LaR9fVXChGyU79Ie6Yc8jRLkLchHOZusYtoy+f+GU1fiSew
        2BePWzkjlm6yfyeX/YLNkaUTzA==
X-Google-Smtp-Source: APBJJlGqDcvhn/GzUoUrWJEAu6LLTtj6nE8lbyEgpTLg48+TgijhmiTggNpW3leZ2HelRF+2igrYUQ==
X-Received: by 2002:a17:90a:bb09:b0:260:fd64:a20 with SMTP id u9-20020a17090abb0900b00260fd640a20mr2495306pjr.9.1689967579259;
        Fri, 21 Jul 2023 12:26:19 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id e23-20020a17090ab39700b002609cadc56esm2802248pjr.11.2023.07.21.12.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 12:26:18 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qMvlZ-003IDP-Dp;
        Fri, 21 Jul 2023 16:26:17 -0300
Date:   Fri, 21 Jul 2023 16:26:17 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Alistair Popple <apopple@nvidia.com>
Cc:     akpm@linux-foundation.org, ajd@linux.ibm.com,
        catalin.marinas@arm.com, fbarrat@linux.ibm.com,
        iommu@lists.linux.dev, jhubbard@nvidia.com, kevin.tian@intel.com,
        kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
        nicolinc@nvidia.com, npiggin@gmail.com, robin.murphy@arm.com,
        seanjc@google.com, will@kernel.org, x86@kernel.org,
        zhi.wang.linux@gmail.com, sj@kernel.org
Subject: Re: [PATCH v3 2/5] mmu_notifiers: Fixup comment in
 mmu_interval_read_begin()
Message-ID: <ZLrb2Xq/ZgDgVPNf@ziepe.ca>
References: <cover.b24362332ec6099bc8db4e8e06a67545c653291d.1689842332.git-series.apopple@nvidia.com>
 <06fa82756e4d6458895962a7743cc7f162658a54.1689842332.git-series.apopple@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06fa82756e4d6458895962a7743cc7f162658a54.1689842332.git-series.apopple@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 06:39:24PM +1000, Alistair Popple wrote:
> The comment in mmu_interval_read_begin() refers to a function that
> doesn't exist and uses the wrong call-back name. The op for mmu
> interval notifiers is mmu_interval_notifier_ops->invalidate() so fix
> the comment up to reflect that.
> 
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> ---
>  mm/mmu_notifier.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
