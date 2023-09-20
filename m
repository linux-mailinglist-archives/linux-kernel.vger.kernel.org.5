Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4D257A78EA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 12:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234197AbjITKQM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 20 Sep 2023 06:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234061AbjITKQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 06:16:10 -0400
X-Greylist: delayed 904 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 20 Sep 2023 03:16:01 PDT
Received: from sender11-of-o51.zoho.eu (sender11-of-o51.zoho.eu [31.186.226.237])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34EF0AD
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 03:16:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1695204020; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=aPF06cmUj0A63kCGcCQK8JxxdOlZLE4g5au+qDUpIxUYZv3MQV3Rnxx05dJc2LFMkm2t72132GKI4HSIGkcc84mE53luY3rSEuD80U/3mAR+pPGXAhBReXVb5lu/1zJbguJlb8QRtIN9rBPhcen/DXx1Swpw8c25NPnQVVH7Zxk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1695204020; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
        bh=ivU1Q3Lm3SRkvOu8dDzPYKK2MzEusFDp8L1yK82VhDE=; 
        b=bjXroVLQkynczCeCxqxd0fYRDsxpMhvCMoSkuJY20f4Taree1+gNPDeE4wHXMzYBF1fyInZUlAQm1NHHxfwdUY24svMl7t920LaCl2RCkqMuEdWBYCA47e28tQ5WTiTA+yLCokTIShglDhg6rxAhRBB9rkPtjB0NMBuccoHuN9Q=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        spf=pass  smtp.mailfrom=carl@uvos.xyz;
        dmarc=pass header.from=<carl@uvos.xyz>
Received: from [10.0.0.2] (ip-037-201-240-033.um10.pools.vodafone-ip.de [37.201.240.33]) by mx.zoho.eu
        with SMTPS id 1695204018039776.6738542916296; Wed, 20 Sep 2023 12:00:18 +0200 (CEST)
Message-ID: <0b5c436a9772b3dac647a5981e50881f5c22c137.camel@uvos.xyz>
Subject: Re: [PATCH v1 1/2] mm/ksm: support fork/exec for prctl
From:   Carl Klemm <carl@uvos.xyz>
To:     Stefan Roesch <shr@devkernel.io>, kernel-team@fb.com
Cc:     akpm@linux-foundation.org, david@redhat.com, hannes@cmpxchg.org,
        riel@surriel.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Date:   Wed, 20 Sep 2023 12:00:16 +0200
In-Reply-To: <20230919205158.1897353-2-shr@devkernel.io>
References: <20230919205158.1897353-1-shr@devkernel.io>
         <20230919205158.1897353-2-shr@devkernel.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-ZohoMailClient: External
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-09-19 at 13:51 -0700, Stefan Roesch wrote:
> A process can enable KSM with the prctl system call. When the process
> is
> forked the KSM flag is inherited by the child process. However if the
> process is executing an exec system call directly after the fork, the
> KSM setting is cleared. This patch addresses this problem.
> 
> Signed-off-by: Stefan Roesch <shr@devkernel.io>
> Reported-by: Carl Klemm <carl@uvos.xyz>
> ---
>  include/linux/sched/coredump.h | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/sched/coredump.h
> b/include/linux/sched/coredump.h
> index 0ee96ea7a0e9..205aa9917394 100644
> --- a/include/linux/sched/coredump.h
> +++ b/include/linux/sched/coredump.h
> @@ -87,8 +87,11 @@ static inline int get_dumpable(struct mm_struct
> *mm)
>  
>  #define MMF_DISABLE_THP_MASK   (1 << MMF_DISABLE_THP)
>  
> +#define MMF_VM_MERGE_ANY       29
> +#define MMF_VM_MERGE_ANY_MASK  (1 << MMF_VM_MERGE_ANY)
> +
>  #define MMF_INIT_MASK          (MMF_DUMPABLE_MASK |
> MMF_DUMP_FILTER_MASK |\
> -                                MMF_DISABLE_THP_MASK |
> MMF_HAS_MDWE_MASK)
> +                                MMF_DISABLE_THP_MASK |
> MMF_HAS_MDWE_MASK |\
> +                                MMF_VM_MERGE_ANY_MASK)
>  
> -#define MMF_VM_MERGE_ANY       29
>  #endif /* _LINUX_SCHED_COREDUMP_H */

I can confirm that this patch works as intended for my usecase, you can
have my:

Tested-by: Carl Klemm <carl@uvos.xyz>

