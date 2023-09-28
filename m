Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B92C07B22A8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 18:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbjI1Qmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 12:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231535AbjI1Qmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 12:42:37 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D11C1AE
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 09:42:36 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1c73637061eso10231535ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 09:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695919355; x=1696524155; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bGSaUROQXQCdbfnq5W92vVAiWr6RA+1OO94Wb6mQU/w=;
        b=2F9wAaubcH++R4ALbleuNIFylqp+QwbEVv7Jse5G0Va+OY9gQUjhlQy0u3p5zXrWCV
         xBT4CrwiTlBxwXtRJm7y9K+pN2FeYlxr4dfZLbvBxwwQcJ2RWHHbPJY5xZ1c9SO6VVfy
         UwNJPuzUGhggowldQUy5lwWcNjmFBu0a+46gqAgFYqVcB3SxfoFPl/LNFPhsk3Dag92e
         H/lvGMeYiT3LmeHat4LwUVc5RF0JNnMYEOuR8IVGnArInVB40FH3WMrlPgfi7eknHUm0
         KyIa6aeD0vm82pYp1fCP19nO0GSEYPbc9rNptmdklGllbCIOxGpOcwIPmdJ5P3jSn7dF
         Yqvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695919355; x=1696524155;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bGSaUROQXQCdbfnq5W92vVAiWr6RA+1OO94Wb6mQU/w=;
        b=pQub5wD47YWmEtiQWnqjeqdDOock9uVTwIdg3hfjXF0Vgk956fGk1qzONqRgCG4HLd
         x+cqTV/tUHc20lTfSumnm4M71k+dY8BFBLBXJsQq+O2cvWz1hFE7TMUANNVlp2N2MrgQ
         W8/LYX4UxF5DiV0YAc+qWX2YZGxlaEj232WAp0RHgCRdKm9MfGuB1BparmQMo3FAK8Qp
         E+1F+r/cr/a/0dXSygYDOcnfI7gwjDb9jnfeWkurtyMy0vQfC9KrdnvBtcXEex9kinAN
         Y2uRRApgVDusbdPn8qF4FuojbSJ5NIGeKT54yHhZjP4hZCuO2+iRdW6+nC49fALJLEnv
         Slhg==
X-Gm-Message-State: AOJu0YzqC4VKmZOxJ/85qZWQIaOAWf8XKttk+q1s/Du6lmAlIZSHK2h4
        9+skC3cSe3SD9NChNVPcdLRWqa+5F3U=
X-Google-Smtp-Source: AGHT+IGL1kaaynpSzZs9P9RfVZGfoeYZA85TB4CE++bWqrA+6EfosmDI1QwBzU5oHPOLD8JBNEskPNw/hVE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:c714:b0:1c0:d418:8806 with SMTP id
 p20-20020a170902c71400b001c0d4188806mr21489plp.12.1695919355670; Thu, 28 Sep
 2023 09:42:35 -0700 (PDT)
Date:   Thu, 28 Sep 2023 09:41:54 -0700
In-Reply-To: <20230925173448.3518223-1-mizhang@google.com>
Mime-Version: 1.0
References: <20230925173448.3518223-1-mizhang@google.com>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
Message-ID: <169567819674.170423.4384853980629356216.b4-ty@google.com>
Subject: Re: [PATCH 0/2] Fix the duplicate PMI injections in vPMU
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Mingwei Zhang <mizhang@google.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>,
        Dapeng Mi <dapeng1.mi@linux.intel.com>,
        Like Xu <likexu@tencent.com>, Roman Kagan <rkagan@amazon.de>,
        Kan Liang <kan.liang@intel.com>,
        Dapeng1 Mi <dapeng1.mi@intel.com>
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

On Mon, 25 Sep 2023 17:34:45 +0000, Mingwei Zhang wrote:
> When we do stress test on KVM vPMU using Intel vtune, we find the following
> warning kernel message in the guest VM:
> 
> [ 1437.487320] Uhhuh. NMI received for unknown reason 20 on CPU 3.
> [ 1437.487330] Dazed and confused, but trying to continue
> 
> The Problem
> ===========
> 
> [...]

Applied to kvm-x86 pmu, with the order swapped and a bit of changelog massaging.
Thanks!

[1/2] KVM: x86: Mask LVTPC when handling a PMI
      https://github.com/kvm-x86/linux/commit/a16eb25b09c0
[2/2] KVM: x86/pmu: Synthesize at most one PMI per VM-exit
      https://github.com/kvm-x86/linux/commit/73554b29bd70

--
https://github.com/kvm-x86/linux/tree/next
