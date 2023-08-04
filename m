Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 192F176FEB4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 12:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbjHDKoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 06:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjHDKom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 06:44:42 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A9E46BD
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 03:44:41 -0700 (PDT)
Received: from [127.0.1.1] (91-154-35-171.elisa-laajakaista.fi [91.154.35.171])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id AA6BE12E4;
        Fri,  4 Aug 2023 12:43:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1691145814;
        bh=3BEyrzp4IUiLGe9w3xtacn7Yy6nvFBbT4HOk9yd56NA=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=FT+PbaJNlTpwZPIvNYkMtzEJmWRm4vJP236yMj3QUZ5O2XhBrzD1necB+dYoKY6wV
         GgcPIDSfVxczEKuGBNYKzjwoYx8NSdRYMdoWx9rrk5HHSEU41ytiL7PEcZ4gjeA4HR
         EmW3pd7FO9GnC2C/2q8CEM8l33wgvTTldB005cG0=
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date:   Fri, 04 Aug 2023 13:44:06 +0300
Subject: [PATCH 01/11] drm/bridge: tc358768: Fix use of uninitialized
 variable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230804-tc358768-v1-1-1afd44b7826b@ideasonboard.com>
References: <20230804-tc358768-v1-0-1afd44b7826b@ideasonboard.com>
In-Reply-To: <20230804-tc358768-v1-0-1afd44b7826b@ideasonboard.com>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?utf-8?q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>,
        Francesco Dolcini <francesco@dolcini.it>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Aradhya Bhatia <a-bhatia1@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=909;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=3BEyrzp4IUiLGe9w3xtacn7Yy6nvFBbT4HOk9yd56NA=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBkzNaRGYqdx9CLtWjNaw71yuxZ7twAVPL/kKywz
 73jg/nITEyJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZMzWkQAKCRD6PaqMvJYe
 9R/ED/0e1faduwhJY8SxU8fljAbFFDWdEBvarjI1D4D/CRcIKgRU7Mc2sn7RFbrHSOJrYeCYJWS
 h1pGjDdPvKmhw4njBLZefSGXAaSJTo8oI9ZOEwkbTuEcuFZaLaGwtCOJQGSlLMt0NJgv5LcKi3v
 u8QJOwmEkzwiANoErF84woZj5cIH22ZuCT/ZIt8KsaAfHR8N8DFNrslZkTFPEMnL3PWVS4NKlxI
 rTDp/nqU0G9GQUywOp2dQA7IupqBJJZXFh9anZ/yJNhKy58SuMb04Yo5JQjhZqTkMhrB4NTXctu
 42hGy57/TkRT0dsm0h5XiK4/s+ldCDn0wjy+hWsbVe1R4NAmfJWdwVIMlrjVQuASMAOfitCwSsA
 Z4NOWBQjx5Vzo9oJuTos5mabMOGW9Ji6CpycTPPTfnTkLEu8bNlIFC09yOB7PSb0inUNAMaB2W3
 BSntU0hS4MgAHptNXQFy5p+BGYUUnZ6P5Da2ByeWbH6/WOj2XgwWGPmchNY+RDoamePLay70lzU
 xvcdg94Te/QIi2sJTT2dyMoopwJfmQRBE6jTY+nAhw9XgU7LoId9YRffFHwUhPVguLSNGHKhoHX
 ouVb8j94cHFEMytHccOLohg70pvFxrgNIvcJd1BbMP1X8S2vzcUcC/6FjRoD+yfIP97Uvj0ZXN5
 hOnOfe5OhhqfXMA==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

smatch reports:

drivers/gpu/drm/bridge/tc358768.c:223 tc358768_update_bits() error: uninitialized symbol 'orig'.

Fix this by bailing out from tc358768_update_bits() if the
tc358768_read() produces an error.

Fixes: ff1ca6397b1d ("drm/bridge: Add tc358768 driver")
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/bridge/tc358768.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/bridge/tc358768.c b/drivers/gpu/drm/bridge/tc358768.c
index 819a4b6ec2a0..bc97a837955b 100644
--- a/drivers/gpu/drm/bridge/tc358768.c
+++ b/drivers/gpu/drm/bridge/tc358768.c
@@ -216,6 +216,10 @@ static void tc358768_update_bits(struct tc358768_priv *priv, u32 reg, u32 mask,
 	u32 tmp, orig;
 
 	tc358768_read(priv, reg, &orig);
+
+	if (priv->error)
+		return;
+
 	tmp = orig & ~mask;
 	tmp |= val & mask;
 	if (tmp != orig)

-- 
2.34.1

