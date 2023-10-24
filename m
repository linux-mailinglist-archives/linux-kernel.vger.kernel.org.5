Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEDA57D57D8
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 18:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234736AbjJXQTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 12:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233585AbjJXQTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 12:19:38 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B39E111;
        Tue, 24 Oct 2023 09:19:36 -0700 (PDT)
Received: from jupiter.universe (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 264DD66072A2;
        Tue, 24 Oct 2023 17:19:35 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1698164375;
        bh=SqKf4LNwvpIYJ9bi8s2HSgXa96OgNa0HbeVAslfV1tU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A2hGpIqV1ZIGRSd6+nUApqHDqsXu2jtpQy8gHMlDfLtCXGef8ux0LOtJzTL4eLJu2
         DUMaQUGSKyHGUHrOvPJjQgrhf4TD/pV9lYOP0rursa+TUzxci2toviIHXet9ksthcq
         hQWjVEeC4WAMatPGuv3DUauC5Q/LsNcEW9MCtVp9Y6JLS1ZUNV7klUwT8MQTe6IrDx
         w1z244Fv0hXQ/z3SmxPaRtFOXFIx6aMuTUzJ6SAVx/BbgDZHcdVh+qfxMzJwdKFoGo
         gAjeXhoZdk/zOXs1qMzCcLtDvfXn1gfJllO7jvBePlPNqf4hhc1VTbjfO3YhdAg1FG
         Z9ZOc+kgg7ZaA==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 9BC2B482AD8; Tue, 24 Oct 2023 18:19:32 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        David Laight <David.Laight@ACULAB.COM>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v4 1/3] math.h: add DIV_ROUND_UP_NO_OVERFLOW
Date:   Tue, 24 Oct 2023 18:18:15 +0200
Message-ID: <20231024161931.78567-2-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231024161931.78567-1-sebastian.reichel@collabora.com>
References: <20231024161931.78567-1-sebastian.reichel@collabora.com>
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

Add a new DIV_ROUND_UP helper, which cannot overflow when
big numbers are being used.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 include/linux/math.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/math.h b/include/linux/math.h
index dd4152711de7..f80bfb375ab9 100644
--- a/include/linux/math.h
+++ b/include/linux/math.h
@@ -36,6 +36,17 @@
 
 #define DIV_ROUND_UP __KERNEL_DIV_ROUND_UP
 
+/**
+ * DIV_ROUND_UP_NO_OVERFLOW - divide two numbers and always round up
+ * @n: numerator / dividend
+ * @d: denominator / divisor
+ *
+ * This functions does the same as DIV_ROUND_UP, but internally uses a
+ * division and a modulo operation instead of math tricks. This way it
+ * avoids overflowing when handling big numbers.
+ */
+#define DIV_ROUND_UP_NO_OVERFLOW(n, d) (((n) / (d)) + !!((n) % (d)))
+
 #define DIV_ROUND_DOWN_ULL(ll, d) \
 	({ unsigned long long _tmp = (ll); do_div(_tmp, d); _tmp; })
 
-- 
2.42.0

