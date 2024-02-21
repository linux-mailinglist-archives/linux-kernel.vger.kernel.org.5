Return-Path: <linux-kernel+bounces-74001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8864F85CEC8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 04:31:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 419EA284E74
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 03:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2A538F9B;
	Wed, 21 Feb 2024 03:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n2BvVLYw"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F0825613
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 03:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708486289; cv=none; b=COIugsmg0jU9dcy1LVv+/eJZOirR6w35dwLG4LcejAFg4YUMMShDGmptMyKdWbrRc/b1Dn64pKgj5qbOCTTxLhg/RHevEhiigg/fTIabp9XtAPxI1Q1ZjZJHtn441TMpCv1k0AUzVlxGBoBRzq0wLuMCvUcaJxhhvFxpTJO9n4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708486289; c=relaxed/simple;
	bh=KV8QmrFI8YYdbcwr7sQty9uDvR+BGYzuPsHhVy4OLs4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MCs6hdC5AY7EDkT/LCykdCJ3xDPm0JSVw8AnMrr2qZ+31kQioycEVUN2XekKvzZmqN7ybPFtaQr7B6hAYXqkZKpTYU/yGf9dR/WfjDyDFe5uZHsCrLRBxztXO0o/cQAMyDsdE7n9rULcvGo9HhEB/iwDqnqjA3k/fGSvvWeoIAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n2BvVLYw; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708486288; x=1740022288;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KV8QmrFI8YYdbcwr7sQty9uDvR+BGYzuPsHhVy4OLs4=;
  b=n2BvVLYwW/5m2eNZpytDY/MYG/ymK0KW4GR5cdLm7Eeg7JnqVjGZGbwM
   cbjJonAYib2gVf7bU02c6pE4ZjieCQqdosVkl8MqRVvo/wEelbaGfPut+
   D8OGtO0UALqljouSOfsLx8lFc5VF/HqyW1we3IhA+m54GVfcxmiu4dObw
   6830+QUaaxoQ2puJTlUdI37GaOm0gXQs7rhaQhL6BII/27O14rcQhNCh6
   gvN6F/4zNfqit1sRVpEDKt0Ko7hiFHJzLBaRKTspZKX8wXKtI+JYL4SJF
   5XdV8n520/vewsxtWUeiQBFXoJD0vI9/9K1L2OzvcUfsgfM2bLnlse6If
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="2779697"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="2779697"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 19:31:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="4953886"
Received: from linux-pnp-server-09.sh.intel.com ([10.239.176.190])
  by fmviesa009.fm.intel.com with ESMTP; 20 Feb 2024 19:31:24 -0800
From: rulinhuang <rulin.huang@intel.com>
To: akpm@linux-foundation.org
Cc: colin.king@intel.com,
	hch@infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lstoakes@gmail.com,
	rulin.huang@intel.com,
	tianyou.li@intel.com,
	tim.c.chen@intel.com,
	urezki@gmail.com,
	wangyang.guo@intel.com,
	zhiguo.zhou@intel.com
Subject: Re: [PATCH v2] mm/vmalloc: lock contention optimization under multi-threading
Date: Tue, 20 Feb 2024 22:34:25 -0500
Message-ID: <20240221033425.11972-1-rulin.huang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240220115433.4d76e50c46454f7aabb7b93d@linux-foundation.org>
References: <20240220115433.4d76e50c46454f7aabb7b93d@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Andrew, we have rebased it on 6.8-rc5.
Thank you for your review.

