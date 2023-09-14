Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACA327A0BF5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 19:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240083AbjINRrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 13:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238757AbjINRrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 13:47:06 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E921FF6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 10:47:02 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-274939681b5so75028a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 10:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694713621; x=1695318421; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J3P8BZDl5uXhLdi7mCkkSTzXwn0E2WaaQT91SGIepdI=;
        b=T86moxrA6ZxDzK1VuFftiohtlOQoe2n31VCssoVqGtI/u1UR606gImuByBxFRgr+Tj
         FLs58GtffSYI8AlYpboCkmyF9ECAkcvR6iNnnLZ2jznEKe1w7bpJqUHWC1mappSoV6NQ
         ty2w7DtI9/cSYFgIhQH47mmOKJCqat1jpvXxG88iwvCFyNe+Jscb/wcowDag1vWWX2cu
         lXCPIhXsNl/6opjs/9mRh8/46i0kmdhXjaHQzWTQ7w00KY92itReDvWE8utAeFF5sfAS
         MmbEz6iWF3RczB1D//FBJdO5cEvvHALLBmt0j48kuxXaTU9Suc0sIJrfrH/WPhKL5hhI
         uF1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694713621; x=1695318421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J3P8BZDl5uXhLdi7mCkkSTzXwn0E2WaaQT91SGIepdI=;
        b=EqQlrQSwG6WF18k+AjmCmhDVv+iSvphoS+pBcMM+XT+TzAvCfXkVNbe1xlDsPp0wxP
         fkks3jgxAeo41St6cRppu/ATH45gR8Holu3/2TSiZss67o6jOWCN56CQfgHg2o/rTts1
         bGu1xJfTovUHA7o8uCntA6fS+rhxVqKtcSy+KCx/aT2kAyW0fPsV6t8rN2QE92Ub6B9d
         CrcU2thktVbByqzHLT2qIt/R4MNVyWxhf8cU7cdr/HUKDFf27FBrKoWDtJgySecFuyzV
         auwxjMHRVTzIqSzYuy2u5gZpgpdUQ+FgU6nu/gRapP4py1IRHQOfBL+fatpgNWlP6XfG
         XLwQ==
X-Gm-Message-State: AOJu0YxW/uzJtQ4t3PA6EhagbwhMN/OidR67j7TnC3IavQn8EaSeJCSg
        jhvMNKUaZHNIEPL7GTJrbj4mvm03OfD30lg2+LE=
X-Google-Smtp-Source: AGHT+IGPp/DAIdRihdOyWbn7a+/dY0934SRhirtwacdlLAZjTTKnNrCTNn7WivJjY3pfaJKBk1H17/lGSRWMortnyyU=
X-Received: by 2002:a17:90b:1d87:b0:268:5bed:708e with SMTP id
 pf7-20020a17090b1d8700b002685bed708emr5548210pjb.24.1694713621533; Thu, 14
 Sep 2023 10:47:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230914080833.50026-1-haibo.li@mediatek.com>
In-Reply-To: <20230914080833.50026-1-haibo.li@mediatek.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Thu, 14 Sep 2023 19:46:50 +0200
Message-ID: <CA+fCnZeHNoccoiUy11pmCG9LWHAxyB+6C7+GTc3ixj8iBnbi0w@mail.gmail.com>
Subject: Re: [PATCH] kasan:fix access invalid shadow address when input is illegal
To:     Haibo Li <haibo.li@mediatek.com>
Cc:     linux-kernel@vger.kernel.org, xiaoming.yu@mediatek.com,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 10:08=E2=80=AFAM 'Haibo Li' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
>
> when the input address is illegal,the corresponding shadow address
> from kasan_mem_to_shadow may have no mapping in mmu table.
> Access such shadow address causes kernel oops.
> Here is a sample about oops on arm64(VA 39bit) with KASAN_SW_TAGS on:
>
> [ffffffb80aaaaaaa] pgd=3D000000005d3ce003, p4d=3D000000005d3ce003,
>     pud=3D000000005d3ce003, pmd=3D0000000000000000
> Internal error: Oops: 0000000096000006 [#1] PREEMPT SMP
> Modules linked in:
> CPU: 3 PID: 100 Comm: sh Not tainted 6.6.0-rc1-dirty #43
> Hardware name: linux,dummy-virt (DT)
> pstate: 80000005 (Nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
> pc : __hwasan_load8_noabort+0x5c/0x90
> lr : do_ib_ob+0xf4/0x110
> ffffffb80aaaaaaa is the shadow address for efffff80aaaaaaaa.
> The problem is reading invalid shadow in kasan_check_range.
>
> The generic kasan also has similar oops.
>
> To fix it,check shadow address by reading it with no fault.
>
> After this patch,KASAN is able to report invalid memory access
> for this case.

Hi Haibo,

I thought this should be covered by the kasan_non_canonical_hook
handler, which prints some additional information about how the GPF
could be caused by accessing shadow memory.

Does it not work in your case? It might be that we need to add
kasan_non_canonical_hook to some other arm64 internal fault handler
functions then.

Thanks!
