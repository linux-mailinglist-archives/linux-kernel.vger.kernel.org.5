Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2894E7D458F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 04:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232105AbjJXCfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 22:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232023AbjJXCfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 22:35:40 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E197A10C9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 19:35:34 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-41cc75c55f0so40937551cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 19:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1698114934; x=1698719734; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+gVTnJsyvkPl/EqbN7quO86+jwMpzGyV8aZcsQmMn3o=;
        b=AptnH0WZ0QYy0jCnG3Thqw16AK5RZ9P9sYgenUhjImzFJoV+yLJF9msUGUWeTMqp8K
         Bqf21YrgqoPWuWNNO/JCE+RhfR4N9Rm+8mC3S11H1o5s1YCMdh2AJNWIt9tVlSr1/uOn
         f6ByLRNTfZ8KwZ8cW4SaucuWhHP8yuiKrTBf1xk7d32iyzU3B0lvToNPrPmR2wS2NCPA
         DUZngWEHAYVpUlP3UkLH+Ms9cpdfKxruFeKpm9odGImG1EWfAaby/JoIF922JlHldSsh
         vZty9D0kZF3041uHLiyQYH62jtNVxZVnX6DRswgq4lBGsT6VLJSSgBRvphZaVkoJ0WEP
         DCKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698114934; x=1698719734;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+gVTnJsyvkPl/EqbN7quO86+jwMpzGyV8aZcsQmMn3o=;
        b=eRM7rQIKtAnvputXcnRTd+wE6uiq5Xzd9v81fv5wnSKV/K+Euc6RZ64/SYosOm+59c
         MCRhNJEyioAHS4rNKGzi1nVS1q/cbu5vMKWj/1xwqkWdEpimcQn8VJZajIhc3kA1L52M
         tUk54kS5quLdUJ+gd6yU+qbcL46BspY8syK/r3BdOTSmvtXQzha0xdcCK3PRtMgD+7/u
         ooHVIM7ONBJGiW/1DBkPygtIOVZguW0nvDEBsgfxVBvWOzUCE/G1kNzk8lWCxH82W16r
         8sa9qTqoOGd79v6d5WM0+wR+HzNyt1NpOd6sDHXMP+7IYqmiDD39ERXHomoniOEvw12g
         Aflg==
X-Gm-Message-State: AOJu0YxbuWGe1DF6tnVEsuT5XyCCkZuYH6nXaMX1EbAbc9FB/fYCHEnq
        dPXePY4KYmn/aBwbH/eBgXCnlr4DXeput19PbG939w==
X-Google-Smtp-Source: AGHT+IGTvcuBeDlMgkhzLj8lqGBgnlFB3pqQpnKuhTsP6Qer6RrLCbnVYfYNForjrvIxfAUhjOFU8Q==
X-Received: by 2002:ac8:5a54:0:b0:403:abf5:6865 with SMTP id o20-20020ac85a54000000b00403abf56865mr15110377qta.18.1698114933933;
        Mon, 23 Oct 2023 19:35:33 -0700 (PDT)
Received: from debian.debian ([140.141.197.139])
        by smtp.gmail.com with ESMTPSA id kr25-20020ac861d9000000b004181c32dcc3sm3144313qtb.16.2023.10.23.19.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 19:35:33 -0700 (PDT)
Date:   Mon, 23 Oct 2023 19:35:32 -0700
From:   Yan Zhai <yan@cloudflare.com>
To:     netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Aya Levin <ayal@nvidia.com>,
        Tariq Toukan <tariqt@nvidia.com>, linux-kernel@vger.kernel.org,
        kernel-team@cloudflare.com, Florian Westphal <fw@strlen.de>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Alexander H Duyck <alexander.duyck@gmail.com>
Subject: [PATCH v4 net-next 0/3] ipv6: avoid atomic fragment on GSO output
Message-ID: <cover.1698114636.git.yan@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the ipv6 stack output a GSO packet, if its gso_size is larger than
dst MTU, then all segments would be fragmented. However, it is possible
for a GSO packet to have a trailing segment with smaller actual size
than both gso_size as well as the MTU, which leads to an "atomic
fragment". Atomic fragments are considered harmful in RFC-8021. An
Existing report from APNIC also shows that atomic fragments are more
likely to be dropped even it is equivalent to a no-op [1].

The series contains following changes:
* drop feature RTAX_FEATURE_ALLFRAG, which has been broken. This helps
  simplifying other changes in this set.
* refactor __ip6_finish_output code to separate GSO and non-GSO packet
  processing, mirroring IPv4 side logic.
* avoid generating atomic fragment on GSO packets.

Link: https://www.potaroo.net/presentations/2022-03-01-ipv6-frag.pdf [1]

change log:
V3 -> V4: cleaned up all RTAX_FEATURE_ALLFRAG code, rather than just
drop the check at IPv6 output.
V2 -> V3: split the changes to separate commits as Willem de Bruijn suggested
V1 is incorrect and omitted

V3: https://lore.kernel.org/netdev/cover.1697779681.git.yan@cloudflare.com/
V2: https://lore.kernel.org/netdev/ZS1%2Fqtr0dZJ35VII@debian.debian/

Yan Zhai (3):
  ipv6: drop feature RTAX_FEATURE_ALLFRAG
  ipv6: refactor ip6_finish_output for GSO handling
  ipv6: avoid atomic fragment on GSO packets

 include/net/dst.h                  |  7 -----
 include/net/inet_connection_sock.h |  1 -
 include/net/inet_sock.h            |  2 +-
 include/uapi/linux/rtnetlink.h     |  2 +-
 net/ipv4/tcp_output.c              | 20 +------------
 net/ipv6/ip6_output.c              | 45 ++++++++++++++++--------------
 net/ipv6/tcp_ipv6.c                |  1 -
 net/ipv6/xfrm6_output.c            |  2 +-
 net/mptcp/subflow.c                |  1 -
 9 files changed, 28 insertions(+), 53 deletions(-)

-- 
2.30.2


