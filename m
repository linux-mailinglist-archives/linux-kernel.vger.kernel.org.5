Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF74A780FBF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 18:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378398AbjHRQB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 12:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378387AbjHRQBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 12:01:23 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE6F3AB6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 09:01:21 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-52256241c50so1361993a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 09:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1692374480; x=1692979280;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UPSQswlPfK/vg9tOIqV/BRlfCJnThjbbuWXP5dIGjVI=;
        b=eOS2hRxp7rH6eN6beKT9AhAtjWCJ5/IIE38A9lAemUFzSEY32ryQpxC0ZiY3D0m02E
         PPS/OljShi5fMfsQx+jB4P7wJ7+vIirfIJ9Ur8GkSfA3V4seJkEwxcZCb09xFsoKsUpA
         k9uSRlnUVjxiRqD9XaByBe/my5BTdzDGSUdko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692374480; x=1692979280;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UPSQswlPfK/vg9tOIqV/BRlfCJnThjbbuWXP5dIGjVI=;
        b=DDUzz/kYRa/+6jhphGFix6YLZTMZ4G3y40rcTHXTEeo3vZ5M04mDlTb6+pbiTtSIC3
         gUCjRh673/tMk+sjL/8A1UuPch/lXUkhM+iH32jNntZ3sJ/ZY+vViUgcXdMsnIZGxdnz
         zyQPQ4m+0gAGIuAtFuK8iImqNTH9rFKrRcQkWWpf3hjMWUBkwMqzWBfCs19V6T9NBphd
         phL+kQo8U2zQkP39+SO/KeWd3zsP9lJLSMVslLFnKyNkPVqc4LVAUZxdBVXwbH2h21XO
         23AhowcRu3rNS+Vov+ehhIMmURfkr9gd03qEDR15E13P2IKBGNeUsfZ35d/gfWflDstm
         HoDQ==
X-Gm-Message-State: AOJu0Yzaepmar+8CzlyE1GAYu7vEGo6ThSz2Rjk8JpVcbZIJr19qFPMA
        0fJP4xPEz4WMa2vEfOag01jwaexdZoreLGXamJDUKg==
X-Google-Smtp-Source: AGHT+IETP5rhdlK0N8SmshAKeFLK5w4xJiVCwhN2jNxLEpXbo/8uRFpY1Jr3KAeX1Do2SnfodkpwHGfpUEuEI5hzDks=
X-Received: by 2002:a05:6402:10c5:b0:523:4996:a4f9 with SMTP id
 p5-20020a05640210c500b005234996a4f9mr2776349edu.34.1692374479880; Fri, 18 Aug
 2023 09:01:19 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1692326837.git.yan@cloudflare.com> <10b3dff2-7be4-ab98-e4a5-968ebb93c25f@iogearbox.net>
In-Reply-To: <10b3dff2-7be4-ab98-e4a5-968ebb93c25f@iogearbox.net>
From:   Yan Zhai <yan@cloudflare.com>
Date:   Fri, 18 Aug 2023 11:01:09 -0500
Message-ID: <CAO3-PbqUczUxg42ECStsZnAybYKBY-hJePN=V-JbPvq-BS4cGA@mail.gmail.com>
Subject: Re: [PATCH v6 bpf 0/4] lwt: fix return values of BPF ops
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        David Ahern <dsahern@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        Thomas Graf <tgraf@suug.ch>,
        Jordan Griege <jgriege@cloudflare.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 9:55=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
>
> On 8/18/23 4:58 AM, Yan Zhai wrote:
> > lwt xmit hook does not expect positive return values in function
> > ip_finish_output2 and ip6_finish_output. However, BPF programs can
> > directly return positive statuses such like NET_XMIT_DROP, NET_RX_DROP,
> > and etc to the caller. Such return values would make the kernel continu=
e
> > processing already freed skbs and eventually panic.
> >
> > This set fixes the return values from BPF ops to unexpected continue
> > processing, checks strictly on the correct continue condition for
> > future proof. In addition, add missing selftests for BPF redirect
> > and reroute cases for BPF-CI.
> >
> > v5: https://lore.kernel.org/bpf/cover.1692153515.git.yan@cloudflare.com=
/
> > v4: https://lore.kernel.org/bpf/ZMD1sFTW8SFiex+x@debian.debian/T/
> > v3: https://lore.kernel.org/bpf/cover.1690255889.git.yan@cloudflare.com=
/
> > v2: https://lore.kernel.org/netdev/ZLdY6JkWRccunvu0@debian.debian/
> > v1: https://lore.kernel.org/bpf/ZLbYdpWC8zt9EJtq@debian.debian/
> >
> > changes since v5:
> >   * fix BPF-CI failures due to missing config and busybox ping issue
>
> Series looks good, thanks! Given we're fairly close to merge window and
> this has been broken for quite some time, I took this into bpf-next.
>
Thanks Daniel! Can you also queue this up for stable (or guide how I can do=
 it)?

Yan


> Thanks,
> Daniel
