Return-Path: <linux-kernel+bounces-79597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A393986249B
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 12:43:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43E281F22E11
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 11:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D36A32E3FD;
	Sat, 24 Feb 2024 11:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ca6+OlIP"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D571AAD7
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 11:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708774985; cv=none; b=fiw4oUtDOS1bKk3Awjq5QVjO3AmeCNZW1rLDEVwP9//20J/Ad6iU+GjekCtIeLrsLbaE6gVvY72cNlP/7pBbHaffXSpp/FRaArnz+d+ilmvOnXr9hZBv3MXz02KYh9MtCXtZGP/Ya0Tb2QfS3K1mF5Oo56y9KJDg2mQd1eKgs9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708774985; c=relaxed/simple;
	bh=Xr9Q1kHyIXarWf9Yt/Tx3cmsbXKsClDj7IWw9Wh0BR4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cUQwx3iucEz4NFDFeZuKQys4AcuuW3kxeRp2xjCEuN7kjRFvh+QJgm0oUYzFDelEz2ZXgZGrV4EBVDanvu5+WpXxk4VcOehbvqwZ7gh4wkGg8r6LMeK9V1ZapeuRHCr9E6CFyRoXrfPQljoSBWROMjwsBlC/aiIz/emiWf9u6y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ca6+OlIP; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a3e5d82ad86so233598566b.2
        for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 03:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708774982; x=1709379782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2uxGcLrkBHPXM66GKa6HAeIjDFhpW0i+YCi2p9SiA+8=;
        b=ca6+OlIPBGlAyHAP4BVLWg1/6NLxk/uHxjK9Y1z0LLnbUvW0L4Gpefx5hQDIEjMsW7
         ID+FWmhJtMA7bNqSD/tgcw41rulHeHaTtYt29/qx1XzFivGpujxKQGcnQgDa8kVmSWE1
         cvWsAeLu59djTBjuPs+15NkJMWugeDe3MwUt2bIAp23ebROVmxhs8A1PWz+TH3JNgz/Q
         BDNKFK6+/iMakTKKRoMhy1NU9dDOy22/hPoai5vrzObf1zblZq0nGEunfkEg/Wwn7fYe
         4DD30ctNnSNZqWiP/focUqJi5S1J1cR6YBnbHFXYc8lz6ZW5L1T9j8+QMiP7qt61mxV9
         MYjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708774982; x=1709379782;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2uxGcLrkBHPXM66GKa6HAeIjDFhpW0i+YCi2p9SiA+8=;
        b=UTn2UlHVo3ax9f9+E9uKRlQDhdbnBEe8nCSKPwmNyqdTFeOswuyshfDU5NABuQDp8N
         00YpUss/mEdpZSE4B5CSnKTvNJiJedZIqUInUvkR73vlPm25yoqXsqz5ZZ5Gv89cv/W9
         gNdMkxI9i8djTWaFLPWCBmSWcD5qvUqpnlt5seMpdc95PZCisyy72zcXnSyqaQ9xSnH7
         1Z+geikDdSVIFTmCuhhZGZxZVmsYm34C2XCvmSzCHIOQ9191uWKbpJ6dMUQ32K1GC5Jt
         htIksEPizrtO9JIVjiiD95hzfCUwm5Nq+y91gtj4yatAPtDzgSQt/pBVFXXJYX58p2iX
         rLDg==
X-Gm-Message-State: AOJu0Yx/+aeVhDnasvPpozAmjrvbkEPqn65Z39kgn9AOpCcHgCwLTMOG
	4JPdMHTPUXcMjw28QolAUG/Gug5U3mUfdu/6gYjQ4FNjQD0tdMauVgLPJOqCamo=
X-Google-Smtp-Source: AGHT+IEKC7IfFNatktFFqrYdYB9hruVm3dYLjZ9GJHLJ9ImHJXSBiMrUSClbOvlzAq8RKE2D671tcA==
X-Received: by 2002:a17:906:eb4d:b0:a3f:47a9:481d with SMTP id mc13-20020a170906eb4d00b00a3f47a9481dmr1850875ejb.76.1708774981783;
        Sat, 24 Feb 2024 03:43:01 -0800 (PST)
Received: from localhost.localdomain (82-132-212-111.dab.02.net. [82.132.212.111])
        by smtp.gmail.com with ESMTPSA id r27-20020a170906351b00b00a41a314f052sm508149eja.192.2024.02.24.03.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Feb 2024 03:43:01 -0800 (PST)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/1] misc: fastrpc: fixes for v6.8
Date: Sat, 24 Feb 2024 11:42:46 +0000
Message-Id: <20240224114247.85953-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=296; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=/QzucFTBKjw6ma1vI8yCtQKjfl4XAwG8OcubZfrFOiE=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBl2dY3EWpTspxcgThu+vRJ/W8Yan3pOc6GVFRSg HAyvOs+4F+JATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZdnWNwAKCRB6of1ZxzRV N221B/4vCGq3aQDh8yfp02Xfoc+T8fK3lkqnpW5ASM1HBVlwN8HnjK3rcuoDUUfY1wUdiVTkMT5 ViNYn06VVt1Zl5fgCNqsI1LgxkGSnudp2EZxgldovEVOwPvUYmF4wRgYzuxAIyTq7Af/oE7lc0J 5ZQgFK2wLNSFEnYqMRK8h0woFfbEieNYDIZ4paahWkUZdrUZgWdarzbUTSNSeNRr5AuH6kmr/y5 rryTN2FLZV75A7G7kXMibpIATiLQhirNxA6VvbH8zvY/znu3PglfJE6w1wlpaur30iWeONB4RWt 6MwLhDTz5yg+ViqNTlcMAasxFKQwCtsCfQ4yF6zBY/Qy57gD
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Here are one fix in fastrpc for 6.8, Could you queue
these for next possible rc.

Thanks,
Srini


Ekansh Gupta (1):
  misc: fastrpc: Pass proper arguments to scm call

 drivers/misc/fastrpc.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

-- 
2.25.1


