Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED5A37B29E2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 02:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232590AbjI2Amm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 20:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232370AbjI2Amj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 20:42:39 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7898F199
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 17:42:37 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59f8315aabfso171196917b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 17:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695948156; x=1696552956; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oXtA4CIJkNUO5AsjiezElUAdl6m7M7+pcvajILFIvUQ=;
        b=hBM189yw+GdQO7P5ZRR6DmndM+3KSxm2bUhd7TPkgDw812YDDBQ1mPkspuJhDVgK23
         Y25xnxioVVZhz67kNxYJvdqKUmB1NYa1FFSZUHOvkaLyt7TeLQonqsdiXKVshzRofPnF
         Udw2RgAxI4sLM9H/TRVxLFAylmqSMVg2We0M/C6ywAHsMs1a/tkhBTuVV8Bc10KgMFX8
         aSKuVzZPXHJKK0RCcFgBhvYjogRQlsKBzfMGnVEQ8Rr0Yh7IPuzy4FoVDru9WZiewcIe
         8nzDixUIdwS8AF2d33RmzOWZwq/B5pRFKTzaA0QmSxGN3v8rcDAFQl5C806L6ne82qYq
         1qzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695948156; x=1696552956;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oXtA4CIJkNUO5AsjiezElUAdl6m7M7+pcvajILFIvUQ=;
        b=bx2RdwBUw6FzpxEpv19tvzOqLhLljL6Qsdl2l23SSi50BEC58OKpgMbnz48VRAXUBl
         MDr51hZLOo7KprsvIQE2QSVg7LdBAQ0Ubcpvn3SPJKALxrrRPbnlRKP3M+tdr8zLnlUY
         af1guIRmwWtsd2lYzi3397m5XXbYwSR1FA/DfpOh8w2kh37r/dv43a5yDmXWyXXf665u
         xt22at06j47t+gQUY2xAkMmLw0RdDzV+upN0i8boAIN1szzgnaO59wEezErAZ8L/DwHn
         i5P9mPjWluoRw84nSc8Ok+SnTeeu6E2CTNTefRNgOWLAtWK3g8P+8CNVumXxKQ6d3odn
         ET0g==
X-Gm-Message-State: AOJu0YwcVmrBED4hgVYn14Erl5m0Nd1Xr+tRI9em32Xs86U/aqFjeRjK
        avGzlftSGt2on1nSEjttP4mS0xfnX6A=
X-Google-Smtp-Source: AGHT+IHQKL11sXvSD1OxXeiwjG9Teo/hx0bwxPfT/7G9T+4Ho10xF8UFwRp+Kp/lYdliugSW1vqRYpcVA/Y=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:181c:b0:d82:9342:8627 with SMTP id
 cf28-20020a056902181c00b00d8293428627mr42880ybb.6.1695948156573; Thu, 28 Sep
 2023 17:42:36 -0700 (PDT)
Date:   Thu, 28 Sep 2023 17:42:35 -0700
In-Reply-To: <20230928173354.217464-4-mlevitsk@redhat.com>
Mime-Version: 1.0
References: <20230928173354.217464-1-mlevitsk@redhat.com> <20230928173354.217464-4-mlevitsk@redhat.com>
Message-ID: <ZRYde2P413vWOYDq@google.com>
Subject: Re: [PATCH v2 3/4] x86: KVM: SVM: refresh AVIC inhibition in svm_leave_nested()
From:   Sean Christopherson <seanjc@google.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     kvm@vger.kernel.org, iommu@lists.linux.dev,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Joerg Roedel <joro@8bytes.org>,
        x86@kernel.org,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>, stable@vger.kernel.org
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

On Thu, Sep 28, 2023, Maxim Levitsky wrote:
> svm_leave_nested() similar to a nested VM exit, get the vCPU out of nested
> mode and thus should end the local inhibition of AVIC on this vCPU.
> 
> Failure to do so, can lead to hangs on guest reboot.
> 
> Raise the KVM_REQ_APICV_UPDATE request to refresh the AVIC state of the
> current vCPU in this case.
> 
> Fixes: f44509f849fe ("KVM: x86: SVM: allow AVIC to co-exist with a nested guest running")
> Cc: stable@vger.kernel.org
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---

Reviewed-by: Sean Christopherson <seanjc@google.com>
