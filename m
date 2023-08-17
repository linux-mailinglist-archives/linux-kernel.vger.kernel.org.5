Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0DA77FFA3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 23:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355214AbjHQVPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 17:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355207AbjHQVPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 17:15:37 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000BD35B3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 14:15:34 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1bf092a16c9so2312165ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 14:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692306934; x=1692911734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A6pRzVAL1HfaFk+MrN35IOTXl1yUajrA5beAIZxFLLg=;
        b=MyltMusNWYrHHduM59ZY3KVk2F109y3Pp1ImvclhC5uVVFlNLd85wpLi5oUy/yS5VG
         ZFFcJApAMPM4nChjoYVKU7Y6Oh7sZaTnMWVh6YYIKI0/wWuJfWBrRxdnsHBmTTqccdY7
         /Ns8/4aEaQBWWwnFK+vLM7Ur9D5iHCixdohfk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692306934; x=1692911734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A6pRzVAL1HfaFk+MrN35IOTXl1yUajrA5beAIZxFLLg=;
        b=YMhh1LyOy/KjJZr5LRthDv0yPMrvI/+3Fe1yLWOhbU+zxosJfDejScYPpwN5QxN5rZ
         raEKP9cSAk0t9G5D3xuNgGdqD97qIJfs06AUD2AYiA2gZuo7vNc0W5L5u7Sxk1RBRd/T
         NQq+AXEYYGNKQk6Udc3b9VpgOHvDZC2Mou6g6zA5s8/zXELkzRKlSpBZuAIfdzQtTxrg
         QOloqKrF8HYppO5wBmPbJ3KQY271s00CXVv9QdHEZjRfHttjGtPxIdDscYm93haf6wZM
         xj2KadLDygV0iDILZLQ5Vn/ePoNt1X6EO/S4i+OnB4Bm2QSQ9OlgU++fcT6hfEwLZQdz
         L/ug==
X-Gm-Message-State: AOJu0YyDwDKgoIfFGolJe6oauS9EBQQkJBaS/BS6j7XDIqAbnrz8CU7M
        HHTcXbtrEE09ar5fVpXg6DeqSQ==
X-Google-Smtp-Source: AGHT+IHVjuRk1web/N5CIE6G3DSroLocgLnvFFM3Lfkq6agT4XiyPHhqIHZks3sie+eRrw9Rg6gakw==
X-Received: by 2002:a17:902:be03:b0:1bd:e85f:700e with SMTP id r3-20020a170902be0300b001bde85f700emr590833pls.69.1692306934435;
        Thu, 17 Aug 2023 14:15:34 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id jj20-20020a170903049400b001b9f7bc3e77sm208556plb.189.2023.08.17.14.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 14:15:32 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Kees Cook <keescook@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: [PATCH 4/7] wifi: cfg80211: Annotate struct cfg80211_pmsr_request with __counted_by
Date:   Thu, 17 Aug 2023 14:15:26 -0700
Message-Id: <20230817211531.4193219-4-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230817211114.never.208-kees@kernel.org>
References: <20230817211114.never.208-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2180; i=keescook@chromium.org;
 h=from:subject; bh=ytZuVuu89ZLCBsGHGYeK5Mrw8+wpGzwhqHz7UbWnFA8=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBk3o3x/0j3Sg2xlp/sAxt3CMimE1sDR90HXUPBB
 lc5GQBuZSuJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZN6N8QAKCRCJcvTf3G3A
 JnDCEACQDuHi5umP6pnbV1/6oqKWEuBYmNo/ZvDgqxNNQUELDL5Ta/5wtzf7XiiCeoll8eOLUCi
 P7ReHnkR5v3TpE40/l08pqvVD0Uhy7syN+4izs7Z/I2Tj6P9F7QPf1eIz9o+DGg+BoXpIz7+anZ
 deuiv+CQBw/qR3n+4ZutHmcdrJ6VXv7JPMxjVlKnPlKZ14LELqAVNYpqRb7GVT9mtCWYSUCzI/o
 q7pc8sXhIiGvqbhGEH1DHBwUsDaCJFyZU0deQ/4Wr6PjJmzm6VwT1/tCLXsJSOc/Bm0dZnJ50tF
 CrXF9Lu0muoI54sFAZ2aObdmUdx9cRs7vLwLMPMpORFSToSzsYuxcmfoe139MigExg96t0sqMjr
 15BXehaTyC/b1xov42tJ+E86o2aphkoRQy/CJfb+41Ab6Kxd881kUk5U5AQDaEzwFxO70DgRF9i
 AIBAQRxAKLNJiH/KfcqZ+dBL3eZFLiSraO9F/WymXLqEq+VLYAFI0NzWsbLSyYAxYakd3yyqocD
 rama7ffqboYN4fv1HznzYuerAjJ40SUp7OYKWNCrjOenDPT+r7wkghCV4iXQMjc7EOpL3oHq35H
 Lwq8T6EDWTvsH0OISgIGkXmXOFRctDiRJ1qka4z9zeAyOBEMvT3kscRRH+5HmFH3PAQoLms2mF6 tAQgs/hfx8leeZg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct cfg80211_pmsr_request.
Additionally, since the element count member must be set before accessing
the annotated flexible array member, move its initialization earlier.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/net/cfg80211.h | 2 +-
 net/wireless/pmsr.c    | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 5c7d091b3925..e9ca4726a732 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -3948,7 +3948,7 @@ struct cfg80211_pmsr_request {
 
 	struct list_head list;
 
-	struct cfg80211_pmsr_request_peer peers[];
+	struct cfg80211_pmsr_request_peer peers[] __counted_by(n_peers);
 };
 
 /**
diff --git a/net/wireless/pmsr.c b/net/wireless/pmsr.c
index 77000a264855..9611aa0bd051 100644
--- a/net/wireless/pmsr.c
+++ b/net/wireless/pmsr.c
@@ -291,6 +291,7 @@ int nl80211_pmsr_start(struct sk_buff *skb, struct genl_info *info)
 	req = kzalloc(struct_size(req, peers, count), GFP_KERNEL);
 	if (!req)
 		return -ENOMEM;
+	req->n_peers = count;
 
 	if (info->attrs[NL80211_ATTR_TIMEOUT])
 		req->timeout = nla_get_u32(info->attrs[NL80211_ATTR_TIMEOUT]);
@@ -321,8 +322,6 @@ int nl80211_pmsr_start(struct sk_buff *skb, struct genl_info *info)
 			goto out_err;
 		idx++;
 	}
-
-	req->n_peers = count;
 	req->cookie = cfg80211_assign_cookie(rdev);
 	req->nl_portid = info->snd_portid;
 
-- 
2.34.1

