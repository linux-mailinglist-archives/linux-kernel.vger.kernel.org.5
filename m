Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1639D803AAC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 17:46:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjLDQqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 11:46:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234862AbjLDPzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 10:55:41 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B250C6
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 07:55:48 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1d03cf821e3so17851605ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 07:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701705347; x=1702310147; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cecZouhBWGt/EiQ/BWaOcGVIY9+Efnff7UOIt4tvjVY=;
        b=gQpqaiFZvwjF5lML5pOBG3hzEY5fPSxeti7yiKg9RP4QeNItmvK+wMfwJ8dnlxdMm4
         lz61qnxgsmQQwHxncM+OOyIrv7q5ofLHdANnTuQbN4sWX+ErSan+80V6DIl/mqD/AKYo
         zHoIxnLNdt2397TO4q5zz/vFhQ5NKJMJJu1IZmcRad7G6rSoQUb9Y7YcZsfvj+jHxxQi
         PnhZPv42js7jfdw8yqtuy6p0qWg5lZE41MMh2rHy6XuOFu0M+7u1nPmue74ESu7PB/gc
         i13t4eCMGbC9MI0lqf3kq6i0wP0GmRKDVkrujF8iJM6E1zWPC9EafLQhj7uIMPom5rm6
         7pjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701705347; x=1702310147;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cecZouhBWGt/EiQ/BWaOcGVIY9+Efnff7UOIt4tvjVY=;
        b=VhVvqb/b1tCh4pX40Wqynr3qrS24SrpyBuXxonNfOXEutv6WK8KlNrU5vxHwouglO8
         2Coo1u7kKzFXpjXpjDQtCguYd+g6+7JnhwOECubF3Zzz4kz4fMUNnT2pLxHJk1EbRw5M
         JDKP788BH2SDBp4ZvW3n3GjGBwV0jva0+VMWODP3hAmXB75avW7ZXtLGK/u9nfzEzxO1
         dMl1zVNkVhpJm31QTWMsKkp4lfjLTWfEeTcVvk3Jm6CLm+WNMNSr1bDAUPXqYuIiHbtW
         Dvd9gRnncQ/PgDR5bDjs2Q/y9wpKpJMAHj3mw+KgxcdyX8fJON2Ejx5D6e3DXsz0u3ay
         19Fw==
X-Gm-Message-State: AOJu0Yw+hpwcto0R7VPs9tTdDVK5Td9vMP9MjODU0CIOwAIT6zDi9lWW
        pQ60/kkhoPgsDzRU4glI8BwH47UFjaQ=
X-Google-Smtp-Source: AGHT+IHT4+rKE00OMxlkVtbzFGfm42rAMwZxQGGjiqdlMrT/HQOS0qnitbvkIE3fzrfrjz38aunT4qZzoAA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:2581:b0:1d0:737b:2850 with SMTP id
 jb1-20020a170903258100b001d0737b2850mr129810plb.11.1701705347469; Mon, 04 Dec
 2023 07:55:47 -0800 (PST)
Date:   Mon, 4 Dec 2023 07:55:45 -0800
In-Reply-To: <20231204074535.9567-1-likexu@tencent.com>
Mime-Version: 1.0
References: <20231204074535.9567-1-likexu@tencent.com>
Message-ID: <ZW32geNb18p9ibrR@google.com>
Subject: Re: [PATCH] KVM: x86/intr: Explicitly check NMI from guest to
 eliminate false positives
From:   Sean Christopherson <seanjc@google.com>
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
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

On Mon, Dec 04, 2023, Like Xu wrote:
> From: Like Xu <likexu@tencent.com>
> 
> Explicitly checking the source of external interrupt is indeed NMI and not
> other types in the kvm_arch_pmi_in_guest(), which prevents perf-kvm false
> positive samples generated after vm-exit but before kvm_before_interrupt()
> from being incorrectly labelled as guest samples:

...

> Fixes: 73cd107b9685 ("KVM: x86: Drop current_vcpu for kvm_running_vcpu + kvm_arch_vcpu variable")

The behavior is deliberate, and was added by commit dd60d217062f ("KVM: x86: Fix
perf timer mode IP reporting").  *If* we want to undo that, then the best "fix"
would be to effective reverting that commit by dropping the IRQ usage of
kvm_before_interrupt() and renaming the helpers kvm_{before,after}_nmi().  But
my understanding is that the behavior is necessary for select PMU usage.
