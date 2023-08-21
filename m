Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A69D6782537
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 10:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233927AbjHUIQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 04:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232273AbjHUIQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 04:16:11 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64320BB;
        Mon, 21 Aug 2023 01:16:06 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-1c4d8eaa8ebso2051551fac.0;
        Mon, 21 Aug 2023 01:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692605765; x=1693210565;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6DgAKg3qHk5I2mBtpVL40HuGEIJCVTC6eN4jhKIOAVA=;
        b=Svh4UXrwWoiKX4ozJj/LL3scNaV2VwZPR+v0kYkp/zdwv10mywINQIC5xuvm05SfZC
         U4vgNCu+R392TPWJjGDNVNJCMTR6C5CgAkCEBJPfSkU0o4rFJgsp+pNsCugpxbhFFrbY
         34hcQSG2khZA2CS3HKJ1sCNnYdlFBMuv3Eqdcr7wEnC96w5LG+C1RKTa4XIqB/HVipoh
         hhLvoUK0K5rzjkXsehk30UxvBfwsVbF8fQVTugKFGz351CIfqCGzBwYArzqqKTDd1I/0
         u3TxoK1f6u8Yoplrn4pBdRcw1Hew3gXdQiCFiY0n0Vkd0pZPwBULZgbh16pPJPKnqB3s
         uwfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692605765; x=1693210565;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6DgAKg3qHk5I2mBtpVL40HuGEIJCVTC6eN4jhKIOAVA=;
        b=O+YVGp5oB8ZwzBxOFr71Jqoppyn1VSxQ3qeB3nIYi3SFAIAvH/udbKfAS9J/2ArymR
         09nZdHb+vUZvEorrnyRC0WLJqq+5VmJR/ilZuxb6ma8O/mVHR5b4IIpDoviSBYIYwA3q
         2n91E21njsbQaL8iUG/6HxtVAv1wVtwBLhPSdh88D4oJFEgp/AarJysvlMVtPNbpy77Y
         egbG0bp4tmWObQ8bNJDf/u0KQFT/113YJ/uqacIfL2E2mlCh+cvEgOuQrMKV2msxhfZc
         l73J579N7vXo++urWwbW6QRRRCmi0F1ktLi81div0dIm9MYXx7uXV9VGspmCbgB8rDE9
         3nQw==
X-Gm-Message-State: AOJu0YzWp6DE2EPfWniuaL1WHgjHoeU3cPdgUd8Xwgz/fwPw2BiLnx3y
        ic9XcB0UbOegW/5QEnqyyfo=
X-Google-Smtp-Source: AGHT+IE1dGo58N3EiQ7SvmfNbPEBuUVwI/PVJQEDkDawAlW5SVTKoZL+ZojblsKw8Cuj3hXELxRgGg==
X-Received: by 2002:a05:6870:d14a:b0:1bb:fd78:4f22 with SMTP id f10-20020a056870d14a00b001bbfd784f22mr7593342oac.34.1692605765589;
        Mon, 21 Aug 2023 01:16:05 -0700 (PDT)
Received: from localhost.localdomain ([2409:40c2:1010:c230:b0ad:364d:f97a:aa9d])
        by smtp.gmail.com with ESMTPSA id s2-20020a17090a764200b002630c9d78aasm5510078pjl.5.2023.08.21.01.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 01:16:05 -0700 (PDT)
From:   coolrrsh@gmail.com
To:     hverkuil@xs4all.nl, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        Rajeshwar R Shinde <coolrrsh@gmail.com>,
        syzbot+e27f3dbdab04e43b9f73@syzkaller.appspotmail.com
Subject: [PATCH v2] UBSAN: shift-out-of-bounds in set_flicker
Date:   Mon, 21 Aug 2023 13:45:59 +0530
Message-Id: <20230821081559.13807-1-coolrrsh@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajeshwar R Shinde <coolrrsh@gmail.com>

UBSAN: shift-out-of-bounds in drivers/media/usb/gspca/cpia1.c:1031:27
shift exponent 245 is too large for 32-bit type 'int'

shift-out-of-bounds error was triggered when variable 
'sd->params.exposure.gain' is greater than the number of bits of int.
When the variable 'currentexp' is left shifted beyond 31 bits then
the error is produced. Therefore added the conditional expression to 
verify valid range.

Tested via syzbot.

Reported-by: syzbot+e27f3dbdab04e43b9f73@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/20230818164522.12806-1-
coolrrsh@gmail.com/
Link: https://syzkaller.appspot.com/bug?extid=e27f3dbdab04e43b9f73
Signed-off-by: Rajeshwar R Shinde <coolrrsh@gmail.com>

---
v1->v2
changed the patch
changed commit message and tested with checkpatch 

---
 drivers/media/usb/gspca/cpia1.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/usb/gspca/cpia1.c b/drivers/media/usb/gspca/cpia1.c
index 46ed95483e22..dafc522d5e7b 100644
--- a/drivers/media/usb/gspca/cpia1.c
+++ b/drivers/media/usb/gspca/cpia1.c
@@ -1028,6 +1028,8 @@ static int set_flicker(struct gspca_dev *gspca_dev, int on, int apply)
 			sd->params.exposure.expMode = 2;
 			sd->exposure_status = EXPOSURE_NORMAL;
 		}
+		if (sd->params.exposure.gain > 31)
+			return -1;
 		currentexp = currentexp << sd->params.exposure.gain;
 		sd->params.exposure.gain = 0;
 		/* round down current exposure to nearest value */
-- 
2.25.1

