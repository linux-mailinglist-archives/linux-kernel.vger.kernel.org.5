Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7384C779397
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 17:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236691AbjHKP6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 11:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbjHKP6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 11:58:44 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2272C2723
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 08:58:43 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fe4a89e8c4so19137145e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 08:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1691769521; x=1692374321;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B5z06Yt1CFJHs1YhwMNSjlQXmAuLI6Alb07sLJpaCQI=;
        b=xJCN6775UE2xvvdCfcU9nxL8IDOi2W7BPOlO8cfLITsY10Jl4lYn9tzLh1ApTrqUK6
         7+XCKLhY2ktBeLPphniupoolGUs+/dfWQs/qEg2Q3hkIvtKhIVDnTumyt8MH62r7fpZR
         w2f6BIq2Je1kuHlo1d6GxtGgtHpqD30uYrS2tn2t3VHEIHWf1ZE1QjGXOCjGTv9JKJyD
         AmpUxdSRJ6nau3FOBxSa/nXd6exE9gjNVBeKRO71+StNZGdYJlVKqsZ7lBlytoL3kKEf
         RsCj9pE8E0O6AmTZoiXYFYaVsuapbkbE9Tk10e5orWkHzSLsKzkO8V86OFAyb0EjgPNh
         FUHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691769521; x=1692374321;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B5z06Yt1CFJHs1YhwMNSjlQXmAuLI6Alb07sLJpaCQI=;
        b=WbAu2fBCZyItH66lfwGIro3qKMclixvK22acd1Nm+X36oxNrW5zyFd5DHl9VTIXtSj
         x875O2WT8iR0CDpeMrp5NAvEM5b8cAO6jFsq5ZgV1jOPwBHmaJJ77RDm3c389I1MxhRa
         wBFuM+Fa1x1fDCHWr7lSzgXLQq0oIr+EuITn1zC2hvbDek7VCVAtjDNWQc9zCSFmvxxl
         twBqz0Qk6Bm0va5b4ViDXdWkz20894kzenx8spA5gdD6ungxxj39H0MiStc+TtTPC23u
         m8WHhltaFokFmV2PgTzK+2J8B8Z2cb4yGvspQz9VlpZCyHukWa/Ec3e7pxOrZ2to2Oad
         MPuQ==
X-Gm-Message-State: AOJu0Yx+ZF6NOkDBepkA8RiqkdJAbXS/bn700Q2/zYR7WGlZM7SI66JI
        IHozrWzx0gxJuVKcj6p9blHmIw==
X-Google-Smtp-Source: AGHT+IEKCxJXBwUq8BP8z2yfXnYXNYMrJNqbAG3zTrUi+N5aZg4YJiB5Hcu+SF9qIea5qmqKF6HLoA==
X-Received: by 2002:adf:ff92:0:b0:317:ed01:dc48 with SMTP id j18-20020adfff92000000b00317ed01dc48mr1750655wrr.9.1691769520997;
        Fri, 11 Aug 2023 08:58:40 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id m12-20020a5d4a0c000000b00317e9c05d35sm5834308wrq.85.2023.08.11.08.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 08:58:40 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: [PATCH net-next 00/14] mptcp: get rid of msk->subflow
Date:   Fri, 11 Aug 2023 17:57:13 +0200
Message-Id: <20230811-upstream-net-next-20230811-mptcp-get-rid-of-msk-subflow-v1-0-36183269ade8@tessares.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFla1mQC/z2NzQrCMBCEX6Xs2YWmIlhfRTyk2U1dND9kUy2Uv
 rtB0MMcvhn4ZgPlIqxw6TYo/BKVFBuYQwfubuPMKNQYhn449mdjcMlaC9uAkWvLWvE/hVxdxrn
 1RQiTx6AP1GXyz/TG0ZI5ORoduQmaPRf2sn6fr/BzwW3fP33tXeCTAAAA
To:     mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        David Ahern <dsahern@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Kuniyuki Iwashima <kuniyu@amazon.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2949;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=FAB0/54LiYDvSFBl1VEoMwafatQAJWGC5dSIRjB6s/8=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBk1lquKusHro9FD9KnIi/TEocqWKA86oGQaU2T9
 Frb0jaMRsuJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZNZargAKCRD2t4JPQmmg
 c4cpEAClCe5ahldku+Tc2o7NA4ES2GkoMV+nz0drxdGqRRWfzsdUje8EnyFcHs7XNSfWI5el+5v
 r24QOzS6KvGLCOaDHl8zlrC+rBBPMIDZgs5Zbh0xDMEWWm3fLxwqD1r492lAsQbbTOnHSc5aVNg
 1uceNkDi3rtsh+eWVXL8FFJGy9C8HifkUzlLuBfnZ28xi9kDHjb7Ri7E+MJcW5KsX4wk0YqR0S6
 XaPt/1GRxDhcXQXrjBkcBdfb2azClEbmx+yhl/XS/5Ncd/Tl8qngTSDizSU+LGg+HwGEf+/AdSE
 o008ZCzKRntucdRqqwsBTihH9SClJIcxH3IfR52oYLPZHCsjdl7y1c+K0gM33Z6rqcYzBmepMEE
 u9rOF1VokLKIXWeY+zP1V57KoCWOSgxaYoH4AaZyQVmNFV/8TOZFhFXEs2gwcfsZcV9ngLAwVFx
 3R3rHN608AaqQZWnOEoxLGw874MArmFcINXH6zO/kus1YtpEirv5y2TVTY8I/fjw25+hVHBOeXa
 JIFT2SiCc0l9J6+6aas4YauAHJdq39fCMV35zzRnDS0NkPcQx8RERu/KV8O/2C3s7o2Few0I13P
 pv8HkKWx7vQx1QoBDkggmGDG9HCnU0go4AIU/mR/hcM2VDj+UsqeVxluAHmu/y+mlLwpDKeZK7Y
 lO+60jixOsH9bUQ==
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

The MPTCP protocol maintains an additional struct socket per connection,
mainly to be able to easily use tcp-level struct socket operations.

This leads to several side effects, beyond the quite unfortunate /
confusing 'subflow' field name:

- active and passive sockets behaviour is inconsistent: only active ones
  have a not NULL msk->subflow, leading to different error handling and
  different error code returned to the user-space in several places.

- active sockets uses an unneeded, larger amount of memory

- passive sockets can't successfully go through accept(), disconnect(),
  accept() sequence, see [1] for more details.

The 13 first patches of this series are from Paolo and address all the
above, finally getting rid of the blamed field:

- The first patch is a minor clean-up.

- In the next 11 patches, msk->subflow usage is systematically removed
  from the MPTCP protocol, replacing it with direct msk->first usage,
  eventually introducing new core helpers when needed.

- The 13th patch finally disposes the field, and it's the only patch in
  the series intended to produce functional changes.

The last and 14th patch is from Kuniyuki and it is not linked to the
previous ones: it is a small clean-up to get rid of an unnecessary check
in mptcp_init_sock().

[1] https://github.com/multipath-tcp/mptcp_net-next/issues/290

Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
Kuniyuki Iwashima (1):
      mptcp: Remove unnecessary test for __mptcp_init_sock()

Paolo Abeni (13):
      mptcp: avoid unneeded mptcp_token_destroy() calls
      mptcp: avoid additional __inet_stream_connect() call
      mptcp: avoid subflow socket usage in mptcp_get_port()
      net: factor out inet{,6}_bind_sk helpers
      mptcp: mptcp: avoid additional indirection in mptcp_bind()
      net: factor out __inet_listen_sk() helper
      mptcp: avoid additional indirection in mptcp_listen()
      mptcp: avoid additional indirection in mptcp_poll()
      mptcp: avoid unneeded indirection in mptcp_stream_accept()
      mptcp: avoid additional indirection in sockopt
      mptcp: avoid ssock usage in mptcp_pm_nl_create_listen_socket()
      mptcp: change the mpc check helper to return a sk
      mptcp: get rid of msk->subflow

 include/net/inet_common.h |   2 +
 include/net/ipv6.h        |   1 +
 net/ipv4/af_inet.c        |  46 ++++++-----
 net/ipv6/af_inet6.c       |  10 ++-
 net/mptcp/pm_netlink.c    |  30 +++----
 net/mptcp/protocol.c      | 194 ++++++++++++++++++++++------------------------
 net/mptcp/protocol.h      |  15 ++--
 net/mptcp/sockopt.c       |  65 ++++++++--------
 8 files changed, 186 insertions(+), 177 deletions(-)
---
base-commit: 80f9ad046052509d0eee9b72e11d0e8ae31b665f
change-id: 20230811-upstream-net-next-20230811-mptcp-get-rid-of-msk-subflow-9ad15cd9cdcb

Best regards,
-- 
Matthieu Baerts <matthieu.baerts@tessares.net>

