Return-Path: <linux-kernel+bounces-121865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C541A88EEBA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 19:57:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F0F22A48B3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A011509BC;
	Wed, 27 Mar 2024 18:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WBJOFrdK"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D6D14F9CC;
	Wed, 27 Mar 2024 18:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711565840; cv=none; b=Kr5oEIWWPNn4kR/QPj9lEqoUNHDQpxPX2KM8kBTP1H1OW8OC3bVd3THj3mrjFOz6YZOxqVJR1w1d/Idaqh+DK/Epv1bckjkRTWWlbGxxqBjCSy5mf2I+823UuetVK3ixkPGG1JhNVzYHhVL2gejZ1qDreol0oO5SZRLOWXflHpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711565840; c=relaxed/simple;
	bh=OfAba53dQ06otKA3IjFlOaA0wy3ja83eDdFvPK/hbB0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J7KEW4eGq4bD0oOdmg8Qja70/Dyg2LFW2Zg1yu0hIinZySCQfULAgJfm+cFaBzk61flBkCc2Kf3Pioy+wcUgQDUk/JGSkUicoHCnicffne6MrwN8N/g1+PoU8JF++ELt5s5mYq1cNEkmKu0mjEhsUvGzHOCpfCc3jq0yQIORQQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WBJOFrdK; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711565839; x=1743101839;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OfAba53dQ06otKA3IjFlOaA0wy3ja83eDdFvPK/hbB0=;
  b=WBJOFrdKjuYisfV67jV9ky38FJPilI5h3JY7OKp5+7dqwpxmBhWiVfCj
   aiEHL7SXwgYf5zC3duODFaaQt5xvbw1CD+6mtBxeW2b88vXEjCe67ZKNN
   W2RqelyTy8NVFz8k+pAwf63RppnybBQ0TBvdt/EUN6K3Gb3/aKacja4t9
   3WiatIvk+uulq5X4B3Z2gbFrcnprrYR5PnHFgfMSH2dxQPJ2l99G0dZhZ
   pxKDBKhHAqEcdER/PL9TTXrHUmd01XU+4tjXfUIClSbWmTKbwB3bbYKug
   DP1PbNt5nfMbp1344pK4cktnhGwUn6w3NYxxw+4gjYdMim+Nz3qiiFuPj
   A==;
X-CSE-ConnectionGUID: 8YTwNL5NReK1fwHx8dUvhQ==
X-CSE-MsgGUID: cfG6RTodQa202PGzq5dlRw==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="6555470"
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="6555470"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 11:57:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="16404593"
Received: from ssherman-mobl.amr.corp.intel.com (HELO [10.212.117.1]) ([10.212.117.1])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 11:57:17 -0700
Message-ID: <a256c478-2cdb-4012-ab95-b6ccba1194e8@linux.intel.com>
Date: Wed, 27 Mar 2024 13:14:02 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/18] ASoC: drop driver owner assignment
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
 Baojun Xu <baojun.xu@ti.com>, Oder Chiou <oder_chiou@realtek.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 alsa-devel@alsa-project.org
References: <20240327-module-owner-var-v1-0-86d5002ba6dc@linaro.org>
Content-Language: en-US
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20240327-module-owner-var-v1-0-86d5002ba6dc@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/27/24 12:44, Krzysztof Kozlowski wrote:
> Core for several drivers already sets the driver.owner, so driver does
> not need to.  Simplify the drivers.

Nice cleanup, thanks.

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

