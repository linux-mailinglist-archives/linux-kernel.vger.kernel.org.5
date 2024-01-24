Return-Path: <linux-kernel+bounces-36583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3E383A363
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 08:46:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44C481F2C330
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 07:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3A617556;
	Wed, 24 Jan 2024 07:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q3E30Tr7"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE64168DA
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 07:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706082338; cv=none; b=GAPQCcSp5Qt31GwkquSpd4To6yhXar2vIhVA3xSpcJ7LtmiYwehyKkerLhxOdD3IoHTKuRqRfKcYY7cH+4rgL/KIYwMIHWoi48+UlUqKfLXHEM4QQB2D4EG+kb1MkIKQAYenc5WF2ypQVdg5zrfkDbG21ZxKxm15nIlQYF5Oezs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706082338; c=relaxed/simple;
	bh=05A1V42ISzk91H47v/1k8F5cOUyqcqx459Ycs2uRiyQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k9nrv3a0U6v73PBK1XCmZccceMo5PsM8bAtUE+NspEZJ05pfGziLuwgq3nt3IvxeI8shuCvleMQA/NyRoOYfggdTF4Y+TeuU1AVPDh1eKKpwje2Q2BrHHLj8Y3646j5dKQhqzzp/rw5D6tpzHE6m8GVvjZfXLNTigpcL2nJDiWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Q3E30Tr7; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-55a179f5fa1so6054727a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 23:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706082334; x=1706687134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rvG442LOHG+Ot3BClfANwtHkjvhl+RcGyuBNzT4bkhE=;
        b=Q3E30Tr7UwicUq8KsvB9Nt6PJeUbFNI7JD1m3uiiASmOmCqZ5EE/IzwMrYFho21nok
         VIzDjKQqgVsh/7Kr2GWrGObV3LI0LXxKZCwrBqKZdf7Sk7h9b0JKji9icaC07F7Plf8H
         K3py/1uCBCVf0znmSkFzWSsYSJb6ZKffTtpWL+ufH4CL5hYsrKE8kbpvixqgbdtRQd9+
         /Dh4qO7TBDN305ljw6Bjvs7M3E6GI+krg+ivxMYnzWtidP0SP9/bc+3zgp8a99NUGTfk
         nm5rbGHBFpux/OHlWAHETHW+3cZFaexW8lrNSmllIv7MTK3NjPlpAX8tB0mVpkVg6UIj
         PH3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706082334; x=1706687134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rvG442LOHG+Ot3BClfANwtHkjvhl+RcGyuBNzT4bkhE=;
        b=aFnPtUyGUchzaTXs8xEA2gp8HPfjKEKWi7SH6d7cWVRiXsa3pagpEcDoGiNyrBOlwS
         BGPRmfr/DkzUg47jBFHClXmQ3PJN33iZWW8PJeFfuBU+pDW88b9xKsIACAeMPjNJdyKS
         AHswnZPqe4p3XoZfyBX07tBA0mKbM5vf4sBjtzNW8P2EB1Xol14pvMtsJfd/FLclhKOm
         17um0sRIDxFv0weKOH8Jr0prH6hLCZi8VqZuwt7kuerDJNbaRdOW7Wq4yLfYDpbxZkyz
         1mCnKh2roLlkFKgTVgFJhPvd99gQFpP9EjS0yN/wPTcuTfcVE3Llsg/p9kHDJAJ2ajfJ
         /Z3w==
X-Gm-Message-State: AOJu0YyE7HanIp93+sfLCf0LzCuHLGvX+nMxfUqmP/QNDrqos3o4sG9T
	p/HXahHm12rN/bSrzYnNWPKOOekaZ+yjdYh2CNftrZV7J4RVj5ztMRsFHmJY4c0=
X-Google-Smtp-Source: AGHT+IFKJ5JzIQYT07scGs0jeluh6Z6hoVdJotYx/+32TFQ6MXa9NX+X/ooKaL8xLirc0Yw4l/nAzg==
X-Received: by 2002:aa7:c40b:0:b0:559:ca4e:d817 with SMTP id j11-20020aa7c40b000000b00559ca4ed817mr1564880edq.73.1706082334623;
        Tue, 23 Jan 2024 23:45:34 -0800 (PST)
Received: from krzk-bin.. ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id c4-20020a056402100400b0055c8a30152bsm1306951edu.83.2024.01.23.23.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 23:45:34 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org,
	linux-arm-msm@vger.kernel.org,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 1/6] of: Add of_phandle_args_equal() helper
Date: Wed, 24 Jan 2024 08:45:22 +0100
Message-Id: <20240124074527.48869-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240124074527.48869-1-krzysztof.kozlowski@linaro.org>
References: <20240124074527.48869-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a helper comparing two "struct of_phandle_args" to avoid
reinventing the wheel.

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

Dependency of cpufreq and reset change.
---
 include/linux/of.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/linux/of.h b/include/linux/of.h
index 6a9ddf20e79a..85bcc05b278d 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -1065,6 +1065,22 @@ static inline int of_parse_phandle_with_optional_args(const struct device_node *
 					    0, index, out_args);
 }
 
+/**
+ * of_phandle_args_equal() - Compare two of_phandle_args
+ * @a1:		First of_phandle_args to compare
+ * @a2:		Second of_phandle_args to compare
+ *
+ * Return: True if a1 and a2 are the same (same node pointer, same phandle
+ * args), false otherwise.
+ */
+static inline bool of_phandle_args_equal(const struct of_phandle_args *a1,
+					 const struct of_phandle_args *a2)
+{
+	return a1->np == a2->np &&
+	       a1->args_count == a2->args_count &&
+	       !memcmp(a1->args, a2->args, sizeof(a1->args[0]) * a1->args_count);
+}
+
 /**
  * of_property_count_u8_elems - Count the number of u8 elements in a property
  *
-- 
2.34.1


