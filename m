Return-Path: <linux-kernel+bounces-31609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED27D8330CD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 23:41:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 876FA1F2160F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 22:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF1E56B84;
	Fri, 19 Jan 2024 22:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j4wd/D3L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0E81E48B;
	Fri, 19 Jan 2024 22:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705704056; cv=none; b=uIUO5iTqp/hu0zHckMxcC3S0WJI5vMOtP8iBj73+l/9LUwGRjTHuUi+2SbgmMctNFy6fz5yU9AwMImApdymPeW7+9ZKs0V8KTPI/JFoGr+9xrINb86VmOYQKeHsQmhZNpv9SahmrQtElFQR250KixEPKcXVMUO1RvKH3hCRPbDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705704056; c=relaxed/simple;
	bh=nz9TfAIKTDYYfKIsjPDHg+tXyY7yGKcv76BL1axJAno=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=g7HGCT60dBW9UgIMO083Q2HytVMtrdnc8bG/0ilHvYC1GZLJC22vL0+2MZsFVYL9kjmoLSocao1ZgtgCYmxUgvHpAI6GaxKdlYobNfxR2mOW6QrtTlQ3CuRwOvgQmriVn0C8PfK9AatREptb5g392f7AK2mTM9GeaGmtFARqiOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j4wd/D3L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 598D7C433F1;
	Fri, 19 Jan 2024 22:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705704055;
	bh=nz9TfAIKTDYYfKIsjPDHg+tXyY7yGKcv76BL1axJAno=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=j4wd/D3Lv8cYHiOsEE907KBlNaTbtxYev4dGj+w6L2X8eoVqCRgu0pzY6Sr6jDv8B
	 a5wscl+4Dlbf/EVr6PjxSj/otwwWSTsj6izfoHhAkfIl39cIfb0/w3Q+CHGYhcEQrC
	 f/4eDJ8XEH4ggAnw35848tpWYQtTda335GSGPYyY9T8aY7Wm5GMYgiRmukEZZgNIiN
	 0YL05mAtsOMeLaQYdaaeImCqRXHthh39HzxBRN2SZcQ8ZIcRZq/m68pS1VVcvaUv+D
	 pwYk/i8oegrrUEvXZXIL1tMUwaXSpFADiGoDALqffcZ5oxdru2EILr6+/QRmJdIOT/
	 taUUcFcXwU2ow==
Date: Fri, 19 Jan 2024 16:40:53 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: adrian.hunter@intel.com, ulf.hansson@linaro.org,
	Victor Shih <victor.shih@genesyslogic.com.tw>,
	Ben Chuang <benchuanggli@gmail.com>, linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mmc: sdhci-pci-gli: GL975x: Mask rootport's replay
 timer timeout during suspend
Message-ID: <20240119224053.GA187501@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAd53p6qE76QjJmjr5ei0mU8xcSNE32hJMOE9Frwz-BuC3gDkA@mail.gmail.com>

On Thu, Jan 18, 2024 at 02:40:50PM +0800, Kai-Heng Feng wrote:
> On Sat, Jan 13, 2024 at 1:37 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Fri, Jan 12, 2024 at 01:14:42PM +0800, Kai-Heng Feng wrote:
> > > On Sat, Jan 6, 2024 at 5:19 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > On Thu, Dec 21, 2023 at 11:21:47AM +0800, Kai-Heng Feng wrote:
> > > > > Spamming `lspci -vv` can still observe the replay timer timeout error
> > > > > even after commit 015c9cbcf0ad ("mmc: sdhci-pci-gli: GL9750: Mask the
> > > > > replay timer timeout of AER"), albeit with a lower reproduce rate.
> > > >
> > > > I'm not sure what this is telling me.  By "spamming `lspci -vv`, do
> > > > you mean that if you run lspci continually, you still see Replay Timer
> > > > Timeout logged, e.g.,
> > > >
> > > >   CESta:        ... Timeout+
> > >
> > > Yes it's logged and the AER IRQ is raised.
> >
> > IIUC the AER IRQ is the important thing.
> >
> > Neither 015c9cbcf0ad nor this patch affects logging in
> > PCI_ERR_COR_STATUS, so the lspci output won't change and mentioning it
> > here doesn't add useful information.
> 
> You are right. That's just a way to access config space to reproduce
> the issue.

Oh, I think I completely misunderstood you!  I thought you were saying
that suspending the device caused the PCI_ERR_COR_REP_TIMER error, and
you happened to see that it was logged when you ran lspci.

But I guess you mean that running lspci actually *causes* the error?
I.e., lspci does a config access while we're suspending the device
causes the error, and the config access itself causes the error, which
causes the ERR_COR message and ultimately the AER interrupt, and that
interrupt prevents the system suspend.

If that's the case, I wonder if this is a generic problem that could
happen with *any* device, not just GL975x.

What power state do we put the GL975x in during system suspend?
D3hot?  D3cold?  Is there anything that prevents config access while
we suspend it?

We do have dev->block_cfg_access, and there's a comment that says
"we're required to prevent config accesses during D-state
transitions," but I don't see it being used during D-state
transitions.

Also, it doesn't seem suitable for preventing config accesses during
suspend because pci_wait_cfg() just busy-waits and never returns an
error.

Bjorn

