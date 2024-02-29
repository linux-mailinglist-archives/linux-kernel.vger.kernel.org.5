Return-Path: <linux-kernel+bounces-86134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5730886C024
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 06:22:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB80AB24439
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 05:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 872CC39FD4;
	Thu, 29 Feb 2024 05:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vm1E9n6H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C3136AE1
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 05:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709184157; cv=none; b=cUzyzNFsHIM5NiIQoGtqhCz2++jtkDSXcgkQrWGpVlF0CnD6gB+gCRttg6rpEFNrGT1PgsLz28+z648EdqCRh5g/ZewrnITfMrojh9HadPapgKV1WvIstSTT0LXPVq2nbsbXosUBVokcZXyHiHPDU+dGFuGMScir0E8hH8dlwwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709184157; c=relaxed/simple;
	bh=oNX4WDKOi3u73StaYCbLq0KirwMdi79LCSisLZhHFs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XM7zRtVP+P0J+pYKEgFjsU6IsSySImBL5VxxXbhGePe4pdCNhAnFJNX69mfhM0KGHagrlBcmOX2JjaJnNPKRj/pNZpB22qyK9ERXkebMJ1hsNciBmrR20fQytClDx202jG/9HoJLoy2hbvDRLDdBIWMJMgwB4T11Q/Eey2/5oUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vm1E9n6H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE86AC433F1;
	Thu, 29 Feb 2024 05:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709184157;
	bh=oNX4WDKOi3u73StaYCbLq0KirwMdi79LCSisLZhHFs0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vm1E9n6HG2cBM66J7owZRDiH3B2WO2f54gxMPbNz9Qud89pY6N6/+whuUIpqjmKvz
	 RakEwfWQrgUMfphSKQ7WsUVYHW0KazLAvHyD+7cxQr/AHXxgkZN1qrHV56JdMYT2cV
	 7AG2Ihsn3+/d13Eu20FsFFNTF/PvTv7d/WMsTzlE=
Date: Thu, 29 Feb 2024 06:22:34 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Michal Hocko <mhocko@suse.com>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: CVE-2021-46966: ACPI: custom_method: fix potential
 use-after-free issue
Message-ID: <2024022902-prancing-judgingly-c9ee@gregkh>
References: <2024022720-CVE-2021-46966-1469@gregkh>
 <Zd9b3qpu3uLFP-eN@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zd9b3qpu3uLFP-eN@tiehlicka>

On Wed, Feb 28, 2024 at 05:14:22PM +0100, Michal Hocko wrote:
> Hi,
> this seems like another example of a reasonable fix with a very dubious
> CVE IMHO. Allowing access to /sys/kernel/debug/acpi/custom_method to
> anybody but trusted actor is a huge security problem on its own. I
> really fail to see any value marking this clear bug fix as security
> related.

It was picked because it was a use-after-free fix, AND it is part of the
"import the GSD database into the CVE database" that the CVE project
asked us to do.

thanks,

greg k-h

