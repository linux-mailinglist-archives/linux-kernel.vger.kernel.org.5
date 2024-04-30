Return-Path: <linux-kernel+bounces-163888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C5F8B7558
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 082521F21394
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 12:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C9E13D8A4;
	Tue, 30 Apr 2024 12:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="Nq/aijsV"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550C613CFA0
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 12:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714478644; cv=none; b=ddDabKdCqmY4BUgV1flK80RGaoHWMFe653r+aukqdaQK2lR4RFiCEwN6x//hprRATlZ/K3sZdKXIboSPLDjA8UXfmtO3msU5EjDlLfNrq695JRmmzF9o/hvluYIrqhH6yBsuUtSSPxL3+yWZ3BvfODuG3UfW3NubPlx4cwvI+1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714478644; c=relaxed/simple;
	bh=roFKNV9068c4FWvmmLYomBY2V974jx//R1VbbE7RHEQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Sunrw+TOa19zi3m78agLBAH/ljsw7F1bshaCLYGjLoZCrHFU/sODM7UdUQWLjvEYEH4jLXyWM0ltxa0bIX1AO10A4XYMP5KozlP7sIMaNRgr/Q4hgJo92d8g7MLmwr//Xiw0LaQoYNujLQwPn1vBz/hHlDARtUICjGfphsvQGGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=Nq/aijsV; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-572a092dd2dso470999a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 05:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1714478640; x=1715083440; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=roFKNV9068c4FWvmmLYomBY2V974jx//R1VbbE7RHEQ=;
        b=Nq/aijsVflufUR/fb+CglXvuOngNJKtzyCPtx2uXFNTQNQ5MT2XnhS2xTdgkK9J0yR
         97zpS3wRjN+YvAMuXKAR8ZrqL1xpfCiA2B19EnI1bTH33NNruCXJkmAaKqZsFosz9ecI
         piW2flTAHqCYCccis+ztO6ow+VZ+jSt7LBAPzStYl+21vdvG+CbY2d0rxvzYRazWHlBG
         iz4EA+PLOOYYVYzlpwrJDwsAjXa9HQeBw2Jx0sLpEPPvInIz2Hy+9zh35tmps9v9Vf+w
         FZq4Y+iKZGc3IqFyOSHh/25EYNRLGijytXvlRzSk37F4j3+xLIQvFmkhxexiaIRUwyjZ
         eVrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714478640; x=1715083440;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=roFKNV9068c4FWvmmLYomBY2V974jx//R1VbbE7RHEQ=;
        b=IeNKVH2tN7r1M0LUhLreThe+bajOL3/4k4cvwjRLJZkenOBs9RnOnWUEKFWxUraYvx
         1FrPrJMmz3NkuyQGrRVy5sOYiYXsZEfeX2HjRRaBeAiUvEcCdCfasBOMvNZbvmqNaUIL
         21h6v9oT2uqO5WNfjIhos5EYcaAO6NCoeRaT4bj4OEofCceUBPMyqXHDfwmYjoe7LFFR
         OYMl+iGEVj8eH0q0lK5qC9O8/9QbzXAC8QH05tJgyJSiSqi6R6q2NKwJqnNXNQVL19s8
         rYRAuUFKsbBMgxTWcTgVTRrSAqh44aFwX4S3cTat2947ctxQqFcRJHVz1hcD6qeBnhcm
         z88g==
X-Forwarded-Encrypted: i=1; AJvYcCVrKXeCnF/dxRN+H15+Z466FggCqDbtTLxOMwoT2c8Z3fv4GW7+H27rMJvTfHKWwC8dvFOdz75C9XBX3as2greHI62hjmvvjyff3cOl
X-Gm-Message-State: AOJu0YwCIKGNHfkw6M2EqtRLuDeQ//n0W32xQYj4NoD5UK5z331IdRv6
	Rl4QknvBT0Rfr1ZN97+kXZoiURMhQKO/WJOTUE2kDwT1U9aqkdYpUgPCw34zTYk=
X-Google-Smtp-Source: AGHT+IFOJa95c5L3PLcuPC8+myscInn7v7yIygmTBp6T6UQW/vkzzT0D2o5eQO+OLj8DOz8EVMoqXQ==
X-Received: by 2002:a50:bb0d:0:b0:572:5bc3:3871 with SMTP id y13-20020a50bb0d000000b005725bc33871mr1684440ede.10.1714478640578;
        Tue, 30 Apr 2024 05:04:00 -0700 (PDT)
Received: from smtpclient.apple (clnet-p106-198.ikbnet.co.at. [83.175.106.198])
        by smtp.gmail.com with ESMTPSA id j17-20020aa7c0d1000000b005729c4c2501sm433685edp.24.2024.04.30.05.03.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2024 05:04:00 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: [EXT] [PATCH v8 6/6] docs: trusted-encrypted: add DCP as new
 trust source
From: David Gstir <david@sigma-star.at>
In-Reply-To: <DB6PR04MB319062F2A19A250BA22C12D48F1A2@DB6PR04MB3190.eurprd04.prod.outlook.com>
Date: Tue, 30 Apr 2024 14:03:48 +0200
Cc: Mimi Zohar <zohar@linux.ibm.com>,
 James Bottomley <jejb@linux.ibm.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>,
 Kshitiz Varshney <kshitiz.varshney@nxp.com>,
 Shawn Guo <shawnguo@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 dl-linux-imx <linux-imx@nxp.com>,
 Ahmad Fatoum <a.fatoum@pengutronix.de>,
 sigma star Kernel Team <upstream+dcp@sigma-star.at>,
 David Howells <dhowells@redhat.com>,
 Li Yang <leoyang.li@nxp.com>,
 Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Tejun Heo <tj@kernel.org>,
 "Steven Rostedt (Google)" <rostedt@goodmis.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
 "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
 "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>,
 Richard Weinberger <richard@nod.at>,
 David Oberhollenzer <david.oberhollenzer@sigma-star.at>,
 Varun Sethi <V.Sethi@nxp.com>,
 Gaurav Jain <gaurav.jain@nxp.com>,
 Pankaj Gupta <pankaj.gupta@nxp.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <DB9357A7-0B20-4E57-AF66-3DD0F55ED538@sigma-star.at>
References: <20240403072131.54935-1-david@sigma-star.at>
 <20240403072131.54935-7-david@sigma-star.at>
 <D0ALT2QCUIYB.8NFTE7Z18JKN@kernel.org>
 <DB6PR04MB3190F6B78FF3760EBCC14E758F072@DB6PR04MB3190.eurprd04.prod.outlook.com>
 <7783BAE9-87DA-4DD5-ADFA-15A9B55EEF39@sigma-star.at>
 <DB6PR04MB319062F2A19A250BA22C12D48F1A2@DB6PR04MB3190.eurprd04.prod.outlook.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
X-Mailer: Apple Mail (2.3774.500.171.1.1)

Hi Jarkko,

> On 30.04.2024, at 13:48, Kshitiz Varshney <kshitiz.varshney@nxp.com> =
wrote:
>=20
> Hi David,
>=20
>> -----Original Message-----
>> From: David Gstir <david@sigma-star.at>
>> Sent: Monday, April 29, 2024 5:05 PM
>> To: Kshitiz Varshney <kshitiz.varshney@nxp.com>


>>=20
>> Did you get around to testing this?
>> I=E2=80=99d greatly appreciate a Tested-by for this. :-)
>>=20
>> Thanks!
>> BR, David
>=20
> Currently, I am bit busy with other priority activities. It will take =
time to test this patch set.

How should we proceed here?
Do we have to miss another release cycle, because of a Tested-by?

If any bugs pop up I=E2=80=99ll happily fix them, but at the moment it =
appears to be more of a formality.
IMHO the patch set itself is rather small and has been thoroughly =
reviewed to ensure that any huge
issues would already have been caught by now.

Thanks!
BR, David=

