Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B35DE7D12D0
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 17:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377733AbjJTPcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 11:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377663AbjJTPcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 11:32:09 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8942AB
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 08:32:07 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1c9f973d319so8141475ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 08:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697815927; x=1698420727; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=X28nqJeYL84cwkoy9Ukz+291k+i+3AkqmrCU0I6FmGI=;
        b=ykFAXbjMZS77yAZj8Zh2AEY71vF427+ZbPCFcKATpT4l2IxLIOiLSA0YyikIcaVG/6
         2aT5kBUkscGxbRL7AS5q3Ybq8FGx1aSMGxVUTfpZqiKQwmoKDNg2V+tyAmjjOxeyGwuo
         glaGyW3adgFznn90roDFi86uqNi2f872VjFCyjNGrFwl/UXasG1PFtlY28l3gdyziqJH
         zejH1HTd+q7BqxM9Grw7i22LRveenR2reW+pt4z9bvQqK5VyMWr9B4Xbj8sSWQRwkCCa
         Vkk5Y80gY+P/jD1gNHVHYOeqc0Rw0QUyIKTq0g8QhkYx9iWI/pPyT5jc8KiWZHdzd04/
         sXPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697815927; x=1698420727;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X28nqJeYL84cwkoy9Ukz+291k+i+3AkqmrCU0I6FmGI=;
        b=M7v2Os0U2njRU5n7Ua8ReBzlLzAcVYEFSAVelsknCj2V3ccsqg6Y/2+vFqzaF9Ew2K
         9RzsJvP13EQtl3mb5FEhK+kB9XM4aNpimQaDuc9J9QMC2/2mRYwEhkROqvhYmyMYeTwf
         HIkAx/JqEUSZCHhfRBQOgzOvfRDiU7UNC3CwpnGHDt+GI+1oIwoG9Pm5UIMphQmkE6PM
         6VX5xk2Pw+PCpOENoUO/Ceno+CR2BjaU+9pSPLZSfoAdi4hGY/aiCfgJHB0DuyH7nQyp
         QYObho8CoHvL9pCA9e/Yc+QZcr6ndV4PaJuAIfssVlBEQTabklOKadcDigqkwkCiO45E
         QI2g==
X-Gm-Message-State: AOJu0YzDXIcv0BI7Z2Lwnq+vP+3vighoGKu5Htd41E9OmrqvPECxlksc
        bR9vSEM9B7MTpp1i5xVCx10j4cY8srU=
X-Google-Smtp-Source: AGHT+IH2aSPsxsO7CwyUlO4VocEfaDkvgJ7FypQ7zwjBiO8wnvZig7O+kXIj+6lirvDOUIZvueCzOsujUuo=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:e214:b0:1c9:db23:706e with SMTP id
 u20-20020a170902e21400b001c9db23706emr38706plb.5.1697815926809; Fri, 20 Oct
 2023 08:32:06 -0700 (PDT)
Date:   Fri, 20 Oct 2023 08:32:05 -0700
In-Reply-To: <20231020151242.1814-5-kirill.shutemov@linux.intel.com>
Mime-Version: 1.0
References: <20231020151242.1814-1-kirill.shutemov@linux.intel.com> <20231020151242.1814-5-kirill.shutemov@linux.intel.com>
Message-ID: <ZTKddZEUyL3QQB6_@google.com>
Subject: Re: [PATCHv2 04/13] x86/kvm: Do not try to disable kvmclock if it was
 not enabled
From:   Sean Christopherson <seanjc@google.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Jun Nakajima <jun.nakajima@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ashish Kalra <ashish.kalra@amd.com>,
        Kai Huang <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>,
        kexec@lists.infradead.org, linux-coco@lists.linux.dev,
        linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023, Kirill A. Shutemov wrote:
> kvm_guest_cpu_offline() tries to disable kvmclock regardless if it is
> present in the VM. It leads to write to a MSR that doesn't exist on some
> configurations, namely in TDX guest:
> 
> 	unchecked MSR access error: WRMSR to 0x12 (tried to write 0x0000000000000000)
> 	at rIP: 0xffffffff8110687c (kvmclock_disable+0x1c/0x30)
> 
> kvmclock enabling is gated by CLOCKSOURCE and CLOCKSOURCE2 KVM paravirt
> features.
> 
> Do not disable kvmclock if it was not enabled.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Fixes: c02027b5742b ("x86/kvm: Disable kvmclock on all CPUs on shutdown")
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Wanpeng Li <wanpengli@tencent.com>
> Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> Cc: Sean Christopherson <seanjc@google.com>
> ---

Reviewed-by: Sean Christopherson <seanjc@google.com>
