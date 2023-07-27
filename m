Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93865764581
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 07:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbjG0FdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 01:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbjG0FdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 01:33:14 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6AA730DB
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 22:32:58 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-686f090316dso320931b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 22:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1690435978; x=1691040778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZOqReItDfaxB+nBJ9zQp2I4wwFvLbgDN9poIQ494Sec=;
        b=NB7doVVdgWMiRRp5hZkHS0QERPxUWcgaqil3/xOuD7rKNI9jl2wuxHFzDl7N5BBoOO
         sl3xJNyzvO0bfAnxkzIj7XB2TM9G9N9NB1i79wtoEmLx1OLdWCwh2Gmg9sMe+wQk8dev
         vYl9h2wmHjFe4B4v+EN50b/3agja8Xa6JRnolEgkoa+ZFEi3SYrtzKFs82tQLWW9ve6K
         tCwjxpBUGyULVV9R7jaM0IvUcbPPi1HNmwcvsH7MJlkCIaQNsi8mz7auF0JcChkn/Nyb
         ZQMym9LSeo1fv++udsWd9/YNECzzOjF7U1bFB4rjS1ZfZUhewLByo5ZcBnGnOBiZVtYA
         ZSOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690435978; x=1691040778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZOqReItDfaxB+nBJ9zQp2I4wwFvLbgDN9poIQ494Sec=;
        b=Es6F5BJUJDhnEcS8/hJqGQ29SCOcD9eFqHBdsV6REYLClBB80J1hZgYti3t5wtnG63
         i1tB28jSjZRmLx9ZiMvthcMsu1LNeg5MwMeasJt0inqoWXkfShVBvlpDqKfhdyqEdb0p
         80Md1ngrTMJXRCpfnU8Mn2oA7JTjX/Jb8o0mW9zzqRnB/xKtmxTuu97kZtDbjanoM6Po
         ozlhnIXfIrbrLhg5M6wRCzZTAQhX6eu8WK/lSj18tOoBlAoDLF0ifdRXf9Qw5/TDxHUR
         wUxQ8+cgBK10rguhs4N/aRtMHYiCM05iwp7ZEAhK9LXJMiMCdZgN+mnrlFi0CAQDYqE/
         1oWw==
X-Gm-Message-State: ABy/qLbGN+zHYyXvAuqHJaSs1ZUApMpR5kaZ/ShLnOuMmJOt84CiyERg
        nUfj+caNdjQblW5MYRLrhdb2Cw==
X-Google-Smtp-Source: APBJJlG4g+UU2DlFHesikVn7Ehf7tvYVZYciQ2xv6muWvezUiwf85V/bBVOrFE/TJKyCXDSRtpnwNQ==
X-Received: by 2002:a05:6a21:4985:b0:10f:52e2:49ec with SMTP id ax5-20020a056a21498500b0010f52e249ecmr3493892pzc.53.1690435978324;
        Wed, 26 Jul 2023 22:32:58 -0700 (PDT)
Received: from localhost.localdomain ([82.78.167.79])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902c11500b001bb889530adsm319059pli.217.2023.07.26.22.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 22:32:58 -0700 (PDT)
From:   Claudiu Beznea <claudiu.beznea@tuxon.dev>
To:     mturquette@baylibre.com, sboyd@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        mripard@kernel.org
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, varshini.rajendran@microchip.com,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>
Subject: [PATCH 04/42] clk: at91: sam9x60: make checkpatch.pl happy
Date:   Thu, 27 Jul 2023 08:31:18 +0300
Message-Id: <20230727053156.13587-5-claudiu.beznea@tuxon.dev>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230727053156.13587-1-claudiu.beznea@tuxon.dev>
References: <20230727053156.13587-1-claudiu.beznea@tuxon.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the following checkpatch.pl CHECK:
Please use a blank line after function/struct/union/enum declarations.

Signed-off-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
---
 drivers/clk/at91/sam9x60.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/at91/sam9x60.c b/drivers/clk/at91/sam9x60.c
index c68cd969dd46..930b4515a1dd 100644
--- a/drivers/clk/at91/sam9x60.c
+++ b/drivers/clk/at91/sam9x60.c
@@ -379,5 +379,6 @@ static void __init sam9x60_pmc_setup(struct device_node *np)
 err_free:
 	kfree(sam9x60_pmc);
 }
+
 /* Some clks are used for a clocksource */
 CLK_OF_DECLARE(sam9x60_pmc, "microchip,sam9x60-pmc", sam9x60_pmc_setup);
-- 
2.39.2

