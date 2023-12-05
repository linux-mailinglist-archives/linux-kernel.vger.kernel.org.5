Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAEA2805C11
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:49:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbjLEQk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 11:40:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjLEQk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 11:40:56 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409F8194
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 08:41:02 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-54c79cca895so16301a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 08:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701794461; x=1702399261; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KYuKDd43mihty8rCENfkyLSyPMUXOf0NuMsF2cC2c1Q=;
        b=UvBsFx+8TxLRN0RT7keZP3llVew5qsUEKO2IcxTrmbBGHgPazqOgPYZ73lWjpNLbDM
         GdA0ZlV2LC1uJEECClukfXOhvPzeKE+XUaE5fqQw18NWPiWozyy9mHDVNHq1R+T4IE2+
         8+XMTjqvdZaPTB6CSxLPH67A2zZwOlAi90kU/Dj3VGPBa+xMfK0M+UIplPlZrRlAJrd6
         6BvDfus8SZ6t5wSPhVOtPrREELiRmmf0vBAqheH7V61ezEtAMv2fxiZ+KP/rZ8HqzSxs
         yPMSseIl8qeXVurlUGX+RkSy8YTEhAjdvwXrqQug4rSdd8kQ/OAHTy6y8j8pt1nR1eSl
         aepg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701794461; x=1702399261;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KYuKDd43mihty8rCENfkyLSyPMUXOf0NuMsF2cC2c1Q=;
        b=Cy1ZIyrm/AIjTe7MFzUaCfJQEmYGRKLIv6B0LHkkoQ61jMKe0JsMxnK1xOatclFIQ6
         yweAfwzhidK0S30Cy1SFfqtktd2neSNLPa8YubkxUl3W4JZAHvDGTzDu0WDSdDfjFGF6
         odDObhxaHcYO0/L1+8z6jm29P/rMzax41/0xRElSKb4eH+KGG3xUEATwNllfBOtknL5u
         72eJpqLwAhV71I38FsmUmFL+Ca97sXMViyyEblP3lREmCQuzxvJhgwWGMhK6ZnNuNSIC
         f0/NupY0OTHJ0czPTHv7Wpb+p6g/YDuYPjbtVNeHDYBko5diq1OL3mrwLtxXWuALK/7l
         KiIw==
X-Gm-Message-State: AOJu0Yzynh3flpvSlGnE8bCi8elGoG6j9Y+CY0Q672eXf6sQxIbzds1S
        V+RXCQU0FyXR4or0iYlU99QRr49MWiW2OW4v5BUGJg==
X-Google-Smtp-Source: AGHT+IHCjAZiAv17BXpDTX78OHWhWz6GbTngg3BDsw35myKX6WSmaekm/BpBH09gIC1zDSuc5zcO9cjzbIx7QMQwxOQ=
X-Received: by 2002:a05:6402:22c4:b0:54c:f4fd:3427 with SMTP id
 dm4-20020a05640222c400b0054cf4fd3427mr207622edb.7.1701794460589; Tue, 05 Dec
 2023 08:41:00 -0800 (PST)
MIME-Version: 1.0
From:   Jann Horn <jannh@google.com>
Date:   Tue, 5 Dec 2023 17:40:24 +0100
Message-ID: <CAG48ez0TfTAkaRWFCTb44x=TWP_sDZVx-5U2hvfQSFOhghNrCA@mail.gmail.com>
Subject: Is xt_owner's owner_mt() racy with sock_orphan()? [worse with new
 TYPESAFE_BY_RCU file lifetime?]
To:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        netfilter-devel <netfilter-devel@vger.kernel.org>,
        coreteam@netfilter.org
Cc:     Christian Brauner <brauner@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Network Development <netdev@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I think this code is racy, but testing that seems like a pain...

owner_mt() in xt_owner runs in context of a NF_INET_LOCAL_OUT or
NF_INET_POST_ROUTING hook. It first checks that sk->sk_socket is
non-NULL, then checks that sk->sk_socket->file is non-NULL, then
accesses the ->f_cred of that file.

I don't see anything that protects this against a concurrent
sock_orphan(), which NULLs out the sk->sk_socket pointer, if we're in
the context of a TCP retransmit or something like that. So I think we
can theoretically have a NULL deref, though the compiler will probably
optimize it away by merging the two loads of sk->sk_socket:

static bool
owner_mt(const struct sk_buff *skb, struct xt_action_param *par)
{
        [...]
        const struct file *filp;
        struct sock *sk = skb_to_full_sk(skb);
        [...]

        if (!sk || !sk->sk_socket || !net_eq(net, sock_net(sk)))
                return (info->match ^ info->invert) == 0;
        else if (info->match & info->invert & XT_OWNER_SOCKET)
                [...]

        // concurrent sock_orphan() while we're here

        // null deref on second access to sk->sk_socket
        filp = sk->sk_socket->file;
        if (filp == NULL)
                [...]
        [...]
}

(Sidenote: I guess this also means xt_owner will treat a sock as
having no owner as soon as it is orphaned? Which probably means that
when a TCP socket enters linger state because it is close()d with data
remaining in the output buffer, the remaining packets will be treated
differently by netfilter?)

I also think we have no guarantee here that the socket's ->file won't
go away due to a concurrent __sock_release(), which could cause us to
continue reading file credentials out of a file whose refcount has
already dropped to zero?

That was probably working sorta okay-ish in practice until now because
files had RCU lifetime, "struct cred" also normally has RCU lifetime,
and nf_hook() runs in an RCU read-side critical section; but now that
"struct file" uses SLAB_TYPESAFE_BY_RCU, I think we can theoretically
race such that the "struct file" could have been freed and reallocated
in the meantime, causing us to see an entirely unrelated "struct file"
and look at creds that are unrelated to the context from which the
packet was sent.

But again, I haven't actually tested this yet, I might be getting it wrong.
