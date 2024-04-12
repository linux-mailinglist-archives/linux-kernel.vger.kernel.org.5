Return-Path: <linux-kernel+bounces-142120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D1D8A27C6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E80261F254E1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF1A4CE0F;
	Fri, 12 Apr 2024 07:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="EalXs2sz"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8444CDF9;
	Fri, 12 Apr 2024 07:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712906043; cv=none; b=by2302E9+q1N/oMtDIvM+DD8r7SvY2hmcAX7FSDOJXtMcr5RSTYLiGlB1uXDtv11MhQlC5EPonF90y4PeyI40wQWI9a0Fbse5upZ6P0nhms9KUIBiWdrVWwPfg+yNxZwECnqr8PrZVekOGLG7Bcs9iI5VEJWHviJeAA+YiaEuUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712906043; c=relaxed/simple;
	bh=0E8Zvt4lAAHQzvRXBnp0JBjP3kaoaumws36hdpe3GLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WUVYx/HC5d5s73ezJFIHvSruh3E7gM2lN2KyhuONgUL6/yHNCdpBxixByh4tU6DYcROg/QsBA6He7WVAN5M0QcMvi3ry9jzliFODnVsGrOnA3k3SMQ0+iWvOoG9D+z0ITfb4f7PH6n7TWEQafW3i1gnYUvWsjlmnaDUKCgEOZIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=EalXs2sz; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=G7y/Tidz+LO01yOcA7IMl40yvIemasjGuLXHx2vTUzs=; b=EalXs2sz/LcepabTg/JSNpWYiE
	O79I2Ju1MMCCXV1ZLHUsl12Pzx1OZj7yg2vvCBsGBiBtqEmh5DYODsTu4kabfk3HsbEUOpvOLlRsu
	/dpcig2EcXBpYEx9IYFURxU3g4M56JROiHqKDl/qmcZL7GdDfGf4Un+lbo6FSNVJGCothMIofK72j
	OMZqmHfD31+mdTGfTh0aUsxaUoOMdaQwwfcbanoDLvt6h9RI5uqaNms5O45UkweL1COf1tjOVOBFG
	d3D4etqiKu85byrhp79RunADhUTqLjHYCW8zBxu19IAgXd1pilXrDZi4Z1NR3wF19QVMYajZ6aQW4
	8g/Q2zbQ==;
Received: from [219.240.46.135] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1rvB6Y-003oWA-EP; Fri, 12 Apr 2024 09:13:47 +0200
From: Hyunjun Ko <zzoon@igalia.com>
To: quic_dikshita@quicinc.com
Cc: agross@kernel.org,
	andersson@kernel.org,
	bryan.odonoghue@linaro.org,
	konrad.dybcio@linaro.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	mchehab@kernel.org,
	quic_abhinavk@quicinc.com,
	quic_vgarodia@quicinc.com,
	stanimir.k.varbanov@gmail.com
Subject: Re: [PATCH v2 00/34] Qualcomm video encoder and decoder driver
Date: Fri, 12 Apr 2024 16:13:25 +0900
Message-ID: <20240412071325.810465-1-zzoon@igalia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <1702899149-21321-1-git-send-email-quic_dikshita@quicinc.com>
References: <1702899149-21321-1-git-send-email-quic_dikshita@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

I'm trying this series of patches for enabling /dev/video0 on sm8650 hdk but failed.
After modprobing, lsmod says just like the follwoing:

root@hdk8650:/lib/modules/6.7.0-rc3+# lsmod
Module                  Size  Used by
iris                  110592  -2
v4l2_mem2mem           20480  -2
videobuf2_memops       12288  -2
videobuf2_v4l2         20480  -2
videobuf2_common       45056  -2
videodev              176128  -2


This series looks for sm8550 device though, my question is that this series have been tested on the device (sm8650 hdk)? or do you expect this should work on it?


