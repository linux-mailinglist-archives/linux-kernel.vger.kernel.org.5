Return-Path: <linux-kernel+bounces-5792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50227818F8B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 19:17:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5D2B283DD4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489FB39ADE;
	Tue, 19 Dec 2023 18:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OZ0fnjAw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706E039AC5;
	Tue, 19 Dec 2023 18:11:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3539C433C7;
	Tue, 19 Dec 2023 18:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703009472;
	bh=Pthe7kfGVzNx+JF4jvBNt3Kbd4VrCiAWzVLzdqj+bqQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OZ0fnjAwvgLQE3MG8q2natKRb+qz0V7gqOZDHnB0bPWKcQ5H/xD97A1mlApd7aOXr
	 jbemNa3WR8dEMnzqelMVvMugFw86p/97jy7RLX2YVQcyiYfTUXEfC66H4qloyP2ori
	 D50L2DjOsttIXjqHGyCkHUmDglfckvLB7I8PpyPc=
Date: Tue, 19 Dec 2023 19:11:09 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Marco Pagani <marpagan@redhat.com>
Cc: Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
	linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: Re: [RFC PATCH v3 2/2] fpga: set owner of fpga_manager_ops for
 existing low-level modules
Message-ID: <2023121927-desolate-choice-a2fe@gregkh>
References: <20231218202809.84253-1-marpagan@redhat.com>
 <20231218202809.84253-3-marpagan@redhat.com>
 <2023121829-zealous-prissy-99cc@gregkh>
 <9296941c-a3c8-4d55-9e52-f1277f1c3fc7@redhat.com>
 <2023121924-extent-defender-fb06@gregkh>
 <b2d3d88e-840d-48b1-86d4-0a89d6143683@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2d3d88e-840d-48b1-86d4-0a89d6143683@redhat.com>

On Tue, Dec 19, 2023 at 06:17:20PM +0100, Marco Pagani wrote:
> 
> On 2023-12-19 16:10, Greg Kroah-Hartman wrote:
> > On Tue, Dec 19, 2023 at 03:54:25PM +0100, Marco Pagani wrote:
> >>
> >>
> >> On 2023-12-18 21:33, Greg Kroah-Hartman wrote:
> >>> On Mon, Dec 18, 2023 at 09:28:09PM +0100, Marco Pagani wrote:
> >>>> This patch tentatively set the owner field of fpga_manager_ops to
> >>>> THIS_MODULE for existing fpga manager low-level control modules.
> >>>>
> >>>> Signed-off-by: Marco Pagani <marpagan@redhat.com>
> >>>> ---
> >>>>  drivers/fpga/altera-cvp.c             | 1 +
> >>>>  drivers/fpga/altera-pr-ip-core.c      | 1 +
> >>>>  drivers/fpga/altera-ps-spi.c          | 1 +
> >>>>  drivers/fpga/dfl-fme-mgr.c            | 1 +
> >>>>  drivers/fpga/ice40-spi.c              | 1 +
> >>>>  drivers/fpga/lattice-sysconfig.c      | 1 +
> >>>>  drivers/fpga/machxo2-spi.c            | 1 +
> >>>>  drivers/fpga/microchip-spi.c          | 1 +
> >>>>  drivers/fpga/socfpga-a10.c            | 1 +
> >>>>  drivers/fpga/socfpga.c                | 1 +
> >>>>  drivers/fpga/stratix10-soc.c          | 1 +
> >>>>  drivers/fpga/tests/fpga-mgr-test.c    | 1 +
> >>>>  drivers/fpga/tests/fpga-region-test.c | 1 +
> >>>>  drivers/fpga/ts73xx-fpga.c            | 1 +
> >>>>  drivers/fpga/versal-fpga.c            | 1 +
> >>>>  drivers/fpga/xilinx-spi.c             | 1 +
> >>>>  drivers/fpga/zynq-fpga.c              | 1 +
> >>>>  drivers/fpga/zynqmp-fpga.c            | 1 +
> >>>>  18 files changed, 18 insertions(+)
> >>>>
> >>>> diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
> >>>> index 4ffb9da537d8..aeb913547dd8 100644
> >>>> --- a/drivers/fpga/altera-cvp.c
> >>>> +++ b/drivers/fpga/altera-cvp.c
> >>>> @@ -520,6 +520,7 @@ static const struct fpga_manager_ops altera_cvp_ops = {
> >>>>  	.write_init	= altera_cvp_write_init,
> >>>>  	.write		= altera_cvp_write,
> >>>>  	.write_complete	= altera_cvp_write_complete,
> >>>> +	.owner		= THIS_MODULE,
> >>>
> >>> Note, this is not how to do this, force the compiler to set this for you
> >>> automatically, otherwise everyone will always forget to do it.  Look at
> >>> how functions like usb_register_driver() works.
> >>>
> >>> Also, are you _sure_ that you need a module owner in this structure?  I
> >>> still don't know why...
> >>>
> >>
> >> Do you mean moving the module owner field to the manager context and setting
> >> it during registration with a helper macro?
> > 
> > I mean set it during registration with a helper macro.
> > 
> >> Something like:
> >>
> >> struct fpga_manager {
> >> 	...
> >> 	struct module *owner;
> >> };
> >>
> >> #define fpga_mgr_register(parent, ...) \
> >> 	__fpga_mgr_register(parent,..., THIS_MODULE)
> >>
> >> struct fpga_manager *
> >> __fpga_mgr_register(struct device *parent, ..., struct module *owner)
> >> {
> >> 	...
> >> 	mgr->owner = owner;
> >> }
> > 
> > Yes.
> > 
> > But again, is a module owner even needed?  I don't think you all have
> > proven that yet...
> 
> Programming an FPGA involves a potentially lengthy sequence of interactions
> with the reconfiguration engine. The manager conceptually organizes these
> interactions as a sequence of ops. Low-level modules implement these ops/steps
> for a specific device. If we don't protect the low-level module, someone might
> unload it right when we are in the middle of a low-level op programming the
> FPGA. As far as I know, the kernel would crash in that case.

The only way an unload of a module can happen is if a user explicitly
asks for it to be unloaded.  So they get what they ask for, right?

How do you "know" it is active?  And why doesn't the normal
"driver/device" bindings prevent unloading from being a problem?  When
you unload a module, you stop all ops on the driver, and then unregister
it, which causes any future ones to fail.

Or am I missing something here?

thanks,

greg k-h

