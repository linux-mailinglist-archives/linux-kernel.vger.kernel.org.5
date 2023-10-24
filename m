Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED017D5B29
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 21:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344226AbjJXTKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 15:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343856AbjJXTKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 15:10:23 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD16610C6;
        Tue, 24 Oct 2023 12:10:20 -0700 (PDT)
Received: from arisu.hitronhub.home (unknown [23.233.251.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: detlev)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CB9B96607326;
        Tue, 24 Oct 2023 20:10:18 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1698174619;
        bh=48gv3M0r1fBIkgyPkulYSBjvZY2KdKwDZSX3M+tYcPk=;
        h=From:To:Cc:Subject:Date:From;
        b=QTVWiK3fyB4H0/VLcasxoGVSu8kR9TM4ME2EhbQXDg6Ague1++Uhw/bw22qXV4PkG
         HOMPVG/cnLOx9cy6zZ0Fpk1DktgBYQ/5elZyeOu2cHllg/7RpZ+XkEhXXet8Vo+oY9
         +Gp0rSPDpvfWKmm5/OsgKeKsjys3WGMY09Ppa6cHZ4kbBIaiNLwsJnhCz6SN6JGe78
         3nRar3bYXvf9g2FbsuY7ZcXsUvfKFq3ocmA9re+kyOXlGPwGee/lOhQ0F/xrKSmz6I
         L3ce61dCaBJea46tBwXJ945Os9ERnB8C/zmw4YBN7G3a8lOjjZiEjIlLRamx6kHtWZ
         SSvDRIm6tIDSg==
From:   Detlev Casanova <detlev.casanova@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-media@vger.kernel.org,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Detlev Casanova <detlev.casanova@collabora.com>
Subject: [PATCH v2 0/5] visl: Adapt output frames for reference comparison
Date:   Tue, 24 Oct 2023 15:09:45 -0400
Message-ID: <20231024191027.305622-1-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.41.0
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

When using visl in automated tests, we need to have output frames that
can be compared to reference frames or hash of those to validate that
the whole pipeline is working properly.

Add a "stable_output" module parameter to make sure that a given input
stream always outputs the same frames.
This is done by skipping information like queues status and pointer
values.

This also adds some stable variation in the frames so that different
input give more different output.

Changes since v1:
 - Fix typo in parameter documentation

Detlev Casanova (5):
  media: visl: Fix params permissions/defaults mismatch
  media: visl: Add a stable_output parameter
  doc: visl: Document stable_output parameter
  visl: Add a codec specific variability parameter
  doc: visl: Document codec_variability parameter

 Documentation/admin-guide/media/visl.rst    |   9 ++
 drivers/media/test-drivers/visl/visl-core.c |  12 +-
 drivers/media/test-drivers/visl/visl-dec.c  | 152 +++++++++++++-------
 drivers/media/test-drivers/visl/visl.h      |   2 +
 4 files changed, 120 insertions(+), 55 deletions(-)

-- 
2.41.0

