Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 091AE7B99A7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 03:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244376AbjJEBbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 21:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244371AbjJEBbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 21:31:19 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA068C1
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 18:31:15 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-27731a63481so372518a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 18:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696469475; x=1697074275; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=l4R4Z1slmx00T+W/d+fdBeoxG7w3RDtRgxkLjahc63g=;
        b=k3m/MPmrZGKZa4P+IgxMyBjj6Gh4BNwhdcFBjIEPr5C2TwUiLioyjjDaIL791ngWz4
         Wd21GCJfEZeqgxVeYFRkaQj2QVHdMAcr1mlmqqb4UTLu5N6CvWRz5dqHz3cJVG/UpU+l
         20UBheF9KTW5zgGfQrjo0Qcq+fQKek2eUCVohlUhX8x9xTVd0dYl8YyIMWnTCbDBosgW
         lkX5XH5bk0f2ZQ27lcKKSEvXUFemT05MlkrfN3oOT0q46qXLGfphVEd9DrNNgabahR+H
         GlbSH4JthuMLEA+y+Xg3WkHD/0wpXZeVmvgRYRoAeM26a9zo+FJjermWHOpKJojIb789
         ErhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696469475; x=1697074275;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l4R4Z1slmx00T+W/d+fdBeoxG7w3RDtRgxkLjahc63g=;
        b=KWPf7mWeS1y3M4D8UL88BRjkckijMM1zC10vi/Ic0LLMXi8JogemBOMJoovU5JuI+9
         gyceEkwUbGHa5Lm/TeykmNhh6NrbEwKofyrBShzc/RNUHmXmfVQj+CwDJyUFd3heNSbR
         V45kI9bmbw5Mf/ZNhQLovMjcylg8A76kNrNz5Jqiu42PKBu38r5tqQB5+n/jVT2Kphyf
         mlWwC8o45dh76UOQXNFNHHzkVFwj/IS7MA+ErriYcROiVY6i4AXX7qdrBTQrKhALsim2
         J5mgZARMweWfLFLd9owc+gihEtutKpxCt/GLGG07OljAF7TaDTCFEMVPlE+sc/a8ji8S
         FXJw==
X-Gm-Message-State: AOJu0YzRxSJARijILwwjRNm1ZU5btK+qmrJovDeY3X1lTPPkyKmh0LIg
        t/xVunYf9cyt6g/OM9kXfuhaNf3Q8ng=
X-Google-Smtp-Source: AGHT+IE7GG6oFKaGaJA/201tyvZ6D8znN1nfmgDyJ9reoTh6OzvmINBKoJs00tpc32XncWrJ6swRYZ10VtM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:aa84:b0:279:84c3:4ab4 with SMTP id
 l4-20020a17090aaa8400b0027984c34ab4mr63251pjq.9.1696469475432; Wed, 04 Oct
 2023 18:31:15 -0700 (PDT)
Date:   Wed,  4 Oct 2023 18:29:31 -0700
In-Reply-To: <20230921171641.3641776-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230921171641.3641776-1-seanjc@google.com>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
Message-ID: <169644922928.2748529.5109845433456152640.b4-ty@google.com>
Subject: Re: [PATCH] KVM: selftests: Treat %llx like %lx when formatting guest printf
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Aaron Lewis <aaronlewis@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Sep 2023 10:16:41 -0700, Sean Christopherson wrote:
> Treat %ll* formats the same as %l* formats when processing printfs from
> the guest so that using e.g. %llx instead of %lx generates the expected
> output.  Ideally, unexpected formats would generate compile-time warnings
> or errors, but it's not at all obvious how to actually accomplish that.
> 
> Alternatively, guest_vsnprintf() could assert on an unexpected format,
> but since the vast majority of printfs are for failed guest asserts,
> getting *something* printed is better than nothing.
> 
> [...]

Applied to kvm-x86 selftests, thanks!

[1/1] KVM: selftests: Treat %llx like %lx when formatting guest printf
      https://github.com/kvm-x86/linux/commit/b15e7490a1ef

--
https://github.com/kvm-x86/linux/tree/next
