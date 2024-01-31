Return-Path: <linux-kernel+bounces-47675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1CA845111
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 06:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7371EB23A2D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 05:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD928005B;
	Thu,  1 Feb 2024 05:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="djMG3SjM"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20427995B
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 05:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706767110; cv=none; b=StREDa69DicAO4JD25ndXPe6/ctdeta81HIaISA/KeZo4TjJl5rYLwSnkLX3QnptVYAOPF1rZzXLykrYGvPpxMm0MIMjU8TdoZiogyS5222N6II+OqIgfI4GwTWkvcdnOn8TnbAUpq8ybCjrXTlwcO1gY0wSdpojS8AkTgvWx2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706767110; c=relaxed/simple;
	bh=MNDj5IWjo3jJNGSHHfjkIbLwbF2Xv1SZe6qfPAyjhiM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ToxH117EpVfgcayczbTXvbut6NbeTsmYQKYPXANIuuB+GLpL0Sz7lgXSHMLnL6DGat/hTbhrVTGxJAzl4iEMkeQD4kpJdj7uScpTWavNiaUn3hOIqUG2yxlGzck4FJcT0fQ+kj+ELFzSZKJufWflXkpXCdNXDT3XD8ka3nVfbX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=djMG3SjM; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706767109; x=1738303109;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MNDj5IWjo3jJNGSHHfjkIbLwbF2Xv1SZe6qfPAyjhiM=;
  b=djMG3SjMB/ZyN4oxtQrzeXg4GRqvpGUdKG03kyhbSn7uY8aVg/aHrUr3
   KhVwg4s01GDHQ97Z+PlBaNgMGxi2ax4rTBmCU49fwZn4t2G//ykkNavgi
   5uXNQ8HZpfbynk+QCZoVr7y/nMng95vCXYy2r9irqMPiFmCkkBqv/5Li7
   iQ4OIu2FSImFJLFCS29GEbHDJGKZpUo4a9dzDLgFlITNWABZeqfhRNg7q
   n6CfNgV/GqEe+vDD1cq1g8boWkFv+I3hPEJflwtpIVlDQBBH5Vx8Mi1vM
   6GZxysUW1Zd+PV6+oTAIIIfHTdQyusn0oxJKEzyOb5fvhX7f9Ld8E9saE
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="17350102"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="17350102"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 21:58:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="23014111"
Received: from tsecasiu-mobl1.amr.corp.intel.com (HELO [10.209.91.60]) ([10.209.91.60])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 21:58:26 -0800
Message-ID: <e2756783-b279-71c2-f844-4c3a4128bad9@linux.intel.com>
Date: Wed, 31 Jan 2024 08:12:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 2/6] soundwire: sysfs: move sdw_slave_dev_attr_group into
 the existing list of groups
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Sanyog Kale <sanyog.r.kale@intel.com>
References: <2024013025-spoiling-exact-ad20@gregkh>
 <2024013029-afternoon-suitably-cb59@gregkh>
 <65b9d883538fa_5a9dd2946a@dwillia2-mobl3.amr.corp.intel.com.notmuch>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <65b9d883538fa_5a9dd2946a@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


> Makes sense. I won't say "looks good" as this file has "slave" all over
> the place, but I checked and it entered the kernel just before the
> CodingStyle changed.

SoundWire 1.2.1 introduced the terms "Manager" and "Peripheral", I had a 
patchset to rename everything maybe two years ago already but it's been 
difficult to add without getting in the way of development and 
backports. Maybe a gradual replacement makes more sense, not sure how to 
go about this.


