Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD05813075
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 13:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573141AbjLNMn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 07:43:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573131AbjLNMnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 07:43:21 -0500
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B90125
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 04:43:26 -0800 (PST)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-6cecc9a3519so4577714b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 04:43:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702557806; x=1703162606;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sWN5XD3asHaaeaSp5xQR9I8f/n7oQYXYfzTxbi+D2HA=;
        b=POfoIzbNdXlNDZSCk0DgSyNs3H4Qzy4pDcjDqXl3PcYz/u0c6FQkSkInLnUy07w86J
         erd4cspRPzvt+Lq3m20PWvkWCW2IyTUlLKqJWVxRbIXkVPLER1HSBamXrIZ3VJVzNV41
         JiGlVHTE8grVChCv6XqFBuIusC+xxkQFU753yeNg1EDqif1OIAq064AaEKTaaqZtUdRy
         SxWhUVNjW8g6yj/EqDDQlTKzBs+EXyVT1xe+HAD1K8sMXzeDgGcYzf1AkBfbSlesNVHG
         xEAaeSy7iTPCoqJSwIQ6BRHFVhyHJwbInhbk3Y03WRmJXbUOgrZB82DDtrUWmQNp/i6x
         xoBA==
X-Gm-Message-State: AOJu0YwvW2Kox4bt/8nCuwAiWJ4bagEpiHINY7EgC5hPaJdGu0h1eWSB
        xja9J7uGw3d3vqiXBXYD1f5GBikHF7NyQ7SwutcBiYPkffDfUCE=
X-Google-Smtp-Source: AGHT+IF19/apVOmIgw6jQTLYoq8SzmLtO3h30qoLmy7/UVtuWUgl+yNKZFp7QNFPBrZtJXswJkxD1JB+3ASPEIgaRoFYrVdqFtP5
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:1acc:b0:6ce:4a3c:47a with SMTP id
 f12-20020a056a001acc00b006ce4a3c047amr1225429pfv.5.1702557806555; Thu, 14 Dec
 2023 04:43:26 -0800 (PST)
Date:   Thu, 14 Dec 2023 04:43:26 -0800
In-Reply-To: <0000000000009e122006088a2b8d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000044fbfc060c77a1da@google.com>
Subject: Re: [syzbot] Test for c71bc336c5061153b502
From:   syzbot <syzbot+c71bc336c5061153b502@syzkaller.appspotmail.com>
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

Subject: Test for c71bc336c5061153b502
Author: syoshida@redhat.com

#syz test

diff --git a/net/core/stream.c b/net/core/stream.c
index 96fbcb9bbb30..b16dfa568a2d 100644
--- a/net/core/stream.c
+++ b/net/core/stream.c
@@ -79,7 +79,7 @@ int sk_stream_wait_connect(struct sock *sk, long *timeo_p)
 		remove_wait_queue(sk_sleep(sk), &wait);
 		sk->sk_write_pending--;
 	} while (!done);
-	return 0;
+	return done < 0 ? done : 0;
 }
 EXPORT_SYMBOL(sk_stream_wait_connect);

