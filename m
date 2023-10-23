Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB607D3FB6
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 21:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231506AbjJWTAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 15:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbjJWS7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 14:59:55 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E59B110;
        Mon, 23 Oct 2023 11:59:54 -0700 (PDT)
Received: from arisu.mtl.collabora.ca (mtl.collabora.ca [66.171.169.34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: detlev)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id F289366071EF;
        Mon, 23 Oct 2023 19:59:51 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1698087592;
        bh=1kYYBVVZKlPmwQg0v2fZqPSvNTFy7yF+ri1uhcr4paQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cWgRGnDwnr9wDW8Ok2OdHR5TTS6eRV580VatM6gq1t88ShZCxLOHfs5fWSUaAYJCh
         8cdW6wfW8JuXxtNKQFJlmx0X0zPrRZhv2yAukJDZLdyEx2eJBwRj3rZjX2DeLwwPuv
         fipVzVCvER+XX3g0W1V7WdT5NegPO1Tv2m6D6+Qhe2rAQt7ZIipOc2xe877WkqK9oW
         ZGQyoVopLsR2zfpEw9XI8BuEjtVwLC7TMiUGTRKb0D0z/pIThSo5a1ydKhZs0XwQ90
         qCFFNf19BKPuK33r+VvE41tq703k77vo9gIzNPQhU3MW+EvxfLhX0K+NiY6aVDne25
         lKgm0TfBI3VaA==
From:   Detlev Casanova <detlev.casanova@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-media@vger.kernel.org,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Detlev Casanova <detlev.casanova@collabora.com>
Subject: [PATCH 1/5] media: visl: Fix params permissions/defaults mismatch
Date:   Mon, 23 Oct 2023 14:58:21 -0400
Message-ID: <20231023185850.67082-2-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231023185850.67082-1-detlev.casanova@collabora.com>
References: <20231023185850.67082-1-detlev.casanova@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`false` was used as the keep_bitstream_buffers parameter permissions.
This looks more like a default value for the parameter, so change it to
0 to avoid confusion.

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

