Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4FF47FE65F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 02:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344095AbjK3Bot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 20:44:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344087AbjK3Boq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 20:44:46 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D3DFA0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 17:44:52 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5d064f9e2a1so6369947b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 17:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701308691; x=1701913491; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xub5VyLk/9hlkO52TXYo+tffXTpWrk+mVN6q+yQi2HA=;
        b=EEarHMDJEVaJYEeRMFJr12jDXevjRahydSvlpyCAsXSUvFtBsXwK2DPvjag4zsb4I5
         2hd1/SBF6VQWEV34YxGwGtsO/NWGpICPEDlhLOVCUX6VUUhI172Ha0VfxO8UILreaXSi
         3lWln/qvGMSprJhv13d7ufjX9fAh5C3a7VmKtARRY8PnK2ebyryWLMhOMP+pPuucOcht
         QXmhWcrBjHeBzDxqFyKMsHRre+Oo/HhllZgukisvc4d6KPSn0VLy3+enGAM1uTgI01gz
         OpifDbEBu9Ai37ovp6TM866m6Rn07OSBtz1Zb/kjGUbVYQfgJLnvy/GnT4h/DI8fzqTh
         wyJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701308691; x=1701913491;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xub5VyLk/9hlkO52TXYo+tffXTpWrk+mVN6q+yQi2HA=;
        b=sGQid5fTL8QFH5ldk00SPA9FxD23HmWjbWS3VCKverniKifExQsp2aor+nl4Hez4Cd
         Tlk5u7vrTJDFRLtCzWsrsROsL5HLOp43m95cnQcOi5jO6qkyWNBXL+bm/HTfenfAX3lx
         VAIQRg1lpEoijlloVjrY93PpQsu5lQoNVdWguRi/NER9/tGfZq5jUtD3ZxaMG59qC8Ca
         I9/O7iHeNXxkQTBWRPhdqI/qX9QGj4fMcXiPtsCDYqMNrJBgMc5A99iGZCKcqLjTYXph
         IwV5HrEqiA6ahTwEPlzLSfegb8iicXB03ZDeLXzmwoCKsNX9AQMXyFWGiZ3AmRQmwemJ
         u9MA==
X-Gm-Message-State: AOJu0YxBR3UbrumcoiP/eocZXYDdUVxTd427J7KZTDDSDXygsuDV5fkp
        FkF7WenDnTaRQUp995EOSVUsrBaS6Bg=
X-Google-Smtp-Source: AGHT+IHHxILkVBPSCyrNJDZ6oTdYrXiPBvE0AM7l5jU3PrmO2ELVJgtmZPPfqmZAA5zbmyzdI66uMRXEYIw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:2e05:b0:5ce:dff:f7a3 with SMTP id
 et5-20020a05690c2e0500b005ce0dfff7a3mr570394ywb.10.1701308691301; Wed, 29 Nov
 2023 17:44:51 -0800 (PST)
Date:   Wed, 29 Nov 2023 17:44:13 -0800
In-Reply-To: <20231108010953.560824-1-seanjc@google.com>
Mime-Version: 1.0
References: <20231108010953.560824-1-seanjc@google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Message-ID: <170129829007.532775.18424810252595366690.b4-ty@google.com>
Subject: Re: [PATCH v2 0/2] KVM: selftests: Detect if KVM bugged the VM
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michal Luczaj <mhal@rbox.co>,
        Oliver Upton <oliver.upton@linux.dev>,
        Colton Lewis <coltonlewis@google.com>
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

On Tue, 07 Nov 2023 17:09:51 -0800, Sean Christopherson wrote:
> Teach selftests' ioctl() macros to detect and report when an ioctl()
> unexpectedly fails because KVM has killed and/or bugged the VM.  Because
> selftests does the right thing and tries to gracefully clean up VMs, a
> bugged VM can generate confusing errors, e.g. when deleting memslots.
> 
> v2:
>  - Drop the ARM patch (not worth the churn).
>  - Drop macros for ioctls() that return file descriptors.  Looking at this
>    with fresh eyes, I agree they do more harm than good. [Oliver]
> 
> [...]

Applied to kvm-x86 selftests.

Xiaoyao, I definitely want to continue the conversation on improving the userspace
experience when KVM kills a VM, but I don't see a reason to hold up "fixing" the
selftests.

[1/2] KVM: selftests: Drop the single-underscore ioctl() helpers
      https://github.com/kvm-x86/linux/commit/6542a0036928
[2/2] KVM: selftests: Add logic to detect if ioctl() failed because VM was killed
      https://github.com/kvm-x86/linux/commit/1b78d474ce4e

--
https://github.com/kvm-x86/linux/tree/next
