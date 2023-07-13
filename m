Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB55751668
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 04:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233705AbjGMCns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 22:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233686AbjGMCnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 22:43:46 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A373172C
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 19:43:45 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4fb41682472so354054e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 19:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1689216223; x=1691808223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZZbsg7ZRrrqBObmRQBVORF/Ql/2GsFEmO5ssSII3RHc=;
        b=RUpLiH+NZ5kW+xt5BZgJW/XlZMe5ZDORblGpIddVoU/ndInI3cAp4cXSNnFk99OF+M
         FX+dvM2WvqMDl+DahMoBnRwn2luRoxsY52IcPWv4pRbOUmvg+hZUnq55Z0F2zjJXjzac
         8DOMUMrGDiHr9oQv5jaCcNZUGSCeUq/RTEN5I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689216223; x=1691808223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZZbsg7ZRrrqBObmRQBVORF/Ql/2GsFEmO5ssSII3RHc=;
        b=Ym17rlYrS2TyHQlqSZQTvaiEvdja8BTl8cLy/C4XZCc0BS5/I4T8OmYHaH1k81vpPS
         6oNm85mqrzE3DLSwvShqTbK7O8UDOb8eE9bL8aCbd4++rR3CSyx2MdCX5J1fanGi9vNk
         U/1bCUpKsB/SuiJRttNOOpoh2VOisyYVGmH1JKh2t2P7QGQhFZLQhc8mxAoBFyCt/T31
         yRVj80NJLb+5aUgScYI2kL1kASGDk3U9qXJY0jovtbVU2z7yEdcXhDqobjy4O8KePWlN
         SakhBJOkVfb8rZKtNta9YLdXQsY+20UxnL/ryvBxysVY0JX6gz6oPqvGALSrK8GIActi
         foEg==
X-Gm-Message-State: ABy/qLanwDxdXBTgWMYyOjLj5UrSc+u96t10p1sz1qxh3J/budUXxnDL
        2pCWIg3jwal8qD80yRglORn/ywmPUpxu11bpD28ZwA==
X-Google-Smtp-Source: APBJJlHzJTiOMDWKfml2hr3byYUAUNS3gAF4xGhcgSFBniRgKe3QbH2vHjtMZUo0Oakz6OyMyNC4x4zguuMI5FrLksQ=
X-Received: by 2002:a19:700e:0:b0:4fa:e7e5:66e0 with SMTP id
 h14-20020a19700e000000b004fae7e566e0mr42962lfc.48.1689216223539; Wed, 12 Jul
 2023 19:43:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230711043453.64095-1-ivan@cloudflare.com> <20230711193612.22c9bc04@kernel.org>
 <CAO3-PbrZHn1syvhb3V57oeXigE_roiHCbzYz5Mi4wiymogTg2A@mail.gmail.com> <20230712104210.3b86b779@kernel.org>
In-Reply-To: <20230712104210.3b86b779@kernel.org>
From:   Yan Zhai <yan@cloudflare.com>
Date:   Wed, 12 Jul 2023 21:43:32 -0500
Message-ID: <CAO3-PbqtdX+xioiQfOCxVovKVYUgXkrmsfw+1wTYoJiAq=2=ng@mail.gmail.com>
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 12:42=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Wed, 12 Jul 2023 11:42:26 -0500 Yan Zhai wrote:
> >   The issue with kfree_skb is not that it fires too frequently (not in
> > the 6.x kernel now). Rather, it is unable to locate the socket info
> > when a SYN is dropped due to the accept queue being full. The sk is
> > stolen upon inet lookup, e.g. in tcp_v4_rcv. This makes it unable to
> > tell in kfree_skb which socket a SYN skb is targeting (when TPROXY or
> > socket lookup are used). A tracepoint with sk information will be more
> > useful to monitor accurately which service/socket is involved.
>
> No doubt that kfree_skb isn't going to solve all our needs, but I'd
> really like you to clean up the unnecessary callers on your systems
> first, before adding further tracepoints. That way we'll have a clear
> picture of which points can be solved by kfree_skb and where we need
> further work.

Those are not unnecessary calls, e.g. a lot of those kfree_skb come
from iptables drops, tcp validation, ttl expires, etc. On a moderately
loaded server, it is called at a rate of ~10k/sec, which isn't
terribly awful given that we absorb millions of attack packets at each
data center. We used to have many consume skb noises at this trace
point with older versions of kernels, but those have gone ever since
the better separation between consume and drop.

That said, accessing sk information is still the critical piece to
address our use case. Is there any other possible way that we can get
this information at the accept queue overflow time?

--
Yan
