Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA17753225
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 08:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232059AbjGNGkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 02:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233975AbjGNGkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 02:40:08 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EECB2D5F;
        Thu, 13 Jul 2023 23:40:07 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-666eef03ebdso1008691b3a.1;
        Thu, 13 Jul 2023 23:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689316807; x=1691908807;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nq4AlzIUYH74DwmP1AytKvtmR3itDA2LKj6kldjoWZU=;
        b=Isnpl4d5csD+Aw1s1azsAEeue2LVPzDM371sqUNpQhontnLuOCkx6NHelmtJgSlxno
         oSqv8mKM9rZP9r9rx6F1ae+YnpqVB8wu/jzFkYNrCovFImrCkCwaz/yS6ZL6PMSzTjok
         rKkU+HB/14IIa1qaKIBgAwljAvSuFSwGbBMXKdiV7ZuV5vTuInpjmJja+rPQtxaAKVgR
         tVF5HC9BBB6FAp90L3XazivDj1QkHUQVEEMCm4MWguvjd2bFNlsWOCEC1+bHCSt7+vbj
         v1YK0fj7mWBbmMVjoFRGJ2AyG2N2dR+uryOMeu7RQ8evtO4oahx0D6DI1H5gPB6+eXBn
         GDCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689316807; x=1691908807;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nq4AlzIUYH74DwmP1AytKvtmR3itDA2LKj6kldjoWZU=;
        b=Fke493LHADl60xAWcMgrvl0h1NJN+nqzddiw3BTAw+TRheNTyBHIn1yUk8DDELNui+
         Anlm0otKZaEEFVomIcl27he1t2zGJah4Uc21dob4wa6qtvF9PFsaotLHfFq128mPcov7
         mJmfkW1UZHKGFZACDzo7SFhYxCrdqA7LxiN7frTCXeC4wVpQtfzGLaMg7qbpideK2njL
         tjwms20BPzgl576IsJMe3c0JHbXAEqGoIr4/uFI5Lyzc6ECBWQRcQ9fospRJom9DY5D8
         giT4lO1DoquucX3mOLqPVP/Yyrk2Z4ZMMOL9vGZ+LcyaBPdQrckNRJK03YGOtV/3o5HF
         YtsA==
X-Gm-Message-State: ABy/qLbNXHdhWHu5/m/Qh5AjCDXzg1A8cWLyvLK4Xw/geVfwzLFju1pT
        +0gURRfSEFKd3lgsKm6vVJw=
X-Google-Smtp-Source: APBJJlG9n6m+b2RmRfHQoTbrXXIPC84zw9M8gNUwTmGMbWoFBAKOO3sl8nWYLCmlyD9N2H+oHttvIw==
X-Received: by 2002:a05:6a00:b47:b0:653:de9a:d933 with SMTP id p7-20020a056a000b4700b00653de9ad933mr3505236pfo.17.1689316806795;
        Thu, 13 Jul 2023 23:40:06 -0700 (PDT)
Received: from localhost.localdomain ([159.196.197.79])
        by smtp.gmail.com with ESMTPSA id h21-20020a62b415000000b0067b24701daasm6358986pfn.86.2023.07.13.23.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 23:40:06 -0700 (PDT)
From:   Jamie Bainbridge <jamie.bainbridge@gmail.com>
To:     "David S. Miller" <davem@davemloft.net>,
        David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Jamie Bainbridge <jamie.bainbridge@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] tcp: Add memory pressure flag to sockstat
Date:   Fri, 14 Jul 2023 16:39:53 +1000
Message-ID: <a35a5881c3280bd7a4fd1943a8b40b890e3bf280.1689316697.git.jamie.bainbridge@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When tuning a system it can be helpful to know whether the protocol is
in memory pressure state or not. This can be determined by corresponding
the number of pages in "net.ipv4.tcp_mem" with the current allocation,
but a global variable already tracks this as the source of truth.

Expose that variable in sockstat where other protocol memory usage is
already reported.

Add "pressure" which is 0 in normal state and 1 under pressure:

 # grep TCP /proc/net/sockstat
 TCP: inuse 5 orphan 0 tw 0 alloc 7 mem 1 pressure 0

 # grep TCP /proc/net/sockstat
 TCP: inuse 5 orphan 0 tw 0 alloc 7 mem 1 pressure 1

Tested by writing a large value to global variable tcp_memory_pressure
(it usually stores jiffies when memory pressure was entered) and not
just by code review or editing example output.

Signed-off-by: Jamie Bainbridge <jamie.bainbridge@gmail.com>
---
 net/ipv4/proc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/proc.c b/net/ipv4/proc.c
index eaf1d3113b62f7dc93fdc7b7c4041140ac63bf69..f4c5ced2de49d5c6d7f5d7ccdaa76c89dcf8c932 100644
--- a/net/ipv4/proc.c
+++ b/net/ipv4/proc.c
@@ -51,16 +51,17 @@
 static int sockstat_seq_show(struct seq_file *seq, void *v)
 {
 	struct net *net = seq->private;
-	int orphans, sockets;
+	int orphans, sockets, tcp_pressure;
 
 	orphans = tcp_orphan_count_sum();
 	sockets = proto_sockets_allocated_sum_positive(&tcp_prot);
+	tcp_pressure = READ_ONCE(tcp_memory_pressure) ? 1 : 0;
 
 	socket_seq_show(seq);
-	seq_printf(seq, "TCP: inuse %d orphan %d tw %d alloc %d mem %ld\n",
+	seq_printf(seq, "TCP: inuse %d orphan %d tw %d alloc %d mem %ld pressure %d\n",
 		   sock_prot_inuse_get(net, &tcp_prot), orphans,
 		   refcount_read(&net->ipv4.tcp_death_row.tw_refcount) - 1,
-		   sockets, proto_memory_allocated(&tcp_prot));
+		   sockets, proto_memory_allocated(&tcp_prot), tcp_pressure);
 	seq_printf(seq, "UDP: inuse %d mem %ld\n",
 		   sock_prot_inuse_get(net, &udp_prot),
 		   proto_memory_allocated(&udp_prot));
-- 
2.41.0

