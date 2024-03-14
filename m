Return-Path: <linux-kernel+bounces-103081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D97687BACC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 10:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE01B1C2181D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 09:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18E76D1BF;
	Thu, 14 Mar 2024 09:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U2l7w9Kw"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FBC6CDC1;
	Thu, 14 Mar 2024 09:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710410261; cv=none; b=fw206vPPwJxxnWUfiBaPtJtm8REVV6Gj66ZjOoiqOh99OQuUQBez//GC7/enyeVpplZfpF3dx+ux3TvWKQJmW3/68MhygZyp2V4GWL/3cAycZy2ZGUqYFZ2FHOBvSVy/AQZk1nV3p0vwuqnuNQIycZzla48By5PslhY48L9bQac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710410261; c=relaxed/simple;
	bh=VqCz2igfg2nWsES9iIOGmzpT62E7/xaNIwB8TKcfzcA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iFK/jhOR8540tZd5UPQSyPZYPwCbZ4PYRsgwF/Gem8H/Gc4cGWi0ggIcNZNw5gOOdXpOotoyBMOPVXOMaksmYbJDacBFpXm+Lm0z6L4HOQB4FTlhjWAhQozHa+zvebBZ/PZx/UCYSgPQi/a2ei4g7f04UEZRIl/vMHFH5u72Xlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U2l7w9Kw; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5689b7e8387so890819a12.2;
        Thu, 14 Mar 2024 02:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710410258; x=1711015058; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9EQJP9snJ+QMn1kOIEI1bHrE4YWtBgcqYZRBKU0i0oU=;
        b=U2l7w9Kwra7BMqOMQLyLhg88vX+CAXPuNqebUMcb+BjoSC9aeTCb1w7bBtlAIe+9M6
         UKtEUzpHlMWOdm/35uTglltyMV5lVVztsDbjUIYA8cN5mkTe2RJr99ccibbUHnqEwsum
         rekdDovVU6KeVD+9HYMaiwDQqrjttmsU9Y/1TInPvlbG0EiLVZ5zNEIVh2RNgnTuzmrM
         1iILSbbzW9in13GwqDD8H1USpU8NvCC27w+HZlgcAufz7NWe2lysasyhUMTAuHg8Izel
         /7U2oatGzcZ/4ayHENDj0s4KYlxrF28B285CGVCFviVr5o9cPUuKIu4Mg92TG22j0Vh8
         URgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710410258; x=1711015058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9EQJP9snJ+QMn1kOIEI1bHrE4YWtBgcqYZRBKU0i0oU=;
        b=Ba4c2PTusd+KufUZs6ISx1PeaumfukkoVyMbFOaN4TjcAgRFa7MxYvfJHWngra4KQW
         B0sTTZXHTPKgR057NzZRlxaA94pdNIS8rbRCYlQZq8z7Cy9dlFttjb2XCUjfvDc6x58W
         Hxc8FBOmBCF9wEC30onJCF+HR63CzfwHH4NWsPSLCsD3IfqxYI5cjNpViYGp55dq4/Sm
         XI9tipqBWy3qRG0bX9f64JMMIjc3Vt7iOzDdvoQ/jbvBrUvofla/sGdFJWb1CkOY6yDf
         2skL40+2L5ghiTp1MXi0G/aLWN+aHgv74jqnIceQ2/EOkZoDCSPtzzckUjfTec4TU3kP
         bINg==
X-Forwarded-Encrypted: i=1; AJvYcCWOVNhPO5p9R8+fZ9c7HPrwQv5oLBwN54yRFqkKVckCEViULkNZ4Ct8ALBgwu3W1oOyZln293JGkJu0/Oj6S6A/RWcFa3sKJV2TI2u3njFyp/rGuujqzYRxOxeQdV2ST5pd2lfPqoHxEwU=
X-Gm-Message-State: AOJu0Yx0DQEhRJDtLiiDFqAT/oRoBUSFkAjAR75lLR/rFEPH7+VeauJI
	mYvFv6VOu7yVMVVjKaTT6Bcm2aK1yfbngymhDl5flDf9jOXlO/AnENlGbelGH/weWDrNBbpDQA3
	H2z9oGbanRG+e4osIeiiIIuFK4So=
X-Google-Smtp-Source: AGHT+IGyab5KBsAesnH1jxLgGY6boYF6TUj24EvyN1esyvAau51ilcVLio7p/CiieVnoKJ3jmExMyWomKfwPWIYn3oI=
X-Received: by 2002:a17:906:ecfc:b0:a46:6557:716f with SMTP id
 qt28-20020a170906ecfc00b00a466557716fmr143159ejb.20.1710410257421; Thu, 14
 Mar 2024 02:57:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240313070705.91140-3-umang.jain@ideasonboard.com> <202403141436.KEQj1YzE-lkp@intel.com>
In-Reply-To: <202403141436.KEQj1YzE-lkp@intel.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 14 Mar 2024 11:57:00 +0200
Message-ID: <CAHp75Vdo4Q-1j7XYB92i5=LNwuB7fpV3jPgE98K1Z_QHP5Zxng@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] media: i2c: Add imx283 camera sensor driver
To: kernel test robot <lkp@intel.com>
Cc: Umang Jain <umang.jain@ideasonboard.com>, linux-media@vger.kernel.org, 
	oe-kbuild-all@lists.linux.dev, 
	Kieran Bingham <kieran.bingham@ideasonboard.com>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, willl will <will@willwhang.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, tomi.valkeinen@ideasonboard.com, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Hans Verkuil <hverkuil@xs4all.nl>, 
	Hans de Goede <hdegoede@redhat.com>, Alain Volmat <alain.volmat@foss.st.com>, 
	Paul Elder <paul.elder@ideasonboard.com>, Mehdi Djait <mehdi.djait@bootlin.com>, 
	Bingbu Cao <bingbu.cao@intel.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14, 2024 at 8:57=E2=80=AFAM kernel test robot <lkp@intel.com> w=
rote:
>
> Hi Umang,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on media-tree/master]
> [also build test ERROR on linuxtv-media-stage/master]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Umang-Jain/media-d=
t-bindings-media-Add-bindings-for-IMX283/20240313-151107
> base:   git://linuxtv.org/media_tree.git master
> patch link:    https://lore.kernel.org/r/20240313070705.91140-3-umang.jai=
n%40ideasonboard.com
> patch subject: [PATCH v3 2/2] media: i2c: Add imx283 camera sensor driver
> config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/202403=
14/202403141436.KEQj1YzE-lkp@intel.com/config)
> compiler: m68k-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20240314/202403141436.KEQj1YzE-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202403141436.KEQj1YzE-lkp=
@intel.com/
>
> All errors (new ones prefixed by >>, old ones prefixed by <<):

..

> >> ERROR: modpost: "__udivdi3" [drivers/media/i2c/imx283.ko] undefined!

I believe I have commented on a suspicious line (during v1 or v2
review round). Seems nobody reacted :-)

--=20
With Best Regards,
Andy Shevchenko

