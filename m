Return-Path: <linux-kernel+bounces-63700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF5D985336F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:44:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FFC91C2339D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B004E57895;
	Tue, 13 Feb 2024 14:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="VTk1MIcw"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958291E88F;
	Tue, 13 Feb 2024 14:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707835447; cv=none; b=mIVrBUXTKG5DbkLbChw/0PjJvuWEGbP3nbvedjBsLqqwq6BbiWB1O/sfYD8HzyWGHx3W9cTK449jqEHDLWD6JImDyW6H+E7Ou2dkmpd4+fuSilBAMwoybkGeBr9aemEZNYZzgWaXBIgsCxdlSAquQesPLnDTGuMuh2dFJcbJYEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707835447; c=relaxed/simple;
	bh=crbHlNdRuniw2NTMAltR/X7KbWQ8GebDd/koBr7yWkk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=cKpd3frjPnS0zfpqX1oW5B5VIlWOrnXwSpZqwkNuaXLLPsz82K46HzEZ4Xs4dIHm91aWmVL4ch6T4biJXzPvYRiGWPHEJeDsHFeZ8PPvrTx35s1KrNtlCrcpELXnxvA8nzsrrcMnWgdAUpywI93cej5b8PKxdoISuAAAgTcTg2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=VTk1MIcw; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5dc816e4affso790069a12.2;
        Tue, 13 Feb 2024 06:44:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707835445; x=1708440245;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yDRCf7ye9xUGIdI7KZ1wE8lwvkdkrKbfelIrWiQUH+M=;
        b=TNB7JJiTc6DUCpx3Mp7zWfTt0srU8c+jfxyOJHBtGMcS+sgZo/jpaXKeGXlv0SO23t
         AYSCLJkSFJlR3gTxvzZVMZ5BMwsI4t96Pwzpx5QepLfr0O8o9agNzijUeAEyI3XBKEnB
         xlC5tKRoZg4rR4e3uUcK5ztJ4CjUumJ6kk1Hlpi7VMiXjK089MDkr4nIq78fsKabY3ZN
         DhMw2zXIPK9tXVtGALL3AwlGrRUx7VIy8ID7jUZ6ILU/PZKb74z1d9G5eINfAFlueXcW
         INTgrEgky2O1uofyhQCm2+o7elkUiHLua7+yxwKFmKT0NrLF0OSRILzCz4RTW4BNINLn
         /fsw==
X-Forwarded-Encrypted: i=1; AJvYcCWaZT/CUVdnYvCmJLzWbDXd8M4tSfMABL6jRJHQ59oJH4SHPUbggt9quXrAaS2oMCdtaZPZVLNaTPHmM6HTnl+jGEhDbHq2recerBmqLZBNDtj6kVPIXnv0fZcMlAlC2C6R59y3HuFW9rY=
X-Gm-Message-State: AOJu0YwktO1+wuABXCwb9KbFQdVky7DdBJGulTcP4XV7QN/mip6zC86S
	Qg0ZbIDyzdWOaxoNo0hr6gkt6WzEu3/THfCBh63pwR5EJCjKcFVpMNR7GD2SysF7Vw==
X-Google-Smtp-Source: AGHT+IECKRQ10VVWIfTc7i8RGgPeMMQjZe6ON9CKBQ5AHK2U/7V0yqbkv1diwDwHiBighxb5JpNBwQ==
X-Received: by 2002:a05:6a20:ac44:b0:19e:cf31:6a0e with SMTP id dh4-20020a056a20ac4400b0019ecf316a0emr4865642pzb.21.1707835444800;
        Tue, 13 Feb 2024 06:44:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVyfbOB2X0I0PrSw+QrU98DWPh1l0diw2Aa3gK/TLI+rgap1TDwsM2KNfZEVtHr+VcuXMRrCBjV9NM0drF8i+uY+C/ieENiWrbp+vu6aAN+OoN139QFol72Ar+sRJk5BQRy790BF/vJGhG81F9mUPksm1TLhPSUx4TS+NtLuNVfWwSnTSITX6vgH3qAiouGk7kjEkr/cfp5v50alDJ5VoyRqdO0bF3n1S7hynBqsb56fQ/vS1rSgc5Eh3iZMoo619E=
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id m8-20020aa78a08000000b006e05cb7fd1fsm7432886pfa.164.2024.02.13.06.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 06:44:03 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1707835443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yDRCf7ye9xUGIdI7KZ1wE8lwvkdkrKbfelIrWiQUH+M=;
	b=VTk1MIcw2cz8FjyYdu7eW21tm3izS9RYkPAtNDSYGsZzuYjtys9Dx4eYxi6On766QmoSQO
	mXmUI4CAq6zxqd8sCmtFmjfVmJaMkINzvxHf3/ZNXHBEVMmUAq5VZ3HRAsZ/HZPJ5T+UA2
	/cuOGIRSjgIWVoJTXOY4ZoXX/UYrTUSZnQAVcHTwOKTgTKlLWZgHY6ZF96+ogFesuaUU5j
	42yazbDPpTPY+x45n8ilg27uwNRvCanMXemV0eF+HCbQ7VvckdI+/4S0jIwkzlojPqBADk
	b3kez1O4G63VlnkO9jxmPkh+6a0K7SzD0u/Hrwsa326jPgxQAPUkAgsnpUANOA==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Tue, 13 Feb 2024 11:44:40 -0300
Subject: [PATCH] gpu: host1x: bus: make host1x_bus_type const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240213-bus_cleanup-host1x-v1-1-54ec51b5d14f@marliere.net>
X-B4-Tracking: v=1; b=H4sIAFeAy2UC/x3MTQqAIBBA4avErBPU/qirRITWWANh4VQI0d2Tl
 t/ivQcYAyFDlz0Q8Cam3SeoPINpNX5BQXMyaKlLqVUh7MXjtKHx1yHWnU8VhWxd42RdV9q2kMI
 joKP4T/vhfT8z1m2nZAAAAA==
To: Thierry Reding <thierry.reding@gmail.com>, 
 Mikko Perttunen <mperttunen@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1654; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=crbHlNdRuniw2NTMAltR/X7KbWQ8GebDd/koBr7yWkk=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBly4BaVcxkCof6n/WVt9Egdz342JxvMV9lxVyXp
 DTWuj8m8xCJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZcuAWgAKCRDJC4p8Y4ZY
 pjF/D/9gmXE6O1HQMJGkb2GijzxXRF2Av0KO1ZnvItTkGhzuNS65CBGLsNlk7fzs6DJPl9CgQV1
 dYegZBcRf4a2A0Tdk1kBn0PUES0I7ZDXhmZLbPPZJzdzOc42wQy8aUzlbejQxVPI0CF1etv7+ps
 dJfK8CrA29vFlLXX8urUg+rvlpH4AtQX6E/gzGGm3QZCCegGcnyIoFzt27e9+I3DWUABlYWR7GZ
 AHOPkPSrKdDJfb+tFcQom6coxe25TRKVrCFKUH2vIj9xeczw3ObdEZzztiXGZpNpFkYRTSif88K
 5OyNlB3q/kDp8Hz8aftr2RzFFvKF6y9sBZg+IwbsLVtsjBze7zWm0VFoQlQz9lCg1LbfPGc1GfV
 DiGUlMy+b99qnYwjJH5SnsmZjNO2viDwcAEF05PtfZBJf7Dj7uyVXP90WxQrTgZJg8zde6A+wKi
 m+vzkssHF3thQaBU+6CvzG9qqEr5eXZjT9D7KBnWRyxgdyHgTUcLB81yx96oXqoPENQQlkfMD8N
 yooGBuz5RAtUVbmysQBPW519pWdJx2yd9pkOPS0hAR2CIHxvb7cxYnJoF0EM5LCSIWbi5xi2KVv
 yz/d11vtdtluE4PLiwcjn+V5eKZylxhU4NO3lurksEp4mlOnNg0Wd7SC4qmkZIO3CIL6wBoU2t4
 h49Vh+/yY4TNwag==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit d492cc2573a0 ("driver core: device.h: make struct
bus_type a const *"), the driver core can properly handle constant
struct bus_type, move the host1x_bus_type variable to be a constant
structure as well, placing it into read-only memory which can not be
modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/gpu/host1x/bus.c | 2 +-
 drivers/gpu/host1x/bus.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/host1x/bus.c b/drivers/gpu/host1x/bus.c
index 4d16a3396c4a..a20dad7f0333 100644
--- a/drivers/gpu/host1x/bus.c
+++ b/drivers/gpu/host1x/bus.c
@@ -382,7 +382,7 @@ static const struct dev_pm_ops host1x_device_pm_ops = {
 	.restore = pm_generic_restore,
 };
 
-struct bus_type host1x_bus_type = {
+const struct bus_type host1x_bus_type = {
 	.name = "host1x",
 	.match = host1x_device_match,
 	.uevent = host1x_device_uevent,
diff --git a/drivers/gpu/host1x/bus.h b/drivers/gpu/host1x/bus.h
index a4adf9abc3b4..a80ceadfeb34 100644
--- a/drivers/gpu/host1x/bus.h
+++ b/drivers/gpu/host1x/bus.h
@@ -10,7 +10,7 @@
 struct bus_type;
 struct host1x;
 
-extern struct bus_type host1x_bus_type;
+extern const struct bus_type host1x_bus_type;
 
 int host1x_register(struct host1x *host1x);
 int host1x_unregister(struct host1x *host1x);

---
base-commit: 2429b3c529da29d4277d519bd66d034842dcd70c
change-id: 20240213-bus_cleanup-host1x-09f7f06652b9

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


