Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19A887BA96E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 20:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjJEStU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 14:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231710AbjJEStR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 14:49:17 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D9A598
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 11:49:16 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-419c8911049so7644201cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 11:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1696531755; x=1697136555; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ftxOEPJW1rckghtvt8DSd7lLtI0tEVMwZjbURy6macw=;
        b=e0yuDN5qpOWOdV3BcnR/KnMOcowHIPsqaRGdWLeorxPxeUWUpcimL2Sj2kXls4DeOj
         hNOallEYkr3ZN4nlkXEC99FROtTelp1PEzQQiAup8gche0pNe5Iml5oO9y8MDysirJTN
         5S5v020yHdQ4ORJHv/VFsa67/Yf9qAV9kyv/EUsDj54nrmPfiXRWA40nSQl6Kv15eWq8
         Qd0/1t/IWn4iy+aTSkvQp7bQaqM+Nf7wvaaV58/mA0UamT7tWI575UiEUJhAon4fZi3x
         hlNVTbJNWRyHf9KaadPWZiE/7bPs6r6r8iQ9qCwlxcjJUyflONPFKZRFsKJsbw4vZoTD
         7RwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696531755; x=1697136555;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ftxOEPJW1rckghtvt8DSd7lLtI0tEVMwZjbURy6macw=;
        b=PFfncJFOVIbstnIJQuKTEoTrk893ma0S2mOQjzJ7e0qOW37Th+rH7V4KLyA8qm7Ijs
         uXor6GRAAYm9Dd0+NWl5CP6UaHIy1Do2LkVJ9cIrmc8H/P50jHH8S658rx2KTAuln6wn
         e3wnfntzHFXV/bRclzv8lJyEnC5OZxQ0bf3U2di/Du5+GqXDL8idZOM4Apsuk5h8FC84
         8n913WErEuWMOnBNXwYK1b4/xaEvlfapwAMiRhuB6fNQoEDWtFRgIeBEYrxwiB6Ykdj2
         16K/LrEZk46roIXPYVDMQ002aZHYJZQ4leu3QL/NO/ocfJEk4BcL9YlztPJg91Ij+zeG
         tsVA==
X-Gm-Message-State: AOJu0Yx/J2hKSp7e37sL4sU/vypI2nvWBlA7qn9yFgdjlz9cgdWvQlLP
        bZf9G1jvvQniOET6kJFQ85W/rQ==
X-Google-Smtp-Source: AGHT+IFS7T8aTHEEQCpK5XZbn9bYJAs8GTcH67a+kIKA/dbNAgv/8+/6Fb+kHkwEyNlWV7wHeziYWw==
X-Received: by 2002:ac8:58d0:0:b0:403:ed26:4083 with SMTP id u16-20020ac858d0000000b00403ed264083mr7375927qta.61.1696531755314;
        Thu, 05 Oct 2023 11:49:15 -0700 (PDT)
Received: from ziepe.ca ([142.68.26.201])
        by smtp.gmail.com with ESMTPSA id m3-20020ac84443000000b0041520676966sm674475qtn.47.2023.10.05.11.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 11:49:14 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qoTPM-004Z7D-Cd;
        Thu, 05 Oct 2023 15:49:12 -0300
Date:   Thu, 5 Oct 2023 15:49:12 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Tina Zhang <tina.zhang@intel.com>
Cc:     Kevin Tian <kevin.tian@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Michael Shavit <mshavit@google.com>,
        Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/6] mm: Add structure to keep sva information
Message-ID: <20231005184912.GU13795@ziepe.ca>
References: <20230925023813.575016-1-tina.zhang@intel.com>
 <20230925023813.575016-5-tina.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230925023813.575016-5-tina.zhang@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 10:38:11AM +0800, Tina Zhang wrote:
> Introduce iommu_mm_data structure to keep sva information (pasid and the
> related sva domains). Add iommu_mm pointer, pointing to an instance of
> iommu_mm_data structure, to mm.
> 
> Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Tina Zhang <tina.zhang@intel.com>
> ---
>  include/linux/iommu.h    | 5 +++++
>  include/linux/mm_types.h | 2 ++
>  2 files changed, 7 insertions(+)

This is fine, but you could probably squash patches 4/5/6

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
