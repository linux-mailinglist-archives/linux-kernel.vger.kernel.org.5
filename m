Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E01C076A5C9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 02:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbjHAAxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 20:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjHAAxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 20:53:44 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F7FEE;
        Mon, 31 Jul 2023 17:53:43 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4f95bf5c493so8277387e87.3;
        Mon, 31 Jul 2023 17:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690851221; x=1691456021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8mtR4vj5hk+cVwancO1pOd7gYaPqrE6PYim1ZZ5qoB4=;
        b=UzURXrGS2fFW0f6ohQuT9GZlY+yVaRvBgbWYsd51A1C0I7hsVFRrglL68uP1FYG7mA
         Qp9UMmO7/Ob/KYz3hSO7nQ9G9K6WuCpX5Bp+L5NPsEBTz+aQBdP1ySK5IDbjQes2ljPm
         iFtWRW4NuxyqNgk4QlTW4P5DTks4N+rtmCBDaiIXN4kr3MQtwHB2N73NTFl6Nt5pIubw
         qD9HLLwAQ95BlGQAV7wzb5ntBgDP9EThYs+PDuN2I3Mf2A7oUowoT45xMPFngEAxU5jN
         Z1fvRprsML+1mnBoPeLW1adlbyKr7k/DgfYgRMTH0QKq+8l0HvvesO1TDu+l/OM4LFTE
         h9Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690851221; x=1691456021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8mtR4vj5hk+cVwancO1pOd7gYaPqrE6PYim1ZZ5qoB4=;
        b=kZkj9tFavQpEhEaPxc5dN/yzUB7KelZSsjy/YcvWwDnFFMLbRyUvf7bKxtws1ISlbW
         Sk/bJmtC+Ho9WT0hrjjg0WnChZSQJXXMM1LW2LsJQJhUl8LxzY63UQ6vGyuAvqgVi5gq
         JUbX+tcHk5K3JaYNbQpX5q93M6nIKgj+Hx0KkNK4JJv7ZIXzj80ynbXY0131tuYXUEY5
         vN3p+AI8l6yRtHbVb6zGvFzG5Jgcv8EdnjvvKFB8foFKKhMnYD9prrkrSfDYB+0nS7bs
         bZyJAqlej6yDzdUwojmho1TzwwzB3Ef2bKMSROhTyzp7CPrxC6uTvhgwU39pZlzq1rXq
         +OaQ==
X-Gm-Message-State: ABy/qLa4S0J6CNNmGP3AB/6nkoL6Wwc4QGYsaYwKQF9bmuZ2M0ozeuD2
        QZDXETPxBMkEp/4J7MKbuPgG5BapNfIIrCv8aU8=
X-Google-Smtp-Source: APBJJlFUoy1em+75xA+nMvVQ2gfJ/UOulA9bmWfi6QU5i0bn/h1n4NEJrN9o00L7gYbQ5NXNTw4SYL9238dC/CyIOp0=
X-Received: by 2002:a2e:88d1:0:b0:2af:25cf:92ae with SMTP id
 a17-20020a2e88d1000000b002af25cf92aemr1176134ljk.22.1690851220847; Mon, 31
 Jul 2023 17:53:40 -0700 (PDT)
MIME-Version: 1.0
References: <b128b6489f0066db32c4772ae4aaee1480495929.1690840454.git.dxu@dxuuu.xyz>
In-Reply-To: <b128b6489f0066db32c4772ae4aaee1480495929.1690840454.git.dxu@dxuuu.xyz>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 31 Jul 2023 17:53:29 -0700
Message-ID: <CAADnVQJXC0votVOBOK7KynVEt9Z5JzMpD22GKS0RJkh0vdrK4A@mail.gmail.com>
Subject: Re: [PATCH] netfilter: bpf: Only define get_proto_defrag_hook() if necessary
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     Jozsef Kadlecsik <kadlec@netfilter.org>,
        "David S. Miller" <davem@davemloft.net>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Florian Westphal <fw@strlen.de>,
        netfilter-devel <netfilter-devel@vger.kernel.org>,
        coreteam@netfilter.org,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 2:55=E2=80=AFPM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> Before, we were getting this warning:
>
>   net/netfilter/nf_bpf_link.c:32:1: warning: 'get_proto_defrag_hook' defi=
ned but not used [-Wunused-function]
>
> Guard the definition with CONFIG_NF_DEFRAG_IPV[4|6].
>
> Fixes: 91721c2d02d3 ("netfilter: bpf: Support BPF_F_NETFILTER_IP_DEFRAG i=
n netfilter link")

since that commit is in bpf-next only
please use [PATCH bpf-next] in the future to make sure BPF CI can test it.

I've applied it after manual testing, but very much prefer
the automation to do it for me.
