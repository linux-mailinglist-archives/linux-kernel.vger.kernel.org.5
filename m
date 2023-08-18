Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E372780F9F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 17:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378337AbjHRPxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 11:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378338AbjHRPxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 11:53:19 -0400
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 533342D56;
        Fri, 18 Aug 2023 08:53:12 -0700 (PDT)
Received: from jerom (unknown [128.107.241.169])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: serge)
        by mail.hallyn.com (Postfix) with ESMTPSA id 368EE746;
        Fri, 18 Aug 2023 10:53:06 -0500 (CDT)
Date:   Fri, 18 Aug 2023 10:53:04 -0500
From:   Serge Hallyn <serge@hallyn.com>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     paul@paul-moore.com, linux-security-module@vger.kernel.org,
        jmorris@namei.org, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, mic@digikod.net
Subject: Re: [PATCH v13 11/11] LSM: selftests for Linux Security Module
 syscalls
Message-ID: <ZN+T4NA/l1ykwxpr@jerom>
References: <20230802174435.11928-1-casey@schaufler-ca.com>
 <20230802174435.11928-12-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230802174435.11928-12-casey@schaufler-ca.com>
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,RCVD_IN_SBL_CSS,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2023 at 10:44:34AM -0700, Casey Schaufler wrote:
> Add selftests for the three system calls supporting the LSM
> infrastructure. This set of tests is limited by the differences
> in access policy enforced by the existing security modules.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

I know these are just testcases, but a few things stood out below.

The actual set of tests looks good, though.  Thanks.

> ---
>  MAINTAINERS                                   |   1 +
>  tools/testing/selftests/Makefile              |   1 +
>  tools/testing/selftests/lsm/Makefile          |  19 ++
>  tools/testing/selftests/lsm/common.c          |  81 ++++++
>  tools/testing/selftests/lsm/common.h          |  33 +++
>  tools/testing/selftests/lsm/config            |   3 +
>  .../selftests/lsm/lsm_get_self_attr_test.c    | 240 ++++++++++++++++++
>  .../selftests/lsm/lsm_list_modules_test.c     | 140 ++++++++++
>  .../selftests/lsm/lsm_set_self_attr_test.c    |  74 ++++++
>  9 files changed, 592 insertions(+)
>  create mode 100644 tools/testing/selftests/lsm/Makefile
>  create mode 100644 tools/testing/selftests/lsm/common.c
>  create mode 100644 tools/testing/selftests/lsm/common.h
>  create mode 100644 tools/testing/selftests/lsm/config
>  create mode 100644 tools/testing/selftests/lsm/lsm_get_self_attr_test.c
>  create mode 100644 tools/testing/selftests/lsm/lsm_list_modules_test.c
>  create mode 100644 tools/testing/selftests/lsm/lsm_set_self_attr_test.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index aca4db11dd02..c96f1c388d22 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -19158,6 +19158,7 @@ W:	http://kernsec.org/
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git
>  F:	include/uapi/linux/lsm.h
>  F:	security/
> +F:	tools/testing/selftests/lsm/
>  X:	security/selinux/
>  
>  SELINUX SECURITY MODULE
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index 666b56f22a41..bde7c217b23f 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -39,6 +39,7 @@ TARGETS += landlock
>  TARGETS += lib
>  TARGETS += livepatch
>  TARGETS += lkdtm
> +TARGETS += lsm
>  TARGETS += membarrier
>  TARGETS += memfd
>  TARGETS += memory-hotplug
> diff --git a/tools/testing/selftests/lsm/Makefile b/tools/testing/selftests/lsm/Makefile
> new file mode 100644
> index 000000000000..bae6c1e3bba4
> --- /dev/null
> +++ b/tools/testing/selftests/lsm/Makefile
> @@ -0,0 +1,19 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# First run: make -C ../../../.. headers_install
> +
> +CFLAGS += -Wall -O2 $(KHDR_INCLUDES)
> +LOCAL_HDRS += common.h
> +
> +TEST_GEN_PROGS := lsm_get_self_attr_test lsm_list_modules_test \
> +		  lsm_set_self_attr_test
> +
> +include ../lib.mk
> +
> +$(TEST_GEN_PROGS):
> +
> +$(OUTPUT)/lsm_get_self_attr_test: lsm_get_self_attr_test.c common.c
> +$(OUTPUT)/lsm_set_self_attr_test: lsm_set_self_attr_test.c common.c
> +$(OUTPUT)/lsm_list_modules_test: lsm_list_modules_test.c common.c
> +
> +EXTRA_CLEAN = $(OUTPUT)/common.o
> diff --git a/tools/testing/selftests/lsm/common.c b/tools/testing/selftests/lsm/common.c
> new file mode 100644
> index 000000000000..db9af9375238
> --- /dev/null
> +++ b/tools/testing/selftests/lsm/common.c
> @@ -0,0 +1,81 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Linux Security Module infrastructure tests
> + *
> + * Copyright © 2023 Casey Schaufler <casey@schaufler-ca.com>
> + */
> +
> +#define _GNU_SOURCE
> +#include <linux/lsm.h>
> +#include <fcntl.h>
> +#include <string.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +#include <sys/types.h>
> +#include "common.h"
> +
> +#define PROCATTR	"/proc/self/attr/"
> +
> +int read_proc_attr(const char *attr, char *value, size_t size)
> +{
> +	int fd;
> +	int len;
> +	char *path;
> +
> +	len = strlen(PROCATTR) + strlen(attr) + 1;
> +	path = calloc(len, 1);
> +	if (path == NULL)
> +		return -1;
> +	sprintf(path, "%s%s", PROCATTR, attr);
> +
> +	fd = open(path, O_RDONLY);
> +	free(path);
> +
> +	if (fd < 0)

not closing fd here

> +		return -1;
> +	len = read(fd, value, size);
> +	if (len <= 0)
> +		return -1;
> +	close(fd);
> +

It would feel cozier if you would ensure a trailing \0 in
value before doing strchr.

> +	path = strchr(value, '\n');
> +	if (path)
> +		*path = '\0';
> +
> +	return 0;
> +}
> +
> +int read_sysfs_lsms(char *lsms, size_t size)
> +{
> +	FILE *fp;
> +
> +	fp = fopen("/sys/kernel/security/lsm", "r");
> +	if (fp == NULL)
> +		return -1;
> +	if (fread(lsms, 1, size, fp) <= 0)

not closing fp

> +		return -1;
> +	fclose(fp);
> +	return 0;
> +}
> +
> +int attr_lsm_count(void)
> +{
> +	char *names = calloc(sysconf(_SC_PAGESIZE), 1);
> +	int count = 0;
> +
> +	if (!names)
> +		return 0;
> +
> +	if (read_sysfs_lsms(names, sysconf(_SC_PAGESIZE)))
> +		return 0;
> +

Again strstr without ensuring \0.  /sys/kernel/security/lsm
is unlikely to be longer than _SC_PAGESIZE, but I *could*
mess with you with a bind mount...

> +	if (strstr(names, "selinux"))
> +		count++;
> +	if (strstr(names, "smack"))
> +		count++;
> +	if (strstr(names, "apparmor"))
> +		count++;
> +
> +	return count;
> +}
> diff --git a/tools/testing/selftests/lsm/common.h b/tools/testing/selftests/lsm/common.h
> new file mode 100644
> index 000000000000..cd0214a3eeb2
> --- /dev/null
> +++ b/tools/testing/selftests/lsm/common.h
> @@ -0,0 +1,33 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Linux Security Module infrastructure tests
> + *
> + * Copyright © 2023 Casey Schaufler <casey@schaufler-ca.com>
> + */
> +
> +#ifndef lsm_get_self_attr
> +static inline int lsm_get_self_attr(unsigned int attr, struct lsm_ctx *ctx,
> +				    size_t *size, __u32 flags)
> +{
> +	return syscall(__NR_lsm_get_self_attr, attr, ctx, size, flags);
> +}
> +#endif
> +
> +#ifndef lsm_set_self_attr
> +static inline int lsm_set_self_attr(unsigned int attr, struct lsm_ctx *ctx,
> +				    size_t size, __u32 flags)
> +{
> +	return syscall(__NR_lsm_set_self_attr, attr, ctx, size, flags);
> +}
> +#endif
> +
> +#ifndef lsm_list_modules
> +static inline int lsm_list_modules(__u64 *ids, size_t *size, __u32 flags)
> +{
> +	return syscall(__NR_lsm_list_modules, ids, size, flags);
> +}
> +#endif
> +
> +extern int read_proc_attr(const char *attr, char *value, size_t size);
> +extern int read_sysfs_lsms(char *lsms, size_t size);
> +int attr_lsm_count(void);
> diff --git a/tools/testing/selftests/lsm/config b/tools/testing/selftests/lsm/config
> new file mode 100644
> index 000000000000..1c0c4c020f9c
> --- /dev/null
> +++ b/tools/testing/selftests/lsm/config
> @@ -0,0 +1,3 @@
> +CONFIG_SYSFS=y
> +CONFIG_SECURITY=y
> +CONFIG_SECURITYFS=y
> diff --git a/tools/testing/selftests/lsm/lsm_get_self_attr_test.c b/tools/testing/selftests/lsm/lsm_get_self_attr_test.c
> new file mode 100644
> index 000000000000..74c65aae1fcc
> --- /dev/null
> +++ b/tools/testing/selftests/lsm/lsm_get_self_attr_test.c
> @@ -0,0 +1,240 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Linux Security Module infrastructure tests
> + * Tests for the lsm_get_self_attr system call
> + *
> + * Copyright © 2022 Casey Schaufler <casey@schaufler-ca.com>
> + */
> +
> +#define _GNU_SOURCE
> +#include <linux/lsm.h>
> +#include <fcntl.h>
> +#include <string.h>
> +#include <stdio.h>
> +#include <unistd.h>
> +#include <sys/types.h>
> +#include "../kselftest_harness.h"
> +#include "common.h"
> +
> +static struct lsm_ctx *next_ctx(struct lsm_ctx *ctxp)
> +{
> +	void *vp;
> +
> +	vp = (void *)ctxp + sizeof(*ctxp) + ctxp->ctx_len;
> +	return (struct lsm_ctx *)vp;
> +}
> +
> +TEST(size_null_lsm_get_self_attr)
> +{
> +	const long page_size = sysconf(_SC_PAGESIZE);
> +	struct lsm_ctx *ctx = calloc(page_size, 1);
> +
> +	ASSERT_NE(NULL, ctx);
> +	errno = 0;
> +	ASSERT_EQ(-1, lsm_get_self_attr(LSM_ATTR_CURRENT, ctx, NULL, 0));
> +	ASSERT_EQ(EINVAL, errno);
> +
> +	free(ctx);
> +}
> +
> +TEST(ctx_null_lsm_get_self_attr)
> +{
> +	const long page_size = sysconf(_SC_PAGESIZE);
> +	size_t size = page_size;
> +	int rc;
> +
> +	rc = lsm_get_self_attr(LSM_ATTR_CURRENT, NULL, &size, 0);
> +
> +	if (attr_lsm_count()) {
> +		ASSERT_NE(-1, rc);
> +		ASSERT_NE(1, size);
> +	} else {
> +		ASSERT_EQ(-1, rc);
> +	}
> +}
> +
> +TEST(size_too_small_lsm_get_self_attr)
> +{
> +	const long page_size = sysconf(_SC_PAGESIZE);
> +	struct lsm_ctx *ctx = calloc(page_size, 1);
> +	size_t size = 1;
> +
> +	ASSERT_NE(NULL, ctx);
> +	errno = 0;
> +	ASSERT_EQ(-1, lsm_get_self_attr(LSM_ATTR_CURRENT, ctx, &size, 0));
> +	if (attr_lsm_count()) {
> +		ASSERT_EQ(E2BIG, errno);
> +	} else {
> +		ASSERT_EQ(EOPNOTSUPP, errno);
> +	}
> +	ASSERT_NE(1, size);
> +
> +	free(ctx);
> +}
> +
> +TEST(flags_zero_lsm_get_self_attr)
> +{
> +	const long page_size = sysconf(_SC_PAGESIZE);
> +	struct lsm_ctx *ctx = calloc(page_size, 1);
> +	size_t size = page_size;
> +
> +	ASSERT_NE(NULL, ctx);
> +	errno = 0;
> +	ASSERT_EQ(-1, lsm_get_self_attr(LSM_ATTR_CURRENT, ctx, &size, 1));
> +	ASSERT_EQ(EINVAL, errno);
> +	ASSERT_EQ(page_size, size);
> +
> +	free(ctx);
> +}
> +
> +TEST(flags_overset_lsm_get_self_attr)
> +{
> +	const long page_size = sysconf(_SC_PAGESIZE);
> +	struct lsm_ctx *ctx = calloc(page_size, 1);
> +	size_t size = page_size;
> +
> +	ASSERT_NE(NULL, ctx);
> +	errno = 0;
> +	ASSERT_EQ(-1, lsm_get_self_attr(LSM_ATTR_CURRENT | LSM_ATTR_PREV, ctx,
> +					&size, 0));
> +	ASSERT_EQ(EOPNOTSUPP, errno);
> +
> +	free(ctx);
> +}
> +
> +TEST(basic_lsm_get_self_attr)
> +{
> +	const long page_size = sysconf(_SC_PAGESIZE);
> +	size_t size = page_size;
> +	struct lsm_ctx *ctx = calloc(page_size, 1);
> +	struct lsm_ctx *tctx = NULL;
> +	__u64 *syscall_lsms = calloc(page_size, 1);
> +	char *attr = calloc(page_size, 1);

You never verify attr is not NULL

> +	int cnt_current = 0;
> +	int cnt_exec = 0;
> +	int cnt_fscreate = 0;
> +	int cnt_keycreate = 0;
> +	int cnt_prev = 0;
> +	int cnt_sockcreate = 0;
> +	int lsmcount;
> +	int count;
> +	int i;
> +
> +	ASSERT_NE(NULL, ctx);
> +	ASSERT_NE(NULL, syscall_lsms);
> +
> +	lsmcount = syscall(__NR_lsm_list_modules, syscall_lsms, &size, 0);
> +	ASSERT_LE(1, lsmcount);
> +
> +	for (i = 0; i < lsmcount; i++) {
> +		switch (syscall_lsms[i]) {
> +		case LSM_ID_SELINUX:
> +			cnt_current++;
> +			cnt_exec++;
> +			cnt_fscreate++;
> +			cnt_keycreate++;
> +			cnt_prev++;
> +			cnt_sockcreate++;
> +			break;
> +		case LSM_ID_SMACK:
> +			cnt_current++;
> +			break;
> +		case LSM_ID_APPARMOR:
> +			cnt_current++;
> +			cnt_exec++;
> +			cnt_prev++;
> +			break;
> +		default:
> +			break;
> +		}
> +	}
> +
> +	if (cnt_current) {
> +		size = page_size;
> +		count = lsm_get_self_attr(LSM_ATTR_CURRENT, ctx, &size, 0);
> +		ASSERT_EQ(cnt_current, count);
> +		tctx = ctx;
> +		ASSERT_EQ(0, read_proc_attr("current", attr, page_size));
> +		ASSERT_EQ(0, strcmp((char *)tctx->ctx, attr));
> +		for (i = 1; i < count; i++) {
> +			tctx = next_ctx(tctx);
> +			ASSERT_NE(0, strcmp((char *)tctx->ctx, attr));
> +		}
> +	}
> +	if (cnt_exec) {
> +		size = page_size;
> +		count = lsm_get_self_attr(LSM_ATTR_EXEC, ctx, &size, 0);
> +		ASSERT_GE(cnt_exec, count);
> +		if (count > 0) {
> +			tctx = ctx;
> +			if (read_proc_attr("exec", attr, page_size) == 0)
> +				ASSERT_EQ(0, strcmp((char *)tctx->ctx, attr));
> +		}
> +		for (i = 1; i < count; i++) {
> +			tctx = next_ctx(tctx);
> +			ASSERT_NE(0, strcmp((char *)tctx->ctx, attr));
> +		}
> +	}
> +	if (cnt_fscreate) {
> +		size = page_size;
> +		count = lsm_get_self_attr(LSM_ATTR_FSCREATE, ctx, &size, 0);
> +		ASSERT_GE(cnt_fscreate, count);
> +		if (count > 0) {
> +			tctx = ctx;
> +			if (read_proc_attr("fscreate", attr, page_size) == 0)
> +				ASSERT_EQ(0, strcmp((char *)tctx->ctx, attr));
> +		}
> +		for (i = 1; i < count; i++) {
> +			tctx = next_ctx(tctx);
> +			ASSERT_NE(0, strcmp((char *)tctx->ctx, attr));
> +		}
> +	}
> +	if (cnt_keycreate) {
> +		size = page_size;
> +		count = lsm_get_self_attr(LSM_ATTR_KEYCREATE, ctx, &size, 0);
> +		ASSERT_GE(cnt_keycreate, count);
> +		if (count > 0) {
> +			tctx = ctx;
> +			if (read_proc_attr("keycreate", attr, page_size) == 0)
> +				ASSERT_EQ(0, strcmp((char *)tctx->ctx, attr));
> +		}
> +		for (i = 1; i < count; i++) {
> +			tctx = next_ctx(tctx);
> +			ASSERT_NE(0, strcmp((char *)tctx->ctx, attr));
> +		}
> +	}
> +	if (cnt_prev) {
> +		size = page_size;
> +		count = lsm_get_self_attr(LSM_ATTR_PREV, ctx, &size, 0);
> +		ASSERT_GE(cnt_prev, count);
> +		if (count > 0) {
> +			tctx = ctx;
> +			ASSERT_EQ(0, read_proc_attr("prev", attr, page_size));
> +			ASSERT_EQ(0, strcmp((char *)tctx->ctx, attr));
> +			for (i = 1; i < count; i++) {
> +				tctx = next_ctx(tctx);
> +				ASSERT_NE(0, strcmp((char *)tctx->ctx, attr));
> +			}
> +		}
> +	}
> +	if (cnt_sockcreate) {
> +		size = page_size;
> +		count = lsm_get_self_attr(LSM_ATTR_SOCKCREATE, ctx, &size, 0);
> +		ASSERT_GE(cnt_sockcreate, count);
> +		if (count > 0) {
> +			tctx = ctx;
> +			if (read_proc_attr("sockcreate", attr, page_size) == 0)
> +				ASSERT_EQ(0, strcmp((char *)tctx->ctx, attr));
> +		}
> +		for (i = 1; i < count; i++) {
> +			tctx = next_ctx(tctx);
> +			ASSERT_NE(0, strcmp((char *)tctx->ctx, attr));
> +		}
> +	}
> +
> +	free(ctx);
> +	free(attr);
> +	free(syscall_lsms);
> +}
> +
> +TEST_HARNESS_MAIN
> diff --git a/tools/testing/selftests/lsm/lsm_list_modules_test.c b/tools/testing/selftests/lsm/lsm_list_modules_test.c
> new file mode 100644
> index 000000000000..445c02f09c74
> --- /dev/null
> +++ b/tools/testing/selftests/lsm/lsm_list_modules_test.c
> @@ -0,0 +1,140 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Linux Security Module infrastructure tests
> + * Tests for the lsm_list_modules system call
> + *
> + * Copyright © 2022 Casey Schaufler <casey@schaufler-ca.com>
> + */
> +
> +#define _GNU_SOURCE
> +#include <linux/lsm.h>
> +#include <string.h>
> +#include <stdio.h>
> +#include <unistd.h>
> +#include <sys/types.h>
> +#include "../kselftest_harness.h"
> +#include "common.h"
> +
> +TEST(size_null_lsm_list_modules)
> +{
> +	const long page_size = sysconf(_SC_PAGESIZE);
> +	__u64 *syscall_lsms = calloc(page_size, 1);
> +
> +	ASSERT_NE(NULL, syscall_lsms);
> +	errno = 0;
> +	ASSERT_EQ(-1, lsm_list_modules(syscall_lsms, NULL, 0));
> +	ASSERT_EQ(EFAULT, errno);
> +
> +	free(syscall_lsms);
> +}
> +
> +TEST(ids_null_lsm_list_modules)
> +{
> +	const long page_size = sysconf(_SC_PAGESIZE);
> +	size_t size = page_size;
> +
> +	errno = 0;
> +	ASSERT_EQ(-1, lsm_list_modules(NULL, &size, 0));
> +	ASSERT_EQ(EFAULT, errno);
> +	ASSERT_NE(1, size);
> +}
> +
> +TEST(size_too_small_lsm_list_modules)
> +{
> +	const long page_size = sysconf(_SC_PAGESIZE);
> +	__u64 *syscall_lsms = calloc(page_size, 1);
> +	size_t size = 1;
> +
> +	ASSERT_NE(NULL, syscall_lsms);
> +	errno = 0;
> +	ASSERT_EQ(-1, lsm_list_modules(syscall_lsms, &size, 0));
> +	ASSERT_EQ(E2BIG, errno);
> +	ASSERT_NE(1, size);
> +
> +	free(syscall_lsms);
> +}
> +
> +TEST(flags_set_lsm_list_modules)
> +{
> +	const long page_size = sysconf(_SC_PAGESIZE);
> +	__u64 *syscall_lsms = calloc(page_size, 1);
> +	size_t size = page_size;
> +
> +	ASSERT_NE(NULL, syscall_lsms);
> +	errno = 0;
> +	ASSERT_EQ(-1, lsm_list_modules(syscall_lsms, &size, 7));
> +	ASSERT_EQ(EINVAL, errno);
> +	ASSERT_EQ(page_size, size);
> +
> +	free(syscall_lsms);
> +}
> +
> +TEST(correct_lsm_list_modules)
> +{
> +	const long page_size = sysconf(_SC_PAGESIZE);
> +	size_t size = page_size;
> +	__u64 *syscall_lsms = calloc(page_size, 1);
> +	char *sysfs_lsms = calloc(page_size, 1);
> +	char *name;
> +	char *cp;
> +	int count;
> +	int i;
> +
> +	ASSERT_NE(NULL, sysfs_lsms);
> +	ASSERT_NE(NULL, syscall_lsms);
> +	ASSERT_EQ(0, read_sysfs_lsms(sysfs_lsms, page_size));
> +
> +	count = lsm_list_modules(syscall_lsms, &size, 0);
> +	ASSERT_LE(1, count);
> +	cp = sysfs_lsms;
> +	for (i = 0; i < count; i++) {
> +		switch (syscall_lsms[i]) {
> +		case LSM_ID_CAPABILITY:
> +			name = "capability";
> +			break;
> +		case LSM_ID_SELINUX:
> +			name = "selinux";
> +			break;
> +		case LSM_ID_SMACK:
> +			name = "smack";
> +			break;
> +		case LSM_ID_TOMOYO:
> +			name = "tomoyo";
> +			break;
> +		case LSM_ID_IMA:
> +			name = "ima";
> +			break;
> +		case LSM_ID_APPARMOR:
> +			name = "apparmor";
> +			break;
> +		case LSM_ID_YAMA:
> +			name = "yama";
> +			break;
> +		case LSM_ID_LOADPIN:
> +			name = "loadpin";
> +			break;
> +		case LSM_ID_SAFESETID:
> +			name = "safesetid";
> +			break;
> +		case LSM_ID_LOCKDOWN:
> +			name = "lockdown";
> +			break;
> +		case LSM_ID_BPF:
> +			name = "bpf";
> +			break;
> +		case LSM_ID_LANDLOCK:
> +			name = "landlock";
> +			break;
> +		default:
> +			name = "INVALID";
> +			break;
> +		}
> +		ASSERT_EQ(0, strncmp(cp, name, strlen(name)));
> +		cp += strlen(name) + 1;
> +	}
> +
> +	free(sysfs_lsms);
> +	free(syscall_lsms);
> +}
> +
> +TEST_HARNESS_MAIN
> diff --git a/tools/testing/selftests/lsm/lsm_set_self_attr_test.c b/tools/testing/selftests/lsm/lsm_set_self_attr_test.c
> new file mode 100644
> index 000000000000..d0f5b776c548
> --- /dev/null
> +++ b/tools/testing/selftests/lsm/lsm_set_self_attr_test.c
> @@ -0,0 +1,74 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Linux Security Module infrastructure tests
> + * Tests for the lsm_set_self_attr system call
> + *
> + * Copyright © 2022 Casey Schaufler <casey@schaufler-ca.com>
> + */
> +
> +#define _GNU_SOURCE
> +#include <linux/lsm.h>
> +#include <string.h>
> +#include <stdio.h>
> +#include <unistd.h>
> +#include <sys/types.h>
> +#include "../kselftest_harness.h"
> +#include "common.h"
> +
> +TEST(ctx_null_lsm_set_self_attr)
> +{
> +	ASSERT_EQ(-1, lsm_set_self_attr(LSM_ATTR_CURRENT, NULL,
> +					sizeof(struct lsm_ctx), 0));
> +}
> +
> +TEST(size_too_small_lsm_set_self_attr)
> +{
> +	const long page_size = sysconf(_SC_PAGESIZE);
> +	struct lsm_ctx *ctx = calloc(page_size, 1);
> +	size_t size = page_size;
> +
> +	ASSERT_NE(NULL, ctx);
> +	if (attr_lsm_count()) {
> +		ASSERT_LE(1, lsm_get_self_attr(LSM_ATTR_CURRENT, ctx, &size,
> +			  0));
> +	}
> +	ASSERT_EQ(-1, lsm_set_self_attr(LSM_ATTR_CURRENT, ctx, 1, 0));
> +
> +	free(ctx);
> +}
> +
> +TEST(flags_zero_lsm_set_self_attr)
> +{
> +	const long page_size = sysconf(_SC_PAGESIZE);
> +	struct lsm_ctx *ctx = calloc(page_size, 1);
> +	size_t size = page_size;
> +
> +	ASSERT_NE(NULL, ctx);
> +	if (attr_lsm_count()) {
> +		ASSERT_LE(1, lsm_get_self_attr(LSM_ATTR_CURRENT, ctx, &size,
> +			  0));
> +	}
> +	ASSERT_EQ(-1, lsm_set_self_attr(LSM_ATTR_CURRENT, ctx, size, 1));
> +
> +	free(ctx);
> +}
> +
> +TEST(flags_overset_lsm_set_self_attr)
> +{
> +	const long page_size = sysconf(_SC_PAGESIZE);
> +	char *ctx = calloc(page_size, 1);
> +	size_t size = page_size;
> +	struct lsm_ctx *tctx = (struct lsm_ctx *)ctx;
> +
> +	ASSERT_NE(NULL, ctx);
> +	if (attr_lsm_count()) {
> +		ASSERT_LE(1, lsm_get_self_attr(LSM_ATTR_CURRENT, tctx, &size,
> +			  0));
> +	}
> +	ASSERT_EQ(-1, lsm_set_self_attr(LSM_ATTR_CURRENT | LSM_ATTR_PREV, tctx,
> +					size, 0));
> +
> +	free(ctx);
> +}
> +
> +TEST_HARNESS_MAIN
> -- 
> 2.41.0
> 
> 
