Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9180813256
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 14:59:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573300AbjLNN67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 08:58:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjLNN65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 08:58:57 -0500
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FFDACF
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 05:59:04 -0800 (PST)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-28ae5c1da14so1399255a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 05:59:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702562344; x=1703167144;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IJIfkhy3xTyFmXnex1Qu2IV36NPp4yjUqK+uClwqdRU=;
        b=lXMX0GMOTyMgA6llPRTbSNsXQ/4bksBBf7tnmSdX8SnN5E0HA8dFOji0K3aY/F4MDz
         opgXVwV5Nc5tIDDR7KQgv0iiEV3O2wh0uySiobHAzXVvoq/vs1xR6A+WcPcPkGAB4ndr
         mvvNQ9GRaO6FkZKBwRFov+YQG+io1D4/PX619N+7Jds6nAKfx0buqCx2yDe5ZN4siSMh
         igO4Zww8pGP16LbEB86YyOFCPhMyncj3nzQZa1s7W8VkAAUr+3H7QfiH7Wr8VhDM99/0
         nF77UX9VCcVsOSJm55RnAyzoBHm/SyENMThIOWS84ZuHaoBcBQWRlAVnUzJx8EiF1pM1
         SjnQ==
X-Gm-Message-State: AOJu0YweIwHB1erGRs0pqnMwJt8nF8DRHpZ1GfCXPjWL9kxeZGoi32i6
        OzGKbaA+E1tRiSfv3dUWi22Kz9H7bILR9+yfJi1xab1t8c5Mk6g=
X-Google-Smtp-Source: AGHT+IG7HwJczXkdQxSZXmgIZ81NwDlIzzs3Y11NEBnopImjb/IfB2PGN06YpjFk7CNVtEWCz68N0njhb4oXG9tNM/9jW1cNQo1j
MIME-Version: 1.0
X-Received: by 2002:a17:90a:4ca7:b0:286:9485:ec48 with SMTP id
 k36-20020a17090a4ca700b002869485ec48mr1052402pjh.8.1702562343999; Thu, 14 Dec
 2023 05:59:03 -0800 (PST)
Date:   Thu, 14 Dec 2023 05:59:03 -0800
In-Reply-To: <0000000000009b39bc060c73e209@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b8e7bb060c78afcc@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-out-of-bounds Read in dns_resolver_preparse
From:   syzbot <syzbot+94bbb75204a05da3d89f@syzkaller.appspotmail.com>
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

Subject: [net?] KASAN: slab-out-of-bounds Read in dns_resolver_preparse
Author: eadavis@qq.com

please test slab-out-of-bounds Read in dns_resolver_preparse

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git 48e8992e33ab
diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
index 10ba439968f7..f28ba8a703fe 100644
--- a/security/keys/keyctl.c
+++ b/security/keys/keyctl.c
@@ -83,7 +83,7 @@ SYSCALL_DEFINE5(add_key, const char __user *, _type,
 	long ret;
 
 	ret = -EINVAL;
-	if (plen > 1024 * 1024 - 1)
+	if (plen > 1024 * 1024 - 1 || plen < 48)
 		goto error;
 
 	/* draw all the data into kernel space */

