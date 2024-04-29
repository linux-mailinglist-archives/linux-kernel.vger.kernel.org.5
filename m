Return-Path: <linux-kernel+bounces-162725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 530118B5FAF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 19:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE876B22230
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 17:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41248626D;
	Mon, 29 Apr 2024 17:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="s6vU/A9j"
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629FC47A5C
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 17:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714410525; cv=none; b=fVTgVtO6CkQpFqnjSLsRsI4Vk0gHfGGsldxs92AWSMkaapOhoU4R4RKVk6+lBDzCFo2d+5LGDkp9OOKcMvgstHsR9LH2+bqjIsV3LXNGqOPGv7PnwTmSvj+af47Me4s7emy193Q4KB26gNj6ypWqJHi08sS7TGVR+p5BScN9DsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714410525; c=relaxed/simple;
	bh=pBoJ+Gll31Xj9j3GHNALM0gtOApoA2F/MU0V1C2N6aI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CzB6Hs/LZiaoe/m8g8wCyg4Be3lzctKjZQX8lnEs68sF9MqjGgaMS+UzL0M6TUC83YRSp6M8ErP5AEyG5QYr9HtJcFfp+5CnZm5rh1dXbUchc2crKTUdzHIP5cFPks0Bopw7ws59LsrVABOzStfzAyTptS7I2iYmHHPgaYriso4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=s6vU/A9j; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5c155a66-34be-4789-8036-484ec01891ff@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714410521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pBoJ+Gll31Xj9j3GHNALM0gtOApoA2F/MU0V1C2N6aI=;
	b=s6vU/A9jYClpsp4VFTW2ogPS6JgjXbPf1ETP5oFavTYvz0CpTIaVY26QfuHl5BsvTYoe1P
	zOUMuN33FfqOfjz4KGNQ5Auilr5XmKC98IdIliuAWZnuORR7L9moXhqcvtx/8mhHCoqw9L
	Fj1hOKPqGekmZqmLWwKvF6rkc3cyWN8=
Date: Mon, 29 Apr 2024 10:08:35 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 1/1] bpf: Use struct_size()
Content-Language: en-GB
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>
References: <20240429121323.3818497-1-andriy.shevchenko@linux.intel.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20240429121323.3818497-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 4/29/24 5:13 AM, Andy Shevchenko wrote:
> Use struct_size() instead of hand writing it.
> This is less verbose and more robust.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


