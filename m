Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC177DCD0E
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 13:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344277AbjJaMdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 08:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344263AbjJaMdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 08:33:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD81102
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 05:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698755544;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=01Cuhkq/fZzHdIhk7dn370LtT6qVzQS52GEFoCa52Y8=;
        b=g9EDNq0p5I6e4STfF/hfFVyVnMBLOA3/PAJgABTuK1bo98rQuEclcYgr0N1qMZA8WBq+lp
        bX4jEtosG2+Knvm+U3g19kvMOgkVzZ95yjsKwoOjmAPdobw3rYHxpawsfC7/wGlu2y+DsA
        gXjGDPtruBIFq5+CvNbVLsl2fkFsSlg=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-347-GPbkU0mVPGquLN_4LYkHGA-1; Tue, 31 Oct 2023 08:32:12 -0400
X-MC-Unique: GPbkU0mVPGquLN_4LYkHGA-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7788fa5f1b0so686956785a.2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 05:32:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698755532; x=1699360332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=01Cuhkq/fZzHdIhk7dn370LtT6qVzQS52GEFoCa52Y8=;
        b=Oaige/1IuMnZSwoK3/8Mp0TP4coZ5syerq9DjXnaYHa8VhqUe43lCILq6pUF4/DEV+
         hVylOES7mxxGLb9/x9b1IbfpD5qXBVr1wpGZCXRp6DbchVv/us+NDcNrZup4+mIVaHFe
         PWcOfSp5KrRerdGKuWaVJVP7J+yGW+lpgAEy3LaKW9ybk5j/FtDZuAQLdP+qloBk4Jq2
         fOnEr4SD8t/A5E2UBhz37/pd2ycYE6dcOxNH5D+1zhxHlB9+xy2QExwCYvr8J+x6QUxP
         4vxu3Q3K8/kIpe6elkmtGnJE4i5/PZI1E+jJDwrCE/ks/BQ31WbqvjArj7tk0HO9uwea
         aOMA==
X-Gm-Message-State: AOJu0YzXU1CIpyhwqF2cGsBAAlDjQp8942RuZGWAqsBQQxM1rHGVry8J
        UfwZEGsw0UMPcsmNMDF4wshplFEkHrselHbtzH9dfA8uPF8kzJDVa2pzSTy6Zu8Y2h+GKDJ+Ba1
        GbszX4hYEmNh+rvKVNy5DHamaMMEhwtG8
X-Received: by 2002:a05:620a:4109:b0:775:681d:dc06 with SMTP id j9-20020a05620a410900b00775681ddc06mr15146858qko.63.1698755532027;
        Tue, 31 Oct 2023 05:32:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtP5GHt2Cr+NcxBoAmMp/ehlVMchXJA7rXREzot7xDH4Twt77eyMwn8XXa3E8PspHWfUt1Kg==
X-Received: by 2002:a05:620a:4109:b0:775:681d:dc06 with SMTP id j9-20020a05620a410900b00775681ddc06mr15146835qko.63.1698755531737;
        Tue, 31 Oct 2023 05:32:11 -0700 (PDT)
Received: from localhost.localdomain (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id g23-20020a05620a13d700b00777063b89casm457697qkl.5.2023.10.31.05.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 05:32:11 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     linux-security-module@vger.kernel.org,
        Benjamin Coddington <bcodding@redhat.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] lsm: fix default return value for vm_enough_memory
Date:   Tue, 31 Oct 2023 13:32:06 +0100
Message-ID: <20231031123207.758655-2-omosnace@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231031123207.758655-1-omosnace@redhat.com>
References: <20231031123207.758655-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1 is the return value that implements a "no-op" hook, not 0.

Fixes: 98e828a0650f ("security: Refactor declaration of LSM hooks")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 include/linux/lsm_hook_defs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 99b8176c3738d..4dd55fdfec267 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -48,7 +48,7 @@ LSM_HOOK(int, 0, quota_on, struct dentry *dentry)
 LSM_HOOK(int, 0, syslog, int type)
 LSM_HOOK(int, 0, settime, const struct timespec64 *ts,
 	 const struct timezone *tz)
-LSM_HOOK(int, 0, vm_enough_memory, struct mm_struct *mm, long pages)
+LSM_HOOK(int, 1, vm_enough_memory, struct mm_struct *mm, long pages)
 LSM_HOOK(int, 0, bprm_creds_for_exec, struct linux_binprm *bprm)
 LSM_HOOK(int, 0, bprm_creds_from_file, struct linux_binprm *bprm, const struct file *file)
 LSM_HOOK(int, 0, bprm_check_security, struct linux_binprm *bprm)
-- 
2.41.0

