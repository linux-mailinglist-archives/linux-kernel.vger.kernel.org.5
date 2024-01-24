Return-Path: <linux-kernel+bounces-36834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B05183A787
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 12:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EC881F22D96
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 11:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978901B59E;
	Wed, 24 Jan 2024 11:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kt8kBt1d"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4061B270;
	Wed, 24 Jan 2024 11:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706094619; cv=none; b=EYckNteAs6J3UjQpOS26fjwpuJcd6ke9kdKIt+Zmuy7JlB3aYTauExrerPV0TdihQWgCksgovAU8Eobkd/zMDXO9GwBhagK30gSFY/R+msL66sSspLG6RXXM+fr0nbd54lz4Y+yQaWOzySUN76MffT1tMJ5MTobWn6m+WYl7GcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706094619; c=relaxed/simple;
	bh=+w+VRj28ZZ5d/t/eU5tEL2OQlofsSoXJCeaJoafaDuM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=G99Iy28MJFr2/5RbxufayzL0Nr7vAKC+SYnLnNu3bN+UeepFZExxvV1DlXovP/Khun88nNeqpbV2yo1VpyhS1r/pzVfcRpWfPME1SVweOmlrVQCEpWGoJTUr5hBSUr7aFeI//5m/taiUlIrO8XlkpdU7RjRf+80jV3oI62ui5W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kt8kBt1d; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706094619; x=1737630619;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=+w+VRj28ZZ5d/t/eU5tEL2OQlofsSoXJCeaJoafaDuM=;
  b=kt8kBt1d9e4AFhM5eGCqbvSh4eqrn3L4Uv5QGfYr8llVp+ZYwNpw9tYk
   H9c13iosz5gMSMVIJ1OWyjJgm7E6QZyoyNW63PL1WpjBmeilUlU+hkTMv
   DYhyETDgV4CYBjdVoUz04ZlKY3xV6dphDY+Tamk0g036TUSqqEE2JEDz6
   UYcOYovIQu1Z/oQgQbJhQZ5hdJNjoh2BgewKdfh3/tlgwKvLTNrjxISZu
   FYpF3WKXGPZB2P0tRprATs/Qccu3FnhRAXiOyqQSzTsBiQXo/Tv0DdXJl
   DcsLOwkA/pWFygss/2dqgyvtOrA2IX16C62P9ylXhM8rk0OktTrxn0LTp
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="8922933"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="8922933"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 03:10:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="929646645"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="929646645"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.48.46])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 03:10:16 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: hdegoede@redhat.com, Armin Wolf <W_Armin@gmx.de>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240121200824.2778-1-W_Armin@gmx.de>
References: <20240121200824.2778-1-W_Armin@gmx.de>
Subject: Re: [PATCH v2] platform/x86: wmi: Use ACPI device name in netlink
 event
Message-Id: <170609461058.14533.1507817163086160025.b4-ty@linux.intel.com>
Date: Wed, 24 Jan 2024 13:10:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3

On Sun, 21 Jan 2024 21:08:24 +0100, Armin Wolf wrote:

> The device name inside the ACPI netlink event is limited to
> 15 characters, so the WMI device name will get truncated.
> 
> This can be observed with kacpimon when receiving an event
> from WMI device "9DBB5994-A997-11DA-B012-B622A1EF5492":
> 
> 	netlink:  9DBB5994-A997- 000000d0 00000000
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo branch. Note it will show up in the public
platform-drivers-x86/review-ilpo branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86: wmi: Use ACPI device name in netlink event
      commit: 3f399b5d7189bcb608c75abc85fe39f7a5509cfa

--
 i.


