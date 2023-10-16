Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAD587C9DB4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 05:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbjJPDW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 23:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjJPDW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 23:22:57 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80045DA
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 20:22:55 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6bd96cfb99cso500374b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 20:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697426575; x=1698031375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r3L72Q2C0A6XyhsC7UMGOLSZK5Azm/i+GpPRU3MZq4Q=;
        b=abKwRmNnzlGZCY3tRMgEIeqabVUqnrsc73kFTdzliIaUuGYlhaNGFPSBwpUdMKBZI0
         nAZ/zX/RT2dcOPTOzY80G3FmbYSCtTUEOhkqOeUi2Z9w/Fv7GvPz9At3CaZ0OeoPNHdI
         ExT7GHm6YipgEFfgIjRgLptN519oO2XosJj+hOg2LqcXaN6vK9u8fIHc9jCfanV/Ws2h
         D1tvDrsBv4NHs4IU+UDdddoqueVIfdnVeZVX3E7V0X7dDPulw3WfvC30rlLhNjo51jxw
         ObHoaRU2hMg9yZzrjKNUENfzlUqNOMGUFLAg8U1EnbM/Rk1YNG6Vksxyb3Dxu99T6P+5
         TcQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697426575; x=1698031375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r3L72Q2C0A6XyhsC7UMGOLSZK5Azm/i+GpPRU3MZq4Q=;
        b=guaPBmsJEiYvmxLw9HwOKCyvcu0fM0GckbpAGwfVEeU47aedf4SzOIszOhZrLd1SV+
         +MDSa5Cgry1AA+DCl72DsNjKuYYxO+vbdZ3i1FZbzkZKWU3MhoiBDgWS7nz+l9IiLiXA
         3vuzLdFBRlvyunMyEd6uR7ZwbEItsf8o8rYCJC68GBGqwmqWcSUQR7B0hrFrH4brOrMM
         dsqZLupxisJkaEpvg7RaYbPQ1GDtoPDpDRAL7+zU462hjMUz+bpVGcndgl1JF9NxVH1q
         V35QWNDtvekjDMQfiZpgQtVVljugaTFNgn8miMuNWP3KeDNoQEjjQG+uV7FKGZamBL2O
         StSg==
X-Gm-Message-State: AOJu0Yz1FF+ytTUf/uTDxEDlnyIElCmnBax0o792WYOiSQEUyrxx6FAx
        KQ+FSKn+2p68pXYUOksi1H0wrA==
X-Google-Smtp-Source: AGHT+IF6N8e9Loe20mQNUBXUIhiXmTkb8m7FtzL5gkme8mgEaofINIog9sVAbKEQ8545hYi479/lHg==
X-Received: by 2002:a05:6a20:1613:b0:15d:9ee7:180a with SMTP id l19-20020a056a20161300b0015d9ee7180amr33444332pzj.4.1697426575048;
        Sun, 15 Oct 2023 20:22:55 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.232])
        by smtp.gmail.com with ESMTPSA id d8-20020a17090ae28800b0027758c7f585sm3452770pjz.52.2023.10.15.20.22.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 15 Oct 2023 20:22:54 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com, corbet@lwn.net, akpm@linux-foundation.org,
        willy@infradead.org, brauner@kernel.org, surenb@google.com,
        michael.christie@oracle.com, mjguzik@gmail.com,
        mathieu.desnoyers@efficios.com, npiggin@gmail.com,
        peterz@infradead.org, oliver.sang@intel.com, mst@redhat.com
Cc:     zhangpeng.00@bytedance.com, maple-tree@lists.infradead.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v5 02/10] maple_tree: Introduce {mtree,mas}_lock_nested()
Date:   Mon, 16 Oct 2023 11:22:18 +0800
Message-Id: <20231016032226.59199-3-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20231016032226.59199-1-zhangpeng.00@bytedance.com>
References: <20231016032226.59199-1-zhangpeng.00@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some cases, nested locks may be needed, so {mtree,mas}_lock_nested is
introduced. For example, when duplicating maple tree, we need to hold
the locks of two trees, in which case nested locks are needed.

At the same time, add the definition of spin_lock_nested() in tools for
testing.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 include/linux/maple_tree.h     | 4 ++++
 tools/include/linux/spinlock.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
index d01e850b570f..f91dbc7fe091 100644
--- a/include/linux/maple_tree.h
+++ b/include/linux/maple_tree.h
@@ -256,6 +256,8 @@ struct maple_tree {
 	struct maple_tree name = MTREE_INIT(name, 0)
 
 #define mtree_lock(mt)		spin_lock((&(mt)->ma_lock))
+#define mtree_lock_nested(mas, subclass) \
+		spin_lock_nested((&(mt)->ma_lock), subclass)
 #define mtree_unlock(mt)	spin_unlock((&(mt)->ma_lock))
 
 /*
@@ -406,6 +408,8 @@ struct ma_wr_state {
 };
 
 #define mas_lock(mas)           spin_lock(&((mas)->tree->ma_lock))
+#define mas_lock_nested(mas, subclass) \
+		spin_lock_nested(&((mas)->tree->ma_lock), subclass)
 #define mas_unlock(mas)         spin_unlock(&((mas)->tree->ma_lock))
 
 
diff --git a/tools/include/linux/spinlock.h b/tools/include/linux/spinlock.h
index 622266b197d0..a6cdf25b6b9d 100644
--- a/tools/include/linux/spinlock.h
+++ b/tools/include/linux/spinlock.h
@@ -11,6 +11,7 @@
 #define spin_lock_init(x)	pthread_mutex_init(x, NULL)
 
 #define spin_lock(x)			pthread_mutex_lock(x)
+#define spin_lock_nested(x, subclass)	pthread_mutex_lock(x)
 #define spin_unlock(x)			pthread_mutex_unlock(x)
 #define spin_lock_bh(x)			pthread_mutex_lock(x)
 #define spin_unlock_bh(x)		pthread_mutex_unlock(x)
-- 
2.20.1

