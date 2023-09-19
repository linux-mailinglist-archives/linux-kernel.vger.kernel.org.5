Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3627A576B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 04:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbjISCbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 22:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbjISCbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 22:31:41 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5025B120
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 19:31:34 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-50308217223so3764986e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 19:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695090692; x=1695695492; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N5MbU8VIeu5EiJtwca5r7fWgQWeL6jFIFNv2pIv6XV0=;
        b=oYUQdMc9QxIwjQMWSfwWzOZKxwMLFsUwarCh99YSi6ih2vmlqAkMRkDQ+yloRfk/Ub
         zz2nHhfv+JpL+0AZERQsER+AEpIa+LBXkNlyRiqm8TNdT1ZybYUHuv/NX1yHermWKLUr
         Ph/SSFh8pN/JNw0jdhSResa3YOAR0bmmB4Iic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695090692; x=1695695492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N5MbU8VIeu5EiJtwca5r7fWgQWeL6jFIFNv2pIv6XV0=;
        b=TwcHQIV8mm+ZXr168IWoYXrc7MxHBERBMlVcmCRJqEV0Z19V+lRq7gRrf5e3Hzy4Zj
         GAx6tIUhyEKqQgSyUz+4ThczMGy9gYXspkUo5brnqCwj7VjM/j5pzb8Y8nnnUrzO6foW
         c5iOV+bkelBeFXhCH1e53ZlknoGJh+HDXiIWFV/2IK67i7J7m2YPc0eL/A1totonuhRk
         aQhlcS6CZMbwfNqIHGo9Oqphy2DHRZiVE+E8G2/6zBLCV/OtqWyV1nkGRYBev8gIGwhc
         Cj87Xrw4Z+A/6Rtxkli+uStfceID3x1JFS4vudGJh4zMybffV+X6FJ1ddhViLaakAOCE
         3SIQ==
X-Gm-Message-State: AOJu0YxDsXammaspJRnyjun9A1wTgm97IP8hiigu5OeCUu2p3RO9XIWZ
        Wjx/aAJU1LZiE5/Nv0Mtvx4eiHEy++6B2lTzRiOwSg==
X-Google-Smtp-Source: AGHT+IGYCxBFEzEjTAyANkyZd9lS1pK+lX+uxDNz+TczYIgHSjG072fjvVdeIR+bF5iEyMR0OJrOGNhi1XswkfAyyYI=
X-Received: by 2002:a05:6512:1319:b0:503:2deb:bbc1 with SMTP id
 x25-20020a056512131900b005032debbbc1mr839997lfu.22.1695090691893; Mon, 18 Sep
 2023 19:31:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230911021637.1941096-1-stevensd@google.com> <20230911021637.1941096-7-stevensd@google.com>
 <14db8c0b-77de-34ec-c847-d7360025a571@collabora.com>
In-Reply-To: <14db8c0b-77de-34ec-c847-d7360025a571@collabora.com>
From:   David Stevens <stevensd@chromium.org>
Date:   Tue, 19 Sep 2023 11:31:20 +0900
Message-ID: <CAD=HUj62vdy9CmqHWsAQi4S6i1ZH8uUE81p8Wu67pQd5vNRr+w@mail.gmail.com>
Subject: Re: [PATCH v9 6/6] KVM: x86/mmu: Handle non-refcounted pages
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        Zhi Wang <zhi.wang.linux@gmail.com>, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2023 at 6:58=E2=80=AFPM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> On 9/11/23 05:16, David Stevens wrote:
> > From: David Stevens <stevensd@chromium.org>
> >
> > Handle non-refcounted pages in __kvm_faultin_pfn. This allows the host
> > to map memory into the guest that is backed by non-refcounted struct
> > pages - for example, the tail pages of higher order non-compound pages
> > allocated by the amdgpu driver via ttm_pool_alloc_page.
> >
> > The bulk of this change is tracking the is_refcounted_page flag so that
> > non-refcounted pages don't trigger page_count() =3D=3D 0 warnings. This=
 is
> > done by storing the flag in an unused bit in the sptes. There are no
> > bits available in PAE SPTEs, so non-refcounted pages can only be handle=
d
> > on TDP and x86-64.
> >
> > Signed-off-by: David Stevens <stevensd@chromium.org>
> > ---
> >  arch/x86/kvm/mmu/mmu.c          | 52 +++++++++++++++++++++++----------
> >  arch/x86/kvm/mmu/mmu_internal.h |  1 +
> >  arch/x86/kvm/mmu/paging_tmpl.h  |  8 +++--
> >  arch/x86/kvm/mmu/spte.c         |  4 ++-
> >  arch/x86/kvm/mmu/spte.h         | 12 +++++++-
> >  arch/x86/kvm/mmu/tdp_mmu.c      | 22 ++++++++------
> >  include/linux/kvm_host.h        |  3 ++
> >  virt/kvm/kvm_main.c             |  6 ++--
> >  8 files changed, 76 insertions(+), 32 deletions(-)
>
> Could you please tell which kernel tree you used for the base of this
> series? This patch #6 doesn't apply cleanly to stable/mainline/next/kvm
>
> error: sha1 information is lacking or useless (arch/x86/kvm/mmu/mmu.c).
> error: could not build fake ancestor

This series is based on the kvm next branch (i.e.
https://git.kernel.org/pub/scm/virt/kvm/kvm.git/log/?h=3Dnext). The
specific hash is d011151616e73de20c139580b73fa4c7042bd861.

-David
