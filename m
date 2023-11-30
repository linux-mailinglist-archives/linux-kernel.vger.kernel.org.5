Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 200D57FE657
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 02:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344065AbjK3BoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 20:44:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbjK3BoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 20:44:12 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B168FA0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 17:44:18 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5cd2100f467so6364267b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 17:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701308658; x=1701913458; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gMxLUnirB9hlBqYifVKy9Kl1l6BWOFWxKcWyIczHOPQ=;
        b=Xm3gWY18Q8gpN1ZnDnYiEKqDPyrNMMgw3AVG48JYnOEDUQD2hmSws0V6yAu5cTWLSR
         ZegNu8i92pzD9TGFPvxJb84gk2bxp5hLNfyfbqHSDqJ8wEVdfHekO9pPstqx+aXPTAjt
         khgo7Ynyv/IaJU40dIz7pluESgUbW1ZFMxBqZ8+hJIvttg4Y0LoPfzOf4xcl2zIA0/Hc
         3hoNuxV85lRlQNxVCZ73wz3gtiqCTwkQaw5KhaWEV/3VcphIipItEreMSYs/AdxvEMyN
         Yt18ipquE7eupqBRyRCHyyyPGO2lran5XVrE8s7ruZFgaxMZQrllWnFMLWLlZJwb6N5z
         eChA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701308658; x=1701913458;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gMxLUnirB9hlBqYifVKy9Kl1l6BWOFWxKcWyIczHOPQ=;
        b=dcSaslLZ6NDnjFyJWEL3JBl9y0/DnzVvjR6++NdqoBE6+MXCSU+sfe6i42P5HpgIdC
         8+7HF78vFvJuyCaPbHa039al2jalWvQ3rWMPtzlV5L02Nte4gPMQLisKdS4g4S4uvlfH
         ZLThowIOFP34fqd0PmYprJpKPmRR0PvKkY2BCeoU5rtFVkveg2iq6LIGebwuKM1gwU0c
         1Lt4VV8Xalci78NkkqxMCL1eshk1cvAZN/b8sr+CPXV/Y4hn5f9GjfRP+WFJ8wj6MvO9
         u4M/Qgr9OdLJRe5oZZcPIKm4pN5KLXBEoN3jiyGorskzV3nKnqHu0cAjcxVSwxU536fr
         6YJg==
X-Gm-Message-State: AOJu0YwemC//SrbhkiX29ZFHsjLVvj05lpkOULqP1stvaxfsGfG0Tlua
        6Zdw5b1oIS4EY8rJv2l8Pne8eET4ND0=
X-Google-Smtp-Source: AGHT+IH0VbxQs9f0utAeUg0aQHLKSIYznR55H8CyelgDvZ+FQgLUjl/M/snSfGWBq/yvxlw5sJ4ZnWjJu/U=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:3209:b0:5cc:234f:1860 with SMTP id
 ff9-20020a05690c320900b005cc234f1860mr577492ywb.3.1701308657947; Wed, 29 Nov
 2023 17:44:17 -0800 (PST)
Date:   Wed, 29 Nov 2023 17:44:08 -0800
In-Reply-To: <20231018192325.1893896-1-seanjc@google.com>
Mime-Version: 1.0
References: <20231018192325.1893896-1-seanjc@google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Message-ID: <170129829387.532906.5566625091888881968.b4-ty@google.com>
Subject: Re: [PATCH] KVM: x86/mmu: Declare flush_remote_tlbs{_range}() hooks
 iff HYPERV!=n
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Oct 2023 12:23:25 -0700, Sean Christopherson wrote:
> Declare the kvm_x86_ops hooks used to wire up paravirt TLB flushes when
> running under Hyper-V if and only if CONFIG_HYPERV!=n.  Wrapping yet more
> code with IS_ENABLED(CONFIG_HYPERV) eliminates a handful of conditional
> branches, and makes it super obvious why the hooks *might* be valid.
> 
> 

Applied to kvm-x86 hyperv, thanks!

[1/1] KVM: x86/mmu: Declare flush_remote_tlbs{_range}() hooks iff HYPERV!=n
      https://github.com/kvm-x86/linux/commit/0277022a77a5

--
https://github.com/kvm-x86/linux/tree/next
