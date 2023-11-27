Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 541F77FA42F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 16:13:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233885AbjK0PNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 10:13:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233584AbjK0PNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 10:13:01 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E72A290;
        Mon, 27 Nov 2023 07:13:07 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6999B21AFA;
        Mon, 27 Nov 2023 15:13:06 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 49B351367B;
        Mon, 27 Nov 2023 15:13:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
        by imap1.dmz-prg2.suse.org with ESMTPSA
        id OIqREQKyZGXEPgAAD6G6ig
        (envelope-from <petr.pavlu@suse.com>); Mon, 27 Nov 2023 15:13:06 +0000
From:   Petr Pavlu <petr.pavlu@suse.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org,
        mathieu.desnoyers@efficios.com
Cc:     zhengyejian1@huawei.com, linux-trace-kernel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Petr Pavlu <petr.pavlu@suse.com>
Subject: [PATCH 0/2] tracing: Simplify and fix "buffered event" synchronization
Date:   Mon, 27 Nov 2023 16:12:46 +0100
Message-Id: <20231127151248.7232-1-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: +++++++++++++++
Authentication-Results: smtp-out1.suse.de;
        dkim=none;
        dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.com (policy=quarantine);
        spf=fail (smtp-out1.suse.de: domain of petr.pavlu@suse.com does not designate 2a07:de40:b281:104:10:150:64:97 as permitted sender) smtp.mailfrom=petr.pavlu@suse.com
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [15.00 / 50.00];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         R_SPF_FAIL(1.00)[-all];
         ARC_NA(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         MIME_GOOD(-0.10)[text/plain];
         SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
         BROKEN_CONTENT_TYPE(1.50)[];
         DMARC_POLICY_QUARANTINE(1.50)[suse.com : No valid SPF, No valid DKIM,quarantine];
         RCVD_COUNT_THREE(0.00)[3];
         MX_GOOD(-0.01)[];
         RCPT_COUNT_SEVEN(0.00)[7];
         MID_CONTAINS_FROM(1.00)[];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         R_DKIM_NA(2.20)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_TLS_ALL(0.00)[]
X-Spam-Score: 15.00
X-Rspamd-Queue-Id: 6999B21AFA
X-Spam: Yes
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rework the maintenance synchronization for buffered events to simplify
it and to address several found problems.

Petr Pavlu (2):
  tracing: Simplify and fix "buffered event" synchronization
  tracing: Disable events in reverse order of their enable operation

 kernel/trace/trace.c        | 66 +++++++++++++++----------------------
 kernel/trace/trace_events.c | 17 ++++++----
 2 files changed, 37 insertions(+), 46 deletions(-)


base-commit: 2cc14f52aeb78ce3f29677c2de1f06c0e91471ab
-- 
2.35.3

