Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8917E5AD1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 17:11:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbjKHQLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 11:11:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbjKHQLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 11:11:07 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 429051FE4
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 08:11:05 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a8ee6a1801so94668477b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 08:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699459864; x=1700064664; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SCyKbBYBcpAJ2v4LwtdWLPucCqpggSO4tuF11LbpeUo=;
        b=Z38J8OwTOMzg0ZKkMEdHyv/RLPGlEISvgB2MZxpkcqKIVJ57SAWDNtLcnc6lpO2LFY
         rhFGFVjHqk2YojbL83tOAT7vSypb3F9pCi0O8cgCArtCwQjz48vcdqd8P+LWtMY0z8Gq
         tvII1XfL0uCq1JjvGeuXx3nRHD4TzZBmkvkB4v1YKeXH+l+Zs6a6hbzqhr9GVdbh9Loz
         ZZAkIEag3smj3s/F5WuSHnX8CvZ+nRSVpRTJ2I12w/mp/fPpaOjHzBaB56ZjAmdzIPd+
         3zW469u2DJ+wQk8CeRN0grCRH7l7w4e0t0JQWVzxHdF0rX70kqjbmUi90+nHKosnakKR
         vF5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699459864; x=1700064664;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SCyKbBYBcpAJ2v4LwtdWLPucCqpggSO4tuF11LbpeUo=;
        b=JKOD0xYebS/ChCJCLvhVSnknViswOWclE38O0LOJpVQhnQFup5bXG5wmu68B2j9vhD
         XAYJrJg53RwqWZBwy/hbG5j8EZWKLyGadLNGNA367+1laBPfhIP2Fh7iV/6InTM/PVOc
         YKepyOpp1itnySqsQO3L3DRgwk8fXshsI/ykK6vD0ADPjVHVJU4a1oY/VeozHogQwsOs
         C594nEHSSEyB2DE7oAHqA+29hMitF079jxdRrB2s4mrS3uaAQfsoSnhEty+PdCqEpO8D
         U6GJ4NgKd8Vl3pVpGFpe4aigRfilmvjs0A+G8CbeeyFHFf4ft1wXMbXC14lMbfXczjdW
         fTvg==
X-Gm-Message-State: AOJu0Yw490QkFlSPajsL2+P9w/2rxsK2mYefqtzMXag74QxfV/UMMrO6
        /9fLpf3akBMp/46oP1vaMjhmZU7RRuo=
X-Google-Smtp-Source: AGHT+IElPBL0TUz47UKKevcrQ52vnzXf3uBAKsqEBbIPFRFkQe5teIswfhYivY589qMtJ1q1v1W1c+yk5QU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:24c:b0:da3:ba0f:c84f with SMTP id
 k12-20020a056902024c00b00da3ba0fc84fmr40900ybs.4.1699459864456; Wed, 08 Nov
 2023 08:11:04 -0800 (PST)
Date:   Wed, 8 Nov 2023 08:11:02 -0800
In-Reply-To: <20231108111806.92604-2-nsaenz@amazon.com>
Mime-Version: 1.0
References: <20231108111806.92604-1-nsaenz@amazon.com> <20231108111806.92604-2-nsaenz@amazon.com>
Message-ID: <ZUuzFshjO7NO5k3b@google.com>
Subject: Re: [RFC 01/33] KVM: x86: Decouple lapic.h from hyperv.h
From:   Sean Christopherson <seanjc@google.com>
To:     Nicolas Saenz Julienne <nsaenz@amazon.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, pbonzini@redhat.com,
        vkuznets@redhat.com, anelkz@amazon.com, graf@amazon.com,
        dwmw@amazon.co.uk, jgowans@amazon.com, corbert@lwn.net,
        kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com,
        x86@kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2023, Nicolas Saenz Julienne wrote:
> lapic.h has no dependencies with hyperv.h, so don't include it there.
> 
> Additionally, cpuid.c implicitly relied on hyperv.h's inclusion through
> lapic.h, so include it explicitly there.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenz@amazon.com>
> ---

FWIW, feel free to post patches like this without the full context, I'm more than
happy to take patches that resolve header inclusion issues even if the issue(s)
only become visible with additional changes.

I'll earmark this one for 6.8.
