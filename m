Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B69687598E2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 16:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbjGSO4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 10:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbjGSOzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 10:55:40 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26505C7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 07:55:39 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-51e57874bfdso9890665a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 07:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brixit-nl.20221208.gappssmtp.com; s=20221208; t=1689778537; x=1690383337;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bz36UCyZvhK5ImAPfX/8b57agUtYhAfBWMkUTD8b+IQ=;
        b=WQGZyAI7rm3pERIjqORRkLifB2HjLWnL0y7Cytm9LJO+zPgHU9WhLJR9S/Hocn6vRf
         n8hts+SCBfGQLfTZHkhcwkzfNdIMnPeDt8faU1wq2n3vCw+XuMFm1e0whavNQYGqOCie
         dPJwuYzTj1yyDDB+RbsinMmYuEGr+NiO58DlIKRiYXAki3icpT4E5r3SnO55eo+krTvQ
         TL8blYRdXmT1zNz0sbNXlSaulTrMbtBXsCz9yUJ3eF6FHdN2AyY2ihicpKd+As7YsDGO
         lJNgr0BDt9HhwtaF1uJFqhpHYMh8d66Yfm/zsXkrsAUkei3kLmPF76bi9CVz5hFl2MCc
         t9SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689778537; x=1690383337;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bz36UCyZvhK5ImAPfX/8b57agUtYhAfBWMkUTD8b+IQ=;
        b=VtngqOQpdFEzbnmWmUJhUkbu7Js4ccKv37xADlkH2Ab5cNeEWZovShMMW4HCxQWaaY
         gxbtSeuhvGf4tWok49nBnxywou33LsntLdIosl6Le5gTh+lJfFhVHIe9W+vyA2yk6Qz3
         Iga8BGFPb7FA3Swgug9i7uKbwt8XqackL6BB0ZOcbrwdNPhpwr9N1cLLEP+6Il1M4X4T
         boG0607oLMLOXpUC4wUGq832tfjF57z/PRldub8SVyDTdkSqeFV+8K/I4g8OMGE2fZyv
         uFtXrmm2FeszwRGkUeGrYqRVMYfpWRE4vDlNt2EmuP2DL5s5CiRhfjP5u8y30MzI8mQb
         A0Og==
X-Gm-Message-State: ABy/qLbwuhpDD0m3Lhxfgu9X9BgHTH75Ith+gaiQIOBlMdCtNwXQ2rLv
        TJxB7m1gC4b9VPJ1pnPCq/q1CQ==
X-Google-Smtp-Source: APBJJlGEhZDD5wK6dURkl5u/39BDG2xrhDPhBwSlvx2AFDK4qhGCyr4f/kVymiKRwy3S88vZabea6g==
X-Received: by 2002:a17:906:7386:b0:994:5396:e322 with SMTP id f6-20020a170906738600b009945396e322mr2712499ejl.1.1689778537344;
        Wed, 19 Jul 2023 07:55:37 -0700 (PDT)
Received: from msi.net.brixit.nl (2a00-bba0-120c-9f00-7a8e-8795-650f-7c4e.static6.cust.trined.nl. [2a00:bba0:120c:9f00:7a8e:8795:650f:7c4e])
        by smtp.gmail.com with ESMTPSA id jx26-20020a170906ca5a00b0098d15d170a0sm2397794ejb.202.2023.07.19.07.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 07:55:36 -0700 (PDT)
From:   Martijn Braam <martijn@brixit.nl>
Cc:     Martijn Braam <martijn@brixit.nl>,
        Dafna Hirschfeld <dafna@fastmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: rkisp1: Promote link validation error to dev_err
Date:   Wed, 19 Jul 2023 16:55:33 +0200
Message-Id: <20230719145534.9812-1-martijn@brixit.nl>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Show an error when the pipeline cannot start due to an invalid link
instead of hiding it behind the debugging system.

Signed-off-by: Martijn Braam <martijn@brixit.nl>
---
 drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
index 8f3cba319762..9361b9086f6b 100644
--- a/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
+++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-capture.c
@@ -1340,7 +1340,7 @@ static int rkisp1_capture_link_validate(struct media_link *link)
 	if (sd_fmt.format.height != cap->pix.fmt.height ||
 	    sd_fmt.format.width != cap->pix.fmt.width ||
 	    sd_fmt.format.code != fmt->mbus) {
-		dev_dbg(cap->rkisp1->dev,
+		dev_err(cap->rkisp1->dev,
 			"link '%s':%u -> '%s':%u not valid: 0x%04x/%ux%u != 0x%04x/%ux%u\n",
 			link->source->entity->name, link->source->index,
 			link->sink->entity->name, link->sink->index,
-- 
2.40.0

