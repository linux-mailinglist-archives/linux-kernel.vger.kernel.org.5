Return-Path: <linux-kernel+bounces-164427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E94DE8B7D88
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77E7D281FC5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36BB9179967;
	Tue, 30 Apr 2024 16:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SjRUCGc6"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0F041C89
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 16:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714495832; cv=none; b=Ibs0MKRTLLnM6F+u2mYf8GDfkziBGvJqIScYBmpF+CaG7PUYSyQz4RDB+41yILXGy9Ue6RkaK+RhELew9XqbK2h/feSr5BY9qA6ATVuxNmZAAlv1lcxiUG4xXh44a42+UNXhvPko2G14OicvkpNvPsT3YHU44Dw1e75wpL+GHl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714495832; c=relaxed/simple;
	bh=fPGBRAa9PRhY++IOfBaDFzp2Jm7p85+AAVua+geoEOc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R0bGuXS1TZV5gJhcDqNU0NP2u1bs0Jj3vyRokuuCVnZtk4v5GH7FRWtLWeWBJYJlB1LK06Or9Mu/1EdFHhuFfFicnyy/vVNR5jG31o/popDmb+hW9B0iCP84w9mOuXD4yBD4I1GDFgOeCqKHzUG8JUEKSKNzeSUvtWjXq44jcH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SjRUCGc6; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <54be9c58-3e14-42c1-8fe4-4b03b630d1ac@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714495828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lFJZeubY0pH8XJB+NDsWHv5pVnm39sgZ/JqOBa9DJ8o=;
	b=SjRUCGc6H5+LA2XHJrXgHFE0vv/DjJUP0keVPI9OKuB6DqHmWMChS69yqn7wJmwcfxxuWN
	RQLJeBrsglP16SZJGsHEZSf+SmhZ63a2k4/kqu86Uafki6vsXRg+uRClV22PRQiZtI7wLd
	jDVP8x2s8YvWFmuREo1yInmy7J9Pgjo=
Date: Wed, 1 May 2024 00:50:20 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [v1,2/3] drm/panel: ili9341: Respect deferred probe
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Randy Dunlap <rdunlap@infradead.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg
 <sam@ravnborg.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
References: <20240425142706.2440113-3-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <20240425142706.2440113-3-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi,


On 2024/4/25 22:26, Andy Shevchenko wrote:
> GPIO controller might not be available when driver is being probed.
> There are plenty of reasons why, one of which is deferred probe.
>
> Since GPIOs are optional, return any error code we got to the upper
> layer, including deferred probe. With that in mind, use dev_err_probe()
> in order to avoid spamming the logs.
>
> Fixes: 5a04227326b0 ("drm/panel: Add ilitek ili9341 panel driver")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>


Reviewed-by: Sui Jingfeng <sui.jingfeng@linux.dev>

-- 
Best regards,
Sui


