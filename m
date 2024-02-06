Return-Path: <linux-kernel+bounces-55612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB1684BEF8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 21:53:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFD981C24367
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 20:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F4C1B815;
	Tue,  6 Feb 2024 20:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="pL89gkvi"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19131B81B;
	Tue,  6 Feb 2024 20:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707252829; cv=none; b=Bz04naJjZaW8e3X6SELcsnyaEUQC9O56llxKRlFwJ3nrV3ang8nz8ydhHft4IjM7gqLles/pKj9soHUFR3tRv+e8ln15LhM8p/hbvWbjLcKLelp6LmJmYtbrAmal35UCgkQnt5OP7DUAJFDR32mva7wcWx6hBhID5NcCqjuwkTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707252829; c=relaxed/simple;
	bh=3yBNu+3PGTah2lBJDL1Nna3OuczWn2UEB53W02vWmWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JabG8V4zCvVvKIeGv1WxyXN94p/CJxe2x0g8G/iB0Wkd3d0NcNpNnFHvvgL6KUspSe4YxooccKrzr5QmswwhSTQz2OTVJU/+tDBEJvOOtXgRoXlmnczcmLvQzo0AYTVraACiJzmbrlqIn5F8QM+Ei3oPkSsaUwB+K8g1XhyH8gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=pL89gkvi; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707252826;
	bh=3yBNu+3PGTah2lBJDL1Nna3OuczWn2UEB53W02vWmWE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pL89gkvi1w7ZkMwqatdGvmDni8qTulCApNhPHgcvl9OgTpB2LHcdysB7n/CD5kjB2
	 Jc0quntxeyOV0kHImvsbwGhc/36vTBYnLZMsljYAymKCDvnrIlJYGb1GDrE5hjwwDS
	 fI46EX5Lcj+y0Dg715xrmQ+hETcdAiAP18q2Pg0HVujutCKE958rO7feSSb/3l1T0G
	 +pKWO2C9JjEFIZs7Sy1QateTaU6Z3vmwRj2NVpDrnqKKymntxKuhR545jucLGkSG8h
	 5kw4+JfeAHhLjMbfRCwbkQgYMgp/VezsKz50OEermnL30DNqo4wGvX1ac38IuNjJcZ
	 DniKAni/3RZRA==
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 5CE7A3782081;
	Tue,  6 Feb 2024 20:53:43 +0000 (UTC)
Date: Tue, 6 Feb 2024 15:53:41 -0500
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Brian Norris <briannorris@chromium.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Tzung-Bi Shih <tzungbi@kernel.org>, kernel@collabora.com,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	chrome-platform@lists.linux.dev,
	Abhijit Gangurde <abhijit.gangurde@amd.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
	Umang Jain <umang.jain@ideasonboard.com>,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/7] firmware: coreboot: Generate aliases for coreboot
 modules
Message-ID: <4c6954a2-5142-41bf-bda2-9de76c380d09@notapiano>
References: <20240112131857.900734-1-nfraprado@collabora.com>
 <20240112131857.900734-3-nfraprado@collabora.com>
 <ZaQVScQ2AYquG-Zr@smile.fi.intel.com>
 <ZbA4VthTMPT7BSRo@google.com>
 <2024013059-poison-equation-81d1@gregkh>
 <CA+ASDXM-m6U+JFvBSSHMxAf8Ct-T-pL8tmcHxHQjepdRFR-s1w@mail.gmail.com>
 <2024013012-gully-goofy-2a55@gregkh>
 <679fa364-28d0-4faa-b46e-805faf56ae53@notapiano>
 <2024020105-dash-antiquity-a56b@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2024020105-dash-antiquity-a56b@gregkh>

On Thu, Feb 01, 2024 at 06:21:03PM -0800, Greg Kroah-Hartman wrote:
> On Thu, Feb 01, 2024 at 05:45:19PM -0500, Nícolas F. R. A. Prado wrote:
> > On Tue, Jan 30, 2024 at 04:23:02PM -0800, Greg Kroah-Hartman wrote:
> > > On Tue, Jan 30, 2024 at 04:01:57PM -0800, Brian Norris wrote:
> > > > On Tue, Jan 30, 2024 at 3:51 PM Greg Kroah-Hartman
> > > > <gregkh@linuxfoundation.org> wrote:
> > > > > On Tue, Jan 23, 2024 at 02:06:14PM -0800, Brian Norris wrote:
> > > > > > "Don't you want to have a driver data or so associated with this?"
> > > > ...
> > > > > But why limit yourself to 32bits now?  Why not make it 64?  It is going
> > > > > to be sent to userspace, so you have to be very careful about it.
> > > > 
> > > > Is that question related to the question I pasted/replied to, about
> > > > driver data? Or a new topic? Sorry if I'm misunderstanding.
> > > 
> > > Same question, driver data, you make it 32 bits.
> > > 
> > > > Anyway, for the size of the tag field: I don't have a strong opinion.
> > > > But FWIW, they're coming from this project:
> > > > 
> > > > https://review.coreboot.org/plugins/gitiles/coreboot/+/269b23280f928510bcadd23182294e5b9dad11ec/payloads/libpayload/include/coreboot_tables.h#36
> > > > 
> > > > As you can see there, we're extremely far from exhausting 16 bits, let alone 32.
> > > 
> > > We've run into running out of bits in other subsystems before, it's
> > > "free" now, just be safe and make it 64 like I think Andy is suggesting.
> > 
> > Either you and Andy are suggesting different things, or I still don't quite get
> > what you mean.
> > 
> > Andy was suggesting we added a driver_data field, that is:
> > 
> > struct coreboot_device_id {
> > 	__u32 tag;
> > 	kernel_ulong_t driver_data;
> > };
> > 
> > You're suggesting we make the tag 64 bits long:
> > 
> > struct coreboot_device_id {
> > 	__u64 tag;
> > };
> 
> Yeah, I'm confused, sorry.
> 
> Yes, add some driver_data, and if you are SURE your tag will NEVER be
> larger than 32 bits, stick with that, but really, you are using the
> space in empty padding anyway, so just make it 64bits please.

Ok, after giving it a closer look, I've decided we really should just stick with
32 bits.

More fundamental than the previous argument that we aren't close to exhausting
32 bits for the tag in coreboot, is the fact that tags are literally defined as
32 bits long for the table entries [1]. Meaning, a tag being 32 bits long is
part of the coreboot ABI. We have to parse it as 32bits from memory.
Representing it as 64 bits internally and exposing it as 64 bits to userspace
would not only be unecessarily complicating things, but also misrepresenting the
data that we're getting from the firmware.

I can add driver_data for v4 no problem, as we can simply not use it while we
don't need it, but having tags be 64 bits actively complicates things for no
real gain, so it's a no-go.

Thanks,
Nícolas

[1] https://review.coreboot.org/plugins/gitiles/coreboot/+/refs/heads/main/src/commonlib/include/commonlib/coreboot_tables.h#128

