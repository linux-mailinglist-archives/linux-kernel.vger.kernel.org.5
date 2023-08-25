Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F903789245
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 01:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbjHYXQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 19:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbjHYXPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 19:15:49 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B987A2118
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 16:15:43 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-58e49935630so31538567b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 16:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693005343; x=1693610143;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AUL1GyRYJNXzwGDpCpWEMsAa6saByKtyyWFg6xkN/k0=;
        b=iXV98+JlIPikUAGtXoRKwAIqPeJ/R0wrCgEUaD4WK07bKYo/5l0vT9R96BzfQopBo5
         44N8Dat+cQbuYOXtnau1ODzW0aOJBiXYoPIMOj2XACkZjZH4/J5xUZ/dvIuiC6xFzLld
         TSpMHbeK8uxfbRaDTH45NQsefuRAAZrnzVjG2sZ+wxOB6qOya/kBzXmnQQ2pEMaWG/OC
         C8cuDT146WxWvf0VyT/JWkfs1WYH97WJ+dchEe9nxqV89HzO7rX6NIBnIfNz51PI3sM0
         pctEVhd1iaBoJS9dIGyJAPwK6NQjvSVbq80CGCzQ8TZF1Gga5EooOCRDbDnjGgyrj8fC
         lK0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693005343; x=1693610143;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AUL1GyRYJNXzwGDpCpWEMsAa6saByKtyyWFg6xkN/k0=;
        b=RShJu5TNVuR7E/AQqmAfjmqk8vEm0Gqw05gtHMA1qYqx0U5uXWVtEhIPhNtQrkfRiB
         6mji528qU3wUAmIpvmnuIgJIvRiG27PH6r/u6uCTExS0aDLy948+JJsrxQOGeLAIFq5o
         MX8k5bYtOIcb0r68Ksdd0MN2i+r2p124tRIfFqclY2vR3U0LWZeBdgXG0FrX2one5KuU
         QmpUy/HIA5zOIJiRZh20FT5B3pZGnQJG4jOuTDuqumAhxzT23rzsHq8bUoHwdaxvA4Ax
         XxRbV6nID26sjgjd/jpmlBkTyPZ4oLPF8dbJwTAnEoG0B3AAkzkL9vX0nsaKheBWTaMp
         WenQ==
X-Gm-Message-State: AOJu0Yxt2BTS7kO4gFM3GO9NnY1KTvBCKd2m3YQEbEQrtZYskbDnQmCE
        72mtnaG8gqSfeKLoV1Jz4O3LL6dtvfc=
X-Google-Smtp-Source: AGHT+IFToBFcB2nCA3YFbZm1JVgczPz/+vW51zSorJ6yqmN1px3q3LGNycFAi2RnJ1sr/T/Gl2M4d6+bu3Q=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:2f87:b0:586:e91a:46c2 with SMTP id
 ew7-20020a05690c2f8700b00586e91a46c2mr570293ywb.4.1693005343091; Fri, 25 Aug
 2023 16:15:43 -0700 (PDT)
Date:   Fri, 25 Aug 2023 16:15:41 -0700
In-Reply-To: <20230714065602.20805-1-yan.y.zhao@intel.com>
Mime-Version: 1.0
References: <20230714064656.20147-1-yan.y.zhao@intel.com> <20230714065602.20805-1-yan.y.zhao@intel.com>
Message-ID: <ZOk2HWEubJIRo1HN@google.com>
Subject: Re: [PATCH v4 11/12] KVM: x86/mmu: split a single gfn zap range when
 guest MTRRs are honored
From:   Sean Christopherson <seanjc@google.com>
To:     Yan Zhao <yan.y.zhao@intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, chao.gao@intel.com, kai.huang@intel.com,
        robert.hoo.linux@gmail.com, yuan.yao@linux.intel.com
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

On Fri, Jul 14, 2023, Yan Zhao wrote:
> Split a single gfn zap range (specifially range [0, ~0UL)) to smaller
> ranges according to current memslot layout when guest MTRRs are honored.
> 
> Though vCPUs have been serialized to perform kvm_zap_gfn_range() for MTRRs
> updates and CR0.CD toggles, contention caused rescheduling cost is still
> huge when there're concurrent page fault holding mmu_lock for read.

Unless the pre-check doesn't work for some reason, I definitely want to avoid
this patch.  This is a lot of complexity that, IIUC, is just working around a
problem elsewhere in KVM.

> Split a single huge zap range according to the actual memslot layout can
> reduce unnecessary transversal and yielding cost in tdp mmu.
> Also, it can increase the chances for larger ranges to find existing ranges
> to zap in zap list.
> 
> Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
> ---
