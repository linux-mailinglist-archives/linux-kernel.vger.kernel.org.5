Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAA9076907D
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 10:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbjGaIj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 04:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbjGaIjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 04:39:17 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3568C1B1;
        Mon, 31 Jul 2023 01:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=ttl1JAg1w0mUKTBhkaN+L9fgEa5IyTTOyMQJJhARt48=; b=ZKOLTQ7/+rcUK0EpU6hve6kJL6
        wTqCJ2MolH4dNgL2RVKI9J/ebwyT2G4mWUm1VNsizEh2IZIqvgCkzkNR4q3KQfL8gqSN0D8CtSCv8
        OZivql69XooHTy+GdS53nm32KE3hn30JsS3X+M9lHv/tCSYZeqbUpJFSWANl2MgqqBvPTdpnvhRSx
        igVxJcs5tXGObcUoBVBF/07eZFaecIo7p5HOrBWZgQfT3cqWRaZdoIcvEN9K6j7La0iSSTcOZ2zlw
        GWPzEuZIkcSiJryzCEG9hWLjYaEXtEq7FMwDpzplAnE0A2Nja4AQOwoVLzdORpQlSiLhLTVccJOCP
        Vra16I6A==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qQOQ3-00EYtG-2z;
        Mon, 31 Jul 2023 08:38:24 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Yangbo Lu <yangbo.lu@nxp.com>, Joshua Kinard <kumba@gentoo.org>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org (open list),
        linux-mmc@vger.kernel.org, netdev@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-modules@vger.kernel.org
Subject: [PATCH 4/5] mmc: use EXPORT_SYMBOL_GPL for mmc_detect_change
Date:   Mon, 31 Jul 2023 10:38:05 +0200
Message-Id: <20230731083806.453036-5-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230731083806.453036-1-hch@lst.de>
References: <20230731083806.453036-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mmc_detect_change is used via symbol_get, which was only ever intended
for very internal symbols like this one.  Use EXPORT_SYMBOL_GPL
for it so that symbol_get can enforce only being used on
EXPORT_SYMBOL_GPL symbols.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/mmc/core/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 3d3e0ca5261481..8ffd78fae1e7b9 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1433,7 +1433,7 @@ void mmc_detect_change(struct mmc_host *host, unsigned long delay)
 {
 	_mmc_detect_change(host, delay, true);
 }
-EXPORT_SYMBOL(mmc_detect_change);
+EXPORT_SYMBOL_GPL(mmc_detect_change);
 
 void mmc_init_erase(struct mmc_card *card)
 {
-- 
2.39.2

