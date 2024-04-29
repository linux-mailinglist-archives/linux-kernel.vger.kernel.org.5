Return-Path: <linux-kernel+bounces-162897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8E18B61D8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 21:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D342EB22011
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 19:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F57013AD32;
	Mon, 29 Apr 2024 19:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="XmkR207c"
Received: from smtp-bc0c.mail.infomaniak.ch (smtp-bc0c.mail.infomaniak.ch [45.157.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639F413AA45
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 19:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714418339; cv=none; b=GJX54AxiXVx2iPfibU3C/wxOvqFLH2BR3WFxpRUt/fgkwESva5X29fevoW5ea4NmL7fGPp+rSRAtJlu6z4utIs459QRu3FGuSobm0DDk11j8mD8p1usDfTplKIXM+x/40Hp82WRZeoWiXyjqaH9S6vglIYgzQdmB/+d/T0B+FEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714418339; c=relaxed/simple;
	bh=rJgKKRzmF2JN7UHlVGkVK78Xzd3bmyE6CF3mTysODzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mg/HNSED4An302lJaO3xcCbBX6XQ9zCCNoVE5GTBD2Vb+//T+MefTOBp0ifKcpkw+LnZPefYvTOrRo5RNGtoaFziv5nMPD0RD3urY9EgQ8jhjBrxdknkK1tBT3u3djpqOOc/sgeT2prlDDpN3hW5UKdWI1o2LVKmciFV5xdUWMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=XmkR207c; arc=none smtp.client-ip=45.157.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VStRJ0rXgzRfx;
	Mon, 29 Apr 2024 21:18:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1714418332;
	bh=rJgKKRzmF2JN7UHlVGkVK78Xzd3bmyE6CF3mTysODzM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XmkR207cTzdvhuM7ib5xxNLMcuNznAau20zPLCHzu2c+/RwCTQmPDHThukU9dtGN7
	 /i/MaIt43BmAXHeA2/zERg3CORptxmTx432yIQ0uf5aH8JgcQpQ3/hjXvF8A91Pr9R
	 zxt3qexP0imMh550Mt2/LYYpFSWN5EkJW3oyCSOA=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4VStRH17SvzSjs;
	Mon, 29 Apr 2024 21:18:51 +0200 (CEST)
Date: Mon, 29 Apr 2024 21:18:50 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, 
	Christian Brauner <brauner@kernel.org>, Mark Brown <broonie@kernel.org>, 
	Shengyu Li <shengyu.li.evgeny@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Will Drewry <wad@chromium.org>, kernel test robot <oliver.sang@intel.com>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 4/9] selftests/harness: Fix interleaved scheduling
 leading to race conditions
Message-ID: <20240429.Eitho4foo5he@digikod.net>
References: <20240429130931.2394118-1-mic@digikod.net>
 <20240429130931.2394118-5-mic@digikod.net>
 <202404290852.C327596A@keescook>
 <20240429101647.756a1ac7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240429101647.756a1ac7@kernel.org>
X-Infomaniak-Routing: alpha

On Mon, Apr 29, 2024 at 10:16:47AM -0700, Jakub Kicinski wrote:
> On Mon, 29 Apr 2024 08:52:36 -0700 Kees Cook wrote:
> > > +/* Wait for the child process to end but without sharing memory mapping. */
> > > +static pid_t __attribute__((__unused__)) clone3_vfork(void)  
> > 
> > Why "unused"?
> 
> Right, static inline is enough

Indeed, I'll fix that.

