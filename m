Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 490807DD964
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 00:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376898AbjJaXwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 19:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346938AbjJaXwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 19:52:33 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7622ABD
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 16:52:31 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1cc1ddb34ccso36028355ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 16:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698796351; x=1699401151; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QJGVDo956lsRbHhZKnYMhq4TnDnKN6pAbpTw19FM6i8=;
        b=I5MnARlBx9KTT19JggHNI9kDe2sxMwT6OvMbCnxoVj3uJ3hhmGy3QprSlVXwjJ0L1e
         YLmSlek6faeGMgiXPgxeI06cod6FOH+rQUefbtJYCfKxqfre50OySJhMubxq4T0FPXLn
         qLtwWH4qWajS+wdwKWLUJdKIViomTKMcKZOPtDPV3GHAdwNR1eVkAiNs0tWEw2oQoGko
         AY37mUNJRDYJTtMbW34PrwfRZnHZVR8tYjFAaAWaPs2ojbsrHnTzAKuqsaxkb6RzZgZ6
         AkCQ82gXVr+TSWqxtuhaUL48dkReJqpDhsXQkOAoGxlwSIlzebx4xFTmsBqIG1mUXfdX
         Pzmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698796351; x=1699401151;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QJGVDo956lsRbHhZKnYMhq4TnDnKN6pAbpTw19FM6i8=;
        b=FhToLJpzWgAwgFunBwEpgKeDWd3MbtX2L1rKYbaeUfFtzx5IqY2LP9Afb+jCljClR7
         dfGcOPDTvHlU4Jio8eAsaGhoXE9SckOzTaho5ynSg8RUZHYSh6aDztvqoJk48WVkgdLn
         oVYjAhRTALMg2Jmm7JspeT+PO7kEq+bBmXWCrZlctJjdff/um9nDoruDC790jNtBLKPE
         iuhPquabaV0PU8kSR7mWQF34AHPNZ/QuvgyMU+cbPWuhm5fFuZHUH0ak9Ge26o9Ap9Yg
         U9A1QUSJt+OZlySMc/7h18+HlQsSh6DA5DP/tv/2pyXccq4qnKhTa7QVYtruu7IjkGHw
         5Rbg==
X-Gm-Message-State: AOJu0Yx0Gn2zZeKSqrWBlldCKQSUOT+fhyL7Pzh2uWuudya+rC/QMqcg
        9qayURjgJ4E14J3qeBsLYxyu/FjjCEA=
X-Google-Smtp-Source: AGHT+IHcOfYzryqSt7FitiHZaz16AzszR9kQOx7pWzPPL2II9dBk3FFbIGHTRJcc4RLjWHHfnly2DK2AufE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:8695:b0:1cc:1137:2158 with SMTP id
 g21-20020a170902869500b001cc11372158mr229139plo.11.1698796350946; Tue, 31 Oct
 2023 16:52:30 -0700 (PDT)
Date:   Tue, 31 Oct 2023 16:52:29 -0700
In-Reply-To: <20231002095740.1472907-7-paul@xen.org>
Mime-Version: 1.0
References: <20231002095740.1472907-1-paul@xen.org> <20231002095740.1472907-7-paul@xen.org>
Message-ID: <ZUGTPZLRcHRajtYB@google.com>
Subject: Re: [PATCH v7 06/11] KVM: xen: allow shared_info to be mapped by
 fixed HVA
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
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2023, Paul Durrant wrote:
> NOTE: The change of the kvm_xen_hvm_attr shared_info from struct to union
>       is technically an ABI change but it's entirely compatible with
>       existing users.

It's not an ABI change, is it?  Userspace that picks up the new header might generate
different code on a rebuild, but the actual ABI is unchanged, no?

> @@ -684,6 +692,14 @@ int kvm_xen_hvm_get_attr(struct kvm *kvm, struct kvm_xen_hvm_attr *data)
>  		r = 0;
>  		break;
>  
> +	case KVM_XEN_ATTR_TYPE_SHARED_INFO_HVA:
> +		if (kvm->arch.xen.shinfo_cache.active)

As requested in previous patches, please explicitly check that the cache is in
the right "mode".

> +			data->u.shared_info.hva = kvm_gpc_hva(&kvm->arch.xen.shinfo_cache);
> +		else
> +			data->u.shared_info.hva = 0;
> +		r = 0;
> +		break;
