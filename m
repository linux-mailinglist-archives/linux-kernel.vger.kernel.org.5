Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDF997AA1E7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 23:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbjIUVI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 17:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232424AbjIUVH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 17:07:57 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E05101A8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 13:33:34 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1c40ac5b6e7so11371155ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 13:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695328414; x=1695933214; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vVkSv5USYfxh1iDKrRIotw/ScBvVaPg/YoEhVNrkyyk=;
        b=j64uyZccEnShlAdgH+z/yCrEhNjhDPvwwhYoXxMvkQGQdf6M+ByvuT15KHoe3NDF5A
         EfQgD11auZHJRt3TUKYuF+9SN7tewsr8s3lKv2SIHThBChosMQEQf3kLeT2AI8sQuq2F
         C2W8NaYsomfUsEobNW/762TT3jgw1SW9bV5UO3NIO8W+aTOHgw+pY3DaoVfEGT1todQi
         fyJLultWhqhG13EnC5c/eFwCSTbmgmvZVYgnIX8/qCadHg/QHLl6zMgyB5gEUzg+FY13
         LQY15dn3MXrwtxpKrhUgOulX4zaLZoETz/HMlk9cKgOR6qSCsFSmVM1AbSJ//qBJgg32
         TJQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695328414; x=1695933214;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vVkSv5USYfxh1iDKrRIotw/ScBvVaPg/YoEhVNrkyyk=;
        b=jNcmTS/IEaZDAQdz1IPKUNEI5w1IDDvyvfR4iwpi5WNItFjHqsjrv0IskdUuMwGCv7
         KksoZB3D3mYTFFbpSyWvRtx7nkUs9YYcof5cYV8wHQ4gNdwzwibpnzzmfQm6JNHLqBIn
         XfMkZjunOGIz9NjLwp1sZKGcZ4ZWxnSkHW2BZV59al6H8ZZID6Go4+M45z9Cp992KZQn
         ya63vlZskFBcR1PZZJneAqvcXa6mxaQ3XYAgrVE1ssvVt1Df/DYvj3dhbGkTppYIc4JO
         UOlJHJzLnsohILRVKDKw1E6PFdyBty0n3GwXaSlSNUaoFHl8ecNE5z8D8Ny890pBL4WJ
         Iqvg==
X-Gm-Message-State: AOJu0YxZ+WdFMiNV9aZCk2s59z/hgcGcBdfB9Qtp79EwsfjKbZBct6y3
        kGatZOF5NhIEMcBl4P5FJlnJN6XiUT4=
X-Google-Smtp-Source: AGHT+IHYFIuc9zqyHxB81MZBEcRhKGKtq8Fpu2bgHAXxJfzHlFxcNfobP06GPEJ6dPoFhdY2/yLVWW0ytIo=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:e88b:b0:1b8:80c9:a98e with SMTP id
 w11-20020a170902e88b00b001b880c9a98emr81106plg.13.1695328414013; Thu, 21 Sep
 2023 13:33:34 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu, 21 Sep 2023 13:33:17 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Message-ID: <20230921203331.3746712-1-seanjc@google.com>
Subject: [PATCH 00/13] KVM: guest_memfd fixes
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Roth <michael.roth@amd.com>,
        Binbin Wu <binbin.wu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a variety of bugs in the guest_memfd series, almost all of which are
my fault, and add assertions and testcases to detect future regressions.

The last patch, renaming guest_mem.c to guest_memfd.c, is obviously not a
bug fix, I included it here so that if we want to go with guest_memfd.c,
squashing everything will be straightforward.

Note, the truncate fix and test conflicts with Isaku's series[*].  My
fix is more correct (knock wood), and my test is slightly more comprehensive
(though arguably not really all that more interesting).

Note #2, this is based on kvm-x86/guest_memfd, to which I force-pushed v12.

Note #3, the patches are organized so that they can be squashed with their
Fixes, i.e. the splits are more than a bit odd in some places.

[*] https://lore.kernel.org/all/cover.1695327124.git.isaku.yamahata@intel.com

Sean Christopherson (13):
  KVM: Assert that mmu_invalidate_in_progress *never* goes negative
  KVM: Actually truncate the inode when doing PUNCH_HOLE for guest_memfd
  KVM: WARN if *any* MMU invalidation sequence doesn't add a range
  KVM: WARN if there are danging MMU invalidations at VM destruction
  KVM: Fix MMU invalidation bookkeeping in guest_memfd
  KVM: Disallow hugepages for incompatible gmem bindings, but let 'em
    succeed
  KVM: x86/mmu: Track PRIVATE impact on hugepage mappings for all
    memslots
  KVM: x86/mmu: Zap shared-only memslots when private attribute changes
  KVM: Always add relevant ranges to invalidation set when changing
    attributes
  KVM: x86/mmu: Drop repeated add() of to-be-invalidated range
  KVM: selftests: Refactor private mem conversions to prep for
    punch_hole test
  KVM: selftests: Add a "pure" PUNCH_HOLE on guest_memfd testcase
  KVM: Rename guest_mem.c to guest_memfd.c

 arch/x86/kvm/mmu/mmu.c                        |  25 ++--
 .../kvm/x86_64/private_mem_conversions_test.c | 112 ++++++++++++++----
 virt/kvm/Makefile.kvm                         |   2 +-
 virt/kvm/{guest_mem.c => guest_memfd.c}       |  84 +++++++------
 virt/kvm/kvm_main.c                           |  40 +++++--
 5 files changed, 184 insertions(+), 79 deletions(-)
 rename virt/kvm/{guest_mem.c => guest_memfd.c} (92%)


base-commit: 7af66fbd6d89b159acc359895449b5940b6e4fdb
-- 
2.42.0.515.g380fc7ccd1-goog

