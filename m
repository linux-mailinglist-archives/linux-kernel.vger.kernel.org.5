Return-Path: <linux-kernel+bounces-35430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C99448390F3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:14:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 087621C23149
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249CC5FDCD;
	Tue, 23 Jan 2024 14:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IIuQUuVU"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5FE5FBAA
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 14:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706019221; cv=none; b=RfTFufJSGwpjgEtrEkyqMFcq+c67V0qFksop2BKXUxEnCb3wBFAqThhDW3uGUbs1EhqFczYM52AhPVTSFtHki34/leEexiM9WHowtJ2xlCFZLQDvG7ePL17c8Vw6FKNTwVZBqWHMZio28j/Pwi7bdaXE9MGfw3AIaXYKSNPoohM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706019221; c=relaxed/simple;
	bh=GaifTXwjrtPwYGxIjA7saixKCJ2NePne3qXb4RkB2PA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XEOntjuwPrEHGtAAyqzpoTVU8BVJntpW/1hjUMKiJsj9QNE3HLsqXyM0U+paFUtXLY218cSC8KBd6m3arryFPkz9gVy57mypOivpf/nC8Ni3OwLJS8AojBE1Qb/xHEwBVwctn35STBONJQGtZuL3Gm0jWWFxvpi4MJ4FrsiNDvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IIuQUuVU; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-336c5b5c163so2679540f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 06:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706019218; x=1706624018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bb9ozaaEJGm3+iYRaS/Eou91hz/HW8vlq47gXO46/QQ=;
        b=IIuQUuVUr2OZ7hVdwW8CGYEMrIDSS5wOvdlkDFzjWGIvbAwvHjBfO+qu/DMe7w352w
         ItK1CFlwh9pS8URQmVx4Bbhz14m60bRGGMBj5CxpwGO5Am5A+DvLrq20bSCOvsaHpkBs
         bCO6Y1eqbdLQtqA8jzQB/BqZCPESTgOe7Fc4gxaCz+v9viyFGOGMmT7Oa+4LN+Rs7Xk6
         T1AkKsJnfGZUrmuil4AMIgfgbxZONnHWqh4pyTV2+YJifsddTPXBjXcNRYPnCXwkewdp
         EOjA9cO/51qqB7BmkS0/9V800OZvhoseLY/bmo9WtxMKrfbTCYGCoLH6SQMgNdpIC+Bt
         1Y1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706019218; x=1706624018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bb9ozaaEJGm3+iYRaS/Eou91hz/HW8vlq47gXO46/QQ=;
        b=W91VwaULZw1pEzDzRPCeTaeYNGMC6CtTjm/qyL0yB1MZbUj3iIbmDDvB61FkCyT8xh
         mDc+VAx0kWrsiKX75L82dYtaoqBGlObEzxfXjpyJLyzd0I7BCM0A9cD7ZOeTcNXLIlgk
         5U6DR4KQv03AlzVbHDJaq5cvthKQtbFrIeAGtZ7U/NkPfKjzRcnOTQyZEboSU1QypZaN
         EyiPVQS2MC8b2KAWuP5yvEYfRKN27m63EUCKXrPRTysgdwhVNAQgx5C2NjehWoISUfxA
         Bdz0B8+snT9S2hh19dYZpSaH/71TdTaPQKef6m4nrASRKIXHxKYQTuDPziVnSQHvYP3a
         q5Dg==
X-Gm-Message-State: AOJu0YyG0vqgfo3DuXzGnkXPq9cCP+1TCaAVZLOwnBHN5tnWPqbIW3wu
	8fmC6PZ/yMD4BlKt/f/y/rmJcQzHyztUcmZgZ8RRKKG6bIPeTL7pWBHip3cT9hOH3goQF5XzLmg
	d
X-Google-Smtp-Source: AGHT+IGTxU9A6hZE3T/GfJ3iQs+U7hHMUT7YMZ5antPynbwk/2dJ9MwRblLpOb1YR4bjPYZyBsdj2g==
X-Received: by 2002:a5d:5602:0:b0:337:c097:db99 with SMTP id l2-20020a5d5602000000b00337c097db99mr3351685wrv.21.1706019218190;
        Tue, 23 Jan 2024 06:13:38 -0800 (PST)
Received: from krzk-bin.. ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id r8-20020adfe688000000b00337d97338b0sm12132298wrm.76.2024.01.23.06.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 06:13:37 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
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
	linux-arm-msm@vger.kernel.org,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 2/6] cpufreq: do not open-code of_phandle_args_equal()
Date: Tue, 23 Jan 2024 15:13:07 +0100
Message-Id: <20240123141311.220505-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240123141311.220505-1-krzysztof.kozlowski@linaro.org>
References: <20240123141311.220505-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use newly added of_phandle_args_equal() helper to compare two
of_phandle_args.

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


