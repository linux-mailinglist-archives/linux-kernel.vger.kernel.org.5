Return-Path: <linux-kernel+bounces-49111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DDD88465F7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 03:42:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 909E21C24020
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 02:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7BDDBE73;
	Fri,  2 Feb 2024 02:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BO27UZx6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5C6BE69;
	Fri,  2 Feb 2024 02:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706841743; cv=none; b=qVvo4OPRO5254U5IXCDi+LAGruaAtSEHGohMvA0tP6V2QWS1Wwiz0+HJaKL1q5GKYzVu0yLtWUvXaUyIOgy4uA9HPhkGJezdTffCpYB0HxneE3roYFYkkZgLJPmjGoYoNOxGqDaWDZkPEnWktYBCYAtgYnmi12fI1ORzMdKaAKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706841743; c=relaxed/simple;
	bh=ACb2Pq3WaRCfkIQVQ7Pcbsp7XchKA0M9Swopp1R7g+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KU16or3Azfa4FabG3IKRFvaA8cJN/wXE8PnARXl9qLA5Y4bFEIraEaMjUfMdw7+aLV8TthGWOB7N1Lv4ks7l6iKHvc8NPta8uddjeilKaZuPyxchML6l9K1Bqy5sWXjG7juZ0HGzW5bn9imjecnzvkhGoHdS5tPtxQAnAMk6EeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BO27UZx6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6464CC433C7;
	Fri,  2 Feb 2024 02:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706841742;
	bh=ACb2Pq3WaRCfkIQVQ7Pcbsp7XchKA0M9Swopp1R7g+w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BO27UZx6nnAn8F3Dsx6V1mHpHtwrNiLSEHcDD8xZHWPspKM6Nz2SBydsr19FBcn9D
	 qzgOb9X9jm+2ZO0vz9y2qs4ZJRwYMBLT0Go7PvJWvMI1D/6eJ6pjs55ib3p6R8bXSm
	 haNPFacc30LF8K0CumZPNZNj92MPVfVl7xOZJA3g=
Date: Thu, 1 Feb 2024 18:42:21 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Hegde, Suma" <Suma.Hegde@amd.com>, naveenkrishna.chatradhi@amd.com,
	LKML <linux-kernel@vger.kernel.org>,
	Carlos Bilbao <carlos.bilbao@amd.com>,
	Hans de Goede <hdegoede@redhat.com>,
	platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH] platform/x86/amd/hsmp: switch to use device_add_groups()
Message-ID: <2024020112-shrouded-ferry-7617@gregkh>
References: <2024012822-exalted-fidgeting-f180@gregkh>
 <0d110d2a-da0c-017a-0e5a-fc6bef7b066a@linux.intel.com>
 <e73426f6-6d50-4ed7-8613-1ec42fa3f991@amd.com>
 <2024020144-duplicity-nuptials-1cd7@gregkh>
 <f48ebcb1-8f87-efee-08ed-844775c995aa@linux.intel.com>
 <2024020138-monologue-claim-41d4@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2024020138-monologue-claim-41d4@gregkh>

On Thu, Feb 01, 2024 at 06:40:30PM -0800, Greg Kroah-Hartman wrote:
> On Thu, Feb 01, 2024 at 04:34:30PM +0200, Ilpo Järvinen wrote:
> > On Thu, 1 Feb 2024, Greg Kroah-Hartman wrote:
> > 
> > > On Thu, Feb 01, 2024 at 06:50:33PM +0530, Hegde, Suma wrote:
> > > > On 1/29/2024 6:16 PM, Ilpo Järvinen wrote:
> > > > > Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> > > > > 
> > > > > 
> > > > > + Cc Suma Hegde.
> > > > > 
> > > > > On Sun, 28 Jan 2024, Greg Kroah-Hartman wrote:
> > > > > 
> > > > > > The use of devm_*() functions works properly for when the device
> > > > > > structure itself is dynamic, but the hsmp driver is attempting to have a
> > > > > > local, static, struct device and then calls devm_() functions attaching
> > > > > > memory to the device that will never be freed.
> > > > > > 
> > > > > > The logic of having a static struct device is almost never a wise
> > > > > > choice, but for now, just remove the use of devm_device_add_groups() in
> > > > > > this driver as it obviously is not needed.
> > > > 
> > > > Hi Greg,
> > > > 
> > > > Could you please hold on merging this patch for a week? I will push a patch
> > > > for converting platform specific structure's memory allocation from static
> > > > to a dynamic
> > > > 
> > > > allocation.
> > > 
> > > Push it where?  Ususally we do "first patch wins" type stuff, why not
> > > just do your work on top of mine?
> > > 
> > > Also, when you do make the needed changes, please remove the explicit
> > > call to create sysfs groups and use the default groups pointer instead,
> > > that will make things much simpler and avoid races in the code.
> > 
> > Hi Greg,
> > 
> > Well, if you really want to "win" :-), please provide an updated version 
> > which considers the changes already made in the for-next branch (the 
> > current one won't apply).
> 
> It applies just fine to the latest linux-next tree, version
> -next-20240201, what tree/branch are you referring to here?

Ah platform driver tree, got it, will rebase...

