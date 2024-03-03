Return-Path: <linux-kernel+bounces-89789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F7B86F5B1
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 16:03:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4998728734D
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 15:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1136AFA5;
	Sun,  3 Mar 2024 15:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="KA9l1gwl"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93F36A8D4
	for <linux-kernel@vger.kernel.org>; Sun,  3 Mar 2024 15:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709478096; cv=none; b=iQdsZ96DoFMtFI3uPogzoyfrnzEHUU165fq10UCmpUW6T9tFMu/nJsKK/SaXXpFOAvcgCSwPV84Zs/Yn2aTKra+xvMAYzhMWpI42Y3e4VUh1WCF756lBph6NLvlOdwmV5B3pqN5t0bV/mjpe4kYa40hrblvjjrEgkwkAQwNIOQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709478096; c=relaxed/simple;
	bh=F9bg72skBcwBiEEYZMM2hukN57hnLQZy3s4mEijYkWQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FhTm7faBldw5929tujN8kIM/Gz66rHC8Wdl9DD8oH2YQkTvw0xWujgEMOy2xpT9CnJYnc6oBaneG8exfTF2Te2uyZ0iZF+7pPKIgZTIvziX2NpZpDyCq2ITpHqtin5ANPwltoRxLWtBH0Bjfi5xTTtX9p13QIZ1wirSvvYqYOMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=KA9l1gwl; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-56715e3cfa7so1250438a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2024 07:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1709478093; x=1710082893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iX5g+V/jIoB/U2fD/Lz2zFWCo9i8AUpfaivI8I9uXqI=;
        b=KA9l1gwlYMbLA5Etcuijby5a5JbXr0VmF9ws5uben3m5fMWhYhU9Tbjkchi29RW1Qe
         ZnHxmI5BDw7LDc4Eb5ooxE5DLX3BPnae1gyIXXuV2UfkbI+Z91j68ysTguPqxroj90SX
         yj92UAdpccpjAIx1N7Y6Ji4V+Jm5SRcy7DAwjC2P768qqZhuV1ulJafBOtuVV8FPmlth
         fmweqX5rDfrmCf7oNuxtfrLsf7i/eJd71B8fV2uRP+cthfavt4ihspRk1F1u0kEx9ZSC
         ElgiNClcSS/hZAMlrh8dJYCa4Ip2ZOfKf+XzN48Jy4/FoVQbJwKGn/DWWlxOrLSc7lCv
         BcYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709478093; x=1710082893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iX5g+V/jIoB/U2fD/Lz2zFWCo9i8AUpfaivI8I9uXqI=;
        b=vL/OU9h0LKe6ROw55g67PZUFujauzvlM8Dt0p11PJgDd/GZCd1JlBeoFbePF5s6+7Q
         XdYNhmBgEHq3lxpazHw96IRi8hzjhpMRZUhH6petK1BSVZINtn3VD6Fb9EsXqR6ljjE1
         h1pILMFsSIR/hFxUjH1Jo467RBimJMx98c20MW1dm999BninjL4UsNywHwsRMQk6ung+
         SDOpzWLMjDD/dr4ELGA1i0kQX3DknWE33elAWgOLQzJzJvip3hm/87Ue7Xsu5PC3Y3F0
         HlqFppOCjcjKE73BJ3y32slXyJrSJTz07QfIbKq608gogKxmcS6bjAsvj0Ac3pqLNBM2
         qb6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXKZeIX534q+R75vmstYoh52+0225uwMYtvTx8mt86CpkT4rzprln/eVKqlagqjGQ5lVmjRJneOydSdQtHdBq8viWJ8JJyDnjIuP2DS
X-Gm-Message-State: AOJu0YyI8wVYkm2tWNPccJplVkGUMXqJUo+33A8bEYh2lfGrwniMcpzR
	MKpbxOkI0or469gxOfqx0PPZS3I5NPwGK+D5hWYbfzNeIqdVFD6ZLjPIZQkoo5I=
X-Google-Smtp-Source: AGHT+IHaFX784uguRkmMeLyP7wBdJksLN2mrMw6APcJ/cXGZXrdnmicuWEsAAPZo80PWjA0bjfx94w==
X-Received: by 2002:a17:906:780b:b0:a3f:f8a7:e1f7 with SMTP id u11-20020a170906780b00b00a3ff8a7e1f7mr5317002ejm.5.1709478092975;
        Sun, 03 Mar 2024 07:01:32 -0800 (PST)
Received: from brgl-uxlite.. ([77.241.232.10])
        by smtp.gmail.com with ESMTPSA id ch14-20020a170906c2ce00b00a42ea946917sm3740293ejb.130.2024.03.03.07.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 07:01:32 -0800 (PST)
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
Subject: [PATCH v8 10/12] firmware: qcom: tzmem: enable SHM Bridge support
Date: Sun,  3 Mar 2024 16:01:13 +0100
Message-Id: <20240303150115.133633-11-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240303150115.133633-1-brgl@bgdev.pl>
References: <20240303150115.133633-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

SHM Bridge is a safety mechanism allowing to limit the amount of memory
shared between the kernel and the TrustZone to regions explicitly marked
as such.

Add a variant of the tzmem allocator that configures the memory pools as
SHM bridges. It also enables the SHM bridge globally so non-SHM bridge
memory will no longer work with SCM calls.

If enabled at build-time, it will still be checked for availability at
run-time. If the architecture doesn't support SHM Bridge, the allocator
will fall back to the generic mode.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Tested-by: Andrew Halaney <ahalaney@redhat.com> # sc8280xp-lenovo-thinkpad-x13s
Tested-by: Deepti Jaggi <quic_djaggi@quicinc.com> #sa8775p-ride
Reviewed-by: Elliot Berman <quic_eberman@quicinc.com>
---
 drivers/firmware/qcom/Kconfig      | 10 +++++
 drivers/firmware/qcom/qcom_tzmem.c | 65 +++++++++++++++++++++++++++++-
 2 files changed, 74 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/qcom/Kconfig b/drivers/firmware/qcom/Kconfig
index 4634f8cecc7b..7f6eb4174734 100644
--- a/drivers/firmware/qcom/Kconfig
+++ b/drivers/firmware/qcom/Kconfig
@@ -28,6 +28,16 @@ config QCOM_TZMEM_MODE_GENERIC
 	  Use the generic allocator mode. The memory is page-aligned, non-cachable
 	  and physically contiguous.
 
+config QCOM_TZMEM_MODE_SHMBRIDGE
+	bool "SHM Bridge"
+	help
+	  Use Qualcomm Shared Memory Bridge. The memory has the same alignment as
+	  in the 'Generic' allocator but is also explicitly marked as an SHM Bridge
+	  buffer.
+
+	  With this selected, all buffers passed to the TrustZone must be allocated
+	  using the TZMem allocator or else the TrustZone will refuse to use them.
+
 endchoice
 
 config QCOM_SCM_DOWNLOAD_MODE_DEFAULT
diff --git a/drivers/firmware/qcom/qcom_tzmem.c b/drivers/firmware/qcom/qcom_tzmem.c
index 23f364afa6ca..244615e8c505 100644
--- a/drivers/firmware/qcom/qcom_tzmem.c
+++ b/drivers/firmware/qcom/qcom_tzmem.c
@@ -67,7 +67,70 @@ static void qcom_tzmem_cleanup_area(struct qcom_tzmem_area *area)
 
 }
 
-#endif /* CONFIG_QCOM_TZMEM_MODE_GENERIC */
+#elif IS_ENABLED(CONFIG_QCOM_TZMEM_MODE_SHMBRIDGE)
+
+#include <linux/firmware/qcom/qcom_scm.h>
+
+#define QCOM_SHM_BRIDGE_NUM_VM_SHIFT 9
+
+static bool qcom_tzmem_using_shm_bridge;
+
+static int qcom_tzmem_init(void)
+{
+	int ret;
+
+	ret = qcom_scm_shm_bridge_enable();
+	if (ret == -EOPNOTSUPP) {
+		dev_info(qcom_tzmem_dev, "SHM Bridge not supported\n");
+		return 0;
+	}
+
+	if (!ret)
+		qcom_tzmem_using_shm_bridge = true;
+
+	return ret;
+}
+
+static int qcom_tzmem_init_area(struct qcom_tzmem_area *area)
+{
+	u64 pfn_and_ns_perm, ipfn_and_s_perm, size_and_flags, ns_perms;
+	int ret;
+
+	if (!qcom_tzmem_using_shm_bridge)
+		return 0;
+
+	ns_perms = (QCOM_SCM_PERM_WRITE | QCOM_SCM_PERM_READ);
+	pfn_and_ns_perm = (u64)area->paddr | ns_perms;
+	ipfn_and_s_perm = (u64)area->paddr | ns_perms;
+	size_and_flags = area->size | (1 << QCOM_SHM_BRIDGE_NUM_VM_SHIFT);
+
+	u64 *handle __free(kfree) = kzalloc(sizeof(*handle), GFP_KERNEL);
+	if (!handle)
+		return -ENOMEM;
+
+	ret = qcom_scm_shm_bridge_create(qcom_tzmem_dev, pfn_and_ns_perm,
+					 ipfn_and_s_perm, size_and_flags,
+					 QCOM_SCM_VMID_HLOS, handle);
+	if (ret)
+		return ret;
+
+	area->priv = no_free_ptr(handle);
+
+	return 0;
+}
+
+static void qcom_tzmem_cleanup_area(struct qcom_tzmem_area *area)
+{
+	u64 *handle = area->priv;
+
+	if (!qcom_tzmem_using_shm_bridge)
+		return;
+
+	qcom_scm_shm_bridge_delete(qcom_tzmem_dev, *handle);
+	kfree(handle);
+}
+
+#endif /* CONFIG_QCOM_TZMEM_MODE_SHMBRIDGE */
 
 static int qcom_tzmem_pool_add_memory(struct qcom_tzmem_pool *pool,
 				      size_t size, gfp_t gfp)
-- 
2.40.1


