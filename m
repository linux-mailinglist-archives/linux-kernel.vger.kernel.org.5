Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8D638079E7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 21:59:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379468AbjLFU7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 15:59:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjLFU7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 15:59:06 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 582E6DC
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 12:59:12 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1cfb30ce241so1805335ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 12:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701896352; x=1702501152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J93fduvsJM9IBDskoI9RKo4tnycXW8hW3zH9yUjvMQk=;
        b=jZZw9mI7YrxEPgI+aIObpwp94vnWw09sNo7OJ/9O8MwgjocHUrmcfZpMxhmTZjk3CF
         SZ0XlZj4Tt8IneivqQgFUq6XcOuf9wDJds7WEv3FQKLaytYyPTknLrpB1dfzqRfHHL4X
         kXCU7iBrV3JBcbRr1LsgX3tMkuE4Y+1zGEvic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701896352; x=1702501152;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J93fduvsJM9IBDskoI9RKo4tnycXW8hW3zH9yUjvMQk=;
        b=akQZDf5QVMCkc7pZSihnumEzfclZDPXJCfpRZPL7jIKUe52rBU81n7ZHD6KyrWPOvR
         VApO7bwBUDZBn/qPkeDSHoZNP0J3BWwx3BA77JC5gUrcFz6JOK89H6OX6vTnJZAoxWij
         m2bYYR0oDhiy+tXGYKduvHJ655Xe9ORqrPPmS8WQFcJfFn4QiUKT/k5WYlGnRxAD+6sw
         mx+wyj0vl8n1WqFjWOZqBoR6LCohJq21vxOHcgmYZdbawb2BjCAlEF1J5z+UD8qySSiy
         9jtWf3mJ4JglUe7kgcoe2cNwalT6ok9a4TzJvWJuRL2Q14um8Sd7X57IY0BOua2qWLnk
         FgMw==
X-Gm-Message-State: AOJu0Yw5ElpqwiFgcxOG1MJZUFEYiX4PTAjSPk1sVec6WMUTS5K71owF
        nQfpFVchz9p1omfYQN00/nihMw==
X-Google-Smtp-Source: AGHT+IFvswkhjo/IRJgksME8nSDfGlm3ijJw/G6gOtT77V36Y3AGjjCCSiF/AeJmBG3/ZUhfEybY+w==
X-Received: by 2002:a17:902:ce8c:b0:1d0:5efb:852e with SMTP id f12-20020a170902ce8c00b001d05efb852emr1894519plg.40.1701896351898;
        Wed, 06 Dec 2023 12:59:11 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id g15-20020a1709029f8f00b001cffe1e7374sm241121plq.214.2023.12.06.12.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 12:59:11 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        kernel test robot <lkp@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <quic_jjohnson@quicinc.com>,
        Michael Walle <mwalle@kernel.org>,
        Max Schulze <max.schulze@online.de>, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH v3] netlink: Return unsigned value for nla_len()
Date:   Wed,  6 Dec 2023 12:59:07 -0800
Message-Id: <20231206205904.make.018-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2690; i=keescook@chromium.org;
 h=from:subject:message-id; bh=pLbf9+8/Dl6ABNGi9y3vSm6UF9GJMzpseYPTOTsyx3s=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlcOCb/xqKImyOG8B5tSBdCnmYR3X3y0Fpi6OPz
 +IJ//WINgGJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZXDgmwAKCRCJcvTf3G3A
 Jla8D/4u3zQcCSzbtxkzBPPv06VCqIqEjWUmThCDWb+7VGajZMflRwumsBIenZhrHpN5F5aclOO
 4VuHTW8AM5MPLgfRnMQ4JvuUp2Upru5NZQjfGbfMVR8helKPFcBr9hc04VO1f92ifYptZRN/LKb
 jOKQWB3KCZMuQasgWFlbpupkYVvuSZVid0v4uHPmr+XPVJHMHShYG5uojmi79M+Ublpsz9iH88S
 lbfK82rcT0UN8FROEBI2dTwMS5WlKw4KrykUQbatRuSyFrU7vSM2SFxoT55PrI419GzCH35Rvqc
 gz7Zap2Sr3KnVwn21KhkpdXtzjiX8Y/hOeWFpfSnhS/PlKtOUWwS84KMSfBCuqIWqBo62i0+zGT
 tyELRq341AAVcM5zvGvxbytPFkyPSbNR7dZJ2STXBR6LM0NKhVEqnpQXcXn2zq5bhpj25epO8cJ
 5rHqEuJaVlT0U7t1RHlp3tkdieB2VJpkHjx9vnAMrB7aXV+30hKEZZvtgIpv6UXRdfnBYXufLpw
 hPjF2ZyQ7BEW3wi3OqKe0Hw0rZrzOYmCRZ5s/oUW5icBLeD2zNyTioD8elQ+oFohpwdafgXuy/v
 9qOsRL44DGAAZ+T1MUSWBz+xvuCU2vKWiUkQWVbeT+otZYhXiojiclK7j+OVH8jbd3TIghZHF6P
 3UCxxmr ZBhWuGBg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return value from nla_len() is never expected to be negative, and can
never be more than struct nlattr::nla_len (a u16). Adjust the prototype
on the function. This will let GCC's value range optimization passes
know that the return can never be negative, and can never be larger than
u16. As recently discussed[1], this silences the following warning in
GCC 12+:

net/wireless/nl80211.c: In function 'nl80211_set_cqm_rssi.isra':
net/wireless/nl80211.c:12892:17: warning: 'memcpy' specified bound 18446744073709551615 exceeds maximum object size 9223372036854775807 [-Wstringop-overflow=]
12892 |                 memcpy(cqm_config->rssi_thresholds, thresholds,
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
12893 |                        flex_array_size(cqm_config, rssi_thresholds,
      |                        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
12894 |                                        n_thresholds));
      |                                        ~~~~~~~~~~~~~~

A future change would be to clamp the subtraction to make sure it never
wraps around if nla_len is somehow less than NLA_HDRLEN, which would
have the additional benefit of being defensive in the face of nlattr
corruption or logic errors.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202311090752.hWcJWAHL-lkp@intel.com/ [1]
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: David S. Miller <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Michael Walle <mwalle@kernel.org>
Cc: Max Schulze <max.schulze@online.de>
Cc: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Link: https://lore.kernel.org/r/20231202202539.it.704-kees@kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 v3: do not cast NLA_HDRLEN to u16 (nicolas.dichtel)
 v2: https://lore.kernel.org/all/20231202202539.it.704-kees@kernel.org/
 v1: https://lore.kernel.org/all/20231130200058.work.520-kees@kernel.org/
---
 include/net/netlink.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/net/netlink.h b/include/net/netlink.h
index 83bdf787aeee..7678a596a86b 100644
--- a/include/net/netlink.h
+++ b/include/net/netlink.h
@@ -1200,7 +1200,7 @@ static inline void *nla_data(const struct nlattr *nla)
  * nla_len - length of payload
  * @nla: netlink attribute
  */
-static inline int nla_len(const struct nlattr *nla)
+static inline u16 nla_len(const struct nlattr *nla)
 {
 	return nla->nla_len - NLA_HDRLEN;
 }
-- 
2.34.1

