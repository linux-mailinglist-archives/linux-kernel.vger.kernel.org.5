Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3058F80119E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 18:24:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379051AbjLARYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 12:24:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379181AbjLARYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 12:24:13 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2080C2736
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 09:23:28 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-5c627dd2accso928081a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 09:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701451407; x=1702056207; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pF1HXnbmSrYchthIdE2P0kzrKumbnX3teWalqa1zpFg=;
        b=F5QbRUFiAnUl+CmA58PzE2VL2S0EWPi732gmuGSDf7TKZtymWuH/KgeMsMSldaQTkL
         7O76c1DoHzUWF2DfCjweg8yz7zZv21ySNClcjv5rKbR1zV+P0cv9D+l7thjMRUR+tQTb
         mkP4unOdzdgEquKhGe80WlEZTPa6vjFGJx1yivPSgs5givJfDwdgfM1vVfsRfbgwG/YA
         BM2RWBZxDyRFt0uvSRAr9x98BF34g8pf/0L6hzV30LnAMadV++gNZTnUkvVIdbB4A/zU
         W4tkV4xFahdU8U9ManfEn2ZitYa/VMHdN+XUmmzWOE9JfBn+Bk2d0/YnCkOrtVWO9EdM
         fKDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701451407; x=1702056207;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pF1HXnbmSrYchthIdE2P0kzrKumbnX3teWalqa1zpFg=;
        b=umqVVEZu6oqpEwutKBBc3aBYQ5yFM9mWNWu/78NS7Wx6tAOWwmm9+LJ/ml8QoO2XQe
         /jWtmxbHmbUVZXGRDIUYWNcVSxgW+/SP5ZSD4B6cyAbJ4PjKmqt2ReqVwIiiNPysmev3
         JQfY6aKXGJp1xoct/CKne9quyAzOBJVDxNonzleKkqI77RhccQDHeScB4BNhmZL6QftR
         gWp95wtJdmEXwpiDQcRUk+tW5+TC0xsIM/HSZsPsLLPtGOB8I1u0MO3vKpqMGeyEvrAy
         TPYie1FwtaRC1GRNW4GwQAcGDCxOG5jXuFTB7x5MI+ADIkWS0kug4hLAC2KB+xkNxRwW
         VaSQ==
X-Gm-Message-State: AOJu0YwMW+KhvBijXLPV6fMCdVa5nj+lLIWjdluvGC3H2ru3tBeIkFIQ
        EauLOZrBIcknY/fk2r6+2OuvTCiPw58L7w==
X-Google-Smtp-Source: AGHT+IHGjfY5XTrK9i72lt1Po9ugG7UBlXvPtE0jY1V4k8nhhcjmWPgtcgyZfDrCVYTGCv+s3fb14BSFs1yWBQ==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a63:2218:0:b0:5be:123c:5fc with SMTP id
 i24-20020a632218000000b005be123c05fcmr3883861pgi.10.1701451407544; Fri, 01
 Dec 2023 09:23:27 -0800 (PST)
Date:   Fri,  1 Dec 2023 17:21:53 +0000
In-Reply-To: <20231201172212.1813387-1-cmllamas@google.com>
Mime-Version: 1.0
References: <20231201172212.1813387-1-cmllamas@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231201172212.1813387-25-cmllamas@google.com>
Subject: [PATCH v2 24/28] binder: collapse print_binder_buffer() into caller
From:   Carlos Llamas <cmllamas@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Carlos Llamas <cmllamas@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code in print_binder_buffer() is quite small so it can be collapsed
into its single caller binder_alloc_print_allocated().

No functional change in this patch.

Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder_alloc.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index edd9714ec9f5..60c829506d31 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -978,16 +978,6 @@ void binder_alloc_deferred_release(struct binder_alloc *alloc)
 		     __func__, alloc->pid, buffers, page_count);
 }
 
-static void print_binder_buffer(struct seq_file *m, const char *prefix,
-				struct binder_buffer *buffer)
-{
-	seq_printf(m, "%s %d: %lx size %zd:%zd:%zd %s\n",
-		   prefix, buffer->debug_id, buffer->user_data,
-		   buffer->data_size, buffer->offsets_size,
-		   buffer->extra_buffers_size,
-		   buffer->transaction ? "active" : "delivered");
-}
-
 /**
  * binder_alloc_print_allocated() - print buffer info
  * @m:     seq_file for output via seq_printf()
@@ -999,12 +989,18 @@ static void print_binder_buffer(struct seq_file *m, const char *prefix,
 void binder_alloc_print_allocated(struct seq_file *m,
 				  struct binder_alloc *alloc)
 {
+	struct binder_buffer *buffer;
 	struct rb_node *n;
 
 	mutex_lock(&alloc->mutex);
-	for (n = rb_first(&alloc->allocated_buffers); n != NULL; n = rb_next(n))
-		print_binder_buffer(m, "  buffer",
-				    rb_entry(n, struct binder_buffer, rb_node));
+	for (n = rb_first(&alloc->allocated_buffers); n; n = rb_next(n)) {
+		buffer = rb_entry(n, struct binder_buffer, rb_node);
+		seq_printf(m, "  buffer %d: %lx size %zd:%zd:%zd %s\n",
+			   buffer->debug_id, buffer->user_data,
+			   buffer->data_size, buffer->offsets_size,
+			   buffer->extra_buffers_size,
+			   buffer->transaction ? "active" : "delivered");
+	}
 	mutex_unlock(&alloc->mutex);
 }
 
-- 
2.43.0.rc2.451.g8631bc7472-goog

