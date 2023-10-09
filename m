Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 468017BD630
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 11:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345573AbjJIJEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 05:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345682AbjJIJEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 05:04:16 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF55CAC
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 02:03:55 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-690fa0eea3cso3869495b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 02:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1696842235; x=1697447035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r3L72Q2C0A6XyhsC7UMGOLSZK5Azm/i+GpPRU3MZq4Q=;
        b=C7Hhn80uXjSnkVDZ1Ws3hifc/LOJonaSh6QuNFixM3KbFXIIShUjX1FXHvr4qp494g
         Pf1OB9PXbNrgoiQmcMFPSsZDlcKAecMaNgORk7VLrv22ECXQ69bprdKj2dA2d95aJDG/
         nBQjmutWKUJBceGjFTcgYg/MBdFs8vJlUYR+yLu1qUrMIFCk7wqUFnyLt8ngW7ehnGQF
         gXMlpxL5jzrS294j+OEvl24drugnFXsTfVYDdI53xTDxkawQrQSwXIcc3cjqP0Ef3zOK
         aLSEDM7ItLVi0l6xJpneYvk8PnBsZu7ojtciIYMOv3YnZl9fJD2LVxboGPPl+1Wqp42n
         dW+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696842235; x=1697447035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r3L72Q2C0A6XyhsC7UMGOLSZK5Azm/i+GpPRU3MZq4Q=;
        b=RkL50td/rq0GzhCsew0MmM9C5JlZlsphAcSFH/KLkJcqG7WH1Pu98ZgeesFDoPxySr
         zj5ocV8lyru3gHkrROIidtCuhgSOoljo/EWU+Q7idoqjrgd9DU37EJIeSrIxhAAeE6fU
         7dPaLkuGnNPh1zlMe74dVWF+pMcZDW700SEPtXfoeytuAQSf73jbtPMQkv1oI4rMtHjD
         UiP8bSy2OWn2WubdgFoUJwDPKU7pMCm96fwj2U633iO3iK6UNctys7MUXuW9wMYVVMew
         bO1ijibUIL5Ch9Yl6j4j0BWzgdLAXj7i8rO3Ub6FhXNbPA80Gnkri1BClib5yhe0fhDh
         5X2w==
X-Gm-Message-State: AOJu0Ywo0qI18ksuxgw1seIbcCsdc+jZS1m1zLKapYdxS9z3jVhSqOzA
        z5wOhnx2wGyvuvYgnL/JR+v/4Q==
X-Google-Smtp-Source: AGHT+IFTziVEGjqko/GY6Y/gf0kzFA12JYrUPiEPy+KRrwJBQ6QE4OFwPoL+CRZrpwt2i9F5PSccSA==
X-Received: by 2002:a05:6a00:1255:b0:68a:5449:7436 with SMTP id u21-20020a056a00125500b0068a54497436mr16185349pfi.32.1696842235402;
        Mon, 09 Oct 2023 02:03:55 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id fk3-20020a056a003a8300b00690ca4356f1sm5884847pfb.198.2023.10.09.02.03.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 Oct 2023 02:03:54 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com, corbet@lwn.net, akpm@linux-foundation.org,
        willy@infradead.org, brauner@kernel.org, surenb@google.com,
        michael.christie@oracle.com, mjguzik@gmail.com,
        mathieu.desnoyers@efficios.com, npiggin@gmail.com,
        peterz@infradead.org, oliver.sang@intel.com, mst@redhat.com
Cc:     zhangpeng.00@bytedance.com, maple-tree@lists.infradead.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 02/10] maple_tree: Introduce {mtree,mas}_lock_nested()
Date:   Mon,  9 Oct 2023 17:03:12 +0800
Message-Id: <20231009090320.64565-3-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20231009090320.64565-1-zhangpeng.00@bytedance.com>
References: <20231009090320.64565-1-zhangpeng.00@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
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

