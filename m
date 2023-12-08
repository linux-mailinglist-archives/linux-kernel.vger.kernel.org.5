Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12394809900
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 03:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1572961AbjLHCHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 21:07:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjLHCHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 21:07:33 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2131C1716
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 18:07:40 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5d032ab478fso19548477b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 18:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702001259; x=1702606059; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BptvliLbbdh5Wt1usUGYyJ/6pHg8JbB115xCaPKtCmQ=;
        b=dDf4ah/8udU8jZxHPu8zRbPI42H5gjuseUIYUsbfvj6cStHQYYUVdztAH9aif8Ag9M
         Bu+jvE1KzoXe8VnVUu/zWvIKjawPGwLu3Dsulch0CNNmghU80r/7uBrn+PXKRgC+3RwT
         gn1NfPGx+74s8yj7HdVOrY3qVN5ecewSVKrSRcTtmvr7JtO4AG5pUbjul+Qc7PEu7kI1
         GUe1/RLpnATUhPcIcALN5cr1TkFrD9xqzdsWlWGOLrrscqGuYHMsX0ACzAL95SrZqIMb
         b2+mO1ZxUiCb1byycXRmfYTCQXGFpeP8Tap506aAY8f7+/llpMhIxTVf/lOtmP1vGC4S
         uHxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702001259; x=1702606059;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BptvliLbbdh5Wt1usUGYyJ/6pHg8JbB115xCaPKtCmQ=;
        b=dLY+Y0Dto14TtEq96aLbtphxgkvNeMpu7TCydVqrk7u8YmVkbpOT9uxi5a4MT1ThN/
         iL+aofe16iYUBR4O1AARTvGytX8KmftT0/oiVaVgvJtRi9dWfEmGcw4a9t5m6SMMNzo2
         V7qtCaqmbmLs7scsnpvd5nb2Mihgm3XGO+bBjCGcbenex4BFg0eJ4SN7GsMbnT8WeyV/
         tLMAj94yxdouEWVldxa0hU6Cfj7sSp/uZQaIUwrerctZMz3wkhmBzgf2CYpF0IgTCL9c
         kHu73XQrQBg3S4F72XzxZnP6lzS5Xisi/O64S039TL6btPQIE/n6lNTWMqCfxATCBkvx
         JrNg==
X-Gm-Message-State: AOJu0Yxs/4sdvOSrq3IyXzG9AouSElGAG89CygYwRUtjnhgWwgJscXVT
        WOK1ptBYLRENgLFD8DAkKlPVnuBxQyI=
X-Google-Smtp-Source: AGHT+IEgUdxPpuKoyTF8TAOPV1sruFitClETp9It5DUTWtsbxGLiEri1zSGnlA7144kJrde8n5FkKYtDEnU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:3013:b0:5d8:4274:bae2 with SMTP id
 ey19-20020a05690c301300b005d84274bae2mr50870ywb.6.1702001259351; Thu, 07 Dec
 2023 18:07:39 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu,  7 Dec 2023 18:07:34 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231208020734.1705867-1-seanjc@google.com>
Subject: [GIT PULL] KVM: x86: Fixes for 6.7-rcN
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
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

Please pull a handful of fixes for 6.7-rcN (hopefully N=5).  These have all
been in -next for a week or so.

The following changes since commit ffc253263a1375a65fa6c9f62a893e9767fbebfa:

  Linux 6.6 (2023-10-29 16:31:08 -1000)

are available in the Git repository at:

  https://github.com/kvm-x86/linux.git tags/kvm-x86-fixes-6.7-rcN

for you to fetch changes up to ef8d89033c3f1f6a64757f066b2c17e76d1189f8:

  KVM: x86: Remove 'return void' expression for 'void function' (2023-12-01 08:14:27 -0800)

----------------------------------------------------------------
KVM fixes for 6.7-rcN:

 - When checking if a _running_ vCPU is "in-kernel", i.e. running at CPL0,
   get the CPL directly instead of relying on preempted_in_kernel, which
   is valid if and only if the vCPU was preempted, i.e. NOT running.

 - Set .owner for various KVM file_operations so that files refcount the
   KVM module until KVM is done executing _all_ code, including the last
   few instructions of kvm_put_kvm().  And then revert the misguided
   attempt to rely on "struct kvm" refcounts to pin KVM-the-module.

 - Fix a benign "return void" that was recently introduced.

----------------------------------------------------------------
Like Xu (2):
      KVM: x86: Get CPL directly when checking if loaded vCPU is in kernel mode
      KVM: x86: Remove 'return void' expression for 'void function'

Sean Christopherson (2):
      KVM: Set file_operations.owner appropriately for all such structures
      Revert "KVM: Prevent module exit until all VMs are freed"

 arch/x86/kvm/debugfs.c |  1 +
 arch/x86/kvm/x86.c     |  9 ++++++---
 virt/kvm/kvm_main.c    | 18 ++++++++----------
 3 files changed, 15 insertions(+), 13 deletions(-)
