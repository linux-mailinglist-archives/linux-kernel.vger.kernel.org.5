Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC3797A2F60
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 12:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239082AbjIPKy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 06:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239069AbjIPKyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 06:54:01 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89541CF7
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 03:53:55 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-404fbfac998so2931865e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 03:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1694861634; x=1695466434; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pXq3ztXMbHolyHBrYC8jW9R2bypQ+SZTONMaVPi85RA=;
        b=5tsFUfaPGTLlJ7/oVRRE8JTabmYFF75Xrm3yKL49kUFdAE11AJIzmb7PLwGYIsr5N5
         adAcJgLZYSxKNW6iflD3ZjoLu4xhkHosb5mNI0QnZwNyl43qEcgl0wDfO4VwxeSOdRuG
         MvV9aC3SXbuzclpPetvV4+UCnrlGy9fcQaBsAkjTDeA8dHyS/M7O/D8bByV5M18mAiCD
         jN5JTp5bI+oOGCM5UPqUwJrf9GsWtCsgFsLdZ/taXIkLqvgTZph1DLfvjE1EwMjN5StX
         8kyRi7/NIcMeYcixjutLi0e+mVVN8cvZ+az/acaV8bDKMARPLd76ooaeKC0PxpkLHAkA
         gNQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694861634; x=1695466434;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pXq3ztXMbHolyHBrYC8jW9R2bypQ+SZTONMaVPi85RA=;
        b=E1A39+2fOO473H24paPshWESGnd1VkGl7oEMAHiwocIGCddncTHWC1u1qLDDrZs/9m
         uA/r1n++WLL/0B5vmmHL2PM56yQOc8kQ+eevhU8Bz3EdxdjIdEL5IRQVp8tmLBmqG9+C
         6SjmZn/79hxo7X1/t8l7M79XJoWdfNR1Hte+LfwfUS8VVrsi8Wtp24Sjfv7prFcjHD6k
         0LoqUdh2IIw6KcKyikjOXyAcQjIcrLgg6nfTDAHG9dhqg8FtyVOfHHRAgA1KcLvTkSbx
         brGkC3g6jznoFgn+ZZVcL1O2r7QUnJ3fs4cSvijx+HJjQcrY95v07Qo6jWrumU8DhEl/
         dzPw==
X-Gm-Message-State: AOJu0YzynPQJJxKdIGk5t0he3sWr9tBfih1Xy3H4Fty7nB7JskwpDOAF
        TgJltwsR2Gy3cCCaxW0EukCOoA==
X-Google-Smtp-Source: AGHT+IEaGkeBo+UEUY8AsPDzyVfUc1LI0L2Es4YLkSDx3om/sns505iK7K51Rnc6Z+vKfYjClRej/Q==
X-Received: by 2002:a05:600c:2299:b0:403:9b7:a720 with SMTP id 25-20020a05600c229900b0040309b7a720mr3942992wmf.1.1694861633854;
        Sat, 16 Sep 2023 03:53:53 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id z20-20020a7bc7d4000000b003feae747ff2sm9900743wmk.35.2023.09.16.03.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Sep 2023 03:53:53 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH net 0/5] mptcp: fix stalled connections
Date:   Sat, 16 Sep 2023 12:52:44 +0200
Message-Id: <20230916-upstream-net-20230915-mptcp-hanging-conn-v1-0-05d1a8b851a8@tessares.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPyIBWUC/z2NywqDMBBFf0Vm7UAe1NeviIs0He0sHEMSS0H89
 6YuXJ4L59wDEkWmBEN1QKQPJ96kgK4r8G8nCyG/CoNRxqpeP3APKUdyKwplvNc1ZB/wL7As6Dc
 RVI3qre2eujUdlFyINPP3uhqhyDCd5w9FK11VfwAAAA==
To:     mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Davide Caratti <dcaratti@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        stable@vger.kernel.org
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1934;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=Qibb+XUG3Fu5XjpF54vZjeB9fuXW430sjfoEwViSqns=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlBYlAmJev8waCdAk/HQ4mawHPUUqTslGS/EMGx
 HFwgFDm9aOJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZQWJQAAKCRD2t4JPQmmg
 c10dEADHm11WwquREihNaEZRxVI4RRl2js578WKR9JZcqmezDjdgPplnVNVpoue7dPM/Bi2PEx/
 11Zfs7E3/oZKZQqp8bmHYIUrriTON8aLVCck+TODLiAvvQzMJcBrELpdQP279PcSNWUpzHrDzNZ
 Dk0iYs/el2szXTp3dJi3PVW1KQGibEzAy8YGvnXdvKRUOV5S2lPBPEuRA/XRJlwUs6vFFuPfowe
 Ef80nyrbn08eGgT45DnJ2UBilgOxKP5zuFHvJ4Ik3K10W6wa7IPnvaKobQPaCByV7e57petq7Ww
 HbZMbzoXyhJqVXTRr06hy8b/G8tp57fzPDDWs5SLkYI+i8a9TV166eIjRnpsEaS4M184G1LaxnG
 rfbNrdbrj+yL8EClR5qXdPnPfRGnHgCMMoHVvF29uAX1B7qjfcefoF2Ehy0wRSpZcYhjyosVRf2
 f9btUL/sbOvZLPL1Cq7QwBfCANDYMcl86hRqFSi+7+XyoRltbaiJa1aHdzExWP2jZd27NBM4nsZ
 DacKWknb/Z/wjVToRDlCt08zjObRXjXmGWxjwQuHs7OCklWVNesfuqnxTH8jxEtHJwCKbyFOVce
 HEINmL2Hx10EsrSyDcQKQMH0WbTtqHWkIMpP9E6rw7ZTACV+jUnyWCdRWPBVpwx4wigLIaLRXps
 rO8r4imsJOL/+zg==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Daire reported a few issues with MPTCP where some connections were
stalled in different states. Paolo did a great job fixing them.

Patch 1 fixes bogus receive window shrinkage with multiple subflows. Due
to a race condition and unlucky circumstances, that may lead to
TCP-level window shrinkage, and the connection being stalled on the
sender end.

Patch 2 is a preparation for patch 3 which processes pending subflow
errors on close. Without that and under specific circumstances, the
MPTCP-level socket might not switch to the CLOSE state and stall.

Patch 4 is also a preparation patch for the next one. Patch 5 fixes
MPTCP connections not switching to the CLOSE state when all subflows
have been closed but no DATA_FIN have been exchanged to explicitly close
the MPTCP connection. Now connections in such state will switch to the
CLOSE state after a timeout, still allowing the "make-after-break"
feature but making sure connections don't stall forever. It will be
possible to modify this timeout -- currently matching TCP TIMEWAIT value
(60 seconds) -- in a future version.

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
Paolo Abeni (5):
      mptcp: fix bogus receive window shrinkage with multiple subflows
      mptcp: move __mptcp_error_report in protocol.c
      mptcp: process pending subflow error on close
      mptcp: rename timer related helper to less confusing names
      mptcp: fix dangling connection hang-up

 net/mptcp/options.c  |   5 +-
 net/mptcp/protocol.c | 165 +++++++++++++++++++++++++++++++--------------------
 net/mptcp/protocol.h |  24 +++++++-
 net/mptcp/subflow.c  |  39 +-----------
 4 files changed, 130 insertions(+), 103 deletions(-)
---
base-commit: 615efed8b63f60ddd69c0b8f32f7783859034fc2
change-id: 20230915-upstream-net-20230915-mptcp-hanging-conn-0609338b1728

Best regards,
-- 
Matthieu Baerts <matthieu.baerts@tessares.net>

