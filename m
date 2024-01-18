Return-Path: <linux-kernel+bounces-30613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C363583220F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 00:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6D5BB2332B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 23:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620BD1DA51;
	Thu, 18 Jan 2024 23:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TvJQb6uT"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABDFB671
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 23:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705618867; cv=none; b=d0SW1JsoyfT2+6iC1x/TwS0IQyR3ZcW9bJZywFomOJlRtKuUjbUvOYPRY5cD/P3yr+34oicLg/HUQWbjopvRnvhamqZkN4Iu0wchMUud4ijkH6RGg6e5Qnbmc5/g1Cnb4Y8q4q/8vSBs1uM4K0E+VfrmA9RElLnQGy2eYsUeH7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705618867; c=relaxed/simple;
	bh=Df+q970LY3Erw7k12oYwqIm5lQVyyvRUn7IgjVBBvKo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NfivTXpKFOG0SFbMblC27ub305nHVPlZR8h7tuV/+qwySkqo1TdbbQQWbaUbzFCdUMKCTbbKpOlc29s958FAOCEHiFHztGH7CJtBLREjdjqk28Qlg/1NiJajQfhkAfLQhBDsoYYhpmH04rwsBLXn4EbSsLNiNxlMIJOUvo6WZsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TvJQb6uT; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705618864; x=1737154864;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=Df+q970LY3Erw7k12oYwqIm5lQVyyvRUn7IgjVBBvKo=;
  b=TvJQb6uTV1TYge33RlACS2CYLeUPzJGCwEUbUEDpdx5E/OiI/5N5aUsj
   i5M1wBijyDVfJGAEVvWamRUi3V8YSLnJ2zRnJYdXr34RmUGDRJfG819X8
   CUO7FGrS3J+GSCO5UWbl+FeKz7eY6WcpfaPaRpuhBMlJp+Hpq2ZMdJYMm
   /I/OjHle+QsURlf1WIRTGj53/ht81w16njB3a9UpLnkrSTeJmOpVny0CL
   FMaLE2JO29++f/QijNPbTxdMgzIal+vl0io95b2cqoDmlvtMBeIbb9DMp
   WhQbnz1ICZGtIDBfHFzpaKlkR99ICtTcM8UXSgXAIOms0nZ6DNRYH565B
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="13957623"
X-IronPort-AV: E=Sophos;i="6.05,203,1701158400"; 
   d="scan'208";a="13957623"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2024 15:01:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="903971134"
X-IronPort-AV: E=Sophos;i="6.05,203,1701158400"; 
   d="scan'208";a="903971134"
Received: from dbhadrax-mobl5.amr.corp.intel.com (HELO [10.209.111.124]) ([10.209.111.124])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2024 15:01:02 -0800
Message-ID: <fbb6448321a94c32ac60bcf3a6858c045863c44b.camel@linux.intel.com>
Subject: Re: [PATCH v4 4/7] hugetlb: pass *next_nid_to_alloc directly to
 for_each_node_mask_to_alloc
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Gang Li <gang.li@linux.dev>, David Hildenbrand <david@redhat.com>, David
 Rientjes <rientjes@google.com>, Mike Kravetz <mike.kravetz@oracle.com>,
 Muchun Song <muchun.song@linux.dev>, Andrew Morton
 <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 ligang.bdlg@bytedance.com
Date: Thu, 18 Jan 2024 15:01:01 -0800
In-Reply-To: <20240118123911.88833-5-gang.li@linux.dev>
References: <20240118123911.88833-1-gang.li@linux.dev>
	 <20240118123911.88833-5-gang.li@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-01-18 at 20:39 +0800, Gang Li wrote:
> With parallelization of hugetlb allocation across different threads, each
> thread works on a differnet node to allocate pages from, instead of all
> allocating from a common node h->next_nid_to_alloc.  To address this, it'=
s
> necessary to assign a separate next_nid_to_alloc for each thread.
>=20
> Consequently, the hstate_next_node_to_alloc and for_each_node_mask_to_all=
oc
> have been modified to directly accept a *next_nid_to_alloc parameter,
> ensuring thread-specific allocation and avoiding concurrent access issues=
.
>=20
> Signed-off-by: Gang Li <gang.li@linux.dev>
> Tested-by: David Rientjes <rientjes@google.com>

Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>

> ---


