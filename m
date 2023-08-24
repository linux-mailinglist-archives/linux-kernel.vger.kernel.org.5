Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D944378681A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 09:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240216AbjHXHGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 03:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbjHXHGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 03:06:39 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 724EE10F;
        Thu, 24 Aug 2023 00:06:37 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-68bec4c6b22so554983b3a.2;
        Thu, 24 Aug 2023 00:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692860797; x=1693465597;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jVpZgWWLzSVokb3IOORkGQQJ1vh8iPrio2oddJje49k=;
        b=RnbrPX94LvmJvCuLmJN20seTHYq2nkQuJUGESbDTbxe1BLhQRuhP9fl9mLSPT7Bec3
         eIpocE2qnAsbxs4RA0ZSonZtJ6uhJM7dzB8Buqwivkb9ef0sbUbIfa10WsImiyb73+v7
         rSt8VOhI3OTAuN+X3fhakZQmhzEJxbfFs1h9s5eIluVnIbGvOit2TocsJ28bJbTxMZIb
         u/e/T8qBf1AfqWMkcQPAWQqCZbfZJKTKoZ7Jr4NjCsY3nXwZCtwdjBa0eMem8X3nUuM+
         MKRYV3QzJsx8FfwEqB95PR7dlH7nd4/Oa7686mj46O/TOW0WoTYbVyct8fdArisPdWRS
         GUJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692860797; x=1693465597;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jVpZgWWLzSVokb3IOORkGQQJ1vh8iPrio2oddJje49k=;
        b=UU1oHdLbeBuy3Xw0lb4ag/lhzon7a45aASIV7cuGNEtzinksjFWMHUljcES1mhZcgE
         F98kDbCCkc+PV/cZVGHdvC52yFm/uLg3TA3Mmjsg0UnqCX4WBdrunlIWavhOdodGXdpU
         spDHd0Oh4aYEuroBI13SjLXOD7+YxaOp+uC3C3NyU0lpa7BnE9LTtJ12B85I/CAp9lg9
         +7hMMDPgFBZli3lfg3GPN+v8SEH6nLLX3U6a9zj2zDxCUYiQ8UBXmola7lY2tgsdkhDj
         MGNJuOlqZXmGj4tybaqNw0u+IR6UIMiezo+xHQqkZr+t104iyMLITILRS9yBAIkqF6h/
         zxmA==
X-Gm-Message-State: AOJu0Yzq1azBpDAGQsZMjqULvG7qOs0DSUQxZs/RiYYcr7Ta8c0IkVhi
        NxSZkwlCVQIyut8MvyhZaLk=
X-Google-Smtp-Source: AGHT+IF3P6gF1TSimhQn/Q6PnEh6lEvcZ2jPpvjP0j7NcVYyIZ6+P9/5O2OIuCxu/Qf8zKQlXZ1DbA==
X-Received: by 2002:a05:6a00:148f:b0:68a:4d66:ca1 with SMTP id v15-20020a056a00148f00b0068a4d660ca1mr12913601pfu.6.1692860796765;
        Thu, 24 Aug 2023 00:06:36 -0700 (PDT)
Received: from localhost.localdomain ([2409:40c2:1047:2379:8974:f63f:c2f8:6a5b])
        by smtp.gmail.com with ESMTPSA id d5-20020aa78145000000b00687a4b70d1esm10436179pfn.218.2023.08.24.00.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 00:06:36 -0700 (PDT)
From:   coolrrsh@gmail.com
To:     hverkuil@xs4all.nl, mchehab@kernel.org, slark_xiao@163.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        Rajeshwar R Shinde <coolrrsh@gmail.com>,
        syzbot+e27f3dbdab04e43b9f73@syzkaller.appspotmail.com
Subject: [PATCH v2] UBSAN: shift-out-of-bounds in set_flicker
Date:   Thu, 24 Aug 2023 12:36:30 +0530
Message-Id: <20230824070630.8209-1-coolrrsh@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajeshwar R Shinde <coolrrsh@gmail.com>

Syzkaller reported the following issue:

UBSAN: shift-out-of-bounds in drivers/media/usb/gspca/cpia1.c:1031:27
shift exponent 245 is too large for 32-bit type 'int'

shift-out-of-bounds error was triggered when variable 
'sd->params.exposure.gain' is greater than the number of bits of int.
When the variable 'currentexp' is left shifted beyond 31 bits then
the error is produced. Therefore added the conditional expression to 
verify valid range.

Tested via syzbot.

Reported-by: syzbot+e27f3dbdab04e43b9f73@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/20230818164522.12806-1-coolrrsh@gmail.com

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

