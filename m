Return-Path: <linux-kernel+bounces-138103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC5589ECA5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1ECA7B25254
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 07:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A343613D28D;
	Wed, 10 Apr 2024 07:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WG4TViuh"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85AF913D27E;
	Wed, 10 Apr 2024 07:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712735363; cv=none; b=c/ImIWdyZ9ELCYIfArk66J1trSfIuC8t9ELvoHFeUhE1ivjDUGu5IcCQrO/4z4PkA9IygaORAeytYCdZtEBFDswAa5jB02eOAFQjSqJViM0hnfIxeigorvlnGN8SE4hWJW7k56euyvyMg671CylPK+03GdHXdwu/iqQQk2K1DAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712735363; c=relaxed/simple;
	bh=+9te3cNBoGduBlHPkYI0dfFohs/gQ6e7/rlGyu2fe+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GoHxLlKU3tnwZEz6/BHiu0KcOlXJGnS3prJl/RaJvUtQ/Qi9vL4InKcqOSX1IHyE0URWdNiLqxMTTi5EnJZQ9kbao+60Mqt1BhxK4Cldd/jYYTaIt+waKOOGDD6wOf93Qx28S+7beqi6r1OjpF5UQlTYPvr8PMlac9tKEHWz4Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WG4TViuh; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712735361; x=1744271361;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+9te3cNBoGduBlHPkYI0dfFohs/gQ6e7/rlGyu2fe+U=;
  b=WG4TViuhwhAsF2AnkDSgR0q84KUIGLRE6hWcEicOmKpyct+/XIkvVjbr
   I8hUdGBCogL/tWx0lmMht3/uviSqIyu3CgIU5Dtjhlaxh+FHTsWog3vxS
   IpDZ3RVtqESXOSHae5TjS1BC2JZPDDjdMDoDzgLdlU34HcsbIf4m6D5ns
   YoWtKR4r04M7WKxdEildlyCq8vT50zbP7yde/dbp4mKyqT0vEhhr/Rp6C
   WopM+ME7yAZzm0IE1mvDzPDeOdvzX/3CMG4ABoSXAEoSJLTo07L+E+1Aj
   uLoGYTYo60THnFbo7f8rWZ8QytWoys6kGQQScnmY6zDAuKeQ3sMeOQxxA
   g==;
X-CSE-ConnectionGUID: yqindwHxRYSLsDAD7MYQdA==
X-CSE-MsgGUID: IH6ImbmuRfSiAiBgalmEjw==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="18647782"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="18647782"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 00:49:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="937094645"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="937094645"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 10 Apr 2024 00:49:18 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 826AC169; Wed, 10 Apr 2024 10:49:17 +0300 (EEST)
Date: Wed, 10 Apr 2024 10:49:17 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Raag Jadav <raag.jadav@intel.com>
Cc: rafael@kernel.org, lenb@kernel.org, robert.moore@intel.com,
	andriy.shevchenko@linux.intel.com,
	stanislaw.gruszka@linux.intel.com, linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] ACPI: bus: allow _UID matching for integer zero
Message-ID: <20240410074917.GX112498@black.fi.intel.com>
References: <20240328035540.13194-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240328035540.13194-1-raag.jadav@intel.com>

On Thu, Mar 28, 2024 at 09:25:40AM +0530, Raag Jadav wrote:
> Commit b2b32a173881 ("ACPI: bus: update acpi_dev_hid_uid_match() to
> support multiple types") added _UID matching support for both integer
> and string types, which satisfies NULL @uid2 argument for string types
> using inversion, but this logic prevents _UID comparision in case the
                                                ^^^^^^^^^^^

Typo: comparison

> argument is integer 0, which may result in false positives.
> 
> Fix this using _Generic(), which will allow NULL @uid2 argument for
> string types as well as _UID matching for all possible integer values.
> 
> Fixes: b2b32a173881 ("ACPI: bus: update acpi_dev_hid_uid_match() to support multiple types")
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

