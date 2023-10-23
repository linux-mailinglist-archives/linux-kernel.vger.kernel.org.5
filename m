Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97FC27D3FB2
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 21:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbjJWS75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 14:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbjJWS7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 14:59:55 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 683DDB6;
        Mon, 23 Oct 2023 11:59:53 -0700 (PDT)
Received: from arisu.mtl.collabora.ca (mtl.collabora.ca [66.171.169.34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: detlev)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 206F26606F65;
        Mon, 23 Oct 2023 19:59:51 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1698087591;
        bh=eQgHu1xMr2KP/d+OA0vKdrgBiUwDt18CfeYteHCKys8=;
        h=From:To:Cc:Subject:Date:From;
        b=XBenG6Kpi3ewP4pgZVWuXYWjUp7/aunoEmWT2JBwknt+2fFs+FczyUsS+BBf9KfpI
         EwTXMNGTkYssJVVdmu2O2Pr4/9KzzUSf1FGLXTR/toVtTAsMb7EA/24eC1XTqx8gBm
         42eZydmsfwPsbI3HJhm1qTrRToHO559gbVSsqcGxXxw8vMyZPNWLfTh07qEv9s8iXE
         /8+8ZxeI3i2dq65OLs9CSFVpzUjvaOD64NR2Kb+5/UUpiEaE58ugM8LgfmRXh2eGVj
         IcbVf/1r3fOudoTKR5ktmZWh9JK5uZDXinv8B4TkhRCdyseDFHA3x4P2TCm26KDBWQ
         fgoFsOmjQWjAg==
From:   Detlev Casanova <detlev.casanova@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-media@vger.kernel.org,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Detlev Casanova <detlev.casanova@collabora.com>
Subject: [PATCH 0/5] visl: Adapt output frames for reference comparison
Date:   Mon, 23 Oct 2023 14:58:20 -0400
Message-ID: <20231023185850.67082-1-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.41.0
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

When using visl in automated tests, we need to have output frames that
can be compared to reference frames or hash of those to validate that
the whole pipeline is working properly.

Add a "stable_output" module parameter to make sure that a given input
stream always outputs the same frames.
This is done by skipping information like queues status and pointer
values.

This also adds some stable variation in the frames so that different
input give more different output.

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

