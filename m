Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C73A80373A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 15:44:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345910AbjLDOo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 09:44:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235874AbjLDOoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 09:44:15 -0500
Received: from mail.xenproject.org (mail.xenproject.org [104.130.215.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA8EFD;
        Mon,  4 Dec 2023 06:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=xen.org;
        s=20200302mail; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
        Subject:To:From; bh=EhQi3onL9GpEqJYUYdTVsT5Q2f0NwXP08T0ndFJ/c7M=; b=aTxlUtH06
        VlLvCE9ceDi8kZAqPwZofP2Wp9wkcSYAWChi0ExMNgvIzt+1sbkygWUSu/qkm5fD6fdnFAwM0tiy6
        Nr9uCHWMmqY3npFk8DCYOgKus5MJ22786Ii2KZJghUQN9Jea+POrOkaDZiYFt0gn/n9Xw28R3fI49
        28d9t3Xs=;
Received: from xenbits.xenproject.org ([104.239.192.120])
        by mail.xenproject.org with esmtp (Exim 4.92)
        (envelope-from <paul@xen.org>)
        id 1rAAAs-0003d8-1y; Mon, 04 Dec 2023 14:43:54 +0000
Received: from 54-240-197-231.amazon.com ([54.240.197.231] helo=REM-PW02S00X.ant.amazon.com)
        by xenbits.xenproject.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <paul@xen.org>)
        id 1rAAAr-00088g-Ng; Mon, 04 Dec 2023 14:43:53 +0000
From:   Paul Durrant <paul@xen.org>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Paul Durrant <paul@xen.org>, Shuah Khan <shuah@kernel.org>,
        kvm@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v10 00/19] KVM: xen: update shared_info and vcpu_info handling
Date:   Mon,  4 Dec 2023 14:43:15 +0000
Message-Id: <20231204144334.910-1-paul@xen.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Durrant <pdurrant@amazon.com>

There are four new patches in the series over what was in version 9 [1]:

* KVM: xen: separate initialization of shared_info cache and content
* KVM: xen: (re-)initialize shared_info if guest (32/64-bit) mode is set

These deal with a missing re-initialization of shared_info if either the
guest or VMM changes the 'long_mode' flag. This was discovred in testing
when the guest wallclock reverted to the Unix epoch because the pvclock
information in the shared_info page was not in the correct place, and so
the guest read zeroes instead.

* KVM: xen: don't block on pfncache locks in kvm_xen_set_evtchn_fast()
* KVM: pfncache: check the need for invalidation under read lock first

The first of these fixes a bug discovered when compiling the kernel with
CONFIG_PROVE_RAW_LOCK_NESTING: kvm_xen_set_evtchn_fast() can be called from
the callback of a HRTIMER_MODE_ABS_HARD timer and hence be executed in
IRQ context. It should therefore not block on any lock. Thus two
occurrences of a read_lock() are converted to a read_trylock() which
kick the code down a slow-path if they fail.
The second patch removes a 'false' contention on the pfncache lock that
could result in taking that slow-path: the MMU notifier callback need only
take a pfncache read lock; it only need take a write lock if a match is
found.

Apart from these new patches...

* KVM: xen: split up kvm_xen_set_evtchn_fast()

... has been re-worked to (hopefully) improve readability and also validate
the 'correct' vcpu_info structure depending on whether the guest is in long
mode or not.

[1] https://lore.kernel.org/kvm/20231122121822.1042-1-paul@xen.org/

Paul Durrant (19):
  KVM: pfncache: Add a map helper function
  KVM: pfncache: remove unnecessary exports
  KVM: xen: mark guest pages dirty with the pfncache lock held
  KVM: pfncache: add a mark-dirty helper
  KVM: pfncache: remove KVM_GUEST_USES_PFN usage
  KVM: pfncache: stop open-coding offset_in_page()
  KVM: pfncache: include page offset in uhva and use it consistently
  KVM: pfncache: allow a cache to be activated with a fixed (userspace)
    HVA
  KVM: xen: separate initialization of shared_info cache and content
  KVM: xen: (re-)initialize shared_info if guest (32/64-bit) mode is set
  KVM: xen: allow shared_info to be mapped by fixed HVA
  KVM: xen: allow vcpu_info to be mapped by fixed HVA
  KVM: selftests / xen: map shared_info using HVA rather than GFN
  KVM: selftests / xen: re-map vcpu_info using HVA rather than GPA
  KVM: xen: advertize the KVM_XEN_HVM_CONFIG_SHARED_INFO_HVA capability
  KVM: xen: split up kvm_xen_set_evtchn_fast()
  KVM: xen: don't block on pfncache locks in kvm_xen_set_evtchn_fast()
  KVM: pfncache: check the need for invalidation under read lock first
  KVM: xen: allow vcpu_info content to be 'safely' copied

 Documentation/virt/kvm/api.rst                |  53 ++-
 arch/x86/kvm/x86.c                            |   7 +-
 arch/x86/kvm/xen.c                            | 358 +++++++++++-------
 include/linux/kvm_host.h                      |  40 +-
 include/linux/kvm_types.h                     |   8 -
 include/uapi/linux/kvm.h                      |   9 +-
 .../selftests/kvm/x86_64/xen_shinfo_test.c    |  59 ++-
 virt/kvm/pfncache.c                           | 185 ++++-----
 8 files changed, 461 insertions(+), 258 deletions(-)


base-commit: 1ab097653e4dd8d23272d028a61352c23486fd4a
-- 
2.39.2

