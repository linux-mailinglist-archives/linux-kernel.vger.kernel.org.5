Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED99E7F52D0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 22:45:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344355AbjKVVpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 16:45:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344312AbjKVVpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 16:45:02 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C56E01BE
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 13:44:58 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-408c6ec1fd1so4115e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 13:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700689497; x=1701294297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nXiWhRqFrWoSNtAFmkHRO3t9Ruwff9Gl/eAaWgquIiw=;
        b=MZYU6+FwDpBJ6xo/We22FfLNh9FSQ9OoFhPVwTcojSXrT4Ftp9AqlcnWAfNmpcIr9K
         V9jZa0+1o205wL1nn/7di5gW7qfzBgaK7kfvFbvKVh5WyWizYTjVcBO/mMAczdYCdGuc
         1nKdjyS7RvhOij8CAByT3z39g1PfqZD9SM9q96esBHOWV05EJmW69iOnUSz6B7eLtlwX
         P3E+wMiSzcK91KwTHnBXYcXwue+qaXf14m8M8fQQin74OtQURnHfN6z78jU74naoOSPQ
         yllW3hBiopQWAJ0YfBOBUrVXzsuC32qIA4B6/iZzza4HJzPSskHO4yMRKtxJ3NVZ6N1E
         fZPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700689497; x=1701294297;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nXiWhRqFrWoSNtAFmkHRO3t9Ruwff9Gl/eAaWgquIiw=;
        b=LTs3b28wT6YiFQzcaULq0uRFMiI5banlpK1lPVudXIsOPKP7hrC3f33VeEC89+5qlN
         YvPYctcodSJ4+OjW/vKbv95pre3bNI9T5fEPDatrTdu12gTd4mfZSyr3I6VLd3KYWS+V
         x7llqnhs7pvep82pmwbx2vbPcjBvRm4vm/MrfT9S7Sptb3C9S16tAyWpS3z/pS6RFJIO
         eYmPTquRj6sLMf6QIYlNbWb3bdUU/MfFInQn9Clqzm+M3qsAIe8e/sguBjDIzWVtpjzq
         9+Bgt/Mx301fGY4MkuxUct1molm41cqJsz+y7HOQ817h0YHKRusb8ficIV/aigDFQY3b
         JiqQ==
X-Gm-Message-State: AOJu0Yy/Te8YQbZeyjiU+uBxEpIgylB9hJa/IqH4dfPY60HSe39kzT4Z
        ZhVbrb65kLqK87/yw2HOjDFxgg==
X-Google-Smtp-Source: AGHT+IHbmV0ARllAULEuHSS994ZoR2ChYITmiV4ts7e154PIRGXVJrabc+eOugs8EXU30EkDHD1E1w==
X-Received: by 2002:a05:600c:4e0a:b0:40a:4c7d:f300 with SMTP id b10-20020a05600c4e0a00b0040a4c7df300mr204704wmq.6.1700689496992;
        Wed, 22 Nov 2023 13:44:56 -0800 (PST)
Received: from localhost ([2a00:79e0:9d:4:309f:a860:c565:1fc7])
        by smtp.gmail.com with ESMTPSA id k27-20020a5d525b000000b0032ddf2804ccsm375746wrc.83.2023.11.22.13.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 13:44:54 -0800 (PST)
From:   Jann Horn <jannh@google.com>
To:     Boris Pismenny <borisp@nvidia.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Cc:     David Howells <dhowells@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net] tls: fix NULL deref on tls_sw_splice_eof() with empty record
Date:   Wed, 22 Nov 2023 22:44:47 +0100
Message-ID: <20231122214447.675768-1-jannh@google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzkaller discovered that if tls_sw_splice_eof() is executed as part of
sendfile() when the plaintext/ciphertext sk_msg are empty, the send path
gets confused because the empty ciphertext buffer does not have enough
space for the encryption overhead. This causes tls_push_record() to go on
the `split = true` path (which is only supposed to be used when interacting
with an attached BPF program), and then get further confused and hit the
tls_merge_open_record() path, which then assumes that there must be at
least one populated buffer element, leading to a NULL deref.

It is possible to have empty plaintext/ciphertext buffers if we previously
bailed from tls_sw_sendmsg_locked() via the tls_trim_both_msgs() path.
tls_sw_push_pending_record() already handles this case correctly; let's do
the same check in tls_sw_splice_eof().

Fixes: df720d288dbb ("tls/sw: Use splice_eof() to flush")
Cc: stable@vger.kernel.org
Reported-by: syzbot+40d43509a099ea756317@syzkaller.appspotmail.com
Signed-off-by: Jann Horn <jannh@google.com>
---
Note: syzkaller did not find a reliable reproducer for this; I wrote
my own reproducer that reliably hits the crash on an unpatched kernel,
and I've verified that the crash goes away with the patch applied.

 net/tls/tls_sw.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index a78e8e722409..316f76187962 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1232,11 +1232,14 @@ void tls_sw_splice_eof(struct socket *sock)
 	lock_sock(sk);
 
 retry:
+	/* same checks as in tls_sw_push_pending_record() */
 	rec = ctx->open_rec;
 	if (!rec)
 		goto unlock;
 
 	msg_pl = &rec->msg_plaintext;
+	if (msg_pl->sg.size == 0)
+		goto unlock;
 
 	/* Check the BPF advisor and perform transmission. */
 	ret = bpf_exec_tx_verdict(msg_pl, sk, false, TLS_RECORD_TYPE_DATA,

base-commit: 98b1cc82c4affc16f5598d4fa14b1858671b2263
-- 
2.43.0.rc1.413.gea7ed67945-goog

