Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A89280014F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 02:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbjLAB4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 20:56:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbjLAB4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 20:56:01 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7ED0F4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 17:56:07 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5d3bdbf1fb5so11423757b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 17:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701395767; x=1702000567; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Gpg0jRMfZzPs+DxGvN7fA6pxlWT05UdkEs/pO3pcReg=;
        b=2IDYwr3zmhFsRLV5KrY1UDgjkBoZb36qbFtvi6bwzpMY+6k0rRNVBkstydlj52Fuf6
         S929fjQVQ4I5Ngv0WWFSDlITPwIcJ+3d9rAA8v1hV7EkqL1QDENupL6SnbnIJDnUW599
         FCTfcWYcwPueHvjSp0Kn950WdADmJUQTF/kwCNXVxBT9+EL6q0EgoPC19OXssgxpx24W
         iI9mZv2fm0afxOVTxGl675ZauJAZ4ALslknmjMsWEGr3ZLEodNfNWkrjcvHuTPRzJkyJ
         kO6nT+cHT9oAry8KGfMWDIfyhPtnYDci+WYehW3XWCuSx97OcJ89eaOqSXk/pwSpsnQO
         dQVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701395767; x=1702000567;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gpg0jRMfZzPs+DxGvN7fA6pxlWT05UdkEs/pO3pcReg=;
        b=OTfln1rD5lAQ3Dud2WtXfOf7yHzmCvzt8dpgo0xBO8QRCDABiMBgxEb4ZSMhlfcVku
         /hQJjWFjY4l8wlysVcXWOUflZ9shQZO4WYsC+6z/3CH95cwP8630mAFMq4JiqPMg/rkf
         x7IHygMZH6wQ1XKShsuMT8a7wTLushhjR5mUv2GZY7io1+j9JyRdzmZ3YcyU4cyFR+UK
         jii7gXLSDPWHQsXBkabsfD1GtinXpI0+ECIQ0oygMLK5/wJXhSoIHLAoT4/PLXk1xj23
         i+FbYFFthYm/HmY2sLYFtPnfRbkDFDtMcVdeTe7bzeG3TXZJJI27q/YYnyZd8wZ9fNdR
         my7A==
X-Gm-Message-State: AOJu0YzPfLDncBb9mjQ0ndiz1waxkSJI7053xxz1Ufk6PWweR2nxNA0H
        ED48QLQPdMtSBqa1+XMC945vmEMk7AU=
X-Google-Smtp-Source: AGHT+IFv6EtpNEyk7jG2a6+OFieWqgV/IdpgQSQjtjX702lGZ3QboxxBNrX7OCdF0p//ZUIQ+fbkIwWyrdc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:ff08:0:b0:5cb:1bf4:ce09 with SMTP id
 k8-20020a81ff08000000b005cb1bf4ce09mr798787ywn.2.1701395767042; Thu, 30 Nov
 2023 17:56:07 -0800 (PST)
Date:   Thu, 30 Nov 2023 17:52:22 -0800
In-Reply-To: <20231125083400.1399197-1-pbonzini@redhat.com>
Mime-Version: 1.0
References: <20231125083400.1399197-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <170137684485.660161.8230111667906795222.b4-ty@google.com>
Subject: Re: [PATCH v2 0/4] KVM: x86/mmu: small locking cleanups
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     mlevitsk@redhat.com
Content-Type: text/plain; charset="utf-8"
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

On Sat, 25 Nov 2023 03:33:56 -0500, Paolo Bonzini wrote:
> Remove "bool shared" argument from functions and iterators that need
> not know if the lock is taken for read or write.  This is common because
> protection is achieved via RCU and tdp_mmu_pages_lock or because the
> argument is only used for assertions that can be written by hand.
> 
> Also always take tdp_mmu_pages_lock even if mmu_lock is currently taken
> for write.
> 
> [...]

Applied to kvm-x86 mmu, thanks!

[1/4] KVM: x86/mmu: remove unnecessary "bool shared" argument from functions
      https://github.com/kvm-x86/linux/commit/2d30059d38e6
[2/4] KVM: x86/mmu: remove unnecessary "bool shared" argument from iterators
      https://github.com/kvm-x86/linux/commit/59b93e634b40
[3/4] KVM: x86/mmu: always take tdp_mmu_pages_lock
      https://github.com/kvm-x86/linux/commit/4072c73104f2
[4/4] KVM: x86/mmu: fix comment about mmu_unsync_pages_lock
      https://github.com/kvm-x86/linux/commit/9dc2973a3b20

--
https://github.com/kvm-x86/linux/tree/next
