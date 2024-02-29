Return-Path: <linux-kernel+bounces-86317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D758686C3D8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1294F1C2345B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 08:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6037050A63;
	Thu, 29 Feb 2024 08:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Zjqu12Tg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D12B3FBB2
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 08:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709196011; cv=none; b=kGX8NK62P9GfKirDbEMxGfSrMfI9JeDT2Tg9XhnQCRXw37inRyvY/EfAfHWltiRFtnUmIuJsNlT+DjjGh6LUv4/sq8ejPxnM398tET74GjIQcXb3ibayhpsTvrntDUWooy7HDTQpqUCdmjhe5i++CZvyjVjC65FpMivPSnpzL9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709196011; c=relaxed/simple;
	bh=+HuT2LRY6QwU0cFT8GjgE0l/dgH7Rq+kEDW4d7JHmzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zb3RjtiznHeUA9dEcDJVHWbD6idkbUWnXBUm3UAFpEFXbyvOCIF5Lk6t7244SAs+Se7L8dJelDJNqd/JZcKcBggjXABChQYW8+qQN38hXHmt8lQOR6wRrDCkfXy7sluXXwh8Si3w5pdhQC6VJhuAkQTKFpj84JSQEQ/p+s7Kx6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Zjqu12Tg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 031D0C43390;
	Thu, 29 Feb 2024 08:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709196011;
	bh=+HuT2LRY6QwU0cFT8GjgE0l/dgH7Rq+kEDW4d7JHmzQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zjqu12Tgv7MhcUKMrnHEhL9FoCus8S5+XdK1p6W4JUyGxmEKXebtfVj70CvGdKmml
	 3KpHt0GZRah5Tb1ZNO+r4/tceSO9I6EwfhMNRdY5owerPwZfEJvxlwAFIcy1Z6GU1W
	 7sDlKlREHzh32BRMKsZDgb+JjSdYEQDqlKiV1h5U=
Date: Thu, 29 Feb 2024 09:40:08 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Michal Hocko <mhocko@suse.com>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: CVE-2021-46966: ACPI: custom_method: fix potential
 use-after-free issue
Message-ID: <2024022951-worst-relatable-f4bb@gregkh>
References: <2024022720-CVE-2021-46966-1469@gregkh>
 <Zd9b3qpu3uLFP-eN@tiehlicka>
 <2024022902-prancing-judgingly-c9ee@gregkh>
 <ZeBAlGNuNZNuCsE5@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZeBAlGNuNZNuCsE5@tiehlicka>

On Thu, Feb 29, 2024 at 09:30:12AM +0100, Michal Hocko wrote:
> On Thu 29-02-24 06:22:34, Greg KH wrote:
> > On Wed, Feb 28, 2024 at 05:14:22PM +0100, Michal Hocko wrote:
> > > Hi,
> > > this seems like another example of a reasonable fix with a very dubious
> > > CVE IMHO. Allowing access to /sys/kernel/debug/acpi/custom_method to
> > > anybody but trusted actor is a huge security problem on its own. I
> > > really fail to see any value marking this clear bug fix as security
> > > related.
> > 
> > It was picked because it was a use-after-free fix, AND it is part of the
> > "import the GSD database into the CVE database" that the CVE project
> > asked us to do.
> 
> OK I see. So now, does it make any sense to consider a bug fix in a
> security sensitive interface (that is even locked down) a security fix?

Yes, I would think so!  If you see any that we have not marked for a
CVE, please let us know and we will be glad to assign them.

Again, we do not always know if things are "locked down" or not, as
everyone uses our codebase in different ways (we don't have the benefit
of a *BSD which does dictate the use cases in ways we can not).

If your systems "lock this down" and prevent access to anyone you do not
trust, then wonderful, you aren't vulnerable to this specific issue at
all and you can just ignore it!

But for other systems that DO allow access to debugfs, this might be a
good idea to address.

thanks,

greg k-h

