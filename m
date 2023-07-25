Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8E47619B8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 15:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjGYNVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 09:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjGYNVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 09:21:05 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C15D1FF6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 06:20:58 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-98e39784a85so1396553366b.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 06:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1690291257; x=1690896057;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=Re/z3nObvtjSOuqc2XvuozwPKWBuW5694/qbzOrvreM=;
        b=avOtOUW+Cj7SR0Q9peI/1FD6B3M1N5Hr+fpAclHpm7L8hzrxsUoV1RTF4m5DA/Dq6a
         YJrqZXEXN7nHdcOkn45MQip/pZDwfl59O6sLsgxXu550emMbxOb105bU8WmyRsMyqKeR
         DiZpVUvn/srF5U00xeHXv3iBuwmiPGmWrnWb4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690291257; x=1690896057;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Re/z3nObvtjSOuqc2XvuozwPKWBuW5694/qbzOrvreM=;
        b=i+jWFrgIoE8SuLKiVmfDuKFEssPFpRXXD9D7RrAqouR/6hWM/xkRB+QLLcNxSNTNjN
         GNjE52gcpfjRmmvPdY6gNiCoPtp3Klv7Ec5FFXcrKVGYNEDYv5eIs9MzY/bVzuD396zL
         NBkWUbsTmG7EAZulVK33A8Fm5NSj82wH3pDjbPFqBOB/y6Dv3UORrx7Fwlzc9KvuLQC2
         gYGLPxqt1kJOSB/EVEqKcw2uT7LpY3BOc/cQFFUW7+qIQcvfqBUbk+yAVJoF0KyCRgRe
         651pU0EzFqebZSTwxE2XlC4r3cv5DoZoRaPeEWa+sCWopbBcms2N/1yPJ1ixkt85+jrY
         Ilfg==
X-Gm-Message-State: ABy/qLa5G8uZpBsX7RHll61IlnlazrrQ2Hc2tv2ax1zr6Jn5Nd3vB7xF
        hMffznD5RK3JhQrjAJv1UCF1ww==
X-Google-Smtp-Source: APBJJlH+qEf1EkwtzcMEpjPEgMFdKkhYpww/2/CnlXcjZ72gg/UoQUeciPbGIm5RrLkuaIIGMvU/lQ==
X-Received: by 2002:a17:907:2c4f:b0:993:d632:2c3 with SMTP id hf15-20020a1709072c4f00b00993d63202c3mr2315057ejc.21.1690291256910;
        Tue, 25 Jul 2023 06:20:56 -0700 (PDT)
Received: from cloudflare.com (79.184.214.102.ipv4.supernova.orange.pl. [79.184.214.102])
        by smtp.gmail.com with ESMTPSA id j1-20020a170906254100b00992076f4a01sm8117208ejb.190.2023.07.25.06.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 06:20:56 -0700 (PDT)
References: <cover.1690255889.git.yan@cloudflare.com>
User-agent: mu4e 1.6.10; emacs 28.2
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Yan Zhai <yan@cloudflare.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Jordan Griege <jgriege@cloudflare.com>,
        kernel-team@cloudflare.com
Subject: Re: [PATCH v3 bpf 0/2] bpf: return proper error codes for lwt redirect
Date:   Tue, 25 Jul 2023 15:20:06 +0200
In-reply-to: <cover.1690255889.git.yan@cloudflare.com>
Message-ID: <87mszkxh3c.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 09:12 PM -07, Yan Zhai wrote:
> lwt xmit hook does not expect positive return values in function
> ip_finish_output2 and ip6_finish_output2. However, BPF redirect programs
> can return positive values such like NET_XMIT_DROP, NET_RX_DROP, and etc
> as errors. Such return values can panic the kernel unexpectedly:
>
> https://gist.github.com/zhaiyan920/8fbac245b261fe316a7ef04c9b1eba48
>
> This patch fixes the return values from BPF redirect, so the error
> handling would be consistent at xmit hook. It also adds a few test cases
> to prevent future regressions.
>
> v2: https://lore.kernel.org/netdev/ZLdY6JkWRccunvu0@debian.debian/ 
> v1: https://lore.kernel.org/bpf/ZLbYdpWC8zt9EJtq@debian.debian/
>
> changes since v2:
>   * subject name changed
>   * also covered redirect to ingress case
>   * added selftests
>
> changes since v1:
>   * minor code style changes
>
> Yan Zhai (2):
>   bpf: fix skb_do_redirect return values
>   bpf: selftests: add lwt redirect regression test cases
>
>  net/core/filter.c                             |  12 +-
>  tools/testing/selftests/bpf/Makefile          |   1 +
>  .../selftests/bpf/progs/test_lwt_redirect.c   |  67 +++++++
>  .../selftests/bpf/test_lwt_redirect.sh        | 165 ++++++++++++++++++
>  4 files changed, 244 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/bpf/progs/test_lwt_redirect.c
>  create mode 100755 tools/testing/selftests/bpf/test_lwt_redirect.sh

For the series:

Tested-by: Jakub Sitnicki <jakub@cloudflare.com>
