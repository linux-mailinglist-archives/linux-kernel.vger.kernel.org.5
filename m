Return-Path: <linux-kernel+bounces-96108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 585A9875736
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89C001C21497
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14ACC1369A2;
	Thu,  7 Mar 2024 19:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jHP8rPIM"
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98AC3136999
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 19:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709839876; cv=none; b=HXPgFUiF6UXZY37EhjAjtDFM4016uO3VSkJSp5pCPI0PIb3o1MF035YlxgC7r34cQ117zvVfjNP6nKYEf9lbiD/w5wJVcH+ufnUjOrIgpnyqdpnpoSatO64oOjS8fni6O9TQSHKifXXsZX4u+U/XE7hHRkwYPBiuobw/WKaADHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709839876; c=relaxed/simple;
	bh=s98oAqevpvSYfVVpzcwgbFsRNlC/QnLKzzxRtydaLGQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Xp5a6j06l32nd6H93MgsJv1Jk/kS8bc+EPnALccF7LvBFLdP/jxQDsuYdV20X6fcnYJMfgsFE+LWJRUChuwsSQOBuy+piK/uYq1EqS7JRjvaPAwXcTLpcl2m1RZW2rFPm7dUzODSkTt2SpPFYH+M5SKFHNvPP85oVp4bBkbBmJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jHP8rPIM; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <683db607-b8a6-4236-8883-1cf7113daa29@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709839871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s98oAqevpvSYfVVpzcwgbFsRNlC/QnLKzzxRtydaLGQ=;
	b=jHP8rPIMRv7ImiQQTKIg9TOrwGCsk6PIzKkY1iIG9vw48a6QKcxyEyT8qQCXGPYpB37Kg9
	3t/zhArO5a5zwfQVr/3JG6525CaqDKZiWec/f0Bw7vtGKHiAPeEkgJRbyWewX6we7unJB7
	92RFJT8SG16nX0EgWcP0Lx8ruCrHxqA=
Date: Fri, 8 Mar 2024 03:30:56 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/4] drm/bridge: Add fwnode based helpers to get the
 next bridge
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Phong LE <ple@baylibre.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20240307172334.1753343-1-sui.jingfeng@linux.dev>
 <20240307172334.1753343-2-sui.jingfeng@linux.dev>
 <CAA8EJpp8tsHi0RhsJXG+r6nOsV3AUC_n6jNHL0Cr6Ku2h3NMog@mail.gmail.com>
 <45f59f31-1f03-4a96-adb6-25c7cdd5e8a1@linux.dev>
In-Reply-To: <45f59f31-1f03-4a96-adb6-25c7cdd5e8a1@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 2024/3/8 03:20, Sui Jingfeng wrote:
> I think the drm_bridge should embeds 'struct device'


'struct device'  -> 'struct device *'


