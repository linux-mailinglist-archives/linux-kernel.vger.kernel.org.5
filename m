Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B37C76F564
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 00:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbjHCWCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 18:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232338AbjHCWCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 18:02:37 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 137EB4228;
        Thu,  3 Aug 2023 15:02:28 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1bc3bec2c95so10713855ad.0;
        Thu, 03 Aug 2023 15:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691100148; x=1691704948;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4DhIg3tNHO0nntKDGAxke0FWjkdaCQbgLVhUvGrrYUs=;
        b=IVlws/H4rqzASnvCfzGDeM/2XoRReLJI6eIC0i9+rPNLhDlwnCMr8bdveheG+sCd5J
         3gFvy0xz1vCS65CzLWl7PQwOUoMfs4iq47iApgydooKTPVi0iV95aDAnaK53qDnZylyL
         n+lXg0DKtjNYPkv2/2ZkW3dLUJcMk1mS0FF2f2ueQ0j4W7Gwt0VtudxJtbIdndtM2vvO
         wTzZfpw+fzEZEFU41QIEttkYj1djtMIGHlKN25Fg9nqVMKlaRSmFvwnxf6tjqlhPuoZg
         wo+N++RmXWWGxczyUFmaBmPnChRUdct7H2SLhWfHWEQtc0eosJwwiPV4MaubrdmNueGN
         Gucw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691100148; x=1691704948;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4DhIg3tNHO0nntKDGAxke0FWjkdaCQbgLVhUvGrrYUs=;
        b=XYkE6de8XuqVA3l0/zizv2Fatr/cOFXVkYndoOR11BUb/kUYX/t0st2srl3/Cey7RI
         F+JHz7LX6O9+xfyJePi3G3CP/wlaHzJZZq/CSHZuT+PO91AFzvRFDWUddTygoDcvCH5N
         r3D1jdF3l7bzCkQ8KX/H0GRU6HHU825Rj7DlvmwKr0hRgAQQPzEo7EoQNdNan6IsyDnp
         AeCrywQF3K72yMvKs2FxRwzQdFWIH8l2TR8LQyjhbjKgrr5pcVNdkzhQcwftkCZ13XWg
         PHjKoVQGxHYhYEuvAD50EQdqDT+wMiI/IuyQhN1I3GBQ2S3AH/o3StdNfit5Itpr9ycY
         zLAg==
X-Gm-Message-State: AOJu0YydSMp6VqQJ6pPWMvioRPIe4IdtiEPwlGiNegW6WWKoSsaGj1ZH
        lCmJFk+E4matZkVC090DTdM=
X-Google-Smtp-Source: AGHT+IHuhhbpypvPjmu6boQpzcgERRrZoJqVc0eDSJ/uhLny1OFK5GhIrA4vr/pGLwrUAZTitqZOeQ==
X-Received: by 2002:a17:902:e746:b0:1b8:af5e:853c with SMTP id p6-20020a170902e74600b001b8af5e853cmr4507plf.26.1691100148236;
        Thu, 03 Aug 2023 15:02:28 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:6c80:7c10:75a0:44f4])
        by smtp.gmail.com with ESMTPSA id p17-20020a170902ead100b001b03a1a3151sm325374pld.70.2023.08.03.15.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 15:02:27 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org (open list:SUSPEND TO RAM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 5/9] PM / QoS: Teach lockdep about dev_pm_qos_mtx locking order
Date:   Thu,  3 Aug 2023 15:01:53 -0700
Message-ID: <20230803220202.78036-6-robdclark@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230803220202.78036-1-robdclark@gmail.com>
References: <20230803220202.78036-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
index 4537d93ddb45..6cb4143d1090 100644
--- a/drivers/base/power/qos.c
+++ b/drivers/base/power/qos.c
@@ -1010,3 +1010,14 @@ void dev_pm_qos_hide_latency_tolerance(struct device *dev)
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

