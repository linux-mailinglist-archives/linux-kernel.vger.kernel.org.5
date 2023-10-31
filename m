Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 092967DD96A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 01:00:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376330AbjJaX67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 19:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235192AbjJaX65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 19:58:57 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E3C0E8
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 16:58:55 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-da03c5ae220so328343276.1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 16:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698796735; x=1699401535; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9i9Iv3jiMg/J1qGB5P5psVE2uSLqd7nXP+oyj+C4sSw=;
        b=ZLKDBjWBM/QlML7IUgghULULuNQQrZ67XTste20kFGvnbzJ7Sd4MtgaHIVINXx056j
         BmVcornZLsQUA6+NS9cvzs3L9VDurK2AbLAnOqB0meHhSLbJpoQchu5Jbn/0oFZTLRz0
         1cOvbeBKgk87cnucW/N+nb6u2poqdqnNagG1lSeZ+/fVooDdrpID5a9Pq1yD9eSa7TRr
         BkGv32fcAosWc87mC3XYMna1dCeCPfmPeOcNtfkbYEAjPViFSHxgYTn4IAQZfYbhCu5C
         tc/5EQrlvOiAB5tVbmx7StgB+crtUdz4l+qUm9AlP150Q6KA7bx87IIsHTLp8EgBzmzO
         +Avw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698796735; x=1699401535;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9i9Iv3jiMg/J1qGB5P5psVE2uSLqd7nXP+oyj+C4sSw=;
        b=IA9NwQa3i7QG4Tf4Bgmg+c65w4q0euRhEm/FEP8YjD8gZF0wNv69KhKwO1E4geHxgz
         d8EU+gvAdqre2WVS298ufvi6MPAipmUpu9iLG7WdiEIsxGmV81/iQxKm0e0JbvMQp0TI
         oQy20akfY5YYUkoCvfv5R8cRIEpdpF6A09k5EMr0CjFTS0/MkCtROKhJYQYCQOcho/d8
         ZqOMXTd027JwUUFOl5I7ZzSw6owWTiA05oQJDu2p6J1U2usdcRMqrsprqs7t1S6RtZjY
         U0urcfCSlMcY6PqWxMuhKV2fhW9SYelDdsPQ/JiH+TVvdhtgTkOq6qrxiktl+KsBWgbH
         dnVw==
X-Gm-Message-State: AOJu0YxivpT8Jdn1Qtyn3+NNNTII7uO3Oo7cFRUVhQg9DCnvgVi0xE/T
        iOaMlnSOtwrrBJgeVgdHSTars+xP3SE=
X-Google-Smtp-Source: AGHT+IGwTz/89tho+pKVku/Pj8lTv2+bIBWHCYW6TnvufRrdElQbeeQC7ZNZcNYtoG1+pQncgj/bqgALsNs=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:264f:0:b0:da3:b467:af07 with SMTP id
 m76-20020a25264f000000b00da3b467af07mr11219ybm.2.1698796734909; Tue, 31 Oct
 2023 16:58:54 -0700 (PDT)
Date:   Tue, 31 Oct 2023 16:58:53 -0700
In-Reply-To: <20231002095740.1472907-12-paul@xen.org>
Mime-Version: 1.0
References: <20231002095740.1472907-1-paul@xen.org> <20231002095740.1472907-12-paul@xen.org>
Message-ID: <ZUGUvdlxAoevcgJH@google.com>
Subject: Re: [PATCH v7 11/11] KVM: xen: allow vcpu_info content to be 'safely' copied
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
> From: Paul Durrant <pdurrant@amazon.com>
> 
> If the guest sets an explicit vcpu_info GPA then, for any of the first 32
> vCPUs, the content of the default vcpu_info in the shared_info page must be
> copied into the new location. Because this copy may race with event
> delivery (which updates the 'evtchn_pending_sel' field in vcpu_info) we
> need a way to defer that until the copy is complete.

Nit, add a blank link between paragraphs.

> Happily there is already a shadow of 'evtchn_pending_sel' in kvm_vcpu_xen
> that is used in atomic context if the vcpu_info PFN cache has been
> invalidated so that the update of vcpu_info can be deferred until the
> cache can be refreshed (on vCPU thread's the way back into guest context).
> So let's also use this shadow if the vcpu_info cache has been
> *deactivated*, so that the VMM can safely copy the vcpu_info content and
> then re-activate the cache with the new GPA. To do this, all we need to do
> is stop considering an inactive vcpu_info cache as a hard error in
> kvm_xen_set_evtchn_fast().

Please, please try to write changelogs that adhere to the preferred style.  I
get that the preferred style likely doesn't align with what you're used to, but
the preferred style really doesn't help me get through reviews quicker.

> diff --git a/arch/x86/kvm/xen.c b/arch/x86/kvm/xen.c
> index aafc794940e4..e645066217bb 100644
> --- a/arch/x86/kvm/xen.c
> +++ b/arch/x86/kvm/xen.c
> @@ -1606,9 +1606,6 @@ int kvm_xen_set_evtchn_fast(struct kvm_xen_evtchn *xe, struct kvm *kvm)
>  		WRITE_ONCE(xe->vcpu_idx, vcpu->vcpu_idx);
>  	}
>  
> -	if (!vcpu->arch.xen.vcpu_info_cache.active)
> -		return -EINVAL;
> -

Hmm, maybe move this check after the "hard" error checks and explicitly do:

		return -EWOULDBLOCK

That way it's much more obvious that this patch is safe.  Alternatively, briefly
explain what happens if the cache is invalid in the changelog.


>  	if (xe->port >= max_evtchn_port(kvm))
>  		return -EINVAL;
>  
> -- 
> 2.39.2
> 
