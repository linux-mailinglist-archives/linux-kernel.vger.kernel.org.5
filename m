Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88C897D78DB
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 01:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbjJYXrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 19:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjJYXrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 19:47:08 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE2613D
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 16:47:06 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c9d922c039so2020075ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 16:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698277626; x=1698882426; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PMB1/GiQQTIiJZvhsIYCOx0hg6B4h+aKw9KU6MvpDV8=;
        b=jA8Dh2H7kf7WYv5hEd0Zf8QXun8YSMiXadvBIJ2uwqhPkeVZsPj7oE8TzQFYKVwn33
         +ydsVe35YzcxvYNNEzJW6gibvBELfSFTd1EB4H/J65ni3gDXt8OdJuwYntTeLv/8mecD
         w6v6Ds9dMyAKXJ26YbG1RAxDJTbiNMcVWtVuQy4S/TD/5IB/N39Uog3B5qnlRlK+bCH0
         NP2zveLVNlwWrwU5D1vKBBVr+ANTigHIx6tPATiNQiNFJ9Z7DkMrAhbJ/yjUoqCTiPCO
         PLiIdFStz8WA5t5Qiwtq40jG+J9fOTTID+IkUhm9ZXUSRJhbsKjgp9jO7H0ng5a2B1d9
         A99w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698277626; x=1698882426;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PMB1/GiQQTIiJZvhsIYCOx0hg6B4h+aKw9KU6MvpDV8=;
        b=hwEWS170QRGcafrg4ZV+32L39k1GtvYzgJDlQfnEwu2QgeT9rHKdFvlz2Q/zaK7KMW
         nOlDEDnJkBg/1h1gkPLoTGfOVhthOYfQVgP0u7cVozEap1Ki2EiacNM93f7FGLogrNIs
         Pu9/E667/rxXcMoo5oxfXVNadxvdlUZPxPPDUGI42MtCfjebxRNJfGuFr2XoP0r8cVu7
         q7cg7e8XoPa7u2ob0JaFXtux4Xn+b/9vwjotWcjQftYM9Ja+MbK6rG2Eew/asnt7F/Td
         xF+V2NJ8rEalKRI7DshCBJJiR21X1TQbH7kAOltp5ieIaPAy7XmIgbs9beFbpSpq+eS5
         9o3w==
X-Gm-Message-State: AOJu0YxvquuO5V+weO4xBQQHQba9QvngVRsfJyxgqwWiui89kvU+pK+6
        XLh8wz8a8NufM5XKhVKtwyTDJw==
X-Google-Smtp-Source: AGHT+IFC+sfzXdin+SwOZnQG/WZCrvMbxnLbGN16wolfDypkoWF5rGlWg0STSpBFiVa7RzS4eO/Tvw==
X-Received: by 2002:a17:903:84c:b0:1ca:1be4:bda4 with SMTP id ks12-20020a170903084c00b001ca1be4bda4mr15202511plb.4.1698277625873;
        Wed, 25 Oct 2023 16:47:05 -0700 (PDT)
Received: from google.com (176.13.105.34.bc.googleusercontent.com. [34.105.13.176])
        by smtp.gmail.com with ESMTPSA id u14-20020a170902e5ce00b001c61901ed2esm9651662plf.219.2023.10.25.16.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 16:47:05 -0700 (PDT)
Date:   Wed, 25 Oct 2023 23:47:00 +0000
From:   Mingwei Zhang <mizhang@google.com>
To:     Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhang Xiong <xiong.y.zhang@intel.com>,
        Jim Mattson <jmattson@google.com>,
        Like Xu <like.xu.linux@gmail.com>,
        Dapeng Mi <dapeng1.mi@intel.com>
Subject: Re: [kvm-unit-tests Patch 0/5] Fix PMU test failures on Sapphire
 Rapids
Message-ID: <ZTmo9IVM2Tq6ZSrn@google.com>
References: <20231024075748.1675382-1-dapeng1.mi@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024075748.1675382-1-dapeng1.mi@linux.intel.com>
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

On Tue, Oct 24, 2023, Dapeng Mi wrote:
> When running pmu test on Intel Sapphire Rapids, we found several
> failures are encountered, such as "llc misses" failure, "all counters"
> failure and "fixed counter 3" failure.

hmm, I have tested your series on a SPR machine. It looks like, all "llc
misses" already pass on my side. "all counters" always fail with/without
your patches. "fixed counter 3" never exists... I have "fixed
cntr-{0,1,2}" and "fixed-{0,1,2}"

You may want to double check the requirements of your series. Not just
under your setting without explainning those setting in detail.

Maybe what I am missing is your topdown series? So, before your topdown
series checked in. I don't see value in this series.

Thanks.
-Mingwei
> 
> Intel Sapphire Rapids introduces new fixed counter 3, total PMU counters
> including GP and fixed counters increase to 12 and also optimizes cache
> subsystem. All these changes make the original assumptions in pmu test
> unavailable any more on Sapphire Rapids. Patches 2-4 fixes these
> failures, patch 0 remove the duplicate code and patch 5 adds assert to
> ensure predefine fixed events are matched with HW fixed counters.
> 
> Dapeng Mi (4):
>   x86: pmu: Change the minimum value of llc_misses event to 0
>   x86: pmu: Enlarge cnt array length to 64 in check_counters_many()
>   x86: pmu: Support validation for Intel PMU fixed counter 3
>   x86: pmu: Add asserts to warn inconsistent fixed events and counters
> 
> Xiong Zhang (1):
>   x86: pmu: Remove duplicate code in pmu_init()
> 
>  lib/x86/pmu.c |  5 -----
>  x86/pmu.c     | 17 ++++++++++++-----
>  2 files changed, 12 insertions(+), 10 deletions(-)
> 
> 
> base-commit: bfe5d7d0e14c8199d134df84d6ae8487a9772c48
> -- 
> 2.34.1
> 
