Return-Path: <linux-kernel+bounces-83474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F2E8699F1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52B731C2466F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC3714AD29;
	Tue, 27 Feb 2024 15:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M0FoZU6z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FA21474AB
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 15:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709046466; cv=none; b=bDq1sN7QqeJiEpayiAogTIu1GP24H68gq+0PY0QzlwWIVA3txR5wKMEwl3zQ5nMpXhoDiCz9ZEmLhWbLN7sezZFSidc/fstOhuNBFz3ExhRkg2Kf5e+D9T7vZvROXH2uW6vQ7z5K7ZTZnc7JFgGvG2UQgNDLgHY6MMxwDmAaERk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709046466; c=relaxed/simple;
	bh=dEWy7wLEKGq1ouT0iXQhr1lr4MchUw+lzS97J7XS4zI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Cz7P7BkBkiGKPgm42iKTK3Wq6MLbbqnj+TwNIvsrIhxKhFjO/an2qL421eXMB9OYQNmJJBb5ePNGp+Pn4WfWI2N/I8fQJMm2cxy9Inz+6jFllF6/gPCUBBexCNqY0l0ZCU9K5k2niBcOXYOFzt5oweK89xzn9CqdmsL6bhFW55A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M0FoZU6z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF7FAC433C7;
	Tue, 27 Feb 2024 15:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709046466;
	bh=dEWy7wLEKGq1ouT0iXQhr1lr4MchUw+lzS97J7XS4zI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=M0FoZU6ziI1hCULE1HJ5T1LCchSD7qQIbU/onUvipS9xFKgfjRH2pnikIdG2R78wC
	 dg4YAHH7a3odiKHJi5nc13YguQHtD7If+4P40yq6rJDcZfTHoTGefHOQdpOJB6tHAk
	 EzFLSVvLZB/rpQArwL2ITIi+ylTNX69NnCH4Tz2yndbqcTq91OMlgpsUUb1HU1Rz6a
	 NRmGK2UoDeRIkYu+AmPwW8sO0URXF/6cJzQoUb7cBnHXjWg0CLeszvemvR7wE646qS
	 K7+Y/XFf8RAA7vv8TeHxcxY3UgoS7o1AZx2qSx73jbAvn0AZ82BmU4OKQ60VwDrYaI
	 guP6FE+XJ3ypw==
Date: Tue, 27 Feb 2024 09:07:44 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Carlos =?utf-8?B?TMOzcGV6?= <clopez@suse.de>, cve@kernel.org,
	linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Jonas Gorski <jonas.gorski@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: CVE-2023-52466: PCI: Avoid potential out-of-bounds read in
 pci_dev_for_each_resource()
Message-ID: <20240227150744.GA235367@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2024022709-magazine-handshake-50da@gregkh>

[+cc Mika, author of 09cc90063240]

On Tue, Feb 27, 2024 at 02:26:26PM +0100, Greg Kroah-Hartman wrote:
> On Tue, Feb 27, 2024 at 02:18:51PM +0100, Carlos López wrote:
> > On 25/2/24 9:16, Greg Kroah-Hartman wrote:
> > > There is no actual issue right now because we have another check
> > > afterwards and the out-of-bounds read is not being performed. In
> > > any case it's better code with this fixed, hence the proposed
> > > change.
> > 
> > Given that there is no actual security issue this looks more like a
> > hardening, and thus not deserving of a CVE, no?
> 
> This was a tricky one, I think it's needed as we do not know how people
> are really using these macros, right?  If the PCI maintainer agrees (on
> the cc:), I'll be glad to revoke it, it's their call.

09cc90063240 ("PCI: Introduce pci_dev_for_each_resource()") added
pci_dev_for_each_resource(), which expands to:

  for (...; res = (&(dev)->resource[(bar)]), bar < PCI_NUM_RESOURCES; ...)

We compute "res" before the bounds-check of "bar", so the pointer may
be out-of-bounds, but the body of the pci_dev_for_each_resource() loop
is never executed with that out-of-bounds value.

So I don't think this is a security issue, no matter how
pci_dev_for_each_resource() is used, unless the mere presence of an
invalid address in a register is an issue.

The same address computation is used for "pci_resource_start(dev,
bar)", which is used in hundreds of places where drivers supply the
BAR index, and the index is not checked.

We could consider adding a bounds check in pci_resource_n() to turn a
potential out-of-bounds reference into a NULL pointer dereference,
e.g.,

  #define pci_resource_n(dev, bar) (bar < PCI_NUM_RESOURCES ?
      &(dev)->resource[(bar)] : NULL)

But of course, there's nothing stopping drivers from computing
"&dev->resource[junk]" themselves.

Bjorn

