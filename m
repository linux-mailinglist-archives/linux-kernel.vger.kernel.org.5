Return-Path: <linux-kernel+bounces-53226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3604584A25A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:32:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0F92289193
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B658537E3;
	Mon,  5 Feb 2024 18:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="wSR/DTec"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E95751016
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 18:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707157711; cv=none; b=ruikSe6xkBjrlfPa5dPB04qwlf2vrMpS2nzNbhzOtIuc4+vcd/RmbtTgFZrPdfDMRUVBF864eAnJCWTzJ6Nl7XOTezeEU3xP6VJd2zJRylZyg3E36oMQNNMK31nvz4hbGaYXE+woM+LFa5NpW+YF4DxKsFdUflU3l4GpQwRiKbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707157711; c=relaxed/simple;
	bh=WIOe11Ytzyo9Yq0ljywUwZYIxYsyWX7ldWgffEttovw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KK0xRZYCsslWkWxBJXPhNW6Dt+5XDxLHSaHyxek5zbSUUseL5o5i76DtzvYoxhKwXdhzf8tn5OCXhfVsJK/6YPN8sisAW+X7pfnJFkC+v43XhXmMPwwq7/E6/1QK1Nbgv73fxKlcp/Ddx2vvEx4nnbjarPE05HY0IctQP6zuEfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=wSR/DTec; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33b0e5d1e89so3767854f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 10:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1707157708; x=1707762508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s0oEOKGcE5RDVKHJLOO6pZt7g+TRP+w7zOsv5ctScyA=;
        b=wSR/DTecwoCltXHtRXb3dgLeHfULEHfW/eJPJ1QVSX5hOGFzRQ5d3WhENXBF103pJG
         PAryWg57OSUCkjUo3rMdem9F1BwEY3jQiOZVj8PyKKO7lRBG3EVsu2I1vYZo2Qp1zPul
         s69RJWuHQH36Pp+fqUGmH0HnXx2Z0dYq5EAi32GMDq8Kp1aTZwxFzO3QR2MhBAjeBvsX
         y9HXNDifadFcLrQ/mNZR0BcCC1OExGuugD5otJfwWnBCZ0fPs2JDdAPTa7I0m5zUuCAT
         JGW7hu53qJyrNlJPQN8Nhhsc+ihKnv0XfGgikvPUONp/X9RWUZGWPxANvSUAMrp/PVFR
         BCKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707157708; x=1707762508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s0oEOKGcE5RDVKHJLOO6pZt7g+TRP+w7zOsv5ctScyA=;
        b=STYt/zcV9weILZZHcQVIY7gYrAHkQDx/Z/vcGz4Yf2E1FjtDz8j2jKOQi+w/Om9ykW
         yaU9LcZh5kxhKxiSD6UsSWQNPfvv1rzJS813tpmBUM8SUXbi7D7nvTDcsIcLE0GCDtvl
         SHnELbzh6jnL0X9+QoPO11Hc8DoNgsy6FU5cajSX/m9MqS0omyQw4nclMxiD38ttBoJp
         9A6S7vthIcr+d04mKYBUnv4L9Ue3FQPhsAjWHHY/dLEtZcY56VjOvZaOGsXi1wlftmCa
         fcIA/00p2k3mSTaFQc8sTUrvsJOokdQA0E7hU/hMwI3ceUvnG+pzjf3OCWj6sMn+xTeu
         r7/A==
X-Gm-Message-State: AOJu0YwLllwoVT3hWlczctzL0M+zGihr1HqphPgkrX4Rdqzpr0VkLu1Y
	KQPqXT6xKL75iHGJlayJC5vjUs2NmBq8Bm0nkTBhx6EUD60NJ+CrwKRIPfoYGwA=
X-Google-Smtp-Source: AGHT+IEbZ91ZP8juBJlYfzHEEEkyJuuPPIxG2nnGFJhu1M+wrdILW9y7zEKqJcg/Y/9qH7CgyyKmsg==
X-Received: by 2002:a5d:698d:0:b0:33b:150e:627a with SMTP id g13-20020a5d698d000000b0033b150e627amr188208wru.70.1707157707812;
        Mon, 05 Feb 2024 10:28:27 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVnHR7MaTmuXNXpSFb/KHk62IruZCfaJyE2NhFVgsQ8v4ZKzkCNgdg8im2IA9UO//5RtflXbuaSbXfQjUOQ5Nc7rhtR/h92SOavahh3Oy/2YUvp5I3STFKS4SciONT37cPKIEXbTV3GqNEeGm/gClTT70BbN/vQ1U0oLciPqqHlTlIPFZCnz6MUZgLC/B2RPTDI+vT7/7Q1qv5JYnxA2xGUfxstrITYjexPK0F6f47jNM5OTJW9lnV/4xO3mrfvTzs4gp/+vJOP4oqThc3gNmtcoszoV9vmnBGpXpFq84LE/W9r5YAzN549zbgJnzSpiLrpVfDib/0xyE/peP37WuCPLwD8yOGBNWDt8hoRRim78eKJSAeqDGnXqmpZTBjLI6ue3aOv1OxqLxpYIYBAT6vFVYqCbfHd3LXPLdyWCY5GS3BzDyCNEQNDKA7RRiCFz22idtO4s8FUOF8eYFQrIQCJGxif2gcfpO/wJMLW98yLnsm17vSDQ9diQsWP7Sll7S2WHuLREMkK641IQLD3IlEPtVJORaEPazIyTTSA/WAwY3p/BmwmZcAvqKTsA2gL7y4=
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:d929:10db:5b5c:b49d])
        by smtp.gmail.com with ESMTPSA id v15-20020a5d678f000000b0033b17e18df8sm203229wru.12.2024.02.05.10.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 10:28:27 -0800 (PST)
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
Subject: [PATCH v7 07/12] firmware: qcom: scm: make qcom_scm_qseecom_app_get_id() use the TZ allocator
Date: Mon,  5 Feb 2024 19:28:05 +0100
Message-Id: <20240205182810.58382-8-brgl@bgdev.pl>
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

Let's use the new TZ memory allocator to obtain a buffer for this call
instead of manually kmalloc()ing it and then mapping to physical space.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
Tested-by: Maximilian Luz <luzmaximilian@gmail.com>
Tested-by: Andrew Halaney <ahalaney@redhat.com> # sc8280xp-lenovo-thinkpad-x13s
Tested-by: Deepti Jaggi <quic_djaggi@quicinc.com> #sa8775p-ride
Reviewed-by: Elliot Berman <quic_eberman@quicinc.com>
---
 drivers/firmware/qcom/qcom_scm.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index 11638daa2fe5..3a6cefb4eb2e 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -1525,37 +1525,27 @@ int qcom_scm_qseecom_app_get_id(const char *app_name, u32 *app_id)
 	unsigned long app_name_len = strlen(app_name);
 	struct qcom_scm_desc desc = {};
 	struct qcom_scm_qseecom_resp res = {};
-	dma_addr_t name_buf_phys;
-	char *name_buf;
 	int status;
 
 	if (app_name_len >= name_buf_size)
 		return -EINVAL;
 
-	name_buf = kzalloc(name_buf_size, GFP_KERNEL);
+	char *name_buf __free(qcom_tzmem) = qcom_tzmem_alloc(__scm->mempool,
+							     name_buf_size,
+							     GFP_KERNEL);
 	if (!name_buf)
 		return -ENOMEM;
 
 	memcpy(name_buf, app_name, app_name_len);
 
-	name_buf_phys = dma_map_single(__scm->dev, name_buf, name_buf_size, DMA_TO_DEVICE);
-	status = dma_mapping_error(__scm->dev, name_buf_phys);
-	if (status) {
-		kfree(name_buf);
-		dev_err(__scm->dev, "qseecom: failed to map dma address\n");
-		return status;
-	}
-
 	desc.owner = QSEECOM_TZ_OWNER_QSEE_OS;
 	desc.svc = QSEECOM_TZ_SVC_APP_MGR;
 	desc.cmd = QSEECOM_TZ_CMD_APP_LOOKUP;
 	desc.arginfo = QCOM_SCM_ARGS(2, QCOM_SCM_RW, QCOM_SCM_VAL);
-	desc.args[0] = name_buf_phys;
+	desc.args[0] = qcom_tzmem_to_phys(name_buf);
 	desc.args[1] = app_name_len;
 
 	status = qcom_scm_qseecom_call(&desc, &res);
-	dma_unmap_single(__scm->dev, name_buf_phys, name_buf_size, DMA_TO_DEVICE);
-	kfree(name_buf);
 
 	if (status)
 		return status;
-- 
2.40.1


