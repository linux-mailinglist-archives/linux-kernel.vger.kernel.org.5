Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73539812FEF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 13:22:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1572990AbjLNMWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 07:22:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1572970AbjLNMWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 07:22:45 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08311BD;
        Thu, 14 Dec 2023 04:22:52 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id F3EAE1F7C9;
        Thu, 14 Dec 2023 12:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1702556570; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=w8JLfHM4wo21BHhrTvjRFJxEdU7atK78kZZyg23UDyk=;
        b=RWUyVnKXtcoJTmaMtFuHNfOUtvmtc6dwFUf1YpKneeLvoUeRHlikEbvnRZSrLoeObs28od
        JX6XTmx/ifH0ChrkVdliL6eeCM3LV7yQYGV8hBK/+bePVWtsIhaeG65n0K+JYtQircpzhK
        GiVqhCyUGapJV0oF8r9yiBikh/8RIMM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1702556570;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=w8JLfHM4wo21BHhrTvjRFJxEdU7atK78kZZyg23UDyk=;
        b=ETvlPeuMdlyTFdrwMqaM7flSDELrT8RV4kC7/CQytqnlwill6J6h82Q+JpWGCKWI1VVsji
        NO2Ke3pI/lRJikCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1702556569; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=w8JLfHM4wo21BHhrTvjRFJxEdU7atK78kZZyg23UDyk=;
        b=BhLsZ/xfXDEphwpzXorycjcI8FLhWKHCWnZzr+jH6x63juFYyUE12gUFIkWVTz29Cy1+Sg
        FfjuYZF0sDgrrI/9Y4pIzGTyztHqCWc5t4iV3Fuytdzrqx6IlOUOt8eKJ+xYNe87Vhf0Eo
        huUFwp4X+4Qj4WjJkEtSdQoqy+qrWu4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1702556569;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=w8JLfHM4wo21BHhrTvjRFJxEdU7atK78kZZyg23UDyk=;
        b=yGXRGCnzI18LZdaPeSl8TY0bDgJv4vXyuKExa8vHNhs2eOuvQuU7ApnGb/kh69mfLhRoHS
        3Yd9AZ4usviNBKCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B2CBC1379A;
        Thu, 14 Dec 2023 12:22:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
        by imap1.dmz-prg2.suse.org with ESMTPSA
        id kGVWKZnzemUVfQAAD6G6ig
        (envelope-from <vbabka@suse.cz>); Thu, 14 Dec 2023 12:22:49 +0000
From:   Vlastimil Babka <vbabka@suse.cz>
Date:   Thu, 14 Dec 2023 13:22:52 +0100
Subject: [PATCH v2] Documentation, mm/unaccepted: document accept_memory
 kernel parameter
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231214-accept_memory_param-v2-1-f38cd20a0247@suse.cz>
X-B4-Tracking: v=1; b=H4sIAJvzemUC/23MsQ6CMBCA4VchN1tDjxLBifcwhpzlKh0KzRWJS
 nh3GycHx2/4/w0Si+cE52ID4dUnP08ZeCjAjjTdWfkhG7DESqM2iqzluPSBwyyvPpJQUOSqtua
 KcDA15DIKO//8Xi/XbCdzUMsoTL8v/PtatdKK2lKjKfHWNKcuPRIf7Rv2/QMT+8YQrgAAAA==
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>
X-Mailer: b4 0.12.4
X-Spam-Score: -0.74
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -1.33
X-Spamd-Result: default: False [-1.33 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         BAYES_HAM(-0.03)[56.40%];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_HAM_LONG(-1.00)[-1.000];
         MIME_GOOD(-0.10)[text/plain];
         RCPT_COUNT_FIVE(0.00)[6];
         RCVD_COUNT_THREE(0.00)[3];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-0.20)[-0.997];
         DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_TLS_ALL(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Flag: NO
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The accept_memory kernel parameter was added in commit dcdfdd40fa82
("mm: Add support for unaccepted memory") but not listed in the
kernel-parameters doc. Add it there.

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
changes since v1:
- use shorter sentences (Tim Chen)
---
 Documentation/admin-guide/kernel-parameters.txt | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 65731b060e3f..91bd74b2e203 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1,3 +1,14 @@
+	accept_memory=  [MM]
+			Format: { eager | lazy }
+			default: lazy
+			By default, unaccepted memory is accepted lazily to
+			avoid prolonged boot times. The lazy option will add
+			some runtime overhead until all memory is eventually
+			accepted. In most cases the overhead is negligible.
+			For some workloads or for debugging purposes
+			accept_memory=eager can be used to accept all memory
+			at once during boot.
+
 	acpi=		[HW,ACPI,X86,ARM64,RISCV64]
 			Advanced Configuration and Power Interface
 			Format: { force | on | off | strict | noirq | rsdt |

---
base-commit: a39b6ac3781d46ba18193c9dbb2110f31e9bffe9
change-id: 20231214-accept_memory_param-af395e3a2d45

Best regards,
-- 
Vlastimil Babka <vbabka@suse.cz>

