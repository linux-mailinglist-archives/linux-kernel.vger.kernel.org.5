Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4361E800157
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 02:56:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376594AbjLAB4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 20:56:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbjLAB4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 20:56:33 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71EA219F
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 17:56:38 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5d032ab478fso28145107b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 17:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701395797; x=1702000597; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iI4oVwt8TD6xPM293sLOSQhO8NJlm+MJKlwZRhcjGtY=;
        b=flXo4wpJ+b0zdsz3T81Jxzr1ovb8MjzJIbJhC95EmQCHnnUCOPYDD+594dWwP3XjvL
         nTKAXVl/I+pKt1WSPxrAyS7AqfcNdeL3miagcSoIde9zGeyvs7/xhcbZ+DFLS9n6YzFM
         CYwhJz1UK1wVIYEL6ljQcbcJAswcOiu8bYdzNhRZYjv0rPKqm34zgH1F1Ple81D6R35p
         +UGO5fCUa6fXWrxO3rY/FIMGJAxx8x3ih9+0n6/TTS1hxPKPLnyaLI7gG5HJb2qXjyPW
         daNGXR1PXu6G7KUKnOzVVtzYN2IRKFGmVggE1YrR6KjA5Y3L8oqb8adT9ducECRe+gBI
         STWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701395797; x=1702000597;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iI4oVwt8TD6xPM293sLOSQhO8NJlm+MJKlwZRhcjGtY=;
        b=N8WhI7xkNtvVRyE7MFumWHC+6GepNZBKi924B8NTwGdFa7G03BAb2x8TBSDIQ+ELuY
         N4W7yZsirBas75Kwf52SH2ZZmWjB6NyZONWxcS2SMEmuSCNKEPERNhiWQunetE+eTlA8
         /vW5NpEgpESyGTAe/bB806lwZgQaoTnL7wX7Fla4CKiNppOPs/m9XDGYFkeZ1x9dXiR1
         GqQ2XLi5C9n1P5J6ZTGo87AbIyxQCTggQiL/cR0oV0mD8/Y19V5ASTDAAcKluXyFlqnf
         Zn5g3mMdy9BtaHvAfeJqBrYqQxRobdi9vykqhIiYeEoRp5P6X0rZ17V2Mm08+LG8JNO+
         zg7w==
X-Gm-Message-State: AOJu0Yy8mL5/Q26PlDJ0SHQ73z7WkaIKFVkPYqOfBiKZvPVyG+DHWys1
        MbAsHZSJHlfFxwl0CnPNu/Spon4hzd0=
X-Google-Smtp-Source: AGHT+IETi2Qic31wESuQIdytaz+n6fY1W/iil7+kMH3zUIefQfN66dqXBkfgXXc0+CDA4lvTWk2F/VuX1V8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:2e87:b0:5cc:3d0c:2b60 with SMTP id
 eu7-20020a05690c2e8700b005cc3d0c2b60mr651819ywb.4.1701395797734; Thu, 30 Nov
 2023 17:56:37 -0800 (PST)
Date:   Thu, 30 Nov 2023 17:52:30 -0800
In-Reply-To: <20231018192021.1893261-1-seanjc@google.com>
Mime-Version: 1.0
References: <20231018192021.1893261-1-seanjc@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <170137748541.663660.2513750001573904834.b4-ty@google.com>
Subject: Re: [PATCH v2] KVM: SVM: Don't intercept IRET when injecting NMI and
 vNMI is enabled
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Santosh Shukla <santosh.shukla@amd.com>,
        Maxim Levitsky <mlevitsk@redhat.com>
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

On Wed, 18 Oct 2023 12:20:21 -0700, Sean Christopherson wrote:
> When vNMI is enabled, rely entirely on hardware to correctly handle NMI
> blocking, i.e. don't intercept IRET to detect when NMIs are no longer
> blocked.  KVM already correctly ignores svm->nmi_masked when vNMI is
> enabled, so the effect of the bug is essentially an unnecessary VM-Exit.
> 
> KVM intercepts IRET for two reasons:
>  - To track NMI masking to be able to know at any point of time if NMI
>    is masked.
>  - To track NMI windows (to inject another NMI after the guest executes
>    IRET, i.e. unblocks NMIs)
> 
> [...]

Applied to kvm-x86 svm, thanks!

[1/1] KVM: SVM: Don't intercept IRET when injecting NMI and vNMI is enabled
      https://github.com/kvm-x86/linux/commit/72046d0a077a

--
https://github.com/kvm-x86/linux/tree/next
