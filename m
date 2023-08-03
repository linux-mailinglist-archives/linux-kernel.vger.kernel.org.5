Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF0D76DBEF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 02:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233113AbjHCAFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 20:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233008AbjHCAFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 20:05:04 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAEDE3595
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 17:04:53 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-268068d80b9so207507a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 17:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691021093; x=1691625893;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DXU39SurILvLq6/JHGmrQjH3sd/iayRp3k55K10Q/Qk=;
        b=N14EqhlH0XuYi9c09FUvrhuEBhP7trrjQMLSKdu2cdfa1LPv9sxVtHElHiETn+I6U/
         gCOJDpUWG8lJ/0UboJS3J2H6A36Io2deAKykmSvfuTmswnNmiiBZzjaA68MOvL++DsQm
         Xvv+F5aKNQftippfJymAOtEh0NVZaToIgrCu9F/jlrsBg6LAhpoYJGn5DSqbStlgcesz
         F4nLEKYSFeWELM23xtVMfennKPah7ExG4x23ELb9kWF2B6l4nXDK9tZfSVpcHsLtVwMN
         ExFkb5da8XXiOy9DCduUeaap6nIXMqc3W0T/cbOaagVrzFlcHhBeDef7QgoBF5gYCLvL
         rtAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691021093; x=1691625893;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DXU39SurILvLq6/JHGmrQjH3sd/iayRp3k55K10Q/Qk=;
        b=mCtGQjhQoh/H40PP7aualsr78y57CJnxAeAcVn1gMl2aLyu3dTQriu6430vOHon61u
         qI0wzYi/VINOZ3FFQT0JtGnrxxpZqqoQynNnvMaQJ2e9rB7oJY1QeD0sfpFio0oZ4Gj3
         G9mjwnqiEGVe5CecQ+uhI8MDFR/eI1I1tLhqD5ES4lkD2v6GLPt1/hXUDYBxLcOwzRep
         PvA1rEgq+++3JBGCGc1kScGRNomxdlYaUI1Exl+wvlLztenESZnjj+MvAwixgRedfTxs
         L5tG6ozuH0BPHoIS3CuI+CjetJc22zuFeQmDcAneReOeFQSklEIGoFQbqzhR0IQ0AC9M
         iCXQ==
X-Gm-Message-State: ABy/qLbtq/IgIIrE5cj+NDqvhy21zSU2o/ZbISVMYeEJejvSauCfUuDL
        kQHk8n4ND1YsP4IpmTGqjkFVirkidqM=
X-Google-Smtp-Source: APBJJlFmlZz1vW97Bw3DBbbuJ84tUClcHIydMYh0fXTvTgoTFTC/4T4z3fFFmfEOuCL6oaFRTNunDJk8uec=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:d4c8:b0:1ba:ff36:e0d7 with SMTP id
 o8-20020a170902d4c800b001baff36e0d7mr106609plg.12.1691021092793; Wed, 02 Aug
 2023 17:04:52 -0700 (PDT)
Date:   Wed,  2 Aug 2023 17:04:20 -0700
In-Reply-To: <20230602233250.1014316-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230602233250.1014316-1-seanjc@google.com>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <169102013519.1831058.15796555141707320249.b4-ty@google.com>
Subject: Re: [PATCH v3 0/3] KVM: x86: Out-of-bounds access in kvm_recalculate_phys_map()
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michal Luczaj <mhal@rbox.co>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 02 Jun 2023 16:32:47 -0700, Sean Christopherson wrote:
> In Michal's words...
> 
> kvm_recalculate_apic_map() creates the APIC map iterating over the list of
> vCPUs twice. First to find the max APIC ID and allocate a max-sized buffer,
> then again, calling kvm_recalculate_phys_map() for each vCPU. This opens a
> race window: value of max APIC ID can increase _after_ the buffer was
> allocated.
> 
> [...]

Applied patch 2 with fixup for the typo to kvm-x86 misc.  Note, patches 1 and 3
went into 6.5.

[2/3] KVM: x86: Retry APIC optimized map recalc if vCPU is added/enabled
      https://github.com/kvm-x86/linux/commit/41e90a69a49b

--
https://github.com/kvm-x86/linux/tree/next
https://github.com/kvm-x86/linux/tree/fixes
