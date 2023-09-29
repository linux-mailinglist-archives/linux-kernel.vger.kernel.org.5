Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 966387B3794
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 18:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233647AbjI2QLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 12:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233355AbjI2QL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 12:11:29 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2308EBE
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 09:11:27 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1c73d9a850dso14661245ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 09:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696003886; x=1696608686; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=A8QbwrIFTxbqqq2vXbxJ1NnvfDmnd7RNsGwPcc6N8j4=;
        b=xxDqATO9Z+qBTCx5l2xg7BNExrcJBNcfftAvmmI5qWjTIFF7ssaXTGVUKlGlte/P1e
         V3FuhJ1HFO7+jjOkgQrmq4fsQbAPrp+2fWUSzNaXDrHtGcD4cKOkeXW1aEZfMj5Ni7Gl
         ek4PXo70+mmBsTPchbIoPdzKPdvvo0mJTAV1OrgOawZeVB4wCuifKm8eWkpWuuN+jwgS
         KDnQrV0ho5Tpf4//lk2Nribav/MttG5AkdakWEhVPQFpui9dDM5AmJed7m13mffxCvZP
         ohv68UihNejFNXSzrGon+lDU2hZxVHSBIR4xl7Tp58IDkIauwfo2JIXSPIb/LS+fL1ng
         2mvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696003886; x=1696608686;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A8QbwrIFTxbqqq2vXbxJ1NnvfDmnd7RNsGwPcc6N8j4=;
        b=IQLoMTsBXczLdIVRpzPwEDOXUr10Y7JtEQEcg7APsceBFISSxSloYUuK/cA/mP+hCx
         4zd0+M6sdRHRjR3e0qbjRUde+h6L5Ejcc2r5nmx+USA2ekLaZdwHjxT4/a3yc/IaypRZ
         r+Nl8pVMOo1wbL5FWvf1FNKFtB7KEq9i+KaoaKD72EHLehP76RLoRkrJMEjtWI+ne3+a
         ctCwErJdsOHn+7cTQxVL9oPeXp4kebt59IwUVyWzkLWaOzYZeQ4baAMSPAp/ZtRpWSoL
         ZTU1umBJMsyhvj9A+i+WnsaPBmG6+XhcqUT6DEIzeq0a0UYBvHmV+2vXVKBwlQKUY2L+
         P3Tw==
X-Gm-Message-State: AOJu0YylB3YAn8LigJoeEGTtOjv77oZhj3PWrqX73jCzA8G2gaPkK90d
        ASK9kWTPmdeNTK1S7mtAwUEAfxw3hmY=
X-Google-Smtp-Source: AGHT+IHD6AUg0p6VK/8EBOOY8c6NQKVToNMSoeFWO59uM3v/3XOIxkH8Mjrl9FQhhyqHFfeW8tBwlqoZafM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:fac4:b0:1c0:d575:d25 with SMTP id
 ld4-20020a170902fac400b001c0d5750d25mr54205plb.11.1696003886668; Fri, 29 Sep
 2023 09:11:26 -0700 (PDT)
Date:   Fri, 29 Sep 2023 09:11:25 -0700
In-Reply-To: <20230928162959.1514661-2-pbonzini@redhat.com>
Mime-Version: 1.0
References: <20230928162959.1514661-1-pbonzini@redhat.com> <20230928162959.1514661-2-pbonzini@redhat.com>
Message-ID: <ZRb3LX-tMKtycBjm@google.com>
Subject: Re: [PATCH 1/3] KVM: x86/mmu: remove unnecessary "bool shared"
 argument from functions
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2023, Paolo Bonzini wrote:
> Neither tdp_mmu_next_root nor kvm_tdp_mmu_put_root need to know
> if the lock is taken for read or write.  Either way, protection
> is achieved via RCU and tdp_mmu_pages_lock.  Remove the argument
> and just assert that the lock is taken.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
> +void kvm_tdp_mmu_put_root(struct kvm *kvm, struct kvm_mmu_page *root)
>  {
> -	kvm_lockdep_assert_mmu_lock_held(kvm, shared);
> +	/*
> +	 * Either read or write is okay, but the lock is needed because
> +	 * writers might not take tdp_mmu_pages_lock.
> +	 */

Nit, I'd prefer to say mmu_lock instead of "the lock", and be very explicit about
writers not needing to take tdp_mmu_pages_lock, e.g.

	/*
	 * Either read or write is okay, but mmu_lock must be held as writers
	 * are not required to take tdp_mmu_pages_lock.
	 */


> +	lockdep_assert_held(&kvm->mmu_lock);
>  
>  	if (!refcount_dec_and_test(&root->tdp_mmu_root_count))
>  		return;
