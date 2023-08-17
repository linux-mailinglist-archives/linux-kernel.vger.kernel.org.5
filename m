Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB1CF7801B3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 01:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356059AbjHQXeo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 19:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356089AbjHQXef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 19:34:35 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFEBB35A1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 16:34:34 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-58e49935630so7725647b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 16:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692315274; x=1692920074;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SXVQeUb4aQ3WTzEZPWHQAR5WyaDuDsrfDrxX8pIEr5A=;
        b=Kq7XEqd5hD8IorchojdlIE1vrgUTXHuSC5f1pYO6saD8HuIhFoyUEN8Jd2Wjif4x/i
         pkgY1UiaiuPmIoz9HrkvSksQC024GjVy7GL+DkVU3Fr7JO0NgpmNcTpeFmfa/6Zr4Q8o
         Ar94Mrx+aboCXGASJYfFZjYMEaBUigQIJJaIu4P/YFN3343vPrZR61/Py5ukbWFtU5mx
         dE4fWOqF/FBnob4ff9IApqv78qGRM7MsIoaI6esN+7hE0th2fFPxyGwA7q1sLP+calqW
         etJQNRFMAryd5XSkCP9T+xbZmv/vRqZZ7aTDHDCInwSckJUomGpMVeglF9cIIjI3ToZ8
         ClYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692315274; x=1692920074;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SXVQeUb4aQ3WTzEZPWHQAR5WyaDuDsrfDrxX8pIEr5A=;
        b=juhR1yJghRhaIX+Zd3UaBq4t4tRrFkGTrqawjtUtlrT4hEAQwlRVNjVDvSPS9YHCpS
         nZV/FFR1hQ+nUM6NjbzB9GK4L7dUXHC7H68pg0LzqfdadrvD+A1rljYWHtwy19koLEya
         W/2ziGOzB1+YIQY1smhLAwK1Qv/uJlhGvP2S9sjAKy6oLPkVlT+W4KyiZANBdWQZ9IEO
         rbv5c/R3YLWesn3y927RCCmMgGHr9DQf12vpD2AdCbf4jMa5cyih7jfiwkE54aHEf+kG
         m4LNXYTpjPSvVE5ASDUZf69ulS0GTTen4jUYwM/C3q3bItKU8/1xvBgGs8pbfUpgZQpE
         14Yg==
X-Gm-Message-State: AOJu0Yx7cYd+by4C/BKMmm1UwUClWEeh++D8i5d17KQNJy2c9c9UH5KW
        DiEgDeRA1bjgrpV4dVUBQowifSy905I=
X-Google-Smtp-Source: AGHT+IGjcebzCdK0FzkZM397dXiDpeR1y40WH7laUbEd55l1OYmq4GofMjD9Wo18AWgS20vwu6WhU/QJLIM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a0d:ec4a:0:b0:56c:e9fe:3cb4 with SMTP id
 r10-20020a0dec4a000000b0056ce9fe3cb4mr16424ywn.1.1692315274086; Thu, 17 Aug
 2023 16:34:34 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu, 17 Aug 2023 16:34:28 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <20230817233430.1416463-1-seanjc@google.com>
Subject: [PATCH 0/2] KVM: selftests: Fix sync_regs race tests on AMD
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michal Luczaj <mhal@rbox.co>
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

The recently introduced sync_regs subtests to detect TOCTOU bugs hang on
AMD because KVM synthesizes INIT on triple fault shutdown (because AMD says
the VMCB is undefined after shutdown).  Fix it by loading known good state
if a shutdown occurs.

Patch two explicitly injects #UD as the "good" vector so that the test
doesn't rely on KVM inadvertantly setting the vector to #DE (old, buggy
behavior).

Sean Christopherson (2):
  KVM: selftests: Reload "good" vCPU state if vCPU hits shutdown
  KVM: selftests: Explicit set #UD when *potentially* injecting
    exception

 .../selftests/kvm/x86_64/sync_regs_test.c       | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)


base-commit: b6d40d24bb2eae6d4c2d4799ddbffcf7bae663db
-- 
2.42.0.rc1.204.g551eb34607-goog

