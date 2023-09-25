Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 642267ACF35
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 06:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbjIYEgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 00:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjIYEgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 00:36:21 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5536492
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 21:36:13 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-53368df6093so9677a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 21:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695616572; x=1696221372; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=utpCVSnKwmUjnI78nqFvLGOx8w1hMljEMO2FokBLE1I=;
        b=ybr6RM4CPXpwC9LRY3DBeFzRR8xUW4feAfauDPvuNqGD1XTEgTZJ6PysV1BcIGUkUW
         YpPV4a1uIofNpKwJGKIAfmzVso2/MAKtqv9JruN5CBBgnotdlr2lHuyMX1lB71iVsovG
         U/DSoEXgp/YIsyIPnhIsjH8h0SsTWPfJ/j5TEABPMYSUa9VXHeJObZ1U//c60mvSXaAg
         Uyzfyc0JGX5Df0HeGB5VSwYoZ02krp79yhq9F1wpQIqpxGAD/zrR+ITeyQmSJ8xE1pQY
         5wKjCRB2yRF4+Gi3Kaxg2BbJo8xffQCdHyjmzOzzwR9xP8YYllbzMcnr9xwnj4Azy0LH
         qYLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695616572; x=1696221372;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=utpCVSnKwmUjnI78nqFvLGOx8w1hMljEMO2FokBLE1I=;
        b=M95d5oeHaKoNUrStWgvRwIDEx95awZih7kSSXSVYpALeQbnx3jc3RQq2O30rrS4m0s
         29re5F8YirRN4Z+UXNQBe5PhmuBLJ0VFZWN9j1VPWX9p7sYQEhPL3PhRUtEckZ4thvel
         33bIhu0a9tfJA8TIS+Y/s0R7bbAsllv9hoskbx30tYlR1Rx0TN+DEJ9Amh1thqyrNWLg
         3XMbRg8low4IqIaFIPIQjmdrxa33Eo5FTQpXq4smNnsWGuqPubecS87mBvltZNV8SPl+
         NmZKdTyA0d0n/vtS3AU4OINwugjn1N3iT9vY2S0TPir/LZjp9mtnipxBbHvJqBSME/2s
         sFFw==
X-Gm-Message-State: AOJu0YyWp8CaQckb9y2Vk9VTuiwg+sXgPXIRB9FVhTftMG52enJkcetw
        J3FG37WAnQ9CZjCpNTA5exDW2g3NF2r5Ofc7ErZyug==
X-Google-Smtp-Source: AGHT+IHKR23zBujhctNddZ7OKF7KZBJFI4TepLmmMkO/RSku8CnURNUbVfdbS2tNLuBfQcREKCgWH/+nVYtyPrKezTY=
X-Received: by 2002:a50:9fc5:0:b0:525:573c:6444 with SMTP id
 c63-20020a509fc5000000b00525573c6444mr23731edf.1.1695616571593; Sun, 24 Sep
 2023 21:36:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230922210530.2045146-1-i.maximets@ovn.org>
In-Reply-To: <20230922210530.2045146-1-i.maximets@ovn.org>
From:   Eric Dumazet <edumazet@google.com>
Date:   Mon, 25 Sep 2023 06:35:58 +0200
Message-ID: <CANn89iJgeCvJbcapir8WkJv6nYop5CcfxgBrx3BoxEuwp0WA_w@mail.gmail.com>
Subject: Re: [PATCH net] ipv6: tcp: add a missing nf_reset_ct() in 3WHS handling
To:     Ilya Maximets <i.maximets@ovn.org>
Cc:     netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        David Ahern <dsahern@kernel.org>,
        Florian Westphal <fw@strlen.de>,
        Madhu Koriginja <madhu.koriginja@nxp.com>,
        Frode Nordahl <frode.nordahl@canonical.com>,
        Steffen Klassert <steffen.klassert@secunet.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 11:04=E2=80=AFPM Ilya Maximets <i.maximets@ovn.org>=
 wrote:
>
> Commit b0e214d21203 ("netfilter: keep conntrack reference until
> IPsecv6 policy checks are done") is a direct copy of the old
> commit b59c270104f0 ("[NETFILTER]: Keep conntrack reference until
> IPsec policy checks are done") but for IPv6.  However, it also
> copies a bug that this old commit had.  That is: when the third
> packet of 3WHS connection establishment contains payload, it is
> added into socket receive queue without the XFRM check and the
> drop of connection tracking context.
>
> That leads to nf_conntrack module being impossible to unload as
> it waits for all the conntrack references to be dropped while
> the packet release is deferred in per-cpu cache indefinitely, if
> not consumed by the application.
>
> The issue for IPv4 was fixed in commit 6f0012e35160 ("tcp: add a
> missing nf_reset_ct() in 3WHS handling") by adding a missing XFRM
> check and correctly dropping the conntrack context.  However, the
> issue was introduced to IPv6 code afterwards.  Fixing it the
> same way for IPv6 now.
>
> Fixes: b0e214d21203 ("netfilter: keep conntrack reference until IPsecv6 p=
olicy checks are done")
> Link: https://lore.kernel.org/netdev/d589a999-d4dd-2768-b2d5-89dec64a4a42=
@ovn.org/
> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
> ---

Nica catch, thanks a lot.

Reviewed-by: Eric Dumazet <edumazet@google.com>
