Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94CBA800147
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 02:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376408AbjLAByt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 20:54:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjLAByt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 20:54:49 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A86E012A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 17:54:55 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-5c612589cfcso80986a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 17:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701395695; x=1702000495; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tecn6AmyR5k2Qu/H4+MjzFtOIKWQJZkWQJnuQ75piAk=;
        b=YJiGLROREVnKrvzffhGG0TC/x+Z5OY0i5IjYPrn0z4jVzeACfg+xNoDfKpg7lrvOBe
         cq7be5UIaMa6OhhDADV/FoD3vYsbVOj+e4ISVA8ji596oftR5F7OpE/NrmkbmOo3Ywye
         2f4WO7wZcVXhz4k66H9sKRXrtiosJd0FzGO+Y7BzI3K49qA9tz7fnn3gl6gfnBisq3Ah
         8lLQM8YhbDB36lDMRUUQAAHn1CQx6VB18T0sbceMgOMn967WVghJbwUhfQXcy399aheK
         qnorEsmGVRzl1xroIXKb96JRA2PHfAApR74KeY0QX9x6RzhGRycZRAHBH48kR7FBl21j
         n7iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701395695; x=1702000495;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tecn6AmyR5k2Qu/H4+MjzFtOIKWQJZkWQJnuQ75piAk=;
        b=xS/qPkpupNHW8inQ36tzIL8KokjyLpuvw7SAg9RvOpGbFOkFRztbxOTnUAbndFeXSY
         BqruWr3rSzth0ewxdXcRlqtc9pzwovTox89JdvhCy+9fOug+o68Sh/FqGGZHGvaossOJ
         5q+sQ/jsZ6aAN9GBZj56VNhmDXnbO9f4o6XrP8G/O5VvxlnODmoWTT51o+I/lsBukASj
         k2SJ5rjI1PBvacZrAOzCOuGcI/sToT3jO5lxrEiy2DtKLEw2GNeOqEtqTG+GqGHqF+hO
         Up9ZBT6P4+oIofmt62um3LUibqKVoN8Xxt9fnrC+rXssFsmvVRPn1YPuh5109Nv9Tghv
         Bdtg==
X-Gm-Message-State: AOJu0YwHf3lMjvNzNY1eRz+NJQMy5IKsMo3iNt54IJ9BzneNIP/Y8DbB
        Nt0v9K1Ustgzo+cIWRlKKNta+Fj2Zs4=
X-Google-Smtp-Source: AGHT+IFO2twNqlDkXK8VLOVlFLjUse1fmfI8xeu/1k50/w5ETgOYlbPmxVQzKInvfkp6xlTRxN2MwHOfCTU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:1220:0:b0:5c2:2f9:c374 with SMTP id
 h32-20020a631220000000b005c202f9c374mr3894156pgl.9.1701395695116; Thu, 30 Nov
 2023 17:54:55 -0800 (PST)
Date:   Thu, 30 Nov 2023 17:52:12 -0800
In-Reply-To: <20231018195638.1898375-1-seanjc@google.com>
Mime-Version: 1.0
References: <20231018195638.1898375-1-seanjc@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <170137723293.662627.9568255433684903794.b4-ty@google.com>
Subject: Re: [PATCH] KVM: x86: Don't unnecessarily force masterclock update on
 vCPU hotplug
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dongli Zhang <dongli.zhang@oracle.com>,
        David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Oct 2023 12:56:38 -0700, Sean Christopherson wrote:
> Don't force a masterclock update when a vCPU synchronizes to the current
> TSC generation, e.g. when userspace hotplugs a pre-created vCPU into the
> VM.  Unnecessarily updating the masterclock is undesirable as it can cause
> kvmclock's time to jump, which is particularly painful on systems with a
> stable TSC as kvmclock _should_ be fully reliable on such systems.
> 
> The unexpected time jumps are due to differences in the TSC=>nanoseconds
> conversion algorithms between kvmclock and the host's CLOCK_MONOTONIC_RAW
> (the pvclock algorithm is inherently lossy).  When updating the
> masterclock, KVM refreshes the "base", i.e. moves the elapsed time since
> the last update from the kvmclock/pvclock algorithm to the
> CLOCK_MONOTONIC_RAW algorithm.  Synchronizing kvmclock with
> CLOCK_MONOTONIC_RAW is the lesser of evils when the TSC is unstable, but
> adds no real value when the TSC is stable.
> 
> [...]

Applied to kvm-x86 misc, thanks!

[1/1] KVM: x86: Don't unnecessarily force masterclock update on vCPU hotplug
      https://github.com/kvm-x86/linux/commit/c52ffadc65e2

--
https://github.com/kvm-x86/linux/tree/next
