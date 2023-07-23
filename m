Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C22B275E2CC
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 17:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjGWPHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 11:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjGWPHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 11:07:31 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F75AF3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 08:07:30 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-992acf67388so522634666b.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 08:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1690124848; x=1690729648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JDolbZwxUR1dqTmWKJPBm9xAZkcLiWXKL3X8juy54I0=;
        b=O/JiitTXHFP0uR2DRWyLFH1VT54tr4N2dQ5DnWPJnLMNEzorUdFk/NfGRMjgKg7qmm
         3nNtv6BWuA4DnciYCfXfiUHeaA2NgbXLjvAin94mQlXkCYvP2ZLApewcCkGPP9T3L9sD
         9h9QsL2oYsGPrU9gB+t73IMPU9nhuqFj61ujk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690124848; x=1690729648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JDolbZwxUR1dqTmWKJPBm9xAZkcLiWXKL3X8juy54I0=;
        b=MBJT/1h1ri+vERZJN/WM1m+oFzv8F9yioYQxOt6ObrO3Rv3RitgeUQ1GuvvX0nbPJ4
         qrLtS033TdwUQ/Ga9wP1i0zQbIjGo4umh7Fq5tZfzMeL6XL4SwiVLwj/UFX+OKPXEeZx
         g7k17zD1MDcp091N7HgczWgbgmGuQfWz+HflnAda4wcg2mtFfLRycvxZKv60NOXX3OBj
         kPIzVfLHjmBCTY1IvpFaeFl7ZqTkbKlKNHJpQceywVJGRpPYe3lnsuemPYkd0BGUwO8g
         29wiiqXD9DtoYl4vz7tnIabYyXmvSNuv0tlKNEvg6pXPhFWsxnLwVquJNmiMlFw0bymF
         teAA==
X-Gm-Message-State: ABy/qLb5HAa4vYUNEb+Ibhx0kNqx6bzZ2oUVIW3L0BJRABJ3oEfJL8uB
        GhW8yYtjFyugbUHM4UeBkFSDwQ==
X-Google-Smtp-Source: APBJJlH4j2EBHuP2dwPwVY7QUDlOn2Aqu+8+9EXAcQe+eR8i5HPWOTYC3BzksTCU+N9cZ3h0t3dGpQ==
X-Received: by 2002:a17:906:768f:b0:993:d8a2:385 with SMTP id o15-20020a170906768f00b00993d8a20385mr7300555ejm.22.1690124848600;
        Sun, 23 Jul 2023 08:07:28 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id t10-20020a1709064f0a00b009929d998abcsm5227691eju.209.2023.07.23.08.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 08:07:28 -0700 (PDT)
From:   Joe Damato <jdamato@fastly.com>
To:     netdev@vger.kernel.org, saeedm@nvidia.com, tariqt@nvidia.com,
        ecree@solarflare.com, andrew@lunn.ch, kuba@kernel.org,
        davem@davemloft.net, leon@kernel.org, pabeni@redhat.com,
        bhutchings@solarflare.com, arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, Joe Damato <jdamato@fastly.com>
Subject: [net 1/2] net: ethtool: Unify ETHTOOL_{G,S}RXFH rxnfc copy
Date:   Sun, 23 Jul 2023 15:06:57 +0000
Message-Id: <20230723150658.241597-2-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230723150658.241597-1-jdamato@fastly.com>
References: <20230723150658.241597-1-jdamato@fastly.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ETHTOOL_GRXFH correctly copies in the full struct ethtool_rxnfc when
FLOW_RSS is set; ETHTOOL_SRXFH needs a similar code path to handle the
FLOW_RSS case so that ethtool can set the flow hash for custom RSS
contexts (if supported by the driver).

The copy code from ETHTOOL_GRXFH has been pulled out in to a helper so
that it can be called in both ETHTOOL_{G,S}RXFH code paths.

Fixes: 84a1d9c48200 ("net: ethtool: extend RXNFC API to support RSS spreading of filter matches")
Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 net/ethtool/ioctl.c | 75 +++++++++++++++++++++++----------------------
 1 file changed, 38 insertions(+), 37 deletions(-)

diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 4a51e0ec295c..7d40e7913e76 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -907,6 +907,38 @@ static int ethtool_rxnfc_copy_to_compat(void __user *useraddr,
 	return 0;
 }
 
+static int ethtool_rxnfc_copy_struct(u32 cmd, struct ethtool_rxnfc *info,
+				     size_t *info_size, void __user *useraddr)
+{
+	/* struct ethtool_rxnfc was originally defined for
+	 * ETHTOOL_{G,S}RXFH with only the cmd, flow_type and data
+	 * members.  User-space might still be using that
+	 * definition.
+	 */
+	if (cmd == ETHTOOL_GRXFH || cmd == ETHTOOL_SRXFH)
+		*info_size = (offsetof(struct ethtool_rxnfc, data) +
+			      sizeof(info->data));
+
+	if (ethtool_rxnfc_copy_from_user(info, useraddr, *info_size))
+		return -EFAULT;
+
+	if ((cmd == ETHTOOL_GRXFH || cmd == ETHTOOL_SRXFH) && info->flow_type & FLOW_RSS) {
+		*info_size = sizeof(*info);
+		if (ethtool_rxnfc_copy_from_user(info, useraddr, *info_size))
+			return -EFAULT;
+		/* Since malicious users may modify the original data,
+		 * we need to check whether FLOW_RSS is still requested.
+		 */
+		if (!(info->flow_type & FLOW_RSS))
+			return -EINVAL;
+	}
+
+	if (info->cmd != cmd)
+		return -EINVAL;
+
+	return 0;
+}
+
 static int ethtool_rxnfc_copy_to_user(void __user *useraddr,
 				      const struct ethtool_rxnfc *rxnfc,
 				      size_t size, const u32 *rule_buf)
@@ -944,16 +976,9 @@ static noinline_for_stack int ethtool_set_rxnfc(struct net_device *dev,
 	if (!dev->ethtool_ops->set_rxnfc)
 		return -EOPNOTSUPP;
 
-	/* struct ethtool_rxnfc was originally defined for
-	 * ETHTOOL_{G,S}RXFH with only the cmd, flow_type and data
-	 * members.  User-space might still be using that
-	 * definition. */
-	if (cmd == ETHTOOL_SRXFH)
-		info_size = (offsetof(struct ethtool_rxnfc, data) +
-			     sizeof(info.data));
-
-	if (ethtool_rxnfc_copy_from_user(&info, useraddr, info_size))
-		return -EFAULT;
+	rc = ethtool_rxnfc_copy_struct(cmd, &info, &info_size, useraddr);
+	if (rc)
+		return rc;
 
 	rc = dev->ethtool_ops->set_rxnfc(dev, &info);
 	if (rc)
@@ -978,33 +1003,9 @@ static noinline_for_stack int ethtool_get_rxnfc(struct net_device *dev,
 	if (!ops->get_rxnfc)
 		return -EOPNOTSUPP;
 
-	/* struct ethtool_rxnfc was originally defined for
-	 * ETHTOOL_{G,S}RXFH with only the cmd, flow_type and data
-	 * members.  User-space might still be using that
-	 * definition. */
-	if (cmd == ETHTOOL_GRXFH)
-		info_size = (offsetof(struct ethtool_rxnfc, data) +
-			     sizeof(info.data));
-
-	if (ethtool_rxnfc_copy_from_user(&info, useraddr, info_size))
-		return -EFAULT;
-
-	/* If FLOW_RSS was requested then user-space must be using the
-	 * new definition, as FLOW_RSS is newer.
-	 */
-	if (cmd == ETHTOOL_GRXFH && info.flow_type & FLOW_RSS) {
-		info_size = sizeof(info);
-		if (ethtool_rxnfc_copy_from_user(&info, useraddr, info_size))
-			return -EFAULT;
-		/* Since malicious users may modify the original data,
-		 * we need to check whether FLOW_RSS is still requested.
-		 */
-		if (!(info.flow_type & FLOW_RSS))
-			return -EINVAL;
-	}
-
-	if (info.cmd != cmd)
-		return -EINVAL;
+	ret = ethtool_rxnfc_copy_struct(cmd, &info, &info_size, useraddr);
+	if (ret)
+		return ret;
 
 	if (info.cmd == ETHTOOL_GRXCLSRLALL) {
 		if (info.rule_cnt > 0) {
-- 
2.25.1

