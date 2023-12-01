Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91864801149
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 18:21:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjLAQqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 11:46:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjLAQqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 11:46:03 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B44EECF
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 08:46:09 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-5bd18d54a48so766297a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 08:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701449169; x=1702053969; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=trs7IYTBAladXDE5IaepbZIO/2tonStqNHjIpFvn3vs=;
        b=euADoSzLorY/O7MB9yfNpJpPfxoNMGBO3gjrEsVfcNQz9tRw6XmQ/1zpmS71Losjt3
         CJHRuy/XC9ljcvoz5vNCUkuoG+AtKf1oV5AHeIvQLIZZ+0dAB6WherAiuFBBpdNzt/76
         LPk/xT3A4NA96rQDeslproDTJJqCTFVb7Iff8vkHNQpSjG3ZwvQdT5JDBY2mIQ0LHjMY
         uR+A5pAqsJUB7fkNUvycOfyAdpxKVJCrhgAHKpF1r4kiy9VdEX46e+Vct1InogC1s8aZ
         Yxx4FSwb74EB8UyIL6zLDr9eixEFdsyzCeTa2jKyUUnpVgclXx+yKtPNstLsqYXcg3gy
         gGGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701449169; x=1702053969;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=trs7IYTBAladXDE5IaepbZIO/2tonStqNHjIpFvn3vs=;
        b=nqHLg6ge+F9kPzLc5Rpdp8YY/spc7l1f4UFJ0nKexVTCR1oWBKpY9vprUY6O88T48g
         PAaNUe3OoWKSuyAaqZUz2iH7+N2/RNPU3P4GNusi+ExiAjQjSh/BHoPmXhsPGEiRWDz5
         GGhCzMqyL1WOY07kHSWg9FQFA5yfGn3vmL/a5swxUP4B4kqV74V4M344O4QbYrvCAZPk
         n/ZVAF18s4ykPmq204+KbdgHs5HycU4MJQbhhCcbHcSY7hZ1znv857cp4aqzH21DIJqs
         B4Af7GZlNcny3PA5BiRBsll2nWrzJdMBmYKlL7iHX3IncGNGGMfz0Df/m2u885M4DlHZ
         MjQA==
X-Gm-Message-State: AOJu0Yzk0TgjG21H5W2EhCY9yhOiyitEY4zMg64EeCotCp9IzzhrlST2
        hlhALNmIa5nRb6Cs3vxC7oc+5o95EO4=
X-Google-Smtp-Source: AGHT+IHP6cpnWG2mRsa2jQK18nXdBIOg5lQS/IldF/fWR8ov2oZkzKlOr+NQV16UJWxtTBgPXNo0z0l997Q=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a65:620b:0:b0:5bd:3c9d:42aa with SMTP id
 d11-20020a65620b000000b005bd3c9d42aamr3892944pgv.7.1701449169223; Fri, 01 Dec
 2023 08:46:09 -0800 (PST)
Date:   Fri, 1 Dec 2023 08:46:07 -0800
In-Reply-To: <20231201104536.947-1-paul@xen.org>
Mime-Version: 1.0
References: <20231201104536.947-1-paul@xen.org>
Message-ID: <ZWoNzzYiZtloNQiv@google.com>
Subject: Re: [PATCH 0/2] KVM: xen: update shared_info when long_mode is set
From:   Sean Christopherson <seanjc@google.com>
To:     Paul Durrant <paul@xen.org>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Fri, Dec 01, 2023, Paul Durrant wrote:
> From: Paul Durrant <pdurrant@amazon.com>
> 
> This series is based on my v9 of my "update shared_info and vcpu_info
> handling" series [1] and fixes an issue that was latent before the
> "allow shared_info to be mapped by fixed HVA" patch of that series allowed
> a VMM to set up shared_info before the VM booted and then leave it alone.

Uh, what?   If this is fixing an existing bug then it really shouldn't take a
dependency on a rather large and non-trivial series.  If the bug can only manifest
as a result of said series, then the fix absolutely belongs in that series.

This change from patch 1 in particular:

 -static int kvm_xen_shared_info_init(struct kvm *kvm, u64 addr, bool addr_is_gfn)
 +static int kvm_xen_shared_info_init(struct kvm *kvm)

practically screams for inclusion in that series which does:

 -static int kvm_xen_shared_info_init(struct kvm *kvm, gfn_t gfn)
 +static int kvm_xen_shared_info_init(struct kvm *kvm, u64 addr, bool addr_is_gfn)

Why not get the code right the first time instead of fixing it up in a completely
different series?
