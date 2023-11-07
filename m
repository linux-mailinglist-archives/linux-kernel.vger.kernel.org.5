Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3977E7E343F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 04:40:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233330AbjKGDk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 22:40:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbjKGDk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 22:40:26 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E24D47
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 19:40:23 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-54357417e81so6991a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 19:40:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699328422; x=1699933222; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lYCIndK7nTAWFMNojgp2tg2y2sSFZQckk0xx9RL2AOM=;
        b=3eSobFRETsHq9uZVd6u88PAq0GAttSvgXUyXYT88R564pFZos4u0wA7nIoPrZDVHFg
         6354A+u9njIrNIcTTtaSrOed98C4FiP1PYva+KMVHqkogAK0g/e/RQ8GjmOf88YZkQAI
         i9WUNytpAFlBFOCmHPIH84YkPfY/G7mgWue68mkaDi3JrV2IG1BrZgH9+uXiE1kw5nPw
         JcAxL7TcQy9xIJhJfV38wtQrMfs47xy5fzA+j/MDjaNJykuxQWfxw/8Wme4nQGWhqESt
         kpuNFRhMtMe51nqmrPUI9aQUfWBr6XePmwTLHr5NxNNyVu64LVXZT8YWLrnrRt2Uf1oF
         AWYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699328422; x=1699933222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lYCIndK7nTAWFMNojgp2tg2y2sSFZQckk0xx9RL2AOM=;
        b=QNWbiW/fGchefXh/B+CiqRjL5+V4wVlusPiEustPwa5YCe6rbLP3rgsLqSJeqCjau4
         wdKPRrZjaZB00CXdX3/TdTSJA1k9IRFMk1/44SACReRJV+xRsxYWW+OjUgbLvTKR35TR
         nccjfSYCgbzyA4AGzFOHAk6r4534DeYMvQr0n6nNMc1JiIKu6xwXq2QhvtVP9Eq4W7wq
         CZe8ha/N+nPWzW9nuxAoUomhFkpVhg63z3hMw6eAlkX3kxzMZSP4FawYJDyFcx4LUkgv
         Hk90In17yExRmy432+yizbU0ZXaooNCW6K7hPDKLO0Y21rqlK9EdJ0w3Wd+d5mGUar2W
         jJHg==
X-Gm-Message-State: AOJu0YxuY5rXAOx3ba0TyYLCn77pXAEUWQBQ5t6RD6HM1SH53xmOGdEZ
        XfTVS0bJMK7LWzWVWCJL36JljV+fGn+7vgUkVBDF2A==
X-Google-Smtp-Source: AGHT+IH0QiR6VsLI/3UP+6avx6qTbRgvfRUAwcSMLx2Ci0aCQ9197Fet5uwI9pffHELnV68wOz0D3/HXDmK/AGmf4BM=
X-Received: by 2002:a50:9eeb:0:b0:544:4762:608 with SMTP id
 a98-20020a509eeb000000b0054447620608mr76680edf.2.1699328421980; Mon, 06 Nov
 2023 19:40:21 -0800 (PST)
MIME-Version: 1.0
References: <20231107023444.3141-1-duminjie@vivo.com>
In-Reply-To: <20231107023444.3141-1-duminjie@vivo.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 7 Nov 2023 04:40:08 +0100
Message-ID: <CANn89iKGqObLBOx-ZMJbYOJ3OSETDestrcf6Yj5HON0Pbda9tA@mail.gmail.com>
Subject: Re: [PATCH v1] net/tcp: use kfree_sensitive() instend of kfree() in tcp_md5_twsk_free_rcu()
To:     Minjie Du <duminjie@vivo.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        David Ahern <dsahern@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "open list:NETWORKING [TCP]" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 7, 2023 at 3:35=E2=80=AFAM Minjie Du <duminjie@vivo.com> wrote:
>
> key might contain private information, so better use
> kfree_sensitive to free it.
> In tcp_md5_twsk_free_rcu() use kfree_sensitive().
>
> Signed-off-by: Minjie Du <duminjie@vivo.com>
> ---
>  net/ipv4/tcp_minisocks.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
> index a9807eeb311c..a7be78096783 100644
> --- a/net/ipv4/tcp_minisocks.c
> +++ b/net/ipv4/tcp_minisocks.c
> @@ -368,7 +368,7 @@ static void tcp_md5_twsk_free_rcu(struct rcu_head *he=
ad)
>         struct tcp_md5sig_key *key;
>
>         key =3D container_of(head, struct tcp_md5sig_key, rcu);
> -       kfree(key);
> +       kfree_sensitive(key);
>         static_branch_slow_dec_deferred(&tcp_md5_needed);
>         tcp_md5_release_sigpool();
>  }
> --
> 2.39.0
>



1) net-next is currently closed.

2) such patch could send a wrong signal (false sense of security with MD5)

3) You forgot tcp_time_wait_init(), tcp_md5_do_del(), tcp_md5_key_copy(),
    tcp_md5_do_add(), tcp_clear_md5_list().

More work is needed I am afraid, please wait until next week when
6-7-rc1 is tagged and net-next opens again.
