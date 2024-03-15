Return-Path: <linux-kernel+bounces-104350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75AC187CC71
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 12:39:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 998EE1C21B67
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 11:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003CB1B974;
	Fri, 15 Mar 2024 11:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="KUfLwR3Y"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4332A1B7E1;
	Fri, 15 Mar 2024 11:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710502741; cv=none; b=pjOuI7u4gVZifmoaTNV0oK/mWk8iquHe/ySDvFcP14hOi2dbl3t2NPyVacW6sBnEyRIv1zXCCxoCip2+pWQyZuxt2yiSyfKSvyQz5yoURBX/lduNmfJ7pXPWq5MN7+9m58XNdy75Z62/L/RWfXlDQklIAi3Gh11P8/B6BnUYDSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710502741; c=relaxed/simple;
	bh=YhK/jnk1sN0Eu2k73vdEasVnkAA21VPShol4SbhmQDE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AigQL+p0k9xR64d7kScCl9sY/XShtfoyniyE0HcHQNI4ap1dvUMmQG2lH6PL4MI3h3r4TP4tepeWkHdyLFKkgO0XSFGnhr5NGX1EGZ7AH63bpUrUD8J/TvHLqfQeX0Muye8zOC9/tccoaOzG4EPgPviJqUUWDUcXKdCry4ONHR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=KUfLwR3Y; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-568a3292916so1984175a12.1;
        Fri, 15 Mar 2024 04:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1710502738; x=1711107538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ret+NQ/Tw5LK56vjyJDNxqW8M+4jtEPqZMI9umR9cCI=;
        b=KUfLwR3YydJAheGuADHmPCFzOmeuutYh+cPx3pAcCH1JXoYknT4HVT9fGpGQHhLJDi
         olBOT21+QWtaOksGCZZ8CHd6EMVD8QEJg4918AHNhf2I62E5flo7lL4zqJRsMDU7tSkI
         /KjLHhFQ3LP3wzTAq9iTpNJKHaTZeFHWPLaYFzQS6+mtrg4S3DEG2suKfDmG7En7mxhc
         Yll27I7dKJujo45T8mZwgFHw8iEAhJm92aNa3iQzb/IFiwXvwqqCsR/8Pw6SplacDztV
         N+9d6NozKyapLVifsnOheV49lTQZGZjObh9/llKi/FIhSOFBYJdC+nf5erbPQW8rhuao
         V40Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710502738; x=1711107538;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ret+NQ/Tw5LK56vjyJDNxqW8M+4jtEPqZMI9umR9cCI=;
        b=er0RKIzF0IcU+kWC90ZhsiiCBSbhUkp2gA5VaqtcF2On1rKBtbSs1mQqtkmD0zvV1Y
         cqxNAKCjrWRra/Zo1WagShjBECx7tJsGMbm8s0e+iJkhu+AJug6VbHmLMF9iyirBqIjr
         ueeon/g/EYndS3y1pM5Efjjw0eAvybhA23DNVaaVrLDjSrT1PWVvxUZRL3pD0TA5vH5M
         PNSjCrjt69l2mMZBqcEOVpLgFlAkoTp6YSkYnWj49PGME05TccHUqiuI8obX0/LqDfcV
         9z/ZcA/jd03Mmq637BbxTxK0p9koyNzLR705XgJ+QbgocOaoa9/PF0hUMev6jNXvpfUg
         y7EQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTWCZDE67T9IvmI0YS4CbbuhFeKCMu6uUu1Zg9qo+Z8onEHrZknnbxYsBA+Pbs5O3h2UVy5ZIAdhCyc+QqDYjPvsp77hQ4qYAIU6kb91XS6xVeH9MzljrD0ODBA8UsYfRULFOKuFhVXwyX1n4+qDo8H0DqxqozFaUC1A==
X-Gm-Message-State: AOJu0Ywzp54EqvzcF+2uV6FJxeco5CfEWjSddoxAOHAJXAk1QRjZ7rAs
	ZQshyNSg7RA1BJS464uoBN4fZqaPA7dXXo75oGC8IzDJQUKBAWDAKKSqAO/B++3GPQ==
X-Google-Smtp-Source: AGHT+IHxB7FB377TOoio0unYbfIwnkxt4g5n3Z4MDqCqa7L7No5w/MvY3FrF55UMKEirChoiUMRGJg==
X-Received: by 2002:a05:6402:530a:b0:568:797a:f2d with SMTP id eo10-20020a056402530a00b00568797a0f2dmr2968341edb.27.1710502737191;
        Fri, 15 Mar 2024 04:38:57 -0700 (PDT)
Received: from ddev.DebianHome (dynamic-095-119-217-226.95.119.pool.telefonica.de. [95.119.217.226])
        by smtp.gmail.com with ESMTPSA id fg3-20020a056402548300b005682f47aea7sm1610024edb.94.2024.03.15.04.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 04:38:56 -0700 (PDT)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: linux-security-module@vger.kernel.org
Cc: linux-block@vger.kernel.org,
	Paul Moore <paul@paul-moore.com>,
	John Johansen <john.johansen@canonical.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Christian Brauner <brauner@kernel.org>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Khadija Kamran <kamrankhadijadj@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	linux-kernel@vger.kernel.org,
	apparmor@lists.ubuntu.com,
	selinux@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH 01/10] capability: introduce new capable flag CAP_OPT_NOAUDIT_ONDENY
Date: Fri, 15 Mar 2024 12:37:22 +0100
Message-ID: <20240315113828.258005-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Introduce a new capable flag, CAP_OPT_NOAUDIT_ONDENY, to not generate
an audit event if the requested capability is not granted.  This will be
used in a new capable_any() functionality to reduce the number of
necessary capable calls.

Handle the flag accordingly in AppArmor and SELinux.

CC: linux-block@vger.kernel.org
Suggested-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v5:
   rename flag to CAP_OPT_NOAUDIT_ONDENY, suggested by Serge:
     https://lore.kernel.org/all/20230606190013.GA640488@mail.hallyn.com/
---
 include/linux/security.h       |  2 ++
 security/apparmor/capability.c |  8 +++++---
 security/selinux/hooks.c       | 14 ++++++++------
 3 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 41a8f667bdfa..c60cae78ff8b 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -70,6 +70,8 @@ struct lsm_ctx;
 #define CAP_OPT_NOAUDIT BIT(1)
 /* If capable is being called by a setid function */
 #define CAP_OPT_INSETID BIT(2)
+/* If capable should audit the security request for authorized requests only */
+#define CAP_OPT_NOAUDIT_ONDENY BIT(3)
 
 /* LSM Agnostic defines for security_sb_set_mnt_opts() flags */
 #define SECURITY_LSM_NATIVE_LABELS	1
diff --git a/security/apparmor/capability.c b/security/apparmor/capability.c
index 9934df16c843..08c9c9a0fc19 100644
--- a/security/apparmor/capability.c
+++ b/security/apparmor/capability.c
@@ -108,7 +108,8 @@ static int audit_caps(struct apparmor_audit_data *ad, struct aa_profile *profile
  * profile_capable - test if profile allows use of capability @cap
  * @profile: profile being enforced    (NOT NULL, NOT unconfined)
  * @cap: capability to test if allowed
- * @opts: CAP_OPT_NOAUDIT bit determines whether audit record is generated
+ * @opts: CAP_OPT_NOAUDIT/CAP_OPT_NOAUDIT_ONDENY bit determines whether audit
+ *	record is generated
  * @ad: audit data (MAY BE NULL indicating no auditing)
  *
  * Returns: 0 if allowed else -EPERM
@@ -126,7 +127,7 @@ static int profile_capable(struct aa_profile *profile, int cap,
 	else
 		error = -EPERM;
 
-	if (opts & CAP_OPT_NOAUDIT) {
+	if ((opts & CAP_OPT_NOAUDIT) || ((opts & CAP_OPT_NOAUDIT_ONDENY) && error)) {
 		if (!COMPLAIN_MODE(profile))
 			return error;
 		/* audit the cap request in complain mode but note that it
@@ -143,7 +144,8 @@ static int profile_capable(struct aa_profile *profile, int cap,
  * @subj_cred: cred we are testing capability against
  * @label: label being tested for capability (NOT NULL)
  * @cap: capability to be tested
- * @opts: CAP_OPT_NOAUDIT bit determines whether audit record is generated
+ * @opts: CAP_OPT_NOAUDIT/CAP_OPT_NOAUDIT_ONDENY bit determines whether audit
+ *	record is generated
  *
  * Look up capability in profile capability set.
  *
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 3448454c82d0..1a2c7c1a89be 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -1624,7 +1624,7 @@ static int cred_has_capability(const struct cred *cred,
 	u16 sclass;
 	u32 sid = cred_sid(cred);
 	u32 av = CAP_TO_MASK(cap);
-	int rc;
+	int rc, rc2;
 
 	ad.type = LSM_AUDIT_DATA_CAP;
 	ad.u.cap = cap;
@@ -1643,11 +1643,13 @@ static int cred_has_capability(const struct cred *cred,
 	}
 
 	rc = avc_has_perm_noaudit(sid, sid, sclass, av, 0, &avd);
-	if (!(opts & CAP_OPT_NOAUDIT)) {
-		int rc2 = avc_audit(sid, sid, sclass, av, &avd, rc, &ad);
-		if (rc2)
-			return rc2;
-	}
+	if ((opts & CAP_OPT_NOAUDIT) || ((opts & CAP_OPT_NOAUDIT_ONDENY) && rc))
+		return rc;
+
+	rc2 = avc_audit(sid, sid, sclass, av, &avd, rc, &ad);
+	if (rc2)
+		return rc2;
+
 	return rc;
 }
 
-- 
2.43.0


