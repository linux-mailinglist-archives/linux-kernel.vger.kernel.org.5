Return-Path: <linux-kernel+bounces-135600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 309C089C841
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 17:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38F2EB21FC4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F10140E26;
	Mon,  8 Apr 2024 15:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Sg3Jq/3m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A32A13E88F;
	Mon,  8 Apr 2024 15:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712590170; cv=none; b=BKlwK4A68CeUuP28Ba6ZPGGhfWnG3sX4GJ7QxWwd9iE81eKrMVKK7++7++7NcvwIMnjXqdROd//az94YhSsGYUZCTd3Hs5q0YjD/UL+TaBkTPW2n23yVhthjmDLlJAXyKhGj1mMDuB5n8sDsHPgIJI+RJTNOQLbscaWyBEA8jSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712590170; c=relaxed/simple;
	bh=453y5TVJbT2eV9mcf+f4sFbiwFZXJLBXjLhR/YaLoiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q8VHbPT541+zo6OecxXmniNbVc/v5Vy/E10osY4nSj9u9WzPdISSegvw8hlNAA3qWOBssXmWUrh1SlmK/0SKse2IJlWusnT5/g2Ic2eVCE6fWQDpbIvuoC2U7pgHdUfntJSVa16dWQKCKFzTaXU1HfhS732QEaR4sHShHyvpSq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Sg3Jq/3m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D30FC433C7;
	Mon,  8 Apr 2024 15:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712590169;
	bh=453y5TVJbT2eV9mcf+f4sFbiwFZXJLBXjLhR/YaLoiU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sg3Jq/3mxT2WhVcxVD6YHLQZ7kVWlV6jYoYpVAOU9c+q55bJrcBZxcVDmLX1qv5E9
	 Yu0LsheLeHrWidWvY50+rF8MQTiEEz2QKnXoO0oLtC0GbmEkL87mYDqhFPr+JrrCeD
	 j/C4elUFCodFyX4pxmxB1yQXQp70y41HUGFWL3cs=
Date: Mon, 8 Apr 2024 11:29:26 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Haifeng Xu <haifeng.xu@shopee.com>
Cc: Reinette Chatre <reinette.chatre@intel.com>, james.morse@arm.com, 
	fenghua.yu@intel.com, babu.moger@amd.com, bp@alien8.de, tglx@linutronix.de, 
	mingo@redhat.com, dave.hansen@linux.intel.com, hpa@zytor.com, 
	peternewman@google.com, x86@kernel.org, linux-kernel@vger.kernel.org, corbet@lwn.net, 
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v6 0/2] x86/resctrl: Track llc_occupancy of RMIDs in
 limbo list
Message-ID: <20240408-stalwart-tomato-sloth-bddbae@lemur>
References: <20240319083039.223088-1-haifeng.xu@shopee.com>
 <4244b729-2eec-4999-9427-00b5c9f3e6fc@intel.com>
 <ca45f32d-b526-4bcd-b177-08698babaf3d@shopee.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ca45f32d-b526-4bcd-b177-08698babaf3d@shopee.com>

On Mon, Apr 08, 2024 at 03:44:00PM +0800, Haifeng Xu wrote:
> I can also reproduced it. After digging into it, I found that our DKIM signature header
> has 't' and 'x' flags. They are recommended as a means to help identify spam.
> 
> t= is the DKIM signature timestamp.
> x= is the DKIM signature expiration time.
> 
> The source code of DKIM Validation can be seen in dkim/__init__.py(line 351), I paste it
> here.
> 
>  343     if b'x' in sig:
>  344         if re.match(br"\d+$", sig[b'x']) is None:
>  345             raise ValidationError(
>  346               "x= value is not a decimal integer (%s)" % sig[b'x'])
>  347         x_sign = int(sig[b'x'])
>  348         now = int(time.time())
>  349         slop = 36000 # 10H leeway for mailers with inaccurate clocks
>  350         if x_sign < now - slop:
>  351             raise ValidationError(
>  352                 "x= value is past (%s)" % sig[b'x'])
>  353             if x_sign < t_sign:
>  354                 raise ValidationError(
>  355                     "x= value is less than t= value (x=%s t=%s)" %
>  356                     (sig[b'x'], sig[b't']))
> 
> The expiry time is less than the time point you download the patch, so the validation
> fails. If I comment out these lines, this series can be successfully downloaded.

FWIW, I've requested ability to ignore the x= flag when validating signatures:
https://bugs.launchpad.net/dkimpy/+bug/2047054

-K

