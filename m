Return-Path: <linux-kernel+bounces-92217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 671A2871CF1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:08:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01969B2558E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B6B2579;
	Tue,  5 Mar 2024 11:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="n5wRjrgG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D3F1DDF4
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 11:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709636892; cv=none; b=C/eyF/i9KHnm8hRlgDbU1szDTvW7YyXIfkfIGRIGj1yK/zM9ADBslccUUSRFob3yMOEiIB2g+qrbtboF30AzAnWwcH2QO/n90m+gbB+UUBW17YvQh0OQpTv1xke7ol/wRuyuuAxph+lHue296kq2niuz7qAZU3Sk2LahOh9LFFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709636892; c=relaxed/simple;
	bh=phnS/eb3ryeT8pmktBTMQyFmxw0iU9seASjgAojYFjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aFpFhQc+3XBplMUhwonp3fSkDp0EavW3IXG6/aJ45EqN7rytGQXBoG2vZQu5o1xqK1K1x2U6qRKzDVuAYlIzzobYXS3lb53wKuVApgyCWMf4QkdmJo1wWQ1IKU1LUMNeHMMpXHobqS3pEVDmPBDTFNpFQm9OKYP5rvpYOU6UJaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=n5wRjrgG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C0A3C433C7;
	Tue,  5 Mar 2024 11:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709636891;
	bh=phnS/eb3ryeT8pmktBTMQyFmxw0iU9seASjgAojYFjM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n5wRjrgG5mJbK6zn1hkmXL/ckxxlUJvr5BC1grn17B9Rv8h4WwMAmpOXF/DCgYx5j
	 33RV1eS3YNcPtkSWEnth8E1/r+Xdpd+yQZsGUBhaBVrt8D03SVfLDZezRLyA8tqVBb
	 fQ4B5TmnCjSb3NVNu91I39N9io4oXZw0djdGPTo8=
Date: Tue, 5 Mar 2024 11:08:09 +0000
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Robert Frohl <rfrohl@suse.com>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: CVE-2023-52572: cifs: Fix UAF in cifs_demultiplex_thread()
Message-ID: <2024030513-unburned-eggplant-a218@gregkh>
References: <2024030256-CVE-2023-52572-2b92@gregkh>
 <ae3d431d-d93f-4fe4-99c9-7157bebaff79@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae3d431d-d93f-4fe4-99c9-7157bebaff79@suse.com>

On Tue, Mar 05, 2024 at 11:38:49AM +0100, Robert Frohl wrote:
> Hi all,
> 
> this seems to be a duplicate of CVE-2023-1192 [0], even though NVD lists
> another, wrong patch. The RH bug has more details [1].
> 
> Cheers,
> Robert
> 
> 
> [0] https://nvd.nist.gov/vuln/detail/CVE-2023-1192
> [1] https://bugzilla.redhat.com/show_bug.cgi?id=2154178#c28

That's a mess.  Please have RH update the json entry with CVE with the
correct git commit id and then I'll be glad to revoke this.  The
information in NVD is not "real" from the point of view of the CVE
database, so I can't take information there as being correct, or not.
As you know, NVD is just an add-on for CVE entries, one of many created
by many different groups/governments.

Until it's fixed in the CVE database, this CVE should stand as it refers
to the correct fix that people need to know about, not the incorrect one
in the RH-assigned CVE.

thanks,

greg k-h

