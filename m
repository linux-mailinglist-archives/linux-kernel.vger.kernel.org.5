Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FDD180EFD2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 16:14:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376495AbjLLPOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 10:14:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232844AbjLLPOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 10:14:42 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E6DAA
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 07:14:49 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-67acdcb3ccdso41279246d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 07:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1702394088; x=1702998888; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Yf/vxoxAPU7AjoQT7h5u+3hNOV3CcW9wSJKxeUZD+0Q=;
        b=FMl03O02/1497tDPB0e5nBLBRNsm3HXi2heayTfAklnFBMDc57cv33+cTkj7p6u92W
         +m4dH2pTl6glzjTmx7ZwaehYO4vPbW6YPp5NLd6AhCJ3EwUji8582Vew7Ji3CnGUZjMf
         xPIPcgZHVz1Ja0Rnt6+G9m/9pqYFafbGLelVF1ecjGUq1/v8PIhQybD179byBmIkVdvY
         gA9/ZqRjArdVc9iB7uffEVm2CeQdPZsY4mXMmGifmun8o1KslZcPsiFsSc1E15qP2sUU
         faisXOEgIXd4lB2tIv6x5MwZANstTpw2tDE5IfKWdHpcjJjw7Ezlk+HYcB2xijrVE/Uq
         IzFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702394088; x=1702998888;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yf/vxoxAPU7AjoQT7h5u+3hNOV3CcW9wSJKxeUZD+0Q=;
        b=K4FG7WO1BGgm7Gj5HS6NJ6qEHUT7ucB8yWFQtetPF0oCuIw4h9zV+QXzdYj6ujTWJV
         8FjFn0HaIFBXBfOtZAyJBvb8CBU3vRuwGNRmdbJ/az/kE6tt+S66kJx1sm/JuY+HrgAw
         K4K3wcIi3L45S+IX9COkxE6whas+4eQ3d3+L+yxDM9YWrw6KV1TD9UIJTsuQuZUlwFgH
         fgogNidLYB+yiXaTTJqAOLxPNkLe3Ldvn7v0patVz7giRig67FCcxKvGJhsSJu+zV+De
         BDvUPrjHUbic2DynGw1qWSOJlPGq2yyk8/GavSWBpcMtyeFDVP1ijU1uCEpEpgYM5V2b
         Fv4Q==
X-Gm-Message-State: AOJu0YxMqaKOt+fS0i7gClfvaqooxyWz2g6FjzUAOobibCPe2u+nZF/f
        U9tOdl2f8SnXjBPhVtfIK6z9Ag==
X-Google-Smtp-Source: AGHT+IGO0U0gsQvPEQe12yrbRz8NbA/1wHR/0MK9Uqm+C0W3pgcHg4DAVW0sKOtW1Iga6sBwe4Qurg==
X-Received: by 2002:ad4:5146:0:b0:67e:ed9e:d217 with SMTP id g6-20020ad45146000000b0067eed9ed217mr730301qvq.24.1702394088317;
        Tue, 12 Dec 2023 07:14:48 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-134-23-187.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.134.23.187])
        by smtp.gmail.com with ESMTPSA id n7-20020a0ce947000000b0067a53851126sm4267023qvo.98.2023.12.12.07.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 07:14:47 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1rD4T9-00Ck0Y-AN;
        Tue, 12 Dec 2023 11:14:47 -0400
Date:   Tue, 12 Dec 2023 11:14:47 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Yi Liu <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Longfang Liu <liulongfang@huawei.com>,
        Yan Zhao <yan.y.zhao@intel.com>, iommu@lists.linux.dev,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 12/12] iommu: Use refcount for fault data access
Message-ID: <20231212151447.GC3013885@ziepe.ca>
References: <20231207064308.313316-1-baolu.lu@linux.intel.com>
 <20231207064308.313316-13-baolu.lu@linux.intel.com>
 <20231211152456.GB1489931@ziepe.ca>
 <416b6639-8904-4b31-973c-d5522e2731d8@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <416b6639-8904-4b31-973c-d5522e2731d8@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 01:17:47PM +0800, Baolu Lu wrote:
> On 12/11/23 11:24 PM, Jason Gunthorpe wrote:
> > Also iopf_queue_remove_device() is messed up - it returns an error
> > code but nothing ever does anything with it 🙁 Remove functions like
> > this should never fail.
> 
> Yes, agreed.
> 
> > 
> > Removal should be like I explained earlier:
> >   - Disable new PRI reception
> 
> This could be done by
> 
> 	rcu_assign_pointer(param->fault_param, NULL);
> 
> ?

Not without a synchronize_rcu

disable new PRI reception should be done by the driver - it should
turn off PRI generation in the IOMMU HW and flush any HW PRI queues.

> >   - Ack all outstanding PRQ to the device
> 
> All outstanding page requests are responded with
> IOMMU_PAGE_RESP_INVALID, indicating that device should not attempt any
> retry.

Yes

Jason
