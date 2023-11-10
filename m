Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 880F47E8082
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344606AbjKJSMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:12:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345712AbjKJSLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:11:19 -0500
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F9C733663
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 04:19:49 -0800 (PST)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-280997b23eeso1942484a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 04:19:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699618789; x=1700223589;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gF17+2JZly3AcMbAyDkee2tAhsec0+/C5rjaQdUyKhU=;
        b=FFtEHgCNN5NAuMH0Q2Bbr6pxi0XTK4o2Y4Pzms0ujBzgGmT8Q33buMmtz4HO20xWTa
         UgiiMmqR+e69abeEsjU3drew+CBucXd5ch7F4iWW7x15CGpxDOQ+Sv410mFM7GcF1E4O
         oIw4LIodyvEjhNQhmA/zjaOWxBIpM3/2JRneT2nKFYFBnml3dLna4uLgv6Q2Fvx2QlsT
         iI1r7AKw7wMu2Edb2gvu8EBoGy5GPzpmfiD1L2BQ4+o5hwDi/Gv+NkmGo0drCdviD3cQ
         VMVo7k9Dwczsj1ehAsQ70ubD+vzphSEPth51n6rE7hqqxrgwh7CPXvKgwfw8sL2L6jGl
         KXUQ==
X-Gm-Message-State: AOJu0Ywq8lSCxt27epkNGc4QUEGwIEjirfQDllyHoSjbh6S7ITrStipf
        J+DqZL+mtlsieLfQnLdgCkOE9s9JfX/FJY/jYG3/+9ySSXu33ag=
X-Google-Smtp-Source: AGHT+IGtEyHjWUpeyLSiH55EcSF/8JtTMXUf+ywlvZLz6VAHQFS+9WszHXT/r+AxoQB2nKemjnbGjDQ/62Ey9ybY4nkSR+tOqHHY
MIME-Version: 1.0
X-Received: by 2002:a17:90b:364c:b0:280:1b63:970 with SMTP id
 nh12-20020a17090b364c00b002801b630970mr1219294pjb.3.1699618789126; Fri, 10
 Nov 2023 04:19:49 -0800 (PST)
Date:   Fri, 10 Nov 2023 04:19:48 -0800
In-Reply-To: <0000000000007323f20609b7cfbb@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002dfa3b0609cb56d6@google.com>
Subject: Re: [syzbot] [PATCH] Test for aea6bf908d73
From:   syzbot <syzbot+bbe84a4010eeea00982d@syzkaller.appspotmail.com>
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

Subject: [PATCH] Test for aea6bf908d73
Author: eadavis@qq.com

please test uaf in nfc_alloc_send_skb

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git aea6bf908d73

diff --git a/net/nfc/llcp_commands.c b/net/nfc/llcp_commands.c
index e2680a3bef79..05b21ced9e1f 100644
--- a/net/nfc/llcp_commands.c
+++ b/net/nfc/llcp_commands.c
@@ -754,6 +754,7 @@ int nfc_llcp_send_ui_frame(struct nfc_llcp_sock *sock, u8 ssap, u8 dsap,
 	remaining_len = len;
 	msg_ptr = msg_data;
 
+	bh_lock_sock(sock);
 	do {
 		remote_miu = sock->remote_miu > LLCP_MAX_MIU ?
 				local->remote_miu : sock->remote_miu;
@@ -784,6 +785,7 @@ int nfc_llcp_send_ui_frame(struct nfc_llcp_sock *sock, u8 ssap, u8 dsap,
 		remaining_len -= frag_len;
 		msg_ptr += frag_len;
 	} while (remaining_len > 0);
+	bh_unlock_sock(sock);
 
 	kfree(msg_data);
 
-- 
2.25.1

