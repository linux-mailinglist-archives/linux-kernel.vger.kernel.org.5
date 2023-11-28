Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45FE07FC693
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 22:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346211AbjK1U5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 15:57:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343899AbjK1U5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 15:57:52 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 335BEDA
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 12:57:58 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40b2ddab817so42572785e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 12:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1701205076; x=1701809876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Eg2wTeQcpZed4qmQGZeMtHI8/aYwGBDHLZSGLE1zswI=;
        b=j8D31Q9pEnWnPtD3zpGLqT8MONMLBfkRFxcOLbDiq/Fc8zqIGvbLS/wDCKX2pKqhaI
         VXFIbFaH+uITOT44/86164XBtEB1rzDp091VUeT9/RvAAma4kNAPlGdzhzZxYem7DLim
         V9QGj9ckv00rUN1Nre2W9jbFw8GZndF1AUt/qRJ7FiZP0XHwAomyUqXnbhNIliKXUc0E
         a9Knwik46XchRSoHc5C83O4s7HBnVbHg6x5f3n/cYsRz5E6V/WUAF5psNk7hW0WdNrtA
         pSy6s59/EN99RQVSKB6ojfiCW9PbusPN99GdkHnvNcggSHcOUFH5SS06S8/bCa4s6sdF
         SNKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701205076; x=1701809876;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Eg2wTeQcpZed4qmQGZeMtHI8/aYwGBDHLZSGLE1zswI=;
        b=UgwMzl80YygRQouM8Fdr7jt120+qfl3rJh9wcc0ageQ59v3IrRODclVQUYeVnnKNoj
         eddxwEeKrK2Ui//JWWgoogcEaTvJZhu4fADh/JXptQxLUNDJOQi+ALFBbm0DyRyup2zX
         0w6jqnb8erXwOI6rUm9evOIGQLXerM5zp/3LSqCkIlOOFuy5YsphvgvoJhLqdCwZsLA2
         /kuOogzco0m/eGByt0/uXLK2AEFyIPejlO+V6YTb3o84lobZfj0ODSFCySJ1MmqL3sky
         1AuuubT59BWNz2UOOuOsL8uo8YMRSub2sa03Oi/7mQhKhT8VSAAznsGWGXwHSqWyvS0G
         4VKA==
X-Gm-Message-State: AOJu0YzHbVZObvlOiesIDk5XxdKctwVTzEUxUMNSPwLNjbawUSsx11Lp
        tsgdvFLyzIQJO3W28MmBeaZGgA==
X-Google-Smtp-Source: AGHT+IHhlmDunPhVUt0EJd91505nMJdUTWbIOFTIF0zQ8f6XyZLElANclWwrHhH1iVcCQYsYmF/saw==
X-Received: by 2002:a05:600c:1552:b0:40b:5075:c147 with SMTP id f18-20020a05600c155200b0040b5075c147mr934652wmg.8.1701205076677;
        Tue, 28 Nov 2023 12:57:56 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id o19-20020a05600c4fd300b0040b45356b72sm9247423wmq.33.2023.11.28.12.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 12:57:56 -0800 (PST)
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
Subject: [PATCH v3 0/7] TCP-AO fixes
Date:   Tue, 28 Nov 2023 20:57:42 +0000
Message-ID: <20231128205749.312759-1-dima@arista.com>
X-Mailer: git-send-email 2.43.0
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

Changes from v2:
- rwlocks are problematic in net code (Paolo)
  Changed the SNE code to avoid spin/rw locks on RX/TX fastpath by
  double-accounting SEQ numbers for TCP-AO enabled connections.

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

The following changes since commit df60cee26a2e3d937a319229e335cb3f9c1f16d2:

  Merge tag '6.7-rc3-smb3-server-fixes' of git://git.samba.org/ksmbd (2023-11-27 17:17:23 -0800)

are available in the Git repository at:

  git@github.com:0x7f454c46/linux.git tcp-ao-post-merge-v3

for you to fetch changes up to 822e6f2d14a1e1de98835fcc3940c04d28582656:

  net/tcp: Don't store TCP-AO maclen on reqsk (2023-11-28 17:57:32 +0000)

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
  net/tcp: Allow removing current/rnext TCP-AO keys on TCP_LISTEN
    sockets
  net/tcp: Don't add key with non-matching VRF on connected sockets
  net/tcp: Store SNEs + SEQs on ao_info
  net/tcp: Don't store TCP-AO maclen on reqsk

 Documentation/networking/tcp_ao.rst |  2 +-
 include/linux/tcp.h                 |  8 +---
 include/net/tcp_ao.h                | 31 ++++++++++--
 net/ipv4/tcp.c                      | 13 ++++-
 net/ipv4/tcp_ao.c                   | 74 ++++++++++++++++++-----------
 net/ipv4/tcp_fastopen.c             |  2 +
 net/ipv4/tcp_input.c                | 26 ++++++----
 net/ipv4/tcp_ipv4.c                 |  4 +-
 net/ipv4/tcp_minisocks.c            |  2 +-
 net/ipv4/tcp_output.c               | 16 +++----
 net/ipv6/tcp_ipv6.c                 |  2 +-
 11 files changed, 116 insertions(+), 64 deletions(-)


base-commit: df60cee26a2e3d937a319229e335cb3f9c1f16d2
-- 
2.43.0

