Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5806F7993CF
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 02:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345662AbjIIAhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 20:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345620AbjIIAhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 20:37:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16D41FF2;
        Fri,  8 Sep 2023 17:37:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6524C433B6;
        Sat,  9 Sep 2023 00:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694219783;
        bh=AkuarkZMuJJZPf+ahKIOj9/X2xOBJEBgJWmh7M136CE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VxuiU9W7BhAQhb+c6+TnKrygLF9mNYn8QBOkONy7CD+Bj7j0tXmc8gtPdlkmiZ0XZ
         M2DjL74wcq1EFf+ygQUzeVIUmXjYgbdC0nP/iL7xtyk1KV3wimnmYLwWbMiQtVyhV5
         DHPHBVXXhYQXP6lu4Pf0GZFkudl5k++lhRZ7gn1l95BzN1KoWzr+/iaicCndZZltsP
         y+Ng0E3PlrEV9g39RLo6QPE6mgJFSIAWoipPp1R7f2BPVN0G6nBsgGfsK38isUfLa2
         BYqbWY7iU5uDZR3VBiwcZKFDCKZURjm+Xidnutg0ofpNlGOzkliLUIUK39af+ZiDw+
         dcTWGaFMwOQyA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sasha Levin <sashal@kernel.org>, crope@iki.fi,
        mchehab@kernel.org, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 6.5 10/28] media: tuners: qt1010: replace BUG_ON with a regular error
Date:   Fri,  8 Sep 2023 20:35:44 -0400
Message-Id: <20230909003604.3579407-10-sashal@kernel.org>
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
index 3853a3d43d4f2..a7b19863f489e 100644
--- a/drivers/media/tuners/qt1010.c
+++ b/drivers/media/tuners/qt1010.c
@@ -345,11 +345,12 @@ static int qt1010_init(struct dvb_frontend *fe)
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

