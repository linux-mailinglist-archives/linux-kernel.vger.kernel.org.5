Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAB837993E8
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 02:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345677AbjIIAhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 20:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345622AbjIIAhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 20:37:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CFA12100;
        Fri,  8 Sep 2023 17:37:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECD22C433AD;
        Sat,  9 Sep 2023 00:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694219786;
        bh=ko+pqNWksD/RYc3sPMkpWyLd6kvvXze6RtWJ7kUNM98=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JZCTB/g6cEW3Dxrg/X5qipqiWkgq+f+xzk41IA9WnvVk0yWmEbKaKYSV2jOBVJaUD
         Tathjy6nTV7sOgGpub/L35CPei01wskQKLhB6rrqoMnAMmEgc1tl8iNfBCmNVc2gLv
         AfrksR5c3cu8LEQZDggSshwpuxCFoImw5H1Zb6QZdGIwOGZgyroObd1Qkf6Pdw6Ltx
         1PD9T5ofnC9mO1/Vb6/Eu+z1WjM+Ac16trSXWHFA6hK3m9BGy+/RmFsVKtulfLP6A/
         A4qawMDldFUs2FLQ5oHjAJA/UAXeA+zizHM05gqaN1fNp5No/GxHMBODMWMs2vH7vt
         Z0qsrp8VcB06w==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sasha Levin <sashal@kernel.org>, mchehab@kernel.org,
        harperchen1110@gmail.com, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 6.5 11/28] media: pci: cx23885: replace BUG with error return
Date:   Fri,  8 Sep 2023 20:35:45 -0400
Message-Id: <20230909003604.3579407-11-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230909003604.3579407-1-sashal@kernel.org>
References: <20230909003604.3579407-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.2
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans Verkuil <hverkuil-cisco@xs4all.nl>

[ Upstream commit 2e1796fd4904fdd6062a8e4589778ea899ea0c8d ]

It was completely unnecessary to use BUG in buffer_prepare().
Just replace it with an error return. This also fixes a smatch warning:

drivers/media/pci/cx23885/cx23885-video.c:422 buffer_prepare() error: uninitialized symbol 'ret'.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/pci/cx23885/cx23885-video.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/pci/cx23885/cx23885-video.c b/drivers/media/pci/cx23885/cx23885-video.c
index 671fc0588e431..9af2c5596121c 100644
--- a/drivers/media/pci/cx23885/cx23885-video.c
+++ b/drivers/media/pci/cx23885/cx23885-video.c
@@ -413,7 +413,7 @@ static int buffer_prepare(struct vb2_buffer *vb)
 				dev->height >> 1);
 		break;
 	default:
-		BUG();
+		return -EINVAL; /* should not happen */
 	}
 	dprintk(2, "[%p/%d] buffer_init - %dx%d %dbpp 0x%08x - dma=0x%08lx\n",
 		buf, buf->vb.vb2_buf.index,
-- 
2.40.1

