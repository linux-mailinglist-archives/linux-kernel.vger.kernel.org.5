Return-Path: <linux-kernel+bounces-133141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B120D899F69
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C26F283F2C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5767B16F0C8;
	Fri,  5 Apr 2024 14:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eBtGdjT3"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9C36CDB7;
	Fri,  5 Apr 2024 14:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712326760; cv=none; b=CV7iWT4ogBKuIoExOYGk6RjnoLcM44kgvyr96Wfhr48Dgm+vGpQXPvAykHDk24p52gQqGJpQspDk9mdthfMtwgaw47BBAmlhbxhd6rByPqkDihfirrodkzYdUsu/tA4HpH2KoqZWDyN/8iszSWG/QXwzEEnOXgVHEFpkPiAT4uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712326760; c=relaxed/simple;
	bh=4Hju7fF0SxNzZ2mqAHW0f5V/ApFhN7MqJVSisoucAV8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=df1fNRiURF6uCocp8L/ih17DpjuIwlcIgFhvx3R+vQCki/s9YNvIc2l2FvrudTua+QMA0O+btQO2zxzg/E2VCwKKDjceJWvi9YfbGAqtumEG5Czf85CdIhdR0BaXLcrx5IkwP3D0tlZCxrp3poJ1cWA7CJb1vvD67/kAk6boLb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eBtGdjT3; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6ecf1d22d78so323460b3a.0;
        Fri, 05 Apr 2024 07:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712326758; x=1712931558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7GqB8UKznuUkiOvF78HZkc7ki6tNhayp05XdI7Kg1aI=;
        b=eBtGdjT3PR4eAw7+FaadhlZZQbd+YdwBHhCre05tQvmeB6fLq6UfIASAhP54o+WXrj
         t7hEik4RdbfeQXGN02U0qwZyWwlT0od7juR0HLRrqIKtWmcyX4IQBzKRsoU9sVZNh7DF
         My3DnDr3niH2Slxla2mBOlGKkCEuS9Wo8OfzQaYxSfdjfjGJJROL7PKwChwh9Rpj5e3I
         71ZPMQilhXa10sK8PLMhtAjP+ppcNz2qq3PiUb/NJR9JnKJxhn0K1PUB3Q8aTCxheUPQ
         aHzk1fQiM4gD/uo7flNA4N6d6D8Zg844328JfZ1yuvt5hoKVu6TXdMKrRFCO2Zc5aQhJ
         BxFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712326758; x=1712931558;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7GqB8UKznuUkiOvF78HZkc7ki6tNhayp05XdI7Kg1aI=;
        b=Ys+Bfb32l/v5xYF/bR0YFV0/hawp7CKzqQ64D6ZzquiVjcn7JPkCPLmBV1jMLlVojH
         g0S/DrpLs/FJRIbfO46LTou+QdCqapdsOF03+8m3HsiNzUngWgov4J6l6bXg5WC+goUm
         zPTgah4GF5pq6R7PG7s797u55IZfy0diAZOKa2rRcpEY+jr/xxhXAJBcBb59PE2sbuNq
         i2li2E1uJpR9ndyqZZv7uMVWMAEmrUGryrZYFErzPlmqcvLtVvJYRcdygC58hxAWvDN5
         CuCZWOGf8YZb+9A5cSU0hGJuW0O5brIEooawBRa3tKBLOpUL7UzZTh4CeGf6aegJoQNc
         ZV4w==
X-Forwarded-Encrypted: i=1; AJvYcCU5/ddig6sX2RV4PJcVAg+jdCutBCEZ95aWE0IKMPz9wIGT7P55dbL7dmEm9hYye2EZHs+Afl53GwvojqG9ScSc1eoghB8OVl9k3eU9nNbIbPCIdrdmSxVaLPCujEW58GVlRvJFiA==
X-Gm-Message-State: AOJu0YzYS3xyqKs6SoXGh6jqTJAvwyrz661ETGjtyFd97HnzbaNKWSIq
	w3mgXuyGdbm2X0csQjMcLtl3gUkvxne9LV6dukmtPVSUkh1596MP
X-Google-Smtp-Source: AGHT+IE9oG9PsE4yWU92U/WhklJgYXEaJSffwUYKajT+v1E4FkogjW6qYtR2PTR08ZgCK+Re7YC//g==
X-Received: by 2002:a05:6a20:a115:b0:1a3:a936:eb07 with SMTP id q21-20020a056a20a11500b001a3a936eb07mr1839289pzk.2.1712326758470;
        Fri, 05 Apr 2024 07:19:18 -0700 (PDT)
Received: from vaxr-BM6660-BM6360.. ([2001:288:7001:2703:acae:28e3:27f5:a1b4])
        by smtp.gmail.com with ESMTPSA id ei51-20020a056a0080f300b006e5f754646csm1524264pfb.139.2024.04.05.07.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 07:19:16 -0700 (PDT)
From: I Hsin Cheng <richard120310@gmail.com>
To: akpm@linux-foundation.org
Cc: paul@paul-moore.com,
	stephen.smalley.work@gmail.com,
	eparis@parisplace.org,
	selinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	I Hsin Cheng <richard120310@gmail.com>
Subject: [PATCH] netlink: Remove the include of files doesn't exist
Date: Fri,  5 Apr 2024 22:19:07 +0800
Message-Id: <20240405141907.166334-1-richard120310@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The file for /security/selinux/security.h and the file for
/include/linux/selinux_netlink.h are no long exist. However the
preprocessor still performs the inclusion of those files, these
behaviors should be removed to ensure it's bug-free.

Signed-off-by: I Hsin Cheng <richard120310@gmail.com>
---
 security/selinux/netlink.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/security/selinux/netlink.c b/security/selinux/netlink.c
index 1760aee71..8ce36abaa 100644
--- a/security/selinux/netlink.c
+++ b/security/selinux/netlink.c
@@ -13,11 +13,9 @@
 #include <linux/kernel.h>
 #include <linux/export.h>
 #include <linux/skbuff.h>
-#include <linux/selinux_netlink.h>
 #include <net/net_namespace.h>
 #include <net/netlink.h>
 
-#include "security.h"
 
 static struct sock *selnl __ro_after_init;
 
-- 
2.34.1


