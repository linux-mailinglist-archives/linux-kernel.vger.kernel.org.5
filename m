Return-Path: <linux-kernel+bounces-76478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DCBC85F7B5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE2621C23E02
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05AAC5FB87;
	Thu, 22 Feb 2024 12:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QuMmPwtS"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE455F87A
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 12:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708603600; cv=none; b=CaYxhXxfwvJL5MpYo04qJlV0bQC7qoqXcfTrjeVsbBvXLtv1CKHwTUjvxCd3M37B0WbEiNDmQkiuX47uTQWl0A0XoHMfInZCimEgUowFLxj6kJRbQqAd9MBIdKxc4eJ6RL+7TYZyRaYrZ0itixrNUVqwiorYhCTUpaqWnbgpOOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708603600; c=relaxed/simple;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SCoWo5G237ggI7PPAWRoZDq881lLZEbaunhV7hyXamwNDqGbkfJYVVGkk9AZNBbbQGzC9aBrVLWW3uhQxR92bePuk5XjmWW0Abm8Io1ypmOBskIBHOmPJa7pUta3V+MflaoBM0+7IKOak2oaEt1irytvU9rmb79BgT2Pnx/Zu8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QuMmPwtS; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708603598; x=1740139598;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=frcCV1k9oG9oKj3dpUqdJg1PxRT2RSN/XKdLCPjaYaY=;
  b=QuMmPwtSyKzqAshMY3qPJIJ7bhUGo0deuyc/FvxwqMW9oVR+fBVoRTKQ
   F2PQplBs+zwfBv9xDUmqNFLl7dR4thOnXPL64LyYY1CXjsbDiy/ZbXkyr
   Hy6wr8nLVSwM/b5uWtuty+PBE9EWBxDrhwEEdO3KHD9Zy5jYKvHLp1LN+
   44TQelOF3ym0YP9vnqnU18FZeEbGN3FArFLElwEZS5zpgfNiePg3fzcz9
   btWK6EJhwpKrKyg8YOygrNrPec6h/AL73VVNdtqDZkjtLcWVMml2lMH+J
   6oit9K7haPQPE4sDJOFI+qeHHFLAEx8+ykXL8QiWklh1tDC5xQaFcjNVi
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="2684521"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="2684521"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 04:06:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="10211007"
Received: from linux-pnp-server-09.sh.intel.com ([10.239.176.190])
  by orviesa005.jf.intel.com with ESMTP; 22 Feb 2024 04:06:34 -0800
From: rulinhuang <rulin.huang@intel.com>
To: akpm@linux-foundation.org,
	urezki@gmail.com
Cc: colin.king@intel.com,
	hch@infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lstoakes@gmail.com,
	rulin.huang@intel.com,
	tianyou.li@intel.com,
	tim.c.chen@intel.com,
	wangyang.guo@intel.com,
	zhiguo.zhou@intel.com
Subject: Re: [PATCH v3] mm/vmalloc: lock contention optimization under multi-threading
Date: Thu, 22 Feb 2024 07:09:36 -0500
Message-ID: <20240222120936.216430-1-rulin.huang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ZdW2HB-XdAJKph5s@pc636>
References: <ZdW2HB-XdAJKph5s@pc636>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit



