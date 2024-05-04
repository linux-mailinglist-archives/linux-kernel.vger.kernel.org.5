Return-Path: <linux-kernel+bounces-168493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7BB8BB93C
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 04:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 609CB1C22A7A
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 02:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E93F1171D;
	Sat,  4 May 2024 02:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kaechele.ca header.i=@kaechele.ca header.b="OhtppCQq"
Received: from mail.kaechele.ca (mail.kaechele.ca [54.39.219.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FBF1FA1;
	Sat,  4 May 2024 02:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.39.219.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714788923; cv=none; b=pDBUgq9Nu6v8AIyYtPXMOtyTNcewlmm6vTJhJ3Tv/jZ/6PxNeuFOlzsmZ3JNsJly/h8A05V2EQodhaaGFhqb8LNcp59d4PmDla5FSGgskxR8Du6141iavtC54zTJ3PFdyD79QbcGDwSgPxyEdQjnJsJhgzPJxvDHSpyDu8ymPZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714788923; c=relaxed/simple;
	bh=faSOwVcykO18Wfl4IuRvnoB9ojJOirqEh7G+O9IVOmE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Y4LFpGOD0ymCrN+l5EQUDMJ5CbFMNpKA4nV7dRM51U157s9rcdw1mPUgP4EnmVr+E4egjHsdwjVDy+lu1gKo8jODZiXmS7JYtvahQTTfZF+fRU4hjPWvenurkIaw9F8NjVmglcDpbq9ywAPZTlNw3ydeU4JGXHdwkE7e8uYdjfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaechele.ca; spf=pass smtp.mailfrom=kaechele.ca; dkim=pass (1024-bit key) header.d=kaechele.ca header.i=@kaechele.ca header.b=OhtppCQq; arc=none smtp.client-ip=54.39.219.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kaechele.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaechele.ca
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A86F0C005F;
	Fri,  3 May 2024 22:07:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kaechele.ca; s=201907;
	t=1714788484; h=from:subject:date:message-id:to:mime-version:
	 content-transfer-encoding; bh=hBpfk745PJzZA78WwD307p1qbXyVdOfgUX8fjEBo+Ts=;
	b=OhtppCQqEghly9KMZyqvlqvg8ez5Z17AxXfigAA2JsSQnHaEfUD6TPh329pAWl9LcWc0WH
	G/62wraDZzxR7QCOR3AhbghUdxxQtGdj+n9jJiQoFc226wsAB7kSlzd1qYMsKzdwzIEneo
	xRGz3jCB1vFHDhUB8ouuRGU4TZ2PzNo=
From: Felix Kaechele <felix@kaechele.ca>
To: Job Noorman <job@noorman.info>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] input: himax_hx83112b: add support for HX83100A
Date: Fri,  3 May 2024 22:04:39 -0400
Message-ID: <20240504020745.68525-1-felix@kaechele.ca>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

This set of patches brings support for the Himax HX83100A touch
controller.
To properly bring the chip up, support for regulator handling is also
added.

I have no access to datasheets. So, like the original driver code
that's being extended here, this code is mostly based on the quite
convoluted, GPLv2 licensed manufacturer drivers for Android.
I included links to sources and references where appropriate.

A number of people tested this patch set on Lenovo ThinkSmart View
(CD-18781Y) devices. That device has a variant utilizing a Innolux
P080DDD-AB2 LCM. This LCM comes with the HX83100A.

I would really appreciate if people using HX83112B chips could give this
set a run to ensure nothing broke.

Thanks,
Felix

Felix Kaechele (6):
  dt-bindings: input: touchscreen: himax,hx83112b: add HX83100A
  input: himax_hx83112b: add regulator handling
  input: himax_hx83112b: use more descriptive register defines
  input: himax_hx83112b: implement MCU register reading
  input: himax_hx83112b: add himax_chip struct for multi-chip support
  input: himax_hx83112b: add support for HX83100A

 .../input/touchscreen/himax,hx83112b.yaml     |   9 +
 drivers/input/touchscreen/himax_hx83112b.c    | 187 +++++++++++++++---
 2 files changed, 166 insertions(+), 30 deletions(-)


base-commit: 7b4e0b39182cf5e677c1fc092a3ec40e621c25b6
-- 
2.44.0


