Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3876E7CE9A1
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 23:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344718AbjJRU7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 16:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344766AbjJRU7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 16:59:11 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C515AD7F
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 13:58:50 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-4084095722aso6205335e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 13:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1697662729; x=1698267529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yQBllu3Ykjk7R9nnF+2uSCxMiVr14uA0qq+2C/piekk=;
        b=K/ByiLnrE4q8I6cyjNleXVcLHSHTNijuCgw/61AruP2K4Fd1N0IU7dy9L/jcbKaIDu
         9fT0rFHyqcjw6HSkLpxUPUBEtc5195OOuEtAVKqWERHvZ1rtDamxBRphdGzlRvMK2QkK
         mpl/7fEzYzWnWyADdXe0aI3lt1hz2E18f6hRk60Xe33uDBo/K/7SkjzBlsRvkn1CzUWy
         OfITxcBUzlJNSpa6AeEwSZwfJ8iuKeKMjWFYqpFbeacW9dKuiApH1WuZFYZnSoSCJvoZ
         bUidtyva9qUsrLJcbX4OqQogCnO9gg6LzTM4IaeMO12sjX4TNJ87NZn/kc3Yp6ATfSk0
         SNuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697662729; x=1698267529;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yQBllu3Ykjk7R9nnF+2uSCxMiVr14uA0qq+2C/piekk=;
        b=SYJbVNK0R+ZeQhPBdcYGOYoidSQ9zIuL2zEVu132Ou7DXBPkmzbZruLm41eTD4Wszf
         ScHhx/sLpQMPDZQjUtRq2DotuotgyBoXeqkjgxCuyvEahG2/Ru+qx1sSvgeBPDuHFW7W
         dIC4qRql/I/XUBllen4POK/k3Q4Vs6muPedNCAHrkbLUL9W9+msntcZ/4d88j9KA2hlr
         63XM4O/SZ/FZvXy9I9mnlCndjD0a0eQwElpumKdjDs7TaJMwTHcfry1e5R/u+Fcxwao+
         pJrBWBPLxSE9psNgQ5+H+fouBinFh9B40TC/+M3GPiLMy1nwPXjrT2Y8LVNFmoq/ZHFc
         MoqA==
X-Gm-Message-State: AOJu0YxY630/CcoF9NyjFcFW7iDxo8R+aJh/W5p6sULbxD1pXRCwtRUR
        z1DfJuIikfwa/Z6DoQl1NmEnDQ==
X-Google-Smtp-Source: AGHT+IEhF2Y0JDq8MMDsi++YlFQlZuxD4lTalKe6Mm2cBfBKacHPHM2hLbAiO40aYmF3jtSoSmXbSg==
X-Received: by 2002:a05:600c:5254:b0:407:8e68:4a5b with SMTP id fc20-20020a05600c525400b004078e684a5bmr356636wmb.38.1697662728836;
        Wed, 18 Oct 2023 13:58:48 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id x19-20020a05600c421300b003fc16ee2864sm2569006wmh.48.2023.10.18.13.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 13:58:48 -0700 (PDT)
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
        Simon Horman <horms@kernel.org>,
        "Tetreault, Francois" <ftetreau@ciena.com>, netdev@vger.kernel.org
Subject: [PATCH v15 net-next 17/23] net/tcp: Add option for TCP-AO to (not) hash header
Date:   Wed, 18 Oct 2023 21:57:31 +0100
Message-ID: <20231018205806.322831-18-dima@arista.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231018205806.322831-1-dima@arista.com>
References: <20231018205806.322831-1-dima@arista.com>
MIME-Version: 1.0
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

Provide setsockopt() key flag that makes TCP-AO exclude hashing TCP
header for peers that match the key. This is needed for interraction
with middleboxes that may change TCP options, see RFC5925 (9.2).

Co-developed-by: Francesco Ruggeri <fruggeri@arista.com>
Signed-off-by: Francesco Ruggeri <fruggeri@arista.com>
Co-developed-by: Salam Noureddine <noureddine@arista.com>
Signed-off-by: Salam Noureddine <noureddine@arista.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
Acked-by: David Ahern <dsahern@kernel.org>
---
 include/uapi/linux/tcp.h | 5 +++++
 net/ipv4/tcp_ao.c        | 8 +++++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/tcp.h b/include/uapi/linux/tcp.h
index e4ddca6178ca..7b9762ab4df8 100644
--- a/include/uapi/linux/tcp.h
+++ b/include/uapi/linux/tcp.h
@@ -366,6 +366,11 @@ struct tcp_diag_md5sig {
 #define TCP_AO_MAXKEYLEN	80
 
 #define TCP_AO_KEYF_IFINDEX	(1 << 0)	/* L3 ifindex for VRF */
+#define TCP_AO_KEYF_EXCLUDE_OPT	(1 << 1)	/* "Indicates whether TCP
+						 *  options other than TCP-AO
+						 *  are included in the MAC
+						 *  calculation"
+						 */
 
 struct tcp_ao_add { /* setsockopt(TCP_AO_ADD_KEY) */
 	struct __kernel_sockaddr_storage addr;	/* peer's address for the key */
diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
index 223af5c9eaf3..10cc6be4d537 100644
--- a/net/ipv4/tcp_ao.c
+++ b/net/ipv4/tcp_ao.c
@@ -562,7 +562,8 @@ int tcp_ao_hash_hdr(unsigned short int family, char *ao_hash,
 		WARN_ON_ONCE(1);
 		goto clear_hash;
 	}
-	if (tcp_ao_hash_header(&hp, th, false,
+	if (tcp_ao_hash_header(&hp, th,
+			       !!(key->keyflags & TCP_AO_KEYF_EXCLUDE_OPT),
 			       ao_hash, hash_offset, tcp_ao_maclen(key)))
 		goto clear_hash;
 	ahash_request_set_crypt(hp.req, NULL, hash_buf, 0);
@@ -610,7 +611,8 @@ int tcp_ao_hash_skb(unsigned short int family,
 		goto clear_hash;
 	if (tcp_ao_hash_pseudoheader(family, sk, skb, &hp, skb->len))
 		goto clear_hash;
-	if (tcp_ao_hash_header(&hp, th, false,
+	if (tcp_ao_hash_header(&hp, th,
+			       !!(key->keyflags & TCP_AO_KEYF_EXCLUDE_OPT),
 			       ao_hash, hash_offset, tcp_ao_maclen(key)))
 		goto clear_hash;
 	if (tcp_sigpool_hash_skb_data(&hp, skb, th->doff << 2))
@@ -1454,7 +1456,7 @@ static struct tcp_ao_info *setsockopt_ao_info(struct sock *sk)
 	return ERR_PTR(-ESOCKTNOSUPPORT);
 }
 
-#define TCP_AO_KEYF_ALL		(0)
+#define TCP_AO_KEYF_ALL		(TCP_AO_KEYF_EXCLUDE_OPT)
 
 static struct tcp_ao_key *tcp_ao_key_alloc(struct sock *sk,
 					   struct tcp_ao_add *cmd)
-- 
2.42.0

