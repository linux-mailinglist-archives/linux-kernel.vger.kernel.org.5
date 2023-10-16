Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 192AE7C9CD8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 03:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbjJPBc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 21:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjJPBc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 21:32:57 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51FA0A9
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 18:32:55 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id A68382C02B1;
        Mon, 16 Oct 2023 14:32:51 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1697419971;
        bh=J6M5IsynnoswtQm5mi5V72Srk6LXjCtjo18yO5zsd8w=;
        h=From:To:Cc:Subject:Date:From;
        b=SHI7P0gyE/ZTmFmQGrr1kjmDW9BPFteWcgCceiXUdBVJj/qLtyzPS8MjAnPAUF2bh
         rNn7a+bkSE2ViMZs1VizUnNSWBiVCYmYIRLuH0XxL9V5QLWCbV3arPnW8+qhVJZr+2
         hESeyTxeB+Aj3MFPTs47Rm4BWDacOYMC9XIoFDkZE2T7A4coMwsod/Wg97NWoP0qEx
         WAL8Jrew3TqXepLGgm6+pqTf5U7EU2D35LtyYBgNiGtTig9GsRpCoqeyAJZetzdonh
         MQ3W1sSr0aSy+LR7psmiBM55RCXcuSTSlTJO6UXP5oBh0pIxklP8IPP1RMiyi+01Ri
         ZLQNm5JriScUQ==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B652c92c30000>; Mon, 16 Oct 2023 14:32:51 +1300
Received: from richardl-dl.ws.atlnz.lc (richardl-dl.ws.atlnz.lc [10.33.23.23])
        by pat.atlnz.lc (Postfix) with ESMTP id 8126A13EDA9;
        Mon, 16 Oct 2023 14:32:51 +1300 (NZDT)
Received: by richardl-dl.ws.atlnz.lc (Postfix, from userid 1481)
        id 7CF5B520158; Mon, 16 Oct 2023 14:32:51 +1300 (NZDT)
From:   Richard Laing <richard.laing@alliedtelesis.co.nz>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, ilpo.jarvinen@linux.intel.com,
        andriy.shevchenko@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org,
        Richard Laing <richard.laing@alliedtelesis.co.nz>
Subject: [PATCH] dt-bindings: serial: snps-dw-apb-uart: Add property to drain TX FIFO
Date:   Mon, 16 Oct 2023 14:32:05 +1300
Message-ID: <20231016013207.2249946-1-richard.laing@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=L6ZjvNb8 c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=bhdUkHdE2iEA:10 a=4-VxxmyDogjG6lCeASgA:9
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During development of a new hardware an issue was seen where writes to
UART_LCR can result in characters that are currently held in the TX FIFO
being lost rather than sent, even if the userspace process has attempted =
to
flush them.

This is most visible when using the "resize" command (tested on Busybox),
where we have observed the escape code for restoring cursor position
becoming mangled.

This is the same issue as addressed in=20
commit 914eaf935ec7 ("serial: 8250_dw: Allow TX FIFO to drain before
writing to UART_LCR")=20

for the Armada 38x serial port. This patch makes the fix more generic
allowing it to be applied on any similar UART.

Richard Laing (2):
  serial: 8250_dw: Allow TX FIFO to drain before writing to UART_LCR An
    issue has been observed on the Broadcom BCM56160 serial port which
    appears closely related to a similar issue on the Marvell Armada 38x
    serial port.
  dt-bindings: serial: snps-dw-apb-uart: Add property to drain TX FIFO

 .../bindings/serial/snps-dw-apb-uart.yaml      |  6 ++++++
 drivers/tty/serial/8250/8250_dw.c              | 18 ++++++++++++++++++
 drivers/tty/serial/8250/8250_dwlib.h           |  1 +
 3 files changed, 25 insertions(+)

--=20
2.42.0

