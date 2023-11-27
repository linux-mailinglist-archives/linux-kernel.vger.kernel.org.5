Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8BDE7FA431
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 16:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233906AbjK0PNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 10:13:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233887AbjK0PNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 10:13:04 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753B8BB;
        Mon, 27 Nov 2023 07:13:10 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 15E121FBDB;
        Mon, 27 Nov 2023 15:13:09 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E312C1367B;
        Mon, 27 Nov 2023 15:13:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
        by imap1.dmz-prg2.suse.org with ESMTPSA
        id +IZ3NgSyZGXEPgAAD6G6ig
        (envelope-from <petr.pavlu@suse.com>); Mon, 27 Nov 2023 15:13:08 +0000
From:   Petr Pavlu <petr.pavlu@suse.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org,
        mathieu.desnoyers@efficios.com
Cc:     zhengyejian1@huawei.com, linux-trace-kernel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Petr Pavlu <petr.pavlu@suse.com>
Subject: [PATCH 2/2] tracing: Disable events in reverse order of their enable operation
Date:   Mon, 27 Nov 2023 16:12:48 +0100
Message-Id: <20231127151248.7232-3-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231127151248.7232-1-petr.pavlu@suse.com>
References: <20231127151248.7232-1-petr.pavlu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: +++++++++++++++
X-Spam-Score: 15.00
X-Rspamd-Server: rspamd1
Authentication-Results: smtp-out2.suse.de;
        dkim=none;
        spf=fail (smtp-out2.suse.de: domain of petr.pavlu@suse.com does not designate 2a07:de40:b281:104:10:150:64:97 as permitted sender) smtp.mailfrom=petr.pavlu@suse.com;
        dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.com (policy=quarantine)
X-Rspamd-Queue-Id: 15E121FBDB
X-Spamd-Result: default: False [15.00 / 50.00];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         BROKEN_CONTENT_TYPE(1.50)[];
         RCVD_COUNT_THREE(0.00)[3];
         MX_GOOD(-0.01)[];
         NEURAL_HAM_SHORT(-0.19)[-0.948];
         RCPT_COUNT_SEVEN(0.00)[7];
         FROM_EQ_ENVFROM(0.00)[];
         R_DKIM_NA(2.20)[];
         MIME_TRACE(0.00)[0:+];
         ARC_NA(0.00)[];
         R_SPF_FAIL(1.00)[-all];
         FROM_HAS_DN(0.00)[];
         DMARC_POLICY_QUARANTINE(1.50)[suse.com : No valid SPF, No valid DKIM,quarantine];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_HAM_LONG(-1.00)[-1.000];
         MIME_GOOD(-0.10)[text/plain];
         MID_CONTAINS_FROM(1.00)[];
         DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         RCVD_TLS_ALL(0.00)[]
X-Spam: Yes
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the disable operation in __ftrace_event_enable_disable() use the
reverse order of the respective enable operation.

This has two minor benefits:
* Disabling of buffered events via trace_buffered_event_disable() is
  done after unregistering the trace event. It closes a small window
  where an event would be still registered and could be hit, but would
  unnecessarily go directly to a ring buffer.
* The SOFT_DISABLED flag is now consistently set only when SOFT_MODE is
  also set.

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 kernel/trace/trace_events.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index f29e815ca5b2..5f14d68a0ced 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -633,9 +633,6 @@ static int __ftrace_event_enable_disable(struct trace_event_file *file,
 			if (atomic_dec_return(&file->sm_ref) > 0)
 				break;
 			disable = file->flags & EVENT_FILE_FL_SOFT_DISABLED;
-			clear_bit(EVENT_FILE_FL_SOFT_MODE_BIT, &file->flags);
-			/* Disable use of trace_buffered_event */
-			trace_buffered_event_disable();
 		} else
 			disable = !(file->flags & EVENT_FILE_FL_SOFT_MODE);
 
@@ -653,11 +650,17 @@ static int __ftrace_event_enable_disable(struct trace_event_file *file,
 
 			call->class->reg(call, TRACE_REG_UNREGISTER, file);
 		}
-		/* If in SOFT_MODE, just set the SOFT_DISABLE_BIT, else clear it */
-		if (file->flags & EVENT_FILE_FL_SOFT_MODE)
-			set_bit(EVENT_FILE_FL_SOFT_DISABLED_BIT, &file->flags);
-		else
+
+		if (soft_disable) {
+			/* Complete going out of SOFT_MODE */
 			clear_bit(EVENT_FILE_FL_SOFT_DISABLED_BIT, &file->flags);
+			clear_bit(EVENT_FILE_FL_SOFT_MODE_BIT, &file->flags);
+			/* Disable use of trace_buffered_event */
+			trace_buffered_event_disable();
+		} else if (file->flags & EVENT_FILE_FL_SOFT_MODE) {
+			/* If in SOFT_MODE, just set the SOFT_DISABLE_BIT */
+			set_bit(EVENT_FILE_FL_SOFT_DISABLED_BIT, &file->flags);
+		}
 		break;
 	case 1:
 		/*
-- 
2.35.3

