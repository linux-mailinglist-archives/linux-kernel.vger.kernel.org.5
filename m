Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB55E79EE30
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 18:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjIMQYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 12:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIMQYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 12:24:16 -0400
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A381CB7;
        Wed, 13 Sep 2023 09:24:11 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2bcfdadd149so122280831fa.0;
        Wed, 13 Sep 2023 09:24:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694622250; x=1695227050;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x3ECGprZP4G16RGe+qK7GG+eKrejw2q8snMfK2wTP5I=;
        b=QeMMBU+S4obMebTMJcHgvMXpBsmJZ1tucPtQgFbL/NPKIRrpPYCW95ah7EJvG4y4Pt
         7PggYk5nH6ZIObBljKsK449/+pD5981WVbVEaXUmvHveK9lpUOB/shHMThC/kttQgtSZ
         CHZzCUBvHKJ7W4Ytpgt2+GnwrYRcnBzEtwCTuRe5jIH0FwwQnvF2gJ1SROGLDrdhG/Km
         3LnBFN9FpGqpU/PWa2cHU+8tP/BN9lfUNYLHDCXp1w2mnS0BocvHCZkUJMewwViFcIiG
         gkNdeaB9B79rsZ3TZkGaXLNdU7tM8Ai15YgoTqSCPVaHeSrT88hiw+hkZWdJL0CNNdli
         nbNA==
X-Gm-Message-State: AOJu0YzKZuUkHY0r0oam5c55+t1NBsPArGFpvuyf6PgBx0NVrjYkFCdk
        3r7/DRAHQRt2sblTqcjBXp0=
X-Google-Smtp-Source: AGHT+IHO5Kq5jnlqD456UUl2gN6+Shv9hSaOmkEwYv9JE6WU+wHrHGCw09hJY98aUmnyFSMf89EOLQ==
X-Received: by 2002:a05:651c:451:b0:2bc:b8f5:aaf1 with SMTP id g17-20020a05651c045100b002bcb8f5aaf1mr2578881ljg.35.1694622249757;
        Wed, 13 Sep 2023 09:24:09 -0700 (PDT)
Received: from gmail.com (fwdproxy-cln-112.fbsv.net. [2a03:2880:31ff:70::face:b00c])
        by smtp.gmail.com with ESMTPSA id kj13-20020a170907764d00b009a1b857e3a5sm8630869ejc.54.2023.09.13.09.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 09:24:09 -0700 (PDT)
Date:   Wed, 13 Sep 2023 09:24:07 -0700
From:   Breno Leitao <leitao@debian.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sandipan Das <sandipan.das@amd.com>, leit@fb.com,
        dcostantino@meta.com,
        "open list:PERFORMANCE EVENTS SUBSYSTEM" 
        <linux-perf-users@vger.kernel.org>,
        "open list:PERFORMANCE EVENTS SUBSYSTEM" 
        <linux-kernel@vger.kernel.org>, Jirka Hladky <jhladky@redhat.com>
Subject: Re: [PATCH] perf/x86/amd: Do not WARN on every IRQ
Message-ID: <ZQHiJxHSSGNk+ul5@gmail.com>
References: <20230616115316.3652155-1-leitao@debian.org>
 <20230616132954.GG4253@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230616132954.GG4253@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Fri, Jun 16, 2023 at 03:29:54PM +0200, Peter Zijlstra wrote:
> On Fri, Jun 16, 2023 at 04:53:15AM -0700, Breno Leitao wrote:
> > On some systems, the Performance Counter Global Status Register is
> > coming with reserved bits set, which causes the system to be unusable
> > if a simple `perf top` runs. The system hits the WARN() thousands times
> > while perf runs.
> > 
> > WARNING: CPU: 18 PID: 20608 at arch/x86/events/amd/core.c:944 amd_pmu_v2_handle_irq+0x1be/0x2b0
> > 
> > This happens because the "Performance Counter Global Status Register"
> > (PerfCntGlobalStatus) MSR has bit 7 set. Bit 7 should be reserved according
> > to the documentation (Figure 13-12 from "AMD64 Architecture Programmer’s
> > Manual, Volume 2: System Programming, 24593"[1]
> 
> Would it then not make more sense to mask out bit7 before:
> 
> +	status &= ~AMD_PMU_V2_GLOBAL_STATUS_RESERVED;
> 	if (!status)
> 		goto done;

Instead of masking `status` against AMD_PMU_V2_GLOBAL_STATUS_RESERVED
(AMD64_NUM_COUNTERS?), I opted for using the `amd_pmu_global_cntr_mask`
global variable because it seems to represent what the loop below is
iterating over:

	/* PMC Enable and Overflow bits for PerfCntrGlobal* registers */
	static u64 amd_pmu_global_cntr_mask __read_mostly;

Also, I think we want to WARN_ON_ONCE() if we see this problem. Right
now, it warns at every time we call this function, which makes the
machine unusable, but, warning it once could be helpful to figure out
there is something wrong with the machine/firmware.

Anyway, please let me know whatever is your preferred way and I will
submit a v2.
