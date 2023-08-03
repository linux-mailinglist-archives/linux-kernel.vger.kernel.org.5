Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C064B76DBEB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 02:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232759AbjHCAEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 20:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjHCAEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 20:04:33 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC88A1BC7
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 17:04:32 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-56942667393so2856747b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 17:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691021072; x=1691625872;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LR0gUEb+d6vy/5/y9RMKjoX8S1s9lNuEvXexoSjnakA=;
        b=mmgJMTFbNK1UJLZG91k+s3kKc02NlqCqOqm9/Rt+hQZC1xWfzWPpJMwGjRTAK9AT9n
         j+YjF3UFUuxj2nkUCBDQAwZI5KD4VJjElfYp63zp2NNshxSxCntd5oeAPWfxHnvVyVxO
         PILo3oax+rCaVAG/v5Ldi/47eXsqGepKU9N9EGyPZb4CI5LOTsojP2b7fi3M6ijfAUFL
         +vS1pSEvSs/hhNbiYKuy+qCZwfsns7HTcCRc/D25F9xSSL+ffm3n5MsBCyGnXNhuRzKC
         yVPiAcgeoQpGwZtYjcTmH+sB96uf0cdm4nQxSl+mWfgUciguG9gz/GoZQvyI5YPfMRRH
         /O/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691021072; x=1691625872;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LR0gUEb+d6vy/5/y9RMKjoX8S1s9lNuEvXexoSjnakA=;
        b=MkWtZtRlg7ZEs+90ERCjI/IohwO9Vv/K8HyebZfdkPcfhmx8X+OxLzikPEJjOcVi6L
         VNdKIHQuRrMlgqVdabb8XhUYrEQCrs5ragTvF6tHJIxYgyS1yZFY1t0Iqb1zv8N1bf9j
         /2XwLu3x4m/m4OJetdLRCqHw9fTnXy+pUBwaE6kKx0yqnM60VDcHs4zRdQ9JuwFvuJHL
         J9QSjcKGZY12rLpQi0VTlxkOvbaYDjMQcrjs97raOte4Cwb8mXdtwywTT7V/PZy6hRbn
         kM9pDVOMkawYWrbEOfWCJhN3H7cI8/eIuKxMWxkJDE3o+ZU/f+c1v4TNBmpgtrc8Gqz+
         TACg==
X-Gm-Message-State: ABy/qLbCZkkJyCzBhnjdX5RmefQfcf69wRduNDBXfJndoMfZlFjcICGI
        VsGFiqIR96Tl8x/nLqtJsrW7UHTT82A=
X-Google-Smtp-Source: APBJJlEEHT176Tb6k+4ZInXk/ZHuEE9moC04ehkMkZpfTjR+ogtPHHqlEwz2ILItO0honvBCgpQc+8MWR+k=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:c609:0:b0:570:b1:ca37 with SMTP id
 l9-20020a81c609000000b0057000b1ca37mr159089ywi.5.1691021072079; Wed, 02 Aug
 2023 17:04:32 -0700 (PDT)
Date:   Wed,  2 Aug 2023 17:04:14 -0700
In-Reply-To: <20230712183136.85561-1-itazur@amazon.com>
Mime-Version: 1.0
References: <20230712183136.85561-1-itazur@amazon.com>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <169101763292.1822238.2978170484113965893.b4-ty@google.com>
Subject: Re: [PATCH] KVM: pass through CPUID 0x80000005
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Takahiro Itazuri <itazur@amazon.com>
Cc:     Takahiro Itazuri <zulinx86@gmail.com>
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

On Wed, 12 Jul 2023 19:31:36 +0100, Takahiro Itazuri wrote:
> Pass CPUID 0x80000005 (L1 cache and TLB info).
> 
> CPUID 0x80000006 (L2 cache and TLB and L3 cache info) has been returned
> since commit 43d05de2bee7 ("KVM: pass through CPUID(0x80000006)").
> Enumerating both 0x80000005 and 0x80000006 with KVM_GET_SUPPORTED_CPUID
> would be better than reporting either, and 0x80000005 could be helpful
> for VMM to pass it to KVM_SET_CPUID{,2} for the same reason with
> 0x80000006..
> 
> [...]

Applied to kvm-x86 misc, thanks!

[1/1] KVM: pass through CPUID 0x80000005
      https://github.com/kvm-x86/linux/commit/af8e2ccfa6f1

--
https://github.com/kvm-x86/linux/tree/next
https://github.com/kvm-x86/linux/tree/fixes
