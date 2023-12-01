Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C594800145
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 02:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376422AbjLABy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 20:54:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjLAByZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 20:54:25 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE32F2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 17:54:32 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-6cdf75604d7so791228b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 17:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701395671; x=1702000471; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PKWMAIjcAS8BeI7d93Q2buqUeQzLcxL2KToIl+B67YY=;
        b=q/tfciZTHghwtQGUrzY9MTa1sD0lbKskkEVZRrTsrMkl+ZJX7awZrhHHgmIENLumUz
         hLN9Mv+u8xhAlZhPOHivK4uBrBY8cqIyVrcLV+1EPP66YnPBy8zdAmFEbZcfvi2gLE5N
         d72JySHtLfpQLfAFXa3T9RnUEz3/472AixJyjH3hFWoUTfkk6DbSfmCvKtmykNOGotgq
         vW/OGcoFOTRIN6AqURqvEkbWswVZuK3cbX16PsfbveklJP0X7o7s0MqpaYlN+26nZdAj
         KbJM84m9Fhe5C19IX38jWWaaPrP9dJh8+rHYdUZitg9jvVtPcKcuUffBlzrTHQB7cWH7
         H/KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701395671; x=1702000471;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PKWMAIjcAS8BeI7d93Q2buqUeQzLcxL2KToIl+B67YY=;
        b=X+WnfcET1BsvStQYadRKC2hzoGj+q1eRFAA26SggjThSW9nDA2tGr4uGN4hR6y+CFY
         /ZKvtn8DM0NvuYaXSTSpr+P+/KqpJ7a51CrGgMlK9eWHZGy0CKdf7+MxXD1e95XCQ6Hk
         DUifTvXmF3S33dG0ue/9bBu8IwY+F9BXP6797/OevlVBy7xpUHx3tuye3TPevO5rWZ16
         8V5xbUju6D2AuSZmGPw2e7wvcNKEQG2cFTHyZbh/eoNt+yXealGSCgfdevNbTghNewDp
         A6WIIXFi8QURmGNW78eqHFgj6QJhn+kMXx6x88jk5JOpSt9pYZZI8UrlOSYlwniPkzb8
         ytAA==
X-Gm-Message-State: AOJu0YzDLiuK9+WoyA0bNs/YfvAP1voGhRtEW8h1uEVOURFPKTou++La
        lOVFFTRov6T/dg75ipq4bcuuQ0s3HJg=
X-Google-Smtp-Source: AGHT+IGDV/0tldeZjg1P5I9SIGsp33yBLfURnsG/MQa2vzkfcUeFecZ6Xi1PNdITyY6nXlZX2Asi72r1Qfs=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:2d29:b0:6cd:f18e:17d with SMTP id
 fa41-20020a056a002d2900b006cdf18e017dmr382231pfb.1.1701395671646; Thu, 30 Nov
 2023 17:54:31 -0800 (PST)
Date:   Thu, 30 Nov 2023 17:52:10 -0800
In-Reply-To: <20231024001636.890236-1-jmattson@google.com>
Mime-Version: 1.0
References: <20231024001636.890236-1-jmattson@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <170137622057.658898.161602473001495929.b4-ty@google.com>
Subject: Re: [PATCH 1/2] KVM: x86: Advertise CPUID.(EAX=7,ECX=2):EDX[5:0] to userspace
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "'Paolo Bonzini '" <pbonzini@redhat.com>,
        Jim Mattson <jmattson@google.com>
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

On Mon, 23 Oct 2023 17:16:35 -0700, Jim Mattson wrote:
> The low five bits {INTEL_PSFD, IPRED_CTRL, RRSBA_CTRL, DDPD_U, BHI_CTRL}
> advertise the availability of specific bits in IA32_SPEC_CTRL. Since KVM
> dynamically determines the legal IA32_SPEC_CTRL bits for the underlying
> hardware, the hard work has already been done. Just let userspace know
> that a guest can use these IA32_SPEC_CTRL bits.
> 
> The sixth bit (MCDT_NO) states that the processor does not exhibit MXCSR
> Configuration Dependent Timing (MCDT) behavior. This is an inherent
> property of the physical processor that is inherited by the virtual
> CPU. Pass that information on to userspace.
> 
> [...]

Applied to kvm-x86 misc, with macros to make Jim queasy (but they really do
guard against copy+paste errors).

[1/2] KVM: x86: Advertise CPUID.(EAX=7,ECX=2):EDX[5:0] to userspace
      https://github.com/kvm-x86/linux/commit/eefe5e668209
[2/2] KVM: x86: Use a switch statement and macros in __feature_translate()
      https://github.com/kvm-x86/linux/commit/80c883db87d9

--
https://github.com/kvm-x86/linux/tree/next
