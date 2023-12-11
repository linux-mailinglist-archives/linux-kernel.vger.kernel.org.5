Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED34C80CF41
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 16:15:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344097AbjLKPPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 10:15:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343966AbjLKPPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 10:15:31 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5256D8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 07:15:37 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1d0544c07c3so20771345ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 07:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702307737; x=1702912537; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sHC3g9oqHOhY9P31mD7uqpVY9YS1P4PdDX2KFPVf1zA=;
        b=zTx0JPwt4SRsknaKjoDO1urk8qulLjP0JDqakqXMFWyn9PACn41WEG8GmYpgxefQcV
         wkNCudUuENTXjAiD1WGWWXfUS9octwV8ky6nVwtd39QDV4W9ohGklJeh2CeT0djrLbwH
         Zl0PtDuFyt6EG76TB3z3W9hl1X7nngCuyIAgcxee7rm2ppXpwd3z08wdMSG+/guiUXQy
         0+lrCmQuF9aJiSb5iE4KMNGuOzxteEKjB91gDhGRf7FrlBdt18oq5TadtS481wBwchhh
         ARfCpVUupGv2+xDUbDsPNyQCsmkIg8+8/ysgjADfP5EFwR+RM1YgDAulxiLK/cWicp7O
         F0Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702307737; x=1702912537;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sHC3g9oqHOhY9P31mD7uqpVY9YS1P4PdDX2KFPVf1zA=;
        b=rlVLV+Tzy+hEJ64oDEtoiYpZ4cTMaf8gLsjtdi6e6Wk+46stBkp79pY4mcOBy+YN7m
         Cklvmmk/LYhEd64zHamI1/KQD1gaVdpM2s7JH2siPmUVi7IFSk3Nwewc492VIQQK+/jW
         SLNQD9LxiekD5TercEjrzslRUzStqR/9YvKGbTWJSFClhVcMidhqIxkejp4wNHXcpaGT
         It48WtfpsZV4hURjGCBzHRX58B4pUG+5W+PqNW+lskvjM6N6/QhMjAm9n0LLl/0pTqtN
         wTwweqxyo4T+yKTZJQHx5/0UnmPQ8XxylTHtTfdzdVejRRv+RVRPYpbiNbIYz/e5u7nw
         G6GA==
X-Gm-Message-State: AOJu0YxJdBRYbW7tRm5UbQYFu5c4QCkIjjwp2f5t1nERTLGQaNR+Gzd+
        ogckwsuzPvo3vcinsRgeRCUes/V4vsw=
X-Google-Smtp-Source: AGHT+IFaDU/4uc5wTg26iO18XssiMZIdzHGNiwzRHnUW+Lpwc7Q7YAIcBlHKULH+qKfK92wvWEAdD99Go6Q=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:ea0d:b0:1d0:e2b:24 with SMTP id
 s13-20020a170902ea0d00b001d00e2b0024mr36521plg.11.1702307736782; Mon, 11 Dec
 2023 07:15:36 -0800 (PST)
Date:   Mon, 11 Dec 2023 07:15:35 -0800
In-Reply-To: <20231211030518.2722714-1-guanjun@linux.alibaba.com>
Mime-Version: 1.0
References: <20231211030518.2722714-1-guanjun@linux.alibaba.com>
Message-ID: <ZXcnlzDhcy8_CizZ@google.com>
Subject: Re: [PATCH 1/1] KVM: Move kvm_gmem_migrate_folio inside CONFIG_MIGRATION
From:   Sean Christopherson <seanjc@google.com>
To:     "'Guanjun'" <guanjun@linux.alibaba.com>
Cc:     dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        kirill.shutemov@linux.intel.com, yu.c.zhang@linux.intel.com,
        tabba@google.com, xiaoyao.li@intel.com, pbonzini@redhat.com,
        x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.2 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_XBL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023, 'Guanjun' wrote:
> From: Guanjun <guanjun@linux.alibaba.com>
>=20
> 'kvm_gmem_migrate_folio' is only used when CONFIG_MIGRATION
> is defined, And it will triggers the compiler warning about
> 'kvm_gmem_migrate_folio' defined but not used when CONFIG_MIGRATION
> isn't defined.
>=20
> The compiler complained like that:
> arch/x86/kvm/../../../virt/kvm/guest_memfd.c:262:12: error: =E2=80=98kvm_=
gmem_migrate_folio=E2=80=99 defined but not used [-Werror=3Dunused-function=
]
>   262 | static int kvm_gmem_migrate_folio(struct address_space *mapping,
>       |            ^~~~~~~~~~~~~~~~~~~~~~

Already fixed, commit 80583d0cfd8f ("KVM: guest-memfd: fix unused-function =
warning")
in kvm/next.

https://lore.kernel.org/all/20231208184908.2298225-1-pbonzini@redhat.com
