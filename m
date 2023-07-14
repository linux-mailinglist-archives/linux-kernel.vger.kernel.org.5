Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A70EC753B71
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 15:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235866AbjGNNEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 09:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234881AbjGNNEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 09:04:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC9830CB;
        Fri, 14 Jul 2023 06:04:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C6D1761D10;
        Fri, 14 Jul 2023 13:04:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D3D8C433C9;
        Fri, 14 Jul 2023 13:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689339843;
        bh=n56OIv7wYjOjFumwVnFoUoyIEuQPLS8u1Ruo4hGD9LM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=msQVqeY3TLfufw2NEY7pyhHzHiNIT0Id16NVjLACYwvWqZmWT1RDrkTYmPDZO3Lor
         bUBU6jNWB22Abm6zcLaDc70I9ctjUK2SuRL5SWhN+sFocbufLvscgmSwwo/jf5EwLB
         +x3lqLDYWL/vUlmUPzPu9+TT+z18qo4Hx/onwHzYeWcMsHJ2aEtZStsHNLFGIU6kQv
         x2eebLwVadZPlv7UWK1dJL3ZMO2UrNf6upiYM1YLlT5FoE/NxWn2fH2OlR47tXH9ej
         0jrz4giBo+6fi30wM58uvHE5P0kQLUP1Jp1unLiyTi8baaXUCr75dZJ3MX/gdDexhb
         8vTVjixyYBIww==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan+linaro@kernel.org>)
        id 1qKISq-0003nk-21;
        Fri, 14 Jul 2023 15:04:04 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>, stable@vger.kernel.org,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH 1/2] serial: qcom-geni: fix opp vote on shutdown
Date:   Fri, 14 Jul 2023 15:02:13 +0200
Message-ID: <20230714130214.14552-2-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230714130214.14552-1-johan+linaro@kernel.org>
References: <20230714130214.14552-1-johan+linaro@kernel.org>
MIME-Version: 1.0
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

The operating-performance-point vote needs to be dropped when shutting
down the port to avoid wasting power by keeping resources like power
domains in an unnecessarily high performance state (e.g. when a UART
connected Bluetooth controller is not in use).

Fixes: a5819b548af0 ("tty: serial: qcom_geni_serial: Use OPP API to set clk/perf state")
Cc: stable@vger.kernel.org      # 5.9
Cc: Rajendra Nayak <quic_rjendra@quicinc.com>
Cc: Matthias Kaehlcke <mka@chromium.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/tty/serial/qcom_geni_serial.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index b825b05e6137..8be896dbaa88 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -126,6 +126,7 @@ struct qcom_geni_serial_port {
 	dma_addr_t rx_dma_addr;
 	bool setup;
 	unsigned int baud;
+	unsigned long clk_rate;
 	void *rx_buf;
 	u32 loopback;
 	bool brk;
@@ -1249,6 +1250,7 @@ static void qcom_geni_serial_set_termios(struct uart_port *uport,
 			baud * sampling_rate, clk_rate, clk_div);
 
 	uport->uartclk = clk_rate;
+	port->clk_rate = clk_rate;
 	dev_pm_opp_set_rate(uport->dev, clk_rate);
 	ser_clk_cfg = SER_CLK_EN;
 	ser_clk_cfg |= clk_div << CLK_DIV_SHFT;
@@ -1513,10 +1515,13 @@ static void qcom_geni_serial_pm(struct uart_port *uport,
 
 	if (new_state == UART_PM_STATE_ON && old_state == UART_PM_STATE_OFF) {
 		geni_icc_enable(&port->se);
+		if (port->clk_rate)
+			dev_pm_opp_set_rate(uport->dev, port->clk_rate);
 		geni_se_resources_on(&port->se);
 	} else if (new_state == UART_PM_STATE_OFF &&
 			old_state == UART_PM_STATE_ON) {
 		geni_se_resources_off(&port->se);
+		dev_pm_opp_set_rate(uport->dev, 0);
 		geni_icc_disable(&port->se);
 	}
 }
-- 
2.41.0

