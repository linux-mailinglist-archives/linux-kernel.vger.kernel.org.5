Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D007875B91E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 22:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjGTU7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 16:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjGTU7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 16:59:44 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D5592D73
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 13:59:10 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id e9e14a558f8ab-3460770afe2so12445ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 13:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689886748; x=1690491548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DwZ5fXf8YtsT6+X1dt0HNi/DCNDf4xsCXWX4xprI2rw=;
        b=0tIvtBuLDGSc3J8LfcEzF3fWH2Po4Y6IfPf/u1bpSpAeHdEUr5qW/54AqEsUjRFE2r
         GHNTBEO6YRDgawyM4F7CGCHU616uETV86Qyr55dx/nol0vauyTUfSI+OgnwNKwpJCuU2
         C61nnSSa/B56qL4aiGipoLm8VrHLaQTmxwnCsYXLcuWzwUzAEaHFRdaHurql6Ihc2fio
         xu7pv+askxPkKnCnbvVuG7IR8WLLzGg+5+xiWR3kKTsXMLUgw8g/zJYwxp1in5kaj7xH
         4Lk9WHGa6k15Cif6z5/EZYZdhcakLgJxWhXFha2XbNwoUMKRfoeO9Zze+VnHMaCdVFGm
         pgew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689886748; x=1690491548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DwZ5fXf8YtsT6+X1dt0HNi/DCNDf4xsCXWX4xprI2rw=;
        b=KwjVkq5DEaTpCYhuFAqzV207FmFJDUU2r4MAw2Z6VvVvlc8gQXEnvFHsu1aJlg+gKs
         alyaZURkAzQafPsCwv8qclr6HXk+7XnipB4DSoyFx4a9qBPa8ZlhIixZYz0H+lOKX+L1
         0fwXJ1dwEFaGy/Q2542W2OId/6yBT5zQpsM0ohwIKFn/Yo9ZFBXYV0IGu18Hye1V8uqD
         CFJWqq6cv1pXHp5qnyWo9DAmXkudUfCgCw7KrFOiNBGcFgZKOaSW5PXuaZ4Bu2f4gQDE
         dvUz5QUUEV9isxN7VPQfRIfOqI76uRVWCKrnjw/EEvcnVfqFgWTV+6jdsgkoy1fn5jzq
         Sk/g==
X-Gm-Message-State: ABy/qLbQJlMtOGB2JJ1bzRTtZr4oDVpAikIwIhDAzHbloFGp3S82KxW1
        lA3QvVshGqRHavnMmYKTFLYYCO0pPlZlbZgm2cdx7Q==
X-Google-Smtp-Source: APBJJlEUJUtr2UHyBrENVzCQMi/MMfsg04kTIDa0DRLRTCfX8QZGwQ0UBo2yaVjKFMr8ia4N8qYiGUrFrP2cIEsi3JQ=
X-Received: by 2002:a05:6e02:12cf:b0:346:5a8b:545e with SMTP id
 i15-20020a056e0212cf00b003465a8b545emr71141ilm.14.1689886747689; Thu, 20 Jul
 2023 13:59:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230720194727.67022-1-kim.phillips@amd.com>
In-Reply-To: <20230720194727.67022-1-kim.phillips@amd.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Thu, 20 Jul 2023 13:58:56 -0700
Message-ID: <CALMp9eTBWWcApb50432zZEGg+PMCzUELaZvdkzYngNSrriimWA@mail.gmail.com>
Subject: Re: [PATCH] x86/cpu: Enable STIBP if Automatic IBRS is enabled
To:     Kim Phillips <kim.phillips@amd.com>
Cc:     x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Borislav Petkov <bp@alien8.de>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Juergen Gross <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tony Luck <tony.luck@intel.com>,
        Alexey Kardashevskiy <aik@amd.com>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 12:48=E2=80=AFPM Kim Phillips <kim.phillips@amd.com=
> wrote:
>
> Unlike Intel's Enhanced IBRS feature, AMD's Automatic IBRS does not
> provide protection to processes running at CPL3/user mode [1].
>
> Explicitly enable STIBP to protect against cross-thread CPL3
> branch target injections on systems with Automatic IBRS enabled.

Is there any performance penalty to enabling STIBP + AUTOIBRS, aside
from the lost sharing? Or does this just effectively tag the branch
prediction information with thread ID?
