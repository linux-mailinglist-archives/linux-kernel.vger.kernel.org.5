Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56EC97DEF61
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 11:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345931AbjKBKDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 06:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345944AbjKBKDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 06:03:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94937123
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 03:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698919329;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HQZaCcbNvR/vRwvT++3FkZXUSfW2tFLkbmwPh6CE5mI=;
        b=TPuluYLg1B6RYighJ5sUG5s1TExDJ730Gfw/dKHyYhYM7SEqh/cVBJ5IodgJtCEx2iN91t
        0uk3XVbDao/xyHnxBk4gV7JbIqz6O9TNLvrZ7cMsxvxh+WGGl/gQyfHM1BiIO2QQwerFnV
        4qteCLo1P/VN1UE6Tv/P/08PliXmfT8=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-0hsS4gw-MBWULub97ErglQ-1; Thu, 02 Nov 2023 06:02:08 -0400
X-MC-Unique: 0hsS4gw-MBWULub97ErglQ-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-5079c865541so591677e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 03:02:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698919326; x=1699524126;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HQZaCcbNvR/vRwvT++3FkZXUSfW2tFLkbmwPh6CE5mI=;
        b=fdQxr7DVLJuMmarzgae1Ie+UFmvRdds6Wrw97XEW1+5mAi99DIZk5yZWuKyaLSr94j
         9WBRXhRAHrRPvbYgpWgPCxVtMiq5cOpIVFzGITRd0B+iHo5+l6wNzMugM+NkaHRYLMYk
         vo86K7auAwbYN1fft3W77xucrWpMY1JCfUgeZ9+aaD9mh68IRQgRs28nhdRE4b3fMLX4
         WWajoxT6TO3E0UgMivrzfuSKVFM1/I/PfsbV/JK3NT++CnROlud1YhvVRV7j2XJKJr4l
         x1Gtyqdewr7rpazOZsHPZUW2/oH9eYa5K5hQZjbiTYoonGv9Tu1puIBG+cLMlje1nohE
         78TQ==
X-Gm-Message-State: AOJu0YzMKTk27np8q40iF3JJ1tXyxDnrgZTM+a9DhAdBXboHJMH7//cP
        4/pEUG5AKGHfGiCaI358dwl6CkIEThNnA08L7zCma0r89BP+C6x+2MbK9v5FAhaK0L/hxMg3Ry7
        gZsc0BGLLFSDyYC5oVhqobVRn45MSSMq8
X-Received: by 2002:ac2:47fa:0:b0:506:899d:1994 with SMTP id b26-20020ac247fa000000b00506899d1994mr12240662lfp.52.1698919326290;
        Thu, 02 Nov 2023 03:02:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgzRDP6IedPcxWzyU82zbL27uQuZvFZAmfFO8532rjHoXbxjyP/bbnF/jAQjaUjhe/+z5K+Q==
X-Received: by 2002:ac2:47fa:0:b0:506:899d:1994 with SMTP id b26-20020ac247fa000000b00506899d1994mr12240648lfp.52.1698919325964;
        Thu, 02 Nov 2023 03:02:05 -0700 (PDT)
Received: from redhat.com ([2a02:14f:174:efc3:a5be:5586:34a6:1108])
        by smtp.gmail.com with ESMTPSA id a16-20020adff7d0000000b0032dbf99bf4fsm1812242wrq.89.2023.11.02.03.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Nov 2023 03:02:05 -0700 (PDT)
Date:   Thu, 2 Nov 2023 06:02:01 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Cindy Lu <lulu@redhat.com>
Cc:     jasowang@redhat.com, yi.l.liu@intel.com, jgg@nvidia.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [RFC 0/7] vdpa: Add support for iommufd
Message-ID: <20231102060151-mutt-send-email-mst@kernel.org>
References: <20230923170540.1447301-1-lulu@redhat.com>
 <20231026024147-mutt-send-email-mst@kernel.org>
 <CACLfguXstNSC20x=acDx20CXU3UksURDY04Z89DM_sNbGeTELQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACLfguXstNSC20x=acDx20CXU3UksURDY04Z89DM_sNbGeTELQ@mail.gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 02:48:07PM +0800, Cindy Lu wrote:
> On Thu, Oct 26, 2023 at 2:42 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Sun, Sep 24, 2023 at 01:05:33AM +0800, Cindy Lu wrote:
> > > Hi All
> > > Really apologize for the delay, this is the draft RFC for
> > > iommufd support for vdpa, This code provides the basic function
> > > for iommufd support
> > >
> > > The code was tested and passed in device vdpa_sim_net
> > > The qemu code is
> > > https://gitlab.com/lulu6/gitlabqemutmp/-/tree/iommufdRFC
> > > The kernel code is
> > > https://gitlab.com/lulu6/vhost/-/tree/iommufdRFC
> > >
> > > ToDo
> > > 1. this code is out of date and needs to clean and rebase on the latest code
> > > 2. this code has some workaround, I Skip the check for
> > > iommu_group and CACHE_COHERENCY, also some misc issues like need to add
> > > mutex for iommfd operations
> > > 3. only test in emulated device, other modes not tested yet
> > >
> > > After addressed these problems I will send out a new version for RFC. I will
> > > provide the code in 3 weeks
> >
> > What's the status here?
> >
> Hi Michael
> The code is finished, but I found some bug after adding the support for ASID,
> will post the new version after this bug is fixed, should be next week
> Thanks
> Cindy

The week is almost gone, what's going on?


> > --
> > MST
> >

