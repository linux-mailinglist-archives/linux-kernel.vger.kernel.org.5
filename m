Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4FA27F0572
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 11:32:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbjKSKc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 05:32:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjKSKcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 05:32:25 -0500
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79FE0E5
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 02:32:22 -0800 (PST)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-6be1065cc81so6120981b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 02:32:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700389942; x=1700994742;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wWDi9LTfz9r0omUuZLsueXe+a4+kPWLNedFXl0i7vOU=;
        b=IXmtpwOVpuk+wCNOHVybZH+DoXw25hyJndUqr00lVudGiqlTVNu8/R4zodxUmZ4N2Y
         MAljPUQI8Qoa5ZA0enQD7+VFXrpT1IFHARKDsfmtHx20gYsiibhPSsu/yNVtXB9863dz
         HTi2o76RYk5rU3Kc0O8JkI0LpA9IOR2UtN6Bk+nhaFH/Mw+pmevGTQtJhJQQS2sDoS0l
         j69PewlcMC9JuR2ZBUey5j7/UEQrIOiAYqT9Z2Vm3iJB67aDmc1vmH6U4FNaJj/+q9vo
         eZv33xP/6xsn7hQnTLs/UuEtGIGh+uuDGuOSYD6kh4IhfFdrJQLIOfRe9D3BXpLya7ZJ
         wOww==
X-Gm-Message-State: AOJu0Yxh5fgFmkRKF39ix+isQnAbBlzFEWInmSXfR+kJr96CTAFbzNk7
        RFEpZhkvZc1xUDh1OvDqmKoMwx7gjHVV1Ns+tpbohdsLe2fvEdc=
X-Google-Smtp-Source: AGHT+IFX+426z/8V4/acIVpN6EJExRWf8LqWx76VhYd2zkhgGfNIwiFnNEp3gRui9Ngw23dtwuL/2b9O3KPWSoz2z3H1C43TdSFc
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:4c95:b0:6c0:f910:77fe with SMTP id
 eb21-20020a056a004c9500b006c0f91077femr1337990pfb.0.1700389942107; Sun, 19
 Nov 2023 02:32:22 -0800 (PST)
Date:   Sun, 19 Nov 2023 02:32:21 -0800
In-Reply-To: <000000000000635bfa0607ed5cdc@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007aa260060a7ee2f3@google.com>
Subject: Re: [syzbot] [PATCH] Test for 6465e260f487
From:   syzbot <syzbot+de4025c006ec68ac56fc@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
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
 
