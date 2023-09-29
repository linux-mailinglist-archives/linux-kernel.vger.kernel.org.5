Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2A317B29E1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 02:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232481AbjI2Am2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 20:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232303AbjI2AmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 20:42:25 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED4D194
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 17:42:23 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1c61aafab45so102500185ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 17:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695948143; x=1696552943; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LHnl2CsLxrfQz4bzbwJAj223y7XyxSn5JpaUfYsfSDE=;
        b=rC1/WGQGD7SZLSycCz9NRY4e71edtsK2IX3bbn6OuMS8KtS3xBBxX+YbzEBoQx+WWI
         yR1GtfF2TV8Lam5xWApyMqRy4O2Nec4K0Fyj+wWl5C3UcAaK7UtYRVvQBgInXGaHIon3
         LMcwIF99+jHB/C1fChwXUfLb6EGQ3KC15/SI1hSs1X+T+tUYLVzY4DIk1JHnghsNlSts
         qEL+AMNKgEe0iXvO9BKE3NR/in/dEvc8r1Zeof3kNcgyTLV1Ivi6w+RrCiIGOdZ9uKhu
         4TSH/YkeswaD1yWzlmgZGIghpoW58KEC2rJKv6ye9+OcLcvCVNuEHFjTan+/Y8jNUHHs
         PTfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695948143; x=1696552943;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LHnl2CsLxrfQz4bzbwJAj223y7XyxSn5JpaUfYsfSDE=;
        b=GEijbvfc3Voj8nxjTrIaWFp1FnMrxYA6yS9PXTxBaDkqTWeTNnTEfzgNoMqM//3orr
         uuSsXe2JzfTalRVfGh0IYaTj1daswGuhy9hEdJWDZADKrWC+5UrJD1iutohRU///2Xs7
         f9Jye7ocPIlxM/qqeAQ7ubY82p/F8FHLyXRfZbli240sRi5bGJZlC8pdEYf5YGI8T3nt
         JKzSkpjSkQMcFObYukAp//cL0Y4wwiKM4XScoNSE9QT0+tsiGfHP/cz/KA+SlG4Ilx3G
         +8xzB8AuX+m2q94nPCfjdiKvyQjU7lGNzqyMETZqmZT1Ju4PuvoW/WpockZn9+b3FxFU
         u0Iw==
X-Gm-Message-State: AOJu0Yxp/i/4Ya+JCVg0a08LVv1hzfEyn7makf1WlOjyAf75pYnqswjm
        WjqXuP9Nk947nFro3oXh37dpZ8F4w+4=
X-Google-Smtp-Source: AGHT+IHUEPW3H4eE8hL9x01DrF8EV6/qXIdYZHJV+3Ch6SWg/Ia5upLk5S9Kq+TjsAHT50edQJbCK+giAKY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:e851:b0:1c6:2b9d:570b with SMTP id
 t17-20020a170902e85100b001c62b9d570bmr34467plg.7.1695948142799; Thu, 28 Sep
 2023 17:42:22 -0700 (PDT)
Date:   Thu, 28 Sep 2023 17:42:20 -0700
In-Reply-To: <20230928173354.217464-3-mlevitsk@redhat.com>
Mime-Version: 1.0
References: <20230928173354.217464-1-mlevitsk@redhat.com> <20230928173354.217464-3-mlevitsk@redhat.com>
Message-ID: <ZRYdbJNY3ldYKgEk@google.com>
Subject: Re: [PATCH v2 2/4] x86: KVM: SVM: add support for Invalid IPI Vector interception
From:   Sean Christopherson <seanjc@google.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     kvm@vger.kernel.org, iommu@lists.linux.dev,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Joerg Roedel <joro@8bytes.org>,
        x86@kernel.org,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2023, Maxim Levitsky wrote:
> In later revisions of AMD's APM, there is a new 'incomplete IPI' exit code:
> 
> "Invalid IPI Vector - The vector for the specified IPI was set to an
> illegal value (VEC < 16)"
> 
> Note that tests on Zen2 machine show that this VM exit doesn't happen and
> instead AVIC just does nothing.
> 
> Add support for this exit code by doing nothing, instead of filling
> the kernel log with errors.
> 
> Also replace an unthrottled 'pr_err()' if another unknown incomplete
> IPI exit happens with vcpu_unimpl()
> 
> (e.g in case AMD adds yet another 'Invalid IPI' exit reason)
> 
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---

Reviewed-by: Sean Christopherson <seanjc@google.com>
