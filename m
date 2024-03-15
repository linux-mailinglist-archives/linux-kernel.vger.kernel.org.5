Return-Path: <linux-kernel+bounces-104351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4D087CC76
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 12:39:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFE5C1C2165F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 11:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCAB11BF3C;
	Fri, 15 Mar 2024 11:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="hpTRPgYe"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E399C1B800;
	Fri, 15 Mar 2024 11:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710502741; cv=none; b=PCTrMLOPOnNrV37EUk7HzoEUCZukvZnvO3ipV65GlwO3/Exk+zg2A1e+W8M6nzICdc+hzS8Zn/j07eHwYNod0egX1zlONWqYzOO1usHvR8VsmRNP4NDrTi14WpzdpzOpRPDoyF5wgKwT0nVd/gwp/DNOJB+piI33mPN+ViJf8UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710502741; c=relaxed/simple;
	bh=j7P+rtIooN2RFNFnyJNgWaUvzjlWg7b4FVbZggyZikc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mfTAxlOlvWiN47myPZaOCq0Uw2NBup1mJ/mkU57zkenU2uJ36ddLrIBk+BT1KXWsIyXdcoF8kAAIjX4vEI9hyhMHXLI5gUinvPvRRQ/9lkgrd2aa1M0dwwk4ukqDK6K7QZUZtgPv/B09PEaNekTDGVfuZeat/erOSwo11NNIn20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=hpTRPgYe; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-568a4e4893aso2179820a12.1;
        Fri, 15 Mar 2024 04:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1710502738; x=1711107538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mi8E9ZQLQ9LPypjXpm7Mdpqzk72OEqhwCGPKB2XFHjg=;
        b=hpTRPgYe5GXaEAn9eTTcpIsZrEFO8P5joIE/JhnbQe5VpSqWGHGY6pgFkQPoeSjNxb
         fTyQTzI844hwWZ3jQCGtUywow2NOllXYqunr1vxQUaoVZDtUfDxCGUgZOwk4w1IdpXLc
         FVrlb1B2GUaIaBOexBq5OePELYSy5skHSAEfl+j+h8yX4r9wmaNr8Sz2cDuHoU6bsXAF
         F6jBSKCFbULXMyCiYXv/OLgka1XlfYe73+dJ2CZsL84DFaYwNVKhDoq2QmFj05kHeJmQ
         Rpi8UXIpXLYqA4sEdOy0d8KVBxC6gybj5hnotkE2YbyGJLFP8jsyOhopJnSh+yOip27Q
         jFrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710502738; x=1711107538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mi8E9ZQLQ9LPypjXpm7Mdpqzk72OEqhwCGPKB2XFHjg=;
        b=Z3eDgcvJcknfHzPkpcAGVrs2HG921dc9yxhb4nc5zy1qsJfhQu6zJqu1dZX/8xfvJA
         pV1t7fRFUhwEm/Wd5dwmkdkm52vzpJal0eboZ3zekl2ZrHM9QSYC6QOWGdlM6UL+FB9r
         5i7hDdWn8KDOILyOgN3fuypFWAsz3wXTjaGDVhEn8DtZu9idbL9Vg6g+s0M/UlLIJQgu
         7COvCgp6EC8s5Er+BOUYJnh83D3i5oQ3MLiMtpDj12/v/P48y6L995ppH9U3fGwmqldK
         G7qcaJNMN9yiek1OQrvM1WZDeWCjDCiyVi0T7FtkjaaeKukw4CS3houuqcSNlOCc7RYz
         LNeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUT576hySEWT275IgjZjkdJhutpz18TI7V1eXIakSQ665FCCzcucaOhxeZM+QIq/whnnfkKmdye8X2FWOMsvHtLATanH9QmN3gflZ7ELifMyZuEuAHoblwXsi11XsxH1ue7
X-Gm-Message-State: AOJu0YzXAx1/fa5lQxbBjI6KEo4vh/YpcCqXZHbNL6P1fYYneKDlxwuR
	bT6svy4rF+i5YZj9TcZ39B1Vm+aachoCwN5Oe/UZXZu4maUsuorQhhBYlir7effIKQ==
X-Google-Smtp-Source: AGHT+IHXsjVgfepYPNctqMBAmfS5W/9E8hiHUchOPAmdfdCjerS73D/Om6GB/wuGRmgu/APbTnlg/g==
X-Received: by 2002:a50:8d14:0:b0:568:b0f4:fe69 with SMTP id s20-20020a508d14000000b00568b0f4fe69mr1272361eds.12.1710502738062;
        Fri, 15 Mar 2024 04:38:58 -0700 (PDT)
Received: from ddev.DebianHome (dynamic-095-119-217-226.95.119.pool.telefonica.de. [95.119.217.226])
        by smtp.gmail.com with ESMTPSA id fg3-20020a056402548300b005682f47aea7sm1610024edb.94.2024.03.15.04.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 04:38:57 -0700 (PDT)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: linux-security-module@vger.kernel.org
Cc: linux-block@vger.kernel.org,
	Serge Hallyn <serge@hallyn.com>,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH 02/10] capability: add any wrappers to test for multiple caps with exactly one audit message
Date: Fri, 15 Mar 2024 12:37:23 +0100
Message-ID: <20240315113828.258005-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240315113828.258005-1-cgzones@googlemail.com>
References: <20240315113828.258005-1-cgzones@googlemail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add the interfaces `capable_any()` and `ns_capable_any()` as an
alternative to multiple `capable()`/`ns_capable()` calls, like
`capable_any(CAP_SYS_NICE, CAP_SYS_ADMIN)` instead of
`capable(CAP_SYS_NICE) || capable(CAP_SYS_ADMIN)`.

`capable_any()`/`ns_capable_any()` will in particular generate exactly
one audit message, either for the left most capability in effect or, if
the task has none, the first one.

This is especially helpful with regard to SELinux, where each audit
message about a not allowed capability request will create a denial
message.  Using this new wrapper with the least invasive capability as
left most argument (e.g. CAP_SYS_NICE before CAP_SYS_ADMIN) enables
policy writers to only grant the least invasive one for the particular
subject instead of both.

CC: linux-block@vger.kernel.org
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v5:
   - add check for identical passed capabilities
   - rename internal helper according to flag rename to
     ns_capable_noauditondeny()
v4:
   Use CAP_OPT_NODENYAUDIT via added ns_capable_nodenyaudit()
v3:
   - rename to capable_any()
   - fix typo in function documentation
   - add ns_capable_any()
v2:
   avoid varargs and fix to two capabilities; capable_or3() can be added
   later if needed
---
 include/linux/capability.h | 10 ++++++
 kernel/capability.c        | 73 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 83 insertions(+)

diff --git a/include/linux/capability.h b/include/linux/capability.h
index 0c356a517991..eeb958440656 100644
--- a/include/linux/capability.h
+++ b/include/linux/capability.h
@@ -146,7 +146,9 @@ extern bool has_capability_noaudit(struct task_struct *t, int cap);
 extern bool has_ns_capability_noaudit(struct task_struct *t,
 				      struct user_namespace *ns, int cap);
 extern bool capable(int cap);
+extern bool capable_any(int cap1, int cap2);
 extern bool ns_capable(struct user_namespace *ns, int cap);
+extern bool ns_capable_any(struct user_namespace *ns, int cap1, int cap2);
 extern bool ns_capable_noaudit(struct user_namespace *ns, int cap);
 extern bool ns_capable_setid(struct user_namespace *ns, int cap);
 #else
@@ -172,10 +174,18 @@ static inline bool capable(int cap)
 {
 	return true;
 }
+static inline bool capable_any(int cap1, int cap2)
+{
+	return true;
+}
 static inline bool ns_capable(struct user_namespace *ns, int cap)
 {
 	return true;
 }
+static inline bool ns_capable_any(struct user_namespace *ns, int cap1, int cap2)
+{
+	return true;
+}
 static inline bool ns_capable_noaudit(struct user_namespace *ns, int cap)
 {
 	return true;
diff --git a/kernel/capability.c b/kernel/capability.c
index dac4df77e376..73358abfe2e1 100644
--- a/kernel/capability.c
+++ b/kernel/capability.c
@@ -402,6 +402,23 @@ bool ns_capable_noaudit(struct user_namespace *ns, int cap)
 }
 EXPORT_SYMBOL(ns_capable_noaudit);
 
+/**
+ * ns_capable_noauditondeny - Determine if the current task has a superior capability
+ * (unaudited when unauthorized) in effect
+ * @ns:  The usernamespace we want the capability in
+ * @cap: The capability to be tested for
+ *
+ * Return true if the current task has the given superior capability currently
+ * available for use, false if not.
+ *
+ * This sets PF_SUPERPRIV on the task if the capability is available on the
+ * assumption that it's about to be used.
+ */
+static bool ns_capable_noauditondeny(struct user_namespace *ns, int cap)
+{
+	return ns_capable_common(ns, cap, CAP_OPT_NOAUDIT_ONDENY);
+}
+
 /**
  * ns_capable_setid - Determine if the current task has a superior capability
  * in effect, while signalling that this check is being done from within a
@@ -421,6 +438,62 @@ bool ns_capable_setid(struct user_namespace *ns, int cap)
 }
 EXPORT_SYMBOL(ns_capable_setid);
 
+/**
+ * ns_capable_any - Determine if the current task has one of two superior capabilities in effect
+ * @ns:  The usernamespace we want the capability in
+ * @cap1: The capabilities to be tested for first
+ * @cap2: The capabilities to be tested for secondly
+ *
+ * Return true if the current task has at least one of the two given superior
+ * capabilities currently available for use, false if not.
+ *
+ * In contrast to or'ing capable() this call will create exactly one audit
+ * message, either for @cap1, if it is granted or both are not permitted,
+ * or @cap2, if it is granted while the other one is not.
+ *
+ * The capabilities should be ordered from least to most invasive, i.e. CAP_SYS_ADMIN last.
+ *
+ * This sets PF_SUPERPRIV on the task if the capability is available on the
+ * assumption that it's about to be used.
+ */
+bool ns_capable_any(struct user_namespace *ns, int cap1, int cap2)
+{
+	if (cap1 == cap2)
+		return ns_capable(ns, cap1);
+
+	if (ns_capable_noauditondeny(ns, cap1))
+		return true;
+
+	if (ns_capable_noauditondeny(ns, cap2))
+		return true;
+
+	return ns_capable(ns, cap1);
+}
+EXPORT_SYMBOL(ns_capable_any);
+
+/**
+ * capable_any - Determine if the current task has one of two superior capabilities in effect
+ * @cap1: The capabilities to be tested for first
+ * @cap2: The capabilities to be tested for secondly
+ *
+ * Return true if the current task has at least one of the two given superior
+ * capabilities currently available for use, false if not.
+ *
+ * In contrast to or'ing capable() this call will create exactly one audit
+ * message, either for @cap1, if it is granted or both are not permitted,
+ * or @cap2, if it is granted while the other one is not.
+ *
+ * The capabilities should be ordered from least to most invasive, i.e. CAP_SYS_ADMIN last.
+ *
+ * This sets PF_SUPERPRIV on the task if the capability is available on the
+ * assumption that it's about to be used.
+ */
+bool capable_any(int cap1, int cap2)
+{
+	return ns_capable_any(&init_user_ns, cap1, cap2);
+}
+EXPORT_SYMBOL(capable_any);
+
 /**
  * capable - Determine if the current task has a superior capability in effect
  * @cap: The capability to be tested for
-- 
2.43.0


