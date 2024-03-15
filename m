Return-Path: <linux-kernel+bounces-104726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B66387D2CF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 18:31:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C21E1C20A77
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 17:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484A4495E5;
	Fri, 15 Mar 2024 17:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="hmk27yYC"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18EB45BFB;
	Fri, 15 Mar 2024 17:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710523873; cv=none; b=JvmcWbWAsQCig7W7Ro49VxazxM+pA3JZOnjPzh+1MDd0GC8EC/QVR0TJNvFY9+rUC97Ab/NOEY81hapgjAtAngSOJR3gHfEvOi86jWZQ9qCQUuy/32vYjOUIWsWZuuP+tpmsRX7JlTqStDFHXdH6Jbk5enlqXKhjtSlSr/sxH3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710523873; c=relaxed/simple;
	bh=AuyctvHzXCuOG0qApdvaa1TbjS2ba7xRFCCfptYNNyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UJfbUK8KoPqte+UYdeIRYRP47F0qFix60ULP/i5450MlZAGLD8E2clAh1nHGGJ77pvFetNtqWJ5A9mW88Ev5bAUMCDZJelui+YgLSGZo5Bb4VEnAFph4CxR/1EHGV+CvFPqZwozu4YW8X4HZY0dKKlmUHcKNrQMPP8JSoefK8AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=hmk27yYC; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-568aa3096e9so1907131a12.0;
        Fri, 15 Mar 2024 10:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1710523870; x=1711128670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4I8kF2HOLsV3f6ALBOCC7UdtwRxp7Bq+Pw3KZf1q5w4=;
        b=hmk27yYCviBmjlIjrJmosuwxL0h7C2XahZz38bEzjDcGQd9iprLnm7oeTdoVaoxQy7
         fG2MboIml/CFZNBxbVQ6ro3fYOz5d7/WFjb51BvpH+uFxTbNoEIbBvE2c1XWR4dWUk0r
         Zh3HWexQS+LwdmtH7oxUU0HbtxR4tNnEaEFl0P5ayoc5UJ09YxMIozyogMvXgma/V/h1
         /mv6i5mc9uSoNH3OCDLUdWx0bVBFlK19Nf6JajHt/qOkQuuM1E9Aq9taDSIt0nsTDIwf
         AJTvR2otqPW46+FtQ3S8qBD6HKvoiXtcnZdYP1Ta36D2gDWJa6cuTQaH79G16IaY4ibL
         f5kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710523870; x=1711128670;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4I8kF2HOLsV3f6ALBOCC7UdtwRxp7Bq+Pw3KZf1q5w4=;
        b=V12NQ/Fc2Wu6yBeBdONTTcpiNHwBt+/F9dz9JBYtfiyFEmJQj8BfH8ECOZ3yBghppy
         44E+GNu5yaUAaVBSBLFAYxAWw+gWVjyZCQZu3keyaM4q8gT7as3DHKLBf8FU/W8Ni4/i
         KWa4XYCSFUsO5MvAcOm/MjQqE1P3BHn460efgriTkIww1F2902FCpFMGkwFIyFWFo3BF
         eiB/5JwLF7U+wYMhw1dhownxNUiFMkfBwzFvu/7pMsAt5gwGVRf7+U4NnPyU+LBbPe9k
         rWLbqCFOCYzC7sy4Kkhl37Ufq0Kg43tO8MZcHcRyyFSYBAAy24KyPjsZtaD1tMwc7Dm3
         QZ1g==
X-Forwarded-Encrypted: i=1; AJvYcCVEoCmO+W2bWal9FmVq1SCmOgA6k6wzsSdEBNv/6e88mJwle79PgLd3pj7BViJYy6rv//O8BVSLAYwaEXBm+o2W+q6haGM+LwoH+/Nb
X-Gm-Message-State: AOJu0YxlYoYjup4Zs/M+BYOgJi5klGcPpbbXWhCBVohJ6ZxOYqgvphHL
	cOyMakA+ljfOjKv7yk+JF+pznnMxvjCQMwB55P4NIEbwdIDS+Ov8Rnwr+PztX2qcWg==
X-Google-Smtp-Source: AGHT+IFi4/oRUcITZyAkekpL0lNl9ACqipPV/q1xqTx1K7ccrkOr2Q2sI8ksPqSYFH88beTuMAxc9w==
X-Received: by 2002:a17:906:ad91:b0:a46:7461:b7da with SMTP id la17-20020a170906ad9100b00a467461b7damr3605057ejb.36.1710523870252;
        Fri, 15 Mar 2024 10:31:10 -0700 (PDT)
Received: from ddev.DebianHome (dynamic-095-119-217-226.95.119.pool.telefonica.de. [95.119.217.226])
        by smtp.gmail.com with ESMTPSA id w23-20020aa7da57000000b00568ba93876esm88935eds.28.2024.03.15.10.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 10:31:09 -0700 (PDT)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: selinux@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] selinux: avoid identifier using reserved name
Date: Fri, 15 Mar 2024 18:31:01 +0100
Message-ID: <20240315173105.636749-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240315173105.636749-1-cgzones@googlemail.com>
References: <20240315173105.636749-1-cgzones@googlemail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Avoid using an identifier starting with double underscores, which
signals a reserved identifier.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 security/selinux/hooks.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index a0fde0641f77..f9a61ff64b83 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6347,16 +6347,16 @@ static void selinux_d_instantiate(struct dentry *dentry, struct inode *inode)
 static int selinux_lsm_getattr(unsigned int attr, struct task_struct *p,
 			       char **value)
 {
-	const struct task_security_struct *__tsec;
+	const struct task_security_struct *tsec;
 	u32 sid;
 	int error;
 	unsigned len;
 
 	rcu_read_lock();
-	__tsec = selinux_cred(__task_cred(p));
+	tsec = selinux_cred(__task_cred(p));
 
 	if (current != p) {
-		error = avc_has_perm(current_sid(), __tsec->sid,
+		error = avc_has_perm(current_sid(), tsec->sid,
 				     SECCLASS_PROCESS, PROCESS__GETATTR, NULL);
 		if (error)
 			goto bad;
@@ -6364,22 +6364,22 @@ static int selinux_lsm_getattr(unsigned int attr, struct task_struct *p,
 
 	switch (attr) {
 	case LSM_ATTR_CURRENT:
-		sid = __tsec->sid;
+		sid = tsec->sid;
 		break;
 	case LSM_ATTR_PREV:
-		sid = __tsec->osid;
+		sid = tsec->osid;
 		break;
 	case LSM_ATTR_EXEC:
-		sid = __tsec->exec_sid;
+		sid = tsec->exec_sid;
 		break;
 	case LSM_ATTR_FSCREATE:
-		sid = __tsec->create_sid;
+		sid = tsec->create_sid;
 		break;
 	case LSM_ATTR_KEYCREATE:
-		sid = __tsec->keycreate_sid;
+		sid = tsec->keycreate_sid;
 		break;
 	case LSM_ATTR_SOCKCREATE:
-		sid = __tsec->sockcreate_sid;
+		sid = tsec->sockcreate_sid;
 		break;
 	default:
 		error = -EOPNOTSUPP;
-- 
2.43.0


