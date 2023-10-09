Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9EFC7BEAB9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 21:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378436AbjJIThX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 15:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378431AbjJIThW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 15:37:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7779A4
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 12:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696880192;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TVDFHMjJ/ycKLdZo/7Qo28nzsm1D+pqkl3FWIOZKqxE=;
        b=Kwwj+j/ggbGYAPb86mjmtRzsVbqjLJPtTj4F1/5e4UJU5oiwapq+rvwwesJrbOJAJO7abP
        2HMBn9iyHXwF5qFJ1qufmTIny9v4pTXalB65EOKMH+VqT1wmVNeoXJNsYXfBPfmGamKdkV
        lkiL1wscXmIGXOYLju7Z4fawAkSUswM=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-548-ELAl8mtAPBG52odKL9FH9g-1; Mon, 09 Oct 2023 15:36:15 -0400
X-MC-Unique: ELAl8mtAPBG52odKL9FH9g-1
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-790d3e93a25so413057839f.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 12:36:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696880175; x=1697484975;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TVDFHMjJ/ycKLdZo/7Qo28nzsm1D+pqkl3FWIOZKqxE=;
        b=mUM2vVe4XooMWJHdPSI0gl6h81exvqgxxu/roByPJ++3JzYfjGf1c3MoPNMLZW3qRP
         08xp7VhYKcf08eNwdq8oGZNg14gb0YsPz31islVvxUq1DkJFBYKFZUemOV1FmVZNqSKS
         OJ8Xfllw9yHSiCkfuZSGLJUNqxJ2+uTlqFW2G22ABMnPUDsYxjhKzW+ZlqpaCOQ0TmsH
         N/rUKA4Z+qrubNfHLLI+0qOlpguwrvXPg/GUdZ+ZZ/J6lV0FfF/8GHUj0z1noStQL9AG
         FRegK8+EMRFJ0xI1t+MwB7i0z6dCypEAEPv4wZ31vEUuT+pKZig+JzbpSB8IZ7OgCfvq
         mr2Q==
X-Gm-Message-State: AOJu0YwkE42MuK5l0PlQo4NFscR9O0lNguS2pXNuIvHwc4lrK/mlMHiS
        d3wacusedlMCX2LbgtUOrmtWjwiqtzQzSEebyBakSbwYks/2KdfFO1gloU4jvhJsqA0psKTXhtt
        gQqfKMeV3Q197E8gHP9IqvspO
X-Received: by 2002:a05:6e02:1a0e:b0:352:6f88:9818 with SMTP id s14-20020a056e021a0e00b003526f889818mr19798122ild.11.1696880174978;
        Mon, 09 Oct 2023 12:36:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZrmoohFj1abftp9cjL5O3tHcNh5viE77dWrcuBTn9TZna5ISvd95pVTk16QjIDbjIm0ia6Q==
X-Received: by 2002:a05:6e02:1a0e:b0:352:6f88:9818 with SMTP id s14-20020a056e021a0e00b003526f889818mr19798109ild.11.1696880174711;
        Mon, 09 Oct 2023 12:36:14 -0700 (PDT)
Received: from redhat.com ([38.15.60.12])
        by smtp.gmail.com with ESMTPSA id t2-20020a056e02010200b003513535c69dsm3154672ilm.5.2023.10.09.12.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 12:36:14 -0700 (PDT)
Date:   Mon, 9 Oct 2023 13:36:12 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     <ankita@nvidia.com>, <jgg@nvidia.com>, <yishaih@nvidia.com>,
        <shameerali.kolothum.thodi@huawei.com>, <kevin.tian@intel.com>,
        <aniketa@nvidia.com>, <cjia@nvidia.com>, <kwankhede@nvidia.com>,
        <targupta@nvidia.com>, <vsethi@nvidia.com>, <acurrid@nvidia.com>,
        <apopple@nvidia.com>, <jhubbard@nvidia.com>, <danw@nvidia.com>,
        <anuaggarwal@nvidia.com>, <dnigam@nvidia.com>, <udhoke@nvidia.com>,
        <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v11 1/1] vfio/nvgpu: Add vfio pci variant module for
 grace hopper
Message-ID: <20231009133612.3fdd86a9.alex.williamson@redhat.com>
In-Reply-To: <ZSHykZ2GgSn0fE_x@debian.me>
References: <20231007202254.30385-1-ankita@nvidia.com>
        <ZSHykZ2GgSn0fE_x@debian.me>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 8 Oct 2023 07:06:41 +0700
Bagas Sanjaya <bagasdotme@gmail.com> wrote:

> On Sun, Oct 08, 2023 at 01:52:54AM +0530, ankita@nvidia.com wrote:
> > PCI BAR are aligned to the power-of-2, but the actual memory on the
> > device may not. A read or write access to the physical address from the
> > last device PFN up to the next power-of-2 aligned physical address
> > results in reading ~0 and dropped writes.
> >   
> 
> Reading garbage or padding in that case?
> 
> Confused...

The coherent memory size is rounded to a power-of-2 to be compliant with
PCI BAR semantics, but reading beyond the implemented size fills the
return buffer with -1 data, as is common on many platforms when reading
from an unimplemented section of the address space.  Thanks,

Alex

