Return-Path: <linux-kernel+bounces-8645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA4681BA94
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 16:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5289EB25D91
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 15:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B0E5103A;
	Thu, 21 Dec 2023 15:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="svt2mg6S"
X-Original-To: linux-kernel@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0267B539E6;
	Thu, 21 Dec 2023 15:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from mail.denx.de (unknown [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: festevam@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id D334A86FF7;
	Thu, 21 Dec 2023 16:23:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1703172212;
	bh=QJ7p7Bf1SpIwh6wh64K5dmUR5iPUQamZcwq0EDP2pGg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=svt2mg6Ss5mVi+p/cR9EZ4Np2p5Zo+n5x3+3Ea0A84sV2Rrmmozs8Eh3ghG/OQEWh
	 esvN8EC4ltWPpKd/WctfqhuX0rdX7qklbj1fsEnLfOH8FnlP7YT7zClIz9JM/6/Xwm
	 6mTKg3Of9lZgiw88ghLsBdIMGaWASPGw0zYdz8LjttVKOMzoixgyIdCwt48S3SAuNX
	 Npa42vLHuQmgG+4B5rlh7PLj9RU9PJl94N5kfHzUwoX2j2XHEl9JnT4+XXQo5rm6Rv
	 VdDL11SF2ua8jfAkqI4iTBPOmZBo8vUQEwAgld0Iar204Zb264Lmn8XF9iXAnr1M1b
	 +SayZDrjmetQg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date: Thu, 21 Dec 2023 12:23:32 -0300
From: Fabio Estevam <festevam@denx.de>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui
 <rui.zhang@intel.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the thermal tree
In-Reply-To: <20231221121745.2771ab8a@canb.auug.org.au>
References: <20231219103457.4e034e9a@canb.auug.org.au>
 <68012fb93e0057f62c03a5d9b01237c4@denx.de>
 <c2a170ea-39e8-49bf-9aeb-60eb20a22454@linaro.org>
 <20231221121745.2771ab8a@canb.auug.org.au>
Message-ID: <182f7809380d0db9aea3a56253dfdd63@denx.de>
X-Sender: festevam@denx.de
User-Agent: Roundcube Webmail/1.3.6
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi Stephen,

On 20/12/2023 22:17, Stephen Rothwell wrote:

>> > diff --git a/kernel/reboot.c b/kernel/reboot.c
>> > index 07eb6537ed8b..f814568525f1 100644
>> > --- a/kernel/reboot.c
>> > +++ b/kernel/reboot.c
>> > @@ -1002,6 +1002,7 @@ void __hw_protection_shutdown(const char *reason, > int ms_until_forced, bool shut
>> >          if (shutdown)
>> >                  orderly_poweroff(true);
>> >   }
>> > +EXPORT_SYMBOL_GPL(__hw_protection_shutdown);
>> 
>> Yeah, I've done it
> 
> Forgot to push out?

The 'bleeding-edge' branch contains the fix now:

https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?h=bleeding-edge&id=f21b0d185f75e15561047312dd4b8306eac8ad71

