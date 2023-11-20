Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BAE77F0C8E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 08:10:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231982AbjKTHKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 02:10:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231961AbjKTHKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 02:10:20 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7236890
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 23:09:52 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6cb749044a2so1193941b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 23:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1700464192; x=1701068992; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xDXgdvBF8SGkmuOKaF3k84DyeZ6d8AGkWTc0p0lsSHQ=;
        b=jWdDEspXc6PbaClYTQwr4ZAi5Sz9KyMBuUu+HM1erxrM5lT+cuXyNLxP5BsuJQ6KzI
         GQehoUXYVBlehwt9ynzXvnTBOYGw2RBn2ooIj66rzY0gq6S+8uYZ7O3mOyTU7KYa+WqZ
         S20jyIf6IcVxwhKagoRG3L4oH95X+3h8n9x8kq2UshAwxtLYQrDoARVhakpC8eL1Eslg
         kmX7FJYi761az7Aq02gIzO/VxeDRvzW50HNcbo6a3WSnGZI4WjMH5gloah19U4qAJfu+
         PLG3n8bwYsTAJIQQGvV58ELlLyHv4wnrEzpm/9VuPTMH38KUEWiQcCBHo62dZMyUmkO1
         Zxjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700464192; x=1701068992;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xDXgdvBF8SGkmuOKaF3k84DyeZ6d8AGkWTc0p0lsSHQ=;
        b=IqZ5Gq4Cpgiu6Wghl75/WSTSrM7ENqn1sXyp7KdAL3FUf3nLG4DevqatQz74kMPXsv
         8ih0Ha9E8xLtghAprQHj7Pok/Pnl4J8ntzlYoMFUzIpxihYOhy2EnMKYdBukw8wA+32O
         q4tb646xrkIZnECUFR1JQzwyTi25JmfX7fXfW8IKH/XkQus36PRw/ToZGmq8FZDBzj5i
         jLDL+X8IooIv4pNp9I/6ETX+rsR1+om40faxxypg+9qKi1gsJ5/SDi0gCsB89/epUTp8
         6MEJjcbj3Q84m+JP69+drEkIO8g3z8dldAYvPEKRkWdm/XaYL2iJxKsVdXNpPbnf77Yh
         uHIw==
X-Gm-Message-State: AOJu0Yyj3M9Ht7W6q1AgtWVpdhGO2MrmWTF690kmHiyqW/YQ19PLwRD4
        yx49gpxs31QLabU+HBp0cTQGIQ==
X-Google-Smtp-Source: AGHT+IGJE4hsoqm+r24IeZOFHkx+hmxgKm2kILrlPXanw2ck3SX21MesbDLtGeVk1MgQnrbMWYj31g==
X-Received: by 2002:a05:6a20:549e:b0:187:d93f:b0fa with SMTP id i30-20020a056a20549e00b00187d93fb0famr9365915pzk.27.1700464191937;
        Sun, 19 Nov 2023 23:09:51 -0800 (PST)
Received: from GL4FX4PXWL.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id d4-20020a170902cec400b001ce67fab3a2sm3698143plg.261.2023.11.19.23.09.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 19 Nov 2023 23:09:51 -0800 (PST)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com, dan.carpenter@linaro.org,
        akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH v2 0/5] Some cleanups of maple tree
Date:   Mon, 20 Nov 2023 15:09:32 +0800
Message-Id: <20231120070937.35481-1-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are some small cleanups of maple tree.

Just to mention, in v1, I forgot to CC LKML, but it has been added in this
version.

Changes since v1:
  - Removed the 'return' statement from [1/5].
  - Made slight modifications to the commit log of [5/5].

v1: http://lists.infradead.org/pipermail/maple-tree/2023-November/003047.html

Peng Zhang (5):
  maple_tree: Move the check forward to avoid static check warning
  maple_tree: Avoid ascending when mas->min is also the parent's minimum
  maple_tree: Remove an unused parameter for ma_meta_end()
  maple_tree: Delete one of the two identical checks
  maple_tree: Simplify mas_leaf_set_meta()

 lib/maple_tree.c | 45 ++++++++++++++-------------------------------
 1 file changed, 14 insertions(+), 31 deletions(-)

-- 
2.20.1

