Return-Path: <linux-kernel+bounces-76481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DFFD85F7BB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:07:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B96F31F231CC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858155F84D;
	Thu, 22 Feb 2024 12:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fe2xFJoP"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B823F9ED
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 12:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708603667; cv=none; b=aDpzChtt+ipnGIKSumH28xfFoAY9wBiERs1XgA6NUk/0FoTLKXxASPSaNooaERJ0J7sl6iVxzkqSfZHoMbZ3TV2dohOvFgQvSBO2yVCQ/4Wz+a514WynSL/PXnTFGushF5SaBU95WzKhBqorb0+gfaVh2jG5LRnyGPuNOceVdOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708603667; c=relaxed/simple;
	bh=OyVyEzm6PAoZwqACVETHMIR8OveG5ztRrupRqvUuqXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EhRs0ncOeGKofgQ/4erSe237xj21h+wF4dQfjsnq3HjyIngDhbOif9ELN42OIZ46LBXO85Ytxojp81at3XY0ygnwIXp1Pst21/BQOhGOjO9SUBp3pF8A3HuYAqsa5edvHOKtDHR7jx8a33/GI5We60eYfiG66hMjByJbdoWWs4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fe2xFJoP; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708603666; x=1740139666;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OyVyEzm6PAoZwqACVETHMIR8OveG5ztRrupRqvUuqXc=;
  b=fe2xFJoPE0Swie4uo3RzkcWmuWYyywmhtkao1Spr2HUmfzYgjgvrlig0
   5n93jMpdexgM1wYGqz8UejAHDVFRFJMg/iQz1ZFolYk9oypY1hbuTPHLB
   3C8RmO9cMALLdUTJCJJHKXxgh8hQGwA1ja2FCe85tdz8u4KZYJLcRdKq5
   OUXQKD3N5YpOoC80mSFe26PX/B4fGu7JAKoxlj+0Rmv9YaD2rA7nhAPun
   mDOYd93qDWsLXng8RCYSF5oBNb3dh8gzKsBTWsV7NfeFPpLQk47fLqfB/
   0c55ezYfus09ZBz2AUMaeSClyszkr7nRX9SYK/65t0BIG/Gt537w9118+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="2974025"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="2974025"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 04:07:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="5843178"
Received: from linux-pnp-server-09.sh.intel.com ([10.239.176.190])
  by orviesa006.jf.intel.com with ESMTP; 22 Feb 2024 04:07:42 -0800
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
Date: Thu, 22 Feb 2024 07:10:45 -0500
Message-ID: <20240222121045.216556-1-rulin.huang@intel.com>
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

Hi Uladzislau and Andrew, we have rebased it(Patch v4) on branch 
mm-unstable and remeasured it. Could you kindly help confirm if 
this is the right base to work on?
Compared to the previous result at kernel v6.7 with a 5% performance 
gain on intel icelake(160 vcpu), we only had a 0.6% with this commit 
base. But we think our modification still has some significance. On 
the one hand, this does reduce a critical section. On the other hand, 
we have a 4% performance gain on intel sapphire rapids(224 vcpu), 
which suggests more performance improvement would likely be achieved 
when the core count of processors increases to hundreds or 
even thousands.
Thank you again for your comments.

