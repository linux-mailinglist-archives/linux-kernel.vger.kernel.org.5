Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEF247A4611
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 11:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240966AbjIRJfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 05:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240952AbjIRJe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 05:34:56 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB55D1B4;
        Mon, 18 Sep 2023 02:34:18 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-271d9823cacso3418013a91.1;
        Mon, 18 Sep 2023 02:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695029658; x=1695634458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qUvK28FHha6/TPODXDcAyXI9rCsyy10y0ZpeI61dT8s=;
        b=eGtCMOSpfPkyeRHfJzpg4sLFF+oZUU8w53DeGPPEZ4VLQh4poFlZ1aVnB32RfEMDxs
         Qc67skvILAxKF0LzU6txT1UxueP4BhUsPqppWpeoqc08civQvhcoDEzG7SQOjcfGJRGc
         OcaDMpLL0CMzSlFybPfzhpJfgwSL5HHlvyAJ4pf1rUxwLGK/zJAvBe9705KPzskPjXaa
         p3dt5ZgTfZL44CjOCUK5eF86rA8py3Z5WpNg+MT+fK9iR62HfKSwPFGlKJOESW+EeME0
         empDB1wtyXY55Hx6JRhHWx8Q7Ab2bTO1CP6nmaC9pEChssOxjPCcnVEsmPUAV0HSpQLW
         H13Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695029658; x=1695634458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qUvK28FHha6/TPODXDcAyXI9rCsyy10y0ZpeI61dT8s=;
        b=a+9cU/+bgWGIKitKnIJJWCYgvN8alelD+GpRjdXSqWPhSfQuDFv/FDYcxndd3IcOrx
         zVRWvyuFGyRGJQ5xcfkwr2jnvvI4b/3s0Cui3T8BqibnZea0OtGCLq/RaYjyUp6JQsG7
         bHRmVIG0LtP4qQFSGB3lhepen0f87CGF3WXlZFMCUVL4dOgXuYPYuCJG5D9YJhlcABmW
         CRV3r5tW4Um1GK0P8EptSQyDDEi0A/F59OC0eJKdkXOGDHTvYSSAL5pRsY21nSf/PjLD
         on0cMe4xyblxJTiJBUvFXyzPFmJ/detiQ+clxys8DJb5IcKTF8DQWL8xR9Gdq9YhOE7p
         CbPw==
X-Gm-Message-State: AOJu0YyonJafmbY5OObawZcHbbqBna1yNkJF6Q3pmgCCsZZrN7zC12aX
        wi6ECnVUBNF8PLrsQwmwXEE=
X-Google-Smtp-Source: AGHT+IGaQ5dMQ1cGSOMTB7KffVIsHovJUmmpxN/gzT3BqwESNFk0PNQLWHK/I1LnAZ5uWtNZ0Di/cg==
X-Received: by 2002:a17:90b:890:b0:274:7de7:d6fa with SMTP id bj16-20020a17090b089000b002747de7d6famr7586704pjb.9.1695029658328;
        Mon, 18 Sep 2023 02:34:18 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id 30-20020a17090a19de00b002694fee879csm9353848pjj.36.2023.09.18.02.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 02:34:18 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Vadim Fedorenko <vadim.fedorenko@linux.dev>,
        Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Networking <netdev@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        kernel test robot <lkp@intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH 1/2] Documentation: dpll: Fix code blocks
Date:   Mon, 18 Sep 2023 16:32:38 +0700
Message-Id: <20230918093240.29824-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230918093240.29824-1-bagasdotme@gmail.com>
References: <20230918093240.29824-1-bagasdotme@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2283; i=bagasdotme@gmail.com; h=from:subject; bh=iX8SWoRLzVX69nnlgwYeyuY20ly0EeLShmwQMvrkdc8=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDKkcksY+a1U3HEkp4JieKLw7v8RoTXjkzHmp5UwTJ/9ua 2kQefC8o5SFQYyLQVZMkWVSIl/T6V1GIhfa1zrCzGFlAhnCwMUpABPRlWX478Lk2sslm8q0XdFy gtTNnRP7r83p93q8Lym3gmXH6ksCMxkZrp7ODHzPlpSht2dHZ3pF8qtcQ6/I8Edy6zcdM/oW+ZO fDQA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel test robot and Stephen Rothwell report htmldocs warnings:

Documentation/driver-api/dpll.rst:427: WARNING: Error in "code-block" directive:
maximum 1 argument(s) allowed, 18 supplied.

.. code-block:: c
	<snipped>...
Documentation/driver-api/dpll.rst:444: WARNING: Error in "code-block" directive:
maximum 1 argument(s) allowed, 21 supplied.

.. code-block:: c
	<snipped>...
Documentation/driver-api/dpll.rst:474: WARNING: Error in "code-block" directive:
maximum 1 argument(s) allowed, 12 supplied.

.. code-block:: c
	<snipped>...

Fix these above by adding missing blank line separator after code-block
directive.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202309180456.lOhxy9gS-lkp@intel.com/
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/linux-next/20230918131521.155e9e63@canb.auug.org.au/
Fixes: dbb291f19393b6 ("dpll: documentation on DPLL subsystem interface")
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/driver-api/dpll.rst | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/driver-api/dpll.rst b/Documentation/driver-api/dpll.rst
index bb52f1b8c0be31..01eb4de867036f 100644
--- a/Documentation/driver-api/dpll.rst
+++ b/Documentation/driver-api/dpll.rst
@@ -425,6 +425,7 @@ The simplest implementation is in the OCP TimeCard driver. The ops
 structures are defined like this:
 
 .. code-block:: c
+
 	static const struct dpll_device_ops dpll_ops = {
 		.lock_status_get = ptp_ocp_dpll_lock_status_get,
 		.mode_get = ptp_ocp_dpll_mode_get,
@@ -442,6 +443,7 @@ structures are defined like this:
 The registration part is then looks like this part:
 
 .. code-block:: c
+
         clkid = pci_get_dsn(pdev);
         bp->dpll = dpll_device_get(clkid, 0, THIS_MODULE);
         if (IS_ERR(bp->dpll)) {
@@ -472,6 +474,7 @@ The registration part is then looks like this part:
 In the error path we have to rewind every allocation in the reverse order:
 
 .. code-block:: c
+
         while (i) {
                 --i;
                 dpll_pin_unregister(bp->dpll, bp->sma[i].dpll_pin, &dpll_pins_ops, &bp->sma[i]);
-- 
An old man doll... just what I always wanted! - Clara

