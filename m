Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 378B9785E86
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 19:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237807AbjHWR1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 13:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233074AbjHWR1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 13:27:32 -0400
Received: from smtp-190b.mail.infomaniak.ch (smtp-190b.mail.infomaniak.ch [IPv6:2001:1600:3:17::190b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11BCCE6A
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 10:27:31 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4RWCp6446kzMq6M1;
        Wed, 23 Aug 2023 17:27:26 +0000 (UTC)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4RWCp50WRKz3X;
        Wed, 23 Aug 2023 19:27:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1692811646;
        bh=dkvxW7AWHKnBaIGfgaNdqXPMIYBWr7XnIRLwQ1vra2M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F3dcaOmF1IAkSAzWsBED07OLpGDNIQx8JRLoQ//DbumeZykZBaQH6WOeUI/Ijkx+1
         N8G/6UwbaO3yIR20QHuP8g3KKlIQYaE4zotoom3acxxie+5psNEPDlj/v8Dz9s+1gW
         nb/sgdGFTKsZLq3bgQg6KuflO/oV7kQAtucarqvA=
Date:   Wed, 23 Aug 2023 19:27:23 +0200
From:   =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     paul@paul-moore.com, linux-security-module@vger.kernel.org,
        jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH v13 11/11] LSM: selftests for Linux Security Module
 syscalls
Message-ID: <20230823.aequ5ahg0Aeb@digikod.net>
References: <20230802174435.11928-1-casey@schaufler-ca.com>
 <20230802174435.11928-12-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802174435.11928-12-casey@schaufler-ca.com>
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
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

You could use the wildcard approach to avoid explicitly listing output
files here, but it's not a big deal.

> +
> +include ../lib.mk
> +
> +$(TEST_GEN_PROGS):
> +
> +$(OUTPUT)/lsm_get_self_attr_test: lsm_get_self_attr_test.c common.c
> +$(OUTPUT)/lsm_set_self_attr_test: lsm_set_self_attr_test.c common.c
> +$(OUTPUT)/lsm_list_modules_test: lsm_list_modules_test.c common.c

It would be nice to add /*_test to a .gitignore file

> +
> +EXTRA_CLEAN = $(OUTPUT)/common.o

Anyway, this Makefile works with all kind of test builds (cf. commit
a52540522c9541bfa3e499d2edba7bc0ca73a4ca).

I'll send another review for this file soon.
