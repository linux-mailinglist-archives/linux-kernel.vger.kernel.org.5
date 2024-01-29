Return-Path: <linux-kernel+bounces-42639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E321840436
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 12:52:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA6B9285F20
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 11:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45250604A4;
	Mon, 29 Jan 2024 11:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yh56MIvr"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D09F5D8FE
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 11:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706529147; cv=none; b=oNq9JrslCWUNsBBrhMP9zlAcWstrjuH4/PejigdFBuzrnEaT1HUW0o4HXN1r4EFExsCOm9uVRyhgEB6Dh2PLq4lbV4c4ukWbdUszhop7MQih1uEbmfTAA8OzgNlnWsg3xqOKW6nDMuJ9YwLReiwSkuzAZX1rCDEYIEd7SoKf1J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706529147; c=relaxed/simple;
	bh=pEaaZzWd53CrhjsWjih79Gm0lLf84UYwD3xSD5zEQj4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fy39xIWdtJNk/fZLxuXQZQeuM9cREmq/AxaLVUCrCEq8xCegVxex8EEGXzLyhX/msdtdDb4REiDO+Mirg+GRX3ZeXAuxTlhwdcs5UCBqgTB7YaUY2mXhu9oHeKacuYWcum+GpczlKJp0oIsvZBtA5gqeBj5WTWjQ++VHLtQEZSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yh56MIvr; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-55ee686b5d5so1449486a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 03:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706529142; x=1707133942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7u11vGwKEs3fH7gtNpJv3ew33Q7fXCEnCXNY0GONseQ=;
        b=yh56MIvrIsDDIDVRv+XbFPR1vq7DFcZr2EVOcMGSm8H5VBpT+4FLwgMKgbreCl94KO
         4+kllBcnF8Tsd/Z7TOsH5z8zzbD4FWMfWiNXja/DLdcEfku4uvC0ldYaRIsBQnfo1Gy/
         5nzJdHCiRfZ8vXCkwv5QuKhz89AoZ7KLKzGn857jrjih/EOfLQ4MUeCUWhasUfvDSPvb
         NsdAVSnnjVHjTVwyl6Aj7h8JFbeUGv9hEBae0urfW90XUQ/Pc7ybAZ2EYeqcBh5WH0rc
         BUxLbc5/yWEZNypMX3EM3sF5x48DAMh74kk8wLIxuESZlSgOetYf92PXnYlJHC7sGQp4
         sVmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706529142; x=1707133942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7u11vGwKEs3fH7gtNpJv3ew33Q7fXCEnCXNY0GONseQ=;
        b=iYOpEXKezwSUcnmg/KfPQFlxwnsA0oZZER17bmT94j0UZtlUa5fgcyswqja4LiibTr
         m7vvF1VI+yKNgxrcg/LBr8sJ6OE/BntClwpF0SeAUgygx9O13BXyQWWEZ3z8HFkfGpn6
         77DKt6hK2kq7gBvUOZLKgz42h15/kbvVQMR5lIUxe8henbG0TtREaKMpRDxoFD6lf47A
         Eex9st56u/xDcjuKyFfM+bCHG3wiJkdR/l5lvYjpUrsfZoJ9QC75YEtt26fji2XLmsuN
         CKQyTU/Xh19CwhnNygZqmSBmg7f7DEjvRciuLxaXFwwA9CZBGdDV2MIrxsPV0izWkO3V
         dxag==
X-Gm-Message-State: AOJu0YzLT9tzzki1vRUqVShGO8vwHPbj7o1h+OwapeFPBsFWzio4ZTCk
	/Iajo/2j9IZ7/5yXBL38al9L5YjX/gx85dRLEsXbSFG7iRxwDADQhJgveZJUACM=
X-Google-Smtp-Source: AGHT+IFmy3sCvOF6JNQB/p5p+/mn9vblRl4lD4OGfVKlB3WcdWBRMAzyMpmnKg1BqnvigRA+MvIHwg==
X-Received: by 2002:a05:6402:274b:b0:55e:f866:30dd with SMTP id z11-20020a056402274b00b0055ef86630ddmr2119525edd.12.1706529142419;
        Mon, 29 Jan 2024 03:52:22 -0800 (PST)
Received: from krzk-bin.. ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id ec19-20020a0564020d5300b0055f29ececeasm19907edb.57.2024.01.29.03.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 03:52:21 -0800 (PST)
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
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Rob Herring <robh@kernel.org>
Subject: [PATCH v6 1/6] of: Add of_phandle_args_equal() helper
Date: Mon, 29 Jan 2024 12:52:11 +0100
Message-Id: <20240129115216.96479-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129115216.96479-1-krzysztof.kozlowski@linaro.org>
References: <20240129115216.96479-1-krzysztof.kozlowski@linaro.org>
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
Acked-by: Rob Herring <robh@kernel.org>
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


