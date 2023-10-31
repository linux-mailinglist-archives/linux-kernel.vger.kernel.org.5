Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B72B87DCD06
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 13:33:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344279AbjJaMdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 08:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344246AbjJaMdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 08:33:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9456EB4
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 05:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698755535;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IwcTumPEA8MXD9aE6NAuiQnpk8SlcZkJMMNjOT52wQs=;
        b=fuRhxgrWOhZPsV40BNQDqO8qj3Ps9RDZD2N6n/ubi+RL0N2gHgEyYyGrc5pRDJsE5DaNxa
        ny3/dzAwYWOVIP6KTmGLjQYt9f5wrt8OEpEvEAQJD6ulO2BM2yyyCMy+mkBTydw8PHlmbI
        5RoBwS+EURlQIZk6WDyjmhG/h72wLms=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-Zgn4cCHMNqCT0Mj5o9XBLg-1; Tue, 31 Oct 2023 08:32:14 -0400
X-MC-Unique: Zgn4cCHMNqCT0Mj5o9XBLg-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-778b5354c7bso706482185a.1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 05:32:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698755534; x=1699360334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IwcTumPEA8MXD9aE6NAuiQnpk8SlcZkJMMNjOT52wQs=;
        b=WT/SyUZX5pUPOvBgfSM4hzfcJHRbZgxEAEAQXehESy4OGek0/rV63/SVuaCmrGG36Y
         BBtz8s1C7Cnl4/QTnuYngf6i+Kz+Bzv6P3rqNJltylTZkUjpYqjF1LMoksX5rpGVirdJ
         NvFDo4vN91IKbcvh6KvbqBtmZn6bN/M2Aoxk8L5GKpGVj56vgd13gDw3/qU5rd5FRAMH
         DzR+es09wannH9lDqHZPINugjut0maO0qInsjNtKcYMbDgVWmcEmu7w+H9NhpNVvYWyb
         DycF1Ylx1LIvglbdNcui36yJo4hyjxdtsAkZ0o9iPmIMrF4lq3iw1pguUvzsxSmkBSBk
         Uokg==
X-Gm-Message-State: AOJu0Ywkd2JwqumYVKFtOkcybCAAkkWqklcsWaaQ54oBtB8hHv2DIynk
        BbSKSrEm3WXSg2pnhIakuDO9+af3doiyc//B8mQN9kodKhHWhoJesBDYHrUy4itwEldLkiN3i0U
        2ERF3PhHeslFyUWkOviCbxWZW
X-Received: by 2002:a05:620a:2408:b0:774:2e8f:2170 with SMTP id d8-20020a05620a240800b007742e8f2170mr15537035qkn.4.1698755533752;
        Tue, 31 Oct 2023 05:32:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1PibxJcjMn2MZ8vm902icTDEZ+hR9K82a6PAvEbaLbNmN/JzZjcwNxAmmW4i0Zd0iBebAFA==
X-Received: by 2002:a05:620a:2408:b0:774:2e8f:2170 with SMTP id d8-20020a05620a240800b007742e8f2170mr15537013qkn.4.1698755533490;
        Tue, 31 Oct 2023 05:32:13 -0700 (PDT)
Received: from localhost.localdomain (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id g23-20020a05620a13d700b00777063b89casm457697qkl.5.2023.10.31.05.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 05:32:12 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     linux-security-module@vger.kernel.org,
        Benjamin Coddington <bcodding@redhat.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] lsm: fix default return value for inode_getsecctx
Date:   Tue, 31 Oct 2023 13:32:07 +0100
Message-ID: <20231031123207.758655-3-omosnace@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231031123207.758655-1-omosnace@redhat.com>
References: <20231031123207.758655-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-EOPNOTSUPP is the return value that implements a "no-op" hook, not 0.

Without this fix having only the BPF LSM enabled (with no programs
attached) can cause uninitialized variable reads in
nfsd4_encode_fattr(), because the BPF hook returns 0 without touching
the 'ctxlen' variable and the corresponding 'contextlen' variable in
nfsd4_encode_fattr() remains uninitialized, yet being treated as valid
based on the 0 return value.

Reported-by: Benjamin Coddington <bcodding@redhat.com>
Fixes: 98e828a0650f ("security: Refactor declaration of LSM hooks")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 include/linux/lsm_hook_defs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 4dd55fdfec267..ff217a5ce5521 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -273,7 +273,7 @@ LSM_HOOK(void, LSM_RET_VOID, release_secctx, char *secdata, u32 seclen)
 LSM_HOOK(void, LSM_RET_VOID, inode_invalidate_secctx, struct inode *inode)
 LSM_HOOK(int, 0, inode_notifysecctx, struct inode *inode, void *ctx, u32 ctxlen)
 LSM_HOOK(int, 0, inode_setsecctx, struct dentry *dentry, void *ctx, u32 ctxlen)
-LSM_HOOK(int, 0, inode_getsecctx, struct inode *inode, void **ctx,
+LSM_HOOK(int, -EOPNOTSUPP, inode_getsecctx, struct inode *inode, void **ctx,
 	 u32 *ctxlen)
 
 #if defined(CONFIG_SECURITY) && defined(CONFIG_WATCH_QUEUE)
-- 
2.41.0

