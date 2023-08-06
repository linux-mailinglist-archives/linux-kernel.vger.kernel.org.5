Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BDA1771430
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 11:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbjHFJck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 05:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjHFJci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 05:32:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE389F3;
        Sun,  6 Aug 2023 02:32:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5BFED60FFC;
        Sun,  6 Aug 2023 09:32:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83E21C433C8;
        Sun,  6 Aug 2023 09:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691314356;
        bh=e3eVn3I3csuxUTSWKKbazD8xuiApRe8LHcpfQHQofGk=;
        h=From:To:Cc:Subject:Date:From;
        b=leVX9+/a4UYzb787JuPbefONy8LrIEK0Y4HHBTpRJ+k6FGVF+P9dJxWdUtupLM+5y
         1K14x98xs+yaAQSfm0kjiqW8979VfUz1wSlhrK2eXmF9MvHIfM24+w/xEcuOwQKFxf
         xywwFT1YvyvDz6vsfPjF7Q9aZIcMlt4v08+qJqaGdqbyiK5/hLpsfZcWIG64RqcU7F
         iPHuoMWLpGJjbwPH0RcpnXgQhOrEzAyflu3kV+gyqcjz6ZPpGUg/436UzOXKXi9qgH
         MZv1GWepaSmPN7rrDddTXkP9NnUzuT9fCWfMWTr9MtGyUFGAj2esYMQjRwspXrgM4C
         pBOkUpN8vMeog==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] serial: 8250_dw: fall back to poll if there's no interrupt
Date:   Sun,  6 Aug 2023 17:20:54 +0800
Message-Id: <20230806092056.2467-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When there's no irq(this can be due to various reasons, for example,
no irq from HW support, or we just want to use poll solution, and so
on), falling back to poll is still better than no support at all.

patch1 makes the interrupt property in dt-binding optional
patch2 falls back to poll if there's no interrupt

since v1:
 - adopt Andy's suggestion to simplified the code

Jisheng Zhang (2):
  dt-bindings: serial: snps-dw-apb-uart: make interrupt optional
  serial: 8250_dw: fall back to poll if there's no interrupt

 .../devicetree/bindings/serial/snps-dw-apb-uart.yaml         | 1 -
 drivers/tty/serial/8250/8250_dw.c                            | 5 ++++-
 2 files changed, 4 insertions(+), 2 deletions(-)

-- 
2.40.1

