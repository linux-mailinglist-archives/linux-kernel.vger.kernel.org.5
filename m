Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB7A762480
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 23:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbjGYVbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 17:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbjGYVbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 17:31:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BDBD1FE5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 14:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690320614;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uK3zP8luGfpdcnVrRakVsTeHLiN3hIMl3KOmXd3egZQ=;
        b=Gkjb/RxpS3iHEriRdpkhyhtbdHv+fc5HJpCcaqbBy0FW4sqhEQ0AmFSEPWCLGydelkh2oP
        nmk+gAwLI2BT5+9J0CtBfmVVe5AmkjYNMR884/Oh6yYMnDKwSVDtjldhb9o5odqZoPvGQ4
        Gs0OszQm1o7FpVTPZZpZcXXcdg9EBJ4=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-HRsinHiYPj6Vw0nZq_y4Fg-1; Tue, 25 Jul 2023 17:30:13 -0400
X-MC-Unique: HRsinHiYPj6Vw0nZq_y4Fg-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7683cdabcb7so808400085a.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 14:30:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690320612; x=1690925412;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uK3zP8luGfpdcnVrRakVsTeHLiN3hIMl3KOmXd3egZQ=;
        b=UCmizQZaDLlBKwVEiY3s529NC3uCvdrbSnnhJ82b8jFz32+wflzVdKo5CbpfqKp4SO
         PfyjbeicWQLB3e/DH5rKnURaLXD1aJ59q4HO5USb/H/34YeNlkoIl8cN6Td6cpX6ne3z
         xUdntUV/f8/zFHnGSIkAtMnwmTZQUdYZ0jtRtLZIFPwn68sGW1zNVFFK1P1XLkQy2TIV
         QWdprhf9+ZXkigpn72cBLN4D5fNvakUd/K7+uJy9LqeeZwhd9DxY+dXd8zurf7t69oUI
         A4CZb4n6AcY55W9d584/ehIVKu6mlGtOooDXx0BOVSTJl6J3L2enpo4WQh8ZzpylBuSg
         k0pQ==
X-Gm-Message-State: ABy/qLbAhMD2UuZ78SM8ILX9uIOIpi7jYri0LfBr/TDO9A1LavHDRTnG
        jRWW4BvXa+dMmu40jqhUDID4TUQ2edxRJn64NJPiqAZb1yVBHP4gsOU0n9toJQ9tPJSUs2HP9Nu
        mqSFtn9pSnq3dhtqplmWkXeCKBOl3nvxp6S6pd7yeqQ//h5azDYAIWow9VBdgoUBHeQzZj0pCOT
        2TwIdEjmJT
X-Received: by 2002:a05:620a:2545:b0:768:156e:41b8 with SMTP id s5-20020a05620a254500b00768156e41b8mr171389qko.56.1690320612370;
        Tue, 25 Jul 2023 14:30:12 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFed3Kq4JhRY5nCg9QF+L66gABirAe874NXCX9weK6QU/6x4lyMcM2Gcjb9IOg9DiukLElQKA==
X-Received: by 2002:a05:620a:2545:b0:768:156e:41b8 with SMTP id s5-20020a05620a254500b00768156e41b8mr171347qko.56.1690320611986;
        Tue, 25 Jul 2023 14:30:11 -0700 (PDT)
Received: from fedora.redhat.com ([2600:1700:1ff0:d0e0::17])
        by smtp.gmail.com with ESMTPSA id j3-20020a37c243000000b00767d7307490sm3943067qkm.34.2023.07.25.14.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 14:30:11 -0700 (PDT)
From:   Andrew Halaney <ahalaney@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     ahalaney@redhat.com, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
        mcoquelin.stm32@gmail.com, pabeni@redhat.com, kuba@kernel.org,
        edumazet@google.com, davem@davemloft.net, joabreu@synopsys.com,
        alexandre.torgue@foss.st.com, peppe.cavallaro@st.com,
        bhupesh.sharma@linaro.org, vkoul@kernel.org,
        linux-arm-msm@vger.kernel.org, jsuraj@qti.qualcomm.com,
        Simon Horman <simon.horman@corigine.com>
Subject: [PATCH net-next v2 1/2] net: stmmac: Make ptp_clk_freq_config variable type explicit
Date:   Tue, 25 Jul 2023 16:04:25 -0500
Message-ID: <20230725211853.895832-3-ahalaney@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725211853.895832-2-ahalaney@redhat.com>
References: <20230725211853.895832-2-ahalaney@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The priv variable is _always_ of type (struct stmmac_priv *), so let's
stop using (void *) since it isn't abstracting anything.

Reviewed-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c | 3 +--
 include/linux/stmmac.h                            | 4 +++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
index 0ffae785d8bd..979c755964b1 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c
@@ -257,9 +257,8 @@ static void intel_speed_mode_2500(struct net_device *ndev, void *intel_data)
 /* Program PTP Clock Frequency for different variant of
  * Intel mGBE that has slightly different GPO mapping
  */
-static void intel_mgbe_ptp_clk_freq_config(void *npriv)
+static void intel_mgbe_ptp_clk_freq_config(struct stmmac_priv *priv)
 {
-	struct stmmac_priv *priv = (struct stmmac_priv *)npriv;
 	struct intel_priv_data *intel_priv;
 	u32 gpio_value;
 
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index ef67dba775d0..3d0702510224 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -76,6 +76,8 @@
 			| DMA_AXI_BLEN_32 | DMA_AXI_BLEN_64 \
 			| DMA_AXI_BLEN_128 | DMA_AXI_BLEN_256)
 
+struct stmmac_priv;
+
 /* Platfrom data for platform device structure's platform_data field */
 
 struct stmmac_mdio_bus_data {
@@ -258,7 +260,7 @@ struct plat_stmmacenet_data {
 	int (*serdes_powerup)(struct net_device *ndev, void *priv);
 	void (*serdes_powerdown)(struct net_device *ndev, void *priv);
 	void (*speed_mode_2500)(struct net_device *ndev, void *priv);
-	void (*ptp_clk_freq_config)(void *priv);
+	void (*ptp_clk_freq_config)(struct stmmac_priv *priv);
 	int (*init)(struct platform_device *pdev, void *priv);
 	void (*exit)(struct platform_device *pdev, void *priv);
 	struct mac_device_info *(*setup)(void *priv);
-- 
2.41.0

