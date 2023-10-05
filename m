Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79FD37BA959
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 20:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbjJESoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 14:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjJESoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 14:44:12 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA1790
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 11:44:10 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-7757523362fso84240385a.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 11:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1696531450; x=1697136250; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bv9JmOKZp2Hb05ZdRhbebweP3aei/gOx0hJ6idhzHDo=;
        b=dmf58RTwgMd/RCWQ6fVHHyBQpywvRlVQwGEvLdVm02BWV3ZrJqu0v8YvTuasrLieoE
         wpAeUZ1/SKyOSW4h5NaZq8PCyFz+bLLyy1edMIOiCLtDP1TxXPKAhWcsVfocu0RSdtn5
         tnjE/H797uubUvCBKy9YBYJgu6ptVTHExIfdZIxckjMvcwF13L3L0MM6mbdtcNfzBVaf
         g2E2sTL+nA5IfOz6Ro+oxdQIKmzNuWb7X7cPnUp1iMxAzEoFrH6tTYIPGTU0+/+kmf+U
         FnQ4y/WkjYpHIE0RoORgvbkv4cFnyB+ONRUPEqYq+y81iZVaYAq4grb/CHAEG+y0sIQ4
         1VFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696531450; x=1697136250;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bv9JmOKZp2Hb05ZdRhbebweP3aei/gOx0hJ6idhzHDo=;
        b=X0G1APhCoc3BEOy/C9sFP9B2EKhPIMuE6wzQ1IDIzVqonuPfTJEZ+j5oHmcgmXSjPv
         I+uT3HhHeIwbUbnEvY2WO52D7ysE86W9VYAATUTVwo/G6M2yyvvStgj7I/d087+ryyZN
         hkYrnwzEI4IiWJ73FI1sZg5W652jUx71s5WPGGdU09gPHEfkJ4qYl3bYnjpgehU63TWA
         GE+1KN/2FMMrF4c41h2XT4oy5etKfZ++gRWeHp7JVqANlrhobB7Poa+4Jcg/GiGGSqsJ
         XWdrFAsgiM+PIrhNCWYvOhAmJxUZ3ge+7Xjbkbd0RB9FUzAKpHd8KV6dmMxQ4Ul1j9pZ
         POEw==
X-Gm-Message-State: AOJu0YyXRNNezvvGo6cUJ8MN8rj+d7AuZyolLuu0AuYGSQDZ7+0BDZ+U
        sSvCj3I6LLKiwBWe8wFwTwP6XQ==
X-Google-Smtp-Source: AGHT+IGpRjhmIMTuQ+m//sL6RHcvn5cUvDqoQah3pNtQOHd+HXQ6N6hjpVFl1hyzdYjzT33Zbzlukw==
X-Received: by 2002:a05:620a:2953:b0:775:cf5f:8a81 with SMTP id n19-20020a05620a295300b00775cf5f8a81mr5961620qkp.62.1696531450088;
        Thu, 05 Oct 2023 11:44:10 -0700 (PDT)
Received: from ziepe.ca ([142.68.26.201])
        by smtp.gmail.com with ESMTPSA id e2-20020a05620a208200b0076cb1eff83csm687090qka.5.2023.10.05.11.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 11:44:09 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qoTKO-004Z4y-3f;
        Thu, 05 Oct 2023 15:44:04 -0300
Date:   Thu, 5 Oct 2023 15:44:04 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Tina Zhang <tina.zhang@intel.com>
Cc:     Kevin Tian <kevin.tian@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Michael Shavit <mshavit@google.com>,
        Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/6] iommu: Introduce mm_get_pasid() helper function
Message-ID: <20231005184404.GT13795@ziepe.ca>
References: <20230925023813.575016-1-tina.zhang@intel.com>
 <20230925023813.575016-4-tina.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230925023813.575016-4-tina.zhang@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 10:38:10AM +0800, Tina Zhang wrote:

> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index a4eab6697fe1..db2510da28c1 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -1189,10 +1189,14 @@ static inline bool mm_valid_pasid(struct mm_struct *mm)
>  {
>  	return mm->pasid != IOMMU_PASID_INVALID;
>  }
> -static inline u32 mm_get_enqcmd_pasid(struct mm_struct *mm)
> +static inline u32 mm_get_pasid(struct mm_struct *mm)

This should not be in a global header

Put the mm_get_pasid() in iommu-sva.c as a helper

Have SMMUv3 call mm_get_enqcmd_pasid() for now, it will be fixed

There is no "mm_pasid" that should leak outside of iommu-sva.c except
specifically to support enqcmd.

Jason
