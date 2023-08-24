Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 529B1787878
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 21:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243192AbjHXTYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 15:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243022AbjHXTXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 15:23:51 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF9EC1BE6;
        Thu, 24 Aug 2023 12:23:48 -0700 (PDT)
Received: from dslb-188-097-211-187.188.097.pools.vodafone-ip.de ([188.97.211.187] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1qZFvg-00036P-Ny; Thu, 24 Aug 2023 21:23:40 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH v2 0/6]  hwrng: imx-rngc - use polling instead of interrupt
Date:   Thu, 24 Aug 2023 21:20:53 +0200
Message-Id: <20230824192059.1569591-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use polling and wait actively for the self test and the initial seeding
of the rngc to complete. This is much simpler than using an interrupt
and a completion.

v2:
- set reasonable timeouts
- separate commit for the removal of interrupt handling
- readl_poll_timeout does not wait in the foreground

Martin Kaiser (6):
  hwrng: imx-rngc - reasonable timeout for selftest
  hwrng: imx-rngc - reasonable timeout for initial seed
  hwrng: imx-rngc - use polling to detect end of self test
  hwrng: imx-rngc - read status register for error checks
  hwrng: imx-rngc - use polling for initial seed
  hwrng: imx-rngc - remove interrupt handler

 drivers/char/hw_random/imx-rngc.c | 100 ++++++------------------------
 1 file changed, 18 insertions(+), 82 deletions(-)

-- 
2.39.2

