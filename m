Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6287ACBB6
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 21:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231432AbjIXTvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 15:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbjIXTu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 15:50:59 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FAE3FA
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 12:50:53 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-3224c229d31so802683f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 12:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695585051; x=1696189851; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ad41TGXwIahQ49MHw+UdUbfiHlgxk7kDHjA1x4UOf8E=;
        b=iIosmKJhwRXo2fu6OuvkG0zG0Iu5Np4YrBPTgMdpB+WIab95Mt5QgOQCp0Zi1zLX9x
         AYj9KHfCjZj88XwDIwM6nql1sSl8xev5eOV8vxxLYvWiPPa5F45bSEpj/GzZmE1VBigf
         AznIfFnWH35b1CDK0fyLAcxYsP+44p0v3+Tq+CQM++/V9nA7N2iodVCMxuat4BPTkEsC
         hl4eV2HVWJaTdSnudREKWmrLPDyYvE7zDG6rr2BKDH+ODHRkzfYQE7xRHpqCSBoAp03r
         fNp76Dywfh35WpBGVOvHV5wEWYhJRLiUdy2j/OMh0r+Ak3eGyy+1QSHgA6Wnz4LS+CBG
         Pb9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695585051; x=1696189851;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ad41TGXwIahQ49MHw+UdUbfiHlgxk7kDHjA1x4UOf8E=;
        b=U6kspouQB3Ly5PSmNTb447Xq/vnH56ZYjCTo3cHvmv9lpdmsCcI7I588tqRjJKLsSk
         E1VFvn7nr4D0MxBtmx/3X5bwJLpHepGKN9uCzIgW0JjAzFiwVH7X4sFZMZlISnrJzlET
         5vhZEuia5vD8LOMVv/P7jMf069xhL1TPzjHhpI4y6Ay9MsxwVC+vnHXskknrNs8RSGmG
         1anbSPtSQPrHebzH0JnCx8gqSBG8F+K2mhQ1fUi3czvoYznWx29SkyUweUp+jQOfV/KT
         KaU6l4+cwNXNyziKLpx1HhxXRTV+9zWCc3r8Wjy2H12bTUv8570LWye2a4f2kZf9oOrV
         ruOw==
X-Gm-Message-State: AOJu0YxLIXg2o9jTMgggL59XG0e40AHWN2yyaWwnNcbQFPQyPxpIVQWz
        Xu+oUR1JFe7AQ44omSHy1gfjs9Tpir8=
X-Google-Smtp-Source: AGHT+IGNP2pZpAtLJmnr9Np23Qt3h8YDzNGMTMBeRErqYnZDanSXWZ4oGsDt2pHasl8f/J/F1MMmbw==
X-Received: by 2002:adf:d087:0:b0:320:b1e:7e6c with SMTP id y7-20020adfd087000000b003200b1e7e6cmr3764106wrh.3.1695585051315;
        Sun, 24 Sep 2023 12:50:51 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id n14-20020a5d400e000000b00321773bb933sm10020959wrp.77.2023.09.24.12.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Sep 2023 12:50:51 -0700 (PDT)
Date:   Sun, 24 Sep 2023 21:50:49 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] staging: rtl8192e: Put kfree() to end of
 rtllib_softmac_free()
Message-ID: <85b63c62780356af91c30cc63280c5f59cd29210.1695582999.git.philipp.g.hortmann@gmail.com>
References: <cover.1695582999.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1695582999.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To reverse order of initialization put kfree() to the end of
rtllib_softmac_free().

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/rtl8192e/rtllib_softmac.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 982578e1c0af..d3468b646ca8 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -2462,8 +2462,6 @@ int rtllib_softmac_init(struct rtllib_device *ieee)
 void rtllib_softmac_free(struct rtllib_device *ieee)
 {
 	mutex_lock(&ieee->wx_mutex);
-	kfree(ieee->dot11d_info);
-	ieee->dot11d_info = NULL;
 	del_timer_sync(&ieee->associate_timer);
 
 	cancel_delayed_work_sync(&ieee->associate_retry_wq);
@@ -2476,6 +2474,9 @@ void rtllib_softmac_free(struct rtllib_device *ieee)
 	cancel_work_sync(&ieee->ips_leave_wq);
 	cancel_work_sync(&ieee->wx_sync_scan_wq);
 	cancel_work_sync(&ieee->ps_task);
+
+	kfree(ieee->dot11d_info);
+	ieee->dot11d_info = NULL;
 	mutex_unlock(&ieee->wx_mutex);
 }
 
-- 
2.42.0

