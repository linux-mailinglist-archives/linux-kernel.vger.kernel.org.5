Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E74FD7AE74C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 10:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233800AbjIZIEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 04:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233714AbjIZIEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 04:04:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E877D7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 01:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695715396;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ELJLtZNf5BHgiOefmxJ85wHiMzo3vyZFSvRuYmBGd3k=;
        b=UiQEkPHheieTHPqLSdnjQSu5AXBPcdvdrtceyFzl1bjbGBLTIxW32GLhQN+F5Zh0dlZMWo
        EA8WGVV+d4582aoj3V6UAnSjyWDRu1z20tOlqVXG0hys0Y3k90wSEgXeufHr+mdJRMTGI6
        t2zM95+KCT1ash+IAY4WjIVSA052V90=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-LW1fATXcNjmFo9R9EXNubg-1; Tue, 26 Sep 2023 04:03:14 -0400
X-MC-Unique: LW1fATXcNjmFo9R9EXNubg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40474e7323dso75685755e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 01:03:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695715392; x=1696320192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ELJLtZNf5BHgiOefmxJ85wHiMzo3vyZFSvRuYmBGd3k=;
        b=DFXr/a2uCCi+b9ZL4mUD/5TwPZxod2z2FhH6SbDtgc/SFkek93YzhSjvUGwz06vuOA
         2NjJ3BEup8v8hvU0cLqbivSQUMsD9sYD+wUhSjeje0acNHwSwTqwYxR+RZ3eCTAVq1Wo
         c7G/MiT3mmwQeAngyJl7yr5Q6BeBkudOETKHu6zGWFEEuZaxB58T9MdvssT7zM1ldfTB
         R6kpYVhm7JhmEDdly9/tfRQuD3OGqBs4IBL6hgftTjtJUnLnkpwHcv0TwDonG/paSOn6
         +BA6RAFMdsw7YkoC/b4qF6tUi9NJWe4ucaebsz/SgZxCo0a75LPeYo6FNu0TNyA3v1Sr
         Dqaw==
X-Gm-Message-State: AOJu0Yx3/NcnRM95bjfzDXoDy/hv0kRZlirkgFP09pJEyXVkQ7R0ELJV
        XwGDt95u+zOgmzWhQjmtaA89P7T44PTkO5gDuGbWNs/GD74aVxUVv3IZ2xMAv7EZpJxNsjTG6td
        mmSNYfZ1th/y5UogPrRA65BesEZ+Np31IW4rGSg7T8eFMzTPt
X-Received: by 2002:a7b:c8ce:0:b0:3f5:fff8:d4f3 with SMTP id f14-20020a7bc8ce000000b003f5fff8d4f3mr7389501wml.7.1695715392276;
        Tue, 26 Sep 2023 01:03:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE59rpXl/SGxh4tybcaud/lyyascHkYmT5tXB1hN3iXyjhk5Q4F0p49nyFPjgDbiKxOxjQesT70FqFxc2/btoE=
X-Received: by 2002:a7b:c8ce:0:b0:3f5:fff8:d4f3 with SMTP id
 f14-20020a7bc8ce000000b003f5fff8d4f3mr7389478wml.7.1695715391965; Tue, 26 Sep
 2023 01:03:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230923170540.1447301-1-lulu@redhat.com> <20230923170540.1447301-8-lulu@redhat.com>
 <20230925135047.GE13733@nvidia.com>
In-Reply-To: <20230925135047.GE13733@nvidia.com>
From:   Cindy Lu <lulu@redhat.com>
Date:   Tue, 26 Sep 2023 16:02:34 +0800
Message-ID: <CACLfguUW+u+ADefgRnpRPU8DNj_EKDsrK0sy_Uj8EGtUN6Yu+g@mail.gmail.com>
Subject: Re: [RFC 7/7] iommufd: Skip the CACHE_COHERENCY and iommu group check
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     jasowang@redhat.com, mst@redhat.com, yi.l.liu@intel.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 9:50=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Sun, Sep 24, 2023 at 01:05:40AM +0800, Cindy Lu wrote:
> > This is just the work arround for vdpa, I Will
> > fix these problems in the next version.
> >
> > Skip these 2 checks:
> > 1.IOMMU_CAP_CACHE_COHERENCY check
> > 2.iommu_group_get check
>
> Uuh, something has gone really, really wrong if you need to skip these
> checks in the core iommufd code..
>
there are problems in this code, I will continue working in this.
Thanks
Cindy
> Jason
>

