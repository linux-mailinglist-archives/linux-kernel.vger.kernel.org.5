Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18368800155
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 02:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376572AbjLAB43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 20:56:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231877AbjLAB41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 20:56:27 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00515193
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 17:56:32 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1d04d286b5cso911535ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 17:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701395792; x=1702000592; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=toNsoSXypYSL9uZTcK8jfeH59RKbIqfw62avR9a71VU=;
        b=iQ7L+KFBtHneYZAw/MPGh4SS2rq2wzhUp9CyzgOMZdf2cv+OwTFaoyeDa8Oo2y2HAg
         qgaUKwUjWUVeQHVGyIf1lsFMSXdbQHtcL4zbY1V8OpTUjw8MbHTBv3PUepM3W4eIEGic
         7laSSz7fxywiQzGHUFfj1UmXHeeu7/9l8GfIGaUe5XOoRACm8cxqEcCThKxQCko0/vv6
         n9CHQgIqAXi5z9Ce3v0hu5CdaWiGQoWRw3Ho4oO15UuqOq0dN1/dSKCAtveijkYggwtL
         Im/feQ0zRyCHIpdMwSAgSHWU1fwbm/KQClUQTgGf/S2plHvr1vHv5PJUqJXtcLdRHAEB
         a73Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701395792; x=1702000592;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=toNsoSXypYSL9uZTcK8jfeH59RKbIqfw62avR9a71VU=;
        b=GbfMMjqkR00KEZ1kVtYypbe5tTKNpCKnAfaU0NMHz/GiTvTPhhJJCRHPfZbpp1JDco
         W2F/5pDfmR5pzFr/Amcm62OLvQMr1kcfAR7nzPlzW0N3RCizpQovXMxKBdElFyfgazct
         8exWtG1AjluEqIhi1ZqjfLcSptQvsuggmIEtXpWcL/1qlYujneUVCmIRyQ9KV6+v4wAW
         9kyHOTeSxjZzUaMWtHIo4salI/TNAYztoaDcgTX89p1j8H21P9NG4noSCclsuIRrUTW8
         GT9hFUN3sWPrHC7tIy/GlJ4hmOEuyKFzXZjfBjjSrVggMENTFC4BM1/w03TmvY9Hp3LW
         JxiA==
X-Gm-Message-State: AOJu0YySO3Ca0ja0CtKKrwKd9HWJk7LWamOeCX+WcgNATudNN4g9tdL+
        Pc9mC20ehv1FIY06I4wP9pjJHKvqKYE=
X-Google-Smtp-Source: AGHT+IFuBXykSxmfmDFQrnUbRaNF6JzD+ONDaMRrQBnJw30Dc27VI6NQZPkPz7BUuWZEy4JDvo4LUxLxQis=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:d4cb:b0:1cc:41b4:5154 with SMTP id
 o11-20020a170902d4cb00b001cc41b45154mr5681528plg.13.1701395792418; Thu, 30
 Nov 2023 17:56:32 -0800 (PST)
Date:   Thu, 30 Nov 2023 17:52:28 -0800
In-Reply-To: <20231018193617.1895752-1-seanjc@google.com>
Mime-Version: 1.0
References: <20231018193617.1895752-1-seanjc@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <170137748399.663624.5891433313552244274.b4-ty@google.com>
Subject: Re: [PATCH] KVM: SVM: Explicitly require FLUSHBYASID to enable SEV support
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Oct 2023 12:36:17 -0700, Sean Christopherson wrote:
> Add a sanity check that FLUSHBYASID is available if SEV is supported in
> hardware, as SEV (and beyond) guests are bound to a single ASID, i.e. KVM
> can't "flush" by assigning a new, fresh ASID to the guest.  If FLUSHBYASID
> isn't supported for some bizarre reason, KVM would completely fail to do
> TLB flushes for SEV+ guests (see pre_svm_run() and pre_sev_run()).
> 
> 
> [...]

Applied to kvm-x86 svm, thanks!

[1/1] KVM: SVM: Explicitly require FLUSHBYASID to enable SEV support
      https://github.com/kvm-x86/linux/commit/770d6aa2e416

--
https://github.com/kvm-x86/linux/tree/next
