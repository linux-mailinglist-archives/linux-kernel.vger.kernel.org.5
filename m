Return-Path: <linux-kernel+bounces-64018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB70B853909
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 18:54:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 679471F24A93
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8252605A7;
	Tue, 13 Feb 2024 17:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DYCK8NA+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CE4604D3;
	Tue, 13 Feb 2024 17:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707846858; cv=none; b=KEgYV9flCY1yel8ukURZyoiAp33m1zv+/YwS0vmlTR6UHaNmTwvyvnuDsm5niF4aLAkgZszBCaudt/Y3/majnuIlXR+PX25d1a1q05QonEWpAm+zTQu2bgDZXFhoMxm559sXvJ6tKObmPOppaxJAgsAVbAV3/yx6ecvJ8CQ1Qew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707846858; c=relaxed/simple;
	bh=MUIZvlFHTGzkRMldmTzlSziHPH3x+7VcZO6X5P3yY88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lHVjAAUcBq3SI04PKBl2MEyxm1GuISOm/NcEIhLFmt1XjQr7GcyTedWBkTeAW7nehVULVijcn1jSN8Micmw/1BUXAUO58Bm8fjY9FTdcR8w4EnrMVB2BGUAPcaPtSH8KKNjY2h2I7HkFmT2758H90AB2f3Fzu8/IOD6HbMnDAj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DYCK8NA+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC4C9C433C7;
	Tue, 13 Feb 2024 17:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707846857;
	bh=MUIZvlFHTGzkRMldmTzlSziHPH3x+7VcZO6X5P3yY88=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DYCK8NA+QYQEbaTAvdCQeYjgOB/G6sNQCAWR5d5CLocyoZDiYAx3DcH/jtgzGH1x/
	 fONWFXnFKbCYE+p65AWgm6hIDk1SJh2veAtMTN3hmAD1jymdhR1eHOT1l0UoaRQ47b
	 j14VpSLC+R+GIsV3PH3yXNRWo7fOBe0tpKr0LCvs=
Date: Tue, 13 Feb 2024 18:27:37 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Serge Semin <fancer.lancer@gmail.com>, linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mips: bus: make mips_cdmm_bustype const
Message-ID: <2024021325-albatross-mule-d8bc@gregkh>
References: <20240213-bus_cleanup-mips2-v1-1-9c0e3d4a1852@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213-bus_cleanup-mips2-v1-1-9c0e3d4a1852@marliere.net>

On Tue, Feb 13, 2024 at 11:49:24AM -0300, Ricardo B. Marliere wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the mips_cdmm_bustype variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> ---

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

