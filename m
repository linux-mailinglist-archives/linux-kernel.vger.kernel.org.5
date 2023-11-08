Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0E97E4E71
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 02:09:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234473AbjKHBJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 20:09:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbjKHBJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 20:09:58 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3291B10CF
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 17:09:56 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1cc5ef7e815so44563365ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 17:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699405795; x=1700010595; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oxu+k+SZ8kCvp94YTrpUeaCD1V6h4t1KJZzJ+BMwr/k=;
        b=HDMZZEDcRuqVut7+vucoEUa0WZjVN0VILC1+u8ThWBrwsfJCmxeqIRcOU+EfHvi6gv
         HYKv0CoXx7ixNs2oGgXiVnGd7mhqpSDNHIFmAXBm36CkE1GHsgtr0Gs77FPwNO5Ga6gn
         kIXpw4W7aeyqf9LaOKdoMwUGWuckP0LnuZm1NOe20FTC72j7Jl3Sv5fNWOc7MQTl7h+O
         MkkFhKfO7QgdVYhnExeJaPa0gF2Vpk1KJ6dwhjh/JDnGfb8x45ITlWDvE9tDo6SjBjUo
         HNnSWqeTBUeQyscB82moURsmzAQYyKsTcqdFmdib5Zay9XCWCJ0d4MzkTAptQLtUJE0j
         P6oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699405795; x=1700010595;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Oxu+k+SZ8kCvp94YTrpUeaCD1V6h4t1KJZzJ+BMwr/k=;
        b=kSzKK7Qd6kYZhWVXo9qzK2gyhtGsNrWQVpXgnNnLqLABVR6SFFdlp35A3doIwhb5v7
         H1zKvpLV5gYUbEXBb0wZr+El9ILuoNennYeJK2tQKAYwDxoVZVhIXCglCXtbwIETzCBt
         oS1v5DQv9j9y02dAMgQzRbP24o6dRSJPFt37UoXrcVokiqw1OTn/dccj/Qd8YwUFtBi/
         haux30neTzoi8Zaf2FPA1JPsAHU8zs0wRWnwDvH6Bz9nPRiNDo190yb7csjfyULDNU4Y
         o8oC7bCHNS85kMvb8+DYEH+ZKF/XjHokDBF1I/B6hsTn8+or0+/PuufAzqN+bkI+F9aZ
         F47Q==
X-Gm-Message-State: AOJu0Ywd0qLracIUNuexqWxrXps0xIBE5AV/LDvutV9DCPR3byYTZyZH
        4EagDL1M5ammOD2rZbq9+q5i5Hocvss=
X-Google-Smtp-Source: AGHT+IEX0TGbWBREr3RBzARDa6iU5dAUeynzl0NsrgqA8zi+AVKyQK6cZItSwsuP762i4QBcNpgy7AOO7BI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:f80e:b0:1cc:2a6f:ab91 with SMTP id
 ix14-20020a170902f80e00b001cc2a6fab91mr11432plb.0.1699405795722; Tue, 07 Nov
 2023 17:09:55 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue,  7 Nov 2023 17:09:51 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231108010953.560824-1-seanjc@google.com>
Subject: [PATCH v2 0/2] KVM: selftests: Detect if KVM bugged the VM
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>,
        Michal Luczaj <mhal@rbox.co>,
        Oliver Upton <oliver.upton@linux.dev>,
        Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Teach selftests' ioctl() macros to detect and report when an ioctl()
unexpectedly fails because KVM has killed and/or bugged the VM.  Because
selftests does the right thing and tries to gracefully clean up VMs, a
bugged VM can generate confusing errors, e.g. when deleting memslots.

v2:
 - Drop the ARM patch (not worth the churn).
 - Drop macros for ioctls() that return file descriptors.  Looking at this
   with fresh eyes, I agree they do more harm than good. [Oliver]

v1: https://lore.kernel.org/all/20230804004226.1984505-1-seanjc@google.com

Sean Christopherson (2):
  KVM: selftests: Drop the single-underscore ioctl() helpers
  KVM: selftests: Add logic to detect if ioctl() failed because VM was
    killed

 .../selftests/kvm/include/kvm_util_base.h     | 75 ++++++++++++-------
 tools/testing/selftests/kvm/lib/kvm_util.c    |  2 +-
 2 files changed, 51 insertions(+), 26 deletions(-)


base-commit: 45b890f7689eb0aba454fc5831d2d79763781677
-- 
2.42.0.869.gea05f2083d-goog

