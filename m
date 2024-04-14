Return-Path: <linux-kernel+bounces-144242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF648A4388
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 17:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C98D1C20F39
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 15:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D6F134CC0;
	Sun, 14 Apr 2024 15:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="g2+L3tmi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mZtT4NSh"
Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEA01EB2B
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 15:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713109640; cv=none; b=q29XmYV0Rk9k3YXoWq43b/tXc19R8YQSZ6tliSxG0qDmTGQVRlxqlVU/qwRrAVrp0dfOidkyjRxLOsC8smuGA4FlKk+dOYl7e9XV/IyEGT9px1MYD/vzfO0jP1U3hHZoBhMMSEBjWVZOIyvqaNH2xRj8TeLOg3bv8EcNsVmg9x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713109640; c=relaxed/simple;
	bh=U1C8+1q10yNUNvXO04ZOHEydz3Duojkc1CTYoiCMBQ4=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=OyUF93XFLKZk9ITDQg/88HrmS/b5egmRoR0h1XftNUYUu/ADcjYmj2xRdZu+ZyHDWNb9D0DWdd1G4gOld9b4j0ovzFhLAL8qqZDQ0eOeaKcpzDoYSaZPyMQzLt3B72vFNL/ffvj1f+XHY4hsO5Qz++IXCPoejl8suexkeZ8kY/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=g2+L3tmi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mZtT4NSh; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 535BC1140131;
	Sun, 14 Apr 2024 11:47:16 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Sun, 14 Apr 2024 11:47:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1713109636; x=1713196036; bh=ZsnKy0Hy5/
	oyigT7+5D/hAVNjkgtAKOSPhlZCbe/7So=; b=g2+L3tmiLucjuXmA3+slRiIw0q
	pMvyPaGpNYJ7Il2/MHPeiuv2qOkmWQklrz5DbuunNpxO+tYd0D1TwBL0aX6i08d9
	isCdWnt0ubhF3jHLqQhw69LGzIneJt/zyYlZ+C8rxRYMrgkIHGl0IG0AgpBubXdT
	cCEtC+y+vBy4A+4vxI0o6oG5okwI3hwyFG5MSiavyuF2ZzW/JPaD1PAopOnMG9xa
	it4zT9b/3Nm+mPg9k6A/mYGhkHSi3gzIZVjBRDzjjBuf9a61ReXRL/waVD5w9nEx
	pwC0K17DOhxRatEV0FEutIiCfp6enljf5nL+z7CYkBpDg94ndxF6r5vXvLKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1713109636; x=1713196036; bh=ZsnKy0Hy5/oyigT7+5D/hAVNjkgt
	AKOSPhlZCbe/7So=; b=mZtT4NSh6wsFW1qR43gqHJdRRKgLhGAO8WZWZclnfKOU
	dZ6nBNC53yt3+G/TUvx/ckDwp8jeU+l22baidzy+cdjIvZcd8C+fJsc8xYXh7tWt
	zQu0Zoq15xX6RzjcE4iu8gqPCj9R+SUjEn3a5XwsrazdC/75W05AQGpd1SIbevHs
	5lC0oxgUICxjTd0ZCr+8yl8OZtAxHliabhyXRqmc8mUhr2Mzu4TFlKRmxN0TwPr2
	fF8OjL7/56VdhuSLTJKGtSuOZgOPTRnd7AYQ8Iy6BE1xMYiRbYI9tDOxVvOoYEaQ
	uR6HsghR5dlbOGTWemxAUR6YEnX8co/Co8bbAZ3X8g==
X-ME-Sender: <xms:g_obZkS-sDw7LJoz0c690X9hfdDjxIscFZPCZHvqr30LHbxbWKj5-A>
    <xme:g_obZhw32EjqAflVRkieA5zsjf8gNn45salhAWaoXYNrP-94mJkEWV3m0fE_eBd_B
    3-CUcz3aXNiPtCbr0Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeiledgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfgjfhffhffvvefutgesth
    dtredtreertdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnuges
    rghrnhgusgdruggvqeenucggtffrrghtthgvrhhnpeevhefhffdvfeejtdeufeevteekue
    elhfeuleejfffhvdfhhfevvdffkedtledvleenucffohhmrghinhepkhgvrhhnvghlrdho
    rhhgpddtuddrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:g_obZh33wlJEK7yPEXr0Cj27zD0GtmLjlu5C-FOhTx6p-_UhMiLO0w>
    <xmx:g_obZoCxpqCtMZAAOwdsSgxH8bm_8gxq2cW8khl_jIZ2rqCi4jfuUA>
    <xmx:g_obZthXtgibrPE4llboM7fWGD1voLd-8cXygbJxi8L0p-zfaBxUpA>
    <xmx:g_obZkoTllQ8U-q9IGGx9d159ODhpAKyb3zoR43i19QsMiIHFTWY5g>
    <xmx:hPobZivYrcIoaLNvcJgbo5_3tIdEi-Km3xuDC-4nyJs_2SEWJ58Mb7LO>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id C5F99B6008D; Sun, 14 Apr 2024 11:47:15 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-379-gabd37849b7-fm-20240408.001-gabd37849
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ae1e6ebe-be09-46fb-a2aa-4db0eb53f160@app.fastmail.com>
In-Reply-To: <202404142258.3CWV3f05-lkp@intel.com>
References: <202404142258.3CWV3f05-lkp@intel.com>
Date: Sun, 14 Apr 2024 17:46:54 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "kernel test robot" <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
 "Thomas Gleixner" <tglx@linutronix.de>
Subject: Re: arch/alpha/include/asm/page.h:9:25: error: 'CONFIG_PAGE_SHIFT' undeclared;
 did you mean 'CONFIG_HAVE_PCI'?
Content-Type: text/plain

On Sun, Apr 14, 2024, at 16:52, kernel test robot wrote:
> tree:   
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 
> master
> head:   7efd0a74039fb6b584be2cb91c1d0ef0bd796ee1
> commit: 5394f1e9b687bcf26595cabf83483e568676128d arch: define 
> CONFIG_PAGE_SIZE_*KB on all architectures
> date:   6 weeks ago
> config: alpha-randconfig-r016-20220816 
> (https://download.01.org/0day-ci/archive/20240414/202404142258.3CWV3f05-lkp@intel.com/config)
> compiler: alpha-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): 
> (https://download.01.org/0day-ci/archive/20240414/202404142258.3CWV3f05-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new 
> version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: 
> https://lore.kernel.org/oe-kbuild-all/202404142258.3CWV3f05-lkp@intel.com/
>
> All errors (new ones prefixed by >>):
>
>    In file included from include/linux/thread_info.h:60,
>                     from include/asm-generic/current.h:6,
>                     from ./arch/alpha/include/generated/asm/current.h:1,
>                     from include/linux/sched.h:12,
>                     from arch/alpha/kernel/asm-offsets.c:10:
>    arch/alpha/include/asm/thread_info.h:43: warning: 
> "current_thread_info" redefined
>       43 | #define current_thread_info()  __current_thread_info
>          | 
>    include/linux/thread_info.h:24: note: this is the location of the 
> previous definition
>       24 | #define current_thread_info() ((struct thread_info *)current)
>          | 
>    In file included from include/linux/shm.h:6,
>                     from include/linux/sched.h:23:
>    include/asm-generic/getorder.h: In function 'get_order':
>>> arch/alpha/include/asm/page.h:9:25: error: 'CONFIG_PAGE_SHIFT' undeclared (first use in this function); did you mean 'CONFIG_HAVE_PCI'?
>        9 | #define PAGE_SHIFT      CONFIG_PAGE_SHIFT
>          |                         ^~~~~~~~~~~~~~~~~

I tried reproducing this, but it always works for me here,
using my own gcc-13.2 build. I tried both the latest linux-next
and the 5394f1e9b commit.

    Arnd

