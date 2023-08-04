Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 942D476F69A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 02:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232626AbjHDAna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 20:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232648AbjHDAnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 20:43:03 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC614694
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 17:42:29 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1bc46ebab95so7748235ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 17:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691109748; x=1691714548;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vujMrPLoi5NFJy2gDTZldPvTGUeu9cCAa9LViNvzt/o=;
        b=XpCFpMvQd4gQvh5gquWQ2ZftAaXrBB47AdVh0lLXrYmERl4lD3tY2Oi2S5FLElr5kD
         criOJo8gVbtB4NFndShfIfXdRyq3hnbrsejCWk0QGXOzcK75QYhrXoPTI3JLxnKLsYtr
         twzk19agPK7WenGVGKqUaiqYW963b5aEsEAadUrL+1G5/6aeheEHuC3KoixXoqFlgZ+n
         LhOpmawTNHJuzxuxo5tH1UygVMDE5unyPCqT25hnvArOLk7TdoaMyK24G/6Zhd53jdxM
         l2h2/SNBHXg1gLP1ignbuQE8H/XS+yIxT8uRZbkocTzCvQ/YWzcy4KoPpD4d/xyARQj8
         h03g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691109748; x=1691714548;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vujMrPLoi5NFJy2gDTZldPvTGUeu9cCAa9LViNvzt/o=;
        b=hrvLx63b0KXdhSzHZdicVPQQ45JmoJQefms+fZHsD1Ovg9aNOioAcN/uTGESeWS8iD
         7qb8nsMHjbeIYfCJCB96oZEY2mRlacqbFYa0AunPBohTapksDcRAv6qS7e/OviuVfirD
         wJEyOw9Gbxn4DBGk29lrMCI0IY/vDG9lb6CP24SNQONF+yGyjBZ5wuzG5Syv2/FoK0TJ
         xo3O7vKC08LFCYkBQ5YH6nB6TBBcL9fCU2h6jdwMksrkb/BId/8GSQLQuF9wNvcTsQ1s
         sc6506Hv6ZiQoXfNPO4t0PyPL9MuH50osJgWa79b9FVeaVxXuqwUaWyvFPrEZwPBLmge
         ZG+Q==
X-Gm-Message-State: AOJu0YwgYaNYZLrem0oo8qaezZjueOcJklwSHSKwpVCd3aX2bI6IG+cE
        i7C2P1fjgT1CLF1HwI9ndhtlDQzJXbQ=
X-Google-Smtp-Source: AGHT+IEQjsVrWEka9KrysAVqongS+7aQWrT2bXGIhy4ffbBau7Yhoew+SCgRy4QDDK8SjLRgYnzvVZ01CJk=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:2349:b0:1bc:4c3d:eb08 with SMTP id
 c9-20020a170903234900b001bc4c3deb08mr1147plh.8.1691109748457; Thu, 03 Aug
 2023 17:42:28 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu,  3 Aug 2023 17:42:22 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230804004226.1984505-1-seanjc@google.com>
Subject: [PATCH 0/4] KVM: selftests: ioctl() macro cleanups
From:   Sean Christopherson <seanjc@google.com>
To:     Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>,
        Michal Luczaj <mhal@rbox.co>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do some minor housekeeping on the ioctl() macros, and then teach them
to detect and report when an ioctl() unexpectedly fails because KVM has
killed and/or bugged the VM.

Note, I'm 50/50 on whether or not the ARM patch is worthwhile, though I
spent a stupid amount of time on it (don't ask), so darn it I'm at least
posting it.

Oh, and the To: will probably show up funky, but I'd like to take this
through kvm-x86/selftests, not the ARM tree.

Thanks!

Sean Christopherson (4):
  KVM: selftests: Drop the single-underscore ioctl() helpers
  KVM: selftests: Add helper macros for ioctl()s that return file
    descriptors
  KVM: selftests: Use asserting kvm_ioctl() macros when getting ARM page
    sizes
  KVM: selftests: Add logic to detect if ioctl() failed because VM was
    killed

 .../selftests/kvm/include/kvm_util_base.h     | 101 ++++++++++++------
 .../selftests/kvm/lib/aarch64/processor.c     |  18 ++--
 tools/testing/selftests/kvm/lib/kvm_util.c    |  17 +--
 3 files changed, 84 insertions(+), 52 deletions(-)


base-commit: 240f736891887939571854bd6d734b6c9291f22e
-- 
2.41.0.585.gd2178a4bd4-goog

