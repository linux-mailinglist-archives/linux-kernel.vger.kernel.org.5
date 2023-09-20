Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7568A7A7740
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 11:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234094AbjITJYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 05:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234058AbjITJX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 05:23:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F37E9E
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 02:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695201785;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=rIy294xxcRG5X8mamyGReIFpqhnDJXgcIMqu9YASlB8=;
        b=KFSwJulw7wPIgWSaJ66ZfwLH6ol9Odck8K/PzapHaO141jIUPGRqAZICiSfl3ivRWAaUOJ
        /PA02CK+YhhB+ffUemJnTB4NQsbOKInT+AUnYPccWvUao6I82xTcUqi/2LhePLzajaLrlP
        Gc5jKl/Dc1cHyJvQoRfJhTDvrvcV4JM=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-tCsNOtWJOKya-nD_kiBVAg-1; Wed, 20 Sep 2023 05:23:03 -0400
X-MC-Unique: tCsNOtWJOKya-nD_kiBVAg-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-5031c8d5589so673911e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 02:23:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695201782; x=1695806582;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rIy294xxcRG5X8mamyGReIFpqhnDJXgcIMqu9YASlB8=;
        b=nD68EG5lNiyXTH9Mcf0wWttFR8g4WyBa4hO3MKUZpGOpM8NsrlDKtjUqWsefJrdnb/
         3vPQjTTSn9qdPA12WSiEpbCiwnMB9XSe6IIKtn0ZMUBZKC8UPHusVzNu2sBYJ8KidCpc
         vandxd8sZywQmZnHh0/p+CgZ472FY9NHhuEFlvGiTEwLMW75PtHVstUyktYKvb5AJB0k
         cXkQdC78PMkv0FJcRSaxCj1M8kyzNtEg1IWc3i1LTPl62bJcHC2A/KEgLnkX1Ihq/bZ4
         YWZ12JYQZCgp1ZaSXOYndp+baWKWRM6YB0wEBf+hhaA31CamhRuUGMCm6MRvcmUdGhAz
         GNmQ==
X-Gm-Message-State: AOJu0YwPixTyzx7+ulKNpKa0HL7v1Xujt7yvuW6x9AHddGS84YSEma5K
        uoJgR7JdZt2RKblTk61FfHD3XCAhIW314TRgJKKcRijbMHqwjVoctdbIWti61d/7rB7oDj36sAe
        gAKhYw5vcvp+Fc9KJzvGi/kyC
X-Received: by 2002:ac2:593c:0:b0:503:2dcd:30ed with SMTP id v28-20020ac2593c000000b005032dcd30edmr1841822lfi.0.1695201782302;
        Wed, 20 Sep 2023 02:23:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIkxZsQBqiHyOJWqxF75XqAGlu1IOGH4PxAL385CxSZ1sXj3qO4M67md1rS1PUK28mcHvZDw==
X-Received: by 2002:ac2:593c:0:b0:503:2dcd:30ed with SMTP id v28-20020ac2593c000000b005032dcd30edmr1841799lfi.0.1695201781897;
        Wed, 20 Sep 2023 02:23:01 -0700 (PDT)
Received: from fedorinator.. ([2a01:599:906:7772:a505:d891:dcff:9565])
        by smtp.gmail.com with ESMTPSA id n23-20020aa7c697000000b0052e2472f884sm8544689edq.21.2023.09.20.02.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 02:23:01 -0700 (PDT)
From:   Philipp Stanner <pstanner@redhat.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        Philipp Stanner <pstanner@redhat.com>
Subject: [PATCH] rculist.h: docu: fix wrong function summary
Date:   Wed, 20 Sep 2023 11:22:12 +0200
Message-ID: <20230920092211.11371-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The brief summary in the docstring for function list_next_or_null_rcu()
states that the function is supposed to provide the "first" member of a
list, whereas in truth it returns the next member.

Change the docstring so it describes what the function actually does.

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 include/linux/rculist.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/rculist.h b/include/linux/rculist.h
index 4837d8892691..fd0ed1550a7c 100644
--- a/include/linux/rculist.h
+++ b/include/linux/rculist.h
@@ -355,7 +355,7 @@ static inline void list_splice_tail_init_rcu(struct list_head *list,
 })
 
 /**
- * list_next_or_null_rcu - get the first element from a list
+ * list_next_or_null_rcu - get the next element from a list
  * @head:	the head for the list.
  * @ptr:        the list head to take the next element from.
  * @type:       the type of the struct this is embedded in.
-- 
2.41.0

