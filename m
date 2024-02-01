Return-Path: <linux-kernel+bounces-48449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80297845C39
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:56:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B37E81C27584
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318A577A0B;
	Thu,  1 Feb 2024 15:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="F5YiyoUQ"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA031626AC
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 15:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706802946; cv=none; b=GDCzm5pyi2V6DJ/+52Wp1WZDt6UuALII1mW745f1++qB4ZhUZT2Y7Zg9LYjKUTgzOnEHPpFAgnSqpK82XRV5fHL4IDJKXawIfwIJluK7LInk2NI185Otn00wkW1d3dXCbx2+gdZOJXrXaDTI/Cxp42YxJ1iGyrJeieGp+TLMtgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706802946; c=relaxed/simple;
	bh=Ne8FaYyFdYXd0+/nwcZOOibQRd96MjLCW87e/NW56iw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n0oIlqNME9AQkrYTFVamjDHiNbNHldszPI+SgOQymCaxBo9fPVrz9DFKdo2iBUNeqobKj8Nd9Dsi9DVg+Yjs4pYoXRIMiSfHP+OY1iZ4C0qqQlHLz5Hi/8LO3N8xitw1oTBEYm4qk5bL7X9cyS4lPM5TDtIIdt+o8Zxkl2gyWeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=F5YiyoUQ; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-50eac018059so1351636e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 07:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1706802942; x=1707407742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VCf5neYMqxadjaO4J9s6ucwyXDUQTnbQajZUESpjeQY=;
        b=F5YiyoUQ4LpEOSuwn6LB/HtF/4p39epgnm8sKeleBEhmcdjFQORpdhD5Mm1b2p/qOL
         lNkog+mNetWQUBsRUq2lL+Wq4AAIRDD9D1XV9SvC6V3mSXmcetOXnWu6uGu13UHdjMxD
         gZhHnmyX1wNTlfdGUL7gnEQIjavJdFh8q16PGwfpTtzGIQ0zH/vTF+BWYo+ix+PXiOiA
         ZEwZoz88OmHe/tG1121+EBTQzhKcqXUNIVnE90Kmj21Hf0xnU1eJeCQoeji0VG0SOAQ2
         Epf7azEh/Rh/Cqtht76lxDviRzZhRsLahahoOwE4XGEa91FpHv6Tb5irklpfn/RUWtZY
         DMgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706802942; x=1707407742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VCf5neYMqxadjaO4J9s6ucwyXDUQTnbQajZUESpjeQY=;
        b=XuDOBEHTOiNoE9WxkXSE67suIVHXHEeRPOyIaZtfltxkdI+peqZu63Ti8pkEVQNCLr
         0HeIj17gziEevRapK74rPYK5ZiKZcOdZ0nJfBLAWZrSTQUH5EvMXhtY2TMg68ocMWRFv
         JeXPhilDJVeZbfsFUmnPFmW2++DeVf8q1/4Ie1+2nMBkDd38jw7PBxnwvxcBl2pvMBeI
         QK/Ad+LYYYhPRNEnWAKIa/WvahlKnPvH2qP9J9US/Y2AfrZ97NjW7gpt74dAd+188+sX
         bKYnn+spgHX0p5UPq2aq6U1xnO/aaKxeRZ0ejZMPHzAV0nse06epYUukK5QYw8/LvKtV
         7O+Q==
X-Gm-Message-State: AOJu0YztNOFZHm/YSG3tshNerBmxrY3Mt4jHFMy4gT5Np57IM8qUSo5b
	TA3xGKhVg3MJdGTqoUzVgeH04K5Fx7EMcKSPvJxt8fTMoUmP6/I03ANZwN61lKI=
X-Google-Smtp-Source: AGHT+IHkrn+Zj3y1432zmCh6KEhYhszwNLXkoBCTb2I+poJA3NCw+EWCILXaf1b/15MhTWnBC6A3Ag==
X-Received: by 2002:ac2:4d10:0:b0:511:1dff:f605 with SMTP id r16-20020ac24d10000000b005111dfff605mr1981785lfi.46.1706802941684;
        Thu, 01 Feb 2024 07:55:41 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVF+2wdShjm6OQ5Wtjr1zIFeaiuVtcAzxXa+wf/JoOMr1kUfk2Tzmj9xzmNSLmnZ5tTi3zErj9tT6F/4UHmgYHK4NDC4c6mCjI0MkhI+HTmlEcNuCV3LVgfo+05AtZMS0sCTIQ5Cs+h9f4+aqt2E1E33ErUq7puh3AW4Ezyoh1gecPEJvl6ONF6zsa7XXcopCHcdI4tCGfWNXv//bihN4LQA189xCmb9aZZTVOPVh8Z2ra+AR9GZIz9SDf96WxpEaz3W0ylZET2Eux5p/O7PgK6UJK4zP+CovmN8UuLL9oUinr4vlj+V5ABtH4iLiJtBDzQnRqwLB6hTt7fXuNt7DjHBefIu2uzrGGP8SzhunR+s7F+pLsepU8uFSil0bcTXXaesrIuTNFrOaeHPq5BDuquDTLUl21KithIGmHmhJYd5KUC5Rfj4YqWqDmIefsc5mEcIsH3uqxt3cMnw4RdaWIrbuuI9xHIZVofhD5KFasGiVclTbyFNDBNmLRX7lkPd8DUwQVrNgbcrJE0sQ/ZYX0wUi9uB5KSM58LnnwFThhoq/aq9JXPDTNSQBBiWfVNn1QutlP3JNqunH+T40nqNurCIqCvWePIjTD9OY1dNlUeoAjvli7wGIwoTpWf+EsvK6aXHGfIvAsuTnEG0R/HQgQTHKptTe67rV92Vof4Xm0dxjJyxPfFQyO8hy5uX/14Ib02fUI/PKeC
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:dd01:5dec:43e3:b607])
        by smtp.gmail.com with ESMTPSA id ce2-20020a5d5e02000000b0033af4848124sm9650318wrb.109.2024.02.01.07.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 07:55:41 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Alex Elder <elder@linaro.org>,
	Srini Kandagatla <srinivas.kandagatla@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Abel Vesa <abel.vesa@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lukas Wunner <lukas@wunner.de>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [RFC 1/9] of: provide a cleanup helper for OF nodes
Date: Thu,  1 Feb 2024 16:55:24 +0100
Message-Id: <20240201155532.49707-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240201155532.49707-1-brgl@bgdev.pl>
References: <20240201155532.49707-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Allow to use __free() to automatically put references to OF nodes.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 include/linux/of.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/of.h b/include/linux/of.h
index 331e05918f11..5462ed47f25b 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -11,6 +11,8 @@
  * Updates for SPARC64 by David S. Miller
  * Derived from PowerPC and Sparc prom.h files by Stephen Rothwell, IBM Corp.
  */
+
+#include <linux/cleanup.h>
 #include <linux/types.h>
 #include <linux/bitops.h>
 #include <linux/errno.h>
@@ -887,6 +889,8 @@ static inline const void *of_device_get_match_data(const struct device *dev)
 #define of_match_node(_matches, _node)	NULL
 #endif /* CONFIG_OF */
 
+DEFINE_FREE(of_node, struct device_node *, if (_T) of_node_put(_T))
+
 /* Default string compare functions, Allow arch asm/prom.h to override */
 #if !defined(of_compat_cmp)
 #define of_compat_cmp(s1, s2, l)	strcasecmp((s1), (s2))
-- 
2.40.1


