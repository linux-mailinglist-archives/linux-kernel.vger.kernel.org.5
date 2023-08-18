Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34C40780E1C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 16:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377770AbjHROjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 10:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237261AbjHROie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 10:38:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D3C83AAC
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 07:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692369465;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O95LdJHJ87WJ7K5Vbs6EOa6gUPNw8q7E/DioZ5WNXJA=;
        b=Cl0Xf95IDJSTqRkht6fBMadt4Cfb+hDH7ISQ6XGbVU+yvlVEwLxmmv9HIWYweVHcsF1qtZ
        JqFhXX6OxRLVzaONbv5zWXa2lWlDyUFg4u9PPuv/J+wYhSSjRPp1IO51NhJMk/h3e+WI1f
        xlhBP5TS5drQTrkIGbMv2TJIWHb/7ZY=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-aPzTfq-9OSGCvTvkdOwhVw-1; Fri, 18 Aug 2023 10:37:43 -0400
X-MC-Unique: aPzTfq-9OSGCvTvkdOwhVw-1
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3a1ec37ccbbso1192563b6e.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 07:37:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692369462; x=1692974262;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O95LdJHJ87WJ7K5Vbs6EOa6gUPNw8q7E/DioZ5WNXJA=;
        b=a21Qt0ri0PWt6/KM8hlOHMOdqgCpn9tYkpPmkNJ20adPkBkqMOmvioNd93nkOnsha+
         1vRQL8pMRvL5amDsErd+k9Rqwf7rruEKojw9P6d3KvLWWIT/8s0eJqYqWZWRf6cFPoa5
         9fxldpkpNL01cvpwuL6w3cG3U+BoAPjYpWXGf7P/8nlGlJUmHUQvGdbGLr3icgWlWLgd
         DtMm7YPgkv6mCI4dO0kFt9rmA28bsE+T3I4GlCB2YxMstJxB8HEiP1fyAIqIRQwLhaHD
         20e+pfodfxoXBp1km+aIdSDJq1X9B/y4dclHVz1VBXxgn2YieYls8BEURXXzo+fA4N6E
         V2Hw==
X-Gm-Message-State: AOJu0YxfgZ/iktv3Fwh1tb5AIcH+fWXGHHbI8fo3fxCkRRyalVkuWlGZ
        ELr7l79aZq+BDXRlXv1aVY/TuBv464jb5I1FINb9QUGciBtGYFuLm0D7YY9t7FeNfyr2Vw+BBqV
        69SoHsuI2Z+khyO6yNZIoUKI1a7eWzLvx
X-Received: by 2002:a05:6808:1929:b0:3a7:4876:6044 with SMTP id bf41-20020a056808192900b003a748766044mr4087304oib.52.1692369462522;
        Fri, 18 Aug 2023 07:37:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/ZT4ZHrYj3m2eSOV5o0nJlNNBtmNfH9d7us98k42bEdH4nVPb3mno1iv+hHUcObHh1+uROg==
X-Received: by 2002:a05:6808:1929:b0:3a7:4876:6044 with SMTP id bf41-20020a056808192900b003a748766044mr4087182oib.52.1692369460795;
        Fri, 18 Aug 2023 07:37:40 -0700 (PDT)
Received: from redhat.com ([38.15.60.12])
        by smtp.gmail.com with ESMTPSA id u8-20020a056808150800b003a05ba0ccb2sm899842oiw.39.2023.08.18.07.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 07:37:40 -0700 (PDT)
Date:   Fri, 18 Aug 2023 08:37:37 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     "Gupta, Nipun" <nipun.gupta@amd.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        git@amd.com, pieter.jansen-van-vuuren@amd.com,
        nikhil.agarwal@amd.com, michal.simek@amd.com,
        abhijit.gangurde@amd.com, Shubham Rohila <shubham.rohila@amd.com>
Subject: Re: [PATCH v6 3/3] vfio-cdx: add bus mastering device feature
 support
Message-ID: <20230818083737.7ad97c2a.alex.williamson@redhat.com>
In-Reply-To: <2d94cffa-7ebf-a8ab-4f43-fc9ab1be41bb@amd.com>
References: <20230810084409.4922-1-nipun.gupta@amd.com>
        <20230810084409.4922-3-nipun.gupta@amd.com>
        <20230816114610.79c9eccc.alex.williamson@redhat.com>
        <2d94cffa-7ebf-a8ab-4f43-fc9ab1be41bb@amd.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Aug 2023 14:02:32 +0530
"Gupta, Nipun" <nipun.gupta@amd.com> wrote:

> On 8/16/2023 11:16 PM, Alex Williamson wrote:
> > On Thu, 10 Aug 2023 14:14:09 +0530
> > Nipun Gupta <nipun.gupta@amd.com> wrote:
> >   
> >> Support Bus master enable and disable on VFIO-CDX devices using
> >> VFIO_DEVICE_FEATURE_BUS_MASTER flag over VFIO_DEVICE_FEATURE IOCTL.
> >>
> >> Co-developed-by: Shubham Rohila <shubham.rohila@amd.com>
> >> Signed-off-by: Shubham Rohila <shubham.rohila@amd.com>
> >> Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
> >> ---
> >>
> >> Changes v5->v6:
> >> - Called CDX device reset at cdx_open_device()
> >>
> >> Changes v4->v5:
> >> - Use device feature IOCTL instead of adding a new VFIO IOCTL
> >>    for bus master feature.
> >>
> >> Changes in v4:
> >> - This patch is newly added which uses cdx_set_master() and
> >>    cdx_clear_master() APIs.
> >>
> >>   drivers/vfio/cdx/main.c | 46 +++++++++++++++++++++++++++++++++++++++--
> >>   1 file changed, 44 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/vfio/cdx/main.c b/drivers/vfio/cdx/main.c
> >> index c376a69d2db2..bf0e1f56e0f9 100644
> >> --- a/drivers/vfio/cdx/main.c
> >> +++ b/drivers/vfio/cdx/main.c
> >> @@ -14,7 +14,7 @@ static int vfio_cdx_open_device(struct vfio_device *core_vdev)
> >>   		container_of(core_vdev, struct vfio_cdx_device, vdev);
> >>   	struct cdx_device *cdx_dev = to_cdx_device(core_vdev->dev);
> >>   	int count = cdx_dev->res_count;
> >> -	int i;
> >> +	int i, ret;
> >>   
> >>   	vdev->regions = kcalloc(count, sizeof(struct vfio_cdx_region),
> >>   				GFP_KERNEL_ACCOUNT);
> >> @@ -39,8 +39,11 @@ static int vfio_cdx_open_device(struct vfio_device *core_vdev)
> >>   		if (!(cdx_dev->res[i].flags & IORESOURCE_READONLY))
> >>   			vdev->regions[i].flags |= VFIO_REGION_INFO_FLAG_WRITE;
> >>   	}
> >> +	ret = cdx_dev_reset(core_vdev->dev);
> >> +	if (ret)
> >> +		kfree(vdev->regions);  
> > 
> > AIUI, this reset clears bus master, but per the first patch in the
> > series the ability to set or clear bus master depends on whether the
> > underlying cdx_ops supports dev_configure.  Apparently all currently
> > do, but will that always be true?
> > 
> > It seems like this could make a gratuitous call to cdx_clear_master()
> > to validate the return value and only conditionally support this device
> > feature based on that result (or fail the device open if it's meant to
> > be required).  
> 
> CDX bus driver does not explicitly call cdx_clear_master during reset. 
> It is triggered by device implicitly and hence device_reset would never
> fail due to lack of bus mastering capability.
> 
> Do you mean if cdx_dev_reset() fails we should not set the 
> VFIO_DEVICE_FLAGS_RESET in vfio_device_info? something like:
> 
> 	ret = cdx_dev_reset(core_vdev->dev);
> 	if (ret == -EOPNOTSUPP)
>   		/* make sure VFIO_DEVICE_FLAGS_RESET is not returned in
> 		 * flags for device get info */
> 	else if (ret)
> 		kfree(vdev->regions);
> 
>  From new device feature added for BUS mastering if cdx_clear_master() 
> fails due to no support, the bus driver will return -EOPNOTSUPP, so same 
> would be communicated to the user-space, so it seems fine from this end.

It's inconsistent to the user to allow the bus master device feature
probe to indicate the feature is available if it's going to fail on
every call.  My suggestion was specifically relative to that, a
gratuitous call to clear bus master, determine if the call works, then
the feature probe could succeed or fail based on that result.

However, now that I look at cdx_dev_reset() I notice the inconsistency
with dev_configure.  The reset path unconditionally calls
dev_configure, but the bus master paths tests dev_configure.  Is
dev_configure a required op or not?  Are reset and bus master control
required features of CDX?  If the core CDX code requires these then the
vfio support gets easier, we don't need to make all these conditional.
Thanks,

Alex

