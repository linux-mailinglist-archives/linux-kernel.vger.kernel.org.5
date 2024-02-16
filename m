Return-Path: <linux-kernel+bounces-69302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BEF78586CE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 21:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 036891F2439A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 20:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8007145FF9;
	Fri, 16 Feb 2024 20:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="JvanfooB"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD5F135A6F
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 20:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708115596; cv=none; b=DnWG0nTj3qIyE8apihhsekf+rt/vP5ghM0S+OELc1YdPAx9NYLK8oQAD0Pkkm2MIX5VjZnvcXaCPj8+THGGDJTCMAFc1mKUt62PJIO5kq+yrkipIOS0MCtKIV0hHLdyOwSgFC37j6+c5FFVkZ25oupRKkqiX1YjG0TuT8qkl0A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708115596; c=relaxed/simple;
	bh=0QV0XOVkgQZCCrRrdg+X1apPFOwyznZIa0nD2VYHxpg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P2VQF5asIQW600Alro8nQilPIADsvGeZURoLXrGkwh5x0azjP8Mz1pn0Pkqv5amiSnX/e3zmtbrpQe8egJ1Cvd3e/l28FlI1064VGPJgGmKDG6TeFawwqCHhEUIXT922LMdG2bk+5KU6tEN/JS/I8rk+O4WEC3u5E6x/3Ni3TBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=JvanfooB; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d11d17dddeso16105451fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 12:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1708115592; x=1708720392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xzau/i70OXFn0nQv+xGSpdZtho+tWjzX+6Y/L0CiXOM=;
        b=JvanfooBq97Z2sHrKPc3VpFIgrK3j/jFli+kAib5aKwMIanlbpELte4UbuyoKFppIs
         gnNNEzb8EG5Rd095l7oHT+3g/PZKTMaVbf46FZermOQA/Jmdl2Bwo9Rr0dywTS8lm+h3
         +UpB0SaOvcH+gWPHsCZntdeunaiR4eKYBKxtyvCD4T5GU5zPEmO85VyHwbazjpo0p1BI
         UDYVphdb/Q4JKjwDs/p1480137jM28OZ6Te+HzDNyyDOd+6VCiYSmwFe3SRAI2HgmzNM
         T7e0rINuN88kEcNUzxrYwBgEasp5p77mMV0Tek2j7T318VT/AKfT0bnxXRAevCYHIOVG
         jcUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708115592; x=1708720392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xzau/i70OXFn0nQv+xGSpdZtho+tWjzX+6Y/L0CiXOM=;
        b=NED7i0w/idtRgElXdPJbZyYJObiCHW5Ll/XvmwBtaW1OGYKx1IPz51tEanQ+kpklNX
         XezuRkygdEMliymwcVDThDUgF4O2fNjclga2jwyAUPO9k26Xqse3AE55+HItxHy9QAov
         SdyBoWBZ7Ba4x0m86SHBvJ6K1/fnATws63zIIbbIzhvlmnDI8U2TSICt/sFA3cEQjrka
         9tBTTNjw57iatXJLdOIGFpujfwMmHIk6hjHjD8z4O2X1sx1jherBI0UPhXx1KUYw5SWj
         UiufrsJIQLJZ3TYJ/r+Is70Sxv/M25eLsXJv0YzqCAaVwkOflYZdGZjvZIh1Gw8iA8Dc
         0fNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcQi+sPn9z6flMcSPNMAAgDwhHHXzTMwUmBwvxYzjGgEtn7IaPtsb3v/Q7EQBoEb7sDk1fWkP/lwW2/Zai9M27ifjLsh7yduE/EHr2
X-Gm-Message-State: AOJu0Ywo61SJSHyYkdbObaLWDG4MnxyM6i58z/8Iun+8bJXQiy5VD8gR
	ZsWCIg/ngrpsYOut00qlbeBOj6Y8fJMJizwl2u+ivX3OrhGe5mCtqeR3GYfuZGk=
X-Google-Smtp-Source: AGHT+IHDXA1CmYyMRhXqVjoGiSoJb0Qo9lCMPdos1FiMsILNtLiMwId05Qkpwu2DiA7OHYVJNW3yMg==
X-Received: by 2002:a05:651c:b0f:b0:2d0:dfa7:fa1a with SMTP id b15-20020a05651c0b0f00b002d0dfa7fa1amr4944359ljr.0.1708115592326;
        Fri, 16 Feb 2024 12:33:12 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:7758:12d:16:5f19])
        by smtp.gmail.com with ESMTPSA id m5-20020a05600c4f4500b0041253d0acd6sm1420528wmq.47.2024.02.16.12.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 12:33:11 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kalle Valo <kvalo@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Saravana Kannan <saravanak@google.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Arnd Bergmann <arnd@arndb.de>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Alex Elder <elder@linaro.org>,
	Srini Kandagatla <srinivas.kandagatla@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Abel Vesa <abel.vesa@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v5 01/18] of: Add cleanup.h based auto release via __free(device_node) markings.
Date: Fri, 16 Feb 2024 21:31:58 +0100
Message-Id: <20240216203215.40870-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240216203215.40870-1-brgl@bgdev.pl>
References: <20240216203215.40870-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

The recent addition of scope based cleanup support to the kernel
provides a convenient tool to reduce the chances of leaking reference
counts where of_node_put() should have been called in an error path.

This enables
	struct device_node *child __free(device_node) = NULL;

	for_each_child_of_node(np, child) {
		if (test)
			return test;
	}

with no need for a manual call of of_node_put().
A following patch will reduce the scope of the child variable to the
for loop, to avoid an issues with ordering of autocleanup, and make it
obvious when this assigned a non NULL value.

In this simple example the gains are small but there are some very
complex error handling cases buried in these loops that will be
greatly simplified by enabling early returns with out the need
for this manual of_node_put() call.

Note that there are coccinelle checks in
scripts/coccinelle/iterators/for_each_child.cocci to detect a failure
to call of_node_put(). This new approach does not cause false positives.
Longer term we may want to add scripting to check this new approach is
done correctly with no double of_node_put() calls being introduced due
to the auto cleanup. It may also be useful to script finding places
this new approach is useful.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 include/linux/of.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/of.h b/include/linux/of.h
index 331e05918f11..8df240214db1 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -13,6 +13,7 @@
  */
 #include <linux/types.h>
 #include <linux/bitops.h>
+#include <linux/cleanup.h>
 #include <linux/errno.h>
 #include <linux/kobject.h>
 #include <linux/mod_devicetable.h>
@@ -134,6 +135,7 @@ static inline struct device_node *of_node_get(struct device_node *node)
 }
 static inline void of_node_put(struct device_node *node) { }
 #endif /* !CONFIG_OF_DYNAMIC */
+DEFINE_FREE(device_node, struct device_node *, if (_T) of_node_put(_T))
 
 /* Pointer for first entry in chain of all nodes. */
 extern struct device_node *of_root;
-- 
2.40.1


