Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BDBB7BEEB0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 01:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378958AbjJIXHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 19:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377234AbjJIXHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 19:07:33 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A4F39E
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 16:07:31 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-3232be274a0so3691703f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 16:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1696892850; x=1697497650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g0DmV+47BzxxddQZc0yCtAVDMIVlVhPRtnj2cwnJcnk=;
        b=kTfCgO5eE0YGZ/zyniFlSlv0NYsc32WxtRFFfO6Q9UVWnAZS/gNgGRmpUlAGKLRTjl
         yzfcgxjdOF2AYYkKHvBXiLyoqPWFvswgyBhfgrySLPXXLfQz7kyem00IBsBXOGLPrzRF
         pBJqj3QNvBN1N/wzv5e1DgqvlPlUz40xH4OoEkLMDSlyXm/Kzz5dCMgP8CcOa2067iEj
         4feSMQ0U/iaH7IUN/o5t37jof9LfvHyIjjqnjCrrD3FNLQ/Mk7J+3gfkasZpM4/fxSUA
         TRYbThD6IjmAsnfkHZPXL56/0bnf1a0ka9Wy3b8OSrc8tJJTRohfWiX6RGoZ8M/qsS6K
         OI0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696892850; x=1697497650;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g0DmV+47BzxxddQZc0yCtAVDMIVlVhPRtnj2cwnJcnk=;
        b=lKBOe16F1gOKhuuyo8Wqtr18lh66CY934Jk0Xiz4ZqTH3vTzEcJCqBbUBNdzE5Oofu
         7BYzFoWXejsEaRjwsFI/BLSPx+W9lDZ8Zg9FKiA+6NM++m9yamJsXI6756038BSjG4WE
         Fhs3rpARmjjXloOMkBnkOEKDkdkKi7oOenMoCvOK2o0FBv0LKXdpG4CDBhxmTRUGb9H1
         RXE5gloTgah9y+eoAZrTKU3ooGtHsswcPqKxdmW/RKuT5e6ONrl+69wIpwikQhoq8rHo
         3gvgZyc27ATKhuKF+B88Dv1hqW9kuFQL41rQGTsqoa2ipWA6xWj5O8ul0aUCNfkNJ0gd
         rNRA==
X-Gm-Message-State: AOJu0YzyDB5tkdWxal8NaOrWECKJNfENj2GPtPDBE64ANaN20GMY6k0C
        YAdiwRLSpe8OI9UydcTVXwGnyg==
X-Google-Smtp-Source: AGHT+IELHQqU0hyAF68nELnOO1ertPHo+zDylE0dxYqx2DnIvMPQazy0boZGMoaxNQETZCbyFGFZyw==
X-Received: by 2002:a5d:5442:0:b0:324:84bc:d5ab with SMTP id w2-20020a5d5442000000b0032484bcd5abmr10981437wrv.1.1696892849680;
        Mon, 09 Oct 2023 16:07:29 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id t24-20020a7bc3d8000000b004042dbb8925sm14592104wmj.38.2023.10.09.16.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 16:07:29 -0700 (PDT)
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
Subject: [PATCH v14 net-next 00/23] net/tcp: Add TCP-AO support
Date:   Tue, 10 Oct 2023 00:06:51 +0100
Message-ID: <20231009230722.76268-1-dima@arista.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is version 14 of TCP-AO support. More-or-less quick update from v13
addressing Jonathan review comment on unreadable list-tables in TCP-AO
Documentation/ page.

There's one Sparse warning introduced by tcp_sigpool_start():
__cond_acquires() seems to currently being broken. I've described
the reasoning for it on v9 cover letter. Also, checkpatch.pl warnings
were addressed, but yet I've left the ones that are more personal
preferences (i.e. 80 columns limit). Please, ping me if you have
a strong feeling about one of them.

The following changes since commit 19537e125cc7cf2da43a606f5bcebbe0c9aea4cc:

  net: bcmgenet: Remove custom ndo_poll_controller() (2023-10-08 17:42:43 +0100)

are available in the Git repository at:

  git@github.com:0x7f454c46/linux.git tcp-ao-v14

for you to fetch changes up to e7b89a5efe68fc78ef8bc3be2bce60a9d35ac4be:

  Documentation/tcp: Add TCP-AO documentation (2023-10-09 23:31:25 +0100)

----------------------------------------------------------------

And another branch with selftests, that will be sent later separately:
  git@github.com:0x7f454c46/linux.git tcp-ao-v14-with-selftests

Thanks for your time and reviews,
         Dmitry

--- Changelog ---

Changes from v13:
- Converted Documentation/ page from human unreadable list-table::
  to grid-table(s) (Jonathan)

Version 13: https://lore.kernel.org/all/20231004223629.166300-1-dima@arista.com/T/#u

Changes from v12:
- Separate TCP-AO sign from __tcp_transmit_skb() into a separate
  function for code locality and readability (Paolo)
- Add TCP-AO self-connect selftest, which by its nature is a selftest
  for TCP simultaneous open, use different keyids and check tcp repair
- Fix simultaneous open: take correct ISNs for verification,
  pre-calculate sending traffic key on SYN-ACK, calculate receiving
  traffic key before going into TCP_ESTABLISHED
- Use kfree_sensitive() for hardening purposes
- Use READ_ONCE() on sk->sk_family when not under socket lock to prevent
  any possible race with IPV6_ADDRFORM

Version 12: https://lore.kernel.org/all/20230918190027.613430-1-dima@arista.com/T/#u

Changes from v11:
- Define (struct tcp_key) for tcp-fast path and detect by type what key
  was used. This also benefits from TCP-MD5/TCP-AO static branches (Eric)
- Remove sk_gso_disable() from TCP-AO fast-path in __tcp_transmit_skb()
  (Eric)
- Don't leak skb on failed kmalloc() in __tcp_transmit_skb() (Eric)
- skb_dst_drop() is not necessary as kfree_skb() calls it (Eric)
- Don't dereference tcp_ao_key in net_warn_ratelimited(), outside of
  rcu_read_lock() (Eric)

Version 11: https://lore.kernel.org/all/20230911210346.301750-1-dima@arista.com/T/#u

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
 Documentation/networking/tcp_ao.rst |  444 +++++
 include/linux/sockptr.h             |   23 +
 include/linux/tcp.h                 |   30 +-
 include/net/dropreason-core.h       |   30 +
 include/net/tcp.h                   |  288 +++-
 include/net/tcp_ao.h                |  361 ++++
 include/uapi/linux/snmp.h           |    5 +
 include/uapi/linux/tcp.h            |  105 ++
 net/ipv4/Kconfig                    |   17 +
 net/ipv4/Makefile                   |    2 +
 net/ipv4/proc.c                     |    5 +
 net/ipv4/syncookies.c               |    4 +
 net/ipv4/tcp.c                      |  246 +--
 net/ipv4/tcp_ao.c                   | 2389 +++++++++++++++++++++++++++
 net/ipv4/tcp_input.c                |   98 +-
 net/ipv4/tcp_ipv4.c                 |  363 +++-
 net/ipv4/tcp_minisocks.c            |   50 +-
 net/ipv4/tcp_output.c               |  236 ++-
 net/ipv4/tcp_sigpool.c              |  358 ++++
 net/ipv6/Makefile                   |    1 +
 net/ipv6/syncookies.c               |    5 +
 net/ipv6/tcp_ao.c                   |  168 ++
 net/ipv6/tcp_ipv6.c                 |  374 +++--
 24 files changed, 5168 insertions(+), 435 deletions(-)
 create mode 100644 Documentation/networking/tcp_ao.rst
 create mode 100644 include/net/tcp_ao.h
 create mode 100644 net/ipv4/tcp_ao.c
 create mode 100644 net/ipv4/tcp_sigpool.c
 create mode 100644 net/ipv6/tcp_ao.c


base-commit: 19537e125cc7cf2da43a606f5bcebbe0c9aea4cc
-- 
2.42.0

