Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A750B772C60
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 19:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbjHGRMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 13:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232017AbjHGRMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 13:12:23 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDDB31BF1;
        Mon,  7 Aug 2023 10:12:08 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1bc1c1c68e2so29730565ad.3;
        Mon, 07 Aug 2023 10:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691428328; x=1692033128;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o/ZrwT0NJoa3SvrfuTbm+aI37YIFG6qkhwqRx+xCrA0=;
        b=UqwBSzb7bDmSyec+1PJCPQEzpyJ0+EdMmkMvCke7Wnea0hLj+c9hkMVwbEw5OIZlt7
         2jFHWIlB3pNRnbenayfQHGZvj+rIIEnIdoYp6wuzuzdJuPV95bZa1c33CO6m1zvKYZN8
         SDRrnOVcXFN2xJuq9TuOmPsyc5HHQEycjoC00VXy6zC+vja0xBQwcwhdO3dug+bY9yUz
         uItD6eYHilJWK3UpSAisNS3wT9CHEhIlEAsWVjwWDL64eFa4pFKQuuEhhneseSz94DT3
         WhYkjovQZccQGJdgPZPdN4dhwG3euTQvC1g9vo6NR/WCZUDwvMeMpkkItLbFOxUoDpyG
         dObQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691428328; x=1692033128;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o/ZrwT0NJoa3SvrfuTbm+aI37YIFG6qkhwqRx+xCrA0=;
        b=acSsuaFsGj2csX7w+se2Ca7ioNUFD4HfSQglPAck/l7j9ZaunprmsguDKBRQ82mpCw
         Aj7OasZP6dA+CHvLk2mE95IH3Gi+Nets8F/VBQhSHOVBMTOJYN/I8ayOKLqmfjzQfL22
         nvAKtL99W6G0zMDzZGXc14D3jWoImCMHpZlY9heEi4IJmwzSQgnCNvcIBrvfTwa4xTaK
         497RRtDbvB9zeUAxCmVseUinIoAb9znoEQDJXg4sQs8iV3VhYdF1d860ryJ2tJ4sUBIg
         Vyjl4qlqSA5GBVbcT8y1esYoQ8SPqmYr5AeHJ1NAcWl2i4wvhcKSXpLL7+CL3bLu1HFq
         v2hQ==
X-Gm-Message-State: AOJu0YzJom4AHvmx/C1FeRHpDvx7w90QDgsTOCh2Kxk3x9GAF3N7jP6J
        np6otGQhiqGajDtsDMXLVmE4nmorW5U=
X-Google-Smtp-Source: AGHT+IHcE8fCOj51H5o9epINqTnpHnYF2YANR0R6RsiK0gsnRbxxmF0NZPQBL0kOhW0Cbcs0EmkDFA==
X-Received: by 2002:a17:902:ab0c:b0:1bb:b855:db3c with SMTP id ik12-20020a170902ab0c00b001bbb855db3cmr7406106plb.41.1691428327863;
        Mon, 07 Aug 2023 10:12:07 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:6c80:7c10:75a0:44f4])
        by smtp.gmail.com with ESMTPSA id v12-20020a170902b7cc00b001ac741dfd29sm7133303plz.295.2023.08.07.10.12.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 10:12:07 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org (open list:HIBERNATION (aka Software Suspend,
        aka swsusp)), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 5/9] PM / QoS: Teach lockdep about dev_pm_qos_mtx locking order
Date:   Mon,  7 Aug 2023 10:11:39 -0700
Message-ID: <20230807171148.210181-6-robdclark@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230807171148.210181-1-robdclark@gmail.com>
References: <20230807171148.210181-1-robdclark@gmail.com>
MIME-Version: 1.0
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

From: Rob Clark <robdclark@chromium.org>

Annotate dev_pm_qos_mtx to teach lockdep to scream about allocations
that could trigger reclaim under dev_pm_qos_mtx.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/base/power/qos.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/base/power/qos.c b/drivers/base/power/qos.c
index 5ec06585b6d1..63cb1086f195 100644
--- a/drivers/base/power/qos.c
+++ b/drivers/base/power/qos.c
@@ -1017,3 +1017,14 @@ void dev_pm_qos_hide_latency_tolerance(struct device *dev)
 	pm_runtime_put(dev);
 }
 EXPORT_SYMBOL_GPL(dev_pm_qos_hide_latency_tolerance);
+
+static int __init dev_pm_qos_init(void)
+{
+	/* Teach lockdep about lock ordering wrt. shrinker: */
+	fs_reclaim_acquire(GFP_KERNEL);
+	might_lock(&dev_pm_qos_mtx);
+	fs_reclaim_release(GFP_KERNEL);
+
+	return 0;
+}
+early_initcall(dev_pm_qos_init);
-- 
2.41.0

