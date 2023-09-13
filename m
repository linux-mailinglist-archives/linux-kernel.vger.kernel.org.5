Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 908A779F3CA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 23:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232661AbjIMV1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 17:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232173AbjIMV1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 17:27:34 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2CC1739
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 14:27:30 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-68bed2c786eso247238b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 14:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694640450; x=1695245250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0FSXe6bNCBpdZi03aeP0wSp6h1r1vEv3fBGeHHeswAM=;
        b=MN7B+0/aeKk1to07jMjepdo89gf4ksqoYzQfjr4H7Me4WC90DbPbmC2TTGyRU6cM26
         PD+d+hcvJIElgIQV6yLgyJ7fxI2UV8/34U/VXU9CrPDjOPIHd2VhBGmIeI10AzOFcsKu
         VK7N/AWKRUQzFSI9TgoSpxLXIpkUfXW2wfBY8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694640450; x=1695245250;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0FSXe6bNCBpdZi03aeP0wSp6h1r1vEv3fBGeHHeswAM=;
        b=VdmhIqytpAaI9m34inT8//XF5oAn2EmLEovMw32G0MQcGLYuRpRKNb1WVXq2sHV/lD
         iP54b8QZk5FqFUFMIzJ+5kHNsyrkA9j8eXPvCc5/+l07gdt+HCcursD6YqX7Wjit5DW0
         JLpXobQJMGhOObEDdTdvyjK7P44i3YF3JTroNHUWvNQqRxPrAmXIlohmqwey8qnAJfux
         A60HoXlhU98NZD9ganrL6a4S7e1HI1XvT0CgSawnTwZTsVSCM0ZUCLPl7M095G928hnZ
         Ldern5gPtqvfCp7ukXOr34JVYpplZGpVNJw8sAkln4Un2cfU49P9/Wczm713PdGCEI6r
         cYTQ==
X-Gm-Message-State: AOJu0Yx+gNqb2eok5o4XvCdO8kG9lTKX3JHeP2HevSEdv9wERi4KMjHY
        do4/aGSB7fKXVP3rXuRGaJlx+Q==
X-Google-Smtp-Source: AGHT+IHrBsutj053PgCBAoa/lMn4hSREkeQcGtlYOD1ODQzI8J5LrpGMDWvF5QcJgJC4rleFbOHPXw==
X-Received: by 2002:a05:6a20:3d14:b0:152:8774:e1ab with SMTP id y20-20020a056a203d1400b001528774e1abmr4265873pzi.52.1694640449755;
        Wed, 13 Sep 2023 14:27:29 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:11a:201:ae97:c6dc:1d98:494f])
        by smtp.gmail.com with ESMTPSA id a10-20020a17090ad80a00b0025bdc3454c6sm1923976pjv.8.2023.09.13.14.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 14:27:29 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        platform-driver-x86@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Prashant Malani <pmalani@chromium.org>
Subject: [PATCH v4 3/4] platform/x86: intel_scu_ipc: Don't override scu in intel_scu_ipc_dev_simple_command()
Date:   Wed, 13 Sep 2023 14:27:21 -0700
Message-ID: <20230913212723.3055315-4-swboyd@chromium.org>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
In-Reply-To: <20230913212723.3055315-1-swboyd@chromium.org>
References: <20230913212723.3055315-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy discovered this bug during patch review. The 'scu' argument to this
function shouldn't be overridden by the function itself. It doesn't make
any sense. Looking at the commit history, we see that commit
f57fa18583f5 ("platform/x86: intel_scu_ipc: Introduce new SCU IPC API")
removed the setting of the scu to ipcdev in other functions, but not
this one. That was an oversight. Remove this line so that we stop
overriding the scu instance that is used by this function.

Reported-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Closes: https://lore.kernel.org/r/ZPjdZ3xNmBEBvNiS@smile.fi.intel.com
Cc: Prashant Malani <pmalani@chromium.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Fixes: f57fa18583f5 ("platform/x86: intel_scu_ipc: Introduce new SCU IPC API")
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/platform/x86/intel_scu_ipc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/platform/x86/intel_scu_ipc.c b/drivers/platform/x86/intel_scu_ipc.c
index 299c15312acb..3271f81a9c00 100644
--- a/drivers/platform/x86/intel_scu_ipc.c
+++ b/drivers/platform/x86/intel_scu_ipc.c
@@ -443,7 +443,6 @@ int intel_scu_ipc_dev_simple_command(struct intel_scu_ipc_dev *scu, int cmd,
 		mutex_unlock(&ipclock);
 		return -ENODEV;
 	}
-	scu = ipcdev;
 	cmdval = sub << 12 | cmd;
 	ipc_command(scu, cmdval);
 	err = intel_scu_ipc_check_status(scu);
-- 
https://chromeos.dev

