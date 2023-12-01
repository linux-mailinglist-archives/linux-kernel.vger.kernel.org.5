Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2A3C8017C6
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 00:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235256AbjLAXbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 18:31:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjLAXbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 18:31:12 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E60910E4
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 15:31:18 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5cb6271b225so44286527b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 15:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701473477; x=1702078277; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IKTnMsXS7bfkUSzfnP9Xpe0AB/j3WnOgx9Hq4BWGDW0=;
        b=3UQjXvMKuwwfsdITeRV7UIBfbnpLDpC9/7ac5rRFqgN8Oi/3eH3+1ZrJplPkQvp/1h
         y4yic5SH3UxFZR3nZb6PXBN2u8vOZpC6j3/0XeFh4DRgVt2Uoj41DZJ4DDzLKPunEhMe
         /5DhYZOfs9JecEeJkE3xTn4QHcGXGQQwvTq3KhiI0XntryAIhPYcZmcNkGP74RVjE584
         MpvPbMqkvlD5HZh2nm4dJQ4TFepMb9bg9haaJcL32toGWFy0ijQSD7ZthkrFawz47ayq
         AUa55OXciZuRK0MDIMJZqj40YQnh89o9J3eM61EFH4ZyewTaZbwj8TxDB0ZA9j5QgggK
         ZW/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701473477; x=1702078277;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IKTnMsXS7bfkUSzfnP9Xpe0AB/j3WnOgx9Hq4BWGDW0=;
        b=sPoMNokozMSHWGwoOBlDPU/ePUR5b2ICbIWV3lzFQkFePiq27YNNTAIFx8GlSKlJej
         JDM3rGTfig3TiiX5aoxs4u9IpAVHluNe22VL1EtWbWF2Fc77cwgL1PtvSkJHzQhmxo03
         0dfu7aGYCY53AZ28G3aKfQ6Dn5Wund9oGQxvLN5voF5rrip566s6yLxs/1ckQAmoxP/Y
         kjqAIDSlMSo//qYAXGcp2Y9ToGPnuZoM0f+6fO+p8drcDx86ZMt0r1zETqSjDgUSoYpC
         u2/WlpaMckUNoyx6SaGoIkXl3sVZNuz2YCt+ZpfXhemP/55/nj3mWqgKeyYlNKot4zZa
         iclA==
X-Gm-Message-State: AOJu0Yxqm4CcFAZabH6BwgQAvuUHlP3cj839youiRf8upBWNjP8wFBDT
        S0VIZl6XN76W2elb7zxD0HiZ6+ZHqY0=
X-Google-Smtp-Source: AGHT+IFRQ4AylpcFdoV4eED2PVv6bLzSBS5jcJXcCPI5IxjYv4WYUfmMopGrsirh/5rxO3xVuRULjEACP9A=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:4704:b0:5d3:a348:b0b9 with SMTP id
 gz4-20020a05690c470400b005d3a348b0b9mr175514ywb.8.1701473477627; Fri, 01 Dec
 2023 15:31:17 -0800 (PST)
Date:   Fri,  1 Dec 2023 15:30:35 -0800
In-Reply-To: <20231018204624.1905300-1-seanjc@google.com>
Mime-Version: 1.0
References: <20231018204624.1905300-1-seanjc@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <170144720127.838654.18038243366582421190.b4-ty@google.com>
Subject: Re: [PATCH 0/3] KVM: Fix KVM-owned file refcounting of KVM module(s)
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Matlack <dmatlack@google.com>
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

On Wed, 18 Oct 2023 13:46:21 -0700, Sean Christopherson wrote:
> Clean up a KVM module refcounting mess that Al pointed out in the context
> of the guest_memfd series.  The worst behavior was recently introduced by
> an ill-fated attempt to fix a bug in x86's async #PF code.  Instead of
> fixing the underlying bug of not flushing a workqueue (see patch 2), KVM
> fudged around the bug by gifting every VM a reference to the KVM module.
> 
> That made the reproducer happy (hopefully there was actually a reproducer
> at one point), but it didn't fully fix the use-after-free bug, it just made
> the bug harder to hit.  E.g. as pointed out by Al, if kvm_destroy_vm() is
> preempted after putting the last KVM module reference, KVM can be unloaded
> before kvm_destroy_vm() completes, and scheduling back in the associated
> task will explode (preemption isn't strictly required, it's just the most
> obvious path to failure).
> 
> [...]

Applied 1 and 3 (the .owner fixes) to kvm-x86 fixes.  I'll follow-up with a
separate series to tackle the async #PF mess.

[1/3] KVM: Set file_operations.owner appropriately for all such structures
      https://github.com/kvm-x86/linux/commit/087e15206d6a
[2/3] KVM: Always flush async #PF workqueue when vCPU is being destroyed
      (no commit info)
[3/3] Revert "KVM: Prevent module exit until all VMs are freed"
      https://github.com/kvm-x86/linux/commit/ea61294befd3

--
https://github.com/kvm-x86/linux/tree/next
