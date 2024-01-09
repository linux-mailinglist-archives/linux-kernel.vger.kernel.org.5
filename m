Return-Path: <linux-kernel+bounces-20886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 326A58286F3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 14:18:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FB88B239D2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 13:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E0F38FB7;
	Tue,  9 Jan 2024 13:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k4jiLNNQ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030EA38F83
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 13:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704806296; x=1736342296;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cJPKiirKT9lqC0Z6wFvcgBdIL3HSIWmPzlmahryzrlo=;
  b=k4jiLNNQT9Xx9hJ3jAVuo5FjN9RLjPKDP6gUJ2p4EH9zN3c8Gjio+mIf
   rQTC7I2UzFVnoJml4nWHrg/VtaK+X+TPbYWnvGfcWFpsjIWWLhmXH/Bpy
   RBK6ilbNHU2ox7/X25lkZpRgz4GeTNogDpZuiiRaENpQRpA1bdvYkmlpd
   1grnCHv/7ph7WTSyzcpEWH41W/qLfS+V1EhdWrRFYLbGSjPrhCNWzQGjD
   Fy/FFyJqCuwQBCwNt9QgLuUuLbFu7fF//T5pcEDKBqvM3dzyk9IW5rHcw
   dx2IL2j43REBA3cvuDsgZgO7svLTC3ipz3lBqG1cJlQVngLH3BzKPs7RM
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="19697831"
X-IronPort-AV: E=Sophos;i="6.04,182,1695711600"; 
   d="scan'208";a="19697831"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2024 05:17:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="781794615"
X-IronPort-AV: E=Sophos;i="6.04,182,1695711600"; 
   d="scan'208";a="781794615"
Received: from arunjose-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.37.37])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2024 05:17:43 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
	id 4CB9010A4E9; Tue,  9 Jan 2024 16:17:40 +0300 (+03)
Date: Tue, 9 Jan 2024 16:17:40 +0300
From: "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xiaoyao Li <xiaoyao.li@intel.com>, linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev
Subject: Re: [PATCH v1] virt: tdx-guest: Handle GetQuote request error code
Message-ID: <20240109131740.nk54gdmri6gpwkta@box.shutemov.name>
References: <20240109054604.2562620-1-sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240109054604.2562620-1-sathyanarayanan.kuppuswamy@linux.intel.com>

On Tue, Jan 09, 2024 at 05:46:04AM +0000, Kuppuswamy Sathyanarayanan wrote:
> Currently when a user requests for the Quote generation, the Quote
> generation handler (tdx_report_new()) only checks whether the VMM
> successfully processes the Quote generation request (status !=
> GET_QUOTE_IN_FLIGHT) and returns the output to the user without
> validating the status of the output data. Since VMM can return error
> even after processing the Quote request, returning success just after
> successful processing will create confusion to the user. Although for
> the failed request, output buffer length will be zero and can also be
> used by the user to identify the failure case, it will be more clear to
> return error for all failed cases. So validate the Quote output status
> and return error code for all failed cases.

Could you split commit message into several paragraphs? It would be easier
to get along.

It can be helpful to follow structure like:

<Background>

<Problem>

<Solution>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

