Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 874BB7A2550
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 20:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236193AbjIORgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 13:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236367AbjIORf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 13:35:58 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC9C3AA2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 10:34:07 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-76ee895a3cbso156023985a.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 10:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694799246; x=1695404046; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B0w0jftHrCKOLI2sub5u/VeO/32jPwYn8o9L7rrDhT8=;
        b=C3YzfpQnPRTWEN7YloNioiOpM10fq1DthdYTNZZ0GNMh/ulir/zHT00Fg6QNfrT3sn
         /eswteh+WFfHjQx5ww8hPcY+XbjR/2OfxI4ytHJTwllf0OwqslAPmzN/Vh3YvYDnyXNO
         pE9bqrY3ausXGLEwyt+821845V6vigVY4JpkedDbFCNMLqxkFj2J8bKZJCPM0iUyMz88
         2mq2cOwuSLRkxpdV4SvPKTfkiu3LLdJ27PODERWkoax51UatP+4ZwmqpoC8tTSz0KyxN
         LgYqX8nXLJV3fMYLgcoCctPXktq3ngzuXP5RvDNvkF5R2jOWehV9ZjVvwGh/q3kIyyHb
         a5Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694799246; x=1695404046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B0w0jftHrCKOLI2sub5u/VeO/32jPwYn8o9L7rrDhT8=;
        b=fYVwI92Wy1vXtZM7oahtxMuBSZE3myl/jN579lTFHkXBOw1kJgcY2UJOFNG/Rvjo+V
         Q1grirJlQXEcxFLm2GYvirkd6kd9nz/JVYzZq1FBv47OsF6sQVdfaT6MHNhC+GQyquzW
         5tenhLjmGo2EilI5QMopQKpapanbpZoOJiPmay9BlV04q5zvfZbQf/Fs43hCPRP0dMUk
         GQWK94ZIw/ytT1ncmBP27zyfrihEAHL2w1l4wSAgBAh9jYHM9Xm6v9dK+VcQvRG/waoA
         DHvaJh87zROqEsZ9vISyoXC+etrDWBIgdMQV1qjXO2hCkTgmYsBoBF0ph+7pP2dKg5iN
         kaxQ==
X-Gm-Message-State: AOJu0Yz9PooZh9AjDscQTkHm4ZpoWelbgSmBuZ9AyiCCo1RpHKEX8g+p
        OzQfh1GUfpG4JrAbw4RQy+vLNIfnVYMeF2xADGWSCQ==
X-Google-Smtp-Source: AGHT+IEZ/WDxzF/O9gB4A+40qEo3bPuHJhEt/xOjx6Re1kZpnRTINetruNrbaRwq/pC5z/EudhBlcPg80BxynPtATiE=
X-Received: by 2002:a0c:e094:0:b0:653:5961:f005 with SMTP id
 l20-20020a0ce094000000b006535961f005mr2596649qvk.26.1694799246336; Fri, 15
 Sep 2023 10:34:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230915-bpf_collision-v2-1-027670d38bdf@google.com>
 <20230915171814.GA1721473@dev-arch.thelio-3990X> <CAADnVQJVL7yo5ZrBZ99xO-MWHHg8L-SuSJrCTf-eUd-k5UO75g@mail.gmail.com>
 <CAKwvOdkbqHFTvRNWG==0FjOPHgnA-zqE2Gn_nB4ys6qvKR2+HA@mail.gmail.com>
 <CAADnVQLfdMuxWVGKSF+COp8Q7DnKxYL0w5crN19vPkSd0Gh7mg@mail.gmail.com> <CAADnVQKJbTM-1n8YKvpC9XN7=tZuJi9mhnmmZSTVFOeBDv+SGA@mail.gmail.com>
In-Reply-To: <CAADnVQKJbTM-1n8YKvpC9XN7=tZuJi9mhnmmZSTVFOeBDv+SGA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 15 Sep 2023 10:33:54 -0700
Message-ID: <CAKwvOd=1X+2m2ZRUft9y+j8H0WBLWbM=VEiS+O0FfywnfpRYyA@mail.gmail.com>
Subject: Re: [PATCH v2] bpf: Fix BTF_ID symbol generation collision
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, stable <stable@vger.kernel.org>,
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Marcus Seyfarth <m.seyfarth@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 10:28=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> And please use [PATCH bpf v3] in subject, so that BPF CI can test it prop=
erly.

Testing `b4 prep --set-prefixes "PATCH bpf "`

--=20
Thanks,
~Nick Desaulniers
