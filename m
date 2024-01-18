Return-Path: <linux-kernel+bounces-30622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC0DC83221D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 00:05:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C50AB23304
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 23:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ADA91E88F;
	Thu, 18 Jan 2024 23:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U4TRNLYO"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1345F1DFE6
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 23:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705619099; cv=none; b=gubRRDsSOUWr6WzZN4r16jOQt7alHlvq//4m73nc/ygxMomWf8S58TGWxX+3jN8BSW5FRcxWaIuX4bj0nsq927lGoV7noEsTGs1VRLkbcO9qzNQhmsT3YOw2fDtxMob+Zoh2L7lLA6iNIByeGjqgmznorq7A8HMT4yI4RM0t1cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705619099; c=relaxed/simple;
	bh=pXV1Phm7gXXc/IcPaGLWOcCoYm5um13/FmP8uLYS4j0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UKcawRq7XXEUdXBokK9L1To3giFqn75e6lLXTElmNLvMpDFZzFTq+t2FKz96eXTnf6CsS+CHxdQ4Rg6MXnb/M/lb21bxD+nJrHSxJEsZ2pvfh2VcBr1OieX2yeWMDpLrbWTCaVvQFu41/dQmMDc6IYA3E+HN+Ii724YGjsMMSic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U4TRNLYO; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705619098; x=1737155098;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=pXV1Phm7gXXc/IcPaGLWOcCoYm5um13/FmP8uLYS4j0=;
  b=U4TRNLYODtIBiHDaXdfZPGzJ3W4aHzpAqTnyiYMJeOglYnFl1pH5Uaky
   pCI4ixdwEzGw0TFa7Tvbf9pBuRGPlqE4RTkFp27gjbdHSqg9J0pQ0ZY1u
   JokxwAPk5ZGoi+DLics0f06ehJNviVV9ROIccpDh5jSZd/GzpPQqgzSMM
   hTNy+KxSwcBTQ59tlF3/tzjzipOWi9fVi7Gv49Q6eJ4a0Ql57lnD6bvWg
   q1JE56wOQUk1E6y/btOfrzsVIqGN5qAVRjSsKExdEtQsUaFqj4sL/wPqy
   IILkA0z5op4+tTV/jCCm17UGGaQ0jcfXQqnN0Ivl1sYPaM4TwURo+ullQ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="7310168"
X-IronPort-AV: E=Sophos;i="6.05,203,1701158400"; 
   d="scan'208";a="7310168"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2024 15:04:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="784913168"
X-IronPort-AV: E=Sophos;i="6.05,203,1701158400"; 
   d="scan'208";a="784913168"
Received: from dbhadrax-mobl5.amr.corp.intel.com (HELO [10.209.111.124]) ([10.209.111.124])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2024 15:04:56 -0800
Message-ID: <29695e89ae2d838c9b7537941b0231c3ff559e48.camel@linux.intel.com>
Subject: Re: [PATCH v4 3/7] padata: dispatch works on different nodes
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Gang Li <gang.li@linux.dev>, David Hildenbrand <david@redhat.com>, David
 Rientjes <rientjes@google.com>, Mike Kravetz <mike.kravetz@oracle.com>,
 Muchun Song <muchun.song@linux.dev>, Andrew Morton
 <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 ligang.bdlg@bytedance.com
Date: Thu, 18 Jan 2024 15:04:55 -0800
In-Reply-To: <20240118123911.88833-4-gang.li@linux.dev>
References: <20240118123911.88833-1-gang.li@linux.dev>
	 <20240118123911.88833-4-gang.li@linux.dev>
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
> When a group of tasks that access different nodes are scheduled on the
> same node, they may encounter bandwidth bottlenecks and access latency.
>=20
> Thus, numa_aware flag is introduced here, allowing tasks to be
> distributed across different nodes to fully utilize the advantage of
> multi-node systems.
>=20
> Signed-off-by: Gang Li <gang.li@linux.dev>
> Tested-by: David Rientjes <rientjes@google.com>
> ---
>  include/linux/padata.h |  3 +++
>  kernel/padata.c        | 14 ++++++++++++--
>  mm/mm_init.c           |  1 +
>  3 files changed, 16 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/linux/padata.h b/include/linux/padata.h
> index 495b16b6b4d7..f79ccd50e7f4 100644
> --- a/include/linux/padata.h
> +++ b/include/linux/padata.h
> @@ -137,6 +137,8 @@ struct padata_shell {
>   *             appropriate for one worker thread to do at once.
>   * @max_threads: Max threads to use for the job, actual number may be le=
ss
>   *               depending on task size and minimum chunk size.
> + * @numa_aware: Dispatch jobs to different nodes. If a node only has mem=
ory but
> + *              no CPU, dispatch its jobs to a random CPU.

Suggest:
Distribute jobs to different nodes with CPU in a round robin fashion.

>   */
>  struct padata_mt_job {


