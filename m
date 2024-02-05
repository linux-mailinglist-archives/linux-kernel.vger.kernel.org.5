Return-Path: <linux-kernel+bounces-53230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC8484A261
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC9CF1F2523F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A16255E6E;
	Mon,  5 Feb 2024 18:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="XTF2JKzE"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0C853E34
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 18:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707157715; cv=none; b=E623Utd/xV4A2x/9BsCp5ai1buS+2OMilKE3/dOKjNplqlHfDkjEzDogQlt7EzI7pYl7LXueJfB5cp3Q5A+jmZUIZYwtLATSIrxlJ/4eeMGVzIzJc4DTudFp79vqaI+GhCAU+Y2s+kmm5qb7d3Llg6h4IQxtR52e+Y/+bUVHHWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707157715; c=relaxed/simple;
	bh=hmzNAsxjSvJ+4PERnPRzpDN6FX4/4anLfvTfR4Y4+GU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nOaVSOrlWdNUrIT+OyravuyLvNXpTu1mbG4+jlXDNtAqGgcnipyCxjiV0A/CK5HcNrcK1SSh/RK5QwK4sZyw+1uLVxQ1Ka7uBJJhFeT+7YwKjQ8xFQrfnQ2LQ2zSuXhfbnk+P+x6xBDVvDD67xSNBMkRe/8PmAC9TRospz7DtIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=XTF2JKzE; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-33aeb088324so3531496f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 10:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1707157712; x=1707762512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I7SHOJjWn4ajTNVMkc896KlcCL3KSTkPo3OUGdVQzNA=;
        b=XTF2JKzE+ectJpW8rTUizvEImhGTb3Xk9yscz1AT08hy102xRy+enVPwTNWAO/eIcQ
         cQx9KGcZD687lVDHHLG5iISGIaogH6SmkEAYyRqriOpPLmZ9Cq/icm2sz6TyjdCsNghj
         rrNg0UTqz71mnF1/WbLrjMgFG+8htPRXgzmEg3i9owJ3KMjIqUiyKiIu8qaX17WWqeG/
         5j6BafD5wjPJl/48h60kGi1PTTsJRromgRbi3ISLfUsrBsj6KE475ZJm4RaW4+SmQo9c
         sySJrSvXPFouRyajX4koTS51rq2yeYQitk9E3hH5cm9gPH1r4eEZp1CkzxKXcVbKY7HN
         jBlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707157712; x=1707762512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I7SHOJjWn4ajTNVMkc896KlcCL3KSTkPo3OUGdVQzNA=;
        b=XNKJ6Hz9zNfYrEs8oLvXhPf4lwta5t/dcSXBO/OR8yEliQ7OdBFZzvcFPPKz6479pG
         O+XXABZKlIHi7+wUvxJlE4nGGINWVUto6LoLme8SqZjkSy7DT9faZE9PSidUGa83jKPY
         LWXjIvf2fPkBpbLDUzUGNHqvCK4EwVZxI95O35GeyLetZVlMwWGM9dJRSg6n1hQnjCDc
         N4TV6fMfwrddCGS2HuVaZOAXlsTkhMqQCzMYZpwRHv9uYX6oFezqEiTHhFu/sF4khfqa
         kyu+kDV36HJNPyL7qi6TgBOTsOrOmF+QrZaveK6e3AlmCFBkoi+W0EaClmeQV5RWAEMN
         B+vg==
X-Gm-Message-State: AOJu0YyzRqo5ZwL+sZ97DURM40zVeKDGRkLjP0wCy0YySmIqQe2p9L1d
	q+JNr9hLtzl5DHrVpU3DY79tGGVxA3gHu8WdOlG59ZcktfWrwgYZNaj91lr7hw4=
X-Google-Smtp-Source: AGHT+IHdz/8C3w++G3TtxRyJjaTTNdLu+sTaVnsD4pE65MfKIdmPxliBIwgVedipoXEPhMJto4XEeg==
X-Received: by 2002:a5d:44c4:0:b0:33b:2884:edf2 with SMTP id z4-20020a5d44c4000000b0033b2884edf2mr235515wrr.56.1707157712083;
        Mon, 05 Feb 2024 10:28:32 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWFmpYMxItrm4bBmJ9+HOBf3GceWMnNDYxReZOmJvsQeVxTV8L8qfCoyq2WW8W0rkQe0S3Tp0SwVLK4x20iaG8v/aH62qitEpg2aHFmtVbe5g2QUX/uGeebRaGuZZ638Ru8/5fb54H+u97BVOzbCAlE/BiLBQCR9lPZBvPUiloZDCo/qmMWF2YUZoO3O/7nfa0vjGlWyHwxNeIDbVK93uSDykWuqFEJm4c1v6iGq6xbyMpyWQv9aOMZ+c/A20g19a13guXOt4kA3I7W2uyTbbkvWR/UrQRIV0DBySUsLA84CZI8qNyNGW5kLr6NxKfEjbXJvqjQCB5bQPL0OBOW16tMRU4r/PAwCZgkc7WrAprZ7BOP18JqTtu+pqsgC5gTuH2KoQr/wmR062h4ZUWYAfNSGfVXXcQHgnRWlS33Sp9ICZrlbGdAHN55r1IhwfKgvVPevsxbvRFxCQ21Fg5OyuHRDzPmJrE5q4Tl08XN05rzmU2Q57aUiJRCFpxK5oHg1WHpmPo9gbDXkpGyWOJz/7wmcBwP9R4YonSZxeaTEpubnKdgXynxBPxL3dBNiag141Y=
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:d929:10db:5b5c:b49d])
        by smtp.gmail.com with ESMTPSA id v15-20020a5d678f000000b0033b17e18df8sm203229wru.12.2024.02.05.10.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 10:28:31 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Elliot Berman <quic_eberman@quicinc.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Guru Das Srinagesh <quic_gurus@quicinc.com>,
	Andrew Halaney <ahalaney@redhat.com>,
	Maximilian Luz <luzmaximilian@gmail.com>,
	Alex Elder <elder@linaro.org>,
	Srini Kandagatla <srinivas.kandagatla@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@quicinc.com,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Deepti Jaggi <quic_djaggi@quicinc.com>
Subject: [PATCH v7 11/12] firmware: qcom: scm: clarify the comment in qcom_scm_pas_init_image()
Date: Mon,  5 Feb 2024 19:28:09 +0100
Message-Id: <20240205182810.58382-12-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240205182810.58382-1-brgl@bgdev.pl>
References: <20240205182810.58382-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The "memory protection" mechanism mentioned in the comment is the SHM
Bridge. This is also the reason why we do not convert this call to using
the TZ memory allocator.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Tested-by: Andrew Halaney <ahalaney@redhat.com> # sc8280xp-lenovo-thinkpad-x13s
Tested-by: Deepti Jaggi <quic_djaggi@quicinc.com> #sa8775p-ride
Reviewed-by: Elliot Berman <quic_eberman@quicinc.com>
---
 drivers/firmware/qcom/qcom_scm.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index 839773270a21..7ba5cff6e4e7 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -563,9 +563,13 @@ int qcom_scm_pas_init_image(u32 peripheral, const void *metadata, size_t size,
 	struct qcom_scm_res res;
 
 	/*
-	 * During the scm call memory protection will be enabled for the meta
-	 * data blob, so make sure it's physically contiguous, 4K aligned and
-	 * non-cachable to avoid XPU violations.
+	 * During the SCM call the hypervisor will make the buffer containing
+	 * the program data into an SHM Bridge. This is why we exceptionally
+	 * must not use the TrustZone memory allocator here as - depending on
+	 * Kconfig - it may already use the SHM Bridge mechanism internally.
+	 *
+	 * If we pass a buffer that is already part of an SHM Bridge to this
+	 * call, it will fail.
 	 */
 	mdata_buf = dma_alloc_coherent(__scm->dev, size, &mdata_phys,
 				       GFP_KERNEL);
-- 
2.40.1


