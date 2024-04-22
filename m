Return-Path: <linux-kernel+bounces-154098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16EBC8AD761
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 00:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA4061F216A2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 22:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB15B208C7;
	Mon, 22 Apr 2024 22:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VFoVgftj"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D4810A20
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 22:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713825706; cv=none; b=DPQ8KPlHtD8wHCO89M7NVhHzSBRb/4nleMM/eaJBsNpjm42VekzbLnxqnCSAC+kvBmFb+3yCOCTDkDJcNGKbMxPAsYglV3K94ZPdmvHsUO3U5fbYJqsME9vfydIN6doJSpl5BErWcagJE6qkUCImu8dOHud9u5Sg1/onO6F0u+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713825706; c=relaxed/simple;
	bh=bpJByZixBCRheOe1LQePKtccXwEXtNPwadWoBCKZbsM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To; b=Yehu4LeLMFT6eQC5tQTvzkgl7O4PV9/G3UWlV3DTXt/Vuoxu0eb/ox6b5CxjC9bXx4WS8oKf/diLgaI5CYsjeqYV6c7lqhQBcpIHDYZe0UQi8yK95e3olI6cQeK6zVsQ28lKYbB9G3b0lpgNKpcPh3YkKdN3rHXkBCSERQi+Lgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VFoVgftj; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-51abf1a9332so4804972e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 15:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713825702; x=1714430502; darn=vger.kernel.org;
        h=to:content-transfer-encoding:mime-version:message-id:date:subject
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=DnA8X22i2kJ7S49+cOC1P/59QG3FgetaGzDVYWU9k2U=;
        b=VFoVgftjILaoKVEtCnqEtMxKKjCmV1hIZxHRGT5195NM5A65IbJUtiWGTOrZURfkju
         oJ8C5bc53ydqbgka5J0RzrvuSeSxA9LNtf5dUxu4OtWItkT/sC9L0Cv4QdnnQyviEc4/
         XpVti1qvwNgwxbnbVA+LX4Fsr8B+ZtCHfVpq+jZOM9xi6s2d5huTzvvIjwVxhVCWgL2Z
         nPm0hYHAv61ckN4tPFcMCJLNhGzDPlN5xY+YbeXBGJTEsXFjwsRPSs9MC0XtaGyy6I6C
         aaHAmuqcYnKdlioLUnX4hew0ErEzL2mILaD/MaCgBAm1NvHKvOzTQWhQWvtzlLsu/kxV
         hlFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713825702; x=1714430502;
        h=to:content-transfer-encoding:mime-version:message-id:date:subject
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DnA8X22i2kJ7S49+cOC1P/59QG3FgetaGzDVYWU9k2U=;
        b=Vimlxt2eZUCYkllQlOhsuq2pNZDQu4pEDfIbb/O3DFQ6/A0PQVGaYrRn3yc/tTvTdE
         xil3Dx9acZ3mDinbSwUtw8apVNR4reeSrs1BTy/vmkkXezCyEWf3TXfw0QeX2WnJfGEO
         mawwTnEVH6yp48CtW6TpXBFYNwDamUnkDHXUKZyYG60GwmpgIm13HRMWDMBlBMVU4fdd
         vdfPPyBSba5grfv9FcvMrwk0buzDyO75/rZ7SyykpqDwRH9IjVcCFtYXDtgI6DzPZgGE
         nKiFXw9QaN1sqqip4RFNScoDBI1GFBT+gnCWoZeuAV7qAKH+zJp1qKcH2+Mm9BaovHT0
         YLWw==
X-Gm-Message-State: AOJu0YzV8mYW/BTsYK++91AAz8ulQpsmTZyO4bVAO5QnQf2/38DB9T9W
	8+RqCUsKWmlw7I4WLmLoYWEtwlP0N1RaitfrVRiutfjzexzpm2KSdDvxnheOaPI=
X-Google-Smtp-Source: AGHT+IFr3ze2L9UOXRY+Ko4np4lZ/ON/DU81SEnl00esnQMAOqb2JOt/nReNl7j6SqU9SDgseEwR1w==
X-Received: by 2002:ac2:5de9:0:b0:518:d829:4bae with SMTP id z9-20020ac25de9000000b00518d8294baemr6813728lfq.32.1713825702513;
        Mon, 22 Apr 2024 15:41:42 -0700 (PDT)
Received: from [127.0.1.1] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id q24-20020ac246f8000000b005130ece9099sm1829517lfo.277.2024.04.22.15.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 15:41:42 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH 0/2] Adreno MAINTAINERS modifications
Date: Tue, 23 Apr 2024 00:41:30 +0200
Message-Id: <20240423-topic-adreno_maintainers-v1-0-21e1adac2c13@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJvnJmYC/x2MMQqAMAwAvyKZLdRYUfyKiNQ2agZbSUUE8e8Wh
 xtuuHsgkTAl6IsHhC5OHEOWqizAbTaspNhnB9RotMFanfFgp6wXCnHaLYczQ5KU8YjazbZtqIO
 cH0IL3/96GN/3A+uQsOZqAAAA
To: linux-kernel@vger.kernel.org, Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 freedreno@lists.freedesktop.org, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.14-dev

Separate out Adreno from the rest of the drm/msm driver, add myself
as a reviewer for the former.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (2):
      MAINTAINERS: Add a separate entry for Qualcomm Adreno GPU drivers
      MAINTAINERS: Add Konrad Dybcio as a reviewer for the Adreno driver

 MAINTAINERS | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)
---
base-commit: 6bd343537461b57f3efe5dfc5fc193a232dfef1e
change-id: 20240423-topic-adreno_maintainers-4d220cba75e8

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>


