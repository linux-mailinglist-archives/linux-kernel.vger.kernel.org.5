Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B25F179811B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 06:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234258AbjIHEFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 00:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjIHEFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 00:05:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7279B1BDD
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 21:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694145853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ed95vriQHpXReZjDMNfNfOb0Q+DBcSF6XUux9f7rbg4=;
        b=baqkmp/ej4+1x1FwNZHxrI1JdVznb9AGyjwHMKwAmpw0RNYGCwoG+CRm5yjhca8xyMiuJe
        pfM4Ml0+7qXWkyPLaqH7f0TTa2QN0+iAx7BbZ5uGiL2LyE72NvNlrG1mdwpaODPWKKq5L2
        g2Rfprn2wMZKnmSBtEDs2rFEP9n2L6M=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-464-iPXxLeQ6Ow2EilSIY3zrWA-1; Fri, 08 Sep 2023 00:04:12 -0400
X-MC-Unique: iPXxLeQ6Ow2EilSIY3zrWA-1
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-1ca47197311so2143033fac.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 21:04:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694145851; x=1694750651;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ed95vriQHpXReZjDMNfNfOb0Q+DBcSF6XUux9f7rbg4=;
        b=FrlJwGgpkrfpUSs1i7Yg1+dHave4pB8XaeAoQ9EjeK7bAAUDOj2hIj4SjnFiTiMZxQ
         igPISSX1/Dig+i5NbKnjcwFpyPqpr4aguX2Uv8Tdxrc1CER+Rin25O1mo6I521EFIjmX
         /5HpvJOLStUt03NxA4qdafzFoFWBiVlxEp+0JXAIghsMui9t53iWw2NQylxISmpm3FBF
         kYi8Yx5MWci8ZD8C/xXVCE5baiy5X4fLuvhRPSjmshq3rSvZyfz3Lbmj7Q/5Lq2lLh1D
         5cbLDH+y/QsiyGhdVJAYl75CQva/FPkY0aZO2kLeQrj31ieP43vhkKnW620s3DNkzAYH
         wGCA==
X-Gm-Message-State: AOJu0YyJXUOnKaTuEqaZkieKEs0TtYa8yUceJVd+bvIv3XnOM5lbzjIM
        jDPQO4Q7cC/TS6fKrzoFDazSRCYdQhaCmU2EdVnXn1xxvqg3NdNogtxNwxM7W2teLPnvjtXFaBo
        NqnQXN+A4eE465E1x0Ny+F0pn
X-Received: by 2002:a05:6870:d146:b0:1d5:15cc:cb67 with SMTP id f6-20020a056870d14600b001d515cccb67mr1728395oac.49.1694145851689;
        Thu, 07 Sep 2023 21:04:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVt53i28hWe5FVkws9aKFNYt7pnOb1q3LVlbAoelKg4jch1lVZMxTW9gRQgouhlu6jCb908Q==
X-Received: by 2002:a05:6870:d146:b0:1d5:15cc:cb67 with SMTP id f6-20020a056870d14600b001d515cccb67mr1728381oac.49.1694145851417;
        Thu, 07 Sep 2023 21:04:11 -0700 (PDT)
Received: from redhat.com ([38.15.60.12])
        by smtp.gmail.com with ESMTPSA id u11-20020a02aa8b000000b0042b0a6d899fsm233194jai.60.2023.09.07.21.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 21:04:10 -0700 (PDT)
Date:   Thu, 7 Sep 2023 22:04:10 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     ankita@nvidia.com, yishaih@nvidia.com,
        shameerali.kolothum.thodi@huawei.com, kevin.tian@intel.com,
        aniketa@nvidia.com, cjia@nvidia.com, kwankhede@nvidia.com,
        targupta@nvidia.com, vsethi@nvidia.com, acurrid@nvidia.com,
        apopple@nvidia.com, jhubbard@nvidia.com, danw@nvidia.com,
        anuaggarwal@nvidia.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v8 1/1] vfio/nvgpu: Add vfio pci variant module for
 grace hopper
Message-ID: <20230907220410.31c6c2ab.alex.williamson@redhat.com>
In-Reply-To: <ZPpsIU3vAcfFh2e6@nvidia.com>
References: <20230825124138.9088-1-ankita@nvidia.com>
        <20230907135546.70239f1b.alex.williamson@redhat.com>
        <ZPpsIU3vAcfFh2e6@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Sep 2023 21:34:41 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Thu, Sep 07, 2023 at 01:55:46PM -0600, Alex Williamson wrote:
> 
> > There's perhaps an argument whether userspace should compose this
> > device itself, for example finding the firmware attributes in sysfs and
> > directly mmap'ing the coherent memory via /dev/mem to back a virtual
> > BAR or otherwise pass-through this associated region.    
> 
> I don't think this works, secure boot turns off /dev/mem and other
> things that would let you do this AFAIK.

Yep, it's got issues, just trying to play devil's advocate for a
non-kernel approach.

> > I've previously raised the point whether the coherent region here
> > might be exposed as a device specific region (such as we do for the
> > above IGD regions) rather than a virtual BAR, but the NVIDIA folks feel
> > strongly that the BAR approach is correct.  
> 
> I think it really depends on what the qemu side wants to do..

Ok, I thought you had been one of the proponents of the fake BAR
approach as more resembling CXL.  Do we need to reevaluate that the
tinkering with the VM machine topology and firmware tables would better
align to a device specific region that QEMU inserts into the VM address
space so that bare metal and virtual machine versions of this device
look more similar?  Thanks,

Alex

