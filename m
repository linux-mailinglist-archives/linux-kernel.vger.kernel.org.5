Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 069DE7B5FB9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 06:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238022AbjJCERL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 00:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbjJCERH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 00:17:07 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC72C6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 21:17:01 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d81486a0382so772501276.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 21:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696306621; x=1696911421; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9kMAxl7wnzbYfSitqyqtdz7yD/9Z7wPKR2cHV1SDeLQ=;
        b=m8vxQ8rV0UaHl6IF+fnDSbaw0v9JpXzQdk5grGUeYImsBr/oUjQ1+jOcs0VMcw3Isg
         veN5haPpKgjswFEvNXzDipwNXxWJxy3cleyNxWEjXx6842zrrxpz1fnS3GUfz+0YoK7f
         rlKrWhYeSHrxGEHOAwTibaGQggqrgQP1xQbcmc3rkRxOWzUHrTcuEWL9O7+yTV0rKXrS
         5/ZJKOxDeom2C31YCyrj4BFCjMr54HYMlRJ7p1uB1u2cuo+MyyxbKsSh5DilykEtupul
         E9O3AUCE3fHe2mr4Bbrl5vCXMjqolJVgaLTKE6pKWx/h5ybD5gly7mUOK8Fj8CIwsAZC
         1gVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696306621; x=1696911421;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9kMAxl7wnzbYfSitqyqtdz7yD/9Z7wPKR2cHV1SDeLQ=;
        b=iQoVlg7wKJqfX3RpVJX1L5wYHyM6PgzzHT5mJx2JbT7a2phZZY4Q1d/Aq57p1cY/9u
         ofBfHuMjCUUq3/BaRZ9xhN98eFp0BAdBQV9BwZtJBaK7Nd6wqKc/dE8h8SxE/FKj0aIA
         6dWJvFPd2Mj4tRVGi94uuBiZLMCouEEfasRSjXBDy5qqeVMXr8CgmiBVTcL2QcCCt5jw
         cbki8Y1v+VUXxL2S352//imkzvCYKj1nWo+CY3q0UxBkaj3+sFHHMexADD/SMLT733Kd
         2F9j5nu65olMiqZkKBK6Qk2UjaZI8a9Yq0thIc0JOMEUrV0WhEmfUCi+82oFYvV4iFtP
         dnBA==
X-Gm-Message-State: AOJu0YzQwzSR2GhifVtBLllBVAJh6FoneFb6l+D6mjPqVbIJGsZuTI+5
        7sVSdOkEHM4HfAJ6OhC7POaC6sAsK3np
X-Google-Smtp-Source: AGHT+IFTh73WutQg1HKHRN6gvVmsnoyBnUIIdRWVnhGRA/0U2dv77uh8riZh7TSwPg5ujv/BPkrdVQMikN4x
X-Received: from coldfire.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2b7a])
 (user=maheshb job=sendgmr) by 2002:a5b:882:0:b0:d7f:f3e:74ab with SMTP id
 e2-20020a5b0882000000b00d7f0f3e74abmr214972ybq.1.1696306621178; Mon, 02 Oct
 2023 21:17:01 -0700 (PDT)
Date:   Mon,  2 Oct 2023 21:16:57 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
Message-ID: <20231003041657.1745487-1-maheshb@google.com>
Subject: [PATCHv2 next 0/3] add ptp_gettimex64any() API
From:   Mahesh Bandewar <maheshb@google.com>
To:     Netdev <netdev@vger.kernel.org>,
        Linux <linux-kernel@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, John Stultz <jstultz@google.com>,
        Don Hatchett <hatch@google.com>,
        Yuliang Li <yuliangli@google.com>,
        Mahesh Bandewar <mahesh@bandewar.net>,
        Mahesh Bandewar <maheshb@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current API to get the sandwich TS for the master-PTP clock read
supports only the sys-time sandwich. This is not really suitable for
all the use cases of sandwich TS needs. Ideally it should
allow a choice of a timebase to use for ts-sandwich need. Updating
the existing API [gettimex64()] is not an option since it would
break compatibility.

About the name - This is a superset of current gettimex64. Since 
the timebase for gettimex64 is fixed and is only 'sys-time / real-time'. 
I'm appending "any" to add the choice factor. so gettimex64any() would
give you eXtended time with sandwitch TS of a timebase of your choice.
If there is a better name, I won't mind changing.

The timebase options are -
   CLOCK_REALTIME, CLOCK_MONOTONIC, & CLOCK_MONOTONIC_RAW

The CLOCK_REALTIME option is equivalent of using current gettimex64()
method.

The first patch adds this new PTP method while the second patch
adds the ioctl support for this method.

The last patch in the series updates the selftest to exercise this
new method.

Mahesh Bandewar (3):
  ptp: add ptp_gettimex64any() support
  ptp: add ioctl interface for ptp_gettimex64any()
  selftes/ptp: extend test to include ptp_gettimex64any()

 drivers/ptp/ptp_chardev.c             | 34 ++++++++++++
 include/linux/ptp_clock_kernel.h      | 51 ++++++++++++++++++
 include/uapi/linux/ptp_clock.h        | 21 ++++++++
 tools/testing/selftests/Makefile      |  1 +
 tools/testing/selftests/ptp/testptp.c | 76 ++++++++++++++++++++++++++-
 5 files changed, 181 insertions(+), 2 deletions(-)

v1 -> v2
  * Removed ktime_get_cycles64() implementation
  * Removed CYCLES as an option
-- 
2.42.0.582.g8ccd20d70d-goog

