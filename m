Return-Path: <linux-kernel+bounces-45491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C9A84316A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 00:39:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB9121C222DF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 23:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28FF679DB0;
	Tue, 30 Jan 2024 23:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="clQj8Yvd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6403979947;
	Tue, 30 Jan 2024 23:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706657955; cv=none; b=dZNGXLkWfaQ3qG2Yl0bsyT/fMJ8LsvN7TuGT8SDfsKWNhwd8a8VPkwlGPGjIlxwWopCoH1vRiD6SSd1PsbFTpw8rs6y/k7wCH1qXo9v5tx2po7/SHj8ssP1PQyTTNuVDKLU25qfJg/DtX2e1YxG6Jr2YacJYYGQYkAz0QXO32RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706657955; c=relaxed/simple;
	bh=SWhI9SxUKhbmDM6VC3Ww/o/zAc3CMboKSmdOI2DEQUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f70n+JmX/jMICuGZowJHDWlnjNdtFKmMdwkoJnoXDnpoaR+dPv/6q7F5qQS5WybwTz0outGEIYAjNe19qIh9f6Wm22cuytMVD3svgg6SF1Bt4RynPWNXE+rIa0RDw4x3UsiBFqhHCu8UiOhxrAXQsB5hlpPnY+3xNEargLtpGJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=clQj8Yvd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA8BAC433F1;
	Tue, 30 Jan 2024 23:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706657954;
	bh=SWhI9SxUKhbmDM6VC3Ww/o/zAc3CMboKSmdOI2DEQUQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=clQj8YvdIRqfCZ71/YLjXkrbQeN1jJ6hp51k9LHxlbTRd0euaSHP4YVjz+GWbmr49
	 4VCVabrAjew0rJS11xyeUvCMENFvk2FtYAMKbM+jA6I4XQQXddgwLksUeGfHT5+iPQ
	 CepZ8/u1RO367Ydon9G8AcpGK+hEBtcq5ViW4WdQ=
Date: Tue, 30 Jan 2024 15:39:13 -0800
From: "'gregkh@linuxfoundation.org'" <gregkh@linuxfoundation.org>
To: "Corona, Ernesto" <ernesto.corona@intel.com>
Cc: "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
	"'oleksandrs@mellanox.com'" <oleksandrs@mellanox.com>,
	"Castro, Omar Eduardo" <omar.eduardo.castro@intel.com>,
	"'omar.eduardo.castro@linux.intel.com'" <omar.eduardo.castro@linux.intel.com>,
	"'pombredanne@nexb.com'" <pombredanne@nexb.com>,
	"'corbet@lwn.net'" <corbet@lwn.net>,
	"'gustavo.pimentel@synopsys.com'" <gustavo.pimentel@synopsys.com>,
	"'lorenzo.pieralisi@arm.com'" <lorenzo.pieralisi@arm.com>,
	"'kishon@ti.com'" <kishon@ti.com>,
	"'darrick.wong@oracle.com'" <darrick.wong@oracle.com>,
	"'bryantly@linux.vnet.ibm.com'" <bryantly@linux.vnet.ibm.com>,
	"'sandeen@redhat.com'" <sandeen@redhat.com>,
	"'rdunlap@infradead.org'" <rdunlap@infradead.org>,
	"'kusumi.tomohiro@gmail.com'" <kusumi.tomohiro@gmail.com>,
	"'arnd@arndb.de'" <arnd@arndb.de>,
	"'mchehab+samsung@kernel.org'" <mchehab+samsung@kernel.org>,
	"'alexandre.belloni@bootlin.com'" <alexandre.belloni@bootlin.com>,
	"'tytso@mit.edu'" <tytso@mit.edu>,
	"'ebiggers@google.com'" <ebiggers@google.com>,
	"Filary, Steven A" <steven.a.filary@intel.com>,
	"'jiri@nvidia.com'" <jiri@nvidia.com>,
	"'vadimp@mellanox.com'" <vadimp@mellanox.com>,
	"'amithash@fb.com'" <amithash@fb.com>,
	"'patrickw3@fb.com'" <patrickw3@fb.com>,
	"Chen, Luke" <luke_chen@aspeedtech.com>,
	"'billy_tsai@aspeedtech.com'" <billy_tsai@aspeedtech.com>,
	"'rgrs@protonmail.com'" <rgrs@protonmail.com>
Subject: Re: [PATCH 30 5/7] Add JTAG core driver ioctl number
Message-ID: <2024013024-starship-referee-7ab3@gregkh>
References: <LV8PR11MB84634960758E20E781DB638F8B7D2@LV8PR11MB8463.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <LV8PR11MB84634960758E20E781DB638F8B7D2@LV8PR11MB8463.namprd11.prod.outlook.com>

On Tue, Jan 30, 2024 at 11:32:14PM +0000, Corona, Ernesto wrote:
> JTAG class driver provide infrastructure to support hardware/software JTAG platform drivers. It provide user layer API interface for flashing and debugging external devices which equipped with JTAG interface using standard transactions.

Please properly wrap your changelog text, didn't checkpatch warn of
this?

> Driver exposes set of IOCTL to user space for:
> - XFER:
>   SIR (Scan Instruction Register, IEEE 1149.1 Data Register scan);
>   SDR (Scan Data Register, IEEE 1149.1 Instruction Register scan);
> - GIOCSTATUS read the current TAPC state of the JTAG controller
> - SIOCSTATE Forces the JTAG TAPC to go into a particular state.
> - SIOCFREQ/GIOCFREQ for setting and reading JTAG frequency.
> - IOCBITBANG for low level control of JTAG signals.

Where are these ioctls implemented?  THat has nothing to do with this
patch itself, right?

And what's the "30" in the patch number above for?

confused,

greg k-h

