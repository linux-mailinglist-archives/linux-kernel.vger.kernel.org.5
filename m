Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED4EF7D7D0C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 08:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343564AbjJZGum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 02:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJZGuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 02:50:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3FFB198
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 23:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698302991;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A819CxVjTt/0YD6znIYJAdPMk1RTWMLfMeumCnGtsqE=;
        b=OmyCdkbua8y30jIgexEf0BuNogXrHH3aUOIEwM2AIkr5t/a9W5ZnG1r8m9/yDsw2JPbh8W
        feBCc1dlRVRWblGguG7sv7UWEfe2RXz2cQglKwLZodzdvy9kgfQ8yo1FQ3NcVqLUAfqSX4
        F7meOy7LjAuESoDO6KKNtaNf7cDz8oU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-uO8zgITFMJa8Nlhx8YwgoA-1; Thu, 26 Oct 2023 02:49:50 -0400
X-MC-Unique: uO8zgITFMJa8Nlhx8YwgoA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-32db9cd71d7so359110f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 23:49:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698302988; x=1698907788;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A819CxVjTt/0YD6znIYJAdPMk1RTWMLfMeumCnGtsqE=;
        b=QI3rfgsp4zavPdIzLq22hsIfU5H4UtmXWqFuPbdtYHLr5RPQEF9i/D/J96mJxfZAe6
         1IVIiWwPZGIxzKwTMa3lmqmSKi0makyWtyYJwAdyy1YEqupsWnuJfoTgEhuMsjet8S92
         DcBcjuJo72eiVROJjA7EnbxBj9GdSQUEcdajr3SjPETND6+DxvGyHIf10CjpuGtvGa0s
         U9D4xEZ3EgDIJ4dNjnJYj3rkRcmyec8NJrAlN8DBPYiYcWhnVkN+aarZA3XomEC64REo
         nHBSA9x2sCeGSqT2/OKNwpwso7M3/WVsR6AHAAlOAsU+2GM7I7rfsT5MBjeaQtJQgOB5
         1QTA==
X-Gm-Message-State: AOJu0Yy2RVg1B6aTTJEodfO5JgzC1If+mGdyY0Q2oL4m3d11fqTmfJVM
        9+zGgrUBLVwUFOdqITvSNi//1CwZO0vohOby68pUJ39XS8UtlD02/n3Xn8rFhYsr0bS8ny4MxzA
        h99Sl/oeeipEkHU+8kJ1+CfX1CeBmaDwEUUf+3Q==
X-Received: by 2002:a05:6000:984:b0:32d:bf1c:ce65 with SMTP id by4-20020a056000098400b0032dbf1cce65mr2167133wrb.22.1698302988589;
        Wed, 25 Oct 2023 23:49:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEOBG562yOR6ZE/N4d6D22qdUaQb1WQ+r+ZpRNQxlAYrJb19NbalLrCC21XyEwKRApTNcdacA==
X-Received: by 2002:a05:6000:984:b0:32d:bf1c:ce65 with SMTP id by4-20020a056000098400b0032dbf1cce65mr2167108wrb.22.1698302988230;
        Wed, 25 Oct 2023 23:49:48 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f6:3c98:7fa5:a31:81ed:a5e2])
        by smtp.gmail.com with ESMTPSA id r4-20020adff704000000b0032d88e370basm13582521wrp.34.2023.10.25.23.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 23:49:47 -0700 (PDT)
Date:   Thu, 26 Oct 2023 02:49:44 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Cindy Lu <lulu@redhat.com>
Cc:     jasowang@redhat.com, yi.l.liu@intel.com, jgg@nvidia.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [RFC 0/7] vdpa: Add support for iommufd
Message-ID: <20231026024931-mutt-send-email-mst@kernel.org>
References: <20230923170540.1447301-1-lulu@redhat.com>
 <20231026024147-mutt-send-email-mst@kernel.org>
 <CACLfguXstNSC20x=acDx20CXU3UksURDY04Z89DM_sNbGeTELQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACLfguXstNSC20x=acDx20CXU3UksURDY04Z89DM_sNbGeTELQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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


We'll miss this merge window then.

> > --
> > MST
> >

