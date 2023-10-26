Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA79D7D7F7F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 11:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344625AbjJZJYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 05:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344572AbjJZJYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 05:24:11 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C02B6186;
        Thu, 26 Oct 2023 02:24:09 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id 41be03b00d2f7-51f64817809so81601a12.1;
        Thu, 26 Oct 2023 02:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698312249; x=1698917049; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ydp47NijRNhsTd2ijrQYlgBAO7+uhRDGUkD8hJL4r/Q=;
        b=WEhn/7GI1vD8PGRG0bZDsj4neEVzlZk4sX6Ha/mIpD6a1GKw33/vZ9UssMLEBzWUFe
         8TNCzdbZ5EBqwaZKmDfSJC06O4XtsuKKcYOz6pfOOQXf5cJyIKLwy2bdvuorzbG6FUAB
         EPYe1AxTGgLY16n8Lrdl1EZsScNAYPE3io6rbOD7jk85e1/qUk1hLI+VAs5BsRv9n2Pd
         CeINLS6fOgvieapzCm+ZRIMAW0WGUFgIepv1Wz6aK8ke4OoZ4dsOW92KixRguZKRlcXA
         t9hRIPz5ie+5ItoJGWpmht+8EYVw+X9LkSRG4WZ1bCAChbNsd97rq8nMr+JkoZA/0ZKL
         il8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698312249; x=1698917049;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ydp47NijRNhsTd2ijrQYlgBAO7+uhRDGUkD8hJL4r/Q=;
        b=Vao0TCQYgD/KAfSkFEUR0yMTGX/wKqaes3q/V7vINEi5l1EBGlHw5zLWRB2x86p1SD
         Mc/51W/xG99Cznd5HIybIYe0LxvQm6bKJVT4qpvgW0Ru6lcTFHhkwoQHD39qGuSCOpsi
         LkbVLX9nVV2n7+lObrKap4ekXHJ5ha7p0I3LlXXACJlRoZOfc1HXx51IzMitlLIecaBh
         JoQU+YxwkV+FnrzfqT70P3hPit6P5n2sxS53SHNC5mr57VfM3lv0ACZE8GZvCNbARWFx
         vmTvwMBoSF3p5Qm92hhb1GI9EeDZbUciyF3tP2XM++pFeZYPC8kcnpDyDjNnjAfHGPNp
         fxyg==
X-Gm-Message-State: AOJu0Ywf5DjArtVIgXV2fMMT/J47SoQqrEI4VpAVliWqCV5tZgFSRdaO
        CFfLqxYeSxbUPp66qhv0P/I=
X-Google-Smtp-Source: AGHT+IGfiG4RI6qZ5xW5/G8usOancHujsybQ3U9PcSZMmC3jNU05tZxIxnVEK0f2M/KW6+GrqwY91w==
X-Received: by 2002:a05:6a20:8f05:b0:163:57ba:2ad4 with SMTP id b5-20020a056a208f0500b0016357ba2ad4mr21534848pzk.2.1698312249140;
        Thu, 26 Oct 2023 02:24:09 -0700 (PDT)
Received: from hbh25y.mshome.net (059149129201.ctinets.com. [59.149.129.201])
        by smtp.gmail.com with ESMTPSA id f11-20020a170902ce8b00b001c5076ae6absm10565631plg.126.2023.10.26.02.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 02:24:08 -0700 (PDT)
From:   Hangyu Hua <hbh25y@gmail.com>
To:     ericvh@kernel.org, lucho@ionkov.net, asmadeus@codewreck.org,
        linux_oss@crudebyte.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, jvrao@linux.vnet.ibm.com
Cc:     v9fs@lists.linux.dev, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hangyu Hua <hbh25y@gmail.com>
Subject: [PATCH] net: 9p: fix possible memory leak in p9_check_errors()
Date:   Thu, 26 Oct 2023 17:23:51 +0800
Message-Id: <20231026092351.30572-1-hbh25y@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When p9pdu_readf is called with "s?d" attribute, it allocates a pointer
that will store a string. But when p9pdu_readf() fails while handling "d"
then this pointer will not be freed in p9_check_errors.

Fixes: ca41bb3e21d7 ("[net/9p] Handle Zero Copy TREAD/RERROR case in !dotl case.")
Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
---
 net/9p/client.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/9p/client.c b/net/9p/client.c
index 86bbc7147fc1..6c7cd765b714 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -540,12 +540,15 @@ static int p9_check_errors(struct p9_client *c, struct p9_req_t *req)
 		return 0;
 
 	if (!p9_is_proto_dotl(c)) {
-		char *ename;
+		char *ename = NULL;
 
 		err = p9pdu_readf(&req->rc, c->proto_version, "s?d",
 				  &ename, &ecode);
-		if (err)
+		if (err) {
+			if (ename != NULL)
+				kfree(ename);
 			goto out_err;
+		}
 
 		if (p9_is_proto_dotu(c) && ecode < 512)
 			err = -ecode;
-- 
2.34.1

