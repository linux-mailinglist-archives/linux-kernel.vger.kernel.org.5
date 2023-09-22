Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6407ABC5F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 01:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbjIVXdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 19:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbjIVXdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 19:33:18 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33AFD19E
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 16:33:12 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-d81adf0d57fso3544933276.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 16:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1695425591; x=1696030391; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+8rKKRCqUyQLWkNEBe6s/yUPdVExxmOivIwMSOHwl/8=;
        b=esoDGfRl/b0lsZuxZqaRrYraARBiayqHpUe+1x1yIM+09U9/+s4SX6cG1M2z1pJYuy
         hPXB7axJccYjMv+suop2/Psr+t93JN2nLx10dKL16wLbLSCcO0gq3bwqv3ubUomhT1z2
         NnioXkKNMfgqqsg9MOZphrAv7nqiAQiDGdLNOYckooj3s+wYOYGmqMHYuI0eBqgGiSA4
         MURQboZHOzR7Q5mRwaiigJ+Bc66mxgeMZ8cL7nUIO3NH8ydSJqP+BZ6leGSDHQ8iJhPq
         7TMF2rwq7WRHLbIRP81/7dRbe339HmOjK37FP63DiEQ5FbiYcqk3fNyHgl1Sj4QtUDOp
         QKNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695425591; x=1696030391;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+8rKKRCqUyQLWkNEBe6s/yUPdVExxmOivIwMSOHwl/8=;
        b=agt0xvlefms4f3BWwwxhY88P4rmRZcLcS5RDQ3rMgQ8Ij1pA+Y+YmcgLhGCHCqDpG5
         uaU0YE+iEv7Z/YNn7oEISmGGzrtIAh79mVCoW1IEzPqYAD4BRoaQA9sMQ31qIrVH6Otp
         ya6Vahuf7oF3Pw+3BCshYluGuTkprjJWw4ytYsUIRLrRXqRHXqUsStGSNbRfekk944w5
         yWCKRGYiHPiKdpO9yMG69W08QaIxitWCcydvPUfGVC47p6KBm1prUYA18bI++FMhXz5q
         KkK7Nbkk2F+BSGVoKtXmNn86XzYaZ4MhsgZvbP1rR7EWohGRSdhOXJWsdQewTdSb1d6n
         rS8g==
X-Gm-Message-State: AOJu0Yy8wZSVmX1CmfWuNbO7JFccx6yxJhLA21gh/hyHpwbSlCDDZ9Eg
        kkuvrXkz1hVpJjfntuHKD/lmBLi1IfZB5MYd8m0=
X-Google-Smtp-Source: AGHT+IHXIm3CPio25fJfcUEZEUoMW195I/INyvWWRxd2/4S04spIkfTN65/K48HdwB4EwzmNKU/gPg==
X-Received: by 2002:a25:dbcc:0:b0:d81:4168:3a83 with SMTP id g195-20020a25dbcc000000b00d8141683a83mr680844ybf.25.1695425591345;
        Fri, 22 Sep 2023 16:33:11 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id i15-20020a0cf10f000000b0064f523836fdsm1838074qvl.123.2023.09.22.16.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 16:33:10 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qjpe1-000eFO-UF;
        Fri, 22 Sep 2023 20:33:09 -0300
Date:   Fri, 22 Sep 2023 20:33:09 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        virtualization@lists.linux-foundation.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] iommu/virtio: Make use of ops->iotlb_sync_map
Message-ID: <20230922233309.GI13795@ziepe.ca>
References: <20230918-viommu-sync-map-v2-0-f33767f6cf7a@linux.ibm.com>
 <20230918-viommu-sync-map-v2-1-f33767f6cf7a@linux.ibm.com>
 <ae7e513b-eb86-97e2-bed0-3cca91b8c959@arm.com>
 <20230919081519.GA3860249@myrica>
 <20230919144649.GT13795@ziepe.ca>
 <20230922075719.GB1361815@myrica>
 <20230922124130.GD13795@ziepe.ca>
 <900b644e-6e21-1038-2252-3dc86cbf0a32@arm.com>
 <20230922162714.GH13795@ziepe.ca>
 <123c53c3-d259-9c20-9aa6-0c216d7eb3c0@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <123c53c3-d259-9c20-9aa6-0c216d7eb3c0@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 07:07:40PM +0100, Robin Murphy wrote:

> virtio isn't setting ops->pgsize_bitmap for the sake of direct mappings
> either; it sets it once it's discovered any instance, since apparently it's
> assuming that all instances must support identical page sizes, and thus once
> it's seen one it can work "normally" per the core code's assumptions. It's
> also I think the only driver which has a "finalise" bodge but *can* still
> properly support map-before-attach, by virtue of having to replay mappings
> to every new endpoint anyway.

Well it can't quite do that since it doesn't know the geometry - it
all is sort of guessing and hoping it doesn't explode on replay. If it
knows the geometry it wouldn't need finalize...

> > What do you think about something like this to replace
> > iommu_create_device_direct_mappings(), that does enforce things
> > properly?
> 
> I fail to see how that would make any practical difference. Either the
> mappings can be correctly set up in a pagetable *before* the relevant device
> is attached to that pagetable, or they can't (if the driver doesn't have
> enough information to be able to do so) and we just have to really hope
> nothing blows up in the race window between attaching the device to an empty
> pagetable and having a second try at iommu_create_device_direct_mappings().
> That's a driver-level issue and has nothing to do with pgsize_bitmap either
> way.

Except we don't detect this in the core code correctly, that is my
point. We should detect the aperture conflict, not pgsize_bitmap to
check if it is the first or second try.

Jason
