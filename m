Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B241475AA4C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 11:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbjGTJAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 05:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbjGTIms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 04:42:48 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C61E2115
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 01:42:46 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R65mH156MzBRDsR
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 16:42:39 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689842558; x=1692434559; bh=Md6rh710L5XA/naj1kP/jEptljd
        erUpfENeBbgOR95E=; b=IsHn5oTojRdCwIUOvrejeC7SF7COIg51M3qY7RgRAGT
        tcZxZbhz3sWMEI3WH+iNq/koy3OaupW6lcU2bkEcnQ0NIv0iOKy0w8TsZPZ6vzZo
        m31qy0PA/wDDFcsMkDE3ucs8Y4zN5cp1usee2snD+LeWwatRThP39Ec8jZNFvLOa
        OvBQ3Qf4XODzqzOnkIH4CISv/z4aVPRkQcBsOoR+Q2MdHa17AGNIRyeL9wPdQPgw
        uQNMZbwClnrgnjssiYYSxTxX6OSUk0b4oImlVnvwnU8h3q+Hv2f0fo6RTq5BTzGI
        1mE1tTr/xcfSD9rW7LrLyBSzihABpuF44lD7Hws/xqQ==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id V-3NtuqiHsk2 for <linux-kernel@vger.kernel.org>;
        Thu, 20 Jul 2023 16:42:38 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R65mG1s24zBHXhQ;
        Thu, 20 Jul 2023 16:42:38 +0800 (CST)
MIME-Version: 1.0
Date:   Thu, 20 Jul 2023 16:42:38 +0800
From:   sunran001@208suo.com
To:     nm@ti.com, kristo@kernel.org, ssantosh@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH] clk: keystone: sci-clk: fix application of sizeof to pointer
In-Reply-To: <20230720074906.3373-1-xujianghui@cdjrlc.com>
References: <20230720074906.3373-1-xujianghui@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <3ad9c41575c274137001916c896bf2b6@208suo.com>
X-Sender: sunran001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The coccinelle check report:
./drivers/scsi/csiostor/csio_mb.c:1554:46-52: ERROR: application of
sizeof to pointer

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
  drivers/clk/keystone/sci-clk.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/keystone/sci-clk.c 
b/drivers/clk/keystone/sci-clk.c
index 6c1df4f11536..2c68c1e09d1f 100644
--- a/drivers/clk/keystone/sci-clk.c
+++ b/drivers/clk/keystone/sci-clk.c
@@ -389,7 +389,7 @@ static struct clk_hw *sci_clk_get(struct 
of_phandle_args *clkspec, void *data)
  	key.clk_id = clkspec->args[1];

  	clk = bsearch(&key, provider->clocks, provider->num_clocks,
-		      sizeof(clk), _cmp_sci_clk);
+		      sizeof(**clk), _cmp_sci_clk);

  	if (!clk)
  		return ERR_PTR(-ENODEV);
