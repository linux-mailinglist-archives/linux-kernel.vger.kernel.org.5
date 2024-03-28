Return-Path: <linux-kernel+bounces-123524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F72890A52
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:57:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29106298ADA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 19:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5A713FD63;
	Thu, 28 Mar 2024 19:52:35 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F97F139D13;
	Thu, 28 Mar 2024 19:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711655555; cv=none; b=kcHtkgaoL9Le5ynYSAtuMteY8QQvZ/cUkehW43dSt6iIwzxQWoc8JTDQOmuWC/iodxLf7dO8EkyXQ6up8IttpQXRB10Z7b1TWofl25mMSmvvQn75110FSf7po14SwqAYrXvvSLjAjC+sCTDqn6LcX7qWm2A38tNJ88DPYREsblQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711655555; c=relaxed/simple;
	bh=47KuFYZ8L8+G4UI1Pvi3xIrvtmpgxV1zjVNEYiD1uVo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lPImMu3VVirrTj/Gd+bGVL1yNux5qCTIR8oK4zm7MvSZSQtFsaeT9mDAj3hsWjNAKd1dHhx8Gik0bOi0o0zFGa/h/kKTP4uyEjgefSnJqiRQJzNamPfGKrs19kSVrMZbPFwGu7CVGWwgl3oWzpHgf/32RGU9k3tMcjFGmaqJXew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13FC6C433C7;
	Thu, 28 Mar 2024 19:52:26 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 28 Mar 2024 20:49:29 +0100
Subject: [PATCH v2 19/19] ACPI: drop redundant owner from acpi_driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-b4-module-owner-acpi-v2-19-1e5552c2c69f@linaro.org>
References: <20240328-b4-module-owner-acpi-v2-0-1e5552c2c69f@linaro.org>
In-Reply-To: <20240328-b4-module-owner-acpi-v2-0-1e5552c2c69f@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Robert Moore <robert.moore@intel.com>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
 Corentin Chary <corentin.chary@gmail.com>, 
 "Luke D. Jones" <luke@ljones.dev>, Hans de Goede <hdegoede@redhat.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>, 
 =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 Matan Ziv-Av <matan@svgalib.org>, Mattia Dongili <malattia@linux.it>, 
 Azael Avalos <coproscefalo@gmail.com>, Ajay Kaher <akaher@vmware.com>, 
 Alexey Makhalov <amakhalov@vmware.com>, 
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>, 
 Richard Cochran <richardcochran@gmail.com>, Theodore Ts'o <tytso@mit.edu>, 
 "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 acpica-devel@lists.linux.dev, linux-input@vger.kernel.org, 
 netdev@vger.kernel.org, chrome-platform@lists.linux.dev, 
 platform-driver-x86@vger.kernel.org, 
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=730;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=47KuFYZ8L8+G4UI1Pvi3xIrvtmpgxV1zjVNEYiD1uVo=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBcnPtASe+iRyJkpoHwhufZ2+JsLopJALmbniw
 UDP7ulp1AWJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgXJzwAKCRDBN2bmhouD
 17DoD/0QKCrfY1wzazIXKHtVvuFB1Xfi5lltqqYYwJMDm4OTF6UpYmgo5MzHKJbTebMw05Z4pZf
 EXEmbB9o8tIjsItkWODjFoUzw3Dat2E2/B6Tpv634gKeMiXI2IvBrsOalPHbWk7v1VlzF6zJswj
 pEzdmJhzgyz9J6P9w5Vi/+lUS/Zxt6h/CumlMz0c1xRxxn3jkH31JvpYdyVa6RccfxFA+q7V6Gv
 bPJQFzhqOp1+nZWqd9D/Ykt0u/rWIegxnQHti3T1xfnI7S4HOyXaV47B99l7NOYJvCmr4Ab2BBt
 5eYRdjRl7jFLLA2gw7Q3FpZ6pHpsQ/g5pb73wrzKO4c68s0Kkphtglr1vOxAJf6owfSb2hbTfei
 u0+17WV0r8xpAmaGBEDuaBKrJ4yHO0Cu81M9LIGBXN808vnkw3BKIcjg/WfxXsViFlvqZhPTuHZ
 eXwou6kxN/EQtyWvmULt496TgdFzxhRHsrGw10bL8gvKrxalcC/on/+sTqzhuBSUVceCxtc4y3e
 gNkZwN+xwaeub2VgVAAW6B+w8jJxRNuRSlgJLwMP+RF0p2kcd9BB0iHytmLZnHf8krluuTFKfZp
 N/GXa4RCkkQcPCCMokvj76NTpBbpX6dq1Ri0N3OnIG0ZA9GcjoJG+WMcDyiELXHjA6YCezqkQvl
 qgi9HU++if1bw9Q==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Once all .owner is removed from all acpi_driver instances, drop it from
the structure.

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

This depends on all previous patches. It could go next cycle, after
things got merged.
---
 include/acpi/acpi_bus.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 7453be56f855..32aae3ee99ac 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -170,7 +170,6 @@ struct acpi_driver {
 	unsigned int flags;
 	struct acpi_device_ops ops;
 	struct device_driver drv;
-	struct module *owner;
 };
 
 /*

-- 
2.34.1


