Return-Path: <linux-kernel+bounces-90629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 194AC870275
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 14:17:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8DE4B27220
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 13:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E6F3EA74;
	Mon,  4 Mar 2024 13:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O71PnSBA"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB90C3D3BE;
	Mon,  4 Mar 2024 13:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709558236; cv=none; b=XIvHWUUS3igwHu6irM6Jb1na9ltYfo9oJED4524NxpUtaSwc6dnZX53lNsb1bMllShIYSxNgsfiXCVxhDjbUz7lv6wGlaZEZeyRB3ARwlz20zBuazMTCCRFWPONc/lx0lHOTeew0zVfHtQKjEE6cbVbwSVjZW3oPWIHStTkBoV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709558236; c=relaxed/simple;
	bh=xdnfnXAPoXai/PKBNe/jGm6kOPUz6a+yu7Z7OrhS8fU=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PHyVWkCK3aI+cERRcB3Pp2128AixZdtpFpeHYPTdo0RGr5Uldt/L28aYAutmkSxR3el8zTOIBdsMFkMt5gkjo2tf915e4DDoOP02unRBBWWxs2aBZEdrGXgVB36K5lopc96RiWMOPdZ9I0BYftb1vrpcBXuvQOdNZa4JZPqAxqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O71PnSBA; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709558234; x=1741094234;
  h=from:to:in-reply-to:references:subject:message-id:date:
   mime-version:content-transfer-encoding;
  bh=xdnfnXAPoXai/PKBNe/jGm6kOPUz6a+yu7Z7OrhS8fU=;
  b=O71PnSBAhjcgXeRFwaYAlSkFLAdeMBhsfZb2AHNvTrSBVOHAA8ZaVzme
   WPf1rMAeUMkmjswyNXwRtt/fRrAmYX3u2Yikj2csZT4Xe7pbk2ZRIunlv
   pr/Ukxukz9Y8pjam7np3t/CnAaVFyrMKSTW1EjQnBGEh1llffUTM+tggX
   WdqiTQpSFhALX41d9XN/1YJrtlB2X3UMp+g5ALT9KySkPw6m9ZnWTfKWk
   fNpCBf6dBKYjfsJdKbXOfPJk5EK9F1LAgQr72zUIjpjCySlGm6JBc5MS6
   iU7wMDDx15FH11qxlKSeLKP0ddiwpcqjrLTtqzrX/PUxd/uyoJzB+naSt
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="4625160"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="4625160"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 05:17:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="8905155"
Received: from ekohn-mobl1.ger.corp.intel.com (HELO localhost) ([10.246.49.145])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 05:17:10 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: hdegoede@redhat.com, linux-input@vger.kernel.org, 
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Alban_Boy=C3=A9?= <alban.boye@protonmail.com>
In-Reply-To: <20240227223919.11587-1-alban.boye@protonmail.com>
References: <20240227223919.11587-1-alban.boye@protonmail.com>
Subject: Re: [PATCH] platform/x86: touchscreen_dmi: Add an extra entry for
 a variant of the Chuwi Vi8 tablet
Message-Id: <170955822522.5357.960339169691404001.b4-ty@linux.intel.com>
Date: Mon, 04 Mar 2024 15:17:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.3

On Tue, 27 Feb 2024 22:40:17 +0000, Alban Boyé wrote:

> 



Thank you for your contribution, it has been applied to my local
review-ilpo branch. Note it will show up in the public
platform-drivers-x86/review-ilpo branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86: touchscreen_dmi: Add an extra entry for a variant of the Chuwi Vi8 tablet
      commit: a8170d6a5d310eeaa3ecf3bbc8e3835004723f36

--
 i.


