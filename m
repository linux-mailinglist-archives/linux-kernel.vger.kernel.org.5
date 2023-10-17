Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 167F17CD01C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 00:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344006AbjJQWzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 18:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233940AbjJQWzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 18:55:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56F6ED
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 15:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697583287;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2MaCWNFBz4u+icJNQE4+/xyS8E2y+prkl+CkqV9Oy3s=;
        b=dkd3QJB4esqH5sFufF7Wq6isDoyykwxjCVUmDdGukC3XwLf0ebqPX7CDPw5CjNm/OvdmBJ
        Y6bUjCy6HnyBr+226pvVYzeyvtWndVZo6QR/9N6a9AMkjuhgnsp+0JQVLoS7mB7Gv5Gh5q
        stH+0ES5PGSkwKyMnuNZ0UBX7imyMeI=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-ZDgQv243N1KMstI0KOigSQ-1; Tue, 17 Oct 2023 18:54:40 -0400
X-MC-Unique: ZDgQv243N1KMstI0KOigSQ-1
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-79fc1c4948aso468990739f.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 15:54:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697583280; x=1698188080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2MaCWNFBz4u+icJNQE4+/xyS8E2y+prkl+CkqV9Oy3s=;
        b=Hum8thAj9WcIiRORX4JRV9mdt3BpEmbUZXdDxS5ryAzZw57YzC8my/0+U6NhpmjfiO
         bY23Z6AIi2UOq7189wAbMIf1iTu1Gd7ejmBairDL7qQ1hYQlFoOTySsSRpO6Cg1laO9G
         WAN+DyhWXXiEnOS0Lhps5kTM1peUwjx9s1h5CNA7U4NCuc1tAXz9YB0pcg0nDcri9b65
         1ZKIarXwEvdGoJkL9WoGGHl6FvM6n8dtmgygRpNhdsc3Px/Hvi1BJE55DnJd7FwOyRBL
         KdroxFAjgzXk1sWR1VYMmiYO4wZbcDyeIJB5BD031+Yn98/m4uGAeWH7lJv0a6fT8ZVv
         BFWg==
X-Gm-Message-State: AOJu0YzKNnWyFPxJRove6uNhzZESAUXIfsEGiLb+d6tbyUIZYSw14HRU
        O21OcCJE1qxtFwMTmiHAaIPkiEEpramGs73099bWPQVqDNTpxYsmGTTzTwjF3RATXZFMwnEkAkj
        I330SfxPyJC5hNWCozQi/wOgP
X-Received: by 2002:a05:6602:14c4:b0:783:7275:9c47 with SMTP id b4-20020a05660214c400b0078372759c47mr4267800iow.7.1697583279936;
        Tue, 17 Oct 2023 15:54:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVlkSqh1AH0+o2hIeBFlVJRTmRnhiYLw2H0/wB2Zp9iEyPUwvVgGvJjUIM6bMQltqejAYEzQ==
X-Received: by 2002:a05:6602:14c4:b0:783:7275:9c47 with SMTP id b4-20020a05660214c400b0078372759c47mr4267774iow.7.1697583279691;
        Tue, 17 Oct 2023 15:54:39 -0700 (PDT)
Received: from redhat.com ([38.15.60.12])
        by smtp.gmail.com with ESMTPSA id c16-20020a5ea810000000b0079fd98bbe9bsm30159ioa.15.2023.10.17.15.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 15:54:39 -0700 (PDT)
Date:   Tue, 17 Oct 2023 16:54:37 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     <ankita@nvidia.com>
Cc:     <jgg@nvidia.com>, <yishaih@nvidia.com>,
        <shameerali.kolothum.thodi@huawei.com>, <kevin.tian@intel.com>,
        <aniketa@nvidia.com>, <cjia@nvidia.com>, <kwankhede@nvidia.com>,
        <targupta@nvidia.com>, <vsethi@nvidia.com>, <acurrid@nvidia.com>,
        <apopple@nvidia.com>, <jhubbard@nvidia.com>, <danw@nvidia.com>,
        <anuaggarwal@nvidia.com>, <kvm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v12 1/1] vfio/nvgpu: Add vfio pci variant module for
 grace hopper
Message-ID: <20231017165437.69a84f0c.alex.williamson@redhat.com>
In-Reply-To: <20231015163047.20391-1-ankita@nvidia.com>
References: <20231015163047.20391-1-ankita@nvidia.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Oct 2023 22:00:47 +0530
<ankita@nvidia.com> wrote:
> +static ssize_t nvgrace_gpu_vfio_pci_read(struct vfio_device *core_vdev,
> +					  char __user *buf, size_t count, loff_t *ppos)
> +{
> +	unsigned int index = VFIO_PCI_OFFSET_TO_INDEX(*ppos);
> +	struct nvgrace_gpu_vfio_pci_core_device *nvdev = container_of(
> +		core_vdev, struct nvgrace_gpu_vfio_pci_core_device, core_device.vdev);
> +	int ret;
> +
> +	if (index == VFIO_PCI_BAR2_REGION_INDEX) {
> +		ret = nvgrace_gpu_memmap(nvdev);
> +		if (ret)
> +			return ret;
> +
> +		return nvgrace_gpu_read_mem(buf, count, ppos, nvdev);
> +	}

After looking at Yishai's virtio-vfio-pci driver where BAR0 is emulated
as an IO Port BAR, it occurs to me that there's no config space
emulation of BAR2 (or BAR3) here.  Doesn't this mean that QEMU registers
the BAR as 32-bit, non-prefetchable?  ie. VFIOBAR.type & .mem64 are
wrong?

I'd certainly expect this to be emulated as a 64-bit, prefetchable BAR
and the commit log indicates the intention is that this is exposed as a
64-bit BAR.

We also need to decide how strictly variant drivers need to emulate
vfio_pci_config_rw with respect to BAR sizing, where the core code
provides emulation of sizing and Yishai's virtio driver only emulates
the IO port indicator bit.  QEMU doesn't really need this, but the
vfio-pci implementation sets the precedent that this behavior is
provided and could be used by other userspace drivers.  It's essentially
just providing a masked buffer to service reads and writes to the BAR2
and BAR3 config address here.  Thanks,

Alex

> +
> +	return vfio_pci_core_read(core_vdev, buf, count, ppos);
> +}

