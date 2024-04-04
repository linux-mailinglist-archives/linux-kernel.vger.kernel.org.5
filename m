Return-Path: <linux-kernel+bounces-131664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B59B898A90
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBFE1B283AE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD54812BF1C;
	Thu,  4 Apr 2024 15:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KaW/5ApO"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384BB1BDC4;
	Thu,  4 Apr 2024 15:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712242825; cv=none; b=c3CeClHSE1KYbCF7Ugi/0lIqgfHQ+CDq4rlBKVprrmlG/AvzwG1QACOK8uRodPWg0KjEHQt3UvJh1VM5bIw/eg9PX4lUYx0Zfe4SUoPvPkalBdTuYMPOSrfUtLUoGdSNbPee0Q1ML29Nrt8mVs+rZyUHWMrTSCvGtLf+e0io+1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712242825; c=relaxed/simple;
	bh=82Ksk5MRce8FoFdBZGQ2WHseU6zKUxpaW0NKXsqB680=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Uf3b3RdlveHxE1Cj9KJ1lAOnI+H5OGyFlSLNdpwjftuP4ema6mwzNs6vliQpqOtAiA5tX+G4NB72T0YDlYCKiadRrckKGFSmvegy8FXw1zimvKq+I3JMA34wNzfDwwFiN+7UpXDJaVq36M3lmlKBN4n35Shed5suGimSkEJ9Hw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KaW/5ApO; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4162bac959cso4082545e9.0;
        Thu, 04 Apr 2024 08:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712242822; x=1712847622; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VnLzhYhrH3H0+vxV47dmFzyztuQARB+T4eF07NyGj34=;
        b=KaW/5ApOlklVERCA7CVcj9lskuUQpRIFclbCo2HRIWm7oFtpC1V2oylEc9fsUZujuH
         w5SUCdKqvKiKMHwi3tDaJElmS504JUUaho4t4x+b5NXEMvsjx5O72RpMgdalUsXFC99W
         JbjZut6KjJBtEIxPoWh3vQ8QcQox7czPF3EcS0ZnRbBhzWgxc7XMH+B8cXGoONe4sKHk
         9PmUT4APC56d/EIY4PNyuDjzC9HaXtgZAPAY4bRCO2QQ1VJHsh2DXzcS1X20Q8MNQoQr
         kOjK9ScBgIbkItfxnONfT1tnt7FceXKWZj1JYDlQhryJ28YPOibZzu+ObT6n6XVM/mBZ
         vk0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712242822; x=1712847622;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VnLzhYhrH3H0+vxV47dmFzyztuQARB+T4eF07NyGj34=;
        b=U2+OHhSsF/tWhNfMYZG5mlyEgVRIIAuvgtccfhk/vdeLzhlk1ofPdeFcHJXERuGA1w
         s/ZQW9th8Tz7lWWLrRktE3UO7APLemX6Y0DKsS9f4YZ3m4CqAt6eUHeaA5880eB5Y6DW
         esrw+PvhWdpFGxfxrO+XWtonX5/U7rOvTsd0hVzFMeqNHi7eOqb6dE8cCPulMBKW7k58
         C4+hjdujCFKgKsJBCzbTdfZ6ALOTORSxX7LczBS4q1WfE9FB9KKqeU93fR7QYfwsL82e
         1mnYmEdDaQb7NBJkG0hE3S8IFPpV4BAeajyEf8ibnHd28pOGgp983gp7v/ofwUt5Dry5
         rmyA==
X-Forwarded-Encrypted: i=1; AJvYcCX0BwAB0EHYqWY1T8nhopWci33KVx0eahmBYkbwJmwek/iBGalmnj6wNDFZ40rHi5ErDM3O73EuwM7z9r3MGF+QPY3VTH3/on/9L8oAG3cOWzzNdpx7Mg+Vkxzp6zz03O2LyIGeSCTc
X-Gm-Message-State: AOJu0YwAFDD0jrZDuVlXKT8bxDTAc5IZrhIvBZ7wHYQ9K79CcmJh9HH3
	ewrzy5cYEJ25fNwrM4uKYNdyijyLsmBswCL+TubaEHuhHGGKtyn4krfI2yMBNugs0c2z
X-Google-Smtp-Source: AGHT+IFwYrzFVkxm9CrZafBJhQH+12w/vURVKxfcNMhINXV03zlxagWwBCJtK6FpV/Zvv8QOPmHLUw==
X-Received: by 2002:a5d:60ce:0:b0:33d:fb3:9021 with SMTP id x14-20020a5d60ce000000b0033d0fb39021mr1541782wrt.54.1712242822364;
        Thu, 04 Apr 2024 08:00:22 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1b:2000:15d4:fc17:481e:8afe? (p200300f6ef1b200015d4fc17481e8afe.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:15d4:fc17:481e:8afe])
        by smtp.gmail.com with ESMTPSA id a1-20020a5d4561000000b00343c0c24a65sm1904999wrc.89.2024.04.04.08.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 08:00:22 -0700 (PDT)
Message-ID: <f6d171499b622b463a174ce56fabc40c1e732bf9.camel@gmail.com>
Subject: Re: [PATCH 0/4] dev_printk: add dev_errp_probe() helper
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Nuno Sa
	 <nuno.sa@analog.com>, Andi Shyti <andi.shyti@kernel.org>
Cc: Petr Mladek <pmladek@suse.com>, Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Olivier Moysan
 <olivier.moysan@foss.st.com>, Jyoti Bhayana <jbhayana@google.com>, Chris
 Down <chris@chrisdown.name>, John Ogness <john.ogness@linutronix.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>,  linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
Date: Thu, 04 Apr 2024 17:03:53 +0200
In-Reply-To: <Zg6Z51uebr2dWLq2@smile.fi.intel.com>
References: <20240404-dev-add_dev_errp_probe-v1-0-d18e3eb7ec3f@analog.com>
	 <Zg6Z51uebr2dWLq2@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-04-04 at 15:15 +0300, Andy Shevchenko wrote:
> +Cc: Andi
>=20
> On Thu, Apr 04, 2024 at 01:06:22PM +0200, Nuno Sa wrote:
> > This series adds a dev_errp_probe() helper. This is similar to
> > dev_err_probe() but for cases where an ERR_PTR() is to be returned
> > simplifying patterns like:
> >=20
> > 	dev_err_probe(dev, ret, ...);
> > 	return ERR_PTR(ret)
>=20
> What about ERR_CAST() cases?

In theory not really needed (I think) but see my reply to the other patch.
>=20
> > The other three patches are adding users for it. The main motivator for
> > this were the changes in the commit ("iio: temperature: ltc2983: conver=
t
> > to dev_err_probe()"). Initially I just had a local helper [1] but then
> > it was suggested to try a new, common helper. As a result, I looked for
> > a couple more users.
> >=20
> > I then move into dev_errp_probe() [2] but it was then suggested to sepa=
rare
> > the patch series so we have onde dedicated for the printk helper.
> >=20
> > [1]:
> > https://lore.kernel.org/all/20240301-ltc2983-misc-improv-v3-1-c09516ac0=
efc@analog.com/
> > [2]:
> > https://lore.kernel.org/all/20240328-ltc2983-misc-improv-v4-0-0cc428c07=
cd5@analog.com/
>=20
> Have you seen mine?
>=20
> 20220214143248.502-1-andriy.shevchenko@linux.intel.com
>=20
> (Note, I'm pretty much fine and thankful that you take care of this)
>=20

Ups nope... I very prefer your naming :). I can take care of this only if y=
ou
don't intend to continue with your series. You sent it first so... :)

- Nuno S=C3=A1


