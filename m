Return-Path: <linux-kernel+bounces-58157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE81384E205
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 14:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7386F290783
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB7576406;
	Thu,  8 Feb 2024 13:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jZH5kKyz"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACACE763F6;
	Thu,  8 Feb 2024 13:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707399160; cv=none; b=rdmPpgSpOO4HsJfupnljBkneS+rWCQv7JYW7Y/ukngA44ZleXYQ9112+Q+kKIeCK2UI6cvd6XmYSe/JHEObv6VPWZ1TE3+KKQfWxd7RIdVQym2+vHLSY/1d+uZoV81hG5U+by5mSobH1eeV95lELvf2lTmmPHMxwopSGRlhXYdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707399160; c=relaxed/simple;
	bh=ox/lygUVUuO8GUhxrGxCpjXKXvOXS2HDwTY6nBtIQ+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OoPZQ5CFvhSzBWqf5o5BD5M0zl99FgeDp+4NE15Mw710oBPF6i2sguEYt9BYQtgffy2EIdPYi3N7XoalaB2PWYRVxYtEoF4vZ28Yimmza17VkA09+IUSw8oritJ8b2Oee2XoANLXmvrVzPsosO1PAanbfnTxNmisw8JHkTOtxCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jZH5kKyz; arc=none smtp.client-ip=134.134.136.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707399158; x=1738935158;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ox/lygUVUuO8GUhxrGxCpjXKXvOXS2HDwTY6nBtIQ+g=;
  b=jZH5kKyzR7YU5VanWvo8w7/O0+RH6pwUTzsXUGJ9DmGXdu51Qy2bepi/
   U0MfkIpzUpDE3d6hVUEWxL/l6TE/gmmBDEkhcHRalvDbfEvBt2Oj/A+ZD
   I994egj86TLrNCvL3sCwjRkHB8b601BjDJ9fskLmob87jswWmA3Or77Pw
   kTZ9n2tzdGVucYFXHrtk+bLkKf/yvdw8bMxXEIa+9ZLqXiSw+k7/7WljT
   JiXoqTZAJvC5tBokV0KO3+bwO7ljLuvQFNlDOxWwlY8du3TpdW2zmLHBu
   2u73KKGqgZ5iEuEUDbePkBPyWgqn72BD/5KczIRjkK12kRyBCjRNQsPTE
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="395629107"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="395629107"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 05:32:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="39085212"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.94.8.107]) ([10.94.8.107])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 05:32:19 -0800
Message-ID: <6a129c31-54c0-4671-a8d4-dc0f72e60154@linux.intel.com>
Date: Thu, 8 Feb 2024 14:32:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: build warning after merge of the spi tree
Content-Language: en-US
To: Stephen Rothwell <sfr@canb.auug.org.au>, Mark Brown <broonie@kernel.org>
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20240208145200.7590dc62@canb.auug.org.au>
From: =?UTF-8?Q?Amadeusz_S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <20240208145200.7590dc62@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/8/2024 4:52 AM, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the spi tree, today's linux-next build (htmldocs) produced
> this warning:
> 
> Warning: /sys/devices/pci0000:00/<dev>/fw_version is defined 2 times:  Documentation/ABI/testing/sysfs-bus-pci-devices-avs:0  Documentation/ABI/testing/sysfs-bus-pci-devices-catpt:0
> 
> Introduced by commit
> 
>    148b93a5062d ("ASoC: Intel: avs: Expose FW version with sysfs")
> 
> You need to make the "<dev>" part unique.
> 

Ah! The avs path should've been:
/sys/devices/pci0000:00/<dev>/avs/fw_version
Will "avs/" in path this fix the error?
As far as I know there are at least two possible devices, that's why we 
used <dev> in path.

