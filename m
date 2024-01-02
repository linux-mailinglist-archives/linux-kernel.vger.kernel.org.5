Return-Path: <linux-kernel+bounces-14572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CDF821F06
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 16:53:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C5C01C2234D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 15:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE2E14AB9;
	Tue,  2 Jan 2024 15:53:45 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E4F14A9C
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 15:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <a.fatoum@pengutronix.de>)
	id 1rKh4q-0001xX-4T; Tue, 02 Jan 2024 16:53:12 +0100
Message-ID: <cfb9c01a-7af6-42ff-9056-e64c8c29bfdb@pengutronix.de>
Date: Tue, 2 Jan 2024 16:53:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 2/2] arm64: boot: Support Flat Image Tree
Content-Language: en-US
To: Masahiro Yamada <masahiroy@kernel.org>, Chen-Yu Tsai <wenst@chromium.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Simon Glass <sjg@chromium.org>, linux-arm-kernel@lists.infradead.org,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Nicolas Schier <nicolas@fjasle.eu>, Tom Rini <trini@konsulko.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Jonathan Corbet <corbet@lwn.net>,
 Nathan Chancellor <nathan@kernel.org>, Nick Terrell <terrelln@fb.com>,
 Will Deacon <will@kernel.org>, linux-doc@vger.kernel.org,
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
 workflows@vger.kernel.org
References: <20231202035511.487946-1-sjg@chromium.org>
 <20231202035511.487946-3-sjg@chromium.org>
 <20231203153401.GV8402@pendragon.ideasonboard.com>
 <20231207142723.GA3187877@google.com>
 <20231207143814.GD15521@pendragon.ideasonboard.com>
 <CAGXv+5Go_0pEVAOLQmRCc_a9-YUtZEmBfXtMuBupX_nb9iqwbw@mail.gmail.com>
 <20231209152946.GC13421@pendragon.ideasonboard.com>
 <CAMuHMdVMZs6mnwWBgFwktO=8o=QzROv60cfZe085MhD6HxQjpQ@mail.gmail.com>
 <CAGXv+5Est3FL-XcEL-vB-6zVNas0mqb2cNYa==Yb7W2SQU9xVQ@mail.gmail.com>
 <CAK7LNATyD-PeNbaLTjJmU9=koqqE+V6QvFe09c2VrXopWvjpcw@mail.gmail.com>
 <CAK7LNAR7Fm-1yaZmyH78vG5yNbbW2Avjj5F63u+aST6JQoMd5A@mail.gmail.com>
From: Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <CAK7LNAR7Fm-1yaZmyH78vG5yNbbW2Avjj5F63u+aST6JQoMd5A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hello Yamada-san,

On 14.12.23 08:33, Masahiro Yamada wrote:
>> The FIT spec allows the "fdt" property to list
>> multiple image nodes.
>>
>>
>> o config-1
>>  |- description = "configuration description"
>>  |- kernel = "kernel sub-node unit name"
>>  |- fdt = "fdt sub-node unit-name" [, "fdt overlay sub-node unit-name", ...]
>>  |- loadables = "loadables sub-node unit-name"
>>  |- script = "
>>  |- compatible = "vendor
> 
> 
> 
> 
> 
> This is a question for U-Boot (and barebox).
> 
> 
> 
> 
>    images {
>           base {
>                 ...
>           };
> 
>           addon1 {
>                 ...
>           };
> 
>           addon2 {
>                 ...
>           };
>     };
> 
>     configurations {
>           ...
>           fdt = "base", "addon1", "addon2";
>     };
> 
> 
> 
> 
> Is U-Boot's "bootm" command able to dynamically construct
> the full DTB from "base" + "addon1" + "addon2"
> and pass to the kernel?

barebox can apply overlays to the DT, but doesn't do so yet from
the extra entries in configuration fdt properties.

This should be straight-forward to add though, if the need arises.

> Is U-Boot able to handle FIT (includes kernel + DTs)
> and a separate initrd?
> 
>   # bootm  <fit-address>:<conf-name>  <ramdisk-address>

This is possible in barebox, provided that the FIT image doesn't
already have a ramdisk and that CONFIG_BOOTM_FORCE_SIGNED_IMAGES=n:

  bootm -r /mnt/nfs/ramdisk.gz /mnt/nfs/image.fit

(Or the equivalent variables if not wanting to use the shell.)

> Presumably, it would be difficult to inject initramdisk
> into image.fit later, so I am hoping bootm would work like that,
> but I did not delve into U-Boot code.
> 
> 
> 
> If it works, is it possible to verify the integrity of initrd?
> The kernel and DTs inside FIT will be verified, but not sure
> if it is possible for ramdisk.

If one wants to preclude mix & match attacks, the configuration needs
to be verified fully, so if signing is required, it's probably better to
amend the FIT later on with the new configuration instead of signing
the initrd separately and combining them at runtime.

Cheers,
Ahmad

> 
> 
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |


