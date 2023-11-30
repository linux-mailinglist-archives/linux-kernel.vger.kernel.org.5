Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 983B47FFBE4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 21:01:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232319AbjK3UBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 15:01:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjK3UA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 15:00:58 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7536110F8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 12:01:04 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-286406ae852so725703a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 12:01:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701374464; x=1701979264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DjLamxZyQfbyptpIvpzFIM9HoGVb6+OmTO9thE+0l0A=;
        b=GGyJ41GinrkCDijL/CNfx8rZzdU+bWwf+Sretpgifqmsok/ABKqMO18zKMQK1XPOLv
         GkFrv6Eq7jtCBnl6+iPQCJQNQCbeRV7WwdarFUCZV3qBmHrrO5Stq5YMAk0DeDMnv3AA
         tV+ja7xTeosbnInimbMe/Rfe4j/CPfl07T2H0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701374464; x=1701979264;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DjLamxZyQfbyptpIvpzFIM9HoGVb6+OmTO9thE+0l0A=;
        b=Qy4TDk0y0+UDN7lMz2RoTrL4PvUCYZvYSQE1V6s+BFA0p1RDZIkbDxrG90QD/yjjox
         z+H1Zf8o2lAFtXHFdHJ4MVrVJ27h7zE8KR/Ks/ajDcD3u0PXWXqV34/YrTBs5W7KNrVR
         /4sqids0rPCj6f17DaqWh+B7e4Njwp2n7yfrCM4zKyl0uus86/dFoe08MoDBlo7gyaVy
         HO4CclOZmSyIlpcFnniCehvHWLx9/lo7qfEvaNr+9SngY/QKZixFT54dXJRxuG2m3+ql
         anEIZ3Y3S6up3nxNY9rmhHoBdDEw2edMz6VXKiw7z+mk8/Es6r/XsSjDf23ml+hXBLFW
         /yRQ==
X-Gm-Message-State: AOJu0Yz4Xy3P0dTLW0quiTX0n57voGTxvLfHvS1pe+u9XlqYXFowM3yT
        UzEM3xZBIsYQuBF3N0ggMsMVD9AbEXWO2LZaljg=
X-Google-Smtp-Source: AGHT+IGgDbuduO0TRl7R7gO2PBc8v+3LqmhG3IlJd7Is7C7ylYuOHkDxFPlQnCSCFhMp0VOLmpjRUQ==
X-Received: by 2002:a17:90b:3b86:b0:285:a179:7174 with SMTP id pc6-20020a17090b3b8600b00285a1797174mr22305244pjb.29.1701374463664;
        Thu, 30 Nov 2023 12:01:03 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id gg16-20020a17090b0a1000b002858ac5e401sm3687765pjb.45.2023.11.30.12.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 12:01:03 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        kernel test robot <lkp@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <quic_jjohnson@quicinc.com>,
        Michael Walle <mwalle@kernel.org>,
        Max Schulze <max.schulze@online.de>, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] netlink: Return unsigned value for nla_len()
Date:   Thu, 30 Nov 2023 12:01:01 -0800
Message-Id: <20231130200058.work.520-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2452; i=keescook@chromium.org;
 h=from:subject:message-id; bh=penjs9WkGWzsqXkZBizH1HvU0T+dKnNfeIaWwvPQsRs=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlaOn9cgfbrAAjas3hx+hd183f+KUlnaqvvTcKU
 c2eIz0CGr+JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZWjp/QAKCRCJcvTf3G3A
 JmIKD/9fiJNBEEe9sj4peZsNPvhzqGeV+ixJOnS3btR7fRWXAR9QBI7p3472rOKKDSEWZRdQTRA
 B5AlP8Marc+gBPUBdlUI2yQuf7iLVJ01rwNk7MwwIm0p8877bB9Ge135CpOadBdbi6N52wYlslO
 fbY82GwnMjEL9QLeGY+bnVljthqsh0u4kzcj5lvIekba/DjxD02UIl6gDiGOjBKEdXYXH0W5+7B
 uW1xm50ZqStiyMkZZNdBsN/x+4w0StkgnevqMlHan+qTAGKPSQjfgBwnfOT3z/FVMnCGQyCtxYn
 9KfatOF3VjZl46DHRNfQge4XVW5DOmOROeWhrNkQO37hOF0WQxOkonKxggOmynztvZXky5GdJJk
 tiLIaHyOqJWjxqwHX3USmrjr8WoFXqUGLZUkIj/opc+VpAHdsRN4ZwFLeXcPBLTiC+NWdxXKBo8
 O520MI1VJ1DXdtevqUR5SSfNbJcdcPnvAYoi6HLgonCzGcTextAdQBvRSp21GJ/2V3HMZVkKlUw
 ljYYLzEDitegFiqrm8+9uwtU+sELR7aZ5uaeM0Yi8Co6ml4VYGgxOHKANC8kTvqTGL03DbLrCfV
 dh6a2w5v9R7rWMFPujOVF3bg8C82w7O6z1FrfxDu3Z/+4EnrtLPo0zdTUkrQe6/6HW1xnnx89m3
 N9xuByR CH8DD7Tw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return value from nla_len() is never expected to be negative, and can
never be more than struct nlattr::nla_len (a u16). Adjust the prototype
on the function, and explicitly bounds check the subtraction. This will
let GCC's value range optimization passes know that the return can never
be negative, and can never be larger than u16. As recently discussed[1],
this silences the following warning in GCC 12+:

net/wireless/nl80211.c: In function 'nl80211_set_cqm_rssi.isra':
net/wireless/nl80211.c:12892:17: warning: 'memcpy' specified bound 18446744073709551615 exceeds maximum object size 9223372036854775807 [-Wstringop-overflow=]
12892 |                 memcpy(cqm_config->rssi_thresholds, thresholds,
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
12893 |                        flex_array_size(cqm_config, rssi_thresholds,
      |                        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
12894 |                                        n_thresholds));
      |                                        ~~~~~~~~~~~~~~

This has the additional benefit of being defensive in the face of nlattr
corruption or logic errors (i.e. nla_len being set smaller than
NLA_HDRLEN).

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202311090752.hWcJWAHL-lkp@intel.com/ [1]
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Michael Walle <mwalle@kernel.org>
Cc: Max Schulze <max.schulze@online.de>
Cc: netdev@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/net/netlink.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/net/netlink.h b/include/net/netlink.h
index 167b91348e57..c59679524705 100644
--- a/include/net/netlink.h
+++ b/include/net/netlink.h
@@ -1214,9 +1214,9 @@ static inline void *nla_data(const struct nlattr *nla)
  * nla_len - length of payload
  * @nla: netlink attribute
  */
-static inline int nla_len(const struct nlattr *nla)
+static inline u16 nla_len(const struct nlattr *nla)
 {
-	return nla->nla_len - NLA_HDRLEN;
+	return nla->nla_len > NLA_HDRLEN ? nla->nla_len - NLA_HDRLEN : 0;
 }
 
 /**
-- 
2.34.1

