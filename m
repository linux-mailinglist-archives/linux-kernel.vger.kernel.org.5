Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 470D27D05C4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 02:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346774AbjJTAS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 20:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346770AbjJTASz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 20:18:55 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE32012D
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 17:18:52 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d9a397a7c1cso341235276.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 17:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697761132; x=1698365932; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oCf557FJxk8CtHL8V069b20YLPs5sHpQLuFktvsDz3M=;
        b=BVFptS7SOmcCCdOP4aVFLYXeQpxufbRjhEEEW234kwzOYVlxB894GNh8R4XhTp6Fou
         lB/pEUDbUwxBKP11P5ihQgoJO2Y8dEyQul0vYw/i2vfuA6Ns7YLmQ8XSKWfq1XWOw3zi
         F/AVpJYxUynvme1bLWPCqSeqzBoyXxu7l9ZfDjFHxGN2ebpPP5HArgzXie97w5AqExSk
         YI4a6w7wTvMIVEjsXwS7p1+xnRFVZGSQXjBa1532hAdjoCT9CDR48WyReoOeR79N22Bv
         YaCqP5vYpMkdy6FA+hXOYQbh+Divavm0mmbV0hhlgkYmGuFBrlnDN56OYkv5CTYdDfqD
         /VMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697761132; x=1698365932;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oCf557FJxk8CtHL8V069b20YLPs5sHpQLuFktvsDz3M=;
        b=thnWqm2mHntctEuK0LFaK/KK78M9LjPEyNrAxcb6YGKP1cnyZuNErz+XvHFyjDr5Jk
         kHqpLuwRkIqV7Jhw4/qmRP/2/4l3SnVbOiHMngmKMWNPhbuzQ2MZ8V+J4jNtJUuJaPN2
         gok/ZonQRXY0IAp81DMjzk5CP+qhMnnabN+EAubuMA4RZZoBfg90/V6+SA6LAdvvdOdn
         l3cQzJy1H3ncHzTzaf4MKmjJY/e6UALefASCs1wcbOtB9eNMWZuI6o7nYLpja2/MK/FS
         jsvuqzclqZAWMQuGuXFMxfLz+w6ExAovf+28CgznOisgFB+pujHoTNsr1eUpWzJAiSqT
         39Wg==
X-Gm-Message-State: AOJu0YzsSc6jyc/0kgR9P7hPmdAw6B/4hnmuTFfrEBWICzu5Oulsv0AF
        th+hHZEMkWvZBVAVtTGMhexVq8LuNnQ=
X-Google-Smtp-Source: AGHT+IHNdE82FHmKAlbJ3pikT/a6fTttzayM7mDKGcRBd0VP/gK3i06z/kOWuvYscfIDXw6n8T/5vlN3mlU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1083:b0:d9a:4f4c:961b with SMTP id
 v3-20020a056902108300b00d9a4f4c961bmr13567ybu.1.1697761132162; Thu, 19 Oct
 2023 17:18:52 -0700 (PDT)
Date:   Thu, 19 Oct 2023 17:18:50 -0700
In-Reply-To: <20230911114347.85882-9-cloudliang@tencent.com>
Mime-Version: 1.0
References: <20230911114347.85882-1-cloudliang@tencent.com> <20230911114347.85882-9-cloudliang@tencent.com>
Message-ID: <ZTHHapdOC0jF23DF@google.com>
Subject: Re: [PATCH v4 8/9] KVM: selftests: Test Intel supported fixed
 counters bit mask
From:   Sean Christopherson <seanjc@google.com>
To:     Jinrong Liang <ljr.kernel@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Like Xu <likexu@tencent.com>,
        David Matlack <dmatlack@google.com>,
        Aaron Lewis <aaronlewis@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jinrong Liang <cloudliang@tencent.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023, Jinrong Liang wrote:
> +static void test_fixed_counters(void)
> +{
> +	uint8_t nr_fixed_counters = kvm_cpu_property(X86_PROPERTY_PMU_NR_FIXED_COUNTERS);
> +	uint32_t ecx;
> +	uint8_t edx;
> +
> +	for (edx = 0; edx <= nr_fixed_counters; edx++)
> +		/* KVM doesn't emulate more fixed counters than it can support. */
> +		for (ecx = 0; ecx <= (BIT_ULL(nr_fixed_counters) - 1); ecx++)
> +			__test_fixed_counters(ecx, edx);

Outer for-loop needs curly braces.
