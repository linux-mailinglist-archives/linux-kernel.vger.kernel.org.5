Return-Path: <linux-kernel+bounces-60314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06226850311
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 08:12:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89D971F24600
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 07:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E584639FC3;
	Sat, 10 Feb 2024 07:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lGoXDUwj"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C85139846
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 07:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707548996; cv=none; b=ok8+5jQwYWx1xJV9Feueaok3cQGFGf092IrTr2GDTRX1lW7Wjjqhy14lRo5FWDdwPjKjMO5jrHq3rGklrbM2fxtqqTijCEP2FgydZYUx6p/WaQ0EbOPX8A+YnFeDDcUqFR0z39e4PEGQDfNxzelJBMD4+I9sKLvCbAMYGoZwTgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707548996; c=relaxed/simple;
	bh=ZrfWbNRvVHxNeML0mxoQMrfj5rYIPsgYNkk8cvKEzno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DjUB4pThI/yzfKSg/MdW/Da4GZZs9QVYwWf2wEEDooBT7PwleJjVDlhNICnj+R7O1KICyBZvuWtsvsqYis5KxdX+6WvZrja9sOpCqbWFVPVmGeimrEnPfV1JDX3TiQHQP9InXUYLdJMJT380R2X5+K750GPTiilJui8rDi5bXqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lGoXDUwj; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d99c5f6bfeso17923215ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 23:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707548994; x=1708153794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0hZ7H2Ratg3rpkz8VVpxhu5TODDBGSfCSSbP4Wfsjkw=;
        b=lGoXDUwj8GWKwtpOWYDgfsHqHSHSG+rG8wc5DWl/zvir8K5/qwHucx9ksNwEwKe13D
         /HNTISSx0r+pUk/LCaDbr/AlPGyDaz/aUSGO9XqTV1FKe2NkvC4KY1t4bYtgmtIkfQEs
         /g2SroUcjkl5QaHZNTSjVQ66tWA2aVefzJdU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707548994; x=1708153794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0hZ7H2Ratg3rpkz8VVpxhu5TODDBGSfCSSbP4Wfsjkw=;
        b=GhOw7OXkfEYoLe6zo0RETt1BRN8SsjQiTl0Tap5Ue645pL4/jjk8nAGBvHTYX9ghgC
         LbZ89KSdAgnFYp0d2JF/wYARoxt05ZBRv4tAv+N0a4IDi9o7UP2JmqS1hgpPeb0NBZH2
         1DAxrCNvYTqlmRsGrhSs0SqRIx0JOPdW/5c8RgiE9HZLcCPPrO5NXARAQJZC2KQdbgmM
         yFqx6kUCx76vCu5GtC7q+iARYw+Hnq2nyddH17agqNp11PxtqAExpQdXTIrE/VvpqnC1
         fsmPenWwHuisCo3+fhbz5V1ufhzR9YfXGmtD9kkjPb8ubcX12CUwylfTAVMK0jOsvK1H
         5LxA==
X-Forwarded-Encrypted: i=1; AJvYcCUaHWHfKYLd8C479jgtPpEIdY0VrzGsgiTNOw7zXSNQMLfkSU0xsF8ccxYc3eqWFTM1/SneCaeVNgTLEmACkKZLmi7niUqIAjrW253Z
X-Gm-Message-State: AOJu0Yx3M8rmeO3DR/mITbk1IqcIe9Q9kcw62MUy0MRIbZQ1spplg65B
	izkwbsyD3T194M6stApd5dcbDdshxQWJ0nKPKn6VXVIRtfZcgBuBO7k8fr50Gg==
X-Google-Smtp-Source: AGHT+IE74shzX34A4XJ2sswnIPnBB2cAtBVGC7VAOSCbWKlPiKiVqbqmig4A0vzOlWVgJfSyoFJIVQ==
X-Received: by 2002:a17:90a:b881:b0:296:1dcf:c297 with SMTP id o1-20020a17090ab88100b002961dcfc297mr2038853pjr.7.1707548993706;
        Fri, 09 Feb 2024 23:09:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUdlXLg5og70qheFVtE2wxLh4Aatgr2JuX6qBZq1Hzv0Ubz4IIv0qIg/xzMHN8EPeDldrbsRJa3EkSGd6FVIRCmDYEQU7VCTD8/9qn7/J/564Dc7YbBVXVx8GJprDInmAOehoOK4VzXaKKoWRxaJ9KfPxwEMKT1MC/9v0Ff2/2IkDw/oc//N8Zhp/aQ9VKlfE9UkS6Fnijj/S/phDX7qkp3imWWVKdocEDgtZlC6S+PFY5tMBwxIIWO0DQuvwakgIw9Pkiw/m0OR/Tf5UowBvq5FMaYjhtiX49jof2ZrCDRMUIVmH2SxGcFfvixC1irDXKWqyJ53IAG89qM3wqEcRJLc02ftkUhCV6aUZ61aFJk5a0i04AG+zB5QHE/mrdyixBvB6qRjd12JpR5l31MK1K3O7ZL3/hK0ZUFt2faCzREy/6eMaNZdEBQGEQTB2U+LRYjZEQ=
Received: from localhost (175.199.125.34.bc.googleusercontent.com. [34.125.199.175])
        by smtp.gmail.com with UTF8SMTPSA id bj13-20020a17090b088d00b0029552a03219sm2883297pjb.29.2024.02.09.23.09.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Feb 2024 23:09:53 -0800 (PST)
From: Stephen Boyd <swboyd@chromium.org>
To: chrome-platform@lists.linux.dev
Cc: Prashant Malani <pmalani@chromium.org>,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	Douglas Anderson <dianders@chromium.org>,
	Pin-yen Lin <treapking@chromium.org>,
	Chen-Yu Tsai <wenst@chromium.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 08/22] platform/chrome: cros_ec_typec: Purge blocking switch devlinks
Date: Fri,  9 Feb 2024 23:09:19 -0800
Message-ID: <20240210070934.2549994-9-swboyd@chromium.org>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
In-Reply-To: <20240210070934.2549994-1-swboyd@chromium.org>
References: <20240210070934.2549994-1-swboyd@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Prashant Malani <pmalani@chromium.org>

When using OF graph, the fw_devlink code will create links between the
individual port driver (cros-ec-typec here) and the parent device for
a Type-C switch (like mode-switch). Since the mode-switch will in turn
have the usb-c-connector (i.e the child of the port driver) as a
supplier, fw_devlink will not be able to resolve the cyclic dependency
correctly.

As a result, the mode-switch driver probe() never runs, so mode-switches
are never registered. Because of that, the port driver probe constantly
fails with -EPROBE_DEFER, because the Type-C connector class requires all
switch devices to be registered prior to port registration.

To break this deadlock and allow the mode-switch registration to occur,
purge all the usb-c-connector nodes' absent suppliers. This eliminates
the connector as a supplier for a switch and allows it to be probed.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
Signed-off-by: Pin-yen Lin <treapking@chromium.org>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Tested-by: Chen-Yu Tsai <wenst@chromium.org>
Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Link: https://lore.kernel.org/r/20230331091145.737305-3-treapking@chromium.org
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/platform/chrome/cros_ec_typec.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index 2b2f14a1b711..cc5269a4b2f1 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -325,6 +325,16 @@ static int cros_typec_init_ports(struct cros_typec_data *typec)
 		return -EINVAL;
 	}
 
+	/*
+	 * OF graph may have set up some device links with switches,
+	 * since connectors have their own compatible. Purge these
+	 * to avoid a deadlock in switch probe (the switch mistakenly
+	 * assumes the connector is a supplier).
+	 */
+	if (dev_of_node(dev))
+		device_for_each_child_node(dev, fwnode)
+			fw_devlink_purge_absent_suppliers(fwnode);
+
 	/* DT uses "reg" to specify port number. */
 	port_prop = dev->of_node ? "reg" : "port-number";
 	device_for_each_child_node(dev, fwnode) {
-- 
https://chromeos.dev


