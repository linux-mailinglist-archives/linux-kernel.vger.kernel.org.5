Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA1147CE7EA
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 21:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbjJRTlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 15:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjJRTlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 15:41:09 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22ED6AB
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 12:41:08 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a7af69a4baso110049737b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 12:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697658067; x=1698262867; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1HjjlWV93sYNVV0Q80LXp2xExJaJHLYvfys9VI+7ya0=;
        b=DQrO8gYwfjibiHN0rlSiIoQ/nLfg/Mj1Sle/edKowt5MgMlpgR0dyArOp+aO7PjTgI
         bL4AaIl1/+fLCwYuBsRf3KavSBJ8TuiiJdf3hK9Q2aCccYr8zi/aCSzRSNfNf98h2UFJ
         yMg4zKbTYVvhPKcmscDh+0vpxzLpKFWNSJyc09cPe+8+veUTug2wYwBP33nwI2+pklPU
         3o4GBtUWMtx5Nu5CJCU8rR4tSO/cvCA3qdq6vQ612TO1MHXGaraKGRg0BhsN2nVSXYxs
         HjVFXMW2p6TT+m9mLSP+ubzhuT8DomIeiThXyxsq4Inex3INW6yMvv6X4Zk+G7ea1pID
         2dkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697658067; x=1698262867;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1HjjlWV93sYNVV0Q80LXp2xExJaJHLYvfys9VI+7ya0=;
        b=sabdt6DZVEezbWsRVS7cao+i9JnRk0PLzNHCpAWHqv7WfLaG4/B4O3JVEHKlQgeXkJ
         m5NuB5yjmSkjYd5IeCNQJDtZb3J0MrfdQc+NrTdAXdmKM95y1na95aboEMvCVpo+aeuD
         yzKIsJPzluUK90Ry2FZlAO0GHQkFDJtinIFu/ZRPd6Ky2/hkB1kl8g8FHs3iSGJiwzNT
         UCt9D03ZCzWaYHPPD0K1990deHdtOtNqk257O2CKiTMWYUbywCthXvV8Vr9QOaWupkDy
         dV3c6EME7YTz3NGNUREIPDuUmCVHkyWj8yAOXM7g1AjEaj5EKQaCnKDAvh1zu1aHUPv8
         yxYA==
X-Gm-Message-State: AOJu0YyE8mxgXL7w4TTjjaHqwHEdWFkZE6wPZvwjateVN+hLjZWP8I3N
        tCKM623fc64+UlHFZ1TsQ/vWgooHDE4=
X-Google-Smtp-Source: AGHT+IE8JldtjibywpNTblhydXdy1N3IhzSNsL72GrUuV8XFAoJlygXGx8+Q6rayxL9AkgT412uQ4HEq/YI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a0d:cbcc:0:b0:592:7a39:e4b4 with SMTP id
 n195-20020a0dcbcc000000b005927a39e4b4mr6046ywd.6.1697658067412; Wed, 18 Oct
 2023 12:41:07 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 18 Oct 2023 12:41:02 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Message-ID: <20231018194104.1896415-1-seanjc@google.com>
Subject: [PATCH 0/2] KVM: nSVM: TLB_CONTROL / FLUSHBYASID "fixes"
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stefan Sterz <s.sterz@proxmox.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two "fixes" to play nice with running VMware Workstation on top of KVM,
in quotes because patch 2 isn't really a fix.

Sean Christopherson (2):
  Revert "nSVM: Check for reserved encodings of TLB_CONTROL in nested
    VMCB"
  KVM: nSVM: Advertise support for flush-by-ASID

 arch/x86/kvm/svm/nested.c | 15 ---------------
 arch/x86/kvm/svm/svm.c    |  1 +
 2 files changed, 1 insertion(+), 15 deletions(-)


base-commit: 437bba5ad2bba00c2056c896753a32edf80860cc
-- 
2.42.0.655.g421f12c284-goog

