Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E282759A10
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 17:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbjGSPmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 11:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjGSPmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 11:42:40 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56240197
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 08:42:39 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-57325434999so68325557b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 08:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689781358; x=1692373358;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=D5fxkTnGgPpXTXRs+pAAOpKveu4sBAlnJ9TAdnEyBnc=;
        b=lHyhjCYeBP7i/K/0t117SJ2Lo9qZWJUGNdXY0iv+0+zNE60S1cOmziGlbGeN2uN9nn
         Kqr9JUKTOHvutwoyRE/MiATy7kCuewOpsSoguamfe7GM2cRjdoWR0VIfhY1R1YGuyUxM
         9Hffie45CBgwONB4rPVioxMTCmiNTYLqyF0n06Gepul95/7RzfNDR5pH+ymsgEWo2M3X
         r/GLWyPFOWs+tuF4HdxBZlyO+aadFna3rEJGqnWVKRabFngPqsoaAE44fDtAjHS0fhiI
         rwfp0nTrN5jN3Ypx5SzR1hFHvVcWZBrnmOzcAQkVc9lMyC7Ic53q1T66hW0A6exIngEB
         J47Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689781358; x=1692373358;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D5fxkTnGgPpXTXRs+pAAOpKveu4sBAlnJ9TAdnEyBnc=;
        b=ZlURZYdJn6R01XSl6G5bKOntaxoqamXbSZGne5/BDKtesYSFFzMgmSN3LVDd2zRtiD
         m+qfRPgTUsoLk/V/o1ofEukLrN23yYXpWzcEllCsn1hpGoNQnPzPY3SXenj5e8oa8Vsa
         PNIti8vYq5KbeeacZKQuZPRvCCT6bysgmcAqnE6139Fz+284oaQNMy7Od3h/6MWwEKxf
         kIuotUIBTOn9E3hIae/b7TeoJ5qOEZfMQKwKhqxOPXHXDHxT4JNJsiLoECNElI8YDra6
         3cf0Ff8NQQTSEmvdxdueFqnVoXnWpVKyLxMj+U1Mv681er0lD6k4+0eX5t8s5dVvoNp0
         Q4CA==
X-Gm-Message-State: ABy/qLZujUQeSoM6Ba+p52bqtmOePCRx2tfSOh3k5NLjnegHKd4QYPaA
        qZiGCRHI6E4Lcr0WogM3ySKmm15M2+s=
X-Google-Smtp-Source: APBJJlEvkfa0YzxhGi1mapD7wqxseWSC9O4G8YQAxUPbYQNHgI3Bi13yP67pEEMYkzOX6AVkNVMrnrNQtRI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:230e:0:b0:c4d:4b23:337 with SMTP id
 j14-20020a25230e000000b00c4d4b230337mr25446ybj.11.1689781358655; Wed, 19 Jul
 2023 08:42:38 -0700 (PDT)
Date:   Wed, 19 Jul 2023 08:42:37 -0700
In-Reply-To: <20230719083332.4584-1-yan.y.zhao@intel.com>
Mime-Version: 1.0
References: <20230719083332.4584-1-yan.y.zhao@intel.com>
Message-ID: <ZLgEbalDPD38qHmm@google.com>
Subject: Re: [PATCH] KVM: allow mapping of compound tail pages for IO or
 PFNMAP mapping
From:   Sean Christopherson <seanjc@google.com>
To:     Yan Zhao <yan.y.zhao@intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, stevensd@chromium.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023, Yan Zhao wrote:
> Allow mapping of tail pages of compound pages for IO or PFNMAP mapping
> by trying and getting ref count of its head page.
> 
> For IO or PFNMAP mapping, sometimes it's backed by compound pages.
> KVM will just return error on mapping of tail pages of the compound pages,
> as ref count of the tail pages are always 0.
> 
> So, rather than check and add ref count of a tail page, check and add ref
> count of its folio (head page) to allow mapping of the compound tail pages.
> 
> This will not break the origial intention to disallow mapping of tail pages
> of non-compound higher order allocations as the folio of a non-compound
> tail page is the same as the page itself.
> 
> On the other side, put_page() has already converted page to folio before
> putting page ref.

Is there an actual use case for this?  It's not necessarily a strict requirement,
but it would be helpful to know if KVM supports this for a specific use case, or
just because it can.

Either way, this needs a selftest, KVM has had way too many bugs in this area.

> Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
> ---
>  virt/kvm/kvm_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 138292a86174..6f2b51ef20f7 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -2551,7 +2551,7 @@ static int kvm_try_get_pfn(kvm_pfn_t pfn)
>  	if (!page)
>  		return 1;
>  
> -	return get_page_unless_zero(page);
> +	return folio_try_get(page_folio(page));
>  }
>  
>  static int hva_to_pfn_remapped(struct vm_area_struct *vma,
> 
> base-commit: 24ff4c08e5bbdd7399d45f940f10fed030dfadda
> -- 
> 2.17.1
> 
