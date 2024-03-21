Return-Path: <linux-kernel+bounces-110635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19BC088618C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 21:20:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C484A1F22D66
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 20:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277FF134CEC;
	Thu, 21 Mar 2024 20:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="b+iOeAwy"
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B9713442F;
	Thu, 21 Mar 2024 20:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711052428; cv=none; b=A0d2H9eMhfAb8eUHXEf7v0Z3aTndG+3QFrbF6QloFL63K6C6ctgzDO0VDxRHD+XjMTt730PBBLo8Qxcrb3hmRAJT7k8b9L3BVviMQ/vHPX9qFOKviRdLmxHt56GuTnTbHMhcljsJZUxHQ1ggsEMLWLfY18ujOny0+Y/VGd0SgpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711052428; c=relaxed/simple;
	bh=eFrHAh7BJNnqflbNawWUWzv1wOsF6n2g6fArJ0mZMlY=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=HBuwUnTrq3NSZ94qAPalJo5/CNSkP/oI/pKXuO/RYwWMz9qZJ+4xcaj/FjiEFWbcyun92kpixYHkX1raOVTB0G/7Ve3ieg/ArHWQZfTRT+aHMw0oPfyLjjuhI9o8wlPvZhedkJqbrI/h2gS/s8Ag9lil8LRxXMyFuqtU+Cg0cRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=b+iOeAwy; arc=none smtp.client-ip=192.134.164.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=content-transfer-encoding:from:mime-version:subject:date:
   message-id:references:cc:in-reply-to:to;
  bh=eFrHAh7BJNnqflbNawWUWzv1wOsF6n2g6fArJ0mZMlY=;
  b=b+iOeAwyum6sXPaLJdb+fWcvioaIay6A5QdvQAH59gWJUsmGC9jNdIvf
   /ahM63HH30yJBWqhsW2vS2WPc5h/9lkl9FlcxgEizgMNTAwfqQZw4FHWI
   d57CFM4Nc+XCYjiqBF+Y6RbCzR99H+QXO1yy2H4bghO54mhDp3Cik0xCj
   0=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.07,143,1708383600"; 
   d="scan'208";a="82803127"
Received: from 184-074-243-067.biz.spectrum.com (HELO smtpclient.apple) ([184.74.243.67])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 21:20:12 +0100
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Julia Lawall <Julia.Lawall@inria.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH net] ice: Fix freeing uninitialized pointers
Date: Thu, 21 Mar 2024 16:20:09 -0400
Message-Id: <F2FBADE8-EDF9-4987-A97B-CF4D2D1452E0@inria.fr>
References: <e5172afb-427b-423e-877a-10352cf4a007@web.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Dan Carpenter <dan.carpenter@linaro.org>, kernel-janitors@vger.kernel.org,
 netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 LKML <linux-kernel@vger.kernel.org>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 David Laight <David.Laight@aculab.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Jonathan Cameron <jic23@kernel.org>,
 Kees Cook <keescook@chromium.org>,
 Lukasz Czapnik <lukasz.czapnik@intel.com>, Paolo Abeni <pabeni@redhat.com>,
 Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
In-Reply-To: <e5172afb-427b-423e-877a-10352cf4a007@web.de>
To: Markus Elfring <Markus.Elfring@web.de>
X-Mailer: iPhone Mail (19H384)

Does one prefer an initialization of null at the top of the function or an i=
nitialization to a meaningful value in the middle of the function ?

(Sorry for top posting)


Sent from my iPhone

> On 21 Mar 2024, at 14:14, Markus Elfring <Markus.Elfring@web.de> wrote:
>=20
> =EF=BB=BF
>>=20
>>> How do you think about to reduce the scope for the affected local variab=
le instead
>>> with the help of a small script (like the following) for the semantic pa=
tch language?
>>>=20
>>> @movement@
>>> attribute name __free;
>>> @@
>>> -u8 *tx_frame __free(kfree);
>>> int i;
>>> ... when any
>>> if (ice_fltr_add_mac(test_vsi, ...))
>>> { ... }
>>> +
>>> +{
>>> +u8 *tx_frame __free(kfree) =3D NULL;
>>> if (ice_lbtest_create_frame(pf, &tx_frame, ...))
>>> { ... }
>>> ... when any
>>> +}
>>> +
>>> valid_frames =3D ice_lbtest_receive_frames(...);
>>=20
>> I believe you don't understand what the scope of the above can be.
>=20
> Will the understanding improve for the proposed source code transformation=
?
>=20
> Regards,
> Markus


