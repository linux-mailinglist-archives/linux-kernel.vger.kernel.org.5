Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0035C770475
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 17:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbjHDPZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 11:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbjHDPYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 11:24:47 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C22A59F5
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 08:24:08 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d1bcb99b518so2392517276.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 08:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691162635; x=1691767435;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZFxOXnJrCnLwyosaEoJ5XKTdBgr+iJ5sfCPaX0Y1m90=;
        b=MqIxKVHf1VXgzNTFjVSItHPlUtA6jlDZ6cMA5loyVnm34+XGPfPfHi7i4Usm4AU7ac
         W0Mjx6U/igEf4P0ZYjtcGxo5foByhdtowNPxbDsL5QxNZpFdCplK5J4FG0yIuvCkXLS4
         a95QuhnNLAnW9bcMzcWNHzyxuBF+wGZZJ0d8TQTo8T4W2a9FWZUJU7HA7KupGKxbn1tI
         TXlz0Eyq/7GTDtCZ7PQmDvEX3+sJslw8Le4sjx5G9NNo4nB0y3Wd39Afmq319x33Xfyp
         hRct9w6s7Sl6w6sbkVIYwI3iqZVNtwB5GBxsHDPKWFaosSyjgDGsQ4el6xElhc4kvD9r
         626Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691162635; x=1691767435;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZFxOXnJrCnLwyosaEoJ5XKTdBgr+iJ5sfCPaX0Y1m90=;
        b=LCo0lWHBF72KWc1WgFPFEJnTcbxDatXh4lcgPOi5lgziuxJscwKQhpaovQdVOCgnfY
         iy59iKixF7s9HBPzpnEt8LoFQd3GL5W8nMdPM/aKJl4ruTS/zxoAoBiHL1y9qSQvwGqb
         h2500Faf+6gII0GRlJDvSGVl1eRmdBPMpp4eJ4CEv65rApwfy23klwFExOdECrwTaX5u
         uXbu4d7Uo2a8uGqW+ceskvjXwAtabJmhWWK/P5ehGakv8/PPUGGUD/ksSjKnumInUu+0
         whVDNCZ6xaoZ2YDrt01PjtGxaKUa/A2B8WYNWOtecQDPI++4NI5Q55ljdYbAkRmdiKfj
         wUfw==
X-Gm-Message-State: AOJu0YzXCKhqfcPcvSYzbaAH8A3d9OxNQ+O0j+OTor4+HCGwV9KzFvmm
        Gh6dsxLglhim4tA08uxEw0tvDWhmdGk=
X-Google-Smtp-Source: AGHT+IGE/OCLG15icz/3cvmPraYl9lMENeybPBclQw1v/gSBLG6RHMQjrkxyHk1GNtrEatT/w5sEvyR2tcs=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:b316:0:b0:d0f:bcfe:bc74 with SMTP id
 l22-20020a25b316000000b00d0fbcfebc74mr11768ybj.9.1691162635611; Fri, 04 Aug
 2023 08:23:55 -0700 (PDT)
Date:   Fri, 4 Aug 2023 08:23:54 -0700
In-Reply-To: <ae42db25-9c8c-3f27-9ccb-41644b135a8b@rbox.co>
Mime-Version: 1.0
References: <20230804004226.1984505-1-seanjc@google.com> <20230804004226.1984505-4-seanjc@google.com>
 <ae42db25-9c8c-3f27-9ccb-41644b135a8b@rbox.co>
Message-ID: <ZM0YCjDLGzEBWF/M@google.com>
Subject: Re: [PATCH 3/4] KVM: selftests: Use asserting kvm_ioctl() macros when
 getting ARM page sizes
From:   Sean Christopherson <seanjc@google.com>
To:     Michal Luczaj <mhal@rbox.co>
Cc:     Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2023, Michal Luczaj wrote:
> On 8/4/23 02:42, Sean Christopherson wrote:
> > Use kvm_ioctl() instead of open coding equivalent ioctl()+TEST_ASSERT()
> > calls when getting the support page sizes on ARM.  The macro usage is a
> > little funky since the "kvm_fd" parameter implies an actual /dev/kvm fd,
> > but on the other hand the code is invoking KVM ioctl()s.
> > 
> > Alternatively, the core utilities could expose a vm_open()+vm_close()
> > pair so that the ARM code could create a dummy, on-stack VM+vCPU pair and
> > use {vm,vcpu}_ioctl() as appropriate.  But the odds of something breaking
> > due to oddball, partial usage of kvm_vm and kvm_vcpu structures is much
> > higher than realizing meaningful benefit from using {vm,vcpu}_ioctl().
> 
> Since you're doing the cleanup, does mmio_warning_test qualify for the
> same (funky usage ahead)?

Hmm, I'm heavily leaning towards deleting that test entirely.  It's almost
literally a copy+paste of the most basic syzkaller test, e.g. spawn a vCPU with
no backing memory and watch it die a horrible death.  Unless I'm missing something,
the test is complete overkill too, e.g. I highly doubt the original KVM bug required
userspace to fork() and whatnot, but syzkaller spawns threads for everything and
so that got copied into the selftest.

And this stuff is just silly:

	TEST_REQUIRE(host_cpu_is_intel);

	TEST_REQUIRE(!vm_is_unrestricted_guest(NULL));

because crashing the VM doesn't require Intel, nor does it require !URG, those
just happened to be the conditions for the bug.

As much as I like having explicit testcases, adding a new selftest for every bug
that syzkaller finds is neither realistic nor productive.  In other words, I think
we should treat syzkaller as being part of KVM's test infrastructure.

I'll send a patch to nuke the test.
 
> -       kvm = open("/dev/kvm", O_RDWR);
> -       TEST_ASSERT(kvm != -1, "failed to open /dev/kvm");
> -       kvmvm = __kvm_ioctl(kvm, KVM_CREATE_VM, NULL);
> -       TEST_ASSERT(kvmvm > 0, KVM_IOCTL_ERROR(KVM_CREATE_VM, kvmvm));
> -       kvmcpu = ioctl(kvmvm, KVM_CREATE_VCPU, 0);
> -       TEST_ASSERT(kvmcpu != -1, KVM_IOCTL_ERROR(KVM_CREATE_VCPU, kvmcpu));
> +       kvm = open_path_or_exit(KVM_DEV_PATH, O_RDWR);
> +       kvmvm = kvm_fd_ioctl(kvm, KVM_CREATE_VM, NULL);
> +       kvmcpu = kvm_fd_ioctl(kvmvm, KVM_CREATE_VCPU, NULL);
> 
> Side note, just in case this wasn't your intention: no kvm@ in cc.

Wasn't intentional, I was moving too fast at the end of the day and missed that
KVM wasn't Cc'd.  Grr.
