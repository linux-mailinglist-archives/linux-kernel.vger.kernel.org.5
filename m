Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3267F80991D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 03:20:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1572988AbjLHCTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 21:19:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbjLHCTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 21:19:04 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14B871719
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 18:19:10 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5d1b2153ba1so16171607b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 18:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702001949; x=1702606749; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yxWoNxQ7Re4hEPxspP07a4pO5MrpwCF1ltmlTW1Q1tA=;
        b=cu40gsxWLQw2D/KR+vCrTQMieXnAqNYo6SvyYOuM0rOUwV5LDCekbYizw0hdtmnPfc
         Ii/dsfg+btFEhju9cHNQctQ0mP/b/v5ayN7f7lvWSwoocQ/S+o6A8MY3ZnV7i66yuOBk
         m41AtGH+XFlypqf0KhrV504v7/hFAXDDlSwSTMdAePgn3mR5YL2oy72WmwfkpO40WZ5r
         gzBA2khtVxL2tIrtngOEtiumxw3T+ZUvj3E5TSRsOKQyoRTpOqzBtfCLfpmrlhoSotW3
         NsFvy3GFa/xUyst3E8CCKKCw1nxAAYr+xUv77VJnTuAPH4zSxHtU0ZG8juCQidmb0M2i
         GpyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702001949; x=1702606749;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yxWoNxQ7Re4hEPxspP07a4pO5MrpwCF1ltmlTW1Q1tA=;
        b=FDMGDa1ZLHInFtocfPfAIs/NP+DGREgfEOpcpB9cLFAFbYVO4ffhQltti6l51gm6j5
         Sn8miEeWmnpWYfBTYpNJWkXxH6vq6YL3MN31WRkjaZjycMCd1b8kiJ3mFzrb3ityejia
         Qv8NDy6RWZbYXlioZFMuqoE7LGpdG0w8roG4l//qSLzxEGhf74lFr8oMvdAJrNCsE9on
         +AIxABRsKVTWfZamczhZXAxkafbh3Ls8waopDpOzumSdHUBEcFuitqmK1+p2kDqOtvoe
         tiyji/hTTz8yGJqoWQGTS+23nJq4Od/y+LNcPQ9WcQaSHZgEJpODt7b3SXnJuwHS2mas
         /YWg==
X-Gm-Message-State: AOJu0YyZyxuNHUSjHax0/F+kjlj+51MIqz0Rj+aCzzrFHszZ9q4GXyiA
        don02mo+c3KVaqlm0/osxbHzQIPJa7k=
X-Google-Smtp-Source: AGHT+IGLAarIGot/mOxhybAJOqF5zuI2ZbCf7KZAbIPPAPtRn+CDvmhNB9rGKAeknxv5s/UJNTS1xhf9MMM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:844:b0:5d6:cb62:4793 with SMTP id
 bz4-20020a05690c084400b005d6cb624793mr51973ywb.0.1702001949309; Thu, 07 Dec
 2023 18:19:09 -0800 (PST)
Date:   Thu,  7 Dec 2023 18:17:39 -0800
In-Reply-To: <20231102162128.2353459-1-paul@xen.org>
Mime-Version: 1.0
References: <20231102162128.2353459-1-paul@xen.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <170199319421.1675545.670609241239795412.b4-ty@google.com>
Subject: Re: [PATCH v5] KVM x86/xen: add an override for PVCLOCK_TSC_STABLE_BIT
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        David Woodhouse <dwmw2@infradead.org>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Durrant <paul@xen.org>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 02 Nov 2023 16:21:28 +0000, Paul Durrant wrote:
> Unless explicitly told to do so (by passing 'clocksource=tsc' and
> 'tsc=stable:socket', and then jumping through some hoops concerning
> potential CPU hotplug) Xen will never use TSC as its clocksource.
> Hence, by default, a Xen guest will not see PVCLOCK_TSC_STABLE_BIT set
> in either the primary or secondary pvclock memory areas. This has
> led to bugs in some guest kernels which only become evident if
> PVCLOCK_TSC_STABLE_BIT *is* set in the pvclocks. Hence, to support
> such guests, give the VMM a new Xen HVM config flag to tell KVM to
> forcibly clear the bit in the Xen pvclocks.
> 
> [...]

Applied to kvm-x86 xen (and not on a Friday!), thanks!

[1/1] KVM x86/xen: add an override for PVCLOCK_TSC_STABLE_BIT
      https://github.com/kvm-x86/linux/commit/6d7228352609

--
https://github.com/kvm-x86/linux/tree/next
