Return-Path: <linux-kernel+bounces-8595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A747B81B9F3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 15:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8E131C238BC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 14:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E1541A85;
	Thu, 21 Dec 2023 14:56:02 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B56360AD;
	Thu, 21 Dec 2023 14:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpha.franken.de
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1rGKSq-0002PR-00; Thu, 21 Dec 2023 15:55:56 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
	id D7761C0A1E; Thu, 21 Dec 2023 15:55:43 +0100 (CET)
Date: Thu, 21 Dec 2023 15:55:43 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Gregory CLEMENT <gregory.clement@bootlin.com>
Cc: Paul Burton <paulburton@kernel.org>, linux-mips@vger.kernel.org,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	=?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v5 00/22] Add support for the Mobileye EyeQ5 SoC
Message-ID: <ZYRR7zIZax7yUgsZ@alpha.franken.de>
References: <20231212163459.1923041-1-gregory.clement@bootlin.com>
 <878r5vctdg.fsf@BL-laptop>
 <ZYNhbQjMbAH6I0kI@alpha.franken.de>
 <87frzwasxo.fsf@BL-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87frzwasxo.fsf@BL-laptop>

On Thu, Dec 21, 2023 at 08:57:55AM +0100, Gregory CLEMENT wrote:
> I do not oppose the addition of a new platform, even though, like
> Jiaxun, I would prefer to avoid duplicating code. The only thing
> preventing the use of the same kernel for EyeQ5 and other platforms is
> the starting address.

there shouldn't be code duplication.

My rough idea would be something like

diff --git a/arch/mips/Kbuild b/arch/mips/Kbuild
index af2967bffb73..d683993ed331 100644
--- a/arch/mips/Kbuild
+++ b/arch/mips/Kbuild
@@ -17,6 +17,7 @@ obj- := $(platform-y)
 # mips object files
 # The object files are linked as core-y files would be linked
 
+obj-y += generic/
 obj-y += kernel/
 obj-y += mm/
 obj-y += net/
diff --git a/arch/mips/generic/Makefile b/arch/mips/generic/Makefile
index e37a59bae0a6..56011d738441 100644
--- a/arch/mips/generic/Makefile
+++ b/arch/mips/generic/Makefile
@@ -4,9 +4,9 @@
 # Author: Paul Burton <paul.burton@mips.com>
 #
 
-obj-y += init.o
-obj-y += irq.o
-obj-y += proc.o
+obj-$(CONFIG_MACH_GENERIC_CORE) += init.o
+obj-$(CONFIG_MACH_GENERIC_CORE) += irq.o
+obj-$(CONFIG_MACH_GENERIC_CORE) += proc.o
 
 obj-$(CONFIG_YAMON_DT_SHIM)            += yamon-dt.o
 obj-$(CONFIG_LEGACY_BOARD_SEAD3)       += board-sead3.o

so everyboady needing these parts of a generic kernel is able
to take it.

> Therefore, if it were possible to have a relocatable kernel, this
> issue would disappear.

yes. There is support for relocatable kernel, so what are we missing
there ?

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]

