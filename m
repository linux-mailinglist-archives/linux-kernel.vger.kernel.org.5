Return-Path: <linux-kernel+bounces-91418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE93871143
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 00:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 266181C219FF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 23:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8677D088;
	Mon,  4 Mar 2024 23:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="C8+DI2f+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1A317555;
	Mon,  4 Mar 2024 23:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709595731; cv=none; b=b+ruZV3qkC5p0a6Obtq85rs1jlObhWC9WISV2jSOos2AxzYkP8a2rZVgYvKKubwpMleGqSGGMdc4jcQ9hI//0BJGjSJ9oJMFCOcPxxenMULHxNZ0AkbmY5tP7Uz2QFK1svslagV8n8LL3v4WJQ5bKJvcIh30WVo8N/ecwULTIkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709595731; c=relaxed/simple;
	bh=ODwOIJnsoYs+tJJkR4iryVyJ94Y2iXW5AzaX0Y/ymF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u8wqu3vpE7Ov48/KqQPuuZSyZZLG0+GodGSLbSkvNaKNjvr7eWeBqfrEDcwZ7OW/WXzVU/jYSRETtE8Fezro9vLdLSmRMcwhf1Tt8PHtkRkQoX9VUzMeWyrx5ZpA0rZvHvbdCHU4phs3u0PHoIdND09GWmDm0bqnRiXJ1MKNXRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=C8+DI2f+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B54BEC433C7;
	Mon,  4 Mar 2024 23:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709595731;
	bh=ODwOIJnsoYs+tJJkR4iryVyJ94Y2iXW5AzaX0Y/ymF4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C8+DI2f+U1Q5qSovuUQRTgF394V3BApAvw58oB8pVEJobwGWAxfp8K0NOuRoR2UE1
	 Mx0E3R1ykV0mDUzu7P8md/Sk1Ew81aLHDbPamtuAzDHAEf6qM4P2ATyID1O+MkQxaV
	 Mfpfy4PMzQWJLT2qPlNBJXvbInVKcLZ7W6EaynvY=
Date: Mon, 4 Mar 2024 23:42:08 +0000
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	"derek.kiernan@amd.com" <derek.kiernan@amd.com>,
	Kees Cook <keescook@chromium.org>, linux-arm-msm@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	John Stultz <jstultz@google.com>,
	Michal Simek <michal.simek@amd.com>,
	"dragan.cvetic@amd.com" <dragan.cvetic@amd.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Justin Stitt <justinstitt@google.com>,
	Frederic Barrat <fbarrat@linux.ibm.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Tomas Winkler <tomas.winkler@intel.com>,
	Amol Maheshwari <amahesh@qti.qualcomm.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	Appana Durga Kedareswara rao <appana.durga.kedareswara.rao@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	Andrew Donnellan <ajd@linux.ibm.com>
Subject: Re: [PATCH 00/11] misc: Convert to platform remove callback
 returning void
Message-ID: <2024030453-charter-villain-8393@gregkh>
References: <cover.1708508896.git.u.kleine-koenig@pengutronix.de>
 <d6c4ff9e-756a-4604-993a-cf14cfdbc53c@app.fastmail.com>
 <p2rqzrmgfaqdcwj2hlgt7u2yrgfrf4dwizecicdpdmb3jezoky@zmkxw5vt7qyi>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <p2rqzrmgfaqdcwj2hlgt7u2yrgfrf4dwizecicdpdmb3jezoky@zmkxw5vt7qyi>

On Mon, Mar 04, 2024 at 11:36:23PM +0100, Uwe Kleine-König wrote:
> Hello Arnd, hello Greg,
> 
> On Wed, Feb 21, 2024 at 02:52:29PM +0100, Arnd Bergmann wrote:
> > On Wed, Feb 21, 2024, at 10:53, Uwe Kleine-König wrote:
> > > Hello,
> > >
> > > this series converts all drivers below drivers/misc to struct
> > > platform_driver::remove_new(). See commit 5c5a7680e67b ("platform:
> > > Provide a remove callback that returns no value") for an extended
> > > explanation and the eventual goal.
> > >
> > > All conversations are trivial, because their .remove() callbacks
> > > returned zero unconditionally.
> > >
> > > There are no interdependencies between these patches, so they could be
> > > picked up individually. But I'd hope that Greg or Arnd picks them up all
> > > together.
> > 
> > These all look good to me, whole series
> > 
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> Thanks.
> 
> You (= Arnd and Greg) are the listed maintainers for drivers/misc/. How
> is this series supposed to be merged? Would a pull request help?

I can take the patchset, let me catch up...

