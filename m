Return-Path: <linux-kernel+bounces-59995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB2284FE52
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 22:13:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3090BB29DC6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 21:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720AC3A8E6;
	Fri,  9 Feb 2024 21:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rIOCa3FN"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F1A199D6
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 21:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707512999; cv=none; b=AIvAeUwSq5K8VGCok6HzJSaIo8bLnwxtD1PiOJagIBHtpfm15LIFbkHdwVHeWVoonWfnkk+YFXahMJqT8T7ARn2K2lAtRbrdfrHExnqFH8ChPLhKjRhLGmXMwu33B1UJoBvq3BdDyvHjNVYmtv3GFLqYBfuw3d/E4d/WqBMhFRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707512999; c=relaxed/simple;
	bh=3dtrntbOogwjknLFZqca+wBqcS9QWbQOd9iEEJQfOvA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DfC5hHKabaHdGdaZ2OhUd035JQKKmlX0cjRSlT9UeRmxWmkUSP/usFRoOfDq9BoHVTu7w+fi+895nBB1mLWEIkk0qFNWRimUAasnK7yhJ2vEdnsYNaf+OLvqftR2fbYxSh4wY5j0z5BuzF+zCd2/lQXFLY2IhNksA05uGLJKNew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rIOCa3FN; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-56001b47285so1937217a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 13:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707512996; x=1708117796; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AK+SsOpDJXwjdmEkPZAy2mx09ivoS/IARlVKsNVFoYA=;
        b=rIOCa3FNdNrVbpHo30DQbDAzLFeRuRBrY9FZvar1nCu+M3ZF5OOO6axwxVia8pOczF
         CLILcUlZ8NsooyGQvWI7gtJoz4WQbNNsH1kAQTPxTbyVlEQ+EyI4eBTCE8633J+23/bi
         FbZQwXYk3trULXdzPS8OphdZCZT8aswpdCEBxt3BLeEm+Aa+uyz0EBJpTP+G56ehBPmy
         OzefBJiPFmLkD1V4nIEsvkZsw93O8gK1KncKR5nJCVni23Uz53E1s7c2xwPOhoqhZG1H
         Lmd4lZH6hNG/C10zl+D7RB7bcw30rNNxoumd50GRVhSsXL4fQx5ngAkjxwBWDUCHKBYr
         x1lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707512996; x=1708117796;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AK+SsOpDJXwjdmEkPZAy2mx09ivoS/IARlVKsNVFoYA=;
        b=NlCa+bbJ3JUk7VbJBWAspDxSDMX+ki14MUlHkujJowdXhlXlEovyZHTbLuUiCeRbaK
         Q7yd8oiTgCuASc29vara/LBYyHL3dLDkjpKqwoXXhvaE8kGTfRf9RfBadm0gzh4Da7Ra
         BrjSoM0j1EdVUaBBWOPp+uOS7ej3bqh5lADu6K3NofOW7pfxGJm1itVbQ6T5gBhT6+dS
         +KKhmBfAP42iem5hOn5WhrZSry0A4BVFwF6g1q3BS+behJ8YBHgBpZJ3L1kjs6FGdgaK
         B9yTtUipTPDR1PJiNPDvjeRs2WAkCybP3GvW+1YS9W0A97+uqqBnabR3Ow1GImgYYbFv
         gdvg==
X-Forwarded-Encrypted: i=1; AJvYcCVRuZrkNCX23sZx8vc7CJIrXW3lnblbUP+oG8uEFcrcIbVnq/x8N8RmIlIBPNij45a7bxgLtILUpdhTVdtydJ+/xhnurxxgVivbg0cD
X-Gm-Message-State: AOJu0YyZOlZ7bZSZUFFGbHX+sGDEzUPwBJyNOEYJFvI7mkqb4xlrXNb6
	sXFSu3CgIGLEGLpUDRaT2pBw2N3KFcQ+1Ww+Cd/mQbjmai7mRh0GVaUD3scaISc=
X-Google-Smtp-Source: AGHT+IHcGl9JHJqOe5VmdQ7VeXCk54tJsLRobhhO7hKVsXdIqB+9dtCWHyxR0NIAJY7xkg0o+FUGxQ==
X-Received: by 2002:a17:906:af94:b0:a38:1938:3d41 with SMTP id mj20-20020a170906af9400b00a3819383d41mr189889ejb.10.1707512996410;
        Fri, 09 Feb 2024 13:09:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV7yR6qZYcLxMBFDCwovXqEY+5tzDFTiFCuF97xuBkVj2p/H9HKYNngM33WBfc13n9vtJD7IfZtdZrhoiJQ42U3KGXh0WwxyQl0pYiAQW2AOggDtknGTPABl0wpdBu8CBxgyUGYRw9uK99xhZO6wVUH4UKRZM4z1BbJE3GPxC8CihdoLXfoUsoIb21+rjdCJjDj2p+YowtrWSjK0cX/mikxvSVIHA/jHOqwOeJ0/ld6iDCGG9PUOncIgEm6HricqdHhhonjlBVPpyzV79q/M9Xmo+q4hdkprUAopGoQNxwic1GySl9bUeyxVtSuVuGyjpkKZiChcjhAAfE+CrwZokvkabm+8CGp+Q6fEgmj4MSxgWpeacUL9ZFh1DpAPSVGHxoWEFkNmiswfeC+hs+AS87KPKyGrSYhYsWxNrpg0PdlE8crwdI2aWYt6/VXxpkn3+jTePc68hz/1zMgjaHlHECFv6JZEdTNJwHTsvlbPkHZXVjX3FtkjOdpc9oDLBMPybjI3Q==
Received: from [10.167.154.1] (037008245233.garwolin.vectranet.pl. [37.8.245.233])
        by smtp.gmail.com with ESMTPSA id vo5-20020a170907a80500b00a3be3b27d0bsm1056517ejc.49.2024.02.09.13.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 13:09:55 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Fri, 09 Feb 2024 22:09:49 +0100
Subject: [PATCH v2 05/20] media: venus: pm_helpers: Kill dead code
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230911-topic-mars-v2-5-3dac84b88c4b@linaro.org>
References: <20230911-topic-mars-v2-0-3dac84b88c4b@linaro.org>
In-Reply-To: <20230911-topic-mars-v2-0-3dac84b88c4b@linaro.org>
To: Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, 
 Vikash Garodia <quic_vgarodia@quicinc.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Dikshita Agarwal <quic_dikshita@quicinc.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 Stanimir Varbanov <stanimir.varbanov@linaro.org>, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
 linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707512985; l=1555;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=3dtrntbOogwjknLFZqca+wBqcS9QWbQOd9iEEJQfOvA=;
 b=oh5FZnz1G42Z7kWhiKa1BU+f/0l6PypNRePBfJONaCzYzRLoGiiAaxtCapT8+vTs2EweuC6lZ
 PlUS6YMzmQLC4SkVj5CuP5XX713SshpGMNA9dXY4b2/tOQrSWSBrAzx
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

A situation like:

if (!foo)
	goto bar;

for (i = 0; i < foo; i++)
	...1...

bar:
	...2...

is totally identical to:

for (i = 0; i < 0; i++) // === if (0)
	...1...

..2...

Get rid of such boilerplate.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/media/platform/qcom/venus/pm_helpers.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/pm_helpers.c b/drivers/media/platform/qcom/venus/pm_helpers.c
index 1ba65345a5e2..7193075e8c04 100644
--- a/drivers/media/platform/qcom/venus/pm_helpers.c
+++ b/drivers/media/platform/qcom/venus/pm_helpers.c
@@ -878,14 +878,10 @@ static int vcodec_domains_get(struct venus_core *core)
 		.pd_flags = PD_FLAG_NO_DEV_LINK,
 	};
 
-	if (!res->vcodec_pmdomains_num)
-		goto skip_pmdomains;
-
 	ret = dev_pm_domain_attach_list(dev, &vcodec_data, &core->pmdomains);
 	if (ret < 0)
 		return ret;
 
-skip_pmdomains:
 	if (!core->res->opp_pmdomain)
 		return 0;
 
@@ -928,9 +924,6 @@ static int core_resets_reset(struct venus_core *core)
 	unsigned int i;
 	int ret;
 
-	if (!res->resets_num)
-		return 0;
-
 	for (i = 0; i < res->resets_num; i++) {
 		ret = reset_control_assert(core->resets[i]);
 		if (ret)
@@ -953,9 +946,6 @@ static int core_resets_get(struct venus_core *core)
 	unsigned int i;
 	int ret;
 
-	if (!res->resets_num)
-		return 0;
-
 	for (i = 0; i < res->resets_num; i++) {
 		core->resets[i] =
 			devm_reset_control_get_exclusive(dev, res->resets[i]);

-- 
2.43.0


