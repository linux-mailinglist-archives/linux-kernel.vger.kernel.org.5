Return-Path: <linux-kernel+bounces-138964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 811A989FCB9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 18:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CB2C28705E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B644317A92F;
	Wed, 10 Apr 2024 16:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZJXYmqS2"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83737179211
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 16:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712766000; cv=none; b=YIOhQeD3XOLNOCVBLS4w/aeea19fWVFDQkCslQCc45IuZOTz+PXjVa66NFRwpSwe7TqLNwUiIubdCBvwdz5NULWXUJczMLwplAMzwhhA9ewonetWyqAvmnc4BXXyLg4RDxWJvGQCbVQGnWoHmo/0ssDHZ5WbVY7GcKTRPa5bQQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712766000; c=relaxed/simple;
	bh=nkV9cGAED/z/VIex+b/PSuJe4lylFvXK/ooyXd9u+WY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=axB4edE1ImxMdFSP+kipqnwbWPj0zOkQBxMlzv7mxqMjY/csJ+AG2uBeAXWJuDHI4djYvKdDGdKeZ84rqiDlKkpUKxMIMdkrZX8NYxr7qmnamFZjPiBV9b+qABa647FEgwkYJlEZpM2WxyTM2huHYNAnFOaAhgzbPDdO3RaTpKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZJXYmqS2; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712765998; x=1744301998;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nkV9cGAED/z/VIex+b/PSuJe4lylFvXK/ooyXd9u+WY=;
  b=ZJXYmqS2DxPorsv2MqSAXZ8xfEEtk7S5CVDihJLU04xkReyo8VIQpLEO
   BR3YYXlxVQ/TuTesiYyc9jN4ILYFnMdjQ+CnsES7F5pqV/QB0V/P4MbIM
   zlZMrHWUjPny7rGSK917n3xxiZUG+5Bt3HpM0waxRkVP9NDdPDsJDhLbW
   cuNeD4iwm1WEQE23bEzZ88tzw0inlXAT8+TFT54CtB2jYQbXhWdmuNPU+
   GtIlkD4C0kJTvQ9ImKRt6kGqsWYxVhV06yOybb30ThqZt5m3mJZlgnvii
   BwUTIAzXsfEQWbi5UD6gpIuEplJ1P6/YtXJprvh4QLwz/tPb1Bm9nhF/n
   Q==;
X-CSE-ConnectionGUID: qUvY5rB/TxipkbOd3248wA==
X-CSE-MsgGUID: Op++Am38Qbuu6eBy2j4jhA==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="8316628"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="8316628"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 09:15:26 -0700
X-CSE-ConnectionGUID: bYm3/WcVRy6UqtcJM8vh6g==
X-CSE-MsgGUID: lJv4/ogSSgGrN2eFG8qM4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="20570377"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.54.39.125])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 09:15:25 -0700
Date: Wed, 10 Apr 2024 09:19:55 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, "Liu, Yi L" <yi.l.liu@intel.com>, Joerg Roedel
 <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
 <robin.murphy@arm.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH 2/2] iommu/vt-d: Remove caching mode check before devtlb
 flush
Message-ID: <20240410091955.5c00e411@jacob-builder>
In-Reply-To: <BN9PR11MB52763F42ED6719E6D03D0D308C062@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240407144232.190355-1-baolu.lu@linux.intel.com>
	<20240407144232.190355-2-baolu.lu@linux.intel.com>
	<20240408140329.6290377f@jacob-builder>
	<aff42b8f-b757-4422-9ebe-741a4b894b6c@linux.intel.com>
	<20240409103146.0d155e45@jacob-builder>
	<BN9PR11MB52763F42ED6719E6D03D0D308C062@BN9PR11MB5276.namprd11.prod.outlook.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Kevin,

On Wed, 10 Apr 2024 00:32:06 +0000, "Tian, Kevin" <kevin.tian@intel.com>
wrote:

> > From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Sent: Wednesday, April 10, 2024 1:32 AM
> > 
> > If the guest uses SL page tables in vIOMMU, we don;t expose ATS to the
> > guest. So ATS is not relevant here, does't matter map or unmap.
> >   
> 
> ATS is orthogonal to SL vs. FL. Where is this restriction coming from?
For practical purposes, what would be the usage to have SL in the guest and
ATS enabled. i.e. shadowing SL but directly expose ATS? 

Thanks,

Jacob

