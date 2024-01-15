Return-Path: <linux-kernel+bounces-26295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D082D82DE32
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 18:09:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57E2C283035
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 17:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25BFC17C96;
	Mon, 15 Jan 2024 17:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mjvCtXil"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0BD18E0C;
	Mon, 15 Jan 2024 17:09:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DCA7C433F1;
	Mon, 15 Jan 2024 17:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705338545;
	bh=EqOMEzkyzNYto3UmIip9XB66HC1aMCqtxgSe2FiBi4I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mjvCtXilB+F7tlBXPufpFIoL+uZ5s6bm559DwsOVDAOKL0F+CaraYCpFlmLbfF6/Q
	 EjC5Fy6G41QsIgoRkD35EDwWOrihkeebauqiWVXBfQrZa1+0Y/RASisVtVmiLTuRk6
	 eGhdOYUpbvtNChB0w/5pkNrmpzNgRHEB7wcdyCpqqI1qtqrYlQLBHHIRt9MqY0ofYh
	 msitEc9VYqPft14r9x/yRjnosv7EZAa3ZkgZZaOK1FsLWl6iC8RmSJqovIlL/18jk/
	 F+22h92t37oDYAe8zT+YeBvv+/CNODIP/dYDYB9N1ce1xsApQ1v7J/gnxDe6pxWzoO
	 fhYcgGy3ZzBnA==
Date: Mon, 15 Jan 2024 11:09:03 -0600
From: Rob Herring <robh@kernel.org>
To: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michael Walle <michael@walle.cc>, linux-mtd@lists.infradead.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, u-boot@lists.denx.de,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH V3 1/6] dt-bindings: nvmem: layouts: add U-Boot
 environment variables layout
Message-ID: <20240115170903.GA911971-robh@kernel.org>
References: <20231221173421.13737-1-zajec5@gmail.com>
 <20240104001129.GA2045237-robh@kernel.org>
 <20240104085839.5624c354@xps-13>
 <8c8d2d38-faf2-47f2-bfbf-2e4842dded47@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8c8d2d38-faf2-47f2-bfbf-2e4842dded47@gmail.com>

On Thu, Jan 04, 2024 at 10:10:13AM +0100, Rafał Miłecki wrote:
> On 4.01.2024 08:58, Miquel Raynal wrote:
> > robh@kernel.org wrote on Wed, 3 Jan 2024 17:11:29 -0700:
> > > On Thu, Dec 21, 2023 at 06:34:16PM +0100, Rafał Miłecki wrote:
> > > > From: Rafał Miłecki <rafal@milecki.pl>
> > > > 
> > > > U-Boot env data is a way of storing firmware variables. It's a format
> > > > that can be used of top of various storage devices. Its binding should
> > > > be an NVMEM layout instead of a standalone device.
> > > > 
> > > > This patch adds layout binding which allows using it on top of MTD NVMEM
> > > > device as well as any other. At the same time it deprecates the old
> > > > combined binding.
> > > 
> > > I don't understand the issue. From a DT perspective, there isn't. A
> > > partition is not a device, but is describing the layout of storage
> > > already.
> > 
> > Actually I think what Rafał wants to do goes in the right direction but
> > I also understand from a binding perspective it may be a little
> > confusing, even more if we consider "NVMEM" a Linux specific concept.
> > 
> > There is today a "u-boot env" NVMEM *device* description which
> > almost sits at the same level as eg. an eeprom device. We cannot
> > compare "an eeprom device" and "a u-boot environment" of course. But
> > that's truly what is currently described.
> > 
> > * Current situation
> > 
> > 	Flash device -> U-Boot env layout -> NVMEM cells

Isn't it?:

Flash device -> fixed-partitions -> U-Boot env layout -> NVMEM cells

> > 
> > * Improved situation
> > 
> > 	Any storage device -> NVMEM -> U-Boot env layout -> NVMEM cells

Why is this better? We don't need a container to say 'this is NVMEM 
stuff' or 'this is MTD stuff'. 'U-Boot env layout' can tell us 'this is 
NVMEM stuff' or whatever the kernel decides in the future.

> > 
> > The latter is of course the most relevant description as we expect
> > storage devices to expose a storage-agnostic interface (NVMEM in
> > this case) which can then be parsed (by NVMEM layouts) in a storage
> > agnostic way.
> > 
> > In the current case, the current U-Boot env binding tells people to
> > declare the env layout on top of a flash device (only). The current
> > description also expects a partition node which is typical to flash
> > devices. Whereas what we should have described in the first place is a
> > layout that applies on any kind of NVMEM device.
> > 
> > Bonus point: We've been working the last couple years on clarifying
> > bindings, especially with mtd partitions (with the partitions{}
> > container) and NVMEM layouts (with the nvmem-layout{} container).
> > The switch proposed in this patch makes use of the latter, of course.
> 
> Thanks Miquèl for filling bits I missed in commit description. Despite
> years in Linux/DT I still struggle with more complex designs
> documentation.
> 
> 
> As per Rob's comment I think I see his point and a possible design
> confusion. If you look from a pure DT perspective then "partitions" and
> "nvmem-layout" serve a very similar purpose. They describe device's data
> content structure. For fixed structures we have very similar
> "fixed-partitions" and "fixed-cells".
> 
> If we were to design those bindings today I'm wondering if we couldn't
> have s/partitions/layout/ and s/nvmem-layout/layout/.

Why!? It is just a name, and we can't get rid of the old names. We don't 
need 2 names.

> Rob: other than having different bindings for MTD vs. NVMEM layouts I
> think they overall design makes sense. A single device may have content
> structurized on more than 1 level:
> 1. You may have fixed layout at top level (multiple partitions)
> 2. Single partitions may have their own layouts (like U-Boot env data)

Sure. Partitions is for 1 and Layouts is for 2.

> Maybe ideally above should look more like:
> 
> flash@0 {
> 	compatible = "<flash-compatible>";
> 
> 	layout {
> 		compatible = "fixed-layout";

Why does 'partitions' and 'fixed-partitions' not work here?

> 		#address-cells = <1>;
> 		#size-cells = <1>;
> 
> 		partition@0 {
> 			reg = <0x0 0x40000>;
> 			label = "u-boot";
> 		};
> 
> 		partition@40000 {
> 			reg = <0x40000 0x10000>;
> 			label = "u-boot-env";
> 
> 			layout {
> 				compatible = "u-boot,env-layout";
> 			};
> 		};
> 
> 		partition@50000 {
> 			reg = <0x50000 0x100000>;
> 			label = "u-boot";
> 		};
> 	};
> };
> 
> but I can clearly see a use for nested "layout"s. As I said maybe we
> just shouldn't be so open in calling those MTD or NVMEM devices as that
> is kind of Linux specific.

The overall structure should be agnostic to the subsystem. Specific 
compatibles like 'u-boot,env' can be tied to a subsystem.

Maybe some things need to be both MTD and NVMEM. MTD to operate on the 
opague region and NVMEM to access the contents.


> I'm not sure if we should try renaming "nvmem-layout" to "layout" or
> "partitions" in similar way at this point.

You can't rename. It's an ABI though maybe the whole "nvmem-layout" is 
new enough we can. It's looking like it was a mistake to accept any of 
this.

Rob

