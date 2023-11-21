Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4637F236A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 03:01:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233099AbjKUCBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 21:01:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232830AbjKUCBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 21:01:25 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16971E8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 18:01:20 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40906fc54fdso21739175e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 18:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1700532078; x=1701136878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SC1Z2aKJYnydBjbbTXuq7CDbdzNLqNihvi9zYbo0HHw=;
        b=abn3oIPWtozRE+3NUEl6UwkbEeQ6mM6mPRHjAXYg2xd9Wc2KO9HVEkTLTXieCRJUfl
         qMydsb2uB4ffHhUu3jrqbgBtMUMBN6i8PZAkf02sIhqoIrvt7mef52wdr6NBWsMERHUY
         Ixo1vkTCFHbtk2wMsqURKEhbQUPh8JoS1QxT5tJknFpgusjTp4RW56D33aTSKWd1xaav
         VpXb86L+HhfMznVmosb7uC8K3IAbSYXLSmfoVuETIsYk9bhZKwq/lj3+FzX2lXv42WyQ
         stia+OXZcDs6hEbcnxgm5VtavJXSJSFVwp9dpPtjmvrxhomJcvDv1TCL7Ke1X1FxBscK
         oUlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700532078; x=1701136878;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SC1Z2aKJYnydBjbbTXuq7CDbdzNLqNihvi9zYbo0HHw=;
        b=dysuNi3uksM0P5kLw6dxw9A4Oq1JtZzTzzyYF8gM7TPFZR1ePAY+/lB+t4a99lNXkt
         cmXrafiPShpKrgQFlvO6SBon4/+FHpaneBdsdqBElGTJ1BzjciRTUTOBZ3Y6GvZ3W6Rw
         OmIOtyEnWLmn7wc5uHAwlQWS6oW5DFIQNWdKjypr/xvvNwHqBmGCconla3h164L7q1+2
         3+TNcSjerlJp9dNHpOPRK2DvvFkn4gF2WJ9dvV89ACsWY/K40LwXG6/egC0GxUNdXBUJ
         2uqeUjtu/Qm/abcty8bq4zdcFpNSJ64OR4HQLbIlfOGa3UEZ1/s/UQcgCWPkzkmUwLbU
         txUQ==
X-Gm-Message-State: AOJu0YwPuSrlu5R1nZmWKT0e8F4i1Cl9wOIf1LyEUhTYPjhqBi7N+gLL
        7LMcyGRXg+6XlzWGQZhpBMdsiw==
X-Google-Smtp-Source: AGHT+IFvvH7kq5FF9+JmqB/nlqMP2X4t2+SnfXFKKHPyCDBAfU4fv+iYMQr6gTjOPqA/V/4ke57Kzg==
X-Received: by 2002:a5d:6d0f:0:b0:332:c4b4:2a8c with SMTP id e15-20020a5d6d0f000000b00332c4b42a8cmr5210203wrq.43.1700532078517;
        Mon, 20 Nov 2023 18:01:18 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id c13-20020a056000184d00b00332cb846f21sm2617105wri.27.2023.11.20.18.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 18:01:18 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org, Dmitry Safonov <dima@arista.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Francesco Ruggeri <fruggeri05@gmail.com>,
        Salam Noureddine <noureddine@arista.com>,
        Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH 0/7] TCP-AO fixes
Date:   Tue, 21 Nov 2023 02:01:04 +0000
Message-ID: <20231121020111.1143180-1-dima@arista.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've been working on TCP-AO key-rotation selftests and as a result
exercised some corner-cases that are not usually met in production.

Here are a bunch of semi-related fixes:
- Documentation typo (reported by Markus Elfring)
- Proper alignment for TCP-AO option in TCP header that has MAC length
  of non 4 bytes (now a selftest with randomized maclen/algorithm/etc
  passes)
- 3 uAPI restricting patches that disallow more things to userspace in
  order to prevent it shooting itself in any parts of the body
- SNEs READ_ONCE()/WRITE_ONCE() that went missing by my human factor
- Avoid storing MAC length from SYN header as SYN-ACK will use
  rnext_key.maclen (drops an extra check that fails on new selftests)

Please, consider applying/pulling.

The following changes since commit 98b1cc82c4affc16f5598d4fa14b1858671b2263:

  Linux 6.7-rc2 (2023-11-19 15:02:14 -0800)

are available in the Git repository at:

  git@github.com:0x7f454c46/linux.git tcp-ao-post-merge

for you to fetch changes up to 4555b5b8d11f4d19ef32a761e2d87dd378e9a435:

  net/tcp: Don't store TCP-AO maclen on reqsk (2023-11-21 01:48:23 +0000)

----------------------------------------------------------------
Dmitry Safonov (7):
      Documentation/tcp: Fix an obvious typo
      net/tcp: Consistently align TCP-AO option in the header
      net/tcp: Limit TCP_AO_REPAIR to non-listen sockets
      net/tcp: Reset TCP-AO cached keys on listen() syscall
      net/tcp: Don't add key with non-matching VRF on connected sockets
      net/tcp: ACCESS_ONCE() on snd/rcv SNEs
      net/tcp: Don't store TCP-AO maclen on reqsk

Thanks,
             Dmitry

Cc: David Ahern <dsahern@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Dmitry Safonov <0x7f454c46@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Francesco Ruggeri <fruggeri05@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Salam Noureddine <noureddine@arista.com>
Cc: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org


Dmitry Safonov (7):
  Documentation/tcp: Fix an obvious typo
  net/tcp: Consistently align TCP-AO option in the header
  net/tcp: Limit TCP_AO_REPAIR to non-listen sockets
  net/tcp: Reset TCP-AO cached keys on listen() syscall
  net/tcp: Don't add key with non-matching VRF on connected sockets
  net/tcp: ACCESS_ONCE() on snd/rcv SNEs
  net/tcp: Don't store TCP-AO maclen on reqsk

 Documentation/networking/tcp_ao.rst |  2 +-
 include/linux/tcp.h                 | 10 ++++------
 include/net/tcp_ao.h                | 11 +++++++++++
 net/ipv4/af_inet.c                  |  1 +
 net/ipv4/tcp.c                      |  6 ++++++
 net/ipv4/tcp_ao.c                   | 29 +++++++++++++++++++++++------
 net/ipv4/tcp_input.c                |  9 +++++----
 net/ipv4/tcp_ipv4.c                 |  4 ++--
 net/ipv4/tcp_minisocks.c            |  2 +-
 net/ipv4/tcp_output.c               | 15 ++++++---------
 net/ipv6/tcp_ipv6.c                 |  2 +-
 11 files changed, 61 insertions(+), 30 deletions(-)


base-commit: 98b1cc82c4affc16f5598d4fa14b1858671b2263
-- 
2.42.0

