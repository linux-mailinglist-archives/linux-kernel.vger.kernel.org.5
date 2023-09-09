Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 359F47994FD
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 02:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242200AbjIIAoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 20:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346241AbjIIAnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 20:43:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 568E12D7C;
        Fri,  8 Sep 2023 17:41:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1119DC116A8;
        Sat,  9 Sep 2023 00:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694220059;
        bh=UwfFFqlAl4P8LC4n4jYgLsPONbs3Pyu1lS+l9u6Ibzw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vA+lr0rYT36pdSTfQ2hMlJpvlLqb/f5+BHlOelAGa/f/9zVMldYTVeUXSuFZdRpoF
         SfXjjFd/mxZY4BJXHlutEZjlrELYxBJDfasEL0PcqvNn9uFyWiWgjQau/cDHeTSYc3
         Wn5voJplBqOw/EBibMWjS4nY5NtUbSuFItgDUV3qhkGc3OC5DzlxRNBBht1fgv4fjT
         B3z/r6qdNO2VTtVfw6pOs5P1aqDgSUrXUlvK9QNonLABJA6t80Z7o4HOhUFHcLWbJd
         zEEGZRHpqhWAs9bRBI/o8v+bW+o/RlgM0Iw7WPGoG8u7SY0f7BJQOo8d4GD+P/zUBe
         uHxjvFTkuQCDw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sasha Levin <sashal@kernel.org>, crope@iki.fi,
        mchehab@kernel.org, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 07/14] media: tuners: qt1010: replace BUG_ON with a regular error
Date:   Fri,  8 Sep 2023 20:40:38 -0400
Message-Id: <20230909004045.3581014-7-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230909004045.3581014-1-sashal@kernel.org>
References: <20230909004045.3581014-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.294
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

[ Upstream commit ee630b29ea44d1851bb6c903f400956604834463 ]

BUG_ON is unnecessary here, and in addition it confuses smatch.
Replacing this with an error return help resolve this smatch
warning:

drivers/media/tuners/qt1010.c:350 qt1010_init() error: buffer overflow 'i2c_data' 34 <= 34

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/tuners/qt1010.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/media/tuners/qt1010.c b/drivers/media/tuners/qt1010.c
index 6d397cc85428d..ab4688f94d8ef 100644
--- a/drivers/media/tuners/qt1010.c
+++ b/drivers/media/tuners/qt1010.c
@@ -351,11 +351,12 @@ static int qt1010_init(struct dvb_frontend *fe)
 			else
 				valptr = &tmpval;
 
-			BUG_ON(i >= ARRAY_SIZE(i2c_data) - 1);
-
-			err = qt1010_init_meas1(priv, i2c_data[i+1].reg,
-						i2c_data[i].reg,
-						i2c_data[i].val, valptr);
+			if (i >= ARRAY_SIZE(i2c_data) - 1)
+				err = -EIO;
+			else
+				err = qt1010_init_meas1(priv, i2c_data[i + 1].reg,
+							i2c_data[i].reg,
+							i2c_data[i].val, valptr);
 			i++;
 			break;
 		}
-- 
2.40.1

