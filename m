Return-Path: <linux-kernel+bounces-90685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDEE787035B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 14:53:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89C0F281467
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 13:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD7C3F8C0;
	Mon,  4 Mar 2024 13:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nIQXKEjQ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EE73DB9A;
	Mon,  4 Mar 2024 13:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709560410; cv=none; b=Mz5OnVoQy3zdSdrygKI+pvHPoW9pdB3jE5G5ad4+MuD/1stX3da8JAYQrkG+Az3OkCgBW5G2WBhq71e8buLvyeKMup3iUbfG6K0L4XXOV8PJGJYIsk1jV0Z7q0cs2babg6zZ+T1DMW1OqUl8SIrdPiNw4Um6jLkqnqHt3f27jfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709560410; c=relaxed/simple;
	bh=ct6yeXiMSgF37VG2k47ZlEma0v/nfDSkmTtol+8MQnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BDz4PTlDkvN0PEbFjIz/IoLE1zl95kSqF66Wyjf5GjqyiDLcyX1H/u5+2UZJBupAisjFDlXm6V50iR+vHyKCBMfBivj8yr4Ucpjw8UUOOMPkSWbdrf77Qid/19PXnJKJnlBXx2YMXJ3rkIP9IC+IxdNUwAnIxAo9//UXj+HUtD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nIQXKEjQ; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709560409; x=1741096409;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ct6yeXiMSgF37VG2k47ZlEma0v/nfDSkmTtol+8MQnI=;
  b=nIQXKEjQK/p9H+KmkyNSHPWuQFYnSAou8hozdJ65f/mmMbqOQuJ5rFJl
   /5Le7PlL5pQhzUffB6bbW2jdKMP1qnBVSojFzHs+EGdt2EbrM5LrmZPzH
   wX9KQZ6e4iKN/V6FF7cuJAP90lGFTCVjcvgMUF4/0G8nDRAXFNr9JpUCK
   vzYA2sc31p4unfkSp7neA/+FsOXWHy8oQPZ9yT8U/CMJFiDUWrU+f6YiM
   2yxrKIm2ZQCX9i4DEpVS0YnvulEHjAG7+o8lXsvxTUFQK0NJDxBNhwNDg
   EfieTv+28Oc2g3wHjaiA1UuMKcrKlamsPadvSrwVbA2fLhkJvra1Rf98X
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="26515948"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="26515948"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 05:53:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="13661839"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa004.jf.intel.com with ESMTP; 04 Mar 2024 05:53:25 -0800
Date: Mon, 4 Mar 2024 21:49:12 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Marco Pagani <marpagan@redhat.com>
Cc: Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alan Tull <atull@opensource.altera.com>,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-fpga@vger.kernel.org
Subject: Re: [RFC PATCH v5 1/1] fpga: add an owner and use it to take the
 low-level module's refcount
Message-ID: <ZeXRWDGvd8P7KhxJ@yilunxu-OptiPlex-7050>
References: <Zbh7iO9wlm9ekzB7@yilunxu-OptiPlex-7050>
 <0720eb91-72f9-4781-8558-8a1b0a3691c2@redhat.com>
 <Zb8dd9af0Ru/fzGi@yilunxu-OptiPlex-7050>
 <4aaa131a-4b64-4b86-9548-68aef63c87b3@redhat.com>
 <ZdHWaeU+/On6LmHX@yilunxu-OptiPlex-7050>
 <9a9d4018-fd65-49be-9e0a-1eecc9cbf15d@redhat.com>
 <ZdYKnZxdTCvu5THG@yilunxu-OptiPlex-7050>
 <ae3cd81b-82af-4977-91d7-fa809c6fc45a@redhat.com>
 <Zd7cff43ffbJOGNY@yilunxu-OptiPlex-7050>
 <08ba8bce-0ebf-4c8f-952d-a6665dc7fdf9@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08ba8bce-0ebf-4c8f-952d-a6665dc7fdf9@redhat.com>

> Just to be sure that I understood correctly, you want to split the
> changes into two patches, like:
> 
> a) add module owner to the manager struct and take it in
> __fpga_mgr_get(); move put_device() from __fpga_mgr_get() to
> fpga_mgr_get() and of_fpga_mgr_get().
> 
> b) add the mutex and the unregistered flag for protection against races.
> 
> So that (b) can be reverted if try_module_get_safe() will be accepted?

Yes, that's what I mean.

> 
> > [...]
> 
> Thanks,
> Marco
> 
> 

