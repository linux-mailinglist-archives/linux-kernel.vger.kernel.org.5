Return-Path: <linux-kernel+bounces-100463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F858797D5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 16:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F0001F228CD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD45F7C6F6;
	Tue, 12 Mar 2024 15:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ks2tX6Iy"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A6C1E534;
	Tue, 12 Mar 2024 15:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710258139; cv=none; b=UOsnW1CGnDaqyJHqklqKpFrNOuZWCvyZGjFeFOhleD+dR8WbJ76kz1nicPLgVPZ4m3XIKVY5nnbWRxG76ALHISRt5hOljRrMFXNUa2nmCuSZHZw7ou3hrLJ/vEJ8XfExUuK8yNy3GeFDhx1xFO6sKFOBofqqwzEVjNLDQFMMSsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710258139; c=relaxed/simple;
	bh=kaba+pIokp3zp1EHJULsrdS8rJZbUpsA1bC4dzl0xGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ellM1oIZaQ4MSyEWNQRZ5ejujpOYkVSBobm+bPbzFTFuWczHSLNzYVD5WflPgQHNvnH6kKdGIcEV3Rn8UcEWvpoO0jLUBI3sJXk1fjNCwRXDOj/CB5wFRcPaIFP828HAoU6qGifKuaWF2YypaTgmCrVutsHVvf/VeIuQO7StJhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ks2tX6Iy; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710258138; x=1741794138;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kaba+pIokp3zp1EHJULsrdS8rJZbUpsA1bC4dzl0xGs=;
  b=ks2tX6IyUT7k1/RdctKWzv/Zfi0GrUDFDj3GXGsD0MmiNbvOx9RsRoMW
   jJGdDDQPvyLY2/0LOzYfNSfDurFg9f8a7bYHE6Ia45Gn9kVUcoMLThyp5
   KeZdRaDPcbCy018VEU6gKiBVkV+/J+GubgEkeJXEpKJYzjWBvgoguuNFs
   rD+pF1PC11O7QJgaWwfXxuV6IuKDybEHhgl5fzRVpqN+EM12Acshk7e+i
   i6eFleacjZ2uUDhphylOQncKaG2nbbblBZCKZmS4EMbIy2I6Xv26pXf7/
   x/96ZYgHfTiCqFhHF35JVkYV6Rbns7qJwnst0D9y1h6QSqS//tO6eSP80
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="4838967"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="4838967"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 08:42:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="914400083"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="914400083"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 08:42:14 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rk4GZ-0000000Bvt2-2J1i;
	Tue, 12 Mar 2024 17:42:11 +0200
Date: Tue, 12 Mar 2024 17:42:11 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Herve Codina <herve.codina@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Yury Norov <yury.norov@gmail.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH] lib/bitmap: Fix bitmap_scatter() and bitmap_gather()
 kernel doc
Message-ID: <ZfB30-rLXEnJtjrY@smile.fi.intel.com>
References: <20240312085403.224248-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312085403.224248-1-herve.codina@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Mar 12, 2024 at 09:54:03AM +0100, Herve Codina wrote:
> The make htmldoc command failed with the following error
>   ... include/linux/bitmap.h:524: ERROR: Unexpected indentation.
>   ... include/linux/bitmap.h:524: CRITICAL: Unexpected section title or transition.
> 
> Move the visual representation to a literal block.

..

> This patch fixes de5f84338970 ("lib/bitmap: Introduce bitmap_scatter() and bitmap_gather() helpers")
> available in net-next and linux-next

Not sure about rules of net-next, but I would add Fixes FWIW:

Fixes: de5f84338970 ("lib/bitmap: Introduce bitmap_scatter() and bitmap_gather() helpers")

-- 
With Best Regards,
Andy Shevchenko



