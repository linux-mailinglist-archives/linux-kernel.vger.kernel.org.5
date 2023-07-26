Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 746B576364E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 14:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233722AbjGZM1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 08:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233491AbjGZM1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 08:27:17 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F29A91BCB
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 05:27:15 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b9a828c920so25559971fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 05:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1690374434; x=1690979234;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=UBWlekeadb6ll5cfrcuV68GqkFWW6y461yJLKCvTOag=;
        b=RQnH4EvQgjKLSCBcnN6qage1q8xr1RAq6uvGWIBvdllBtnnhgDXKzy1D837z4p2fXC
         ei3ZnUBc6aZFLHCOreaU1xSfrElRYNFOa+CVs5sibx1DPKBJZ/nigiCesxFewnuqs1z0
         27sNVpGt60SLq4SuQWUwWBTwKVfiKCbHTxuRI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690374434; x=1690979234;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UBWlekeadb6ll5cfrcuV68GqkFWW6y461yJLKCvTOag=;
        b=HOjiM+94GqAH9bTO7owYi6ZbVMW51uY35ONeZe3i9Zx/rB7Wlw+epePtpz7RgTpulM
         BtNT4P0t7aIg5zVxmPq2b5fxwhg/doxY+uGJCNs2cCxv63OBFxmiWgD63bwd10dRHD9p
         Jdf+VEfzToe/MGW0MymGbbzab+c9DUbybcW2jNgqGK0Im3V+KrhdvdSBBrGBH/i/mxNz
         PVmaO2qyH9QGXkSjuxRy3954nfB3psFKmO64i4EwApOdFs9sc/2jd4ykqyKGpYSq7myV
         AmlipuAoqaRRHRPdkj+Xncg4XXm5eKienAH3LE0QkUz6M/6CwmOKmf3RKFtsPiNLwLsu
         GaSw==
X-Gm-Message-State: ABy/qLajIZbsupahlPIf52oGURbQw1uW8lM8rE13QtTXnjCk9HR/mQS9
        W+Bs75h00feQPraVYUkpZcYAkg==
X-Google-Smtp-Source: APBJJlGe0BnzdEiexUengASClPGYfYEAD6/edtGkc8pSs2d5oo3Xa6dhiLC0n0m2SfnTK3KW/uVebA==
X-Received: by 2002:a2e:6e11:0:b0:2b9:aa4d:3728 with SMTP id j17-20020a2e6e11000000b002b9aa4d3728mr1294382ljc.29.1690374434227;
        Wed, 26 Jul 2023 05:27:14 -0700 (PDT)
Received: from cloudflare.com (79.184.136.135.ipv4.supernova.orange.pl. [79.184.136.135])
        by smtp.gmail.com with ESMTPSA id kd7-20020a17090798c700b00992a8a54f32sm9436706ejc.139.2023.07.26.05.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 05:27:13 -0700 (PDT)
References: <cover.1690332693.git.yan@cloudflare.com>
 <9c4896b109a39c3fa088844addaa1737a84bbbb5.1690332693.git.yan@cloudflare.com>
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
        linux-kselftest@vger.kernel.org, kernel-team@cloudflare.com,
        Jordan Griege <jgriege@cloudflare.com>,
        Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [PATCH v4 bpf 2/2] bpf: selftests: add lwt redirect regression
 test cases
Date:   Wed, 26 Jul 2023 14:26:57 +0200
In-reply-to: <9c4896b109a39c3fa088844addaa1737a84bbbb5.1690332693.git.yan@cloudflare.com>
Message-ID: <87edkuyi1r.fsf@cloudflare.com>
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

On Tue, Jul 25, 2023 at 06:09 PM -07, Yan Zhai wrote:
> Tests BPF redirect at the lwt xmit hook to ensure error handling are
> safe, i.e. won't panic the kernel.
>
> Tested-by: Jakub Sitnicki <jakub@cloudflare.com>
> Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Signed-off-by: Yan Zhai <yan@cloudflare.com>
> ---

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
