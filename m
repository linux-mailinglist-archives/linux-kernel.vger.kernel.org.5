Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8529D7F69C7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 01:27:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjKXA10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 19:27:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjKXA1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 19:27:24 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B50110C8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 16:27:30 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2c5039d4e88so16644061fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 16:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1700785648; x=1701390448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q8QM/m7UTtv+MC2zusUkJTGgTrqbe8gRAx9REDFyuSU=;
        b=kRvkrt2ME06+64sbnWjGIGz9OeN3KFbdlPZCk6Htz8uuIVvLqj5G7mXzp4wlNm3bRk
         QnuhH1Yvx4CzN4NKknKX42dYX99voJKjXarmoW/8SV2PT91kr7JluuO/Ta1BJ1Wul+8S
         i1cfndvTTlGCopgzie4xQWu6yVpiTDtJPaFjIy5EiQ0kZX2DMCxAmW2P1Qq4FRCfTeiu
         mMJVerT1bcYdOalTqZbgESxMYt9pKi94hpnX/4dHnXd7KyhknNqrly9GwSo7MjLIX6Vn
         BTTnzoOxtjk//3hPh8PSbYWkelsNeJxf3t03za17Z47C3nock2n2LtqRGBQWWAjYqnpn
         vxNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700785648; x=1701390448;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q8QM/m7UTtv+MC2zusUkJTGgTrqbe8gRAx9REDFyuSU=;
        b=Tmg3CeVv4eGkv9MsR1JLSPADc01KKaiSDgEznINVnZA6Yj+RIi8tUxPjrZqmQtvo0a
         hy1KlKbXmtUh8ft/qYQZfCRKDxURJM26p/gnMJGhcvy20hGW55hbFeznXzLA513KccCI
         ekBswWA6A75ASwP7iUhVJXZUtaynUyniIZQbmHiGhd1zNew/IHBH1xZb9oNOYdKQGN0y
         eSG+H8AxsHbBEiGDP7OOBHcBLWNcoW5/a/I4QpkatDccxEbGtvfEdMRTRuu1928i7xiH
         amLFDixx8n0Lkzt2b8PRa+jrU9C1Th3UiooUTFR/vbd8yOQRWzXCieQcpX6VOyT3ZvP8
         gE2g==
X-Gm-Message-State: AOJu0YycoQyoyjy9zRpjFOtuw0RKK7Smv/OigbO6BZ65SdHuYQVM+YWR
        iSzZRiMtqFMKoUa7/bALKoUKzg==
X-Google-Smtp-Source: AGHT+IFh+qtjDvYkcbRMFlh/WyRvztcosddBJ2m0H91J1i9G+Zxs4K+RjS13PJvfkM83cKVos7a9uA==
X-Received: by 2002:a2e:3615:0:b0:2c5:2fa8:716a with SMTP id d21-20020a2e3615000000b002c52fa8716amr689164lja.9.1700785648284;
        Thu, 23 Nov 2023 16:27:28 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id g9-20020a05600c310900b004094e565e71sm3453230wmo.23.2023.11.23.16.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 16:27:27 -0800 (PST)
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
        Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH v2 0/7] TCP-AO fixes
Date:   Fri, 24 Nov 2023 00:27:13 +0000
Message-ID: <20231124002720.102537-1-dima@arista.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Changes from v1:
- Use tcp_can_repair_sock() helper to limit TCP_AO_REPAIR (Eric)
- Instead of hook to listen() syscall, allow removing current/rnext keys
  on TCP_LISTEN (addressing Eric's objection)
- Add sne_lock to protect snd_sne/rcv_sne
- Don't move used_tcp_ao in struct tcp_request_sock (Eric)

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

The following changes since commit d3fa86b1a7b4cdc4367acacea16b72e0a200b3d7:

  Merge tag 'net-6.7-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2023-11-23 10:40:13 -0800)

are available in the Git repository at:

  git@github.com:0x7f454c46/linux.git tcp-ao-post-merge-v2

for you to fetch changes up to c5e4cecfcdc7f996acae740812d9ab2ebcd90517:

  net/tcp: Don't store TCP-AO maclen on reqsk (2023-11-23 20:54:54 +0000)

----------------------------------------------------------------

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
  net/tcp: Allow removing current/rnext TCP-AO keys on TCP_LISTEN sockets
  net/tcp: Don't add key with non-matching VRF on connected sockets
  net/tcp: Add sne_lock to access SNEs
  net/tcp: Don't store TCP-AO maclen on reqsk

 Documentation/networking/tcp_ao.rst |  2 +-
 include/linux/tcp.h                 |  8 +---
 include/net/tcp_ao.h                |  8 +++-
 net/ipv4/tcp.c                      |  6 +++
 net/ipv4/tcp_ao.c                   | 57 +++++++++++++++++++----------
 net/ipv4/tcp_input.c                | 21 +++++++++--
 net/ipv4/tcp_ipv4.c                 |  4 +-
 net/ipv4/tcp_minisocks.c            |  2 +-
 net/ipv4/tcp_output.c               | 15 +++-----
 net/ipv6/tcp_ipv6.c                 |  2 +-
 10 files changed, 81 insertions(+), 44 deletions(-)


base-commit: d3fa86b1a7b4cdc4367acacea16b72e0a200b3d7
-- 
2.43.0

