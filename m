Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 523117A000A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 11:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236995AbjINJax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 05:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231925AbjINJaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 05:30:52 -0400
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9642BB;
        Thu, 14 Sep 2023 02:30:47 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5009d4a4897so1273330e87.0;
        Thu, 14 Sep 2023 02:30:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694683846; x=1695288646;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yhzrQcFYanuR/rryCQ3vIG4JSnBo0za/RItuZJ05BA0=;
        b=dS0nihStM9e9N+Qfccds9GaP1lqYkV0qq5Wg404tiBNwsXjwZEctkNPwARZzrKLzwf
         b0CM8pG73maTJKtQJLA5MMlwaTm1K7FR0VN9Gt5SL4FPjLsQ5nqvsVaz+Zm958rtAzv5
         u6L509iPg62K4kt6h2lpcxuIT0ZLkyO0LZgIOZ+txJx6faS89gxFcOFCuYtvn2V6rN1K
         PcyuHaSGAbnF0XgAMa1qs64UjH0cMO2ZaKmm4fOcN57ALqDADpzcVdOCEv2h3Xc9VT3/
         4HnbDFrQOOE5jLm0cRtW6JlJqV/QrgCubSf3ybAVd7NBuklGndGYl+1dGoM5CBwg1kTg
         rZ6Q==
X-Gm-Message-State: AOJu0Yxejx2gMztS9ebqc42Vg3K1QX7kN0d18Aw5N2bdYzZTrhZ2TsQF
        Ohnd6XSvsUfaPgoJrvNoU8U=
X-Google-Smtp-Source: AGHT+IEqHcW6/vrmEkBozWYmgnSNm1KHLcN6q9dWz1WjomwtZAJPjz4Nn4gfbzgmeBPQTZvA+CYg5Q==
X-Received: by 2002:a19:ae09:0:b0:4ff:7046:984a with SMTP id f9-20020a19ae09000000b004ff7046984amr3890530lfc.7.1694683845507;
        Thu, 14 Sep 2023 02:30:45 -0700 (PDT)
Received: from gmail.com (fwdproxy-cln-000.fbsv.net. [2a03:2880:31ff::face:b00c])
        by smtp.gmail.com with ESMTPSA id d16-20020aa7d690000000b0052a3aa50d72sm684159edr.40.2023.09.14.02.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 02:30:45 -0700 (PDT)
Date:   Thu, 14 Sep 2023 02:30:43 -0700
From:   Breno Leitao <leitao@debian.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Sandipan Das <sandipan.das@amd.com>,
        Jirka Hladky <jhladky@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
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
        "H. Peter Anvin" <hpa@zytor.com>, leit@fb.com,
        dcostantino@meta.com,
        "open list:PERFORMANCE EVENTS SUBSYSTEM" 
        <linux-perf-users@vger.kernel.org>,
        "open list:PERFORMANCE EVENTS SUBSYSTEM" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] perf/x86/amd: Do not WARN on every IRQ
Message-ID: <ZQLSw6PeUbV+p2gH@gmail.com>
References: <20230616115316.3652155-1-leitao@debian.org>
 <20230616132954.GG4253@hirez.programming.kicks-ass.net>
 <ZQHiJxHSSGNk+ul5@gmail.com>
 <CAE4VaGBXO5Joynan_o13XpT=mNrwt4D84NTZF6H62GXJjpMbBA@mail.gmail.com>
 <f06ef3dd-dd71-4ba4-a4fa-18a08788c035@amd.com>
 <20230914091234.GE16631@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914091234.GE16631@noisy.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 11:12:34AM +0200, Peter Zijlstra wrote:
> On Thu, Sep 14, 2023 at 02:25:40PM +0530, Sandipan Das wrote:

> > I agree with using WARN_ON_ONCE() to make this less intrusive.
> 
> Could you send a patch that AMD is happy with?

Why the current patch is not good enough?
