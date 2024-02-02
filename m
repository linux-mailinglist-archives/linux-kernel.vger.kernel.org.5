Return-Path: <linux-kernel+bounces-49110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B0F8465F5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 03:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 342F41F2507F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 02:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A8CBE73;
	Fri,  2 Feb 2024 02:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dheUGUbY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F340C2CD;
	Fri,  2 Feb 2024 02:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706841631; cv=none; b=fMqKAPuYWCSV6nzU21Ckt+rCrug55pNJvosOVvsw3RXl+wCDTio1Rr/DPP7nE25Cq7Efq47D/o8aXLtZCezzBvkNF1AC18VRKrrxykAisO37z9SqcRXetyqTBE6XwZVdJkd7pRA6CkKBp85Hhtlrnlf5LM+H89cMG7Pt9gN5y3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706841631; c=relaxed/simple;
	bh=IIW7zY26kn4sAgb4s5AHDa6fmJAMG2UJn1ZMIaqET5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eadDLfhB4e7XHEh19Dzli65D0eVaTIcnmXp5djTa8i71lb8mAWxl8/YP/4HfswBIHCsu/mbuSgjyShSffDS/Mfc/N3m8z+6y9I2RLftUpGAqsc04pqcsm4zdiIxSJYo+4reTCmdMsuKRB+LU+hJtaK/DT3w2WSWXR4J2hdfvb0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dheUGUbY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEEADC43390;
	Fri,  2 Feb 2024 02:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706841631;
	bh=IIW7zY26kn4sAgb4s5AHDa6fmJAMG2UJn1ZMIaqET5Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dheUGUbYGJyGAMTYC+91FiGTvpC0heWgBTPpSnE4o6bEANBlG7Np0ezFoLMdDApID
	 yDrqfmNPCVxJvOVxrq100aeQmG/X+F3s58VOqTSlV82Dd7b4oe06saC1iSgeK/dGVb
	 UAHvaQxQAo76KWugJQWOxa34HBzWuULMWGC3PO+w=
Date: Thu, 1 Feb 2024 18:40:30 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Hegde, Suma" <Suma.Hegde@amd.com>, naveenkrishna.chatradhi@amd.com,
	LKML <linux-kernel@vger.kernel.org>,
	Carlos Bilbao <carlos.bilbao@amd.com>,
	Hans de Goede <hdegoede@redhat.com>,
	platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH] platform/x86/amd/hsmp: switch to use device_add_groups()
Message-ID: <2024020138-monologue-claim-41d4@gregkh>
References: <2024012822-exalted-fidgeting-f180@gregkh>
 <0d110d2a-da0c-017a-0e5a-fc6bef7b066a@linux.intel.com>
 <e73426f6-6d50-4ed7-8613-1ec42fa3f991@amd.com>
 <2024020144-duplicity-nuptials-1cd7@gregkh>
 <f48ebcb1-8f87-efee-08ed-844775c995aa@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f48ebcb1-8f87-efee-08ed-844775c995aa@linux.intel.com>

On Thu, Feb 01, 2024 at 04:34:30PM +0200, Ilpo Järvinen wrote:
> On Thu, 1 Feb 2024, Greg Kroah-Hartman wrote:
> 
> > On Thu, Feb 01, 2024 at 06:50:33PM +0530, Hegde, Suma wrote:
> > > On 1/29/2024 6:16 PM, Ilpo Järvinen wrote:
> > > > Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> > > > 
> > > > 
> > > > + Cc Suma Hegde.
> > > > 
> > > > On Sun, 28 Jan 2024, Greg Kroah-Hartman wrote:
> > > > 
> > > > > The use of devm_*() functions works properly for when the device
> > > > > structure itself is dynamic, but the hsmp driver is attempting to have a
> > > > > local, static, struct device and then calls devm_() functions attaching
> > > > > memory to the device that will never be freed.
> > > > > 
> > > > > The logic of having a static struct device is almost never a wise
> > > > > choice, but for now, just remove the use of devm_device_add_groups() in
> > > > > this driver as it obviously is not needed.
> > > 
> > > Hi Greg,
> > > 
> > > Could you please hold on merging this patch for a week? I will push a patch
> > > for converting platform specific structure's memory allocation from static
> > > to a dynamic
> > > 
> > > allocation.
> > 
> > Push it where?  Ususally we do "first patch wins" type stuff, why not
> > just do your work on top of mine?
> > 
> > Also, when you do make the needed changes, please remove the explicit
> > call to create sysfs groups and use the default groups pointer instead,
> > that will make things much simpler and avoid races in the code.
> 
> Hi Greg,
> 
> Well, if you really want to "win" :-), please provide an updated version 
> which considers the changes already made in the for-next branch (the 
> current one won't apply).

It applies just fine to the latest linux-next tree, version
-next-20240201, what tree/branch are you referring to here?

thanks,

greg k-h

