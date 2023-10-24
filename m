Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9BC7D5B35
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 21:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344237AbjJXTK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 15:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343884AbjJXTKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 15:10:23 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91AE710C3;
        Tue, 24 Oct 2023 12:10:21 -0700 (PDT)
Received: from arisu.hitronhub.home (unknown [23.233.251.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: detlev)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B43936607333;
        Tue, 24 Oct 2023 20:10:19 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1698174620;
        bh=QzXZQ5qW45emjNZOoZBacDZXLZ1f0TmfU80OiA4TC/E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UYvc3HSAZvat0g51dUgwMnhIxMzTeig7f+ZRkCB+EbDN/SJLW34szjzL56d22Gp/J
         szJIoheeTE8w2mXrAj2lyu7Gs5PPUpJ/03vc3Zb5qfghWf7C9NeHSOtjksAVyrKQrR
         NV9V9dOUrSoRItv3hi/Xs8gKC1PDCuxI1ZlfRe8m9oZoyMgTDod5PB3QabOGuTv0U1
         0miFeOdpiydJDk33YtmXLbzJPbaYNsoPanqP+2dzbzWOifdDbBHaQwN/y6ulr62xOi
         C0WGxZ4/TeZhRYumDIDXRoZNN6W/srooulskWly3Qq3MJ7Jmcx6GThxBXn8m+3ab6o
         pSFaRocKP16Og==
From:   Detlev Casanova <detlev.casanova@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-media@vger.kernel.org,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Detlev Casanova <detlev.casanova@collabora.com>
Subject: [PATCH v2 1/5] media: visl: Fix params permissions/defaults mismatch
Date:   Tue, 24 Oct 2023 15:09:46 -0400
Message-ID: <20231024191027.305622-2-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231024191027.305622-1-detlev.casanova@collabora.com>
References: <20231024191027.305622-1-detlev.casanova@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`false` was used as the keep_bitstream_buffers parameter permissions.
This looks more like a default value for the parameter, so change it to
0 to avoid confusion.

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
---
 drivers/media/test-drivers/visl/visl-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/test-drivers/visl/visl-core.c b/drivers/media/test-drivers/visl/visl-core.c
index 9970dc739ca5..df6515530fbf 100644
--- a/drivers/media/test-drivers/visl/visl-core.c
+++ b/drivers/media/test-drivers/visl/visl-core.c
@@ -74,7 +74,7 @@ MODULE_PARM_DESC(visl_dprintk_nframes,
 		 " the number of frames to trace with dprintk");
 
 bool keep_bitstream_buffers;
-module_param(keep_bitstream_buffers, bool, false);
+module_param(keep_bitstream_buffers, bool, 0);
 MODULE_PARM_DESC(keep_bitstream_buffers,
 		 " keep bitstream buffers in debugfs after streaming is stopped");
 
-- 
2.41.0

