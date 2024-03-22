Return-Path: <linux-kernel+bounces-111415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02424886C03
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 13:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1C69286CE1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 12:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B63444C84;
	Fri, 22 Mar 2024 12:25:27 +0000 (UTC)
Received: from smtp.dudau.co.uk (dliviu.plus.com [80.229.23.120])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5981446B4;
	Fri, 22 Mar 2024 12:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.229.23.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711110326; cv=none; b=aVQUi7tlJ/H+8L1ELnq8mpxgl13dgaPoGYb5nh0cYPrSx9KtycTJ0WJfIsin1nt6GL8BYamOBL6/hXNGDMeOrjZUOPeZpE0homRy91MTRSecfiV/iMEHkxblfoSx97pWi9F89U6KGHqWbAwpdntsqNG3rMIY0jZ+DNVA+L4yO30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711110326; c=relaxed/simple;
	bh=JPMHi1XX85jvIDDUVM1CjjE3cn3oHcAZfWVA0Nis8K8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q5Pc2voLi9yWSoqX+NfMWYmpT6ypxUoFAbUr6nJqIlysFh5qbube4U27UmkcbyDPXzeznhlRgb12PQeMQicXlOJTsayFFZRT6G/2ulyLozIHptjPqQQ3s3qWO6++XgWip+Ns9LBcgm5XHJCRJ5vPTWf8ctIEV6H1TTv+fzxNVys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dudau.co.uk; spf=pass smtp.mailfrom=dudau.co.uk; arc=none smtp.client-ip=80.229.23.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dudau.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dudau.co.uk
Received: from mail.dudau.co.uk (bart.dudau.co.uk [192.168.14.2])
	by smtp.dudau.co.uk (Postfix) with SMTP id 1011B4172F42;
	Fri, 22 Mar 2024 12:25:20 +0000 (GMT)
Received: by mail.dudau.co.uk (sSMTP sendmail emulation); Fri, 22 Mar 2024 12:25:19 +0000
Date: Fri, 22 Mar 2024 12:25:19 +0000
From: Liviu Dudau <liviu@dudau.co.uk>
To: =?utf-8?B?QmrDuHJu?= Mork <bjorn@mork.no>
Cc: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>,
	Haijun Liu <haijun.liu@mediatek.com>,
	Chiranjeevi Rapolu <chiranjeevi.rapolu@linux.intel.com>,
	M Chetan Kumar <m.chetan.kumar@linux.intel.com>,
	Ricardo Martinez <ricardo.martinez@linux.intel.com>,
	Loic Poulain <loic.poulain@linaro.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	"David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: net: wwan: t7xx: BUG: Unaligned access when loading mtk_t7xx
 module
Message-ID: <Zf14r4UPwQss9L4d@bart.dudau.co.uk>
References: <Zfxlj3pYUk4ys47T@bart.dudau.co.uk>
 <87il1ezdbd.fsf@miraculix.mork.no>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87il1ezdbd.fsf@miraculix.mork.no>

On Fri, Mar 22, 2024 at 01:00:22PM +0100, Bjørn Mork wrote:
> Liviu Dudau <liviu@dudau.co.uk> writes:
> 
> >  I had a
> > go at guessing that UL registers are at 0x8 and 0x48 offsets and DL
> > registers are at 0x0478 and 0x04b8, but while that fixes the alignment
> > exception, I now get a "CLDMA{0,1} queue 0 is not empty" message.
> 
> I don't think you can assume the register offsets are wrong.  It looks
> more like the device doesn't care about alignment.

Sorry, I should clarify: the offsets are wrong when you're trying to do
a 64bit read over PCIe for a MEM64 area. Accessed addresses are expected
to be multiples of 8 bytes. t7xx_cldma_hw_set_start_addr() uses the offset
for the low register for calculating the address for the write, which is
not 64bit aligned for the UL block.

> 
> But given that the driver includes <linux/io-64-nonatomic-lo-hi.h>, you
> can probably replace those unaligned 64bit accesses with two nonatomic
> 32bit accesses.
>

I've tried your suggestion and things seem to progress further, thanks for
that! I'm getting some errors on not being able to transition from D3hot
to D0, but I guess it might be something to do with the PCIe-to-M.2 adaptor
that I'm using. Will continue my investigation into the setup and report
back with a patch to replace the register accesses with the lo_hi variants.

Best regards,
Liviu

> 
> Bjørn

-- 
Everyone who uses computers frequently has had, from time to time,
a mad desire to attack the precocious abacus with an axe.
       	   	      	     	  -- John D. Clark, Ignition!

