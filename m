Return-Path: <linux-kernel+bounces-63473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B964E853009
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 13:02:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 758FC28593C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833E938DD5;
	Tue, 13 Feb 2024 12:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RwjyCxY2"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD4838380;
	Tue, 13 Feb 2024 12:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707825718; cv=none; b=SKPQqujR3hN/P/tMrQnDqESUEpO0diSCuHRzu21VPGPdQPHwm9yOSrJEhshSJGrQdOAH4pY2nTLKABiv3oYutBngo8/bsBKyVTbqSYN86MzwyMysLGWWVKRnfv3WyP5hyyYQudeCUYn1nWwEH6EG5Hns7hHa9CJ946DxEfVed+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707825718; c=relaxed/simple;
	bh=cNukAC2lj8Vitoz014bWjpa4UuuRTFxJ/G1TZ9IGHeU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HtuWrWj4pIzv/beL/jEcJpBHGsn3uPASxjywrFVpky7/Vd8k8N7lnxzD0EkVIgRJgCLt9ZvM47eKE/dj2qNMxwXeik5rgUTAnkJffg3NCRTHKeBM1YrpmlBToVLprKHRFHjTY6+E66RMmj8tcy2y8GkgexUvljC1BbQN2aAIS10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RwjyCxY2; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707825717; x=1739361717;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=cNukAC2lj8Vitoz014bWjpa4UuuRTFxJ/G1TZ9IGHeU=;
  b=RwjyCxY2aNuXVYP9b/nyor3K7MxKfoIMgiNdf/r71oJ9i2YxcjnhoZOW
   g6BWA0eMEJ2dABwp/Llkt/xAshPmBprusptuoNWo957gv8ZtkEAkGKjfC
   mpDd6kKo69k36b08kUYakmMIlL+e6bK6/ScIqfBLHFa8rU5Y5YX6brzih
   RDs9+e7x7R8jt3i9z66DMcdPiL9uUM+8WxCtZChVGUGFqbHsy1Ou2hI03
   ChE3TT3x7cf7n5x/5u0Zhkdj8PdNSY/qCQguo3iHn4xE6IRolLGMzxs8A
   TX8qD5h8XtKJNCBYCWHDe1krMakxtnj+0PNz4b6MWzjZLUdn43JE9wPuU
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="1682360"
X-IronPort-AV: E=Sophos;i="6.06,157,1705392000"; 
   d="scan'208";a="1682360"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 04:01:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,157,1705392000"; 
   d="scan'208";a="7508828"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.32.103])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 04:01:54 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Ike Panhc <ike.pan@canonical.com>, Hans de Goede <hdegoede@redhat.com>, 
 Gergo Koteles <soyer@irl.hu>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <0cdbc0e6eb65e160384ae0ed152e7de3ded1d9d5.1707604991.git.soyer@irl.hu>
References: <0cdbc0e6eb65e160384ae0ed152e7de3ded1d9d5.1707604991.git.soyer@irl.hu>
Subject: Re: [PATCH] platform/x86: ideapad-laptop: support Fn+R
 dual-function key
Message-Id: <170782570805.2763.12736496055327560798.b4-ty@linux.intel.com>
Date: Tue, 13 Feb 2024 14:01:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3

On Sat, 10 Feb 2024 23:51:57 +0100, Gergo Koteles wrote:

> According to the manual, Fn+R adjusts the display refresh rate.
> Map Fn+R to KEY_DISPLAYTOGGLE.
> 
> 


Thank you for your contribution, it has been applied to my local
review-ilpo branch. Note it will show up in the public
platform-drivers-x86/review-ilpo branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86: ideapad-laptop: support Fn+R dual-function key
      commit: c5211eacf3326538fbf31b612e5ea546ca8a3425

--
 i.


