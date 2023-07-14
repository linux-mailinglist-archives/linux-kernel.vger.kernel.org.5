Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53C05753B70
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 15:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235813AbjGNNEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 09:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjGNNEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 09:04:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 308AD30CA;
        Fri, 14 Jul 2023 06:04:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE8D461D11;
        Fri, 14 Jul 2023 13:04:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A416C433C8;
        Fri, 14 Jul 2023 13:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689339843;
        bh=BknjWnKCtvrJ0CaxUt4ptagyWk8YX48GKd/9fEAJ7JU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GYn5D6G2rlXhkg6EtehiBiofi0CHsC3R3ZgqqiiObvyMK+L+JI/s1boBPYZmHn5Hx
         LXGAj95v2RxQn2xRcKnC2RS+Y6z3pflHw9IcNMnCOnWpr3Fx5S16lzCf7T1rpeQaJY
         fJ98o5wIjf3mG2lTj07BkfJdPIrRyIYEACeiTIQbBDVGYeuKlC/9JeG8A3O1/dRJmT
         StpVxBG+wYK48dB5GpLgJO4T+ch2wnKZUl5omXqD9LpZTII4DSkvDhvpd/tOzy2qPu
         UBDiMlQSRoMhXRNBSvvFs8rh7viw82a8JxhwE/+6qohzGYh9io19FJGs/xRsRPxHdR
         SDX35RDG13Ucg==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan+linaro@kernel.org>)
        id 1qKISq-0003nm-2J;
        Fri, 14 Jul 2023 15:04:04 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 2/2] serial: qcom-geni: clean up clock-rate debug printk
Date:   Fri, 14 Jul 2023 15:02:14 +0200
Message-ID: <20230714130214.14552-3-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230714130214.14552-1-johan+linaro@kernel.org>
References: <20230714130214.14552-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the clock-rate debug printk more readable by using an equal sign
instead of a dash as separator between names and values and adding some
spaces:

	qcom_geni_serial 988000.serial: desired_rate = 1843200, clk_rate = 7372800, clk_div = 4

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/tty/serial/qcom_geni_serial.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 8be896dbaa88..753ac68d03a6 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -1246,7 +1246,7 @@ static void qcom_geni_serial_set_termios(struct uart_port *uport,
 		goto out_restart_rx;
 	}
 
-	dev_dbg(port->se.dev, "desired_rate-%u, clk_rate-%lu, clk_div-%u\n",
+	dev_dbg(port->se.dev, "desired_rate = %u, clk_rate = %lu, clk_div = %u\n",
 			baud * sampling_rate, clk_rate, clk_div);
 
 	uport->uartclk = clk_rate;
-- 
2.41.0

