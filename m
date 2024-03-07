Return-Path: <linux-kernel+bounces-95307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D935D874C03
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 917B01F21AC6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863E385278;
	Thu,  7 Mar 2024 10:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="djwt2YzF"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CE4839F5;
	Thu,  7 Mar 2024 10:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709806196; cv=none; b=HaSHwxg8scvz1KUwSv8FoiItcnSqh4SzfpFHIEGHCr5kwSA+GWLJvvHQ8Qub2B7umM7UEQqVfJJOEBo8I0qx4vic7ekTtkfaRAxByjfkj4Rrf6W2pN3jOxo3JeChPiuXv8WUVaJi2YxN9gxCR5zF0q7eyt6QAmoNjI6w5w1jUkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709806196; c=relaxed/simple;
	bh=vh1KTvU7pgzsNqD/jqUFcTHIz8fH1XhJOVJN36h5elM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fyhRpZIrEPYkhkYKcQjEqRp79EYmyPp8Tws/q0M9F1oZeTJBBvO0it9r1s1f1AI8WsIBLwkekpNyH6HZByY++I29pbqLFrkAwjxNpQsKlsJ3xxRkOG5oMH4xTVt3Fw/mP6O8p9aSg+JIMdlnuzjWelPlyfBcTWy+nfNyKU3OCdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=djwt2YzF; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709806195; x=1741342195;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=vh1KTvU7pgzsNqD/jqUFcTHIz8fH1XhJOVJN36h5elM=;
  b=djwt2YzFgaDGEImHg9+rRheVtXZVAZCjyW/cVkU8S3HaYih6qujYzw8O
   +M4fUJemWKaonMRVDLW5Ik5YSgwxSUpBH3L9UHvVWS85NQKAQySfMEoDM
   ARyIfI+K84FklXDtFr2S4hZIg223MmM2hpb+38bqF2Qt3COjOUE11nLpX
   /pucgbU1yTMYSEQ9bV/gilQxtsxafUgm0g5KJ5nN2+2LojT7m34U0jTMi
   elkup9hoG2yCw7hxQA6VeFdPDMfTrF6aTPq/5a8jkK3OaFRLzHnNVkNgF
   b1T8noDNC+PS8OLV3ZPubbjWlhLI0i1732kgEcUlgmTQ59SEi1shpu2TW
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="4398717"
X-IronPort-AV: E=Sophos;i="6.06,211,1705392000"; 
   d="scan'208";a="4398717"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 02:09:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,211,1705392000"; 
   d="scan'208";a="14728012"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.169])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 02:09:51 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Vadim Pasternak <vadimp@nvidia.com>, Daniil Dulov <d.dulov@aladdin.ru>
Cc: Mark Gross <mgross@linux.intel.com>, 
 Andy Shevchenko <andy@infradead.org>, Darren Hart <dvhart@infradead.org>, 
 Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, 
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
In-Reply-To: <20240306153804.6509-1-d.dulov@aladdin.ru>
References: <BN9PR12MB53815F52C9033DC526085827AF232@BN9PR12MB5381.namprd12.prod.outlook.com>
 <20240306153804.6509-1-d.dulov@aladdin.ru>
Subject: Re: [PATCH] platform/mellanox: mlxreg-hotplug: Remove redundant
 NULL-check
Message-Id: <170980618467.1921.15643030796886976535.b4-ty@linux.intel.com>
Date: Thu, 07 Mar 2024 12:09:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3

On Wed, 06 Mar 2024 18:38:04 +0300, Daniil Dulov wrote:

> Pointer item is checked fo NULL at mlxreg_hotplug_work_helper() and then
> it is dereferenced to produce dev_err().
> This pointer is also dereferenced before calling this function and should
> never be NULL except some piece of hardware is broken as it is said in
> the comment before the check. So, this check can be safely removed.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo branch. Note it will show up in the public
platform-drivers-x86/review-ilpo branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/mellanox: mlxreg-hotplug: Remove redundant NULL-check
      commit: 576b82c3c9bf021af4984aafc105508c99660667

--
 i.


