Return-Path: <linux-kernel+bounces-107816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8173A88020E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5CB61C22EE6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 16:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C16D81ADB;
	Tue, 19 Mar 2024 16:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="cBIDENnM"
Received: from out203-205-221-191.mail.qq.com (out203-205-221-191.mail.qq.com [203.205.221.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED3D81ABB
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 16:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710864960; cv=none; b=GY7e1fGxNdPazkWiB37TdOaFA4m5qksmTIo4YeM/Qr4BrGTJfDOGlmj57jEmjsjlg0OICGhupFon5VRH94eHq1bQz/X8vmouKG/QCdkZ37wwdSiBLCw4y9hflBnOho8uIuzxqNwIyLDSRqpZKGLOsYVe11uhMXVpvzZ2YJA4/wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710864960; c=relaxed/simple;
	bh=MQwq3CaKFobz/Og+FyJkBLflAT+jCfZ/jcxb/K41MAY=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=TIDXkTrzyi/zbOSTF1LXEO15fmFoPIjyRtAzoGEk9fo5pwAlx6I5/S/1pClsElMepjj4P2kMN6rM4C6nHiV1IcHjhUZSZwceinLasaLbZkyhb3AOS/Djp0RHWz4Wx4W+008YwklNkjRDG33bQyWG8KP/P0i2rBMn3a60K3GB4pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=cBIDENnM; arc=none smtp.client-ip=203.205.221.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1710864949;
	bh=fwstqXNrz8sY5tQtk9MdOqROTvTakp2tAFmoCiSvqDs=;
	h=From:To:Cc:Subject:Date;
	b=cBIDENnMtYV2oQ6R1iwcTp6EN1EAfCach3I8e1MLZPl3t3W4pDhalvegm+WtGWI49
	 uMCNqxyWYS1j4g/DptiF4u+sqpcBNmmeAp2vplmcagBRONXxV3OQlyZGDp7oZGlPfv
	 7ICqwRDANWD/VgkqW9J/TPw00nONND128YNrqkZA=
Received: from localhost.localdomain ([2409:8a60:2a60:b160:1774:d6f7:f5f5:b6a])
	by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
	id E8996A1C; Tue, 19 Mar 2024 23:58:09 +0800
X-QQ-mid: xmsmtpt1710863889tsixp1msu
Message-ID: <tencent_0D6ABA209A4980742DE6003FBFE7FE2A3207@qq.com>
X-QQ-XMAILINFO: OZZSS56D9fAjJx2XFB9CPVqNM2/4Sxeta/bYS5Nf960ywqFXKQQtZpe/1Ub5sH
	 Z8oTDc2Gdjz4phxaPWEcl2KqRPj3ugBceSY18RteibdfMOLWdYLWnDPrK6TFLKVekjBE/hVLwH8C
	 jRjv3nGMJZfv5ronxCEnaLthKXF10AaiRYL7CDQ/PxMogKpEDTnWkX8QnpqP0Luj9/hXMsvBVbAP
	 Vsf9kClTEpsnBcbqVaNFcsIjzItWqHWhfL143bMXgHQJvhcdeiZPCT6OvzYUjPIS6SauCoxYCjtO
	 P0fQ48wP7mCwF8M9m2pKUx5/AUA00DVW6Au7ubptgdCHWeMdWJ2LEwxkxyU3iIn/riQ/HAs7Ahtp
	 oT6LgqLGqzGigbKLg7XG27y/5mtcqVCgB7FRG0wzWV0KiVtcUDbYSDM575VpmsbF/StHrX2QxVVn
	 raxZYtMA6whSH667/vEfRnY42F2gBpzjLiND7cb5ze7Uox+T1WNG1xTHLerb73DQGc9kVgSRc0t1
	 e98zgjqxf67H/tWtmV8NqhFJJPbgLQpyyc76SXHg03pMaK88qBjDybMH1rucG9Cqcpiotb4cmMMj
	 Ows3y4kWLbl3vROzOXg8vlxtli9/JSamZAFgcucRRKOUhkSZFpfUire3jYmsQeqIExoghiCZnqEA
	 nNzEFUoicZiCya8tRdPJegC8dtvE9H9O5qdpA6/afQh93O61Xe4XfkgSyPRYDyYGc9ZFtcpmqcGQ
	 8Kj73cqOgBNlvje969scq05Z7ippwRiFU6tPQN39lo3Qlt2ri1/C9/Xd264M9dYMhR3IjG1fjpRt
	 wKTIHm4odZ5IKYsV6nUkUrweM8pPDoKU7cuiVnOyD11S+md2f4L5J7cf0ihRqr9AbWBoaNqxbLiI
	 5dcCuvLYIL96wSd7Gu5qvwoecD6al9fi/Es8xDdS5ntseeMGLY+HR75jGTF4XRiMnZ0pCPAKOCoZ
	 zp3GzW4PE+fQaUqnWQcXeaKAfJ2adPO9wRPjekAXh03iajRJNUSmITFdo5m3TMlDfvABKgoidH5b
	 19Jc/M9+5+HxE9b+UN
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: wenyang.linux@foxmail.com
To: "Eric W . Biederman" <ebiederm@xmission.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Joel Granados <j.granados@samsung.com>,
	Christian Brauner <brauner@kernel.org>
Cc: Dave Young <dyoung@redhat.com>,
	Wen Yang <wenyang.linux@foxmail.com>,
	Iurii Zaikin <yzaikin@google.com>,
	linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v2 1/9] sysctl: support encoding values directly in the table entry
Date: Tue, 19 Mar 2024 23:57:42 +0800
X-OQ-MSGID: <26c450f6467b4cbaf94cdb10f047abc6ab0c2a5d.1710863674.git.wenyang.linux@foxmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wen Yang <wenyang.linux@foxmail.com>

Eric pointed out:
- by turning .extra1 and .extra2 into longs instead of keeping them as
  pointers and needing constants to be pointed at somewhere.
- The only people I can see who find a significant benefit by consolidating
  all of the constants into one place are people who know how to stomp
  kernel memory.

This patch supports encoding values directly in table entries through the
following work:
- extra1/extra2 and min/max are placed in one union to ensure that the
  previous code is not broken, then we have time to remove unnecessary
  extra1/extra2 progressively;
- since type only has two states, use one bit to represent it;
- two bits were used to represent the information of the above union( 0:
  using extra1/extra2, 1: using min, 2: using max, 3: using both min/max);
- added some helper macros.

Suggested-by: Eric W. Biederman <ebiederm@xmission.com>
Signed-off-by: Wen Yang <wenyang.linux@foxmail.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Joel Granados <j.granados@samsung.com>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Iurii Zaikin <yzaikin@google.com>
Cc: linux-kernel@vger.kernel.org
---
 include/linux/sysctl.h | 108 ++++++++++++++++++++++++++++++++++++++---
 kernel/sysctl.c        |  61 +++++++++++++++++------
 2 files changed, 148 insertions(+), 21 deletions(-)

diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index ee7d33b89e9e..1ba980219e40 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -61,6 +61,25 @@ extern const int sysctl_vals[];
 
 extern const unsigned long sysctl_long_vals[];
 
+#define	SYSCTL_NUMERIC_NEG_ONE			((long)-1)
+#define	SYSCTL_NUMERIC_ZERO			(0L)
+#define	SYSCTL_NUMERIC_ONE			(1L)
+#define	SYSCTL_NUMERIC_TWO			(2L)
+#define	SYSCTL_NUMERIC_THREE			(3L)
+#define	SYSCTL_NUMERIC_FOUR			(4L)
+#define	SYSCTL_NUMERIC_ONE_HUNDRED		(100L)
+#define	SYSCTL_NUMERIC_TWO_HUNDRED		(200L)
+#define	SYSCTL_NUMERIC_THREE_HUNDRED		(300L)
+#define	SYSCTL_NUMERIC_FIVE_HUNDRED		(500L)
+#define	SYSCTL_NUMERIC_ONE_THOUSAND		(1000L)
+#define	SYSCTL_NUMERIC_TWO_THOUSAND		(2000L)
+#define	SYSCTL_NUMERIC_THREE_THOUSAND		(3000L)
+#define	SYSCTL_NUMERIC_16K			(16384L)
+#define	SYSCTL_NUMERIC_U8_MAX			((long)U8_MAX)
+#define	SYSCTL_NUMERIC_U16_MAX			((long)U16_MAX)
+#define	SYSCTL_NUMERIC_INT_MAX			((long)INT_MAX)
+#define	SYSCTL_NUMERIC_LONG_MAX			(LONG_MAX)
+
 typedef int proc_handler(struct ctl_table *ctl, int write, void *buffer,
 		size_t *lenp, loff_t *ppos);
 
@@ -131,6 +150,18 @@ static inline void *proc_sys_poll_event(struct ctl_table_poll *poll)
 #define DEFINE_CTL_TABLE_POLL(name)					\
 	struct ctl_table_poll name = __CTL_TABLE_POLL_INITIALIZER(name)
 
+enum {
+	SYSCTL_TABLE_TYPE_DEFAULT,
+	SYSCTL_TABLE_TYPE_PERMANENTLY_EMPTY
+};
+
+enum {
+	SYSCTL_TABLE_EXTRA_PTR,
+	SYSCTL_TABLE_EXTRA_LONG_INIT_MIN,
+	SYSCTL_TABLE_EXTRA_LONG_INIT_MAX,
+	SYSCTL_TABLE_EXTRA_LONG_INIT_MINMAX
+};
+
 /* A sysctl table is an array of struct ctl_table: */
 struct ctl_table {
 	const char *procname;		/* Text ID for /proc/sys, or zero */
@@ -138,20 +169,39 @@ struct ctl_table {
 	int maxlen;
 	umode_t mode;
 	/**
-	 * enum type - Enumeration to differentiate between ctl target types
+	 * type - Indicates to differentiate between ctl target types
 	 * @SYSCTL_TABLE_TYPE_DEFAULT: ctl target with no special considerations
 	 * @SYSCTL_TABLE_TYPE_PERMANENTLY_EMPTY: Used to identify a permanently
 	 *                                       empty directory target to serve
 	 *                                       as mount point.
 	 */
-	enum {
-		SYSCTL_TABLE_TYPE_DEFAULT,
-		SYSCTL_TABLE_TYPE_PERMANENTLY_EMPTY
-	} type;
+	u8 type:1;
+
+	/**
+	 * extra_flags
+	 * @SYSCTL_TABLE_EXTRA_PTR: flag indicating that this uses extra1/extra2.
+	 * @SYSCTL_TABLE_EXTRA_LONG_INIT_MIN: flag indicating that this uses min/max
+					      and min has been initialized.
+	 * @SYSCTL_TABLE_EXTRA_LONG_INIT_MAX: flag indicating that this uses min/max
+					      and max has been initialized.
+	 * @SYSCTL_TABLE_EXTRA_LONG_INIT_MINMAX: flag indicating that this uses min/max
+						 and both have been initialized.
+	 *
+	 */
+	u8 extra_flags:2;
+	union {
+		struct {
+			void *extra1;
+			void *extra2;
+		};
+		struct {
+			long min;
+			long max;
+		};
+	};
+
 	proc_handler *proc_handler;	/* Callback for text formatting */
 	struct ctl_table_poll *poll;
-	void *extra1;
-	void *extra2;
 } __randomize_layout;
 
 struct ctl_node {
@@ -213,6 +263,50 @@ struct ctl_table_root {
 #define register_sysctl(path, table)	\
 	register_sysctl_sz(path, table, ARRAY_SIZE(table))
 
+#define CTL_TABLE_ENTRY(_name, _data, _len, _mode, _func)		      \
+	{								      \
+		.procname = _name,					      \
+		.data = _data,						      \
+		.maxlen = _len,						      \
+		.mode = _mode,						      \
+		.proc_handler = _func,					      \
+		.extra_flags = SYSCTL_TABLE_EXTRA_PTR,			      \
+	}
+
+#define CTL_TABLE_ENTRY_MIN(_name, _data, _len, _mode, _func, _min)	      \
+	{								      \
+		.procname = _name,					      \
+		.data = _data,						      \
+		.maxlen = _len,						      \
+		.mode = _mode,						      \
+		.proc_handler = _func,					      \
+		.min = _min,						      \
+		.extra_flags = SYSCTL_TABLE_EXTRA_LONG_INIT_MIN,	      \
+	}
+
+#define CTL_TABLE_ENTRY_MAX(_name, _data, _len, _mode, _func, _max)	      \
+	{								      \
+		.procname = _name,					      \
+		.data = _data,						      \
+		.maxlen = _len,						      \
+		.mode = _mode,						      \
+		.proc_handler = _func,					      \
+		.max = _max,						      \
+		.extra_flags = SYSCTL_TABLE_EXTRA_LONG_INIT_MAX,	      \
+	}
+
+#define CTL_TABLE_ENTRY_MINMAX(_name, _data, _len, _mode, _func, _min, _max)  \
+	{								      \
+		.procname = _name,					      \
+		.data = _data,						      \
+		.maxlen = _len,						      \
+		.mode = _mode,						      \
+		.proc_handler = _func,					      \
+		.min = _min,						      \
+		.max = _max,						      \
+		.extra_flags = SYSCTL_TABLE_EXTRA_LONG_INIT_MINMAX,	      \
+	}
+
 #ifdef CONFIG_SYSCTL
 
 void proc_sys_poll_notify(struct ctl_table_poll *poll);
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 157f7ce2942d..144c441236ab 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -822,6 +822,20 @@ struct do_proc_dointvec_minmax_conv_param {
 	int *max;
 };
 
+static void do_int_conv_param_init(const struct ctl_table *table,
+		struct do_proc_dointvec_minmax_conv_param *param)
+{
+	if (table->extra_flags == SYSCTL_TABLE_EXTRA_PTR) {
+		param->min = table->extra1;
+		param->max = table->extra2;
+	} else {
+		param->min = (table->extra_flags & SYSCTL_TABLE_EXTRA_LONG_INIT_MIN) ?
+			(int *)&table->min : NULL;
+		param->max = (table->extra_flags & SYSCTL_TABLE_EXTRA_LONG_INIT_MAX) ?
+			(int *)&table->max : NULL;
+	}
+}
+
 static int do_proc_dointvec_minmax_conv(bool *negp, unsigned long *lvalp,
 					int *valp,
 					int write, void *data)
@@ -867,10 +881,9 @@ static int do_proc_dointvec_minmax_conv(bool *negp, unsigned long *lvalp,
 int proc_dointvec_minmax(struct ctl_table *table, int write,
 		  void *buffer, size_t *lenp, loff_t *ppos)
 {
-	struct do_proc_dointvec_minmax_conv_param param = {
-		.min = (int *) table->extra1,
-		.max = (int *) table->extra2,
-	};
+	struct do_proc_dointvec_minmax_conv_param param;
+
+	do_int_conv_param_init(table, &param);
 	return do_proc_dointvec(table, write, buffer, lenp, ppos,
 				do_proc_dointvec_minmax_conv, &param);
 }
@@ -889,6 +902,20 @@ struct do_proc_douintvec_minmax_conv_param {
 	unsigned int *max;
 };
 
+static void do_uint_conv_param_init(const struct ctl_table *table,
+		struct do_proc_douintvec_minmax_conv_param *param)
+{
+	if (table->extra_flags == SYSCTL_TABLE_EXTRA_PTR) {
+		param->min = table->extra1;
+		param->max = table->extra2;
+	} else {
+		param->min = (table->extra_flags & SYSCTL_TABLE_EXTRA_LONG_INIT_MIN) ?
+			(unsigned int *)&table->min : NULL;
+		param->max = (table->extra_flags & SYSCTL_TABLE_EXTRA_LONG_INIT_MAX) ?
+			(unsigned int *)&table->max : NULL;
+	}
+}
+
 static int do_proc_douintvec_minmax_conv(unsigned long *lvalp,
 					 unsigned int *valp,
 					 int write, void *data)
@@ -936,10 +963,9 @@ static int do_proc_douintvec_minmax_conv(unsigned long *lvalp,
 int proc_douintvec_minmax(struct ctl_table *table, int write,
 			  void *buffer, size_t *lenp, loff_t *ppos)
 {
-	struct do_proc_douintvec_minmax_conv_param param = {
-		.min = (unsigned int *) table->extra1,
-		.max = (unsigned int *) table->extra2,
-	};
+	struct do_proc_douintvec_minmax_conv_param param;
+
+	do_uint_conv_param_init(table, &param);
 	return do_proc_douintvec(table, write, buffer, lenp, ppos,
 				 do_proc_douintvec_minmax_conv, &param);
 }
@@ -1038,8 +1064,16 @@ static int __do_proc_doulongvec_minmax(void *data, struct ctl_table *table,
 	}
 
 	i = data;
-	min = table->extra1;
-	max = table->extra2;
+	if (table->extra_flags == SYSCTL_TABLE_EXTRA_PTR) {
+		min = table->extra1;
+		max = table->extra2;
+	} else {
+		min = (table->extra_flags & SYSCTL_TABLE_EXTRA_LONG_INIT_MIN) ?
+			&table->min : NULL;
+		max = (table->extra_flags & SYSCTL_TABLE_EXTRA_LONG_INIT_MAX) ?
+			&table->max : NULL;
+	}
+
 	vleft = table->maxlen / sizeof(unsigned long);
 	left = *lenp;
 
@@ -1274,10 +1308,9 @@ int proc_dointvec_jiffies(struct ctl_table *table, int write,
 int proc_dointvec_ms_jiffies_minmax(struct ctl_table *table, int write,
 			  void *buffer, size_t *lenp, loff_t *ppos)
 {
-	struct do_proc_dointvec_minmax_conv_param param = {
-		.min = (int *) table->extra1,
-		.max = (int *) table->extra2,
-	};
+	struct do_proc_dointvec_minmax_conv_param param;
+
+	do_int_conv_param_init(table, &param);
 	return do_proc_dointvec(table, write, buffer, lenp, ppos,
 			do_proc_dointvec_ms_jiffies_minmax_conv, &param);
 }
-- 
2.25.1


