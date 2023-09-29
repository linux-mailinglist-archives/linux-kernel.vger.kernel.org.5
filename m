Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88EFC7B2A46
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 04:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbjI2CUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 22:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjI2CUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 22:20:12 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9DDB19F
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 19:20:09 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59f7d109926so168616657b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 19:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695954008; x=1696558808; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=K0+exT2Vigr26I9k2jO7yGhZG3qMq/s7Ri07pEtuZwI=;
        b=ZsD7T4KgZsC20XieTIjf159uwQdTTbELh9ugPBhiAx0nrSnvgoiYem00h1OHitzYm/
         nEBE1HHnccquKx2E37P/h/fcAqZHZLV3H66/58d4KjJHQAQJ+KnFClxjmiz7ZPeyKjsT
         J6LE+I5zX4FKSFtNhsrLBEfFtXK8R66DeR+7ddWvjq5S5wGofgq5X8VzFLf3bV4C/TIN
         kc8ta96IcJJku+gQfl2W27oldzdczFHSJTBSWnzKxiJKatUrfD00yLobqEJqopJMxE7Q
         j73mxyBcZ1Lt6iHrdgW51YOiY9v4zRJ8kXd4xmlWMauviCz3wCeoCYZJYgn4iMAi28GA
         tnhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695954008; x=1696558808;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K0+exT2Vigr26I9k2jO7yGhZG3qMq/s7Ri07pEtuZwI=;
        b=RqRUb01YdFitNOFOoxRUyJpXgOfkfBCx/ApkyUECcwQY11ZKOQhHgSiPlTb5ZG2tHl
         GMxdZUKSmaswqR+hKGdJbwY11uoM07iyBQ+KauqfNR5fDMacDpVGHYms+08ZtsyPJo82
         9zMppxQBvbpDzr5CHLBBRzaj7fvRS/eBE0OdZkQuTWgAe6ncU4bJvqS6viHIMN9iUijr
         NqyOYJpdGHekrsLcdoCKzgeppw7ME1mvok5DPVA+KR0lUobQVGbimCCJaveg4Gm7vVN/
         Y95306kHClag2lmuN5lCaYEvhMf1+oaUTLqX2t3VnSH5mCZ6AcjE9u2VcMNLHQM+wivW
         srfg==
X-Gm-Message-State: AOJu0YxIwLirgdeNJjaIcY+RutjXyrNohFhjXSdeWWKV8eeARgWIO7wM
        M/xXOXvEjdBibfIDneVxxHMk21kpJYA=
X-Google-Smtp-Source: AGHT+IFZ3z8GazvOmhxU8dpXuC24cIstyReKmh5R2PFxeModk3iRSNi4k5IHowWukNy4M+lp6WTZMMQP7hE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:af47:0:b0:59b:c811:a702 with SMTP id
 x7-20020a81af47000000b0059bc811a702mr41223ywj.6.1695954007753; Thu, 28 Sep
 2023 19:20:07 -0700 (PDT)
Date:   Thu, 28 Sep 2023 19:20:01 -0700
In-Reply-To: <20230913000215.478387-1-hshan@google.com>
Mime-Version: 1.0
References: <20230913000215.478387-1-hshan@google.com>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
Message-ID: <169592156740.1035449.1039175365762233349.b4-ty@google.com>
Subject: Re: [PATCH v3] KVM: x86: Fix lapic timer interrupt lost after loading
 a snapshot.
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        Haitao Shan <hshan@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Sep 2023 16:55:45 -0700, Haitao Shan wrote:
> When running android emulator (which is based on QEMU 2.12) on
> certain Intel hosts with kernel version 6.3-rc1 or above, guest
> will freeze after loading a snapshot. This is almost 100%
> reproducible. By default, the android emulator will use snapshot
> to speed up the next launching of the same android guest. So
> this breaks the android emulator badly.
> 
> [...]

Applied to kvm-x86 apic, thanks!

[1/1] KVM: x86: Fix lapic timer interrupt lost after loading a snapshot.
      https://github.com/kvm-x86/linux/commit/9cfec6d097c6

--
https://github.com/kvm-x86/linux/tree/next
