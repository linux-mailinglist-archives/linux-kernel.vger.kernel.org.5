Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6A71787803
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 20:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235622AbjHXSeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 14:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243091AbjHXSdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 14:33:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E291BE9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 11:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692901985;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kLlThC3R9OImoZ+MRsaHGOa2SVCnd5iJ51KhprNayB4=;
        b=WI7GAb87tP7mnRpBeTH91Znyjn1cl6S5pWbLfXl89I62rPWiJ1mi3ExG69AI3NceGiB2+B
        J+r/tGPsVW2Q3QaaR8Ud/ot4DDrI5hX42/1NXmIoPqsiOyTyGfF5DNCdFwayx+jvefuhME
        2HG/A67KcfqLKLhgQHXLJRAH4KLlS3U=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-mVWxVleXNsma081_XsL5Nw-1; Thu, 24 Aug 2023 14:33:04 -0400
X-MC-Unique: mVWxVleXNsma081_XsL5Nw-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-649fac91500so11618886d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 11:33:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692901984; x=1693506784;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kLlThC3R9OImoZ+MRsaHGOa2SVCnd5iJ51KhprNayB4=;
        b=I0bsBaITLTs+4yGzzwZKY/nwGrexL+jKS4FNzCqX+fVcWnJMftALfiDmAWongkpxcN
         eatsrtyXGge7R4ieTcNrdXN6iX51F/qZ3N8LD8vkp/qFKe6HfU1fcDvzcV2Pf2RBbZaZ
         t7jGtXmoHeuwb8zYKLIKNQXmtE/FK9x+TZRTX4g/tFl0Fe2HLr5wxDBwxvPWtxw5PRPL
         rRSUkh29Eq1l/LGJdp5pJRWP7ts+PmFsBtuGqWr8BRGfTVngzGK70IvvA6/l/yqvV2uw
         e0I0qWjX4uNX4uIqFNPXsJ3n+fs4EWd3chQc9fQ1/c9qVmhdCQj5GE+47nR7N1L84rS6
         qN0g==
X-Gm-Message-State: AOJu0YxfIvkQn3b4RpmCaW6aABC/mS3jn5Gute9/mzpNzvA6MHsC1XgU
        Q6oarbnET91xtxUjA1LeUqkk5MUhaqubICRFISAuKNgVvls8icHe4tuHe0btrLcyQgFvhz6saML
        JspJ+R7yddoEFazMN14WKb2DN
X-Received: by 2002:a05:6214:ac9:b0:64b:926a:e7fc with SMTP id g9-20020a0562140ac900b0064b926ae7fcmr19233930qvi.21.1692901984162;
        Thu, 24 Aug 2023 11:33:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/pC6Ozwx0rjBhGbBoQuQPKXeDRWWo7/yf47bHb2XuaionNEwEaUXyApPQsLo9pKSgtTNXGg==
X-Received: by 2002:a05:6214:ac9:b0:64b:926a:e7fc with SMTP id g9-20020a0562140ac900b0064b926ae7fcmr19233915qvi.21.1692901983920;
        Thu, 24 Aug 2023 11:33:03 -0700 (PDT)
Received: from [192.168.1.165] ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id j17-20020a0ceb11000000b0064f77d37798sm4209qvp.5.2023.08.24.11.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 11:33:03 -0700 (PDT)
From:   Andrew Halaney <ahalaney@redhat.com>
Date:   Thu, 24 Aug 2023 13:32:56 -0500
Subject: [PATCH net-next 5/7] net: stmmac: Correct addend typo
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230824-stmmac-subsecond-inc-cleanup-v1-5-e0b9f7c18b37@redhat.com>
References: <20230824-stmmac-subsecond-inc-cleanup-v1-0-e0b9f7c18b37@redhat.com>
In-Reply-To: <20230824-stmmac-subsecond-inc-cleanup-v1-0-e0b9f7c18b37@redhat.com>
To:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Richard Cochran <richardcochran@gmail.com>
Cc:     netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrew Halaney <ahalaney@redhat.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

added should be addend in this context.

Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 20ef068b3e6b..dfead0df6163 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -853,7 +853,7 @@ int stmmac_init_tstamp_counter(struct stmmac_priv *priv, u32 systime_flags)
 	/* Store sub second increment for later use */
 	priv->sub_second_inc = sub_second_inc;
 
-	/* calculate default added value:
+	/* calculate default addend value:
 	 * formula is :
 	 * addend = (2^32)/freq_div_ratio;
 	 * where, freq_div_ratio = 1e9ns/sub_second_inc

-- 
2.41.0

