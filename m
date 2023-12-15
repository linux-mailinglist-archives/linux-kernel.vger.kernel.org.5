Return-Path: <linux-kernel+bounces-632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C418143DB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 09:41:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC7661C22759
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 08:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239B517997;
	Fri, 15 Dec 2023 08:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LFCNE6Bi"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9EE1774F
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 08:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702629639; x=1734165639;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Rd5viuBQiPqVA3ULp+UHOWd5TEKMyHgFH0Vs6eQQGmU=;
  b=LFCNE6BiZXkrscUSjxlIrHGw96s6swvOmdyrzaS2vYHKP9VErzfS+GHJ
   T0FswWQ9CLOk0EuROPLeOyHW4TTwLPu4+2k+mOE/S/Pack1H9RCw3IOJu
   ZghYB/CgjlEttserO2UfoMKMb/1wZROuFtBxNuBvg5xP6bN33I6ls2CvU
   qhP1KtsT5kzv41nnTxHslv6yP1klkz/BUjYgX9mH47fulaU/T9iyMlsV8
   PjdUhyg//TOqByaYquRilqIi4B0T6r+C+OBkRU6zZIeZrgsDmoP67nV0S
   dDVKIvlImMGfCxtvSFygBRIqN/3noaXoq1OY3H1K64c92AN89vyBqKozK
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="2406132"
X-IronPort-AV: E=Sophos;i="6.04,278,1695711600"; 
   d="scan'208";a="2406132"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 00:40:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="845054229"
X-IronPort-AV: E=Sophos;i="6.04,278,1695711600"; 
   d="scan'208";a="845054229"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.localnet) ([10.213.25.64])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 00:40:36 -0800
From: "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 "Fabio M. De Francesco" <fabio.maria.de.francesco@intel.com>,
 Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH] mm/memory: Replace kmap() with kmap_local_page()
Date: Fri, 15 Dec 2023 09:40:33 +0100
Message-ID: <3867181.PYKUYFuaPT@fdefranc-mobl3>
Organization: intel
In-Reply-To: <20231214114747.ddd42a1e567d2bd0f95f2095@linux-foundation.org>
References:
 <20231214081039.1919328-1-fabio.maria.de.francesco@linux.intel.com>
 <20231214114747.ddd42a1e567d2bd0f95f2095@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday, 14 December 2023 20:47:47 CET Andrew Morton wrote:
> > From: "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>
> > ...
> > From: "Fabio M. De Francesco" <fabio.maria.de.francesco@intel.com>
> > 
> > ...
> > 
> > Signed-off-by: Fabio M. De Francesco
> > <fabio.maria.de.francesco@linux.intel.com>
> We get a complaint from checkpatch (and possibly from Stephen Rothwell)
> that the From: and Signed-off-by: email addresses differ.
> 
> I tentatively rewrote your explicit From: to @linux.intel.com, which
> may have been unwelcome.  What can we do here?

I have two email addresses and sometimes some confusion arises while 
configuring. Please discard this patch. I'm going to send another to replace 
this.

Thanks,

Fabio





