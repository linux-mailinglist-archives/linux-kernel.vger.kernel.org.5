Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D63D57619B1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 15:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjGYNUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 09:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjGYNU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 09:20:28 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B857D1BC5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 06:20:01 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-99364ae9596so944982766b.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 06:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1690291200; x=1690896000;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=/AN1YHLUYuWO5atontjFpAIVd9Zt4nVgfXmFEwZMLzU=;
        b=d00/nGb5if1lMP2Y7kVokEl1WMecpTb066F1Bn0/tUZ6XRXXfatJXIV2ekVmu1BdyI
         RwTbNk3xgFE+kMdJDUUJIvzRmY8BGR9ujCiLf7X9H6fQvU6G3L0a1sHgdCQzMZmzf3Y0
         Pk2AgMMB3kLb7+PHb+AH9a9SMpJK/LMcGynzU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690291200; x=1690896000;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/AN1YHLUYuWO5atontjFpAIVd9Zt4nVgfXmFEwZMLzU=;
        b=bTdWj63Ni6G6qZpxy7/euLSepKXF1PxySYMFyVVarP+XvvoJM+wXHIi6NkNtbHh6Q3
         3Zcix9fb3F23hXbsS38gMvO00/sOEg+kBI8gLV0kzbdXU5CWacRxyt6TddX1LyVXBG45
         /qeh+aHVv/S1jCWWZkZdOIG9CicPio0aBv4I0HM4flb8ZJJwvTyDs3iU6wMuKKMEVhh4
         NgPdbXqrxzDOz/3kS/J1yLjHeLcBanRZk2wyMuuRl/eRttI9fUNqe9qq/swSG7mwH+7w
         rbbfzqO7Fgmzr2J/fnwlamAu2y6Vnc7zjXtMY2oGpUJSAfmcKBAHDPm6ztLsEAp59oBa
         E+GA==
X-Gm-Message-State: ABy/qLZc4wplwjaQoZ0ir/2Ek+rEpBy1YU4bddm57n+N7d6iJtQlDIVH
        bNizO6W/8BI18ox0dj/H5kIjKQ==
X-Google-Smtp-Source: APBJJlExKo+MISIorbKqmmXFqOZx+fFkcFbM3faOMvOhcozXsTgxolJpBU64M1xQar434N5lKWU4nw==
X-Received: by 2002:a17:906:8a67:b0:994:673:8b00 with SMTP id hy7-20020a1709068a6700b0099406738b00mr11175043ejc.12.1690291200175;
        Tue, 25 Jul 2023 06:20:00 -0700 (PDT)
Received: from cloudflare.com (79.184.214.102.ipv4.supernova.orange.pl. [79.184.214.102])
        by smtp.gmail.com with ESMTPSA id b19-20020a170906039300b0099364d9f0e2sm8239882eja.98.2023.07.25.06.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 06:19:59 -0700 (PDT)
References: <cover.1690255889.git.yan@cloudflare.com>
 <25c13cb89412b120616f4e31a31c3108e45bc6af.1690255889.git.yan@cloudflare.com>
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
Subject: Re: [PATCH v3 bpf 2/2] selftests/bpf: test lwt redirect error handling
Date:   Tue, 25 Jul 2023 15:18:58 +0200
In-reply-to: <25c13cb89412b120616f4e31a31c3108e45bc6af.1690255889.git.yan@cloudflare.com>
Message-ID: <87r0owxh4x.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 09:14 PM -07, Yan Zhai wrote:
> Tests BPF redirect at the lwt xmit hook to ensure error handling are
> safe, i.e. won't panic the kernel.
>
> Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Signed-off-by: Yan Zhai <yan@cloudflare.com>
> ---
>  tools/testing/selftests/bpf/Makefile          |   1 +
>  .../selftests/bpf/progs/test_lwt_redirect.c   |  67 +++++++
>  .../selftests/bpf/test_lwt_redirect.sh        | 165 ++++++++++++++++++
>  3 files changed, 233 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/progs/test_lwt_redirect.c
>  create mode 100755 tools/testing/selftests/bpf/test_lwt_redirect.sh
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index 538df8fb8c42..e3a24d053793 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -66,6 +66,7 @@ TEST_PROGS := test_kmod.sh \
>  	test_xdp_vlan_mode_generic.sh \
>  	test_xdp_vlan_mode_native.sh \
>  	test_lwt_ip_encap.sh \
> +	test_lwt_redirect.sh \
>  	test_tcp_check_syncookie.sh \
>  	test_tc_tunnel.sh \
>  	test_tc_edt.sh \
> diff --git a/tools/testing/selftests/bpf/progs/test_lwt_redirect.c b/tools/testing/selftests/bpf/progs/test_lwt_redirect.c
> new file mode 100644
> index 000000000000..622c6b1e7128
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_lwt_redirect.c
> @@ -0,0 +1,67 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +
> +#define ETH_LEN 14

Nit: We have ETH_HLEN in bpf_tracing_net.h defined.

[...]
