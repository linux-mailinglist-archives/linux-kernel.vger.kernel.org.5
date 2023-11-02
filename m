Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8EDF7DFBEF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 22:14:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377415AbjKBVOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 17:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjKBVOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 17:14:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91079188
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 14:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698959637;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wfkOCZI8s/vE06TUoYXsRUD43KZX2PM2aWjgbIbsBpM=;
        b=Z3Zy5fCE+H2PlUQgOTKlHDrB/lg5VqJ1jIIDV3MxKzuNsc9nu4B/lWNwMym9gZGTc83TaI
        c+eJSkhTqIeW9AiH0ZfYJcP8Fc6l0f7cr7X7+mGmIY57nuFxOeQ6zEaZCLAqs5oHdVH+i6
        zGqbQdRQ7odvgaAANY8fBa++jITFawY=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-ji9xvFzfOXiGcdNf2ocneA-1; Thu, 02 Nov 2023 17:13:55 -0400
X-MC-Unique: ji9xvFzfOXiGcdNf2ocneA-1
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7a9545b8e2bso193432439f.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 14:13:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698959635; x=1699564435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wfkOCZI8s/vE06TUoYXsRUD43KZX2PM2aWjgbIbsBpM=;
        b=JXGKToILSnaxigf9/k8oqA/8W7vLaFdUvDykC2O7kJZcbGX0wCCvRCEH8sTHSRFTc7
         9jCEKRNzS52pMXLmiWdkvayFNa2ccR4laSbUMDRgTUfUU3aOaMjvNP/1hrfQ0ySfh+9B
         rgnGgDxo35rOj7iW3GWDUz7Zjwq5JCSuvmKIT5F7v/VjgSOBuyyDOQqTmb9CVJ0ryNQN
         gujDkk05iAYOEqqjMFeXJFRiCNfJ40MG5OmRdnXYkt/b6xYb0Z92iz2ogW3jfYVFRcqM
         JBtksp+hc4KQhukem+rGaw+lxTV/ZMl4kwS5A+KqWWkGDNsz8Kg64vthJN4V3z74UAx5
         Kkzw==
X-Gm-Message-State: AOJu0YxH5LSTinHnKQIeUypubPOdqyqN0xDpVy8scXBsnj1xuaxRBxnJ
        7hd7Qr+BAGGarZ4yWVnfcMOIqh5oww7RCNpXQxOKWjbxZulcNliRC03GkoZlp+gpQtYTo92d4e7
        ksr1ydeIBOXHJsqrGIhi8qTmz
X-Received: by 2002:a05:6e02:1aa3:b0:357:a51e:7dc4 with SMTP id l3-20020a056e021aa300b00357a51e7dc4mr1194195ilv.8.1698959635175;
        Thu, 02 Nov 2023 14:13:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRtIDvk2h6ou5ybOQtJNHDdfQL1y1Tux+ld68/4dPL58MpKjJYWrha15wfkZsxlztkkSrmeg==
X-Received: by 2002:a05:6e02:1aa3:b0:357:a51e:7dc4 with SMTP id l3-20020a056e021aa300b00357a51e7dc4mr1194170ilv.8.1698959634873;
        Thu, 02 Nov 2023 14:13:54 -0700 (PDT)
Received: from redhat.com ([38.15.60.12])
        by smtp.gmail.com with ESMTPSA id r20-20020a056e02109400b0035742971dd3sm96799ilj.16.2023.11.02.14.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 14:13:54 -0700 (PDT)
Date:   Thu, 2 Nov 2023 15:13:52 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     "Chatre, Reinette" <reinette.chatre@intel.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "yishaih@nvidia.com" <yishaih@nvidia.com>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "tom.zanussi@linux.intel.com" <tom.zanussi@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: Re: [RFC PATCH V3 00/26] vfio/pci: Back guest interrupts from
 Interrupt Message Store (IMS)
Message-ID: <20231102151352.1731de78.alex.williamson@redhat.com>
In-Reply-To: <BN9PR11MB52769292F138F69D8717BE8D8CA6A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1698422237.git.reinette.chatre@intel.com>
        <BL1PR11MB52710EAB683507AD7FAD6A5B8CA0A@BL1PR11MB5271.namprd11.prod.outlook.com>
        <20231101120714.7763ed35.alex.williamson@redhat.com>
        <BN9PR11MB52769292F138F69D8717BE8D8CA6A@BN9PR11MB5276.namprd11.prod.outlook.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Nov 2023 03:14:09 +0000
"Tian, Kevin" <kevin.tian@intel.com> wrote:

> > From: Tian, Kevin
> > Sent: Thursday, November 2, 2023 10:52 AM
> >   
> > >
> > > Without an in-tree user of this code, we're just chopping up code for
> > > no real purpose.  There's no reason that a variant driver requiring IMS
> > > couldn't initially implement their own SET_IRQS ioctl.  Doing that  
> > 
> > this is an interesting idea. We haven't seen a real usage which wants
> > such MSI emulation on IMS for variant drivers. but if the code is
> > simple enough to demonstrate the 1st user of IMS it might not be
> > a bad choice. There are additional trap-emulation required in the
> > device MMIO bar (mostly copying MSI permission entry which contains
> > PASID info to the corresponding IMS entry). At a glance that area
> > is 4k-aligned so should be doable.
> >   
> 
> misread the spec. the MSI-X permission table which provides
> auxiliary data to MSI-X table is not 4k-aligned. It sits in the 1st
> 4k page together with many other registers. emulation of them
> could be simple with a native read/write handler but not sure
> whether any of them may sit in a hot path to affect perf due to
> trap...

I'm not sure if you're referring to a specific device spec or the PCI
spec, but the PCI spec has long included an implementation note
suggesting alignment of the MSI-X vector table and pba and separation
from CSRs, and I see this is now even more strongly worded in the 6.0
spec.

Note though that for QEMU, these are emulated in the VMM and not
written through to the device.  The result of writes to the vector
table in the VMM are translated to vector use/unuse operations, which
we see at the kernel level through SET_IRQS ioctl calls.  Are you
expecting to get PASID information written by the guest through the
emulated vector table?  That would entail something more than a simple
IMS backend to MSI-X frontend.  Thanks,

Alex

