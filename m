Return-Path: <linux-kernel+bounces-125376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D3D8924C8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 21:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 987B21F222DF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 20:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D66FE13AA54;
	Fri, 29 Mar 2024 20:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WNKyaeJq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD241DDEA
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 20:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711742710; cv=none; b=ZuEbSFR5I5RlJe/hV+0+Hb2WmnpUsA5UYmBUCMZK4Ep95k3gEEgONmxrEjclALbnGTzOPzJIlEP3MK5r74MEEW9Ivc6NxO/AkSLi3MnT4PLIKbAZiBzLojYuL7qjdkQeB8uG0lcPM5wZNzBNUss6GowdUdWc/wgvQLeWQfCydn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711742710; c=relaxed/simple;
	bh=cIbe2NRCQP7djfpbM+11L+WlZLa/v/ScA4ZubIQlJek=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IH/bfwocBNr/EWFjYA4rQ+zq6qjRLAu1EWzLNx/nYms25eaJ+HVRn6xOkPIi4bAUx6rFbtx499kaCqoN9RXsTTvs96Tt2koSuYaGBgjKuqA8DLkyd1x+1DJ1pg7fA4TCP7Qh/by3UJSxB//9dY12XtplAq/1xB7EXfXKEescjUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WNKyaeJq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711742707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SnHjQH48YnJt749mCO2kgMTpPbKk2F0bzExQRDPnK30=;
	b=WNKyaeJqRyi2lqcR7sTPNbSobvGMHN8VaOMFTEQqYCryC+uqEgT2hxWQEUHoOQZQPK6JIT
	w1/WLX4JgP+P52YnUyAtiIv9NxmWhsTfbcIpg5oUkc3dGuKsmQsS2T00cz6mAqeVFlHuJW
	G2253EgETwG3I9ue0Mueoq+mcJj8Or0=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-xBaRD8gjNtaNR0CT0P6bPw-1; Fri, 29 Mar 2024 16:05:05 -0400
X-MC-Unique: xBaRD8gjNtaNR0CT0P6bPw-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-6ea81ca3883so1578167b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 13:05:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711742705; x=1712347505;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SnHjQH48YnJt749mCO2kgMTpPbKk2F0bzExQRDPnK30=;
        b=eK1pnwZVG/uIdcgdmcZJeqbEv7DYNH+JWKhOFnLsTbUJFvaPmQYV5Hn8LjK2HbUJvd
         On192iAEQjDk+PAw8e6QZpIdDXy9tQpQxuOmZ4pit5uA5nhwoNAABAj8usqW1i87NJDr
         ZgIyZZD8yQcmt2hxl9np3vPb7R22CDrPyOrpZLwlkWUoHtoy0u8jYB3LzXqNPaUk22LA
         rJxsH/F8FeeqcxdlhDksnVjJluUs0nzhX8/UZMM87/IKMB4SR6k/KCG/cH2GWiFygIyD
         Ew5Y/0mF7AGl+Jw2kzYhOxqbP9CKM7Cm+1EXE0ksJ95SnhKKBxSEYyfoaS3CmbcExm9T
         HCKw==
X-Forwarded-Encrypted: i=1; AJvYcCWE9NkfHC6bU4yOhsx4MKKZjWFoaw5CG1JEZ557IHEI4X8w4SSvyQOFgP4fjcYqWNaeqY66yTSBfQT6ln++YZGBqNXlxoxBXrziJzjV
X-Gm-Message-State: AOJu0Yxkk1sMShRtVnyMp8O3/zjfIg/emiOrrYWtjaznvRWWQQjvHVJm
	PIkA202OSceHn5HcG8tjEPLBQ50RG7dScoz3NpUK7sgLnvR/ce7SsddEmGaG6eydAvY/NFjdsPG
	HiUcnus8G1R0QSK5P1JJ23K460Rl8YCxoRauq0T8J3G0VN6CRJJzImMbkQxzv2w==
X-Received: by 2002:a05:6a21:193:b0:1a3:c8d5:707a with SMTP id le19-20020a056a21019300b001a3c8d5707amr3325554pzb.7.1711742704859;
        Fri, 29 Mar 2024 13:05:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzus5TYmyBQIJzw2X4oGKdRnzm+fHezhgpcMAHRkbhzjBiVvj5MPNNZHf4gEN4NnQQtcePCw==
X-Received: by 2002:a05:6a21:193:b0:1a3:c8d5:707a with SMTP id le19-20020a056a21019300b001a3c8d5707amr3325536pzb.7.1711742704523;
        Fri, 29 Mar 2024 13:05:04 -0700 (PDT)
Received: from localhost.localdomain ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id e4-20020a17090301c400b001dd6ebd88b0sm3830017plh.198.2024.03.29.13.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 13:05:04 -0700 (PDT)
From: wefu@redhat.com
To: jszhang@kernel.org,
	guoren@kernel.org,
	conor@kernel.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	jic23@kernel.org,
	lars@metafoo.de,
	andriy.shevchenko@linux.intel.com,
	nuno.sa@analog.com,
	marcelo.schmitt@analog.com,
	bigunclemax@gmail.com,
	marius.cristea@microchip.com,
	fr0st61te@gmail.com,
	okan.sahin@analog.com,
	marcus.folkesson@gmail.com,
	schnelle@linux.ibm.com,
	lee@kernel.org,
	mike.looijmans@topic.nl
Cc: linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	Wei Fu <wefu@redhat.com>
Subject: [PATCH 0/3] iio: adc: add ADC driver for XuanTie TH1520 SoC
Date: Sat, 30 Mar 2024 04:01:23 +0800
Message-ID: <20240329200241.4122000-1-wefu@redhat.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wei Fu <wefu@redhat.com>

This patchset adds initial support for XuanTie TH1520 ADC driver.
This is modified from XuanTie TH1520 Linux_SDK_V1.4.2(linux v5.10.113)
The original author is Fugang Duan <duanfugang.dfg@linux.alibaba.com>

Wei Fu (3):
  drivers/iio/adc: Add XuanTie TH1520 ADC driver
  riscv: dts: thead: Add XuanTie TH1520 ADC device node
  dt-bindings: adc: Document XuanTie TH1520 ADC

 .../bindings/iio/adc/thead,th1520.yaml        |  52 ++
 arch/riscv/boot/dts/thead/th1520.dtsi         |  10 +
 drivers/iio/adc/Kconfig                       |  13 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/xuantie-th1520-adc.c          | 572 ++++++++++++++++++
 drivers/iio/adc/xuantie-th1520-adc.h          | 193 ++++++
 6 files changed, 841 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/thead,th1520.yaml
 create mode 100644 drivers/iio/adc/xuantie-th1520-adc.c
 create mode 100644 drivers/iio/adc/xuantie-th1520-adc.h

-- 
2.44.0


