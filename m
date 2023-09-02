Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9B279048F
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 02:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351450AbjIBAuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 20:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240699AbjIBAun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 20:50:43 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B00FE7E
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 17:50:41 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-56c2e882416so1866670a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 17:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693615840; x=1694220640; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xso6py3sSP369NcSM7OaRdSGpGgel8g9Ydr1ZVYU7zI=;
        b=WeT83IE0NZ3jDMYz5cZ47UPqic8EnY7WxWcFdWHuczUuB/nSgek9Nu/vFFop7QynrA
         q6BlVk8iwVef5d3DCY/46B4pfJCWmlpRtoyXoNmTKm9PTUYw1pNUaP/WgfN7I8Zcj8cK
         zmQQHgVS8XGAraLznFUJ79CuBRWdzd+XhuCMK1wkgwoF78Kcn9pY+H0+uO0RaW7Gw9YR
         2Lgeo1uFDCIeHN8/28YVmDR1o+Q2Is1cPUxwXmY8NYP2tEcF/J6OKKvFwgHPFQRZssQG
         UeldJITA9BGBBIYxB5LNVpbBOhBu7hRK7nuJeD5y9IkhY1qlUIZXuUf6LOY1fLfzlW2d
         GFwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693615840; x=1694220640;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xso6py3sSP369NcSM7OaRdSGpGgel8g9Ydr1ZVYU7zI=;
        b=LgQNMAVCwAc4jKdGy6o0E4ZsFmAxccLXqQT1o5EYHKHBi35knJFYEuZ+1TvDITpq06
         zl1DT0D7RKDswuxzEY51ZNDYftnT+69co44FC5kZyZyGb44uWfjDaHhXn2GtGPPHCKU/
         OXZE68IhjpeJl1RoCE0l5ZcrpUIo5jE+NdtHJ4Nsl+wLHllXilBoCVJkZ5pztlkajWei
         x/o4N+ZBvCtYPox+OxTVKP0gZRO6LZM1Fee4k8Fd5xa7GJzf9vM/pRkK20w2JVKzaWxR
         nrjQ5FYbn+UmVh+PjuN7dJvQVoBbua7vCcjvfiHsrqg+o42+JmQ2sOXRYVedODiwymhw
         OZyw==
X-Gm-Message-State: AOJu0Ywe+QxvHvNQurviFIqUxqsu3ZA8MwG2lEM0jYr6SyxDWaMNDnaR
        nvLlaZ/rAmuynp1zZbDgTrpE3wDM+xVDQTl3
X-Google-Smtp-Source: AGHT+IFYmAgTbu9ox3YY+0nR+sFdwbW/8gNvWKw40HS/sUs0zyAO5Lsk2yNwB8SMHbQYbuxv4R02Sw==
X-Received: by 2002:a05:6a20:5499:b0:140:a6ec:b56a with SMTP id i25-20020a056a20549900b00140a6ecb56amr4881386pzk.3.1693615840332;
        Fri, 01 Sep 2023 17:50:40 -0700 (PDT)
Received: from westworld (209-147-138-147.nat.asu.edu. [209.147.138.147])
        by smtp.gmail.com with ESMTPSA id a19-20020a62bd13000000b0068be3489b0dsm3601687pff.172.2023.09.01.17.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 17:50:39 -0700 (PDT)
Date:   Fri, 1 Sep 2023 17:50:37 -0700
From:   Kyle Zeng <zengyhkyle@gmail.com>
To:     gregkh@linuxfoundation.org, jlbec@evilplan.org, hch@lst.de,
        linux-kernel@vger.kernel.org
Subject: [PATCH] configfs: fix a race in configfs_lookup() in stable-5.10.y
Message-ID: <ZPKG3VxTIcATSLCX@westworld>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Basically porting c42dd069be8dfc9b2239a5c89e73bbd08ab35de0 to
stable-v5.10.y to avoid race condition between configfs_dir_lseek and
configfs_lookup since they both operate ->s_childre and configfs_lookup
forgets to obtain the lock.

Signed-off-by: Kyle Zeng <zengyhkyle@gmail.com>
---
 fs/configfs/dir.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index 12388ed4faa5..0b7e9ab517d5 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -479,6 +479,7 @@ static struct dentry * configfs_lookup(struct inode *dir,
 	if (!configfs_dirent_is_ready(parent_sd))
 		goto out;
 
+	spin_lock(&configfs_dirent_lock);
 	list_for_each_entry(sd, &parent_sd->s_children, s_sibling) {
 		if (sd->s_type & CONFIGFS_NOT_PINNED) {
 			const unsigned char * name = configfs_get_name(sd);
@@ -491,6 +492,7 @@ static struct dentry * configfs_lookup(struct inode *dir,
 			break;
 		}
 	}
+	spin_unlock(&configfs_dirent_lock);
 
 	if (!found) {
 		/*
-- 
2.34.1

