Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCBF47E6D4A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 16:23:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234485AbjKIPXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 10:23:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232294AbjKIPXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 10:23:11 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF45230DC
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 07:23:08 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5afe220cadeso13499477b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 07:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699543388; x=1700148188; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kigI6ClI5egwqqPJrt8+IeHIdPDCUrXTRQpt6o3p25c=;
        b=GgQtopqGyNnoJUxGoqLTpXHh3YJf0lYuQxp7mtAp7ewXWYpRa9r44HWdSyaudVaf9j
         DkeKPgudRWU6SbEshZOLgaQ2FeTRjP2WCrnZaWX5rokTbFf+4Zy5o6hHqobYS5hfhBTu
         dm64nZeo8lY3ceBejTD6mTkfUQqiwnJl1zxnSqFCHOIUYQs0ijjq1pauTlK+KceuEeHP
         1m6HqJFY1/pARHn87eXGJysI/WUPElqMbiLP4LQcvs7dQDn9ocD8xt8qUvGVBomPg9fg
         aCfELCr9UesRRKnYmNsdlp8mRUO1Ay7uM36X6ESFts2a+6RbpLi6GyS/WQH+pMoQtDhm
         tHZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699543388; x=1700148188;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kigI6ClI5egwqqPJrt8+IeHIdPDCUrXTRQpt6o3p25c=;
        b=epUs88YOHIZ/IavA7aPkIeKVS9KdEMOJPrS1PEKlSpufSRkqDzL5jSirDixLGus32i
         /tEzAR+Wa5+w05wdKOTOeAJG/W432JgeXQ2DOKXsb3hj7mp2ddFXjYJ2j9i8EAkBS/Sl
         kXh2R0bl79rlymL7wlrxTPbk/tm5HivjdpH0rVhUtGthE4dIEOhpq2DWU9trDh9xiyzv
         qzQ+Daj1cdz9QdacpQmpi9B0ZhNPUCnUE62BOb5ukgT2msdmuI9a7ybvtchzR+0WKyly
         COjR5sRtGkHrNDmN0HLiOKDXQPgZvcgl05Z9uSTUF/FSPHPEKXXAR7FjMZZ6iOZq8s71
         BQaQ==
X-Gm-Message-State: AOJu0YzBXizG2VsdsZ1t6i2g3V1+vFE1nLwOBdsuK2SG4QnWdz1S6z1L
        HGiGmQNihdQDXKB0FmOUn1/6zf0VQh4=
X-Google-Smtp-Source: AGHT+IFXnzP17PCTQd37aYqPCT1uLviAELrNiOsHNVjcYyLHD22AsT92khPvu9YBl9QRnes7DTAeBrp7upE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:4e95:0:b0:57a:118a:f31 with SMTP id
 c143-20020a814e95000000b0057a118a0f31mr149451ywb.7.1699543388029; Thu, 09 Nov
 2023 07:23:08 -0800 (PST)
Date:   Thu, 9 Nov 2023 07:23:06 -0800
In-Reply-To: <20231108003135.546002-11-seanjc@google.com>
Mime-Version: 1.0
References: <20231108003135.546002-1-seanjc@google.com> <20231108003135.546002-11-seanjc@google.com>
Message-ID: <ZUz5WrxGf4blspae@google.com>
Subject: Re: [PATCH v7 10/19] KVM: selftests: Test Intel PMU architectural
 events on fixed counters
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Dapeng Mi <dapeng1.mi@linux.intel.com>,
        Jim Mattson <jmattson@google.com>,
        Jinrong Liang <cloudliang@tencent.com>,
        Aaron Lewis <aaronlewis@google.com>,
        Like Xu <likexu@tencent.com>
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023, Sean Christopherson wrote:
> @@ -199,6 +219,22 @@ static void guest_test_arch_event(uint8_t idx)
>  		__guest_test_arch_event(idx, gp_event, i, base_pmc_msr + i,
>  					MSR_P6_EVNTSEL0 + i, eventsel);
>  	}
> +
> +	if (!guest_has_perf_global_ctrl)
> +		return;
> +
> +	fixed_event = intel_event_to_feature[idx].fixed_event;
> +	if (pmu_is_null_feature(fixed_event) || !this_pmu_has(fixed_event))
> +		return;
> +
> +	i = fixed_event.f.bit;
> +
> +	wrmsr(MSR_CORE_PERF_FIXED_CTR_CTRL, FIXED_PMC_CTRL(i, FIXED_PMC_KERNEL));
> +
> +	__guest_test_arch_event(idx, fixed_event, FIXED_PMC_RDPMC_BASE + i,

Grr, this should be an OR, not a SUM, i.e. "FIXED_PMC_RDPMC_BASE | i".  That's
how Like/Jinrong originally had things, but I got confused by the BASE terminology
and "fixed" it.  The end result is the name, but the PMU code is hard enough to
follow as it is.

I'm also going to rename FIXED_PMC_RDPMC_BASE, that is a terrible name that got
copy+pasted from perf.  It's not a base value, it's a single flag that says "read
fixed counters".
