Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55C6C761C05
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 16:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233250AbjGYOl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 10:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233188AbjGYOlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 10:41:23 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C6091
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 07:40:56 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-5222a38c0a0so3839928a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 07:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1690296051; x=1690900851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IThHZKgOu2CI5lLaW4+dohujcbudp1VuPGinJk5/sjg=;
        b=YycOgFH4zQyYEHbalkot5ZX4yBrIJRW7H0IyiNBqCjc4D8OlAEz+b4bIO59iZ49fRx
         zXsyax8B84PncxwgOuAD/wa5ujUzvNlDDELrEwV0QP2mM/De2ayWTLG3zzwXIzsbf26B
         t7ubBySeNUCXq+H8Dmcw5oqpgp3RwpGP1rIOw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690296051; x=1690900851;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IThHZKgOu2CI5lLaW4+dohujcbudp1VuPGinJk5/sjg=;
        b=UO2F79/DPP43NRg6OiL2eJY3dkzR40Dz8tFWR2jae9rTPHFFxLniivo+KbKw7y81Oy
         316TDihhWX17DUII2sf7or/S9B0GxjyRPQ9gzWBtzhSwhvuqy74ibRZYtJkVrdJwCqk0
         HIsjB3EcMwd00eUgi7eA/Ri5yarSWbzpVEp5HYglUn8taId4YJ/nfSDG6OqKShDIVVcg
         kANwIeyXXrV3Mb5RyKBoM8iq0YRlsqEdk+xxS49zLcZ55L1HE+IQmgvViMZud6BlRd1L
         2odSXDcaaloK6fmfVJTDzxvlarcoshCLgpDRZ2BfvBuKrvoq1yZu/Rf5eRNics27Ob5y
         hcgQ==
X-Gm-Message-State: ABy/qLaB0kdSkSJzlUYJq+9eX8pFOgcF+hVsiQBwtaxSE9WVe98yBRhE
        enSyGLMVVGFU2rZdi0eM2LTPNTiW3lnZWUhCinGC6g==
X-Google-Smtp-Source: APBJJlF68pzIjDwAzPGMKcrhOEyk9TWf/oRIMQEj1J4deHdSxGb7fnpo7ceaea8lfJeFMZmiLVLVP2G2Gj0o1TJx2JU=
X-Received: by 2002:a05:6402:10cb:b0:521:7ab6:b95d with SMTP id
 p11-20020a05640210cb00b005217ab6b95dmr11439677edu.29.1690296051014; Tue, 25
 Jul 2023 07:40:51 -0700 (PDT)
MIME-Version: 1.0
References: <cdbbc9df16044b568448ed9cd828d406f0851bfb.1690255889.git.yan@cloudflare.com>
 <9a5c27e4-a1a3-1fe5-a179-bfd0072e7c59@web.de>
In-Reply-To: <9a5c27e4-a1a3-1fe5-a179-bfd0072e7c59@web.de>
From:   Yan Zhai <yan@cloudflare.com>
Date:   Tue, 25 Jul 2023 09:40:39 -0500
Message-ID: <CAO3-PbokoLz8S8YhV_nNjq+Oq3P_SXqbj-TNJmrC56DV8KLb7Q@mail.gmail.com>
Subject: Re: [PATCH v3 bpf 1/2] bpf: fix skb_do_redirect return values
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     kernel-team@cloudflare.com, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Hao Luo <haoluo@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Mykola Lysenko <mykolal@fb.com>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Jordan Griege <jgriege@cloudflare.com>,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 12:11=E2=80=AFAM Markus Elfring <Markus.Elfring@web=
.de> wrote:
>
> >                                      =E2=80=A6 unexpected problems. Thi=
s change
> > converts the positive status code to proper error code.
>
> Please choose a corresponding imperative change suggestion.
>
> See also:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/process/submitting-patches.rst?h=3Dv6.5-rc3#n94
>
>
> Did you provide sufficient justification for a possible addition of the t=
ag =E2=80=9CFixes=E2=80=9D?
>
>
> =E2=80=A6
> > v2: code style change suggested by Stanislav Fomichev
> > ---
> >  net/core/filter.c | 12 +++++++++++-
> =E2=80=A6
>
> How do you think about to replace this marker by a line break?
>
> See also:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/process/submitting-patches.rst?h=3Dv6.5-rc3#n711
>
> Regards,
> Markus

Hi Markus,

   Thanks for the suggestions, those are what I could use more help with.
   Will address these in the next version.

Yan
