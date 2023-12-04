Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3C26803DED
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 20:01:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjLDTAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 14:00:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbjLDTAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 14:00:49 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A1EFA
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 11:00:54 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-a1b7b6bf098so205497466b.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 11:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1701716453; x=1702321253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RwD2XopKRhDcKNokK1u0ay6hI/ADWt3zA2G08pzMLDs=;
        b=YHB3ssCOCDwZtDUNgKw3MksznWZjMVyxFC1JcjUaLSG7VSRsPbbH+Cdlq46VqRZD2q
         +yXkOOt/gagi9hjRrmrscp9Gabhy0etxGJLOkfySYBNcdeLsKkCNVxHkusfxv2LnHBOu
         KB2BgyTQL2keIyZSujG7L6y6KpILvtmhsZCwXGSwZ0VaHCAF8JOSuEjBh7O03SxsxsNJ
         dpNNfbDxU0/IdNer8m+W7RF6p4a9kTfl497wDc1XLoKp+/vaxSnl0J2rAtbg6rPZBWPj
         DkR/zdEtfXKrJNHZFmdcUlbkx4DeSnr7qkoXAe+hoNh6d/44n0w9VQ5V7IElgfUfH5Yt
         ILUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701716453; x=1702321253;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RwD2XopKRhDcKNokK1u0ay6hI/ADWt3zA2G08pzMLDs=;
        b=ZLXxSzxPafyOwRxN3aasDXH6iO8x7gQf8sLhFeHE9x97ud/5tpXqmaVJiGE5V+GThe
         XWdl32sQgFERy2FKHu8k51xHEC96AIg+w9VlBQQEcDQj+3gUkt8E/iidHs+7AeG4RpBG
         5e05/6kq3DGGtn488lFTFjKEWSUWWv1MpxuBqAB7yEbWWAZmFy/bdYt8uemdT+mdvWb4
         6UVHQiOYHjEpC/1IwJUFOUWJ6afxPX7eZmtmg+swmsP6XkORattRW1zmcVOnGzuP1Yun
         Bop8Km8sBp1fyaZ8qGlb6kEyeegjQx+LGmpmQj0dSwck/M6euv3fA+gyfRcB/Y9A0ayK
         Tt7g==
X-Gm-Message-State: AOJu0YxhNdKT3e01lJNS92/6wEcPP2L4Te7/QsbBem00uPOqZoDPNFg4
        Hjd68Azg2KFyY0PPLywZb5ba7w==
X-Google-Smtp-Source: AGHT+IFzrv0hg9IOKz1K3PFLsyMHrkOWrtKQ8BdaZhJ5DdJ1H/NpFvg56NDuPLgvP9b6cB4oV7YYyA==
X-Received: by 2002:a17:906:c2:b0:a1a:e3c6:f50 with SMTP id 2-20020a17090600c200b00a1ae3c60f50mr2707164eji.66.1701716452786;
        Mon, 04 Dec 2023 11:00:52 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id dx9-20020a170906a84900b009fbc655335dsm5577614ejb.27.2023.12.04.11.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 11:00:51 -0800 (PST)
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
Subject: [PATCH v5 0/7] TCP-AO fixes
Date:   Mon,  4 Dec 2023 19:00:39 +0000
Message-ID: <20231204190044.450107-1-dima@arista.com>
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

Changes from v4:
- Dropped 2 patches on which there's no consensus. They will require
  more work TBD if they may made acceptable. Those are:
  o "net/tcp: Allow removing current/rnext TCP-AO keys on TCP_LISTEN sockets"
  o "net/tcp: Store SNEs + SEQs on ao_info"

Changes from v3:
- Don't restrict adding any keys on TCP-AO connection in VRF, but only
  the ones that don't match l3index (David)

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

The following changes since commit 33cc938e65a98f1d29d0a18403dbbee050dcad9a:

  Linux 6.7-rc4 (2023-12-03 18:52:56 +0900)

are available in the Git repository at:

  git@github.com:0x7f454c46/linux.git tcp-ao-post-merge-v5

for you to fetch changes up to 13504cef7e321700d930e9c005db6759c21981a3:

  net/tcp: Don't store TCP-AO maclen on reqsk (2023-12-04 18:23:30 +0000)

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

Dmitry Safonov (5):
  Documentation/tcp: Fix an obvious typo
  net/tcp: Consistently align TCP-AO option in the header
  net/tcp: Limit TCP_AO_REPAIR to non-listen sockets
  net/tcp: Don't add key with non-matching VRF on connected sockets
  net/tcp: Don't store TCP-AO maclen on reqsk

 Documentation/networking/tcp_ao.rst |  2 +-
 include/linux/tcp.h                 |  8 ++------
 include/net/tcp_ao.h                |  6 ++++++
 net/ipv4/tcp.c                      |  6 ++++++
 net/ipv4/tcp_ao.c                   | 17 +++++++++++++----
 net/ipv4/tcp_input.c                |  5 +++--
 net/ipv4/tcp_ipv4.c                 |  4 ++--
 net/ipv4/tcp_minisocks.c            |  2 +-
 net/ipv4/tcp_output.c               | 15 ++++++---------
 net/ipv6/tcp_ipv6.c                 |  2 +-
 10 files changed, 41 insertions(+), 26 deletions(-)


base-commit: 33cc938e65a98f1d29d0a18403dbbee050dcad9a
-- 
2.43.0

