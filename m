Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2354276A7B3
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 05:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbjHAD65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 23:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjHAD6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 23:58:55 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C23173E
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 20:58:52 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-40c72caec5cso168411cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 20:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690862332; x=1691467132;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Yt1rvrVZ9IgNOuFXI4E5A8hfrrursvkzMTiizAX7RTI=;
        b=kpR7t6p3BZDaMKDyaiDLhpYZtWAg2ZvXlLjRmHEBXesGbd4MKPIamZot14ORDSZhMj
         +GMCWc+mS7rswLiWUUwru5haqzf/323ztXgVGe5N1B/PyhFuJ+m69r8nQP1ZjW2SxcWg
         pYXCq+1dqkzg6PJUWbEmhijkJ2fCJyN6PaKuwfxw1y/XJCvraWuRboBfrwYGyzgUc+z6
         wrBeGyCgGDzympf3cEF46e9ShkrIWrwQ9HDja6wrcog5T6Mm1ssnshR6d5I62+LU4meW
         Hjncm/0TD/TmMy5bDqrZJ022GpQ7DFFaG8xH9GQanY9E5HqzARJw+ZmCwiZbh64wm1Kt
         /VKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690862332; x=1691467132;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yt1rvrVZ9IgNOuFXI4E5A8hfrrursvkzMTiizAX7RTI=;
        b=epJbTqHOp3YaBv5dZJIqenLFun8wQGEqh4kxMTRQlKE1r4b/KPEeXR5BmQdfvkWEMb
         4rHSaMJrCTqbklR+RAxHTpA/M8lOQKAHQZ7VcB4zoOQy5aPbwP1SCbQz0szZ73jvYmtx
         jeRoaYOAy1yXVUqXhLp/aU5cDc1UdS5fl/4F85B2+mq9liE39/Habk8Wfcu8OYKY5GnU
         56ccW+3yiQoxdAq51IYlw7hP4tMVlXvddWAOfjNu1OACkqRpLgceKjLn3BbliifwLEEx
         yXgqWnLfFnkg0JF/+D81fIjczxSf/1QBgmJoi7o+F+ETvLZJab9P9Lu354vXvUms5s1c
         6IUA==
X-Gm-Message-State: ABy/qLZV+a2xNDy+lhUJhOClh6kuO7Iayhox+igyf4mMAo0VA7cYWSS3
        DWZU/MthubMu2CguICeTXLry3ACB8+bgS82EMoruvYyeE9HPHYNVjv4=
X-Google-Smtp-Source: APBJJlHqGvXZmER5NC2t1o066u6go7Fkz0XFS7dI5jjeM/lF+a8uDam1MAfx9GgJ/ZtF98XID5Ny93yCraRA44c7CQ4=
X-Received: by 2002:ac8:5748:0:b0:403:96e3:4745 with SMTP id
 8-20020ac85748000000b0040396e34745mr672755qtx.20.1690862331785; Mon, 31 Jul
 2023 20:58:51 -0700 (PDT)
MIME-Version: 1.0
References: <a5856fa1ebe3879de91a8f6298b6bbd901c61881.1690578565.git.thomas.lendacky@amd.com>
In-Reply-To: <a5856fa1ebe3879de91a8f6298b6bbd901c61881.1690578565.git.thomas.lendacky@amd.com>
From:   Dionna Amalie Glaze <dionnaglaze@google.com>
Date:   Mon, 31 Jul 2023 20:58:40 -0700
Message-ID: <CAAH4kHb-7vjsKYQ-JyHZDyKzX857iN+5K1yY9AC9O2yHyBM35w@mail.gmail.com>
Subject: Re: [PATCH] x86/sev: Fix SNP CPUID requests to the hypervisor
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michael Roth <michael.roth@amd.com>,
        Ashish Kalra <ashish.kalra@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Fixes: ee0bfa08a345 ("x86/compressed/64: Add support for SEV-SNP CPUID table in #VC handlers")
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>

Nice catch.

> +static int __sev_cpuid_hv_ghcb(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct cpuid_leaf *leaf)
> +{
> +       u32 cr4 = native_read_cr4();
> +       int ret;
> +
> +       ghcb_set_rax(ghcb, leaf->fn);
> +       ghcb_set_rcx(ghcb, leaf->subfn);
> +
> +       if (cr4 & X86_CR4_OSXSAVE)
> +               /* Safe to read xcr0 */
> +               ghcb_set_xcr0(ghcb, xgetbv(XCR_XFEATURE_ENABLED_MASK));
> +       else
> +               /* xgetbv will cause #GP - use reset value for xcr0 */
> +               ghcb_set_xcr0(ghcb, 1);
> +

Everything looks good except I'm confused by this last comment. I
thought xgetbv would #UD if OSXSAVE isn't set in cr4. Is that what
happens after you set it to 1 as some kind of workaround?

....oh I think I do remember hitting this weird technicality when
setting up CPUID support. I think it'd be helpful to document a little
bit more why the ghcb's value is xcr0 is relevant at all when cr4's
OSXSAVE bit is 0 though.


-- 
-Dionna Glaze, PhD (she/her)
