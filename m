Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 192FA7BA94D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 20:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbjJESkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 14:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232100AbjJESkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 14:40:32 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F81EE
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 11:40:30 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-d8afe543712so1505501276.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 11:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1696531229; x=1697136029; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GA7m8rwe0k1pFYhUoJZj68DQDssw+4ZBgs2lOlxIr1I=;
        b=LEch0XlAhw6OtseZwEDnmdU78PK9Oc78c0VN6Wq3OOthXSEA2mdgSZvPbKCS18iwEx
         XGHXQIP176G+LxRLjKiPxRh7LlJAxTQvpbWrNY7gdlcB4gfCTc7zVYzvysMIprGxNCc8
         5zx+kB1E9M0PkANMrXTr2F2kQiAPHamBifjIkBpRuTxAR9gcHoliyJMttLO1UHAHpA69
         Xz15VGDWh0OW9YnZdQCB8wEwXKmS7N0e4wH5XGx9e19/4jgvBeDfxNR16YUGG+7xyd2Z
         zC2wytMME+y3CUkzV8Rzn5t0fZMVDviN2un6pRHdG240UmQN31TzeDtrD97L2fQ6PgKp
         JASQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696531229; x=1697136029;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GA7m8rwe0k1pFYhUoJZj68DQDssw+4ZBgs2lOlxIr1I=;
        b=PeG/X4KPtlBBKidSK3F0dKUrTCKHNHNyKZBMJUa/IzDarbyfXrxuqQ57wqmzljzqcN
         tdPHon6WgorP4Kyo8lnLwgy/ksLuPFrRU7WvUs+oznTiyoq/x/QEeI94tOXES/lLPtkG
         Ia16rx7LJ0rf5SUgnkpWS3DDItyVwJX4U81VChRGWBEuQhOHzty4SOVwrvNuz8RI8o4Y
         RxV6xRrf45v3nemqTExtGNMim35Zlt5m+tB3bGBVLTF66ZF3j3UgwirhY9xQPHIw7+1M
         fgVHwUEb1MLi43Ttg1JOBDcdkxaEQDhMy1fBfcaniY7+TMBZpgsMW7JntCdV7IgSIT0M
         wiLQ==
X-Gm-Message-State: AOJu0YxN0EJ7TRHOWK4/s4H+Rd1Q9RbyJZzLfyXwJ9SvNZ/2VuCyrmjw
        f7tm4Hv0WYjOdAsrb25Gqy+qOA==
X-Google-Smtp-Source: AGHT+IFSdPnLfyqRjiwDBgMR0Mn4eMujqBf/xiPgg8OR5KohHrBUwIBC0U8szG5MhEvW2qYa7uM/JQ==
X-Received: by 2002:a05:6902:1896:b0:d7f:362:1d9a with SMTP id cj22-20020a056902189600b00d7f03621d9amr7698100ybb.2.1696531227223;
        Thu, 05 Oct 2023 11:40:27 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id u14-20020a0cf1ce000000b006560eea8a7esm692821qvl.132.2023.10.05.11.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 11:40:26 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qoTGr-004Z3U-Nt;
        Thu, 05 Oct 2023 15:40:25 -0300
Date:   Thu, 5 Oct 2023 15:40:25 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Tina Zhang <tina.zhang@intel.com>
Cc:     Kevin Tian <kevin.tian@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Michael Shavit <mshavit@google.com>,
        Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/6] iommu: Add mm_get_enqcmd_pasid() helper function
Message-ID: <20231005184025.GS13795@ziepe.ca>
References: <20230925023813.575016-1-tina.zhang@intel.com>
 <20230925023813.575016-3-tina.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230925023813.575016-3-tina.zhang@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 10:38:09AM +0800, Tina Zhang wrote:
> mm_get_enqcmd_pasid() is for getting enqcmd pasid value.
> 
> The motivation is to replace mm->pasid with an iommu private data
> structure that is introduced in a later patch.
> 
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Tina Zhang <tina.zhang@intel.com>
> ---
> 
> Change in v2:
> - Change mm_get_pasid() to mm_get_enqcmd_pasid()
> 
>  arch/x86/kernel/traps.c | 2 +-
>  include/linux/iommu.h   | 8 ++++++++
>  2 files changed, 9 insertions(+), 1 deletion(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
