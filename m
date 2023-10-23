Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2437D40EE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 22:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbjJWUfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 16:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjJWUfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 16:35:36 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D9F5D79
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 13:35:35 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d9a581346c4so3530552276.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 13:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698093334; x=1698698134; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ftc156R8Kd2p0eLX9s/siFvI+R44W46BFe9vk5gYkeo=;
        b=jfDUFyuNCywwheuYlMSa+Y7ueLMHqcXynkDon0axWkfl2qxfPopYyV9kGQz3wTNp4a
         zDYL3tEfwpYR4qZasGXBYLGNi78rHcc8KcOfWwcpHStgoM64ObeXffFuihSP0w5ExwQ2
         x23hMV6d4TSYQ5nNYZCasJlKLrMTynm/5ZvUzWYsncb3oiy/l5+hnqjHonpZXVyh+dOH
         OuATEdounyDdbPyT61u8Az9gJS9QfohSYWIGZkgUbCQJlF+uBgKL2QZVLuKlGCg3pY3d
         QwNnRYTbkLvGjjNAGNyQ2HTR/QNRvwg3Fzc2RQjWqiEHiM7ejF9ajSREZGpckl+7NweQ
         buRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698093334; x=1698698134;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ftc156R8Kd2p0eLX9s/siFvI+R44W46BFe9vk5gYkeo=;
        b=ahYmxWwG+7hbGhsBIGZ80rIqQ9pbiRYDHiFzptUHnAvd84ri363BampeRi3a6Z/dIC
         42s5Nz6EWW5wvq2zdR2W7G3lZQ3OxZlIx105ksG4jkfxmPIIgOpF+0BPskG3HFKrw1fK
         9wmVMs++UIE4WFclsqucr4v3gyC4h0LjjEtMl8X8BwGMeT80LirFpoabfwXWrXZwuJGh
         BJxiWwP5y80rlte2idC5LHV6mDAK7koBJwnWXBELDiZZFXV6EBkf0ed8CIcK6CDkDfNc
         EYLakc5GEp+9xd6bqY3hI1lyBY5W5UkCLS88TjU78XYGL8rzOwMH8EJkplizhqesDrtm
         YuVg==
X-Gm-Message-State: AOJu0YzusPxssuEt4JrLFnS4EId7WKvf3xUt1sDdmuclIE2UW8EvcPtm
        IYADrvfKQ9+KJnaV2fz807PsK3/zjOg=
X-Google-Smtp-Source: AGHT+IFnRwkLvEGLMmOenWNn9XKiIbSNmznR2IUPt5HqUEqAUppmd5a2JUCASkiwyHqAzTVJQQOpPK6kyHI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:c7d2:0:b0:c78:c530:6345 with SMTP id
 w201-20020a25c7d2000000b00c78c5306345mr174231ybe.7.1698093334369; Mon, 23 Oct
 2023 13:35:34 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Mon, 23 Oct 2023 13:35:31 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Message-ID: <20231023203531.2461809-1-seanjc@google.com>
Subject: [PATCH gmem] KVM: Fix off-by-one error when querying attributes in xarray
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Binbin Wu <binbin.wu@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>
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

Subtract -1 from kvm_range_has_memory_attributes()'s @end when using
xas_find(), as "end" is exclusive whereas xas_find() takes an inclusive
"max" as the maximal index to find/return.

Reported-by: Binbin Wu <binbin.wu@linux.intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/kvm_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 959e866c84f0..12458959dd25 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2447,7 +2447,7 @@ bool kvm_range_has_memory_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
 	rcu_read_lock();
 
 	if (!attrs) {
-		has_attrs = !xas_find(&xas, end);
+		has_attrs = !xas_find(&xas, end - 1);
 		goto out;
 	}
 

base-commit: 911b515af3ec5f53992b9cc162cf7d3893c2fbe2
-- 
2.42.0.758.gaed0368e0e-goog

