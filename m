Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3CB7F0478
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 06:15:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbjKSFPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 00:15:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbjKSFPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 00:15:18 -0500
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461D7196
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 21:15:14 -0800 (PST)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1cc252cbde2so38220275ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 21:15:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700370914; x=1700975714;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+K/RL7Jd5lEjPPqvqwmtXZn0QRR8vstOZeu+HDLu+Mo=;
        b=KgFOogiBaVeXaDvJs4K7gdLRZoYZ31NeEDymRImyLch/OnjkFKpC+rNnJ33queiN6N
         wl/QJVux/fA/frVg0KCupJvRI6Xip0M5FoegiiKqyeNqp7Gq9F43UjxaOWM5SvlSIV2k
         Ml1kw4RQTsd0GRqcEtBzt91lZhYaY5MAk9ymQZZdX597DPcxCNZRn92U2R6XYBh/ytGz
         cQ12M0YWRyIPZOJCCM3L39FYmcGXBZRGGGaP6LEXHqMWK+kLAghvX6jlobbV8JH3A3wh
         g2zFquuu6v//9gwlkR5nMErBoPASYH78H0qDhhzFRQitp8meU3XJ0CGMAXC14t2FPLIw
         U/6g==
X-Gm-Message-State: AOJu0YxM3Kp+5G0RNhdYev8fCWkltqYPr3bYofOQb3e+nykEDQARW3qR
        W6hc+gLr/hCkYo82ZU/ohhGIKRHhYzr+UZ+IQQef6qpM9sn2uXQ=
X-Google-Smtp-Source: AGHT+IG0HDsq2CfMQs5KSuLqnDQdrRfKPYegpui7oOF1fAOeZeyO10NecO31w2Uu/LirOvAYRrr78HS2vO/zV9lOWDS9H4B3wnzD
MIME-Version: 1.0
X-Received: by 2002:a17:902:b491:b0:1cc:281a:8463 with SMTP id
 y17-20020a170902b49100b001cc281a8463mr1086156plr.7.1700370913851; Sat, 18 Nov
 2023 21:15:13 -0800 (PST)
Date:   Sat, 18 Nov 2023 21:15:13 -0800
In-Reply-To: <000000000000635bfa0607ed5cdc@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004e803e060a7a7488@google.com>
Subject: Re: [syzbot] [PATCH] Test for 6465e260f487
From:   syzbot <syzbot+de4025c006ec68ac56fc@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [PATCH] Test for 6465e260f487
Author: eadavis@sina.com

please test warn in __nf_unregister_net_hook

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 6465e260f487


diff --git a/net/netfilter/core.c b/net/netfilter/core.c
index 3126911f5042..58f2a5294453 100644
--- a/net/netfilter/core.c
+++ b/net/netfilter/core.c
@@ -113,6 +113,7 @@ nf_hook_entries_grow(const struct nf_hook_entries *old,
 	alloc_entries = 1;
 	old_entries = old ? old->num_hook_entries : 0;
 
+	mutex_lock(&nf_hook_mutex);
 	if (old) {
 		orig_ops = nf_hook_entries_get_hook_ops(old);
 
@@ -129,17 +130,23 @@ nf_hook_entries_grow(const struct nf_hook_entries *old,
 			 * prevent defrag, conntrack, iptables etc from attaching).
 			 */
 			if (reg->priority == orig_ops[i]->priority &&
-			    reg->hook_ops_type == NF_HOOK_OP_BPF)
-				return ERR_PTR(-EBUSY);
+			    reg->hook_ops_type == NF_HOOK_OP_BPF) {
+				new = ERR_PTR(-EBUSY);
+				goto unlock;
+			}
 		}
 	}
 
-	if (alloc_entries > MAX_HOOK_COUNT)
-		return ERR_PTR(-E2BIG);
+	if (alloc_entries > MAX_HOOK_COUNT) {
+		new = ERR_PTR(-E2BIG);
+		goto unlock;
+	}
 
 	new = allocate_hook_entries_size(alloc_entries);
-	if (!new)
-		return ERR_PTR(-ENOMEM);
+	if (!new) {
+		new = ERR_PTR(-ENOMEM);
+		goto unlock;
+	}
 
 	new_ops = nf_hook_entries_get_hook_ops(new);
 
@@ -170,6 +177,8 @@ nf_hook_entries_grow(const struct nf_hook_entries *old,
 		new->hooks[nhooks].priv = reg->priv;
 	}
 
+unlock:
+	mutex_unlock(&nf_hook_mutex);
 	return new;
 }
 
@@ -546,11 +555,13 @@ void nf_hook_entries_delete_raw(struct nf_hook_entries __rcu **pp,
 {
 	struct nf_hook_entries *p;
 
+	mutex_lock(&nf_hook_mutex);
 	p = rcu_dereference_raw(*pp);
 	if (nf_remove_net_hook(p, reg)) {
 		p = __nf_hook_entries_try_shrink(p, pp);
 		nf_hook_entries_free(p);
 	}
+	mutex_unlock(&nf_hook_mutex);
 }
 EXPORT_SYMBOL_GPL(nf_hook_entries_delete_raw);
 
