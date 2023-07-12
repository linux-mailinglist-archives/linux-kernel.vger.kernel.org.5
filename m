Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50B8E750ED9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 18:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232973AbjGLQmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 12:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232989AbjGLQmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 12:42:42 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F234C1FC9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 09:42:38 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-51f7fb9a944so2390670a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 09:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1689180157; x=1691772157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bW19SqP+fvSrSLXAkvlkbepiHCJjhpsp8L+HzcG/ses=;
        b=SgfwpiDWROfxicDuY5a0jDAkPQX29D8MNs1R5sSaSiMXu07hvOsRjGj7HzDMnoMyuK
         AnKOFz5cSrsss5qyVXdnVaFbkjetGCqVe5k4VNKvQqq8pjpuoKaOse60yM0U/X4YrTrA
         4S4A6px64gAkeCA3SC0KBg49c/q6SIcP8kiG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689180157; x=1691772157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bW19SqP+fvSrSLXAkvlkbepiHCJjhpsp8L+HzcG/ses=;
        b=jV+1IquEQU012km60ZMCC2B4tkd7vYk9q50+e+zoXUc3ugtV0djEsK9pw6eB4hqmBG
         c0lILHWHaW0nPISOpTFOeB4hmie0Eg1rXQnyYsv1FsyzVdUjJDK4lQA6UBWf12EqP6Af
         X4kZtm99n/k9YhCw6wZ6lQDyzjJ/iN9cJ/80xlYEGsd5FibN300/exi+2Yf4qzbbOQYd
         ORM91th8kyLYeFKB2xh6wsj4ihh+6VdIpoJjHyJB5ytDFz8EHzKqzExOlRi+uIYJHRjI
         BoVdt9F0t2cjf4JIXIsSooC5bE2CJk9bet4j88lOdO/bFe+9wiOiL0mPpmhQFzvmWtMn
         MuCw==
X-Gm-Message-State: ABy/qLZ6SXICLRt5slAvrFC6CNY2yknNZ8hBcQ6eCQWWe63kdOfKwNK4
        erirrXRVYeAs5xhOOd1zOa5sxMR31P27tMRNoqHX8g==
X-Google-Smtp-Source: APBJJlGzPGGBWdPkIfFETV6ee4h2sW7Me7h2Y4ydRiIsAB+e3U42ZwJVOhWcHj4/9NOqR7spBub/hKIpSmXEM8uEWfc=
X-Received: by 2002:aa7:d951:0:b0:51e:342c:25e0 with SMTP id
 l17-20020aa7d951000000b0051e342c25e0mr15386229eds.41.1689180157295; Wed, 12
 Jul 2023 09:42:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230711043453.64095-1-ivan@cloudflare.com> <20230711193612.22c9bc04@kernel.org>
In-Reply-To: <20230711193612.22c9bc04@kernel.org>
From:   Yan Zhai <yan@cloudflare.com>
Date:   Wed, 12 Jul 2023 11:42:26 -0500
Message-ID: <CAO3-PbrZHn1syvhb3V57oeXigE_roiHCbzYz5Mi4wiymogTg2A@mail.gmail.com>
Subject: Re: [RFC PATCH net-next] tcp: add a tracepoint for tcp_listen_queue_drop
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Ivan Babrou <ivan@cloudflare.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@cloudflare.com,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Paolo Abeni <pabeni@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        David Ahern <dsahern@kernel.org>
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

On Tue, Jul 11, 2023 at 9:36=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 10 Jul 2023 21:34:52 -0700 Ivan Babrou wrote:
> > There's already a way to count the overall numbers of queue overflows:
> >
> >     $ sudo netstat -s | grep 'listen queue'
> >     4 times the listen queue of a socket overflowed
> >
> > However, it's too coarse for monitoring and alerting when a user wants =
to
> > track errors per socket and route alerts to people responsible for thos=
e
> > sockets directly. For UDP there's udp_fail_queue_rcv_skb, which fills
> > a similar need for UDP sockets. This patch adds a TCP equivalent.
>
> Makes me want to revert your recent UDP tracepoint to be honest :(
> We can play whack a mole like this. You said that kfree_skb fires
> too often, why is that? Maybe it's an issue of someone using
> kfree_skb() when they should be using consume_skb() ?

Hi Jakub,

  The issue with kfree_skb is not that it fires too frequently (not in
the 6.x kernel now). Rather, it is unable to locate the socket info
when a SYN is dropped due to the accept queue being full. The sk is
stolen upon inet lookup, e.g. in tcp_v4_rcv. This makes it unable to
tell in kfree_skb which socket a SYN skb is targeting (when TPROXY or
socket lookup are used). A tracepoint with sk information will be more
useful to monitor accurately which service/socket is involved.

--
Yan
