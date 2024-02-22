Return-Path: <linux-kernel+bounces-76956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E9185FF06
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:17:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A58C1F2C289
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76AB3157E8F;
	Thu, 22 Feb 2024 17:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tfwno.gf header.i=@tfwno.gf header.b="OsbdC2An"
Received: from mail.cock.li (mail.cock.li [37.120.193.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268EB154BE3;
	Thu, 22 Feb 2024 17:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.120.193.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708622168; cv=none; b=CMltMnE3fVlI3b8Cp0GqyoiSfo4jjPhaVm3nJHGp7nN8Y0r5Yd1+y8Bx5sLvMIKAXhpI7DgWnW0EUukmJa8mPfElIL03FrmgKqMKYUVbWtuc/roCQEuxNNoVfcRLUQW2aQ/6uFWQUse9E6n98WCIpQ5jDgwSMFlm+tfZo1Hu35k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708622168; c=relaxed/simple;
	bh=7EBMd3pVgEsAVmo80nV1cVmtlTC7XkSbAO9djDDzbhM=;
	h=MIME-Version:Content-Type:Date:From:To:Subject:Message-ID; b=XQEyaZpievPJrk2QgB/hl/DL9wIFUxDfMujV0lh+VLWzwp4AdW08nmZySb0TwtnmP2s4ZwSjV48jIM4D2EY+uzW80tDHFiARHIOji4aknXDI+e5AscqYolq3i5jXXyvjJglCNCbi312QHCxJ+Xb46wJoU2lShdDiseRcYjJnvRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tfwno.gf; spf=pass smtp.mailfrom=tfwno.gf; dkim=pass (2048-bit key) header.d=tfwno.gf header.i=@tfwno.gf header.b=OsbdC2An; arc=none smtp.client-ip=37.120.193.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tfwno.gf
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tfwno.gf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tfwno.gf; s=mail;
	t=1708621644; bh=7EBMd3pVgEsAVmo80nV1cVmtlTC7XkSbAO9djDDzbhM=;
	h=Date:From:To:Subject:From;
	b=OsbdC2An85JTOPyX1I5CUzDShB90oIzC1giRiqFW40crgHQWNeKbpjyq/baorPEHp
	 oRmuVLRu946XtmfCLEkA4qhA0vOhaBUfQh3i2vrWmJuaWN+znDOuAnIX+SvclhlbXS
	 usINoHJFF3kzvGVDsN7MnftCmcykOhmTrnddLqG4xcCiAGESrRa27HUQZyWTb4n6n5
	 ENC+6jo7li80PZ2TXOuSJ3XRtiR7HT1Ss5fL1z5IGyImHlUEHndbjXoNAgUOdgyzDK
	 nkwH+OoKj66VIMhzPqK70+5UZxRrcrMqj0Onds3tJb7hwg7ErEXIZj5zRslOSyCGx0
	 IsRtPzlq29j6w==
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Thu, 22 Feb 2024 17:07:23 +0000
From: ns@tfwno.gf
To: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor
 <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>,
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: make install doesn't install proper files for some architectures
User-Agent: Roundcube Webmail/1.4.15
Message-ID: <06e09da69e6c34d03a303c11088d9ffd@tfwno.gf>
X-Sender: ns@tfwno.gf

Greetings,

The kernel's build system has an install target. Most of the time this
works fine, but it is limited to only one file, which can make it busted
for some arches.

One example of a target where it is busted is a generic ppc32 kernel,
where there are plenty of supported platforms, some of which can boot
perfectly fine through Open Firmware & some which are from bad, bad
times o' yore where you had to embed the DT straight into the kernel. &
some more on top of that. When you run make install for ppc32, it only
installs the uncompressed vmlinux. This is almost certainly not the
correct decision for _any_ of the platforms in question, & it totally
leaves out the properly wrapped images that many of these platforms
absolutely need in order to boot (e.g. PS3 & Wii, which need an image
with an embedded DT).

This is not really great. By contrast, the all target built all the
specific images that my config selected. I didn't have to read the
arch's boot Makefile to figure out what files I have to build. Is there
any target which does the same but for installing every image the all
target produced? It'd be a much better experience than leaving the
details of every arch & bizzare platform supported by it up to (most
likely incomplete) scripts, when the Makefiles already have all that
information properly written. I suppose it'd also come in handy if e.g.
x86 had a saner image format [1] in the future or something of the sort.

[1]: 
https://source.denx.de/u-boot/u-boot/-/blob/master/doc/usage/fit/x86-fit-boot.rst

