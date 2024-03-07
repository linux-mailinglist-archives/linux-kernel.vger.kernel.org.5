Return-Path: <linux-kernel+bounces-95804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 073898752F3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 16:18:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E58ABB29EB9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 15:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC30212F37E;
	Thu,  7 Mar 2024 15:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J6BX5Gb8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3088A12EBF1
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 15:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709824629; cv=none; b=pC+LWh23vRFgHZoCHL2p1BaUK/CyH0vap6mKWOwyaa2GmWLOTX2vsz9zZKeAvjdJ0FJS5KoB/nE25CHCKer5wnl0mZ9M2QIH5G4B5V7I9FLMXv8RNVzQp7KZSd4iP53fKEZX6xmT689gVKsh/jIf7G4oou8yIlC7dejDh4vyMKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709824629; c=relaxed/simple;
	bh=bcLaWbBdhUfJxU9PF6Qxo7YRYTZ8kvqVGWXXOykqSHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F2MvrS5r7JCzyevyrW/ipe6t/ob5CD8j0HjarTqo9H8JcqsRotHqDw3YepatBVlyBvUO3e97W/mNMNMNYZhBs4YkxZOFjKO0zn73oTx8rnUgvFrX1H3mocz2/EWVEdHprvf0IsrHOD9cmAdhfPs4dl6CNVH1eyaMOuiA13KVQNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J6BX5Gb8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07169C433F1;
	Thu,  7 Mar 2024 15:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709824628;
	bh=bcLaWbBdhUfJxU9PF6Qxo7YRYTZ8kvqVGWXXOykqSHU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J6BX5Gb8dHBGAgqEHmtm/z5NoMyr0XGC4ohF8EapfRMPzoiaWvmVpWGF7/Whk2sVN
	 HJ8zaCB8Z5cx6V1j/pscPkfgQUZ2Df9XtiOkN1DnVlp+jzaNbEwluCRCPKZqOVihHy
	 VedeRFyzlUGBaPnJ/S2fcv3zLjDMJ2X6fatx+5hXLfH1qp5K3UhPa5vt12cMPMUlbn
	 JLFsQqxrAnchzuptZNZn6rIqrLjm+7boixC4PZXRtm2lL/DCAakRZp1j7jrIT+ciER
	 izIff1KnKPMZLJ01HVlb1v8i1PiTF12yEvdQ2+GLGKTLT+JA6rSK/JjX43Y3LEDelr
	 kwd/aUvRCDN3A==
Date: Thu, 7 Mar 2024 08:17:05 -0700
From: Keith Busch <kbusch@kernel.org>
To: Len Brown <lenb@kernel.org>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, linux-nvme@lists.infradead.org,
	maxg@mellanox.com, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
Subject: Re: [PATCH 1/1] nvme: Use pr_dbg, not pr_info, when setting shutdown
 timeout
Message-ID: <ZenacXkUAh4I1gkK@kbusch-mbp>
References: <49a7c0b667abe23d95d67cf0cf7ea7e193d9f2a1.1709773065.git.len.brown@intel.com>
 <dc6c4d98-e56a-448d-b372-38ce0cd927e9@nvidia.com>
 <CAJvTdK=Fbo0in7diYv_4Zk_-zrOPP4skDgpTMOYw-UM8=3R29Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJvTdK=Fbo0in7diYv_4Zk_-zrOPP4skDgpTMOYw-UM8=3R29Q@mail.gmail.com>

On Thu, Mar 07, 2024 at 09:27:21AM -0500, Len Brown wrote:
> On Thu, Mar 7, 2024 at 4:29 AM Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
> 
> > > Some words are alarming in routine kernel messages.
> > > "timeout" is one of them...
>
> > > Here NVME is routinely setting a timeout value,
> > > rather than reporting that a timeout has occurred.
> >
> > No.
> > see the original commit message
> >
> > "When an NVMe controller reports RTD3 Entry Latency larger than the
> > value of shutdown_timeout module parameter, we update the
> > shutdown_timeout accordingly to honor RTD3 Entry Latency. Use an
> > informational debug level instead of a warning level for it."
> >
> > So this is not a routine flow. This informs users about using a
> > different value than the module param they set.
> 
> I have machines in automated testing.
> Those machines have zero module params.
> This message appears in their dmesg 100% of the time,
> and our dmesg scanner complains about them 100% of the time.
> 
> Is this a bug in the NVME hardware or software?
> 
> If yes, I'll be happy to help  debug it.
> 
> If no, then exactly what action is the informed user supposed to take
> upon seeing this message?
> 
> If none, then the message serves no purpose and should be deleted entirely.

It lets you know that your device takes longer to safely power off than
the module's default tolerance. System low power transitions may take a
long time, and at one point, people wanted to know about that since it
may affect their power management decisions.

This print was partly from when NVMe protocol did not provide a way to
advertise an appropriate shutdown time, and we had no idea what devices
in the wild actually needed. We often just get a dmesg with bug reports,
and knowing device's shutdown timings was helpful at one point with
suspend and power off issues.

You can make the print go away by adding param

  nvme_core.shutdown_timeout=<Largest Observed Value>

But personally, I don't find this print very useful anymore, so I don't
care if it gets removed.

