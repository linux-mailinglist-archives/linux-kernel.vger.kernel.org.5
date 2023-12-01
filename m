Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8FB800142
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 02:52:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376487AbjLABwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 20:52:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbjLABwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 20:52:44 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B4EA131
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 17:52:51 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5d379f92d70so17728107b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 17:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701395570; x=1702000370; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VmMRiyNlWj7E7DgTlLHv9EXBHs71X6661FunQt63Zuo=;
        b=qUMABBidryf5/55E1JgDs6QBRarLv17hNYabXoUbaxIbgfg3ryD1w7R4iuaYBxVBrC
         mwq+y+eeCNesQJZKjb6hvj3iuP8bCm2uUfyKMTV61DWCv/jH1/ScbeA8B6mTe7gNbKea
         OqtAkRnJgcpxqRsqueNn/WaR5NcReM86aZvHjDnepcy2DYaurpfJz54lemSgsOQyJxS5
         sGoW8Lt85oacUiOmZH17XobH5gGjBlPAHFPJTF7sFk3dojLPO/x+dMsHe9JRFJFpGt53
         gspAuiD1D7DXYfTATT3q+cs8xMrkf5kbSJzkf1rMhSqmGjqxyKhc8oJm81E0RkJp2+tr
         MzlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701395570; x=1702000370;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VmMRiyNlWj7E7DgTlLHv9EXBHs71X6661FunQt63Zuo=;
        b=pdaGZR5S6AGnR0z2oWyvgSVAoTNjnznCdIkHAqYAW1TV0cXA4zRpKwJ4/23tw33lFS
         Y44R0RGti2NSqHKaQYXIeLcvIU6aeoFP9RTTV/b5rtPSdgSE3SJMc4gok01oLWwTRWFS
         TIxJWFSUNe8ICQBTjtsY+LP4/gZIIUuyOfDkqw6GG+6j/jxgSrqsF0j+IJBcoFpPG/W8
         qmB416Ch+R1OTwvPWJuAsmd0XWIWGPFxH5BGjwyidDXR7CW8P7hsvL0ZPpeQULoutw+V
         Xl/n8GilbZR+ZVeiLm4Z59spoWOPsAllwAMx30MOTDT2g2DcmhI/49RbgOt+qsjX7O9f
         N+CA==
X-Gm-Message-State: AOJu0YzSHbOFcnJs4IcI2VfM8iOwJWzEsIyAsaBaSfhxdR7QUd+VIOB+
        Ncs2Slw0mRoxY9iMM5GsKDauWI0BShk=
X-Google-Smtp-Source: AGHT+IG0csC5MDjPOHcU6NEDOuOjQZAIXLHGqiPVTff1eLcelFsQF5L6YdMrleiiyf2icf/uD20FIF8jycU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:99d0:0:b0:5d4:1835:afe0 with SMTP id
 q199-20020a8199d0000000b005d41835afe0mr17243ywg.10.1701395570360; Thu, 30 Nov
 2023 17:52:50 -0800 (PST)
Date:   Thu, 30 Nov 2023 17:52:08 -0800
In-Reply-To: <20230315101606.10636-1-wei.w.wang@intel.com>
Mime-Version: 1.0
References: <20230315101606.10636-1-wei.w.wang@intel.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <170137868908.667071.11420459240927661184.b4-ty@google.com>
Subject: Re: [PATCH RESEND v2] KVM: move KVM_CAP_DEVICE_CTRL to the generic check
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>, pbonzini@redhat.com,
        Wei Wang <wei.w.wang@intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Wed, 15 Mar 2023 18:16:06 +0800, Wei Wang wrote:
> KVM_CAP_DEVICE_CTRL allows userspace to check if the kvm_device
> framework (e.g. KVM_CREATE_DEVICE) is supported by KVM. Move
> KVM_CAP_DEVICE_CTRL to the generic check for the two reasons:
> 1) it already supports arch agnostic usages (i.e. KVM_DEV_TYPE_VFIO).
> For example, userspace VFIO implementation may needs to create
> KVM_DEV_TYPE_VFIO on x86, riscv, or arm etc. It is simpler to have it
> checked at the generic code than at each arch's code.
> 2) KVM_CREATE_DEVICE has been added to the generic code.
> 
> [...]

Applied to kvm-x86 generic, thanks!

[1/1] KVM: move KVM_CAP_DEVICE_CTRL to the generic check
      https://github.com/kvm-x86/linux/commit/63912245c19d

--
https://github.com/kvm-x86/linux/tree/next
