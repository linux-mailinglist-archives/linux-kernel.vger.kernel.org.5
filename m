Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9267975FE55
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 19:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbjGXRrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 13:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbjGXRqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 13:46:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D49A726B9;
        Mon, 24 Jul 2023 10:44:32 -0700 (PDT)
Message-ID: <20230724172844.922152119@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690220664;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=4pQHURzHcwcFZ9S0vbzPTsi43pbiloyiG3aJ+/xAmII=;
        b=HOSlRNRENtX+6xkRO1N3OyyDeOhy2LFaKHXTp8rqFB0QwKy/QwpRCsy0Qd9DoecBO5w37O
        I/HkCr57Zqx1F3wkWeLKCZsiZsbntE4tXkpj9x8IfmkDUigq1rbo/08Cn7w3k4NR2KkqAH
        EvigQWvLJJmKSIemeRMuC1nsudNRcQOxEaCmpvBgqYUiygyLd3UKGmY09kx9KTjVfrD8ZZ
        MpZC7zZGJcssGdb3oZxIxVb6dUG0cUOyGrsdzJisvHe4hX0mZDgNUNIJ6iRlgb+9A+3KGt
        6yA5nW/06KEfQ+HSPPDWwdpgckhqs4MXnnScRSp3kLXVh7rO6izszPdHQ5aqMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690220664;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=4pQHURzHcwcFZ9S0vbzPTsi43pbiloyiG3aJ+/xAmII=;
        b=H1G7mKqnvQfHFb5aBTJRYlKkWHmZVAYoVwWl8jg5lQH06BxuaJG7j3E7mBVujBTqsKf7AT
        C/0kC4xcSeO4U9Ag==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <james.smart@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>,
        Huang Rui <ray.huang@amd.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Steve Wahl <steve.wahl@hpe.com>,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>
Subject: [patch 21/29] x86/smpboot: Teach it about topo.amd_node_id
References: <20230724155329.474037902@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 24 Jul 2023 19:44:23 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When switching AMD over to the new topology parser then the match functions
need to look for AMD systems with the extended topology feature at the new
topo.amd_node_id member which is then holding the node id information.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/smpboot.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -486,6 +486,7 @@ static bool match_smt(struct cpuinfo_x86
 
 		if (c->topo.pkg_id == o->topo.pkg_id &&
 		    c->topo.die_id == o->topo.die_id &&
+		    c->topo.amd_node_id == o->topo.amd_node_id &&
 		    per_cpu_llc_id(cpu1) == per_cpu_llc_id(cpu2)) {
 			if (c->topo.core_id == o->topo.core_id)
 				return topology_sane(c, o, "smt");
@@ -507,10 +508,13 @@ static bool match_smt(struct cpuinfo_x86
 
 static bool match_die(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
 {
-	if (c->topo.pkg_id == o->topo.pkg_id &&
-	    c->topo.die_id == o->topo.die_id)
-		return true;
-	return false;
+	if (c->topo.pkg_id != o->topo.pkg_id || c->topo.die_id != o->topo.die_id)
+		return false;
+
+	if (boot_cpu_has(X86_FEATURE_TOPOEXT) && topology_amd_nodes_per_pkg() > 1)
+		return c->topo.amd_node_id == o->topo.amd_node_id;
+
+	return true;
 }
 
 static bool match_l2c(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)

