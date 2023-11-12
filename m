Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 309F07E8F67
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 10:57:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbjKLJyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 04:54:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjKLJyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 04:54:37 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E28A2D62;
        Sun, 12 Nov 2023 01:54:34 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-4079ed65471so28067715e9.1;
        Sun, 12 Nov 2023 01:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699782873; x=1700387673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4Y+xqbrN1WZa/CB0XAzBxnbgNyp0CPoCcb3whiJBwOM=;
        b=h1tmaTEap+cEWHjp0IT7aJ7J11vjnilX0zeP1BDNIx9ZauAd/GnQUWe5WtSe4NiuDs
         S0dftR+z2qyfDZ2qgHyVZMtH6ZjPN+cwsYoaUEZ4Rf7pC3xrfrZGioP/Z0hlgCUk8eO5
         uRXRI45/1JXHUFmy/HQAc0ObgwxNLB5bkFdGcxNIJhSOjyecMixAV+t9upAw8ql5iRGg
         1gtlGPcpy5hC0P7QRpgvJxcQ9hp2caKoBWbwN7QbM60USDQusONerNkmYXO8XhQswzF9
         tXZgRyfAKIOUbX48heQVBm3tWOu3TS10d3G3uEfIa/s+JYkdCWEFjORchr+3odCQHqqW
         WI3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699782873; x=1700387673;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Y+xqbrN1WZa/CB0XAzBxnbgNyp0CPoCcb3whiJBwOM=;
        b=adOumkhkKkF8WrxHMGy1oTPjoNczzSgsBfm1JL0wqw8aAdH5MceldBr+MJOrhPzOs5
         xD7u7Xqa8Gv9GBIPGddgezCcaYE5D5xYvDXVjYXbs7VW063KPP0iGo/a1WaF5lNCxMUB
         UiztQ/XCSeVOHExO62kSWjQJ8x80BazhdW7b+8mqSWyf7p/bgdj0vSEgib1vrqnNI/N0
         RUuhdnZx7kP0GKOIR38V0rvqNYFq+qH5DtCCs4NsAu6ZjVIlMwF/fnOUiu8WBgp8wVlv
         cNUvz1yxfRnZ4yHrofKTLl9kv4CRP86iMZJE1YxicllXCVzAXHfsM3tBR09Xb4XKaRsr
         gvVA==
X-Gm-Message-State: AOJu0YwvGTscYj+7tgoaOtPXjjTixk6d8aEWKV5OtcRIGB9F9ylyzpoo
        cx+syQ0BcFylzWfqVS5Lozc=
X-Google-Smtp-Source: AGHT+IFhdvWQPiABEirvH8ajDQ/MWsIvLSNfMwdx+zFoWJPmRJ2z1VQ0IEmCdwejJCxks9UbmV1IRQ==
X-Received: by 2002:a05:600c:d8:b0:405:4a78:a890 with SMTP id u24-20020a05600c00d800b004054a78a890mr3175157wmm.8.1699782872537;
        Sun, 12 Nov 2023 01:54:32 -0800 (PST)
Received: from eagle-5590.. ([91.196.221.26])
        by smtp.gmail.com with ESMTPSA id w23-20020a05600c2a1700b003fe23b10fdfsm10200942wme.36.2023.11.12.01.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Nov 2023 01:54:32 -0800 (PST)
From:   Ronald Monthero <debug.penguin32@gmail.com>
To:     al@alarsen.net
Cc:     keescook@chromium.org, gustavoars@kernel.org,
        Ronald Monthero <debug.penguin32@gmail.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] qnx4: fix to avoid panic due to buffer overflow
Date:   Sun, 12 Nov 2023 19:53:53 +1000
Message-Id: <20231112095353.579855-1-debug.penguin32@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

qnx4 dir name length can vary to be of maximum size
QNX4_NAME_MAX or QNX4_SHORT_NAME_MAX depending on whether
'link info' entry is stored and the status byte is set.
So to avoid buffer overflow check di_fname length
fetched from (struct qnx4_inode_entry *)
before use in strlen to avoid buffer overflow.

panic context
[ 4849.636861] detected buffer overflow in strlen
[ 4849.636897] ------------[ cut here ]------------
[ 4849.636902] kernel BUG at lib/string.c:1165!
[ 4849.636917] invalid opcode: 0000 [#2] SMP PTI
..
[ 4849.637047] Call Trace:
[ 4849.637053]  <TASK>
[ 4849.637059]  ? show_trace_log_lvl+0x1d6/0x2ea
[ 4849.637075]  ? show_trace_log_lvl+0x1d6/0x2ea
[ 4849.637095]  ? qnx4_find_entry.cold+0xc/0x18 [qnx4]
[ 4849.637111]  ? show_regs.part.0+0x23/0x29
[ 4849.637123]  ? __die_body.cold+0x8/0xd
[ 4849.637135]  ? __die+0x2b/0x37
[ 4849.637147]  ? die+0x30/0x60
[ 4849.637161]  ? do_trap+0xbe/0x100
[ 4849.637171]  ? do_error_trap+0x6f/0xb0
[ 4849.637180]  ? fortify_panic+0x13/0x15
[ 4849.637192]  ? exc_invalid_op+0x53/0x70
[ 4849.637203]  ? fortify_panic+0x13/0x15
[ 4849.637215]  ? asm_exc_invalid_op+0x1b/0x20
[ 4849.637228]  ? fortify_panic+0x13/0x15
[ 4849.637240]  ? fortify_panic+0x13/0x15
[ 4849.637251]  qnx4_find_entry.cold+0xc/0x18 [qnx4]
[ 4849.637264]  qnx4_lookup+0x3c/0xa0 [qnx4]
[ 4849.637275]  __lookup_slow+0x85/0x150
[ 4849.637291]  walk_component+0x145/0x1c0
[ 4849.637304]  ? path_init+0x2c0/0x3f0
[ 4849.637316]  path_lookupat+0x6e/0x1c0
[ 4849.637330]  filename_lookup+0xcf/0x1d0
[ 4849.637341]  ? __check_object_size+0x1d/0x30
[ 4849.637354]  ? strncpy_from_user+0x44/0x150
[ 4849.637365]  ? getname_flags.part.0+0x4c/0x1b0
[ 4849.637375]  user_path_at_empty+0x3f/0x60
[ 4849.637383]  vfs_statx+0x7a/0x130
[ 4849.637393]  do_statx+0x45/0x80
..

Signed-off-by: Ronald Monthero <debug.penguin32@gmail.com>
---
 fs/qnx4/namei.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/qnx4/namei.c b/fs/qnx4/namei.c
index 8d72221735d7..825b891a52b3 100644
--- a/fs/qnx4/namei.c
+++ b/fs/qnx4/namei.c
@@ -40,6 +40,13 @@ static int qnx4_match(int len, const char *name,
 	} else {
 		namelen = QNX4_SHORT_NAME_MAX;
 	}
+
+	/** qnx4 dir name length can vary, check the di_fname
+	 * fetched from (struct qnx4_inode_entry *) before use in
+	 * strlen to avoid panic due to buffer overflow"
+	 */
+	if (strnlen(de->di_fname, namelen) >= sizeof(de->di_fname))
+		return -ENAMETOOLONG;
 	thislen = strlen( de->di_fname );
 	if ( thislen > namelen )
 		thislen = namelen;
-- 
2.34.1

