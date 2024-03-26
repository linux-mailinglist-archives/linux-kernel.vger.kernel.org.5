Return-Path: <linux-kernel+bounces-119994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B339D88CFDD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 22:20:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E57191C62EF2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F3813D617;
	Tue, 26 Mar 2024 21:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WLjnCe06"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5403B12AAEF;
	Tue, 26 Mar 2024 21:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711487997; cv=none; b=UKY4sfRk2uZzuEXQg7HMzJYkKMjuFkli4mvSX9AoXU8plaPziMZg7NLMT5beNam6L8L1hQni8hB8hnCUy48ozdCXi0dON5W+ZQvImHHoWPgcWM4/DvlYaHlChPnVlwEhOOI+7wQgwm2XO2SelvS+pBiihrf1xCYhOtiWMrlHfcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711487997; c=relaxed/simple;
	bh=PtcVq2IBfbHwquK1C5LX+o56w7nX57P5Da5pZ9tBVi4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=NwDjZiciGC0vS+acBJk4T5PM9ZGvPY0kcsFB1eZRxA8yyfmR6oyEfEtTN21bS38hWSg8a+g9ST2z2tJbw7b5L/euq1p0jHqs1zpKNvyB4OKjxRP2O1gwIA8gigj9Xr0d7ZS19HywfxjwlzvC99O5tyIt4gzMhh6fDlUL1bRW/Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WLjnCe06; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A07FCC433C7;
	Tue, 26 Mar 2024 21:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711487996;
	bh=PtcVq2IBfbHwquK1C5LX+o56w7nX57P5Da5pZ9tBVi4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=WLjnCe06KBKhcNOFdNFNqs4vfybWqKE93ou7HRl+Saho6ifNs2lISmzjLYzyoLkRb
	 25cjyRjdrYukMWjPhk2wzLLm65KCNhbOlxriYthLv3OPnjdrzW8xasw0RvFHvELV5T
	 Y0Rf4XHyAqFyGWk1R/05DLfjVmfhVZfCePHJHTyOEdmBU+oNjqdiyOmYnNDR4xNEbH
	 OsuGAO+zBCvwaNCFpv7HSLkt7eA+gQfLZQlXoPh/Di04RVWb+/WUmJ0f/CC304ZJ22
	 LTroO4nEsHQXizJpb3dvrXnJe9C8gU2uMmWP5YZDIZbI8/WXJQBYrTnBqBqTlUrWRJ
	 2L77wUMaiSm/g==
Date: Tue, 26 Mar 2024 16:19:54 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: adrian.hunter@intel.com, ulf.hansson@linaro.org,
	Victor Shih <victor.shih@genesyslogic.com.tw>,
	Ben Chuang <benchuanggli@gmail.com>, linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mmc: sdhci-pci-gli: GL975x: Mask rootport's replay
 timer timeout during suspend
Message-ID: <20240326211954.GA1497572@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAd53p5p=JJ9OOQd=XPzJgW7yib+hMJxZqj7PZFsd2uFtK94xg@mail.gmail.com>

On Tue, Mar 26, 2024 at 09:52:28AM +0800, Kai-Heng Feng wrote:
> On Tue, Mar 26, 2024 at 3:02 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Mon, Mar 25, 2024 at 10:02:27AM +0800, Kai-Heng Feng wrote:
> > > On Sat, Mar 23, 2024 at 12:43 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> ...

> > > > If that's the case, why do the
> > > > masking in the suspend/resume callbacks?
> > >
> > > Because there's no functional impact when the error happens, other
> > > than suspend/resume.
> >
> > Oh, I think I see.  Is this accurate?
> >
> >   Due to a hardware defect in GL975x, config accesses when ASPM is
> >   enabled frequently cause Replay Timer Timeouts in the Port leading
> >   to the device.
> >
> >   These are Correctable Errors, so the Downstream Port logs it in its
> >   PCI_ERR_COR_STATUS and, when the error is not masked, sends an
> >   ERR_COR message upstream.  The message terminates at a Root Port,
> >   which may generate an AER interrupt so the OS can log it.
> >
> >   The Correctable Error logging is an annoyance but normally not a
> >   major issue.  But when the AER interrupt happens during suspend, it
> >   can prevent the system from suspending.
> 
> That's totally the case here.
> 
> This brings up another different but related topic  - should the port
> driver disable AER/DPC IRQ during suspend?
> We've discussed this many times, I still think that's the right
> approach to "quiesce" many unexpected errors during system state
> transition.

Maybe so.  We can continue that in the context of that patch.  Maybe
it needs to be reposted; I can't remember where it's at right now.

> > I think we should log a hint in dmesg that we're masking
> > PCI_ERR_COR_REP_TIMER because the error will still be logged in the
> > PCI_ERR_COR_STATUS register, and that will be visible via lspci, and a
> > dmesg hint will save debugging time when people report that.
> 
> Sure. Where do you think it's a better place to implement the quirk? I
> Assume PCI quirk is a better place than driver's probe routine?

Yes, I think drivers/pci/quirks.c is a better place so we can mask it
even if the driver isn't loaded.  Users can still run lspci and see
these errors even if the driver isn't loaded.

Bjorn

