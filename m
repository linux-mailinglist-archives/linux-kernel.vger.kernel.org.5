Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D79777FFA6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 23:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355259AbjHQVPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 17:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355215AbjHQVPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 17:15:39 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 393C43592
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 14:15:37 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1bc0d39b52cso2073115ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 14:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692306937; x=1692911737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h3KUIjH3bqO3vz9j7zL88Gi7VGzR7tpzI/DAuF67YiY=;
        b=kM2CV3yqnMQ3sAajAg0RjqmXfUnXkNE7pnTvtpPBHXQapPviKtWvfTryssx3R7OPUW
         kZY5hfjw60H8b94f7uX45reuNipK3U1jz0CjPV4GFJRQ08PzWPrONHjb5qqiXNMRHSDK
         ILrE9YOayY4VpZHZ/Rs8jIzUKjHArSNr289LY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692306937; x=1692911737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h3KUIjH3bqO3vz9j7zL88Gi7VGzR7tpzI/DAuF67YiY=;
        b=iX4QNu+GIt+rrWyk69bInWIew/k0LLsGsIHKF5Ki0rbb+kxyfENAccRC0+MGJ62/Qn
         RVwxIxDWpj+AcRlL8LWNuhYfnGj6bufVzEuSSj9eM69+aHhutiuB4v1WXexHcI8wsLdo
         u2E5ieu9m9fF/AJNOiJ0Dug5AaGJD5MQpv4FA8kEckEZb7tiO3hHVaOxJC4lORvJ+xOW
         O+U0ckziL2L5I848S2X6OpugWWMsuhvr52WzRSau8hdobRAnloK/2qxn7fTnh3uccGhS
         mFhCQ3WX63BzUbY4VumU+rwIs0XBDIrisg9scE+pJ4tMuL+mTXtmgI02zdOy9DLjzcmC
         WHuw==
X-Gm-Message-State: AOJu0YxiScwasatn74eoqH6p1MD3IuVKlhPI8tyhzo7yg+5vaakfhP34
        FmIeBzcrox4GAT9eNp3Sz+/jhg==
X-Google-Smtp-Source: AGHT+IEmfNVsNy4iHnvmICXL9xQpKVCsS1m4JFbHTVsXD7ksfRQU/kKdfL0/USC58A0YU154Pq7AGg==
X-Received: by 2002:a17:903:1250:b0:1b7:e646:4cc4 with SMTP id u16-20020a170903125000b001b7e6464cc4mr755667plh.28.1692306936691;
        Thu, 17 Aug 2023 14:15:36 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id n9-20020a170902e54900b001bde65894d5sm219283plf.109.2023.08.17.14.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 14:15:35 -0700 (PDT)
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
Subject: [PATCH 5/7] wifi: cfg80211: Annotate struct cfg80211_rnr_elems with __counted_by
Date:   Thu, 17 Aug 2023 14:15:27 -0700
Message-Id: <20230817211531.4193219-5-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230817211114.never.208-kees@kernel.org>
References: <20230817211114.never.208-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2013; i=keescook@chromium.org;
 h=from:subject; bh=opTdchMTFBio49JAacuYDHOX8V17n+9BFsDugyXAN9E=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBk3o3xP3ljHbFTrWITJj5hyUq0mFHJdP46PaHR+
 QMZ01hVNLqJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZN6N8QAKCRCJcvTf3G3A
 Jhc3D/0fmSOg3r4qUmVXQBWBtynY0f5BSPE/uidL/PDaHslJN4zo0mvrc/HxB5KHuXE1PIu2rWY
 0XvH+I5JZS8YV1NLW20Ngnr221VsBQ2U55gZ6ueSH51LejIR6Ugn51e+uPeBXY+Sq9lqmuvdONi
 ioVUed6O0963qupB6yUISWu4h0mift+ky7C6t2Tyrrqfan2O7JTKMmSniubu7UZ+ytA+ORDPp2G
 +ZJQ4ziYgEh5MAXRoSRovOxK5aRPI7JAN5K71Pnx9n6Lqvax4Qfx0fSyxQE2s8BP/ApwRtHyDR6
 w1TjreEP7u9BA3a74LI1Sq8w3ECR/r/hLlijUCBUYzPKze8d7r7Agm9zMcSc/DQ1KcFu/vx3q4q
 vUIGXe/zSwPZhYwleRXNCgq710EA9chMYY3RtWCLJss6VxrkzVPg120TpzIOcREY5wj6zkAgR+s
 OJF55sKozzPob6ghUtHwn/LsiqSPjcxzDaY5lPPCEDF6ftxDRFdttZ+rO8fw+95XH5eBml2uw1t
 Uq+0dKigcSbaEgOmW1FZ2rQgTH9UQrO6nqrYO5ky/qMpq6rNembFzV8ZlEbEyVZhe4cobhuzi9i
 6OuWS+FRM+KGsHfEWs+jTTqgZtGklRO0Jk8AygwNl1w3I6/bBzm97DbzVNzOCWStiY9rxVpzc7e FypPiEKQyAFJxEg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
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

As found with Coccinelle[1], add __counted_by for struct cfg80211_rnr_elems.
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
 net/wireless/nl80211.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index e9ca4726a732..6efe216c01d2 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1204,7 +1204,7 @@ struct cfg80211_rnr_elems {
 	struct {
 		const u8 *data;
 		size_t len;
-	} elem[];
+	} elem[] __counted_by(cnt);
 };
 
 /**
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 9ba4266368db..0ffebf1a1eb6 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -5470,13 +5470,13 @@ nl80211_parse_rnr_elems(struct wiphy *wiphy, struct nlattr *attrs,
 	elems = kzalloc(struct_size(elems, elem, num_elems), GFP_KERNEL);
 	if (!elems)
 		return ERR_PTR(-ENOMEM);
+	elems->cnt = num_elems;
 
 	nla_for_each_nested(nl_elems, attrs, rem_elems) {
 		elems->elem[i].data = nla_data(nl_elems);
 		elems->elem[i].len = nla_len(nl_elems);
 		i++;
 	}
-	elems->cnt = num_elems;
 	return elems;
 }
 
-- 
2.34.1

