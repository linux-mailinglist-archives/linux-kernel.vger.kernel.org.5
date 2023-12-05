Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE308042FF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 01:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343529AbjLEABK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 19:01:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjLEABI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 19:01:08 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D963BFF
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 16:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701734474;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=93s1ELgfxstgbB9hpuLBR3wLORjWDRcMjxyeQXV1qHs=;
        b=L30hPDlAyzQ5/4jPlkBwPwo+C35s6VyL8ADUi4UuceQ8TyEaR2LzLhqOXGspd8vAMhk8So
        V5dOkUnCsNZE7XN+Nytz3V/61133NagABHoAfjO9OCtgsU4ntG/6XICUBOvMuQhdubnfX8
        qBebl+Sf/2ITVpQFvm5dW0Bhlz8oXas=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-Ec1Xjut3PqKkrCuiSNMb0Q-1; Mon, 04 Dec 2023 19:01:12 -0500
X-MC-Unique: Ec1Xjut3PqKkrCuiSNMb0Q-1
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7affd581173so416384539f.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 16:01:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701734472; x=1702339272;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=93s1ELgfxstgbB9hpuLBR3wLORjWDRcMjxyeQXV1qHs=;
        b=dEFdO7SiGrhiuT8ZdPMk5xgZLk6PnMJpxNt6TEcrfvxmLGuFFUg+1HSCQY+I9lyCA/
         rm6+6eYMkcNo1XMgsM9p8pnLefaCfKcomZf/i6FaYktYZbmD1VOiUZYMceevYQ5nJbMW
         HALHE6AGs1Nnri0wmFR2Tv0eMueaEeQqMSsJLq8IquaeC1IivKH741H4eEQTomX2Wkbr
         tcMetVt/TBfOTBnIaRnufWmoLI1Yow3+acIKdgNj9GpPvoZy0KECodUQx4z0xn+vk+Ye
         oRlxm26b1kPAz3WF9sy4oRZWLVEHvKNr0eSOVCqOG/e5ypBIK2rUweFcQDZ/4J0V6o0N
         chjw==
X-Gm-Message-State: AOJu0Yx98K2pgWEoeKBEkv29FGus+ZGiMLusKUMlrYmj7GuvBLvx/6kP
        zjKVig32AibeQw3aRuZmphUeazon9qFBgU/6IRUlUG7zCsQ4ktR+2wwDdyVbDb3y86YxNJC8UVh
        9BUIwFyNHfWirdyvRRatHSqmk
X-Received: by 2002:a6b:ef16:0:b0:7b3:989f:ee57 with SMTP id k22-20020a6bef16000000b007b3989fee57mr4464346ioh.7.1701734472026;
        Mon, 04 Dec 2023 16:01:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEnJuHCFrwbwVhh2Pq5VkbCt1npgoQecLnLIdP8jj6eymRP8pW+byzWrwnNKbCScAQq4L60Hg==
X-Received: by 2002:a6b:ef16:0:b0:7b3:989f:ee57 with SMTP id k22-20020a6bef16000000b007b3989fee57mr4464338ioh.7.1701734471701;
        Mon, 04 Dec 2023 16:01:11 -0800 (PST)
Received: from redhat.com ([38.15.60.12])
        by smtp.gmail.com with ESMTPSA id 22-20020a5d9c56000000b007b35043225fsm3092323iof.32.2023.12.04.16.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 16:01:10 -0800 (PST)
Date:   Mon, 4 Dec 2023 17:00:48 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Brett Creeley <brett.creeley@amd.com>
Cc:     <jgg@ziepe.ca>, <yishaih@nvidia.com>,
        <shameerali.kolothum.thodi@huawei.com>, <kevin.tian@intel.com>,
        <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <shannon.nelson@amd.com>
Subject: Re: [PATCH v2 vfio 0/6] vfio/pds: Clean-ups and multi-region
 support
Message-ID: <20231204170048.232760ee.alex.williamson@redhat.com>
In-Reply-To: <20231117001207.2793-1-brett.creeley@amd.com>
References: <20231117001207.2793-1-brett.creeley@amd.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Nov 2023 16:12:01 -0800
Brett Creeley <brett.creeley@amd.com> wrote:

> This series contains various clean-ups, improvements, and support
> for multiple dirty tracking regions. The majority of clean-up and
> improvements are in preparation for the last patch in the series,
> which adds support for multiple dirty tracking regions.
> 
> Changes:
> 
> v2:
> - Make use of BITS_PER_BYTE #define
> - Use C99 style for loops
> - Fix subject line to use vfio/pds instead of pds-vfio-pci
> - Separate out some calculation fixes into another patch
>   so it can be backported to 6.6-stable
> - Fix bounds check in pds_vfio_get_region()
> 
> v1:
> https://lore.kernel.org/kvm/20231114210129.34318-1-brett.creeley@amd.com/T/
> 
> Brett Creeley (6):
>   vfio/pds: Fix calculations in pds_vfio_dirty_sync
>   vfio/pds: Only use a single SGL for both seq and ack
>   vfio/pds: Move and rename region specific info
>   vfio/pds: Pass region info to relevant functions
>   vfio/pds: Move seq/ack bitmaps into region struct
>   vfio/pds: Add multi-region support
> 
>  drivers/vfio/pci/pds/dirty.c | 309 ++++++++++++++++++++++-------------
>  drivers/vfio/pci/pds/dirty.h |  18 +-
>  2 files changed, 204 insertions(+), 123 deletions(-)
> 

Applied to vfio next branch for v6.8.  Thanks,

Alex

