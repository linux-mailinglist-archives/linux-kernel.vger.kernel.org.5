Return-Path: <linux-kernel+bounces-87518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B850A86D56B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 22:02:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E82771C22460
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C55616D5FC;
	Thu, 29 Feb 2024 20:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fJq/kCFx"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25833143747;
	Thu, 29 Feb 2024 20:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709239319; cv=none; b=qvTisPGJ+wwiDLpx+xJ7BRN+RsRVaLZR6ljmcRclxPZ1y9kLuEcc7iivgry8ORwXda9IC69jBD2L4Ou7JYrEBQWFgPkphr4BxynPcOk1Wad0R9tq6uMIpthgYSS4GKzHGaQhLt8L0PDeTDAdk6ddLefpo0+Tet0Z5RiTdhKCrE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709239319; c=relaxed/simple;
	bh=Afb1bS5M8L8H7i6Uyi43uTFRREwyVzlW0GwyD+OUcN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d2pb9lYMgS+UH7vswFzM64SHqeAhSXDsj+L66tEpbPx5zFJPCaugDsDCZFp5F65tAv/pbJcAkPF0g2y23Bto4+OnOWC27ElfcsQzgnRk0JvW+v2FgC/uPm5qBiD898fn30pAvYpx16lm3WQaIoTt4WnIkSwWNxuWQ5pwx0zi/RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fJq/kCFx; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709239317; x=1740775317;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Afb1bS5M8L8H7i6Uyi43uTFRREwyVzlW0GwyD+OUcN4=;
  b=fJq/kCFxJcdVpMr5IUoe/BSEc15n2Qzkm+2qrYirOwDJPxNkqk7pEn17
   vSwrN6kz8+PWavUlZ16U+KANR7UK3w+qdPp2rrV2zjUl6CqyohAXVZvMN
   dVDxeBq33vvv7GQKtnXUeBqma7QasF0hVK3dAmXqELK0KsGcsRLqHtTJ2
   L5uVDGybaPDxALPqZmDKUkbKkNC5smDQGAb4+zzX5W95AkwsU5AkEIrXy
   1IBxAnifIxZzY9+4fKAzpftq3Sd9BM+Elfz2S6VZPnkmIgUMGrFYIbgcr
   bVNSNUEX/f4HBp579jgWhKbq1l0/dVPCzVhvk3s3nlrzikhSIzpT4oc3X
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="3908109"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="3908109"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 12:41:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="8373570"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.105])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 12:41:55 -0800
Date: Thu, 29 Feb 2024 12:41:53 -0800
From: Tony Luck <tony.luck@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"dave@stgolabs.net" <dave@stgolabs.net>,
	"dave.jiang@intel.com" <dave.jiang@intel.com>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
	"ira.weiny@intel.com" <ira.weiny@intel.com>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"david@redhat.com" <david@redhat.com>,
	"Vilas.Sridharan@amd.com" <Vilas.Sridharan@amd.com>,
	"leo.duran@amd.com" <leo.duran@amd.com>,
	"Yazen.Ghannam@amd.com" <Yazen.Ghannam@amd.com>,
	"rientjes@google.com" <rientjes@google.com>,
	"jiaqiyan@google.com" <jiaqiyan@google.com>,
	"Jon.Grimm@amd.com" <Jon.Grimm@amd.com>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"rafael@kernel.org" <rafael@kernel.org>,
	"lenb@kernel.org" <lenb@kernel.org>,
	"naoya.horiguchi@nec.com" <naoya.horiguchi@nec.com>,
	"james.morse@arm.com" <james.morse@arm.com>,
	"jthoughton@google.com" <jthoughton@google.com>,
	"somasundaram.a@hpe.com" <somasundaram.a@hpe.com>,
	"erdemaktas@google.com" <erdemaktas@google.com>,
	"pgonda@google.com" <pgonda@google.com>,
	"duenwen@google.com" <duenwen@google.com>,
	"mike.malvestuto@intel.com" <mike.malvestuto@intel.com>,
	"gthelen@google.com" <gthelen@google.com>,
	"wschwartz@amperecomputing.com" <wschwartz@amperecomputing.com>,
	"dferguson@amperecomputing.com" <dferguson@amperecomputing.com>,
	tanxiaofei <tanxiaofei@huawei.com>,
	"Zengtao (B)" <prime.zeng@hisilicon.com>,
	"kangkang.shen@futurewei.com" <kangkang.shen@futurewei.com>,
	wanghuiqiang <wanghuiqiang@huawei.com>,
	Linuxarm <linuxarm@huawei.com>
Subject: Re: [RFC PATCH v6 00/12] cxl: Add support for CXL feature commands,
 CXL device patrol scrub control and DDR5 ECS control features
Message-ID: <ZeDsESXK5pMeialz@agluck-desk3>
References: <20240215111455.1462-1-shiju.jose@huawei.com>
 <65d6936952764_1138c7294e@dwillia2-xfh.jf.intel.com.notmuch>
 <54c55412e9374e4e9cacf8410a5a98cb@huawei.com>
 <65d8f5201f8cc_2509b29467@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <20240226102944.000070a3@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240226102944.000070a3@Huawei.com>

> Obviously can't talk about who was involved in this feature
> in it's definition, but I have strong confidence it will get implemented
> for reasons I can point at on a public list. 
> a) There will be scrubbing on devices.
> b) It will need control (evidence for this is the BIOS controls mentioned below
>    for equivalent main memory).
> c) Hotplug means that control must be done by OS driver (or via very fiddly
>    pre hotplug hacks that I think we can all agree should not be necessary
>    and aren't even an option on all platforms)
> d) No one likes custom solutions.
> This isn't a fancy feature with a high level of complexity which helps.

But how will users know what are appropriate scrubbing
parameters for these devices?

Car analogy: Fuel injection systems on internal combustion engines
have tweakable controls. But no auto manufacturer wires them up to
a user accessible dashboad control.

Back to computers:

I'd expect the OEMs that produce memory devices to set appropriate
scrubbing rates based on their internal knowledge of the components
used in construction.

What is the use case where some user would need to override these
parameters and scrub and a faster/slower rate than that set by the
manufacturer?

-Tony

