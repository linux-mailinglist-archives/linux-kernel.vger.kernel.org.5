Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACDDC7DD943
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 00:28:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346893AbjJaX2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 19:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234390AbjJaX2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 19:28:20 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACADEC9
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 16:28:18 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-da03390793fso6106199276.3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 16:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698794898; x=1699399698; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ENayTSofjgkkxALl6xU7QgNf1DeiFgXjZ0+OmHefEsg=;
        b=3jHmmzrLswHkb926usWk6KwFRYAf3dhaV24pvAAqWaCWJkNqNtHIBtTXiPXdsXYZGi
         8IVCnDWgV8ttTywYHW3aJUJH6NgI/dLhyEdEo3+qi0FPQSMYrzDo6E07YF//QluI17aT
         yRsyJ0Og9erOBmWF5SNs8iKJ3tygFQUj8H/8FkvCgUl/Aiyj/GQDRyKa8O/jLJV0+Dsi
         sieh/B/oJPIudYHaVehS3qvF52xcEqsX4EPIeNaZTuU5roJvLrPxY6r8A1Pk33PCZnvj
         zTlHRdzwgRLkyORLr2H5EFpyLCna9HZLv2ZQ+Dw0Qkp0h+edUYiVQ/KoZ/vFPlX93XXW
         kSng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698794898; x=1699399698;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ENayTSofjgkkxALl6xU7QgNf1DeiFgXjZ0+OmHefEsg=;
        b=rbRSowpejRC+0IiJLsBTQMP6XMf16QzBvYj4+dWLn8QD6VQMS0NxKbGECVISDA3ieH
         0FPBrxHL9vERvFFdjodNMJ4KUiwlW6zHdFuklwbNBCstMF0AHKDxHjhSJp+Podt7rx1H
         6vjOIleTMR9XY6KhQXtbwvmTq9gwl7qAsjNDI/+fxJiufhb+OylwsCFwzVrnWPpLcD+M
         T9IcZi6aQoAEWx/E5kU0zTeDJ5l5AWznEx0tmPO2r8pFATNPAGhKj+8QpeJpOTBoDBHq
         uB6bdBT4Izdj5AMwjkdkc2kQdIAXg2MFeF5xxEt+vWbY5bk9vO3F2Ba/Aci+rGNH78sR
         hprg==
X-Gm-Message-State: AOJu0Yy3vnWYMjlX9htN4AWwtixbww0aTTM1lwaLP7XF5CUrlTQeEz+R
        vQf5zOpI+NWbFDGr8kK9EkEJzF4x4tI=
X-Google-Smtp-Source: AGHT+IGg02iRvuNDO3zt4sBicsPmDFm2zxMX+TjRPmKchM2JIWMpwwHznBGiE6wu4jxsX/3bRzA5KbG/11I=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:8706:0:b0:d9a:be7b:283c with SMTP id
 a6-20020a258706000000b00d9abe7b283cmr290002ybl.0.1698794897986; Tue, 31 Oct
 2023 16:28:17 -0700 (PDT)
Date:   Tue, 31 Oct 2023 16:28:16 -0700
In-Reply-To: <20231002095740.1472907-3-paul@xen.org>
Mime-Version: 1.0
References: <20231002095740.1472907-1-paul@xen.org> <20231002095740.1472907-3-paul@xen.org>
Message-ID: <ZUGNkCljRm5VXcGg@google.com>
Subject: Re: [PATCH v7 02/11] KVM: pfncache: add a mark-dirty helper
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
> At the moment pages are marked dirty by open-coded calls to
> mark_page_dirty_in_slot(), directly deferefencing the gpa and memslot
> from the cache. After a subsequent patch these may not always be set
> so add a helper now so that caller will protected from the need to know
> about this detail.
> 
> NOTE: Pages are now marked dirty while the cache lock is held. This is
>       to ensure that gpa and memslot are mutually consistent.

This absolutely belongs in a separate patch.  It sounds like a bug fix (haven't
spent the time to figure out if it actually is), and even if it doesn't fix
anything, burying something like this in a "add a helper" patch is just mean.


> diff --git a/virt/kvm/pfncache.c b/virt/kvm/pfncache.c
> index 0f36acdf577f..b68ed7fa56a2 100644
> --- a/virt/kvm/pfncache.c
> +++ b/virt/kvm/pfncache.c
> @@ -386,6 +386,12 @@ int kvm_gpc_activate(struct gfn_to_pfn_cache *gpc, gpa_t gpa, unsigned long len)
>  }
>  EXPORT_SYMBOL_GPL(kvm_gpc_activate);
>  
> +void kvm_gpc_mark_dirty(struct gfn_to_pfn_cache *gpc)
> +{

If there's actually a reason to call mark_page_dirty_in_slot() while holding @gpc's
lock, then this should have a lockdep.  If there's no good reason, then don't move
the invocation.

> +	mark_page_dirty_in_slot(gpc->kvm, gpc->memslot, gpc->gpa >> PAGE_SHIFT);
> +}
> +EXPORT_SYMBOL_GPL(kvm_gpc_mark_dirty);

This doesn't need to be exported.  Hrm, none of the exports in this file are
necessary, they likely all got added when we were thinking this stuff would be
used for nVMX.  I think we should remove them, not because I'm worried about
sub-modules doing bad things, but just because we should avoid polluting exported
symbols as much as possible.
