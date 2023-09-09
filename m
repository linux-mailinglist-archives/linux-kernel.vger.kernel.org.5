Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 288A1799459
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 02:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235338AbjIIAki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 20:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234137AbjIIAjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 20:39:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D7832716;
        Fri,  8 Sep 2023 17:38:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8C60C116A5;
        Sat,  9 Sep 2023 00:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694219920;
        bh=ko+pqNWksD/RYc3sPMkpWyLd6kvvXze6RtWJ7kUNM98=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lpMwe6376i2SZufFio3Tc+ztnJejoVR95GSflSdJGnYeSptjPEANtMtPd9RVDJR1N
         rylDzRdVx/PXLVAjZ97TN+G2plizZld3u1cl5hjR/jdWH1QVgJdhSIxqbgsFJkYxWI
         KarDo2pP1Iq+UI4jvZdpTbvyS7BrgmMwfYh4Wlb5aTRpLjDW/zcWyOAl+w54fBfIwu
         KfWw/HG+8NZ+yZAFPtP2q6n7EO4TQfvEiaUJj7iVC/q70HA1shTUR5G9hKMKmlmVNF
         r5JrXlbyMNA8zyrV/hQLFdYgJrarlYTyAkLPV9lJ3RUzV5k6y5d2hao67x8AF6atEv
         mPK7pr04IZetA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sasha Levin <sashal@kernel.org>, mchehab@kernel.org,
        harperchen1110@gmail.com, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 11/24] media: pci: cx23885: replace BUG with error return
Date:   Fri,  8 Sep 2023 20:38:03 -0400
Message-Id: <20230909003818.3580081-11-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230909003818.3580081-1-sashal@kernel.org>
References: <20230909003818.3580081-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.52
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

