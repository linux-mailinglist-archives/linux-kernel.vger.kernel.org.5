Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC837D85EB
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 17:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345430AbjJZPYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 11:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345431AbjJZPYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 11:24:09 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D40318F
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 08:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=s31663417; t=1698333831; x=1698938631; i=estl@gmx.net;
        bh=SWTSfYAJ6wjPq94D3WZ59HwtQ06vUm4Q2LB7f5lEL+M=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
         References;
        b=Hq+oYA1A4I4B8RJ8Qblzlf7M8EW+HW5HaZJYlZpwbJaCqtciQeFBVJE1W0Aqyb0C
         5sHj3gTP9t5S2aN8VbEs3mEZTu+Idom1bYp67ECkEYvyYQFqQzlWrl3Rr20RSYMY+
         ztAqu82w77h9/J93Bi47rJD7u3jr/65W+Qwg0rNLrUchQUlL5K5/s6t1a/PM34jVt
         f6d0O9+9Gm2NbsYo5BJPG6EYnimPDhnhuJr/hG6NLgsjb0girLZH5mgeChn6gxbq7
         1i033FJIcwR6lendHroDPXFimOjhfQjifashQInhRtiBnDKbVWyd4jyTu+vAVIMmX
         1zwr4joFgf3fbbSOFw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.localdomain ([77.246.119.226]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1M9Wys-1qskQV0yTU-005ZfM; Thu, 26 Oct 2023 17:23:51 +0200
From:   Eberhard Stoll <estl@gmx.net>
To:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Eberhard Stoll <eberhard.stoll@kontron.de>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Chuanhong Guo <gch981213@gmail.com>,
        Mario Kicherer <dev@kicherer.org>,
        Martin Kurbanov <mmkurbanov@sberdevices.ru>
Subject: [PATCH 2/4] mtd: spinand: Add support for clock to rx delay setting
Date:   Thu, 26 Oct 2023 17:23:03 +0200
Message-Id: <20231026152316.2729575-3-estl@gmx.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231026152316.2729575-1-estl@gmx.net>
References: <20231026152316.2729575-1-estl@gmx.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fEubDti3aDbWQ3NePpK//inzhLn2La+uc+hDR3Cl0ol3T/Mk1wb
 jcAB5EmgHOJKnIEq/zMCqNuV3qpoNPkzOyIJu5qanQGoY1ua/xiB2LMxI09pOZPEn0NTLWK
 p2hq59e4uLShkHDH0a1QW6WBV+RAcmIqE24zkuG4vdcIkqpXAlvXpTl8XFZvkLqPJSEuvoR
 ptA4GN6zN+ds26T6j3wtw==
UI-OutboundReport: notjunk:1;M01:P0:WecwLtkKLQc=;XuITYkWd5CcgSFoGdVhSqEemhnG
 boarAIRBxF0Wd3bgiAB7N7W3pBtkMxZ2YPxaa7wC3WKv8+VRFCtQxa2dEsJ6R/uKncQbRLhdP
 OFbFkVZeeZ3w/X7oqujToEvjvkBqQDj79H9EIVWPKR261xIjU3pY9j1BygVNH4yR+rJLrjcWx
 K1QbBy/NR+EBlvIK+oe+mGadp+oexIUyB0PObzjWw+PBGX97nWj5f1HLRhaoCcvreUpBAbE0i
 GbUq/g3f5OJFRnMv5Nt1ogj6GUnYE+H3Dx1bqHzguHQyQ+j6wR/sNTHmIcSjbcali5fFMSHXy
 1fA13a0OxpxvcSzDk0eSgft5rnipdEttQsZIwRKzP13bpEGnXfw8gurJEmr1jiGe+/NCA7ryE
 7wyjdsShI2c87RF7R9JXLS5S0FLpxtQZIr92D2vQxMfOUh3/DuZuD/GNXFebxWex5WzqBCHCM
 HoqWClOthAeNbkT5CktKkiequA3gCABhWIOekZiEW0AtwQhXLOkZR9wVPcniehIKpmOlpqWOI
 2HPBAtCe0Z777rtnXBIwPQr4Jd49vBA+WRBiFHjm6YEU6czpEDcJdWAuWaR9IBLZhTjPPtAvE
 PObjKOw9AzYASA2NgtXyTYsztCyQxdLJm9wwGazCkjs3Eb0iolFwcMqA6/gpSuUsWq/6GCWcS
 V91T+jP8+6E8+aBCVgPoBHlIRZVBXyNEKvsrCcu1uhRY3m3WyK5hsEkD8OPBFNAJ+iVc6rFQZ
 fjo4SVO72M9zW/1z1O6YCNnUztHUPf+hj0wAvEX+hnY9QtMG9LPoIkdgb80TfY63mxJiaYXFv
 P4OOucVbBIQqgI9DUORmDPQnwQaGhZTibtQ9MQX0bwBJWsoEBUywp9q7OD4JhOWTAGGp0PRjX
 WOyq4nIP4HuALfEhJ07q+5xF1nTp9255HpwFbX28Z2EDPGDwe2YBn7Iub4Bm2BpRJQhQf6pnS
 TiFwbw==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eberhard Stoll <eberhard.stoll@kontron.de>

Add the configuration parameter to set the spi clock to receive
data delay parameter for SPI NAND devices.

This parameter is often referenced as tCLQV in SPI NAND device
data sheets.

Signed-off-by: Eberhard Stoll <eberhard.stoll@kontron.de>
Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
=2D--
 drivers/mtd/nand/spi/core.c | 2 ++
 include/linux/mtd/spinand.h | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 393ff37f0d23..e546b0d1f76f 100644
=2D-- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1113,6 +1113,8 @@ int spinand_match_and_init(struct spinand_device *sp=
inand,
 					       info->op_variants.update_cache);
 		spinand->op_templates.update_cache =3D op;

+		spinand->spimem->spi->rx_sample_delay_ns =3D table[i].rx_sample_delay_n=
s;
+
 		return 0;
 	}

diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 3e285c09d16d..fe34d5259c97 100644
=2D-- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -326,6 +326,7 @@ struct spinand_ondie_ecc_conf {
  * @model: model name
  * @devid: device ID
  * @flags: OR-ing of the SPINAND_XXX flags
+ * @rx_sample_delay_ns: clock to rx data delay timing (tCLQV)
  * @memorg: memory organization
  * @eccreq: ECC requirements
  * @eccinfo: on-die ECC info
@@ -343,6 +344,7 @@ struct spinand_info {
 	const char *model;
 	struct spinand_devid devid;
 	u32 flags;
+	u32 rx_sample_delay_ns;
 	struct nand_memory_organization memorg;
 	struct nand_ecc_props eccreq;
 	struct spinand_ecc_info eccinfo;
@@ -378,6 +380,9 @@ struct spinand_info {
 #define SPINAND_SELECT_TARGET(__func)					\
 	.select_target =3D __func,

+#define SPINAND_RX_SAMPLE_DELAY(__delay)				\
+	.rx_sample_delay_ns =3D __delay,
+
 #define SPINAND_INFO(__model, __id, __memorg, __eccreq, __op_variants,	\
 		     __flags, ...)					\
 	{								\
=2D-
2.25.1

