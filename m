Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16DED767B4C
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 03:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbjG2BmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 21:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234323AbjG2BmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 21:42:06 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF09549EC
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 18:41:17 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-55c79a5564cso1777452a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 18:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690594875; x=1691199675;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=etHIErEcW2Snp48GMQTn4g9bxzrUdUzMcla8D7qkAKU=;
        b=NYiDMaTVhIAWqq2Ku68RdD957FUpBniR7RICpd5Ta09Re7OeUgl3W+OEMsjWPdln08
         CJUpUT+gN+e7y12/Jmtw9OK/yUGfFrF0aCGTfISkVXFlrfzCfe6JEhpxpQxcSfXu4Zar
         QFlbWgnGGbV2L7tbZ3Ml+7OSARYS6BW1hrXOYGgW8AR729AU438PBsH8dUTu0xLfuOVM
         /cZ/Guv0sEuG/xN+qbxm8Fmks6OZNOYfX087Ejj0cZXQc84D35YWo4l9+6yMV7vnh9WY
         GTn0ni7vkbyhH3Fjlt9O2wGe37ppCa/NiCE1vyOifDl+V3vRrHTZmlxHlaajqNl/WpeH
         cGvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690594875; x=1691199675;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=etHIErEcW2Snp48GMQTn4g9bxzrUdUzMcla8D7qkAKU=;
        b=EeXDmA3KVLPaioREvmTecAEgbdQrTKGSb1fJ8OaEQtCw1izPW+iwrg9D2LRLk45Z0q
         hAPfn69h2AwvHfpgH+p/HPQqmxW6rVP9vd7qGtolIan9hteTp9s7CwLrIINA+X12RZ4A
         N7PsoSqlbHchE12CFoPHgOQG+q8EhmxCwPSDVzdsiscKc7xXumnP2vslGeJDjmSTpIkp
         aNoJd27hlxy6K3ug874ZL5ygVsHghY56AgiYyL4hEIR3WbfG7SQLttylDFzyRkBl0DNY
         9Ex79T1eOb7Q2Xswn6WehePwaL4DZP0lOT1J4cpkHGj8iPkNW8D3cf29kl8fYpzZIt36
         u59g==
X-Gm-Message-State: ABy/qLblWYE21SnzlXfMe6TIlZ5B9MsZSiqK7VxB2HQhQVp3BnxjEKf8
        RTSvHA4L6EwpDWHQRx3eBc+oM+FBgxk=
X-Google-Smtp-Source: APBJJlEgel2xyk023tQstWnd108PwEKYO8pRsbSFOhwxNCzG4vrLLyhebl7F/zmViiPb+nRZMMcJ8NjGMt4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:2445:b0:1bb:c7bc:ce9a with SMTP id
 l5-20020a170903244500b001bbc7bcce9amr13831pls.10.1690594873732; Fri, 28 Jul
 2023 18:41:13 -0700 (PDT)
Date:   Fri, 28 Jul 2023 18:41:12 -0700
In-Reply-To: <20230726135945.260841-1-mlevitsk@redhat.com>
Mime-Version: 1.0
References: <20230726135945.260841-1-mlevitsk@redhat.com>
Message-ID: <ZMRuON4m1qZZWWip@google.com>
Subject: Re: [PATCH v2 0/3] Fix 'Spurious APIC interrupt (vector 0xFF) on
 CPU#n' issue
From:   Sean Christopherson <seanjc@google.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        Borislav Petkov <bp@alien8.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023, Maxim Levitsky wrote:
> Maxim Levitsky (3):
>   KVM: x86: VMX: __kvm_apic_update_irr must update the IRR atomically
>   KVM: x86: VMX: set irr_pending in kvm_apic_update_irr
>   KVM: x86: check the kvm_cpu_get_interrupt result before using it
> 
>  arch/x86/kvm/lapic.c | 25 +++++++++++++++++--------
>  arch/x86/kvm/x86.c   | 10 +++++++---
>  2 files changed, 24 insertions(+), 11 deletions(-)

Paolo, are you still planning on taking these directly?  I can also grab them
and send them your way next week.  I have a couple of (not super urgent, but
kinda urgent) fixes for 6.5 that I'm planning on sending a PULL request for, just
didn't get around to that today.
