Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22FCF7E4013
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 14:29:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234460AbjKGN33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 08:29:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231833AbjKGN32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 08:29:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A11688F
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 05:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699363719;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vfimE53Fve5aGuDWfThDIn9D2hKcZVuah28LMBgDfqs=;
        b=ZA5/WQfPMlwpaKfScyxC/5QbWSxAB6F2scIOaENBeXnBublO9t3ssJT+MOPNJUcddKmfHg
        6/0/f+J1S22Z+Qb/RB9GZbY8h88B31iq4wxkJdWNQJVrHXK4lyn1ORCk7z6o7BVng5lfio
        MzC+DAkKMSV+uppCqNkQGovaTJW63cs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-386-DkyH0ZSmNPuwI2oH3S2EkQ-1; Tue, 07 Nov 2023 08:28:38 -0500
X-MC-Unique: DkyH0ZSmNPuwI2oH3S2EkQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40853e14f16so36090045e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 05:28:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699363717; x=1699968517;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vfimE53Fve5aGuDWfThDIn9D2hKcZVuah28LMBgDfqs=;
        b=ZnOfz/IC56n4zRPYVFWg92pZ/2gQ3+EQVVXcBHR2rb/lsVf/jrSRQKXG9F2GKDM+hn
         1CI9H7j1eedB8GnKNvBBH7NE4M6BbozFs9y1OAL9RmYp87V+7hXpNwoTa+BjfgmsaFxe
         7OY28ytLwyGO+ttv2hBRloHwmsZIGXikgHFVLQbuF4C0joJVUuH6e6EHB7L4GwQoe9P6
         wnKgZm6uJNtQjVw5YdIt9ygoU13MZ/7t6/x1cqciytrcoE0Da6VvVsmViMQD7bFVYJu7
         4GVZjD6yFcuuVXtmF6Y8srm/AYxfiBe8ShCKsZKMsQXi/Gnn0VXujQqW70lj4b4bO4zo
         dQGw==
X-Gm-Message-State: AOJu0YzkaomXjJ/Gq1G3NmpAui5tFDWqv117XYa2j+w3x2BEUVCHtqj8
        tKIh2RFknZgv9ugz6/4jktwK3o3yBJhaxLEcPzy0M36BK41XauAcOZ+C36nyun0PD0U67ZCKqa3
        0DgeYuWvEQ8Q9fuzja7SFZXoR
X-Received: by 2002:a05:600c:45cc:b0:405:75f0:fd31 with SMTP id s12-20020a05600c45cc00b0040575f0fd31mr2326523wmo.31.1699363717314;
        Tue, 07 Nov 2023 05:28:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEtC5KDdpuy2FXN8TvtT5NUe+9K52kc66AxdSuH43yqMhhnPmYpxrxy7CAZjiRPuu1mZVAilg==
X-Received: by 2002:a05:600c:45cc:b0:405:75f0:fd31 with SMTP id s12-20020a05600c45cc00b0040575f0fd31mr2326504wmo.31.1699363716906;
        Tue, 07 Nov 2023 05:28:36 -0800 (PST)
Received: from redhat.com ([2a02:14f:1f1:373a:140:63a8:a31c:ab2a])
        by smtp.gmail.com with ESMTPSA id g23-20020a7bc4d7000000b004063cd8105csm15206763wmk.22.2023.11.07.05.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 05:28:36 -0800 (PST)
Date:   Tue, 7 Nov 2023 08:28:32 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Cindy Lu <lulu@redhat.com>, jasowang@redhat.com,
        yi.l.liu@intel.com, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [RFC v1 0/8] vhost-vdpa: add support for iommufd
Message-ID: <20231107082343-mutt-send-email-mst@kernel.org>
References: <20231103171641.1703146-1-lulu@redhat.com>
 <20231107022847-mutt-send-email-mst@kernel.org>
 <20231107124902.GJ4488@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107124902.GJ4488@nvidia.com>
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

On Tue, Nov 07, 2023 at 08:49:02AM -0400, Jason Gunthorpe wrote:
> On Tue, Nov 07, 2023 at 02:30:34AM -0500, Michael S. Tsirkin wrote:
> > On Sat, Nov 04, 2023 at 01:16:33AM +0800, Cindy Lu wrote:
> > > 
> > > Hi All
> > > This code provides the iommufd support for vdpa device
> > > This code fixes the bugs from the last version and also add the asid support. rebase on kernel
> > > v6,6-rc3
> > > Test passed in the physical device (vp_vdpa), but  there are still some problems in the emulated device (vdpa_sim_net), 
> > 
> > What kind of problems? Understanding that will make it easier
> > to figure out whether this is worth reviewing.
> 
> IMHO, this patch series needs to spend more time internally to Red Hat
> before it is presented to the community. It is too far away from
> something worth reviewing at this point.
> 
> Jason

I am always trying to convince people to post RFCs early
instead of working for months behind closed doors only
to be told to rewrite everything in Rust.

Why does it have to be internal to a specific company?
I see Yi Liu from Intel is helping Cindy get it into shape
and that's classic open source ethos.

I know some subsystems ignore the RFC tag but I didn't realize
iommu is one of these. Is that really true?

-- 
MST

