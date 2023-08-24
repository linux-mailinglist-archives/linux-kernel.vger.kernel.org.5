Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 780DA7877FF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 20:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243102AbjHXSeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 14:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243089AbjHXSdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 14:33:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F0971BEB
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 11:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692901984;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XQSvh9slhSAVrK9RWa2tfsuNvxEUSp0MXiAFYeXPuAw=;
        b=XJfc4y6N2faFmurv6tTIlm1ifXhNdcbkV5RcYj9ST7tFrp7hrZakhqKF9te/G2q/psf3ds
        KOcTdHPhDXmfSuaSws3mxTP7cmsxArBiwjd2x4iKwZNPr7+Rg/zWnZTKP28hEMCKXogyaI
        EY+Or76eHK0L7xAWRvgUtnMFBSwZe8w=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-ctDG47sWNoqiMu8LaOB5yw-1; Thu, 24 Aug 2023 14:33:03 -0400
X-MC-Unique: ctDG47sWNoqiMu8LaOB5yw-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-63faa1e03a8so1450286d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 11:33:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692901982; x=1693506782;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XQSvh9slhSAVrK9RWa2tfsuNvxEUSp0MXiAFYeXPuAw=;
        b=iUJEBp4+11rGhkLEUMtnp5aRwkbUI8FOHlHzpaz40iXp5PuJAv0IFhx+tsht9TFfQK
         HxfQYK/dNytp3f8URyjGFG+CtZMpZ+CYlrhZJ7JXJqTGm6KvtLJMOVGPgcMnUZuEYZqs
         mSkTfhMuUZE51VywYkfRE2ivzDC/c+nJ4f0nru1SqUhdO/ldRbSXMi+EilwMDWcd4d7t
         fEd8/nUYvN0YL2q+cwjaPebaEO21SNdOzooVmPcrBn8ESSUoGk8G5XX84ce7KY6Dg4iK
         sT8dg2rJDT7Ivzk+bpXbboV7KmX1+ixKMyTfG6R7rbUFcO0LktOr0jopq2PrlfKpdivl
         tkMw==
X-Gm-Message-State: AOJu0Yyh7YE13/MetITYu1u/mQ0RuKoOJvGPFJA62NBbST41u+lNl+Fi
        s4H4BKDK2fb/uIxDVmWzXGNNHG5kAkrUULw85kofqysDviWSUGy0JKmzJB10fGQp/xkLvwcx1zr
        6iYhWmucCT7c49Ceh4i8K9Z0m
X-Received: by 2002:a0c:a99b:0:b0:63a:5ebc:6e7a with SMTP id a27-20020a0ca99b000000b0063a5ebc6e7amr15574218qvb.31.1692901982709;
        Thu, 24 Aug 2023 11:33:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFj5ZJm6hpe0krNTRRf2s5iyapXzQ1FpiG0EpY/VpNEjLrDgHOUR63fuY3Iw6CLeMnPKpjAVQ==
X-Received: by 2002:a0c:a99b:0:b0:63a:5ebc:6e7a with SMTP id a27-20020a0ca99b000000b0063a5ebc6e7amr15574200qvb.31.1692901982497;
        Thu, 24 Aug 2023 11:33:02 -0700 (PDT)
Received: from [192.168.1.165] ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id j17-20020a0ceb11000000b0064f77d37798sm4209qvp.5.2023.08.24.11.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 11:33:02 -0700 (PDT)
From:   Andrew Halaney <ahalaney@redhat.com>
Date:   Thu, 24 Aug 2023 13:32:55 -0500
Subject: [PATCH net-next 4/7] net: stmmac: Remove a pointless cast
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230824-stmmac-subsecond-inc-cleanup-v1-4-e0b9f7c18b37@redhat.com>
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
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The type is already u64, there's no reason to cast it again.

Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index f0e585e6ef76..20ef068b3e6b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -859,7 +859,7 @@ int stmmac_init_tstamp_counter(struct stmmac_priv *priv, u32 systime_flags)
 	 * where, freq_div_ratio = 1e9ns/sub_second_inc
 	 */
 	temp = div_u64(NSEC_PER_SEC, sub_second_inc);
-	temp = (u64)(temp << 32);
+	temp = temp << 32;
 	priv->default_addend = div_u64(temp, priv->plat->clk_ptp_rate);
 	stmmac_config_addend(priv, priv->ptpaddr, priv->default_addend);
 

-- 
2.41.0

