Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 565417DD953
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 00:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346960AbjJaXhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 19:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbjJaXhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 19:37:11 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19AEBC9
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 16:37:09 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-5b9615ecd47so1945404a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 16:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698795428; x=1699400228; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZwHYdHsj6Uwfawhe3YKJrgXMDrso8FFgWnxbTx5mjPc=;
        b=sv272kgLIXd+aMp9oEOAjPhiw+fyr1USMGCP4TarM/5D3mO6spRwzZQNJDXXeqCFre
         JF279z+F0Xh+CV/0r4CG8xFPJQaflsCFMuwZsTjMQw5TM28E59DeUho2f/WNucO77I+K
         rUQsaAX4xGdY5z6t48tz9rs3sC2xqn/GJlQRoeV6EzURzP18Y2fAjLJxtbGzanXpyo3Q
         IciN3QoCezTDDEXlMtQYitm0zaPhZgrHvFk4HEn914QLkuCPDxoIuF5auiG0Tg7Qe3Wx
         zGtb92X0AD3wsJ5RZPjOkpZ1CiJ/Ukm8LvqZ14AX6BB//0YRNvckxZsWBG4iP6g1Cx/5
         lkfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698795428; x=1699400228;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZwHYdHsj6Uwfawhe3YKJrgXMDrso8FFgWnxbTx5mjPc=;
        b=DSERh1AVo2wWC2Idqv3G9IpWxmz3bc9FFQc5GF/AkE/JeiottNaixD2h41m54gbVRR
         l7FNaC8rb7b4SpdQRjXB+YgSiRwZpb0ObNV2zWdry1oP1gjppnPZmWkISWUwr/e8St6E
         wUUmAls7CnsaLPSo2TYVaBW83J3S7sj/0zP1+obtIIph9pu7fQ7L8FBt/JfOHKxU6Utz
         cntJBh63vQXFvsTfYQiRbM4MJGsmXK5rmvlSmznOp1mHqn8wTI0CmSBEig0r8FX7+nbc
         GtpsIKt99bTxzUr1ypQCGrHpfWrTIUAF6L72AHWvF59PLrYwh30x39SRVQnO+HyYuI3d
         HPJw==
X-Gm-Message-State: AOJu0Ywq+285S9AnPIZ14HcMyptRRTVA2SCyjKq+z7GT3/N0Go87GXJx
        0dZBp7msS2kc5rrA14NlfJBGxnTGjuI=
X-Google-Smtp-Source: AGHT+IGszvICnLgFRTXinSium5kgpeGfrV1GQxnH0N3W2FHBUTPitXFJJYcg6VYoCyFzg6goTjXUCucj0hM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:7293:b0:1ca:8e79:53b7 with SMTP id
 d19-20020a170902729300b001ca8e7953b7mr235809pll.9.1698795428519; Tue, 31 Oct
 2023 16:37:08 -0700 (PDT)
Date:   Tue, 31 Oct 2023 16:37:06 -0700
In-Reply-To: <20231002095740.1472907-4-paul@xen.org>
Mime-Version: 1.0
References: <20231002095740.1472907-1-paul@xen.org> <20231002095740.1472907-4-paul@xen.org>
Message-ID: <ZUGPosqRPNf155sX@google.com>
Subject: Re: [PATCH v7 03/11] KVM: pfncache: add a helper to get the gpa
From:   Sean Christopherson <seanjc@google.com>
To:     Paul Durrant <paul@xen.org>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Durrant <pdurrant@amazon.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        David Woodhouse <dwmw2@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2023, Paul Durrant wrote:
> From: Paul Durrant <pdurrant@amazon.com>
> 
> A subsequent patch will rename this field since it will become overloaded.

Too. Many. Pronouns.

  Add a helper to get the gpa of a gpc cache, as a subsequent patch will
  rename "gpa" to "addr".

> To avoid churn in places that currently retrieve the gpa, add a helper for
> that purpose now.

This is silly.  If this series added any protection against incorrect usage then
I could understand the helper, but this just end up being

	return gpc->addr_is_gpa ? gpc->addr : INVALID_GPA;

which is nasty.  IIUC, there's no WARN because kvm_xen_vcpu_get_attr() doesn't
pre-check that the cache is in the correct mode.  That's a really silly reason
to not harden the rest of KVM.

> diff --git a/virt/kvm/pfncache.c b/virt/kvm/pfncache.c
> index b68ed7fa56a2..17afbb464a70 100644
> --- a/virt/kvm/pfncache.c
> +++ b/virt/kvm/pfncache.c
> @@ -386,6 +386,12 @@ int kvm_gpc_activate(struct gfn_to_pfn_cache *gpc, gpa_t gpa, unsigned long len)
>  }
>  EXPORT_SYMBOL_GPL(kvm_gpc_activate);
>  
> +gpa_t kvm_gpc_gpa(struct gfn_to_pfn_cache *gpc)
> +{
> +	return gpc->gpa;
> +}
> +EXPORT_SYMBOL_GPL(kvm_gpc_gpa);

Any reason not to make this static inline?  Even in the final form, not making
this inlined seems silly.

Belatedly, same question for kvm_gpc_mark_dirty() I suppose.

>  void kvm_gpc_mark_dirty(struct gfn_to_pfn_cache *gpc)
>  {
>  	mark_page_dirty_in_slot(gpc->kvm, gpc->memslot, gpc->gpa >> PAGE_SHIFT);
> -- 
> 2.39.2
> 
