Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E08957797EB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 21:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236343AbjHKTs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 15:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjHKTs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 15:48:29 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD737EE
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 12:48:28 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-997c4107d62so315550366b.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 12:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691783307; x=1692388107;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v6G6ZsuSoAElNftzo3kwRe5FK/2FlGxWGqeqEHPrOvI=;
        b=RxfvhmJg/lkv55d73lCUiQyY749TBwr/BUK/AUEdLGM175XjeImsC36EYmC4v3vvBT
         bePaqmfq9kimsHXkP+U1RfnmD9bOaxMjZOu6geFDBkaVfV1gmZyB1sdzg+DOa2aFOkTV
         63gzTLe1RERRAPJCMtqs/k9KdWmgP1rOcqgRGjxZCDBMgD73jWsnVSzuy98u4i6RJFrn
         I7KQBAg/2MT086+a/CUVhrIrwa14BZ9FpVCaF3fj2CrpDbVfbHsiOrbi23redqiCuEVX
         poJDRIxSkJuX8yWBUyekhFO6ThUnIkgb8aLRuPChWIva3kRkJHoug0XF3Nh8YVnxeShR
         vPaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691783307; x=1692388107;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v6G6ZsuSoAElNftzo3kwRe5FK/2FlGxWGqeqEHPrOvI=;
        b=kMRgwwXPnAsS/vwqsNRH99J78JK5NVJ6Lm8RnlJj2CScsTvck5tPTxRr4MFoEZjPHh
         lgAuialiHQRY4PF3bmBkiGyOO0kS8/cO1zvYMaHoUPH6uS+wcScYQjR//YVwv1e3lpkD
         i/98NYnUlWIwx0QCH2S5dfevHUTv+5bqpV/IkaYFT1qZRSBUWfPK1YUiibnyQvhl+/K1
         gtduAD5UI7EOzueqJvlzQ5k4IQYbgrvloa1GtJjsnQHIONbIuAuE8tKcaUj/3GvKm9Pj
         k+FcwGf2ShQUVbv7Rk0UHY9onKLoPozExjRhU0Dqe5IOH3di4yCy82m2dHF8EzWbDSp7
         sQJw==
X-Gm-Message-State: AOJu0YyFDwbLr4Gif2pJLJz3YLZHaiZWY0JNb/N7Ok0GWCC9KEKc2+q4
        op5KXJ7p2e6T+idU0LVVMpU=
X-Google-Smtp-Source: AGHT+IG/104ukHsu031mGOY3ApsPQB0S/3+LRE1H7tiS+p7BVerjVJesajVY6QqMuoA5QLtG2PwWkA==
X-Received: by 2002:a17:906:7488:b0:99c:1c8e:ac20 with SMTP id e8-20020a170906748800b0099c1c8eac20mr2423950ejl.22.1691783306898;
        Fri, 11 Aug 2023 12:48:26 -0700 (PDT)
Received: from f.. (cst-prg-75-195.cust.vodafone.cz. [46.135.75.195])
        by smtp.gmail.com with ESMTPSA id q14-20020a17090622ce00b00992ca779f42sm2598994eja.97.2023.08.11.12.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 12:48:26 -0700 (PDT)
From:   Mateusz Guzik <mjguzik@gmail.com>
To:     brauner@kernel.org
Cc:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] vfs: fix up the assert in i_readcount_dec
Date:   Fri, 11 Aug 2023 21:48:14 +0200
Message-Id: <20230811194814.1612336-1-mjguzik@gmail.com>
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

Drops a race where 2 threads could spot a positive value and both
proceed to dec to -1, without reporting anything.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 include/linux/fs.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 562f2623c9c9..21c8f8ae014d 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2613,8 +2613,7 @@ static inline bool inode_is_open_for_write(const struct inode *inode)
 #if defined(CONFIG_IMA) || defined(CONFIG_FILE_LOCKING)
 static inline void i_readcount_dec(struct inode *inode)
 {
-	BUG_ON(!atomic_read(&inode->i_readcount));
-	atomic_dec(&inode->i_readcount);
+	BUG_ON(atomic_dec_return(&inode->i_readcount) < 0);
 }
 static inline void i_readcount_inc(struct inode *inode)
 {
-- 
2.39.2

