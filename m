Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 741A776F53E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 00:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbjHCWBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 18:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjHCWBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 18:01:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32111BF9
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 15:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691100020;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e5T5pWUirWKsLkB00AEjSsIe112xMOygwTl2MuAcfig=;
        b=YQP3IMvcFfLAblvYkgou62VRXwBfPF+Xfjunov+FsC9Yh69swhYdn2DAsCr3seOaxWZ9uR
        2poVCljbPSKLFLudEkUjyZt/KFj34KO1zGoVMMZ7DsAzYkGHlRDhwz961Wvc7tMokUweHr
        skbEf0Q6s33OzetqvS4D7coitJb6shg=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-OVxfl9R4MFyJaW0oqi5ojw-1; Thu, 03 Aug 2023 18:00:19 -0400
X-MC-Unique: OVxfl9R4MFyJaW0oqi5ojw-1
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-34916ad5387so13643765ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 15:00:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691100018; x=1691704818;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e5T5pWUirWKsLkB00AEjSsIe112xMOygwTl2MuAcfig=;
        b=U6sI1EQa/Uat3n/gvafcpHGMDSw8x5Xim2y1lDoyxUjJ6AV5vq0+bDFTyjtPmwXA1K
         suELEFSHYh47AHQhqjCAxWdL4i9Y1rKm/8QWj+GStKvU8/hKHouLEr8fBy8hgRJ3rDyh
         efs/lZKQWlBJkjYpTAEn2hJFW3ZzuhrE8B3huEt1IO2m/zmcvZq3vUew7Ubg6nzOoTH2
         8bpGU3SnZExfS7xEdXNmvkYKbMwMgI7HhVQ2hPhFGeKgiP2HCA9gNl4cSKy2LZYtv9fj
         lOhYUGfXnv3l3WPAyorJFBdCtgXKpq9AhVFRMVzG6dEwxzVL+MzDzxeNYbCDRVGpUXGS
         /dkA==
X-Gm-Message-State: AOJu0YwlsuOmB/OHa4ZWa6kh+IvFgCmqxVGIxjDZOnEzys75QWuSv/hi
        ne6P0Nu3s9zq9ic7ImaAafP1b1pRNXFD7uq1+X7eYGgHqdthHGQNDIBT730qiqu/gBDlPRCTBwJ
        wKNYJ0q8WtXSfCVvOaHXGDE7p
X-Received: by 2002:a05:6e02:20ed:b0:345:a201:82b7 with SMTP id q13-20020a056e0220ed00b00345a20182b7mr69167ilv.26.1691100018585;
        Thu, 03 Aug 2023 15:00:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6QmGZ5H41pusQ3ikpHB/gC8Bym4btP9K7AYCIEgfcDYkJDLPsGy/J3ZEcAkXxbhX5FcUjNw==
X-Received: by 2002:a05:6e02:20ed:b0:345:a201:82b7 with SMTP id q13-20020a056e0220ed00b00345a20182b7mr69140ilv.26.1691100018240;
        Thu, 03 Aug 2023 15:00:18 -0700 (PDT)
Received: from redhat.com ([38.15.60.12])
        by smtp.gmail.com with ESMTPSA id q3-20020a92d403000000b00348d652a6b4sm246877ilm.48.2023.08.03.15.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 15:00:17 -0700 (PDT)
Date:   Thu, 3 Aug 2023 16:00:16 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Nipun Gupta <nipun.gupta@amd.com>
Cc:     <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <git@amd.com>, <pieter.jansen-van-vuuren@amd.com>,
        <nikhil.agarwal@amd.com>, <michal.simek@amd.com>,
        <abhijit.gangurde@amd.com>, Shubham Rohila <shubham.rohila@amd.com>
Subject: Re: [PATCH v5 2/3] vfio: add bus master feature to device feature
 ioctl
Message-ID: <20230803160016.5b299ae7.alex.williamson@redhat.com>
In-Reply-To: <20230803143253.7817-2-nipun.gupta@amd.com>
References: <20230803143253.7817-1-nipun.gupta@amd.com>
        <20230803143253.7817-2-nipun.gupta@amd.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Aug 2023 20:02:52 +0530
Nipun Gupta <nipun.gupta@amd.com> wrote:

> add bus mastering control to VFIO_DEVICE_FEATURE IOCTL. The VFIO user
> can use this feature to enable or disable the Bus Mastering of a
> device bound to VFIO.
> 
> Co-developed-by: Shubham Rohila <shubham.rohila@amd.com>
> Signed-off-by: Shubham Rohila <shubham.rohila@amd.com>
> Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
> 
> Changes in v5:
> - This patch is newly added which proposes a new flag
>   VFIO_DEVICE_FEATURE_BUS_MASTER in VFIO_DEVICE_FEATURE IOCTL. 
> 
> ---
>  include/uapi/linux/vfio.h | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index 20c804bdc09c..05350a2f1eab 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -1287,6 +1287,22 @@ struct vfio_device_feature_mig_data_size {
>  
>  #define VFIO_DEVICE_FEATURE_MIG_DATA_SIZE 9
>  
> +/**
> + * Upon VFIO_DEVICE_FEATURE_SET, allow the BUS mastering for the device to be
> + * set or clear based on the operation specified in op flag.
> + *
> + * If the BUS MASTER of the device is configured to CLEAR,
> + * all the incoming DMA from the device will be blocked.
> + * If the BUS MASTER of the device is configured to SET (enable),
> + * device would be able to do DMA to host memory.

CDX is clearly not the only bus that has the concept of controlling a
device's ability to perform DMA, so I'm concerned about this
description.  For example someone with no prior vfio-pci experience
might be confused reading the uAPI and then not having support for this
feature in vfio-pci.

One option would be to make this CDX specific through the name, ie.
VFIO_DEVICE_FEATURE_CDX_BUS_MASTER, but maybe it's sufficient to leave
it general but explain here that this is only implemented for devices
which require bus master control and have no means in the in-band
device interface to provide that control.  Going on to state that PCI
bus master is controlled in-band through config space and that this is
initially only provided for CDX devices would be useful.  Of course the
PROBE interface can be used to determine if this is available for a
given device.

> + */
> +struct vfio_device_feature_bus_master {
> +	__u32 op;
> +#define        VFIO_DEVICE_FEATURE_SET_MASTER        0       /* Set Bus Master */
> +#define        VFIO_DEVICE_FEATURE_CLEAR_MASTER      1       /* Clear Bus Master */

Ultimately it doesn't matter, but this is a strange choice, set = 0,
clear = 1.  I think the reverse would be better for raw debugging.
Thanks,

Alex

> +};
> +#define VFIO_DEVICE_FEATURE_BUS_MASTER 9
> +
>  /* -------- API for Type1 VFIO IOMMU -------- */
>  
>  /**

