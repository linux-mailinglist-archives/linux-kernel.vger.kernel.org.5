Return-Path: <linux-kernel+bounces-22870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5EBA82A4B5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 00:01:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED70F1C22BE3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 23:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2454A4F897;
	Wed, 10 Jan 2024 23:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a54uqtiX"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B724CDE1
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 23:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704927697; x=1736463697;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=3+OaQQdytDnhe9opJRAlwti2hrQ+ESQmSUVck2AcGXs=;
  b=a54uqtiX+nUDe6OYc2l18sBNz2YMfzXGlds07ew9wxcLr4MxbfwA4vk2
   ypBRFPA4yTJ606U5FvfE9D1Y0SwxjjK8lplHH/Hd2GOIMmS7zmugRDxaw
   VgwJmH6o5vOpXmwQuIT/yclOS2C9NrN3aDBa1nuSAQgqyAEz7mNmJpAv4
   AbpHpKhBDBUwGrfCn3IT2w60ebG/F0OytmGD2Ws7N6owOpQolftHTr/LX
   DP9G6tdx3tbq3zaMRkNR04Yxccz7Dp7FLYuRfCHoXaMutyZTdQZqiV7q6
   wnT3s8l1GtT9k7JMaLlcmSzmp66PfZguXqmrKsbPJ+j+/yRfUuTVFzffw
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="465067552"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="465067552"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 15:01:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="925799297"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="925799297"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.54.38.190])
  by fmsmga001.fm.intel.com with ESMTP; 10 Jan 2024 15:01:36 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
	id 2636F301C53; Wed, 10 Jan 2024 15:01:36 -0800 (PST)
From: Andi Kleen <ak@linux.intel.com>
To: Oscar Salvador <osalvador@suse.de>
Cc: andrey.konovalov@linux.dev,  Andrew Morton <akpm@linux-foundation.org>,
  Andrey Konovalov <andreyknvl@gmail.com>,  Marco Elver <elver@google.com>,
  Alexander Potapenko <glider@google.com>,  Dmitry Vyukov
 <dvyukov@google.com>,  Vlastimil Babka <vbabka@suse.cz>,
  kasan-dev@googlegroups.com,  Evgenii Stepanov <eugenis@google.com>,
  linux-mm@kvack.org,  linux-kernel@vger.kernel.org,  Andrey Konovalov
 <andreyknvl@google.com>
Subject: Re: [PATCH v4 12/22] lib/stackdepot: use read/write lock
In-Reply-To: <ZZUlgs69iTTlG8Lh@localhost.localdomain> (Oscar Salvador's
	message of "Wed, 3 Jan 2024 10:14:42 +0100")
References: <cover.1700502145.git.andreyknvl@google.com>
	<9f81ffcc4bb422ebb6326a65a770bf1918634cbb.1700502145.git.andreyknvl@google.com>
	<ZZUlgs69iTTlG8Lh@localhost.localdomain>
Date: Wed, 10 Jan 2024 15:01:36 -0800
Message-ID: <87sf34lrn3.fsf@linux.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Oscar Salvador <osalvador@suse.de> writes:
>> 
>> With this change, multiple users can still look up records in parallel.

That's a severe misunderstanding -- rwlocks always bounce a cache line,
so the parallelism is significantly reduced.

Normally rwlocks are only worth it if your critical region is quite long.

>> 
>> This is preparatory patch for implementing the eviction of stack records
>> from the stack depot.
>> 
>> Reviewed-by: Alexander Potapenko <glider@google.com>
>> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>


Has anyone benchmarked this on a high core count machine? It sounds
pretty bad if every lock aquisition starts bouncing a single cache line.

Consider using RCU or similar.

-Andi

