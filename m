Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE9977A8C5F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 21:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbjITTMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 15:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbjITTMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 15:12:03 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA5F6D6;
        Wed, 20 Sep 2023 12:11:46 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2c129cb7770so1103581fa.1;
        Wed, 20 Sep 2023 12:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695237105; x=1695841905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yHRQdHA2TrKcClwyZPJGHcHGoAWxrLE4S/rv0kc+7Gc=;
        b=RFN2OvlaiiPt0VMSzMfmqRTrF0/bTErVljiwg6yiYeB16mH4sjofHncyGdk+Eel8Du
         s6uonOBrlVeyxpexgXPdyR+Nf6hUUTuM9yYWiL1o/+S4L2Y7xsMCYcrn0Y2NNRy4q5E5
         pxKw0I0D94UxqzMoKR4HlZJ12Vh3Ye2lU23K+34IwryhJXSViqc4zL77Hj50ftkLEVw/
         iYZ2CM17gY5dNW3BuC1Cbfg6gscp+w94QyAZWfSCPKFWNp4F05KT8BM36Z8pIe4wd13w
         8CKyAcEVDYfRGcBXv8SnwbFMXQD8PUFVpWhIh9DPRldQaquUCr3XqXr6E4fS+odkY7gk
         +h+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695237105; x=1695841905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yHRQdHA2TrKcClwyZPJGHcHGoAWxrLE4S/rv0kc+7Gc=;
        b=Ne4aOICLAOXNjO45E4tC+uan+82xn9HTMbn/FqAXCHxgHk9H0b/zYWQLCTMKuYP1r3
         JJV/W0IWM8e5/GVOvfgpjNF+55+DZDgARC4mpjdi6R171knTuYXaxQbtxmAb0XuH+SnR
         PvY2+6IjGWQtVyuMyHVNOP2GBkM3I3GPUhGK4wkOcMUsFeNv0i+bmO6wWdDPDBe9mYdt
         r8YSM72WutdRXSFhOiWn3Y7EJXEykQuZIPubHG/KG+cOuKiuM7AYRMiVWAu3NvsZozfY
         G3bAYerWheuzfpw3othAwH7ZgjXXZIkkPdhtR29pD5XwIrbe6u2lUAIrmLQK4ZNdxBau
         Q6Vg==
X-Gm-Message-State: AOJu0YxO6vKOEdPMIXoM+IFCOYGiaNpSQidkVbYee8gHq054nLsIwus1
        fFhlfBRObspDWY1eYRP7PZLvhh432ec=
X-Google-Smtp-Source: AGHT+IHd2CkZwttT4F2jXh6IaKu9rcVIvAB/uihrNi/Key7BOuuMoH3/wbQTh7zgdKEGQKF+hmaX5A==
X-Received: by 2002:a2e:b5b7:0:b0:2c0:1ce3:c20c with SMTP id f23-20020a2eb5b7000000b002c01ce3c20cmr2389071ljn.3.1695237104782;
        Wed, 20 Sep 2023 12:11:44 -0700 (PDT)
Received: from localhost ([178.176.81.97])
        by smtp.gmail.com with ESMTPSA id s22-20020a2e81d6000000b002b9b90474c7sm79123ljg.129.2023.09.20.12.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 12:11:44 -0700 (PDT)
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Michal Simek <michal.simek@amd.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Punnaiah Choudary Kalluri 
        <punnaiah.choudary.kalluri@xilinx.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 09/20] EDAC/synopsys: Drop local to_mci() macro definition
Date:   Wed, 20 Sep 2023 22:10:33 +0300
Message-ID: <20230920191059.28395-10-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230920191059.28395-1-fancer.lancer@gmail.com>
References: <20230920191059.28395-1-fancer.lancer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The to_mci() macro was added in commit 1a81361f75d8 ("EDAC, synopsys: Add
Error Injection support for ZynqMP DDR controller") together with the
errors injection debug feature. It turns out the absolutely the same
macro-function has already been defined in the edac_mc.h (former
edac_core.h) header file. No idea why it was needed to have a local
version of the macro, but there is no point in it now. Drop the local
macro-function definition for good.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 drivers/edac/synopsys_edac.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index c2ac2eb64642..0c6441719215 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -941,7 +941,6 @@ static const struct of_device_id synps_edac_match[] = {
 MODULE_DEVICE_TABLE(of, synps_edac_match);
 
 #ifdef CONFIG_EDAC_DEBUG
-#define to_mci(k) container_of(k, struct mem_ctl_info, dev)
 
 /**
  * ddr_poison_setup -	Update poison registers.
-- 
2.41.0

