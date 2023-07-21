Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2812375D79F
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 00:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjGUWnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 18:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjGUWnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 18:43:41 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F8B3A86
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 15:43:40 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-c386ccab562so2291707276.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 15:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689979420; x=1690584220;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k+6O0YIMwG1cwBx+yYV4PQs65NLJ69q60H268QBXqI0=;
        b=hmJMFyMKavzdB4iyndVgPr3+n37+SAXDovr5+nwV08bJvHRSThf7MgLO5tdEtXSw1f
         XerzxiovVN3R3vbNCqIs1AMT3AOBNTdS4HAaKfLSdFOBTA38exP9T8k6/7ptO1WlonGU
         BOcWk42elFAzngve5Kof4BIfMYRPoZenXrRT+vQUnl4Uf748v/GhfP3men3MTLu6DmSc
         LxigsC514xYQheWPgEZQwWHwvGhRWgriUmOGC9KudeqiG0XyR8RPORBSkK0wwOQmrgOf
         So/EdWTFLymWYtNDT48BlqeFFsMeY9Q7SUJosljJ9DlATtDenzYWqmZEZx1ltL/aT3z1
         vU+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689979420; x=1690584220;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k+6O0YIMwG1cwBx+yYV4PQs65NLJ69q60H268QBXqI0=;
        b=HXxIsSp0oR4HFW5sNZIRoVIMoYyadNP3EtYnL42VPEEF0KxNyeTV1NBvsNNCHWo/m8
         kHNErJjh3MJg9a6u08ihP/IL1yvrxaXNc7vmY13oxPCdX5+WI7LB9CSLeL768IbdK2cI
         5X8Oo9ZXaJisUG0kwZnxsywGzEiu3Z1NRQLDv+lrLrxJ0ZUMoD09mA82ce72uSFHXTrJ
         NS6VmfOhGnZNIc+wK81kwFn3v4x87PwLGYx+K911FS3nyuLuxZ0mKTDSvhKNIuf2iRuZ
         Szm69ue9v1sA9LyYBMP5aYt9ccZwr9Hy3ZwgrZl8bgIs3T+kgbcrcQ2SrtD/oWuYakpm
         vNnw==
X-Gm-Message-State: ABy/qLZaKiYKEMnWUKFtISN0hUVBbsYGxrmihdcHNlJIg/CDdZXMhJB7
        673qUruVoH67bL0UhF0KbAsOnzp8hew=
X-Google-Smtp-Source: APBJJlH4nH1apLt9lOCybEoth1zmYiXMKQfwt/TGh1u8/BUf6F1PQtJ0c2/w8q0sUs7E+P7quD6OQImNAds=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:24a:b0:cea:fb07:7629 with SMTP id
 k10-20020a056902024a00b00ceafb077629mr22978ybs.10.1689979419845; Fri, 21 Jul
 2023 15:43:39 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 21 Jul 2023 15:43:35 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230721224337.2335137-1-seanjc@google.com>
Subject: [PATCH 0/2] KVM: x86: Acquire SRCU in fastpath handler
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Thelen <gthelen@google.com>,
        Aaron Lewis <aaronlewis@google.com>
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

Acquire SRCU for read when handling fastpath MSR writes so that side
effects like

Note, the PMU case could (and should) also be fixed by making the PMU
filter code smarter, e.g. by snapshotting which PMC events need to be
emulated, thus avoiding the filter lookup entirely.  But acquiring SRCU
is relatively cheap, and this isn't the first bug of this nature.

Which is a perfect segue into patch 2, which reverts a hack-a-fix to
fudge around SVM needing to do the front half of emulation when skipping
the WRMSR.

Note #2, the fastpath also doesn't honor the MSR filter for TSC_DEADLINE.
That's a problem for another day.

Sean Christopherson (2):
  KVM: x86: Acquire SRCU read lock when handling fastpath MSR writes
  Revert "KVM: SVM: Skip WRMSR fastpath on VM-Exit if next RIP isn't
    valid"

 arch/x86/kvm/svm/svm.c | 10 ++--------
 arch/x86/kvm/x86.c     |  4 ++++
 2 files changed, 6 insertions(+), 8 deletions(-)


base-commit: fdf0eaf11452d72945af31804e2a1048ee1b574c
-- 
2.41.0.487.g6d72f3e995-goog

