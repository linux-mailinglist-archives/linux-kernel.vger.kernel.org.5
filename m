Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 237EE80D8EF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 19:50:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345261AbjLKStu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 13:49:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbjLKSts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 13:49:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF5FDB
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 10:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702320594;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XB9mhIvJlXIIux4LJMz0ThVUKKa3x07C77ea6R/b5W4=;
        b=CL3+qhbWdFALQhmyM2vBfmgPxZOzgAzYsJxg5sAEPbtRp03kDIDBZQZKre04jlPcd0FqRy
        qjN6Dmq4gOziEHFWlM5AvecMkvhCem3+MFllHtWJExKnh9xrpMAniEsJepEHGQkYb1k310
        JYbry6nYgoYnfp/F0U//Pnhmpq+cthE=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-8ggQLSa-P6uQlAf1srZOAw-1; Mon, 11 Dec 2023 13:49:52 -0500
X-MC-Unique: 8ggQLSa-P6uQlAf1srZOAw-1
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7b70a24dd1dso434436139f.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 10:49:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702320592; x=1702925392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XB9mhIvJlXIIux4LJMz0ThVUKKa3x07C77ea6R/b5W4=;
        b=Rnjlpwpb48DOM3dsFYydptsZN5GUDaJIKXd6XA8kUbws09RG6GfXcttQfsTuS4Shvn
         OMiCtC//31YpgoJPNos5rX9elekdlcPC84bclNJlB7GhvrQGfh1fyS9K8LDEP7sbu0K7
         FoknIlJEB3Q6Yx14Ft405XE5gzen4wXlB7rvZbRu8raQUREyoAzRLWoXteVYChVBNoYg
         GTfcTo+XK9RSvZXgdO6GzHcdZbp+/XBxP04sbJBNCv34PR5R6TZIZPjUke2xVYtny5EB
         2dQysQeARB/RzPMbqdfo8R/zCLU5fpxTqvXlMrqQ6P8r435ZR/0GhUwuU1AQkO4HTKaT
         Aqmw==
X-Gm-Message-State: AOJu0YzSiGYAKdHQEZhVgjKrm38nwCD6dnSN6aNEsp4TaX9vglsfSbXC
        Af9mp0r+2c8xFaFrwdPWeyN4e04AoH0YCyy/aQ+KV6wEAQusxqYPfOFzSk3Qf9hU1jgMn6xdPuW
        /qa408bcRslZFg/dHCgmEji9j
X-Received: by 2002:a05:6602:5c4:b0:7b7:cd9:69e4 with SMTP id w4-20020a05660205c400b007b70cd969e4mr5869246iox.17.1702320591919;
        Mon, 11 Dec 2023 10:49:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG9BStqyJrk+wPBnz2NVGzUjSM91G8zGRKaMo7y/fs+I/Qqz3zD2APq+aikOivF1KWpRzNeLg==
X-Received: by 2002:a05:6602:5c4:b0:7b7:cd9:69e4 with SMTP id w4-20020a05660205c400b007b70cd969e4mr5869225iox.17.1702320591628;
        Mon, 11 Dec 2023 10:49:51 -0800 (PST)
Received: from redhat.com ([38.15.60.12])
        by smtp.gmail.com with ESMTPSA id k18-20020a056638371200b0046921815eb5sm2056817jav.62.2023.12.11.10.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 10:49:51 -0800 (PST)
Date:   Mon, 11 Dec 2023 11:49:49 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org, kevin.tian@intel.com,
        robin.murphy@arm.com, baolu.lu@linux.intel.com, cohuck@redhat.com,
        eric.auger@redhat.com, nicolinc@nvidia.com, kvm@vger.kernel.org,
        mjrosato@linux.ibm.com, chao.p.peng@linux.intel.com,
        yi.y.sun@linux.intel.com, peterx@redhat.com, jasowang@redhat.com,
        shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
        suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        zhenzhong.duan@intel.com, joao.m.martins@oracle.com,
        xin.zeng@intel.com, yan.y.zhao@intel.com
Subject: Re: [PATCH 3/3] vfio: Report PASID capability via
 VFIO_DEVICE_FEATURE ioctl
Message-ID: <20231211114949.273b21c0.alex.williamson@redhat.com>
In-Reply-To: <20231211181028.GL2944114@nvidia.com>
References: <20231127063909.129153-1-yi.l.liu@intel.com>
        <20231127063909.129153-4-yi.l.liu@intel.com>
        <20231211110345.1b4526c6.alex.williamson@redhat.com>
        <20231211181028.GL2944114@nvidia.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Dec 2023 14:10:28 -0400
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Mon, Dec 11, 2023 at 11:03:45AM -0700, Alex Williamson wrote:
> > On Sun, 26 Nov 2023 22:39:09 -0800
> > Yi Liu <yi.l.liu@intel.com> wrote:

> > >    the PF). Creating a virtual PASID capability in vfio-pci config space needs
> > >    to find a hole to place it, but doing so may require device specific
> > >    knowledge to avoid potential conflict with device specific registers like
> > >    hiden bits in VF config space. It's simpler by moving this burden to the
> > >    VMM instead of maintaining a quirk system in the kernel.  
> > 
> > This feels a bit like an incomplete solution though and we might
> > already posses device specific knowledge in the form of a variant
> > driver.  Should this feature structure include a flag + field that
> > could serve to generically indicate to the VMM a location for
> > implementing the PASID capability?  The default core implementation
> > might fill this only for PFs where clearly an emualted PASID capability
> > can overlap the physical capability.  Thanks,  
> 
> In many ways I would perfer to solve this for good by having a way to
> learn a range of available config space - I liked the suggestion to
> use a DVSEC to mark empty space.

Yes, DVSEC is the most plausible option for the device itself to convey
unused config space, but that requires hardware adoption so presumably
we're going to need to fill the gaps with device specific code.  That
code might live in a variant driver or in the VMM.  If we have faith
that DVSEC is the way, it'd make sense for a variant driver to
implement a virtual DVSEC to work out the QEMU implementation and set a
precedent.

I mostly just want us to recognize that this feature structure also has
the possibility to fill this gap and we're consciously passing it over
and should maybe formally propose the DVSEC solution and reference it
in the commit log or comments here to provide a complete picture.
Thanks,

Alex

