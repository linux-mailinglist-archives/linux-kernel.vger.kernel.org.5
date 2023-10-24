Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6BFC7D5702
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 17:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343790AbjJXP4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 11:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234938AbjJXP4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 11:56:38 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F0D10E3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 08:56:34 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5a7c95b8d14so44706957b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 08:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698162993; x=1698767793; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rjxp8+OshJaX6HTmER4qwOWebSL28uCYwZrUG7M1dI0=;
        b=irFe4tOUpPfmrQxJxOFBR3ifIS41fyVzV3luVLqHU7X0KdFqWq8BImhZiQW5Bz5uRm
         3AdPo13tvUqJlc9ivsO+TsaBL1EsPIaPJw/iqRmfKH5Gns9LbSeOVF1b+dwQCGJ15UNa
         SMjrC6AsVynBf/4pLZfgWTxLU59a2dSPLmT+3/88h3j3kDN1MT+JqldTWlNq9jjJQHw2
         swfEaoERFk0CwLyhNCe1rePshfrdDn9McuRko7mbeGX4Gua7dfwsInY5ERvSQXqtzpTB
         trhitb/xp0wFBRCc5q+OwLYyHeVx0M9gJ+LvNhG70VIHvUCCepeWiXAx2pxfZ2lBWX8W
         rpGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698162993; x=1698767793;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rjxp8+OshJaX6HTmER4qwOWebSL28uCYwZrUG7M1dI0=;
        b=ktID5p2eo8rcMjN5jDt6I1hsB5XaGvv93iwOpbehv2oZUlm3iUbEv88k4lzDPM+AA9
         YMhpu6EOitBcI5LIi7HFfs377TK5JO2UaQxoJrBjQ7TSPeWe9WkvNqsY1Ykiafm/wu6k
         IbNjXC0FwhbZtx6GzE5+AzkeSGnSbIQF+vBgjaKEortL4oFnsW/Lha/IIxcQwKCNhc3Z
         ZFlzfUDusY0t4V+s3uXUjiluV5Dmxnno43mbEfIkeYsYSedVCCfo0CGdtB2iYaUAgOOt
         FHBxsRLoLO/GHxEvowFje4nW1a1WXxAGWssAmN4l8mIgdJwLKgT6SBAXJbaJ5i+E7nib
         YsUQ==
X-Gm-Message-State: AOJu0YyuBjiwAgpXOtyw3IZRRgHmDa8LaZNTEvTLqx9chjVRCjh8WkLa
        W0IbZiVyFWOLLsUSQ+HwAzIWyQ==
X-Google-Smtp-Source: AGHT+IGIID9UC2iGLP/x4qScEs2HOJYndJ88tB5gJ7g8+EATt+2WBgfMeGi7aFr2+0fEWl2TZbouVw==
X-Received: by 2002:a0d:fd06:0:b0:5a2:15bc:b32c with SMTP id n6-20020a0dfd06000000b005a215bcb32cmr11823780ywf.42.1698162992889;
        Tue, 24 Oct 2023 08:56:32 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id n192-20020a0dcbc9000000b0059f8120ee4dsm4176106ywd.30.2023.10.24.08.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 08:56:32 -0700 (PDT)
Date:   Tue, 24 Oct 2023 08:56:20 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     kernel test robot <lkp@intel.com>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        domenico cerasuolo <mimmocerasuolo@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Christoph Lameter <cl@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Vishal Moola <vishal.moola@gmamil.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, Mel Gorman <mgorman@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Nhat Pham <nphamcs@gmail.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mempolicy: alloc_pages_mpol() for NUMA policy without
 vma: fix
In-Reply-To: <202310241551.uY40myKo-lkp@intel.com>
Message-ID: <38fa4314-3fc7-4e16-fc9d-2773d36a31b1@google.com>
References: <00dc4f56-e623-7c85-29ea-4211e93063f6@google.com> <202310241551.uY40myKo-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Oct 2023, kernel test robot wrote:

> Hi Hugh,
> 
> kernel test robot noticed the following build warnings:
> 
> 
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/UPDATE-20231024-144517/Hugh-Dickins/hugetlbfs-drop-shared-NUMA-mempolicy-pretence/20231003-173301
> base:   the 10th patch of https://lore.kernel.org/r/74e34633-6060-f5e3-aee-7040d43f2e93%40google.com
> patch link:    https://lore.kernel.org/r/00dc4f56-e623-7c85-29ea-4211e93063f6%40google.com
> patch subject: [PATCH] mempolicy: alloc_pages_mpol() for NUMA policy without vma: fix
> config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20231024/202310241551.uY40myKo-lkp@intel.com/config)
> compiler: m68k-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231024/202310241551.uY40myKo-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202310241551.uY40myKo-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>    In file included from mm/zswap.c:41:
>    mm/internal.h: In function 'shrinker_debugfs_name_alloc':
>    mm/internal.h:1232:9: warning: function 'shrinker_debugfs_name_alloc' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
>     1232 |         shrinker->name = kvasprintf_const(GFP_KERNEL, fmt, ap);
>          |         ^~~~~~~~
>    mm/zswap.c: In function 'zswap_writeback_entry':
>    mm/zswap.c:1322:16: error: implicit declaration of function 'get_task_policy'; did you mean 'get_vma_policy'? [-Werror=implicit-function-declaration]
>     1322 |         mpol = get_task_policy(current);
>          |                ^~~~~~~~~~~~~~~
>          |                get_vma_policy
> >> mm/zswap.c:1322:14: warning: assignment to 'struct mempolicy *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
>     1322 |         mpol = get_task_policy(current);
>          |              ^
>    cc1: some warnings being treated as errors

Gaah, thanks for that, I never built it without CONFIG_NUMA=y:
v2 patch with a get_task_policy() without CONFIG_NUMA coming up,
built this time.

Hugh
