Return-Path: <linux-kernel+bounces-9628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE89B81C8B3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 12:03:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CF241C22363
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 11:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04CBB156F7;
	Fri, 22 Dec 2023 11:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OHnc36/2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9639156C6;
	Fri, 22 Dec 2023 11:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703242990; x=1734778990;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qo9kVLRTA5g9uD10OHLNcwX9WmuI9qyqNSWDkMj1SPs=;
  b=OHnc36/2Wv2ZCQsxVwwMGfhVOSDtRiTdhLuisJNKSAzbyzB98A44yYh/
   QWDh2BEePDk/mGLRYPUABfTZiquayW3CV1NjG+yzxYXEEjUhGe9PpUWBu
   n0SPbkewTB5S/Ja/QKDjq96NiF7BhxTjtHnqGmnYfK+sV4R4+zxoVrgCb
   E/DdGxEMoTTR6slZwsTlRnYYCdQN83s8LwEJDU2qD8DmlYGU+YjcO+ruA
   lM4R704fmNoCrWIz6jAvrP6VJP1LZ02+1sCYESIa6LpH2apl/jyo5WR0v
   6EPXKD+4+BLDeGz1gJ6yeMWvKVFRPMMd+z8XIKoJjmOnt3sC7F13Dkws0
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="2951428"
X-IronPort-AV: E=Sophos;i="6.04,296,1695711600"; 
   d="scan'208";a="2951428"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 03:03:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="900396146"
X-IronPort-AV: E=Sophos;i="6.04,296,1695711600"; 
   d="scan'208";a="900396146"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 22 Dec 2023 03:03:06 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 5252B305; Fri, 22 Dec 2023 13:03:05 +0200 (EET)
Date: Fri, 22 Dec 2023 13:03:05 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Werner Sembach <wse@tuxedocomputers.com>
Cc: Andreas Noever <andreas.noever@gmail.com>,
	Michael Jamet <michael.jamet@intel.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] thunderbolt: Reduce retry timeout to speed up boot for
 some devices
Message-ID: <20231222110305.GF2543524@black.fi.intel.com>
References: <20231220150956.230227-1-wse@tuxedocomputers.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231220150956.230227-1-wse@tuxedocomputers.com>

On Wed, Dec 20, 2023 at 04:09:56PM +0100, Werner Sembach wrote:
> This is a followup to "thunderbolt: Workaround an IOMMU fault on certain
> systems with Intel Maple Ridge".
> 
> It seems like the timeout can be reduced to 250ms. This reduces the overall
> delay caused by the retires to ~1s. This is about the time other things
> being initialized in parallel need anyway*, so like this the effective boot
> time is no longer compromised.
> 
> *I only had a single device available for my measurements: A Clevo X170KM-G
> desktop replacement notebook.
> 
> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>

Applied to thunderbolt.git/next, thanks!

