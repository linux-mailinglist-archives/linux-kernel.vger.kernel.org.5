Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF0F7AFA68
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 07:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjI0Fxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 01:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbjI0Fwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 01:52:53 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54485199
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 22:52:16 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d84acda47aeso17821783276.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 22:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695793935; x=1696398735; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PdEyDvEQWoBI92qpF/Uzb1GUaex9NeolFXPHe23E1k8=;
        b=RzSvcCoZN1JIWrqdM8SYFc/lG7oJ3rZn/MloLV8r/A1Bltyj2o7Kg9r9zusYwajApS
         GHNqHKIzV+VDBd0d/kLqzwK8kJMeWc7jJohq9aaq9vX8yQDxJWIqnR2TcHZ9ox0X42/9
         NkgFnitQWnJGaikxL2+WsX+PXSgoOf+DbcgUDwL+A/AU4Vd3LJ31LU1b+ajMd98UrjBG
         23ITdrNScc2RqBiZB9HC48wVh7nOzisfuWAk9/SPnsbv0Ncl+YBep/uPokNL33cSTeOg
         oFJuNC4JfH7UEmLfDURfzT82WSWJPCcrpe5DykpT58kwrQRCaJYF5rs9Qnwx6hmVfclQ
         Nt9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695793935; x=1696398735;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PdEyDvEQWoBI92qpF/Uzb1GUaex9NeolFXPHe23E1k8=;
        b=wQYM7XODDlDGZVUKSKF+mYj5Hhdk2xxYWat3j7bE5Ghuba1uADZG/BuAtzBlDUePRR
         ELuzkJesM8YNRbIjUQjn9DkAkRNcPTu+rOD3gB0wJ6gMkvgZMllMicaluWsNYpgEtP9c
         qwZcc/EBJMqIzVrpOgNFOj8JS6TLOjLqiGHw0h1ozw5YmodSJWCSPRcJXC45EGFLHues
         EvcPw+JBb8owE2scEkePcI+a8ViKXmyF4u2TWKwdw3P/MHPTw38Ik5x46XQYwNKGVG7m
         Z2uFDHM4xwVddw10d6S82lQs+IZm1sHEpzljjlb00s+KQPPr02pBsCR1U35xfecQvCxt
         lAIw==
X-Gm-Message-State: AOJu0Yz72Aiw9qxEYedV88Bwe6bxd4HM1VtMF/vMnr3OEzkjrhFFP6J9
        q536/zOgAxHwZnOk5RvJM43gjGDWicpIqd3LZQ==
X-Google-Smtp-Source: AGHT+IEaS5LFX+8+6L9Q61zarfCqUXo3huTncRIZR8kYZ9xqH7nQBhWg2JgKaj+jTH+e0xqrs03slPUJ1I5966n0MQ==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:cc57:0:b0:d4d:8ade:4dfa with SMTP
 id l84-20020a25cc57000000b00d4d8ade4dfamr11730ybf.1.1695793935601; Tue, 26
 Sep 2023 22:52:15 -0700 (PDT)
Date:   Wed, 27 Sep 2023 05:52:14 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAA3DE2UC/x3MwQqDMAwA0F+RnBfQtk7crwwPLkaXQztJpDjEf
 7d4fJd3gLEKG7yqA5SzmPxSQfOogL5jWhhlKgZXO1/3rkPbNNH6x0klsxpGMUL5xBwJCVsffOi 75jmPAcqxKs+y3/97OM8L8ryHqG8AAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695793934; l=1586;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=wWwjcICs9gtgVAVLbVDl2AzKRTJfFBmL/hPhS0rX2sU=; b=H91kmNzP7h9iUJihNntBjcaYva+p8s04nGgbyn8MlVRybrFRnzz2WT4H/o661VS+FNDHi3FnW
 uYdMPF/jBmNBYE0aW5zXwz90P8UWU4tGEdGpR3XL4ospVokhUoyAQg2
X-Mailer: b4 0.12.3
Message-ID: <20230927-strncpy-drivers-misc-ibmvmc-c-v1-1-29f56cd3a269@google.com>
Subject: [PATCH] ibmvmc: replace deprecated strncpy with strscpy
From:   Justin Stitt <justinstitt@google.com>
To:     Brad Warrum <bwarrum@linux.ibm.com>,
        Ritu Agarwal <rituagar@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`strncpy` is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

A suitable replacement is `strscpy` [2] due to the fact that it
guarantees NUL-termination on the destination buffer without
unnecessarily NUL-padding.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.
---
 drivers/misc/ibmvmc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/misc/ibmvmc.c b/drivers/misc/ibmvmc.c
index 2101eb12bcba..6d9ed9325f9f 100644
--- a/drivers/misc/ibmvmc.c
+++ b/drivers/misc/ibmvmc.c
@@ -1249,9 +1249,7 @@ static long ibmvmc_ioctl_sethmcid(struct ibmvmc_file_session *session,
 		return -EIO;
 	}
 
-	/* Make sure buffer is NULL terminated before trying to print it */
-	memset(print_buffer, 0, HMC_ID_LEN + 1);
-	strncpy(print_buffer, hmc->hmc_id, HMC_ID_LEN);
+	strscpy(print_buffer, hmc->hmc_id, sizeof(print_buffer));
 	pr_info("ibmvmc: sethmcid: Set HMC ID: \"%s\"\n", print_buffer);
 
 	memcpy(buffer->real_addr_local, hmc->hmc_id, HMC_ID_LEN);

---
base-commit: 6465e260f48790807eef06b583b38ca9789b6072
change-id: 20230927-strncpy-drivers-misc-ibmvmc-c-534349716fa4

Best regards,
--
Justin Stitt <justinstitt@google.com>

