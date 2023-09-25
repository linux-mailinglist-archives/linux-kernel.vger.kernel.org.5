Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3E157AD8CB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 15:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbjIYNSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 09:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbjIYNSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 09:18:03 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F49A2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 06:17:56 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-503012f4e71so9254728e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 06:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695647874; x=1696252674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7auSkgezWSL6mQoHeXRixUmeJiJBcJSiSQX0s+bC+Hg=;
        b=xueCLe+A0tVPe8iQ5lGUtoyuyK8ZJTWH566c0cnvMlEHWS5l6BKCCBV3LGcmaluj+k
         hxk919XMzNi9uwetRyVCnpCkbaCmoqenIck2naKgi/3WkaHjb5RseUAm58+taVvXed5v
         DowfNvF0cvUDv99XOTBoIPf1CwRQWllYtmTVNI374kNm0WJheKwDljKcd/ufeJ7xBr+8
         BxiKeurnsInolZ6jpuCRAUZOaaTbThdUNDNL3TvrbA+Upe2fz+3m1Qtp5MyGMEzLJaWi
         6+GvV7XshZQhRWaODrFIXCKAVIHwUjgJdxZ1xmeixkOI+HYev4LLUSgD4ootsVb3VMLG
         qOBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695647874; x=1696252674;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7auSkgezWSL6mQoHeXRixUmeJiJBcJSiSQX0s+bC+Hg=;
        b=IHGpzHRuUpJxY26af/lYqrp1mTTmkWsDgeAhBrSUGpv0cDjTrZKWcB2hd04uF5uKjy
         2YNtqp2Dbe5Lpri1EC3iLLyVG+k80H2VUDpUOnWEjC/byJVsLtKOFLRMYe8ZJSzllDq2
         NItwC0HowKaBcyQkKOsqAl7tW79XfYss2ajlaa3g+wtu5O1GHz9lKsvc3b87zJEqeHwa
         eUvTd3pSCdaKIrf4TUFryn0lIg5V6WyA57CQHFPLlKYSJ8KzSE8uUCWBWNvHVKuDu49g
         God1AetfHZKLkXCRBYbzdkFShylHjwREar58X9TVALltSfSCNUjA9QzH5QYSbp5LKxLh
         DPcg==
X-Gm-Message-State: AOJu0Yyp+O7YCvNE/qxUuvWpfG9Jsmzql7RB1d6pkaNAYCB4Smldo4vf
        cSjmK+6umwgGU3/dtFhsW6GosxOsmGBGwCPqBk8=
X-Google-Smtp-Source: AGHT+IEXoUei5lKEdPsc7LZJvh36BS9Wc/8t36M9yrgUxODOFj9Q1mO85xDzs/ts7iRE7KQ08A6DmQ==
X-Received: by 2002:a05:6512:239d:b0:500:a93d:fc78 with SMTP id c29-20020a056512239d00b00500a93dfc78mr2876540lfv.31.1695647874370;
        Mon, 25 Sep 2023 06:17:54 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id m29-20020a056512015d00b004fe10276bbfsm1823583lfo.296.2023.09.25.06.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 06:17:53 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Viresh Kumar <vireshk@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Nikunj Kela <nkela@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/9] PM: domains/opp/arm_scmi: Extend performance scaling support
Date:   Mon, 25 Sep 2023 15:17:06 +0200
Message-Id: <20230925131715.138411-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Consumer drivers for devices that are attached to the SCMI performance domain,
are currently not able to use the OPP library to scale performance. This series
is enabling the support for this.

The OPPs for SCMI performance domain are encoded in the FW, rather than being
described through DT. To better support this, some changes have also been done
to the OPP library and for PM domains in general. More details are available in
the commit messages.

I have based the series on the scmi tree and the for-next/scmi/updates branch,
so the OPP and PM domain changes would require acks from Viresh and Rafael to
be allow to be picked up and funneled through the scmi tree. Or, let's just
discuss what works best for us in this regards.

Note that, I am running this on the Qemu virt platform with Optee running an
SCMI server. If you want some more details about my test setup, I can certainly
share this with you, just let me know.

Looking forward to your feedback!

Kind regards
Ulf Hansson


Ulf Hansson (9):
  PM: domains: Introduce dev_pm_domain_set_performance_state()
  PM: domains: Implement the ->set_performance_state() callback for
    genpd
  OPP: Add dev_pm_opp_add_dynamic() to allow more flexibility
  OPP: Extend dev_pm_opp_data with a level
  OPP: Switch to use dev_pm_domain_set_performance_state()
  OPP: Extend support for the opp-level beyond required-opps
  firmware: arm_scmi: Simplify error path in scmi_dvfs_device_opps_add()
  firmware: arm_scmi: Specify the performance level when adding an OPP
  firmware: arm_scmi: Add generic OPP support to the SCMI performance
    domain

 drivers/base/power/common.c             | 21 ++++++++++
 drivers/base/power/domain.c             | 33 +++++++++------
 drivers/firmware/arm_scmi/perf.c        | 22 +++++-----
 drivers/opp/core.c                      | 54 +++++++++++++++++++------
 drivers/opp/of.c                        | 10 +++--
 drivers/opp/opp.h                       |  2 +-
 drivers/pmdomain/arm/scmi_perf_domain.c | 34 ++++++++++++++++
 include/linux/pm.h                      |  2 +
 include/linux/pm_domain.h               |  6 +++
 include/linux/pm_opp.h                  | 31 ++++++++++++--
 10 files changed, 168 insertions(+), 47 deletions(-)

-- 
2.34.1

