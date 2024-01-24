Return-Path: <linux-kernel+bounces-36584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8640A83A367
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 08:46:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2636A1F26853
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 07:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47F717588;
	Wed, 24 Jan 2024 07:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zHmJ0Jkt"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC2A171D2
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 07:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706082340; cv=none; b=JNEVf6Jch2DtYA8MlVg+pF2xUhqiPMdFL/cA23IbtXG7GAEwtHXK/iJ1avdjTstYBDtU8DoSzcbt5lChV0TCWQmEoOzlXBfL9ekLmUFMna8bedG7qJaYy17UwQfdcx/n66OJNE8DTqksvyAjAbM3yxk89NLDyF7m4BfxNh2YlhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706082340; c=relaxed/simple;
	bh=sVXlhCINy91jWhZ6PsZ+NZ5hY4jMsVzvytP/1xoTcWs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BALAiccpWL/Ss5IlbWrk1UmHPw1ACAO/yGH8HVBvxEiVRpckllqi8THFqT40Ziko1XMyv3TwoHf2hRDK0HmEwwea/c9cfMDW+3e0VY1yLOZzqFmXcsZcrQFX84QMdGJBMS+iQoSH9IjlGnYuuCpbsbe35kED3I1J2oiFp2FmuS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zHmJ0Jkt; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-55a9008c185so6396746a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 23:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706082336; x=1706687136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Twb14CHQV4rxLJEwyOADsP4YgaAe6VIG5jHjsjkoYM=;
        b=zHmJ0JktUE3PC8HWNARk1Uzi5CCw6oUEOkGYIbSXWy2ecVhujkLpkGOf2yhq0nVMUc
         RTstJ45AqP3m6R0xNCZ+cCn+wOty8za8GSkaHdLX25G+eer3Sryf709WcdPGmxrCAf2A
         fpIgsidkxJGuNdUWR5go6Ah1p+LeJGv392WUBY2i/dndqSDmbmcbLrIY6qJ2NiQvAklS
         8vyo74d52ClIbc7BrQpl7FbS+l3xPESM3jEoBFwKOZE8YTVRhbKHST6dblsTo+4NcOSQ
         w2wvfncdy3jKNU9p5SoYRZ6XLfgOnBPaLrAioK68I1LLDIkdRJTdzH+Aftbbb0ZtlW7z
         IBPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706082336; x=1706687136;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Twb14CHQV4rxLJEwyOADsP4YgaAe6VIG5jHjsjkoYM=;
        b=gVqYcNVB4MEuGop7MokpeZbNM5EXL7IqQO2OrI1mQael2gS1PxR0DrG6SOcsqoDJpY
         WY0A7DQ1BlIeMhB7f+uJb2+YyaCbMMBSDY4TNWMNuAsd+iyAc7BG8pvxrHjZndIBKl/h
         I5n7ArIwgPwsyEj3d1QNr3tf1jFGpl6GmKkfe/TgQNm8pdrJsQnXMNbWftS19C+8DoSr
         VurwBkAr1KGyxbhi7VsKyc/20riqVz/V4ZSr2xcU2BobyG4n/bweQskTaLJEXlTlZXhT
         8/2QWVwYy8S7eNX6e/2Qxj+g7jji3r4kbMNHNEY/Jx+RsTNv2KwYCkcHSeD7S5UzMH0g
         kOeA==
X-Gm-Message-State: AOJu0YzTV0DTYZQjsX5MDjIojeei25d2phCkkRBUpT+5ffjXj5sbSlBL
	KrV4EdKNTL2lDZ8KVtrCuCl99FeQWEyhIu/NKG3s1F2o+RxBENQ9neomxChCQ0Q=
X-Google-Smtp-Source: AGHT+IEd7wCKPo8WkTbk0u737H/8Ow4jEXZBmtDW8b4VUySFuKLyGUxPBx1MuSzXlKRiapm7MvRwSg==
X-Received: by 2002:a05:6402:34c5:b0:55c:972e:3e97 with SMTP id w5-20020a05640234c500b0055c972e3e97mr1149526edc.3.1706082336269;
        Tue, 23 Jan 2024 23:45:36 -0800 (PST)
Received: from krzk-bin.. ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id c4-20020a056402100400b0055c8a30152bsm1306951edu.83.2024.01.23.23.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 23:45:35 -0800 (PST)
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
Subject: [PATCH v5 2/6] cpufreq: do not open-code of_phandle_args_equal()
Date: Wed, 24 Jan 2024 08:45:23 +0100
Message-Id: <20240124074527.48869-3-krzysztof.kozlowski@linaro.org>
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

Use newly added of_phandle_args_equal() helper to compare two
of_phandle_args.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

Depends on previous of change.
---
 include/linux/cpufreq.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index afda5f24d3dd..3cd06dafb04b 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -1149,8 +1149,7 @@ static inline int of_perf_domain_get_sharing_cpumask(int pcpu, const char *list_
 		if (ret < 0)
 			continue;
 
-		if (pargs->np == args.np && pargs->args_count == args.args_count &&
-		    !memcmp(pargs->args, args.args, sizeof(args.args[0]) * args.args_count))
+		if (of_phandle_args_equal(pargs, &args))
 			cpumask_set_cpu(cpu, cpumask);
 
 		of_node_put(args.np);
-- 
2.34.1


