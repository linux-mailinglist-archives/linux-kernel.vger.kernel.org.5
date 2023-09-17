Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0347A3DDC
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 23:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234088AbjIQV3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 17:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231883AbjIQV3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 17:29:19 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 890BD12F
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 14:29:13 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1c1ff5b741cso36538765ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 14:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google; t=1694986153; x=1695590953; darn=vger.kernel.org;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sVQbPyFdM4luF2DrdTikPfdxX3rv9lXgDVF92WzKQBA=;
        b=M/jizT2mrDYD8Eb526wI5dfx4sb/d+cj11kY7Gvt8Y8p247CdoG8Mp8WoI9YL3n/6q
         pYAHEtSuNRl69cyPwnPgqHEcOll+bKLsVm6S8Y783hVXx/ZUsw8REcnbQpoZ01TO6ozd
         lco0zxbnAuNYp4+w+hJ3M9xrGxB5Z2CTfyxuQJoZRhvrcj4KjPibJuRixkfs4mf+oVj3
         R4Noyq9hPVWTW4lor+ljAIbo+mfFB0XJYMc3FrzesOlWQIM7OlDObZ/Yz6MEuQNchemh
         bN9BB7PwmKSVSlVZVaxbaYeGWSdqnAeQXuUNiSVPHANUP4SROWy7gcKAUtmqB01lWM31
         yHdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694986153; x=1695590953;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sVQbPyFdM4luF2DrdTikPfdxX3rv9lXgDVF92WzKQBA=;
        b=NPyDso0hQl8GqGeCUunWQ9un/yuiWM0Kj1x2Jkbw3mCd/YLXPWfXqqbTVGHoVn9sp3
         YdW1o8s9LVoNfSFyIRodZNMWqSUvhKvV+kpTcVm5BFXGY7r8mPmlYiYdCtXdgten/LF7
         qAoq1wMbwfMdsiARmpNHyMwibxljBY0BgDTz1PcQDDckKqCYjnMeWS0VHElRLTx0jAmO
         xFtIeJAqvc2Jn6lhMYoxWulPjg+5yZ5qaxbMx7umK9HSHulhzWve5MyWeylwsTLKaQ7i
         SEOb16tVlIhYjbiE2SmUk+b+/aA3g9OHAEW0sBjug8ER/7kUVG/JOyZ1IXA4pSVfFYdK
         bwTA==
X-Gm-Message-State: AOJu0Yx6159XN3pMvpy+FR9FE1sabAWANHLxjz7bd4t7oYVC+V9Yex9D
        zBIgwTE8GzSdpOtIgwDbj04GMQ==
X-Google-Smtp-Source: AGHT+IHJCZYt25NQWNl3KplF0hoF1Mc2Oxzl8kxQCjWQd5Ydn36vmPLYIf6TM+sd4aBU5grh0mKLzQ==
X-Received: by 2002:a17:902:c94f:b0:1c3:3dae:5869 with SMTP id i15-20020a170902c94f00b001c33dae5869mr9757433pla.63.1694986152952;
        Sun, 17 Sep 2023 14:29:12 -0700 (PDT)
Received: from DougS18 (s66-183-142-209.bc.hsia.telus.net. [66.183.142.209])
        by smtp.gmail.com with ESMTPSA id ck11-20020a17090afe0b00b0025c1cfdb93esm5984287pjb.13.2023.09.17.14.29.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Sep 2023 14:29:12 -0700 (PDT)
From:   "Doug Smythies" <dsmythies@telus.net>
To:     "'Srinivas Pandruvada'" <srinivas.pandruvada@linux.intel.com>,
        <rafael.j.wysocki@intel.com>
Cc:     "Doug Smythies" <dsmythies@telus.net>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <Mario.Limonciello@amd.com>,
        "'Swapnil Sapkal'" <swapnil.sapkal@amd.com>, <Ray.Huang@amd.com>
Subject: [PATCH] tools/power/x86/intel_pstate_tracer: python minimum version
Date:   Sun, 17 Sep 2023 14:29:15 -0700
Message-ID: <001701d9e9ae$02438120$06ca8360$@telus.net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AdnprML0/P/rI+TGQ42r3UCRGpjUpQ==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Doug Smythies <dsmythies@telus.net>

Change the minimum python version from 2.7 to 3.6.
Remove a 2.X backwards compatibility line.

Signed-off-by: Doug Smythies <dsmythies@telus.net>
---
 .../x86/intel_pstate_tracer/intel_pstate_tracer.py     | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py b/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
index ec3323100e1a..6b0790e6465a 100755
--- a/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
+++ b/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 # SPDX-License-Identifier: GPL-2.0-only
 # -*- coding: utf-8 -*-
 #
@@ -11,9 +11,9 @@ then this utility enables and collects trace data for a user specified interval
 and generates performance plots.

 Prerequisites:
-    Python version 2.7.x or higher
+    Python version 3.6.x or higher
     gnuplot 5.0 or higher
-    gnuplot-py 1.8 or higher
+    phython3-gnuplot 1.8 or higher
     (Most of the distributions have these required packages. They may be called
      gnuplot-py, phython-gnuplot or phython3-gnuplot, gnuplot-nox, ... )

@@ -23,7 +23,7 @@ Prerequisites:
     see print_help(): for Usage and Output details

 """
-from __future__ import print_function
+
 from datetime import datetime
 import subprocess
 import os
@@ -562,7 +562,7 @@ if __name__ == "__main__":

     # Temporary (or perhaps not)
     cur_version = sys.version_info
-    print('python version (should be >= 2.7):')
+    print('python version (should be >= 3.6):')
     print(cur_version)

     # Left as "cleanup" for potential future re-run ability.
--
2.25.1


