Return-Path: <linux-kernel+bounces-90632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0EB487027F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 14:18:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E8631C21278
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 13:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79733F9CE;
	Mon,  4 Mar 2024 13:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jUsPpxYt"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AADD3F9C7;
	Mon,  4 Mar 2024 13:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709558258; cv=none; b=nSeQb6sq0yVK3CNwQjagvOvki7ZBn4bIxnr7KtColy8/fr9I4dR3JyQgZgHidlgYVmif4vTSFJyWxuTjeDuSJcGd6ZTyHT2JK0iQhPKkUdEWMmSDwskstFiv2tAr7zY+ZnRlcS+u9tiyI4Iql+FT2QUv6PHkNQPHcm19M8tPLLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709558258; c=relaxed/simple;
	bh=OX/K8YyOzC1SThuNTMwMMnK8+cBQVcgmipBIo+ZTROA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=cyU9/MDADKrRTETj3Zx59msY0G9zgKf7paHtFJszuYoo4GRITx2TH98zqL5jqHFKQK7s6u2S/gBEoTltYoBr8/agthlZxtu0A2Nh2uNBmS630sW+RH9bPYCpobPd77MwaFN4C78aggLsGXKNzGR56bcsNeVXLeW2+AP2zTdUbC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jUsPpxYt; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709558256; x=1741094256;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=OX/K8YyOzC1SThuNTMwMMnK8+cBQVcgmipBIo+ZTROA=;
  b=jUsPpxYt2rxU0MwZYiU32eHmgH5WKW2oSAv7E8DCebA806ev4if9YltW
   L9gdwKO6x8XttyrSSNKbN9Q2vLAWT2xC2IexjBHxW1EJj07fVJZ4vaIKQ
   5zva3Y1cb6Tiz5dOcX/bpRlVnYZn/YIUrfsWBbhRggrKHYbIAP95YjlSr
   CNU5FyNNvbe/RfPENWwPPEAm3BKv9dRDgRQ3FDpyWaXNbzwwAR0htJYy3
   mbeDwDyMwv+kZXfFKNh+0m6JRI4beXap/tsU40yWxZBN+UEXWAZRi6vLD
   4pCV01iYcYkEcfMWjnhTHzoxeyrhTfbV1GU0p4tbMZ2GuWYbnGjnrCpe0
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="4213933"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="4213933"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 05:17:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="13656421"
Received: from ekohn-mobl1.ger.corp.intel.com (HELO localhost) ([10.246.49.145])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 05:17:32 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Shravan Kumar Ramani <shravankr@nvidia.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: Hans de Goede <hdegoede@redhat.com>, 
 Vadim Pasternak <vadimp@nvidia.com>, platform-driver-x86@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <a4af764e-990b-4ebd-b342-852844374032@moroto.mountain>
References: <a4af764e-990b-4ebd-b342-852844374032@moroto.mountain>
Subject: Re: [PATCH] platform/mellanox: mlxbf-pmc: fix signedness bugs
Message-Id: <170955824704.5357.5837908391020307060.b4-ty@linux.intel.com>
Date: Mon, 04 Mar 2024 15:17:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3

On Thu, 29 Feb 2024 16:11:36 +0300, Dan Carpenter wrote:

> These need to be signed for the error handling to work.  The
> mlxbf_pmc_get_event_num() function returns int so int type is correct.
> 
> 


Thank you for your contribution, it has been applied to my local
review-ilpo branch. Note it will show up in the public
platform-drivers-x86/review-ilpo branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/mellanox: mlxbf-pmc: fix signedness bugs
      commit: d22168db08c4c8e6c5e25fa3570f50f0f2ff1ef1

--
 i.


