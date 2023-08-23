Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 793D0785D72
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 18:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237147AbjHWQrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 12:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbjHWQrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 12:47:15 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAFB711F;
        Wed, 23 Aug 2023 09:47:12 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3a8614fe8c4so2047492b6e.1;
        Wed, 23 Aug 2023 09:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692809232; x=1693414032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pLEHw0p+ItbikR581t0Cb8C/8ckkF5RK7T20RRLe4ik=;
        b=BE01GgmLkfnh0SlKDDJM0CdeuLLakzzZ0xqWdDtfsOYvYY8wrZVIkGTtu7FrNev+qt
         spUGYxeNNDCdTGtvXCE9XKngL9ktTzfh9G3xqEu4nOPAObm5BdZSCCo/6D6DA5sSVBfg
         v5JG2TfQhOYZTl07szFO5HtpgfUoLd7WGDoF931SmPG7/gsl08Yd5eK117cp5D4J4hdb
         pAIjYTqd0eqpHAImnPco8M5nvckaWtJbxgNlonmNNDBKfIrgSLF3JmG0+C1YN9JxOgLZ
         agn6qmJtkc+zoEepZoW68Z6vHLc0NnVwmHHpWVheT5SRx6Gj7B0D849/TILutDqEPNh7
         GT8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692809232; x=1693414032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pLEHw0p+ItbikR581t0Cb8C/8ckkF5RK7T20RRLe4ik=;
        b=f0ccOOR+WTf1Ylmms/al9Rf0rja1X7EX0kU0Kr2uSoUnIFpwTDuj5NkHMpCBpOn7tE
         exWOritjDJsO0+KpwR/JxXPxsZqTg1JD+MDmRCiXaFCBLYXXSX04cY3ngg4WCT1GR6eA
         nah0aJK9nzztGxVzAc0FMlj4b6oFpUP1ykkR9fXvEB+V5udS/8I6p86LiLwuJOrZw0Qm
         suZt6OU/16VAa7amQBZQG3wyt6T6mIBa+hdIeyvQZyRbsC0VcvYevsug7IsDoAPjxVwL
         ZxDtJeLBsg3L5GKii0T+mlPO2bsDdfDZsbCXctC2Vgcs8nFD7GC1CAYSI88trG1EFyNr
         gygg==
X-Gm-Message-State: AOJu0Yye9a94aI/8FnADnd5R2paTlYvhUyNeZyRd6K++IRPJNV55hrQR
        6nbEcHxMWJ/qIEDvRR7k6fY=
X-Google-Smtp-Source: AGHT+IFcEs87mj9LiehOwBZ+67DiIaboptJJyoQJjMCSoGy+/IFAExF1rZixP92bqvpQEqxWpOGeBw==
X-Received: by 2002:aca:2b08:0:b0:3a8:4dfd:4f02 with SMTP id i8-20020aca2b08000000b003a84dfd4f02mr12455452oik.11.1692809232070;
        Wed, 23 Aug 2023 09:47:12 -0700 (PDT)
Received: from DESKTOP-7B1REV8.localdomain ([2001:569:5755:c600:f516:e916:c7f4:e401])
        by smtp.gmail.com with ESMTPSA id n16-20020aa79050000000b0068664ace38asm10043148pfo.19.2023.08.23.09.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 09:47:11 -0700 (PDT)
From:   Qingjie Xing <xqjcool@gmail.com>
To:     edumazet@google.com
Cc:     davem@davemloft.net, dhowells@redhat.com, fw@strlen.de,
        johannes@sipsolutions.net, keescook@chromium.org, kuba@kernel.org,
        kuniyu@amazon.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com, pctammela@mojatatu.com,
        xqjcool@gmail.com
Subject: Further Elaboration on this patch
Date:   Wed, 23 Aug 2023 09:43:34 -0700
Message-Id: <20230823164334.93-1-xqjcool@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CANn89iJCDYteM_1SQ-h2=htUAE4FqrBAak0kHt_Z990XYZThzQ@mail.gmail.com>
References: <CANn89iJCDYteM_1SQ-h2=htUAE4FqrBAak0kHt_Z990XYZThzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First of all, I'd like to apologize for the duplication of emails.
I'm sorry for any inconvenience this may have caused.

It's important to emphasize that this fix primarily addresses an anomaly
in the behavior of `netlink_rcv_wake()` and `netlink_overrun()` when
dealing with the `NETLINK_S_CONGESTED` flag. This issue only arises when
the --sk->sk_receive_queue-- is empty.

This situation occurs when `netlink_recvmsg()` completes the reception of
the last packet in the sk->sk_receive_queue, leaving it empty. Within 
netlink_rcv_wake()`, the `NETLINK_S_CONGESTED` flag is cleared. However,
concurrently, `netlink_overrun()` proceeds to set the `NETLINK_S_CONGESTED`
flag again.

In this specific scenario, due to the `NETLINK_S_CONGESTED` flag being set,
packets sent to this socket cannot be added to the sk->sk_receive_queue.
Because the sk->sk_receive_queue is empty, the `EPOLLIN` flag, which is 
monitored by the `poll()` call, won't be set. Consequently, further calls
to `netlink_recvmsg()` will not be triggered.

When the sk->sk_receive_queue is not empty, or when concurrent actions
lead to the non-emptiness of sk->sk_receive_queue, these situations will
not pose a problem. This is because as long as there are packets in the
sk->sk_receive_queue, the `netlink_recvmsg()` function will be invoked
continuously until the queue becomes empty. Only when the
sk->sk_receive_queue becomes empty, the `netlink_rcv_wake()` function
will attempt once again to clear the `NETLINK_S_CONGESTED` flag.
Therefore, we only need to consider the scenario described above, where
the sk->sk_receive_queue is empty.
