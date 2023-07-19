Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7372758E9A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 09:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjGSHRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 03:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbjGSHQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 03:16:47 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB741FFC
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 00:16:38 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b74209fb60so99019051fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 00:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689750997; x=1692342997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qqjGnkydjRYo2dESqfO3eXpJEsuUSuu3liWybMYNxjM=;
        b=gX7b5UN9DkeHJXYwujSe1mjmePWQplvCvP44U3BFMNFhyjzTNc5cPL0b0FlYXl4Hcq
         jxN76VnlMs/9ozWflSmx+8DKY2OPbWWT7ADykcn5N3+7vzltbgVCMSrmganHSQMB0To9
         M8iQKIij7Ois9wkxeKl3uimcVDRE1EU2yCMg0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689750997; x=1692342997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qqjGnkydjRYo2dESqfO3eXpJEsuUSuu3liWybMYNxjM=;
        b=VSrYgHhLdz/HEilJ9p/SO0LEtdkGMDBJ2OBZGGy/78TRwZkSDjWBxZB1OBlPkYFRIu
         6GmUg87RbruFE4c5w5s3HneRb7m/PfTtLQ6dS76DSbkPN1wFEkeBUIzESnGGkFIDGp1h
         DlPxpWc3WvETmNv8PmUVpHae+oZHCjyV21pgngbkZqFDkyoRvwWytTi4PCFyHnVYWGx1
         ZpnfnOopVgAHDRu69LNSGkT3M+qhKtnRvDCr1WV3TTQWQDPmS3ddvBXXnJOFqxW2sfJ/
         QVRhqyBFDr8ZwKWyBCnYL3sWdndpT5p6Rpjdow68s+VKVn/EnJYmNDRIMk8iZkZnN8dV
         22mg==
X-Gm-Message-State: ABy/qLbwXl3ehRbhBrDYiSk2aGZaSBTGFDX5/xVfnXIld3HM/Fo7sJR5
        ihYH3FEJKAxibkPY5tQ/wkQquk5HrdcsPFRFVsGvhA==
X-Google-Smtp-Source: APBJJlFqhwQMdurqFqZbJF6PVLk2bfOiT9p8qJTEaQQQ3Jq/BQQ5+E1DH8yM8SRT8kMqvgYsDBHQZ/8q8j2PVmM/Edg=
X-Received: by 2002:a2e:b164:0:b0:2b7:1c0f:f221 with SMTP id
 a4-20020a2eb164000000b002b71c0ff221mr1255715ljm.39.1689750997071; Wed, 19 Jul
 2023 00:16:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230704075054.3344915-1-stevensd@google.com> <20230704075054.3344915-6-stevensd@google.com>
 <ZLd9/V6EAxSwEAzY@yzhao56-desk.sh.intel.com>
In-Reply-To: <ZLd9/V6EAxSwEAzY@yzhao56-desk.sh.intel.com>
From:   David Stevens <stevensd@chromium.org>
Date:   Wed, 19 Jul 2023 16:16:26 +0900
Message-ID: <CAD=HUj58w8O_XnpOSr_+VH8-evcn+y7ReWPZ-96QesXF4mUybw@mail.gmail.com>
Subject: Re: [PATCH v7 5/8] KVM: x86/mmu: Don't pass FOLL_GET to __kvm_follow_pfn
To:     Yan Zhao <yan.y.zhao@intel.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Xu <peterx@redhat.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 3:35=E2=80=AFPM Yan Zhao <yan.y.zhao@intel.com> wro=
te:
>
> On Tue, Jul 04, 2023 at 04:50:50PM +0900, David Stevens wrote:
> > @@ -4451,7 +4461,8 @@ static int direct_page_fault(struct kvm_vcpu *vcp=
u, struct kvm_page_fault *fault
> >
> >  out_unlock:
> >       write_unlock(&vcpu->kvm->mmu_lock);
> > -     kvm_release_pfn_clean(fault->pfn);
> > +     if (fault->is_refcounted_page)
> > +             kvm_set_page_accessed(pfn_to_page(fault->pfn));
> For a refcounted page, as now KVM puts its ref early in kvm_faultin_pfn()=
,
> should this kvm_set_page_accessed() be placed before unlocking mmu_lock?
>
> Otherwise, if the user unmaps a region (which triggers kvm_unmap_gfn_rang=
e()
> with mmu_lock holding for write), and release the page, and if the two
> steps happen after checking page_count() in kvm_set_page_accessed() and
> before mark_page_accessed(), the latter function may mark accessed to a p=
age
> that is released or does not belong to current process.
>
> Is it true?

Yes, good catch. During some testing last week, I actually found this
bug thanks to the WARN_ON the first patch in this series added to
kvm_is_ad_tracked_page. I'll fix it in the next revision, after Sean
gets a chance to comment on the series.

Thanks,
David
