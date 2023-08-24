Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1818B787801
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 20:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243107AbjHXSeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 14:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243088AbjHXSdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 14:33:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C7EA19A3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 11:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692901983;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6l23XMepM0Sh/iOcowpX76UCT+vWOCxLFJ6fQYXhTVo=;
        b=X0y107lxiVSyYEmIPUufzreSZ7fAZXPY6VHZIVHtZyobUFY1zBYE41vOxI/IghliVsVQXO
        jjepjQmwzAhZp5kDJste6kkkTLQjMyhvh55CxNyQoulYBTVEcDIi4EsA+BznCaHUZxiFJ1
        LVOWyBxc1BGxKg2uzlUpDWJB/lxDqyo=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-XOuaS_s8MJW5f72hwjyl3A-1; Thu, 24 Aug 2023 14:33:02 -0400
X-MC-Unique: XOuaS_s8MJW5f72hwjyl3A-1
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-5711abe79ffso185720eaf.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 11:33:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692901981; x=1693506781;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6l23XMepM0Sh/iOcowpX76UCT+vWOCxLFJ6fQYXhTVo=;
        b=g1jJ0EVU9hJH2yNEbb0XA3vC2Sem4SjKUppBbZTO9isWIkRJRsmgFoniZUmPBDZtud
         X4waRVzIy+4i6HXnMnYbdMMJp8v38rqsfuvVDLn0VaUV9Pep8Gp5Z1tqC1Qg0NJb4CgX
         KsdQ0wwysC8XxDye/vpI535nV/N12crhk4lQNjXLsTNBV1gEKC6Qp3TkMi6TQb1mXZ/V
         Q5+qTlnQHqmoxdg9FE01rvQTCLDYu03FwpeO1C3K6T2RL+43MQvVLPUH+mKNWvpRSYMt
         gH3NfiiDnYgJEIGksMraBA7uhSIe4c87Y811lDeBCO5/aGy3PQkLlsymoaKW0Y+yfw1U
         lP7Q==
X-Gm-Message-State: AOJu0Yxnc0/a0Cnk4yQ40+FxoiWDS8IONNT0ECo7ev/yhrevNaNlgJPb
        HNyCt/KoDUaWDFr/37k1MuKqXkDn1XOSu8ynzQJGJDJQx5bIYSfcNlfzAL37qpzr9zr0K4FtpOI
        0RU+ORa43oyhY7++ii0sfQoP9
X-Received: by 2002:a05:6870:e253:b0:1be:f8d9:7bdd with SMTP id d19-20020a056870e25300b001bef8d97bddmr627381oac.6.1692901981471;
        Thu, 24 Aug 2023 11:33:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHS3fEn/UFcZp7p1JhHHa0Wzb/ax2PIiQ32dL4ujO6wuTfaKPgzGkO+lp3kAWh66sAyZwY+xw==
X-Received: by 2002:a05:6870:e253:b0:1be:f8d9:7bdd with SMTP id d19-20020a056870e25300b001bef8d97bddmr627359oac.6.1692901981225;
        Thu, 24 Aug 2023 11:33:01 -0700 (PDT)
Received: from [192.168.1.165] ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id j17-20020a0ceb11000000b0064f77d37798sm4209qvp.5.2023.08.24.11.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 11:33:00 -0700 (PDT)
From:   Andrew Halaney <ahalaney@redhat.com>
Date:   Thu, 24 Aug 2023 13:32:54 -0500
Subject: [PATCH net-next 3/7] net: stmmac: Precede entire addend
 calculation with its comment
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230824-stmmac-subsecond-inc-cleanup-v1-3-e0b9f7c18b37@redhat.com>
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

The addend calculation is currently split. The variable to be programmed
is first altered, then a comment explaining the full calculation is
seen, then the variable is altered further before the calculation is
finished.

Make the comment the first thing read. This makes the conversion of
sub_second_increment from nanoseconds to hertz much easier to
understand and reads logically.

Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index ba38ca284e26..f0e585e6ef76 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -849,7 +849,6 @@ int stmmac_init_tstamp_counter(struct stmmac_priv *priv, u32 systime_flags)
 	stmmac_config_sub_second_increment(priv, priv->ptpaddr,
 					   priv->plat->clk_ptp_rate,
 					   xmac, &sub_second_inc);
-	temp = div_u64(NSEC_PER_SEC, sub_second_inc);
 
 	/* Store sub second increment for later use */
 	priv->sub_second_inc = sub_second_inc;
@@ -859,6 +858,7 @@ int stmmac_init_tstamp_counter(struct stmmac_priv *priv, u32 systime_flags)
 	 * addend = (2^32)/freq_div_ratio;
 	 * where, freq_div_ratio = 1e9ns/sub_second_inc
 	 */
+	temp = div_u64(NSEC_PER_SEC, sub_second_inc);
 	temp = (u64)(temp << 32);
 	priv->default_addend = div_u64(temp, priv->plat->clk_ptp_rate);
 	stmmac_config_addend(priv, priv->ptpaddr, priv->default_addend);

-- 
2.41.0

