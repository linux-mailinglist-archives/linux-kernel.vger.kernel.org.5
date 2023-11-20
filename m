Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFDAC7F1CC1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 19:39:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232733AbjKTSj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 13:39:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232654AbjKTSjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 13:39:03 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B54D6C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 10:38:27 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-332c7d4a6a7so764758f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 10:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700505505; x=1701110305; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Kg0bpxRdcL8t4yRhGzqbCgUsQk8IIqBGTHsR5xQerDs=;
        b=a3KYCq1F3WLVrkift4CNCBJXO/IPMn2Zwhl2zWgLTIdCs3PqwBhkuhu/2tpGOnAMZK
         05Z01XpgFt9ZSX7CmYay7JbTf3wSVFVmcSu9Sc+gZuqQ34AOoPUlF/MgB3RE35/ChrcK
         Mv9mO4qy8VTFfjEf0bSm7gDQmBCbnmLQpQB4TyGtWm1RC7EXhP3WPeq1BvxrYCGZorG8
         DtEJJngMS02Sl9LthGjQgZVAVsSl4nuLZH10CBjOhrXP1hrzS0r7AoFDtqUL8mimeZba
         Uti/efz6+xPmCeOgwW802SH2oS28CMAESuDf1I/7MyaLKvoR9YrgegyWiQrqNLR6hpYL
         bZeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700505505; x=1701110305;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kg0bpxRdcL8t4yRhGzqbCgUsQk8IIqBGTHsR5xQerDs=;
        b=E1H4NVrRLxr/s1T/2iRMQTC26JDdcsJz3DNGwq28CRQlA0do1g3FD5nj1QXiGXsx80
         UcWiMWw1/MUBF9mgEz8gRfUGIu+p55GePu6Nr23M/Tv0KnMRBHXgjm/VoGQb1QxiHLfk
         Ien6hJWZaojD/N9ZrDgWQrf+z0/uoTORz5sUR6awfeAeQcez+WDIsLtlpW088T6r748c
         H7Uj+25KNG+eIBSp5DOQdJzfHhSXTb+UcDfh2nuTvvWMM3F4LPRm38yYd2+j9tmw0ox2
         EmGHLn57sB/sIW3HsOdrUkSqWRwM/PROFHgKeMPtgqcZhdzOfAy8DmvQ/9EGd7/oMeoS
         3+oQ==
X-Gm-Message-State: AOJu0Yy5T8OTSleS6AUGcigL2uOfRcX5CsLky8WXsOahuUvJw+TwheXr
        +DDklkWj0Ym+tCIy0fOyR03fkw==
X-Google-Smtp-Source: AGHT+IHMunydcfDqafYEVS8rh4UBWcg4B9mAZ2t8F2fQH+JRl/yole2wNILvFQ9UWlf9jYlmdOnM/g==
X-Received: by 2002:a05:6000:18a9:b0:332:c9c3:2cd3 with SMTP id b9-20020a05600018a900b00332c9c32cd3mr2386984wri.47.1700505504906;
        Mon, 20 Nov 2023 10:38:24 -0800 (PST)
Received: from myrica ([2.221.137.100])
        by smtp.gmail.com with ESMTPSA id y4-20020a5d4ac4000000b003316c8ad545sm10939806wrs.76.2023.11.20.10.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 10:38:24 -0800 (PST)
Date:   Mon, 20 Nov 2023 18:38:33 +0000
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Robin Murphy <robin.murphy@arm.com>,
        virtualization@lists.linux-foundation.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] iommu/virtio: Enable IOMMU_CAP_DERRED_FLUSH
Message-ID: <20231120183833.GA38524@myrica>
References: <20231120-viommu-sync-map-v3-0-50a57ecf78b5@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120-viommu-sync-map-v3-0-50a57ecf78b5@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Niklas,

On Mon, Nov 20, 2023 at 03:51:55PM +0100, Niklas Schnelle wrote:
> Hi All,
> 
> Previously I used virtio-iommu as a non-s390x test vehicle[0] for the
> single queue flushing scheme introduced by my s390x DMA API conversion
> series[1]. For this I modified virtio-iommu to a) use .iotlb_sync_map
> and b) enable IOMMU_CAP_DEFERRED_FLUSH. It turned out that deferred
> flush and even just the introduction of ops->iotlb_sync_map yield
> performance uplift[2] even with per-CPU queues. So here is a small
> series of these two changes.
> 
> The code is also available on the b4/viommu-deferred-flush branch of my
> kernel.org git repository[3].
> 
> Note on testing: I tested this series on my AMD Ryzen 3900X workstation
> using QEMU 8.1.2 a pass-through NVMe and Intel 82599 NIC VFs. For the
> NVMe I saw an increase of about 10% in IOPS and 30% in read bandwidth
> compared with v6.7-rc2. One odd thing though is that QEMU seemed to make
> the entire guest resident/pinned once I passed-through a PCI device.
> I seem to remember this wasn't the case with my last version but not
> sure which QEMU version I used back then.

That's probably expected, now that boot-bypass is enabled by default: on
VM boot, endpoints are able to do DMA to the entire guest-physical address
space, until a virtio-iommu driver disables global bypass in the config
space (at which point the pinned memory is hopefully reclaimed by the
host). QEMU enables it by default to mimic other IOMMU implementations,
and to allow running firmware or OS that don't support virtio-iommu. It
can be disabled with boot-bypass=off

> @Jean-Philippe: I didn't include your R-b's as I changed back to the
> nr_endpoints check and this is like 30% of the patches.

Thank you for the patches. For the series:

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
