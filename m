Return-Path: <linux-kernel+bounces-97975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE388772A4
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 19:12:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 453EF1F21D61
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 18:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D2523741;
	Sat,  9 Mar 2024 18:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ODXmAH0E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E653DFC1F;
	Sat,  9 Mar 2024 18:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710007966; cv=none; b=XaugK5XY897LV+2lJ5Bq0e/JT2ZOvufadV7/5R7h7kc6ZInMzVzRh+DetQ1s+vVu6M+Ed+n612zxyc0sfYMQ0qTkjJqJAFrERRIpg5SeuvIs4nKsH/pBX82GKNWT1/bJBDtU8Jt9l8NGaBgb8g16UuUP4EgcWJYWnxJcgk9tn88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710007966; c=relaxed/simple;
	bh=nYEkpmlTsyzK3AKUqGaa2TkgAyQ7k0rhaWxh2Dk/SJw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SGt5Oq8odX8nAVlIrGfc8FZjrRrrnpbLM7kqlMaC6aY5siVKMI6WH0mjuaPwda4gUh4TuYGuCX/VN3TNqMHoZeTlx0yuim7LnT/y6vtUXkNJMgXHqBVUrhSe9TOJwcf9r3ZrDwCB1Lvzja7/L6aDkxw+5/mcIdVn/voIRgt06xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ODXmAH0E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8766C433F1;
	Sat,  9 Mar 2024 18:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710007965;
	bh=nYEkpmlTsyzK3AKUqGaa2TkgAyQ7k0rhaWxh2Dk/SJw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ODXmAH0EDp9yHuiaUkGMAe22WVHAczucS/NkA9HHs5djhpvBe85EaD7qMEVh9a8GY
	 TKw+6VF0vDKq3EjLnEBO0pHQxn5SlyAiG50z1oNUHxLkn4skoUCXB9x/WVzUJ3aP7Z
	 FLspWFpfeOy1hgfr+a+b3lO8r9jdxCjm3krpS7ZgYKsGltLsfiV/JwSb2X0NBYBPNF
	 LXTP4NGq/cLdMOYZbpEplyXdwGu3dbhFrs5GwluFczpo0giURu1RGJ+omYlSKXV5Nw
	 vf8s/oXPMpcx9azwbJq9xqSgq6Baus3gPf/lMiValRaxijRg7JTQB4ozY8OyrEBx1O
	 sl9vIGATnvSOg==
Date: Sat, 9 Mar 2024 18:12:33 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, lars@metafoo.de,
 ang.iglesiasg@gmail.com, mazziesaccount@gmail.com, ak@it-klinger.de,
 petre.rodan@subdimension.ro, phil@raspberrypi.com, 579lpy@gmail.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] iio: pressure: Add timestamp and scan_masks for
 BMP280 driver
Message-ID: <20240309181233.189abfaf@jic23-huawei>
In-Reply-To: <ZeYb3S1VNoziKHbb@smile.fi.intel.com>
References: <20240303165300.468011-1-vassilisamir@gmail.com>
	<20240303165300.468011-4-vassilisamir@gmail.com>
	<ZeW048EyOAze7oZR@smile.fi.intel.com>
	<20240304185017.GA3955@vamoiridPC>
	<ZeYb3S1VNoziKHbb@smile.fi.intel.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 4 Mar 2024 21:07:09 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Mon, Mar 04, 2024 at 07:50:17PM +0100, Vasileios Amoiridis wrote:
> > On Mon, Mar 04, 2024 at 01:47:47PM +0200, Andy Shevchenko wrote:  
> > > On Sun, Mar 03, 2024 at 05:52:59PM +0100, Vasileios Amoiridis wrote:  
> 
> ...
> 
> > > > +enum bmp280_scan {
> > > > +	BMP280_TEMP,
> > > > +	BMP280_PRESS,
> > > > +	BME280_HUMID,
> > > > +};  
> > > 
> > > Hmm... Why do we need to actually copy the IIO ones? Can't we use IIO ones
> > > directly (or in some way)?  
> > 
> > What do you mean exactly by copying the IIO ones? These values are used as
> > indexes to enable channels in the avail_scan_masks below.  
> 
> Yeah, I have now an answer to my question. The IIO drivers provide these lists
> as mapping between available channels (as starting from 0) and real channels
> as per IIO specifications (which can be anything, although limited currently
> by 40 or so).
> 

These are the scan indexes. It would be better to specify them as such
in the channel definitions so that the two sets of values are forced to match.

Jonathan

