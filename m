Return-Path: <linux-kernel+bounces-121358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 346C288E6B1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:42:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E50D82C8CF9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA69A12FB16;
	Wed, 27 Mar 2024 13:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hZa5clA5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2033112CD98
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 13:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711545436; cv=none; b=khI5BrbFeHuIMJEXsSNV36lq/A2GmdWfB/f5GjV9Zwsl4Plg1kjSo8cWfKef3vfrKznMaje3N804464neJ0ws/yA7XoxNyR+4/72GiD+DqO+sw2n4V24kzBmDf5bW3eiNjcDNvnXhp77311Q5z0vFmGWDQJ4SytNP0/GybTe1TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711545436; c=relaxed/simple;
	bh=EgGwsr1jWaZ3/tn3jhVBCdIu5Zv7AE9Le1ze+dVFpKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SWwEnOC7PhUBsS1v/5fw/Y1Kq7BBvDbYgAY8PBaSmsJwi7io1pi2eQ/oKIhtte8MPYxwEitKS3Dbe83gIlJ/DF3v+sXj0KXEVNxmp479vrB2xcFXC4hdlkg2JTFMq8UB7u9/cQ9cBLpp+4qASJSSOxReliM6zE/OpLAMub2hgmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hZa5clA5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC207C433C7;
	Wed, 27 Mar 2024 13:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711545436;
	bh=EgGwsr1jWaZ3/tn3jhVBCdIu5Zv7AE9Le1ze+dVFpKM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hZa5clA5oSe9ER3hZCEFG65OMupx2BoQMqS7RixS7YRWiYLXCJw5Go90/s3nH0J/k
	 TRaQsFCOzU826/qMteSuzE7B2U2SzuljYSlQYT2x86ur9XbNAh26Gi7UsDZ2DyRIxb
	 t8fvOanIcy475vfiYNUPDVdGYdD49BLFDKObRxoOUjICTJCNvkNnQP+tHLMIpNWmDQ
	 f8thN/h/4DFNYkDSX2QFtfqvZCjbEow+AIIUmB57/NfWawfuq8iW1FEd5NDwk1T85S
	 QgAkpAQz5kjUoZNpY1WKj6u2wLxB91EEY5VsRyHrDBWOkNmoDBULiJ3RPxDRdR11pZ
	 Pvxf5RX7sxBFA==
Date: Wed, 27 Mar 2024 13:17:11 +0000
From: Lee Jones <lee@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mateusz K <mateusz.kaduk@gmail.com>, Bjorn Helgaas <helgaas@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] mfd: intel-lpss: Switch over to MSI interrupts
Message-ID: <20240327131711.GR13211@google.com>
References: <20240312165905.1764507-1-andriy.shevchenko@linux.intel.com>
 <20240325211915.GA1449994@bhelgaas>
 <CAPf=4Rc2vQrWqcs=-ND3iOZFJyKE7FdPoqU9w6DKjoSaJo6KaQ@mail.gmail.com>
 <ZgLefFQanbq-ozKM@smile.fi.intel.com>
 <ZgLooJa1JVKEMOtf@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZgLooJa1JVKEMOtf@smile.fi.intel.com>

On Tue, 26 Mar 2024, Andy Shevchenko wrote:

> On Tue, Mar 26, 2024 at 04:41:01PM +0200, Andy Shevchenko wrote:
> > On Tue, Mar 26, 2024 at 11:06:38AM +0100, Mateusz K wrote:
> > > I tried the patch that changes PCI_IRQ_LEGACY into PCI_IRQ_ALL_TYPES
> > > and it seems I get some other error now
> > > 
> > > [    1.477341] intel-lpss 0000:00:15.0: enabling device (0004 -> 0006)
> > > [    1.477466] intel-lpss 0000:00:15.0: can't derive routing for PCI INT A
> > > [    1.477468] intel-lpss 0000:00:15.0: PCI INT A: not connected
> > > [    1.477488] intel-lpss 0000:00:15.0: probe with driver intel-lpss
> > > failed with error -2147483648
> > > [    1.489572] intel-lpss 0000:00:15.2: enabling device (0004 -> 0006)
> > > [    1.489688] intel-lpss 0000:00:15.2: can't derive routing for PCI INT C
> > > [    1.489689] intel-lpss 0000:00:15.2: PCI INT C: not connected
> > > [    1.489715] intel-lpss 0000:00:15.2: probe with driver intel-lpss
> > > failed with error -2147483648
> > > [    1.501886] intel-lpss 0000:00:19.0: enabling device (0004 -> 0006)
> > > [    1.502034] intel-lpss 0000:00:19.0: can't derive routing for PCI INT A
> > > [    1.502036] intel-lpss 0000:00:19.0: PCI INT A: not connected
> > > [    1.502067] intel-lpss 0000:00:19.0: probe with driver intel-lpss
> > > failed with error -2147483648
> > > [    1.514288] intel-lpss 0000:00:19.1: enabling device (0004 -> 0006)
> > > [    1.514535] intel-lpss 0000:00:19.1: can't derive routing for PCI INT B
> > > [    1.514538] intel-lpss 0000:00:19.1: PCI INT B: not connected
> > > [    1.514570] intel-lpss 0000:00:19.1: probe with driver intel-lpss
> > > failed with error -2147483648
> > > [    1.526291] intel-lpss 0000:00:1e.0: enabling device (0004 -> 0006)
> > > [    1.526555] intel-lpss 0000:00:1e.0: can't derive routing for PCI INT A
> > > [    1.526557] intel-lpss 0000:00:1e.0: PCI INT A: not connected
> > > [    1.526604] intel-lpss 0000:00:1e.0: probe with driver intel-lpss
> > > failed with error -2147483648
> > > [    1.538130] intel-lpss 0000:00:1e.3: enabling device (0004 -> 0006)
> > > [    1.538233] intel-lpss 0000:00:1e.3: can't derive routing for PCI INT D
> > > [    1.538235] intel-lpss 0000:00:1e.3: PCI INT D: not connected
> > > [    1.538253] intel-lpss 0000:00:1e.3: probe with driver intel-lpss
> > > failed with error -2147483648
> > 
> > Hmm... I have a unique board to test :-)
> > Let's revert it then.
> > 
> > Bjorn, in such case your tree should keep conversion one.
> > 
> > Lee, do you prefer a revert or can you simply drop this from the queue?
> 
> Hold on, but IIUC this is the report about new hardware that never had
> a support by Linux before.

So a revert is no longer required?

-- 
Lee Jones [李琼斯]

