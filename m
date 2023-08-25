Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0071F789249
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 01:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbjHYXRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 19:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbjHYXRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 19:17:20 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB98F26BB
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 16:17:11 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d7494be34f8so1825233276.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 16:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693005431; x=1693610231;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IbA16e4G5FTrEyMeWKj8UXENnQA5tEiZF2o6wpVFWAU=;
        b=thv0HRAWuOFftasB16yDDl3uAPY9b/6f559qheYS39Vin0ldCLBOm9TytR75fPnHwS
         hgw6yLwxviL95z7V8ENoLLLiyBOPpoO3JmalTMAFuQeCXbwGT/cr7mMbNhjmr9fZCwt/
         rOgwb2f41MmlkyLyrua2Fpbxrjmg1RPRwjlhTLHQahs8M7eGLe9x7pnGMmH1pqbShlA4
         v+pD8MH2FbC8A5MrFfqimysQJwLMF6xsV32nrBuj/xve+niPujxhadsqCgZSIZTuQ+vk
         Iedeud8IqCtHnBax1ms32mQmqrfFY/XLLH1QNoS3zgltqJOdprJk9uNZ9BtvWNFUW3wx
         wlsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693005431; x=1693610231;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IbA16e4G5FTrEyMeWKj8UXENnQA5tEiZF2o6wpVFWAU=;
        b=IA2D5hSFZAWKoq8N7XM1NZqpInRTZbk+CMI7c1TPD2UvLxFn/MPkiMDoLKHLoO7NTD
         kc3nPeFJ/F9anDRwJqDSCTS3zXDufyu2TsChH3ZG1cl7F1XWe9HT8dCI5Czxdgufj5oT
         3qpfHlRnBPjJBWGyaeQNveC4rW/FQrcqH0UaUss539+rI5kVgqGm9PKtFhprxOtGvYcW
         LG/8w/VmGHizZ+wAPWRw0CfLXS3lzfC3Jfpxd1vX97wUR61mSTzS7XYZSeDuqh9DIyLp
         hW9TOeWYoU82O5Ub5egF/cBV+eQRLqEVZ0suPS9DLBIyGSCLy2Cb59GxONEFp0vVEeMt
         P+JA==
X-Gm-Message-State: AOJu0YzcbYyT5fuAV1xJYOiJv0LB6LuvEldKavouPT6KrzHydg83ngI4
        58fdPUWzveWrB/hw8J6u9ilOrY6eTss=
X-Google-Smtp-Source: AGHT+IFTiUVRDswF1MCfPVgkxj0gqCmd6KaPLl8CBqEY/4jKQt6W6PXso8zzm5KnsMxtD2+p2IzF0da1OQc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:106:b0:d77:984e:c770 with SMTP id
 o6-20020a056902010600b00d77984ec770mr425695ybh.5.1693005431047; Fri, 25 Aug
 2023 16:17:11 -0700 (PDT)
Date:   Fri, 25 Aug 2023 16:17:09 -0700
In-Reply-To: <20230714064656.20147-1-yan.y.zhao@intel.com>
Mime-Version: 1.0
References: <20230714064656.20147-1-yan.y.zhao@intel.com>
Message-ID: <ZOk2dSCdc693YOKe@google.com>
Subject: Re: [PATCH v4 00/12] KVM: x86/mmu: refine memtype related mmu zap
From:   Sean Christopherson <seanjc@google.com>
To:     Yan Zhao <yan.y.zhao@intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, chao.gao@intel.com, kai.huang@intel.com,
        robert.hoo.linux@gmail.com, yuan.yao@linux.intel.com
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023, Yan Zhao wrote:
> This series refines mmu zap caused by EPT memory type update when guest
> MTRRs are honored.
> 
> Patches 1-5 revolve around utilizing helper functions to check if
> KVM TDP honors guest MTRRs, TDP zaps and page fault max_level reduction
> are now only targeted to TDPs that honor guest MTRRs.
> 
> -The 5th patch will trigger zapping of TDP leaf entries if non-coherent
>  DMA devices count goes from 0 to 1 or from 1 to 0.
> 
> Patches 6-7 are fixes and patches 9-12 are optimizations for mmu zaps
> when guest MTRRs are honored.
> Those mmu zaps are intended to remove stale memtypes of TDP entries
> caused by changes of guest MTRRs and CR0.CD and are usually triggered from
> all vCPUs in bursts.

Sorry for the delayed review, especially with respect to patches 1-5.  I completely
forgot there were cleanups at the beginning of this series.  I'll make to grab
1-5 early in the 6.7 cycle, even if you haven't sent a new version before then.
