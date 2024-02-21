Return-Path: <linux-kernel+bounces-74259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E06285D1B9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 08:49:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51D8C287717
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 07:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1F43BB31;
	Wed, 21 Feb 2024 07:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ETynYkD/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0DE3BB24;
	Wed, 21 Feb 2024 07:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708501742; cv=none; b=jVutQA89JprBTDgmB/hU/36etHP8svTZd0Zah0KyuVtijrMz3jxDyuPCNwFMEHx5I0ZyKpTOlrOl+U1a7QVI4diKVVAoe3ZBV+kTm6NGTX/2GkDLSd4x8IlGQsu9pEHhvcVD18GB/CE+QsG1MyUXS4W23Gfpg0SRMUATw6RDw0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708501742; c=relaxed/simple;
	bh=qi+I98yy5ZrMETBL+d0Nqci1ne8TZO4ZlEZU91fFtso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fOXya7rHNn77s+KZfZqXWjEyOwCa9pxbr/2dnSRWA5clBWwrvitdeiESzVlY4ELSu07xCxHV9Y7leoQlngbMKaSwIHDb6oOUZN20xF+CCaELjOnjOo8Pz310evKgpAFsfHvsgHLBgM05etK2wFuo8nvkeM8/+NEBd4emZG78OmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ETynYkD/; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708501742; x=1740037742;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qi+I98yy5ZrMETBL+d0Nqci1ne8TZO4ZlEZU91fFtso=;
  b=ETynYkD/9evKLfoWDBrs+o90h6hQmLTCbBld2Boy96dyiczaV1zyk+x/
   VBjSaDgOyskUnHzGMG5RdaJzcOQAJ3h/0dZ/TanQ7TSe6S5n++hapd/dh
   vC8RmRtonXXfj678wCVu1zzTwfT8j9+JKADK+JKywyWSoz+LMyXwapS+y
   a4C08GLtZ9QsoklJsTs5r/0NN9EonKGdmgQk7+rVXLiB8mYpz4I8pWsj6
   gVmyvbgZlUUuXBvKUiSEbbIU1STEHvd1Wp2/f87+Ed+JmtlnvmDs+rOMn
   qxdEyAmv4j+ijbZDe70AEVJ4eGPPqSuLVheHLwMefF/yUWcOc5WvcflwX
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="25109364"
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="25109364"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 23:49:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="9733223"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 23:48:58 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 4B72E11F855;
	Wed, 21 Feb 2024 09:48:54 +0200 (EET)
Date: Wed, 21 Feb 2024 07:48:54 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Saravana Kannan <saravanak@google.com>
Subject: Re: [PATCH v1 1/1] device property: Don't use "proxy" headers
Message-ID: <ZdWq5vA29iB8MzNy@kekkonen.localdomain>
References: <20240220161931.3091680-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220161931.3091680-1-andriy.shevchenko@linux.intel.com>

On Tue, Feb 20, 2024 at 06:18:50PM +0200, Andy Shevchenko wrote:
> Update header inclusions to follow IWYU (Include What You Use)
> principle.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Sakari Ailus

