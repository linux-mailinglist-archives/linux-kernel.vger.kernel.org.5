Return-Path: <linux-kernel+bounces-99926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96EE4878F44
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 08:54:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C95761C2099C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 07:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398AD69D03;
	Tue, 12 Mar 2024 07:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="immu3X6c"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB69F6996F
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 07:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710230048; cv=none; b=mmV263KiCwsMMRpf9mgvswIe6OkjBI/212RGKxXq6nRdbmYqukfLlAs+Vt0Ey8dxFLwFXyQyv4v6Sh51Ri7YqLpUoxK0xGnJB4QZjlFRWQ9LkS6HTwwCOpdlvni5FF9BfFwU+V2l39V/QiSbG3s8dX9hO11owp+IasfuHLTxkqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710230048; c=relaxed/simple;
	bh=NxNmcKhf9PiRD5MQkaPrTZ0o2xgPuVzoEHnYIYjDzZo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pbKNOSFimCP0PLiBmkGhJX6wizU/GwI2oslciZttlswmm2QaoDgLDX7t4VN5bCcEXCjDJNsbIJ/4nmBRBapes65oZFIqRszwHrZRhz0GXC7BJ/YfMxgAu5d11DhiOShsXojE6MNye5pczS6W6hgeYGH8HNi7fLkKCpZ4kqInA7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=immu3X6c; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710230047; x=1741766047;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=NxNmcKhf9PiRD5MQkaPrTZ0o2xgPuVzoEHnYIYjDzZo=;
  b=immu3X6cP0BEgXSBWBXgXsk7Iu1eyG8mmnej8uk1nyT5ERReiSNrUwu7
   FTlRzwloUU178WAnpC1EadFM12Cwe0JfNfb+YpGAm4X9AJJZ88fVPpVcw
   /QL2NRjOVqCTFoUBaDsDrM0SVvgk9hyL+tF/giZRVyD0KcTVuyLPD7TZA
   vi4zLUeXOBXgrtd6p2NStKbCQxz/+T3B6JMzSPcG2S0DP0SpaW84J4fpC
   FBBnTEMrTiBfYz0ZqnbxK3g12PCZ1VLr7CZIjJ/djIlbGHnHXDv9tV+Np
   jPdO/3e0Jtl1KDnOIupTkb+uK7CeCoYq/S6lHLoJsZ6wQ9b4z8g39dgwu
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11010"; a="16364924"
X-IronPort-AV: E=Sophos;i="6.07,118,1708416000"; 
   d="scan'208";a="16364924"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 00:54:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,118,1708416000"; 
   d="scan'208";a="34630087"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 00:54:02 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,  David Hildenbrand
 <david@redhat.com>,  Matthew Wilcox <willy@infradead.org>,  Gao Xiang
 <xiang@kernel.org>,  Yu Zhao <yuzhao@google.com>,  Yang Shi
 <shy828301@gmail.com>,  Michal Hocko <mhocko@suse.com>,  Kefeng Wang
 <wangkefeng.wang@huawei.com>,  Barry Song <21cnbao@gmail.com>,  Chris Li
 <chrisl@kernel.org>,  <linux-mm@kvack.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 3/6] mm: swap: Simplify struct percpu_cluster
In-Reply-To: <20240311150058.1122862-4-ryan.roberts@arm.com> (Ryan Roberts's
	message of "Mon, 11 Mar 2024 15:00:55 +0000")
References: <20240311150058.1122862-1-ryan.roberts@arm.com>
	<20240311150058.1122862-4-ryan.roberts@arm.com>
Date: Tue, 12 Mar 2024 15:52:08 +0800
Message-ID: <87cyrz51lj.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Ryan Roberts <ryan.roberts@arm.com> writes:

> struct percpu_cluster stores the index of cpu's current cluster and the
> offset of the next entry that will be allocated for the cpu. These two
> pieces of information are redundant because the cluster index is just
> (offset / SWAPFILE_CLUSTER). The only reason for explicitly keeping the
> cluster index is because the structure used for it also has a flag to
> indicate "no cluster". However this data structure also contains a spin
> lock, which is never used in this context, as a side effect the code
> copies the spinlock_t structure, which is questionable coding practice
> in my view.
>
> So let's clean this up and store only the next offset, and use a
> sentinal value (SWAP_NEXT_INVALID) to indicate "no cluster".
> SWAP_NEXT_INVALID is chosen to be 0, because 0 will never be seen
> legitimately; The first page in the swap file is the swap header, which
> is always marked bad to prevent it from being allocated as an entry.
> This also prevents the cluster to which it belongs being marked free, so
> it will never appear on the free list.
>
> This change saves 16 bytes per cpu. And given we are shortly going to
> extend this mechanism to be per-cpu-AND-per-order, we will end up saving
> 16 * 9 = 144 bytes per cpu, which adds up if you have 256 cpus in the
> system.
>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>

LGTM, Thanks!

--
Best Regards,
Huang, Ying


