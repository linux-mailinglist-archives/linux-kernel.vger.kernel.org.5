Return-Path: <linux-kernel+bounces-93839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41BD987356C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 12:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D54A31F24ECC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 11:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBFB576900;
	Wed,  6 Mar 2024 11:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H8OcJnab"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A1A5FB91;
	Wed,  6 Mar 2024 11:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709723514; cv=none; b=W8CB1rZTBTw9CJR6hItHax74JkeRP1t9HG7nv/NV0Xh8XqTL1QRdsAOrQvwrCdWdHIXWkrsWaCg9NfFpz05Bn7sjnf+0yMRZnrzVpu/AUEVKu2uwUUOkd3+EWg4Fn+3T7P1kVQwC2qvsCXYIrR6PyKriZisSVzIga+60TWROLT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709723514; c=relaxed/simple;
	bh=A2b1bwOR7rg+shnfBmsvF+nNuz4ACbbwnWjTr0Br2rw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=L6l136lXxhMwPSYko+JAE3WSu42U11uqxfhpYi401QKm3clqaVC8jG0AekldEf/3hXIVQMpOUGzZk5l3SX6pRFzq5wFKfs6xjD5PJaEKTnpOH6u3+jTb4ud2CLNHbwaTkoiinjFWvCUwcHKDXu8gHz0PVcq5P639ZxKFuHj+WNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H8OcJnab; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709723512; x=1741259512;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=A2b1bwOR7rg+shnfBmsvF+nNuz4ACbbwnWjTr0Br2rw=;
  b=H8OcJnab/5n4UZFuXFNKzdRMXnNAeTPeItIjeQw+vWMF5KOS4XEHMEuE
   XUasuthOHInvvZrG2Of8Q/21EOt5E6n40C4TmYTEzj781bVpcARkmglUB
   taCpO7H6ALV4MxbpifNoxMBbb66QfhH9+8s2wAvzXfY1qNPNnjaRhrUQm
   iyXOQeYEW3BgwjUB+zwgzlt5HLpEkeJu3fSw1ACyXfXkFbcste9ffPUHf
   tYYz7go0sQ40AGorB4YQpFjcNc+L6KLlXImZf3Tcdo6hCIZixU+uOvI3k
   UVTNha8oiFXD3W0h/Yxxtay2J5CRIl7fOvWcKKIqcbjwziNiotGDKfk9b
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="4446626"
X-IronPort-AV: E=Sophos;i="6.06,208,1705392000"; 
   d="scan'208";a="4446626"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 03:11:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,208,1705392000"; 
   d="scan'208";a="40609639"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.146])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 03:11:47 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Prasanth Ksr <prasanth.ksr@dell.com>, 
 Hans de Goede <hdegoede@redhat.com>, Jorge Lopez <jorge.lopez2@hp.com>, 
 Mark Pearson <markpearson@lenovo.com>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Dell.Client.Kernel@dell.com, platform-driver-x86@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
In-Reply-To: <20240305-class_cleanup-platform-v1-1-9085c97b9355@marliere.net>
References: <20240305-class_cleanup-platform-v1-1-9085c97b9355@marliere.net>
Subject: Re: [PATCH] platform/x86: make fw_attr_class constant
Message-Id: <170972349774.3698.6241783676827025751.b4-ty@linux.intel.com>
Date: Wed, 06 Mar 2024 13:11:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3

On Tue, 05 Mar 2024 15:55:04 -0300, Ricardo B. Marliere wrote:

> Since commit 43a7206b0963 ("driver core: class: make class_register() take
> a const *"), the driver core allows for struct class to be in read-only
> memory, so move the fw_attr_class structure to be declared at build time
> placing it into read-only memory, instead of having to be dynamically
> allocated at boot time.
> 
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo branch. Note it will show up in the public
platform-drivers-x86/review-ilpo branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86: make fw_attr_class constant
      commit: 04f53f56655d733c91e9cedfbf0bf9882f6015b6

--
 i.


