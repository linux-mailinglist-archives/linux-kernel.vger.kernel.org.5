Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84D238049BA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 07:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344317AbjLEGGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 01:06:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231695AbjLEGGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 01:06:30 -0500
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4C12C3
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 22:06:36 -0800 (PST)
Message-ID: <29bd5cc7-e8e6-4a4d-b526-651c7885a185@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1701756394;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VsRmRaEO4PHPFPipHn4Io6Xoy0VdHjTgPWI63DWkYRg=;
        b=iL1kmkQBwgGP924gLcS8obFI0W5s4W9Aku7Jcm3vSTqi6rx5Mvh285Mwy61qfNg3mYiog8
        KTi3Ed8WTVAKvMMRpyDjz1MvA+/v740gqdInX9TlLgET/I41EfgBEQ2JuKT6dSqrzX5Mhi
        mL1tz3beobO6pup7osZZmRP9/24ObJo=
Date:   Tue, 5 Dec 2023 14:06:29 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v5 9/9] slub: Update frozen slabs documentations in the
 source
Content-Language: en-US
To:     "Christoph Lameter (Ampere)" <cl@linux.com>
Cc:     vbabka@suse.cz, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
References: <20231102032330.1036151-1-chengming.zhou@linux.dev>
 <20231102032330.1036151-10-chengming.zhou@linux.dev>
 <dd73fdd6-b093-b32a-85a3-25cd22c21652@linux.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <dd73fdd6-b093-b32a-85a3-25cd22c21652@linux.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/12/5 05:41, Christoph Lameter (Ampere) wrote:
> On Thu, 2 Nov 2023, chengming.zhou@linux.dev wrote:
> 
>> From: Chengming Zhou <zhouchengming@bytedance.com>
>>
>> The current updated scheme (which this series implemented) is:
>> - node partial slabs: PG_Workingset && !frozen
>> - cpu partial slabs: !PG_Workingset && !frozen
>> - cpu slabs: !PG_Workingset && frozen
>> - full slabs: !PG_Workingset && !frozen
> 
> The above would be good to include in the comments.
> 
> Acked-by: Christoph Lameter (Ampere) <cl@linux.com>
> 

Thanks for your review and suggestion!

Maybe something like this:

diff --git a/mm/slub.c b/mm/slub.c
index 623c17a4cdd6..21f88bd9c16b 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -93,6 +93,12 @@
  *   by clearing the PG_workingset flag when moving out of the node
  *   partial list. Please see __slab_free() for more details.
  *
+ *   To sum up, the current scheme is:
+ *   - node partial slab: PG_Workingset && !frozen
+ *   - cpu partial slab: !PG_Workingset && !frozen
+ *   - cpu slab: !PG_Workingset && frozen
+ *   - full slab: !PG_Workingset && !frozen
+ *
  *   list_lock
  *
  *   The list_lock protects the partial and full list on each node and
