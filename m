Return-Path: <linux-kernel+bounces-160952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E498B4502
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 09:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7227C283665
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 07:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A7844C60;
	Sat, 27 Apr 2024 07:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XjNqsYMT"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3C641A89;
	Sat, 27 Apr 2024 07:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714204473; cv=none; b=hhGxxoVTGjInmc0WOzZVyhsfsrY54i+RFL/JfcgGtwD8za5pp5eJvM4PMnVaR2Fa0t4muRxvAnDgCJVGnGyNG0E0rFnwywKgq0tKdk6uQYp8mmCIN6VLcHv07HJVytag5NHkzurMEGuihMND4vCOwHurmP3GTP5PXzSeaIG6ny4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714204473; c=relaxed/simple;
	bh=EBvbsaXetNJYdVZkRWkDhH/zk9BDKCOwz/QHuOw94OM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KOfzn2mNQEGmKmEFQYa9yuJ53puHm8cXv7mtpFzvgc3/witieXsldqTzMI+eMN76cC3dZufVeFmkWToDTLYVHB1KRWjgM7niwsKkhGZFxbJ/sFbZziYOcEldq9yYTd4kkci5qaITvk4ebdBZDB15s7zlmBGGS/Frkp+T5cfH4VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XjNqsYMT; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6ed627829e6so3486221b3a.1;
        Sat, 27 Apr 2024 00:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714204471; x=1714809271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LryMUWSXWSPRxaQIt2IMtBO24PQkNlmC6gXH6D1bj+M=;
        b=XjNqsYMTk0HzbgKCVUqPTuV52lnC1m0WBwv7cSs2hm9hwB8s3zdsvUYYjtLix/gDwu
         IBdbf0lY07DeV/XRE28Sv7PFuPuHMVyv2nx/pLvXb914eF6XA2M6Zv5PKAFAWEXkpQIf
         ieiz3P+nIWIT4jqQ0nyCoBfyyOiy1zIAAt12O2yPbC6vpNPUD6SyGpXwnCGK2nqFysG1
         7sWy/KEXErhSOiO4Y8VUPtOdeF3Gjk+asjHP46Yc3Fxlz2XS4U6gw8zNan6l7f6hLGZn
         6B+WJKNp3CCOIxkaC7Sp/oX6Ig9JL15B+USWxHfnD+/MF188bs+mI372YeMisnVGIHEt
         ZN9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714204471; x=1714809271;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LryMUWSXWSPRxaQIt2IMtBO24PQkNlmC6gXH6D1bj+M=;
        b=k9qC6Uj/fxlmfaUq3uTWHhUWCtvXoJnlCfOvocTjC9P/M/xzYQ65OgKV+7/M+rUHEw
         dvbj0+JuJzRIyLZGiSKkPhhmpYWR/rbf34gYtDI8gmEK8AWlFBTDDsOkCbqM3hpoli2/
         KbTJVudufTx99Zm6TNRPvg/Jtq+WPI2dhSajTRqB62lxp1Mr/lM7emS+P0qrmN+mPBiI
         h9fVOUwTfNWnEld/twewSztuEeAukfBDbuM4AG/feDEWWjWxOuY0bwo17mJaBAh7wz3+
         bwsJgZSRhkr4mBlIgH7LqmTPxzjZ4nPOB8N1Db6zuRAw8i8JJd3Yaak3mugG8Ff3IRTd
         ftMA==
X-Forwarded-Encrypted: i=1; AJvYcCUwL4pFILjB1JaMbyD/aY3ws2RLCTbnDZn1/1hkLmKioqBSmLXdBfqAcFNmwtrXqZeG3MW+z642oo33gE65+8eG3IF/056sWOSBshr1o/tBICrq/Gb6L5tbtvSdlkfO5DfjV2fhzX1f0PSBBfO9GptdSChXqHYJwTEIUP7kUemztHyV2g==
X-Gm-Message-State: AOJu0Yz56gpdflP19di/dIymhw9AyntHL8W3y3swQ0R2utyR8Cdn+Zs6
	wi65UKPRrJDRUrQ+li+PVD3N7mVORMzdO/EHBouwIwBX529pfxVY
X-Google-Smtp-Source: AGHT+IHwdCsHr6JoQr3UpVGreocmmdoL7npjKTt7RGk906UWUDf90Xrt08F1iukUPLp2fEIKYTRf4Q==
X-Received: by 2002:a05:6a00:1906:b0:6ea:e2d8:468 with SMTP id y6-20020a056a00190600b006eae2d80468mr6341330pfi.26.1714204470669;
        Sat, 27 Apr 2024 00:54:30 -0700 (PDT)
Received: from localhost ([46.3.240.103])
        by smtp.gmail.com with ESMTPSA id m12-20020a63710c000000b005f77b2c207dsm13608057pgc.12.2024.04.27.00.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Apr 2024 00:54:30 -0700 (PDT)
From: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
To: broonie@kernel.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	unicorn_wang@outlook.com,
	inochiama@outlook.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu
Cc: dlan@gentoo.org,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Subject: [PATCH v1 0/2] riscv: sophgo: add spi nor support for cv1800 series
Date: Sat, 27 Apr 2024 15:54:24 +0800
Message-Id: <20240427075426.662671-1-qiujingbao.dlmu@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

add spi nor support for cv1800 series

Jingbao Qiu (2):
  dt-bindings: mtd: add sophgo spi-nor-controller
  spi: add support for sophgo spi-nor controller

 .../bindings/spi/sophgo,spi-cv1800-nor.yaml   |  33 ++
 drivers/spi/Kconfig                           |   9 +
 drivers/spi/Makefile                          |   1 +
 drivers/spi/spi-sophgo-cv1800.c               | 370 ++++++++++++++++++
 4 files changed, 413 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/sophgo,spi-cv1800-nor.yaml
 create mode 100644 drivers/spi/spi-sophgo-cv1800.c


base-commit: 4cece764965020c22cff7665b18a012006359095
-- 
2.25.1


