Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60DC97A527B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 21:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjIRTAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 15:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjIRTAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 15:00:43 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A7810E
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 12:00:36 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-403004a96a4so54134025e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 12:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1695063635; x=1695668435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ll/AvVRrBQm6SEVrUQpNi67a39m/OvrEmI+jt6Dj7aQ=;
        b=WBe7iUuj1yximGeBscfmUCPaiMOuP+QUFipw/x0yHuLvAzNODU6T3cBeCLF2FBRTqu
         TKlsIoxqTVK2hxg5aI8+NVjU/msmB1mJqQIu0Xux+CM+CoMFNHWcDJ+uCYAzAISjKq3z
         9VFUWu+XJbYFkG4QztVqpaN89kKD4XR5zXKlE+PrSRzCCASyFg2+Zm+8QBtU3Gk4x4xP
         Zel4n2R+f38JAAU/vk/o84QzRqRacQKI8dvSm6/GFf1ZJsKN4Dgbo+H7GVI/Sj6DgCEA
         1xmkiQJS+FsQhIh499APaq8kX/GxoaVTA0x3St8V/etUnWS5mr87k7zp/sxRXwrMAaKX
         Zf6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695063635; x=1695668435;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ll/AvVRrBQm6SEVrUQpNi67a39m/OvrEmI+jt6Dj7aQ=;
        b=gTXyOXjYSp6EBPxdKJbILGWhL+ZuXRSxCiUNtuPA7VyCe7UbPeFEx+r/+1F2lCK1IK
         /9FDlpxu3yBKYiiB7zzalspA8XGBJ/K6HBJnhrmMhE/fjkPFFo9SVUaxDICOw6XGoXa/
         uzOuSnRTjHeb2F4tMla56sUXsMECSEHdaPp3aNKSlW27BKP5CIaIvrVDSFwD2StC1Yo9
         VXiiErqls8UcTpMC6LR1X4s9kOndOd1jjKNdXveKaoJ8JmCQGIFwPt0cs907HIGa0RfJ
         TxO/GyYc1q6IUoGWoxzK7Xt1xYwRUqgRmumkSS1ogSjhGB/2oHse8BgeWY8LLwMXjaeE
         ly6g==
X-Gm-Message-State: AOJu0YxAKpws69CpOwYhd1Jibh4uQK1qtsiivpE3lZGVkzMGbZw2L1g4
        Dn7Few6HEW2WmT3rNgB++oiBjA==
X-Google-Smtp-Source: AGHT+IGqkw9V5NHoNUS+Ag1XP6STp8YGqhWG5D6u54EXL3/EwOyMEZDcRggx6NIa5Fo390ZnHS7oHA==
X-Received: by 2002:a7b:ce0f:0:b0:3fe:1b4e:c484 with SMTP id m15-20020a7bce0f000000b003fe1b4ec484mr8291094wmc.5.1695063635291;
        Mon, 18 Sep 2023 12:00:35 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id n9-20020a05600c3b8900b004047ac770d1sm10762707wms.8.2023.09.18.12.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 12:00:34 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org, Dmitry Safonov <dima@arista.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Bob Gilligan <gilligan@arista.com>,
        Dan Carpenter <error27@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Donald Cassidy <dcassidy@redhat.com>,
        Eric Biggers <ebiggers@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Francesco Ruggeri <fruggeri05@gmail.com>,
        "Gaillardetz, Dominik" <dgaillar@ciena.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Ivan Delalande <colona@arista.com>,
        Leonard Crestez <cdleonard@gmail.com>,
        "Nassiri, Mohammad" <mnassiri@ciena.com>,
        Salam Noureddine <noureddine@arista.com>,
        Simon Horman <simon.horman@corigine.com>,
        "Tetreault, Francois" <ftetreau@ciena.com>, netdev@vger.kernel.org,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH v12 net-next 00/23] net/tcp: Add TCP-AO support
Date:   Mon, 18 Sep 2023 19:59:58 +0100
Message-ID: <20230918190027.613430-1-dima@arista.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is version 12 of TCP-AO support. The changes from v11 address
Eric's review comments. The biggest change was defining a common
(struct tcp_key) that merges tcp_ao_key with tcp_md5sig_key on TCP
fast-path, therefore in order to help reviewing I provide
the ranged-diff between the versions here:

   https://gist.github.com/0x7f454c46/fe546b9cf323ca21acc3d0eabbd41236

There's one Sparse warning introduced by tcp_sigpool_start():
__cond_acquires() seems to currently being broken. I've described
the reasoning for it on v9 cover letter. Also, checkpatch.pl warnings
were addressed, but yet I've left the ones that are more personal
preferences (i.e. 80 columns limit). Please, ping me if you have
a strong feeling about one of them.

The following changes since commit a5ea26536e89d04485aa9e1c8f60ba11dfc5469e:

  Merge branch 'stmmac-devvm_stmmac_probe_config_dt-conversion' (2023-09-18 12:44:36 +0100)

are available in the Git repository at:

  git@github.com:0x7f454c46/linux.git tcp-ao-v12

for you to fetch changes up to 45aa51f1d541b7ce961b379eb0f45031b89575d6:

  Documentation/tcp: Add TCP-AO documentation (2023-09-18 18:07:32 +0100)

----------------------------------------------------------------

And another branch with selftests, that will be sent later separately:
  git@github.com:0x7f454c46/linux.git tcp-ao-v12-with-selftests

Thanks for your time and reviews,
         Dmitry

--- Changelog ---

Changes from v11:
- Define (struct tcp_key) for tcp-fast path and detect by type what key
  was used. This also benefits from TCP-MD5/TCP-AO static branches (Eric)
- Remove sk_gso_disable() from TCP-AO fast-path in __tcp_transmit_skb()
  (Eric)
- Don't leak skb on failed kmalloc() in __tcp_transmit_skb() (Eric)
- skb_dst_drop() is not necessary as kfree_skb() calls it (Eric)
- Don't dereference tcp_ao_key in net_warn_ratelimited(), outside of
  rcu_read_lock() (Eric)

Changes from v10:
- Make seq (u32) in tcp_ao_prepare_reset() and declare the argument
  in "net/tcp: Add TCP-AO SNE support", where it gets used (Simon)
- Fix rebase artifact in tcp_v6_reqsk_send_ack(), which adds
  compile-error on a patch in the middle of series (Simon)
- Another rebase artifact in tcp_v6_reqsk_send_ack() that makes
  keyid, requested by peer on ipv6 reqsk ACKs not respected (Simon)

Version 10: https://lore.kernel.org/all/20230815191455.1872316-1-dima@arista.com/T/#u

The pre-v10 changelog is on version 10 cover-letter.

Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Bob Gilligan <gilligan@arista.com>
Cc: Dan Carpenter <error27@gmail.com>
Cc: David Ahern <dsahern@kernel.org>
Cc: David Laight <David.Laight@aculab.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Dmitry Safonov <0x7f454c46@gmail.com>
Cc: Donald Cassidy <dcassidy@redhat.com>
Cc: Eric Biggers <ebiggers@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Francesco Ruggeri <fruggeri05@gmail.com>
Cc: Gaillardetz, Dominik <dgaillar@ciena.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Cc: Ivan Delalande <colona@arista.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Leonard Crestez <cdleonard@gmail.com>
Cc: Nassiri, Mohammad <mnassiri@ciena.com>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Salam Noureddine <noureddine@arista.com>
Cc: Simon Horman <simon.horman@corigine.com>
Cc: Tetreault, Francois <ftetreau@ciena.com>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Dmitry Safonov (23):
  net/tcp: Prepare tcp_md5sig_pool for TCP-AO
  net/tcp: Add TCP-AO config and structures
  net/tcp: Introduce TCP_AO setsockopt()s
  net/tcp: Prevent TCP-MD5 with TCP-AO being set
  net/tcp: Calculate TCP-AO traffic keys
  net/tcp: Add TCP-AO sign to outgoing packets
  net/tcp: Add tcp_parse_auth_options()
  net/tcp: Add AO sign to RST packets
  net/tcp: Add TCP-AO sign to twsk
  net/tcp: Wire TCP-AO to request sockets
  net/tcp: Sign SYN-ACK segments with TCP-AO
  net/tcp: Verify inbound TCP-AO signed segments
  net/tcp: Add TCP-AO segments counters
  net/tcp: Add TCP-AO SNE support
  net/tcp: Add tcp_hash_fail() ratelimited logs
  net/tcp: Ignore specific ICMPs for TCP-AO connections
  net/tcp: Add option for TCP-AO to (not) hash header
  net/tcp: Add TCP-AO getsockopt()s
  net/tcp: Allow asynchronous delete for TCP-AO keys (MKTs)
  net/tcp: Add static_key for TCP-AO
  net/tcp: Wire up l3index to TCP-AO
  net/tcp: Add TCP_AO_REPAIR
  Documentation/tcp: Add TCP-AO documentation

 Documentation/networking/index.rst  |    1 +
 Documentation/networking/tcp_ao.rst |  434 +++++
 include/linux/sockptr.h             |   23 +
 include/linux/tcp.h                 |   30 +-
 include/net/dropreason-core.h       |   30 +
 include/net/tcp.h                   |  288 +++-
 include/net/tcp_ao.h                |  347 ++++
 include/uapi/linux/snmp.h           |    5 +
 include/uapi/linux/tcp.h            |  105 ++
 net/ipv4/Kconfig                    |   17 +
 net/ipv4/Makefile                   |    2 +
 net/ipv4/proc.c                     |    5 +
 net/ipv4/syncookies.c               |    4 +
 net/ipv4/tcp.c                      |  246 +--
 net/ipv4/tcp_ao.c                   | 2341 +++++++++++++++++++++++++++
 net/ipv4/tcp_input.c                |   97 +-
 net/ipv4/tcp_ipv4.c                 |  363 ++++-
 net/ipv4/tcp_minisocks.c            |   50 +-
 net/ipv4/tcp_output.c               |  263 ++-
 net/ipv4/tcp_sigpool.c              |  358 ++++
 net/ipv6/Makefile                   |    1 +
 net/ipv6/syncookies.c               |    5 +
 net/ipv6/tcp_ao.c                   |  168 ++
 net/ipv6/tcp_ipv6.c                 |  374 +++--
 24 files changed, 5122 insertions(+), 435 deletions(-)
 create mode 100644 Documentation/networking/tcp_ao.rst
 create mode 100644 include/net/tcp_ao.h
 create mode 100644 net/ipv4/tcp_ao.c
 create mode 100644 net/ipv4/tcp_sigpool.c
 create mode 100644 net/ipv6/tcp_ao.c


base-commit: a5ea26536e89d04485aa9e1c8f60ba11dfc5469e
-- 
2.41.0

