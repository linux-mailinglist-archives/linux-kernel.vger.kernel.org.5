Return-Path: <linux-kernel+bounces-56585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EEE984CC0F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B6232912C8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 13:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A2477F23;
	Wed,  7 Feb 2024 13:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UqbNJFQj"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC8D77F08;
	Wed,  7 Feb 2024 13:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707313969; cv=none; b=oAjSDHBLiUk0qbz7MYKYVIFETiVKt1UHspsx+f1fT7g3ctuHlBTzx6y586rE+gwxAFNE/FJ1rAFBsINvQKjfymeD7KBCfei+TtohBVTf+H48EXY4lEH17OKAGH7fN6whqmzDE1W5DcfhEmCmNF76n0XjxVCGa6N4sj11OfwvhHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707313969; c=relaxed/simple;
	bh=LJ+qhquQIV7sWyOZXEIik8kiprvLDIOmfTr/MQf2ue4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bzFYV9YyEnwiOSSsJs3XudUIuDILhKwFCtw5lTf1QjextZgYqvztsntWUmrmMyQbxeFkfjLqIIKPf2vj1t12humKqEbR+iWxC72Gzr0kMXJhjSc6rirO3DD0U+B7yyVlvnJpkRDlu+3GK9WdntmNE1QPzkPetTU79r631TmDcwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UqbNJFQj; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707313967; x=1738849967;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=LJ+qhquQIV7sWyOZXEIik8kiprvLDIOmfTr/MQf2ue4=;
  b=UqbNJFQjMqg1LdYU6glxZd8DpSgEdPEu1FvpIDHxLFcEiOVcOWg50jTl
   k+rnJ02ozziR9zsithNPlq3IXhbeGJ7eSl0CSf9rxT8RsGRgsJSLcDQAo
   qXVcGjEqw6ztwDgOq5ZFVyjxcoblyIuF2YeCveFWd3ALXEGBQdc7T8W74
   B+cr1mpqZ3clQ2RCZqfPn7trfYJu9E+3g2aXNhYSiykrH1s0bXCSzO3P/
   MHD8oIC2a0FkZSOodyPzbG21NtXu+rSOBSWrZ+Kswr89GPRpWYNbzjR0x
   Ypv4nPr/1aCKy6X6HnGMhojaQRLJuiSBqeDctJmWYpAnf/qeLB55NiRq8
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="1134673"
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="1134673"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 05:52:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="6109310"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.51.96])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 05:52:44 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: hdegoede@redhat.com, Armin Wolf <W_Armin@gmx.de>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240206220447.3102-1-W_Armin@gmx.de>
References: <20240206220447.3102-1-W_Armin@gmx.de>
Subject: Re: [PATCH 1/4] platform/x86: wmi: Check if WMxx control method
 exists
Message-Id: <170731395760.2085.5086221738289789312.b4-ty@linux.intel.com>
Date: Wed, 07 Feb 2024 15:52:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3

On Tue, 06 Feb 2024 23:04:44 +0100, Armin Wolf wrote:

> Some devices like the MSI GF63-12VF contain WMI method blocks
> without providing the necessary WMxx ACPI control methods.
> Avoid creating WMI devices for such WMI method blocks since
> the resulting WMI device is going to be unusable.
> 
> 


Thank you for your contribution, it has been applied to my local
review-ilpo branch. Note it will show up in the public
platform-drivers-x86/review-ilpo branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/4] platform/x86: wmi: Check if WMxx control method exists
      commit: 7f1b998a9108f7fd465039323d5fc2599b8cae77
[2/4] platform/x86: wmi: Use FW_BUG when warning about missing control methods
      commit: d0c595a11785573aad3b9e32ae293c48757eceff
[3/4] platform/x86: wmi: Remove unnecessary out-of-memory message
      commit: 49c67cd5b6a4b611ac775de3831f5e739dd580f2
[4/4] platform/x86: wmi: Replace pr_err() with dev_err()
      commit: fde7da1072f3c0239a80b590e7b75c9411e8b630

--
 i.


