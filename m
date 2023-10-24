Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4F37D53F5
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 16:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343735AbjJXO0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 10:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343524AbjJXO0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 10:26:35 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26D98F
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 07:26:33 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-66d13ac2796so28109846d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 07:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1698157593; x=1698762393; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HSkD7qLJMOj3J00NGcykYcTjPHnf3wlBQzh0/FoSFS4=;
        b=FonKB+paqvcJd3aVuqUZ+DevZ/ju7KgsAyiFti5qWAKKk+pIspKJHAt+VmB9+TR+e3
         b3PpYYT+SeXQzIkU81+kDj62AQt3o320/Y2tYt8AsChGLQ8gMBB3U2Q4Rx2zY9HY0vM7
         qSupfNWy5VBNU0ydV9brylYzcOL/rULFNdIXs/1Eda4n/asAKTypg4cA0J96uw1A89Kd
         1mycTcY/dX5c+xNytOcYy/OmZ42s5vi5HYt0SnWGnx2guiTFCmgqG4tQVnx7ri508m+7
         Dzkv0imnofKK1jCFF2KEIdx1X/vgKy+PV96B1zZYeZXoQObuNiz6UcI33NBaevNUG7yP
         vZrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698157593; x=1698762393;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HSkD7qLJMOj3J00NGcykYcTjPHnf3wlBQzh0/FoSFS4=;
        b=F9BtJyjkS5VdbRIS5/7XY1YgIjVbssEX78XKP3lGpWNEPm3IW9AluihC0m7b6Svz7Z
         vdbDuRtlOd9UWHcR8wJug1JGdBM5wgOfskVy5R1XNjV08FtNey8SOhPhpYEXkbuWPd5k
         pehgc+E6Ek5NV/0uhffO0VFgoiUjBS7y2aodik8GekOnQXFpExi5Kqchm6XOEEh2eQTQ
         H6Zb/NbRyGMGGoF+FN4eEAHrdhLtDqz4O95mN4hE3jcF37BjRY+OrHaCfrkaQsomfjxx
         NReSvptujIIaL72xxB+OvuqRuMDFggSaPYvH8jxcj7sLHSHsoN57nqIwa/rA90xWEsrR
         NhBw==
X-Gm-Message-State: AOJu0YyugP2EIFPKzdi3QvWZ1Y5DqSGQtPaicIRqbGJCiDLiyttfLEeG
        RFDof6zX7KTzA2kd87gQ5UXSDg==
X-Google-Smtp-Source: AGHT+IEe+TEGePA52UECB7U2kmO8POiVcE6AKJVynAW93jmiSs63kLXqKS6YPGva2vriS+ablYsZ3A==
X-Received: by 2002:a05:6214:230f:b0:66d:62b7:53f4 with SMTP id gc15-20020a056214230f00b0066d62b753f4mr14290057qvb.45.1698157592853;
        Tue, 24 Oct 2023 07:26:32 -0700 (PDT)
Received: from debian.debian ([140.141.197.139])
        by smtp.gmail.com with ESMTPSA id e20-20020ad442b4000000b0065d1380dd17sm3598217qvr.61.2023.10.24.07.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 07:26:32 -0700 (PDT)
Date:   Tue, 24 Oct 2023 07:26:28 -0700
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
Subject: [PATCH v5 net-next 0/3] ipv6: avoid atomic fragment on GSO output
Message-ID: <cover.1698156966.git.yan@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
V4 -> V5: minor fixup
V3 -> V4: cleaned up all RTAX_FEATURE_ALLFRAG code, rather than just
drop the check at IPv6 output.
V2 -> V3: split the changes to separate commits as Willem de Bruijn suggested
V1 is incorrect and omitted

V4: https://lore.kernel.org/netdev/cover.1698114636.git.yan@cloudflare.com/
V3: https://lore.kernel.org/netdev/cover.1697779681.git.yan@cloudflare.com/
V2: https://lore.kernel.org/netdev/ZS1%2Fqtr0dZJ35VII@debian.debian/

Yan Zhai (3):
  ipv6: drop feature RTAX_FEATURE_ALLFRAG
  ipv6: refactor ip6_finish_output for GSO handling
  ipv6: avoid atomic fragment on GSO packets

 include/net/dst.h                  |  7 -----
 include/net/inet_connection_sock.h |  1 -
 include/net/inet_sock.h            |  1 -
 include/uapi/linux/rtnetlink.h     |  2 +-
 net/ipv4/tcp_output.c              | 20 +------------
 net/ipv6/ip6_output.c              | 45 ++++++++++++++++--------------
 net/ipv6/tcp_ipv6.c                |  1 -
 net/ipv6/xfrm6_output.c            |  2 +-
 net/mptcp/subflow.c                |  1 -
 9 files changed, 27 insertions(+), 53 deletions(-)

-- 
2.30.2


