Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD7897DB25E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 04:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbjJ3D5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 23:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231518AbjJ3D5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 23:57:13 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1700C0
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 20:57:10 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6bb4abb8100so3549645b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 20:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698638230; x=1699243030; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ne8SXDkcXFFwq2DJL9gmjTYE7QsrFEkJZWdUaILBAC8=;
        b=KcatbkYRjGOlJI8A23ZSXDpfHjnify9p0cGIhDRkcJnH8H8mWlZEQ3gWX2W9Zge0fW
         ftTDqLRvKqgk10Jtpqpn7loOKuX7pDDiEnHxRCbLs2sNnRVMaPlAvJ9cmNVEpw+SUjzG
         PBxaNr79D2Cl6EH7O8cexZCW37Skg3YE6Lc/5dDA+Ko+V6SLCcDzb866NeEel6YUUT23
         BdnBfiZHcPFi9P7Un5bPEHQAnK0sWGZyttyxrGhHyN7jJgMiZZfwfEL4MdVfo7nHrXUR
         NBkGjRpry9di8qMRABgJcG+Me+tZm0YdrkDwKtAP7OSss9jTSJ3DcUKptMpjZF3CPh7u
         mcBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698638230; x=1699243030;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ne8SXDkcXFFwq2DJL9gmjTYE7QsrFEkJZWdUaILBAC8=;
        b=MN8fnTz7W4LIfjQlbQnA91TeLwq94iHP1W2zeclpzO5ZvWv8D3w5Ib7Fai/24RfXPi
         +fafi+XCVJ9tzS93UXdez+1+CnmpZCo+usryjLW9ynZbnPU8ag/UjZDW2TtaX6OCPzm0
         RjttV2Yi1QPin/gM5MTE6yrrGiaR7CI7JDozBhFF5xORsxe8m1i1cC69v0L9ME58ATz7
         YDehO9c2rje+ku9B7dNZysC1Zfec1gNgobfg2pHQrIjb1Agi6bdUHS4YPWVygVzRpvgd
         qNz5CXyB6rRAupS5iHyxF20Os2yuVsFoxTSd+X5hPwYh0zBX1z8W4JcOnEvWFjpfINkP
         eWdQ==
X-Gm-Message-State: AOJu0YzhukPz4JP2Khd4oWt6EpEY1Sk9z6gDnieZ8iCdP/6Yj8dpAyDO
        mA2vb/LusJ5EvHeVXLmSC10Z0A==
X-Google-Smtp-Source: AGHT+IFoAgdtfAghj821g9kM1YgGoDdEC6gChDxr4PITFJqr111aBbTmgAn9BDyGIaR80cEFIm61RQ==
X-Received: by 2002:a05:6a00:218d:b0:6b3:55fd:d851 with SMTP id h13-20020a056a00218d00b006b355fdd851mr7660252pfi.10.1698638229341;
        Sun, 29 Oct 2023 20:57:09 -0700 (PDT)
Received: from google.com (60.89.247.35.bc.googleusercontent.com. [35.247.89.60])
        by smtp.gmail.com with ESMTPSA id d5-20020a056a0010c500b006bfb903599esm4913052pfu.139.2023.10.29.20.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Oct 2023 20:57:08 -0700 (PDT)
Date:   Mon, 30 Oct 2023 03:57:04 +0000
From:   Mingwei Zhang <mizhang@google.com>
To:     "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
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
Message-ID: <ZT8pkA28Q8zzDMrp@google.com>
References: <20231024075748.1675382-1-dapeng1.mi@linux.intel.com>
 <ZTmo9IVM2Tq6ZSrn@google.com>
 <719318df-dc19-4f4c-88ff-5c69377f713c@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <719318df-dc19-4f4c-88ff-5c69377f713c@linux.intel.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023, Mi, Dapeng wrote:
> On 10/26/2023 7:47 AM, Mingwei Zhang wrote:
> > On Tue, Oct 24, 2023, Dapeng Mi wrote:
> > > When running pmu test on Intel Sapphire Rapids, we found several
> > > failures are encountered, such as "llc misses" failure, "all counters"
> > > failure and "fixed counter 3" failure.
> > hmm, I have tested your series on a SPR machine. It looks like, all "llc
> > misses" already pass on my side. "all counters" always fail with/without
> > your patches. "fixed counter 3" never exists... I have "fixed
> > cntr-{0,1,2}" and "fixed-{0,1,2}"
> 
> 1. "LLC misses" failure
> 
> Yeah, the "LLC misses" failure is not always seen. I can see the "LLC 
> misses" 2 ~3 times out of 10 runs of PMU standalone test and you could see
> the failure with higher possibility if you run the full kvm-unit-tests. I
> think whether you can see the "LLC misses" failure it really depends on
> current cache status on your system, how much cache memory are consumed by
> other programs. If there are lots of free cache lines on system when running
> the pmu test, you may have higher possibility to see the LLC misses failures
> just like what I see below.
> 
> PASS: Intel: llc references-7
> *FAIL*: Intel: llc misses-0
> PASS: Intel: llc misses-1
> PASS: Intel: llc misses-2
> 
> 2. "all counters" failure
> 
> Actually the "all counters" failure are not always seen, but it doesn't mean
> current code is correct. In current code, the length of "cnt[10]" array in
> check_counters_many() is defined as 10, but there are at least 11 counters
> supported (8 GP counters + 3 fixed counters) on SPR even though fixed
> counter 3 is not supported in current upstream code. Obviously there would
> be out of range memory access in check_counters_many().
> 

ok, I will double check on these. Thanks.

> > 
> > You may want to double check the requirements of your series. Not just
> > under your setting without explainning those setting in detail.
> > 
> > Maybe what I am missing is your topdown series? So, before your topdown
> > series checked in. I don't see value in this series.
> 
> 3. "fixed counter 3" failure
> 
> Yeah, I just realized I used the kernel which includes the vtopdown
> supporting patches after Jim's reminding. As the reply for Jim's comments
> says, the patches for support slots event are still valuable for current
> emulation framework and I would split them from the original vtopdown
> patchset and resend them as an independent patchset. Anyway, even though
> there is not slots event support in Kernel, it only impacts the patch 4/5,
> other patches are still valuable.
> 
> 
> > 
> > Thanks.
> > -Mingwei
> > > Intel Sapphire Rapids introduces new fixed counter 3, total PMU counters
> > > including GP and fixed counters increase to 12 and also optimizes cache
> > > subsystem. All these changes make the original assumptions in pmu test
> > > unavailable any more on Sapphire Rapids. Patches 2-4 fixes these
> > > failures, patch 0 remove the duplicate code and patch 5 adds assert to
> > > ensure predefine fixed events are matched with HW fixed counters.
> > > 
> > > Dapeng Mi (4):
> > >    x86: pmu: Change the minimum value of llc_misses event to 0
> > >    x86: pmu: Enlarge cnt array length to 64 in check_counters_many()
> > >    x86: pmu: Support validation for Intel PMU fixed counter 3
> > >    x86: pmu: Add asserts to warn inconsistent fixed events and counters
> > > 
> > > Xiong Zhang (1):
> > >    x86: pmu: Remove duplicate code in pmu_init()
> > > 
> > >   lib/x86/pmu.c |  5 -----
> > >   x86/pmu.c     | 17 ++++++++++++-----
> > >   2 files changed, 12 insertions(+), 10 deletions(-)
> > > 
> > > 
> > > base-commit: bfe5d7d0e14c8199d134df84d6ae8487a9772c48
> > > -- 
> > > 2.34.1
> > > 
