Return-Path: <linux-kernel+bounces-82804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 232978689E0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 08:32:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFFEBB2393B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 07:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7566354BD4;
	Tue, 27 Feb 2024 07:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="F85mb3rg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59F356441;
	Tue, 27 Feb 2024 07:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709019126; cv=none; b=flNbCo2J926HDPQAJ83vzU9gqg5ltPcnCO3npa/qNQzsIqIvO/F1ePbRIjmE7c8K4x2VyR1siTIbK1hxwCfkkOCTVXIGQSEJ9EFN3AUYAyum4pjQoAyyr+S5ahF8p2ClaeXCGM5C/8cZeMWsPRraNYWu01TRlznYJFXmWqsaCak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709019126; c=relaxed/simple;
	bh=J+BCSTM2zIQiZtu5XInAU+A2j7tVeZ+gnZ2UGP99oBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lcZNBx14dbzASPmWq95T3sRsTO5QIbuLL7g13bfT8dJ2LKsFmRiqKne5VCsH5CKVYOGcc9lUSJv0mP9tz/trgdQapw3fU81dmJe0iK6uHWB0i7rk3uWupNGCBHNgArCtkKKG1QtO3uMraDf+mtxuvmM3Trm1shd6jm786w6P8B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=F85mb3rg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7962C433C7;
	Tue, 27 Feb 2024 07:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709019126;
	bh=J+BCSTM2zIQiZtu5XInAU+A2j7tVeZ+gnZ2UGP99oBA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F85mb3rgIOL4NXCzALfSEiicT5N7lqtOMgIyQueWrmmd184uBe3KqcksNPr2+upHj
	 O0+sOt8MuSjAp/8Oj3CavrSk9YU4ALImUEGoL1KsjJgP39m/znczmGzz/vTrcZtgYW
	 2ll6LFjJecyGs8W7GBqPcqxqQ9mibnGjGLEF1oUU=
Date: Tue, 27 Feb 2024 08:32:00 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Joy Chakraborty <joychakr@google.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	linux-kernel@vger.kernel.org, manugautam@google.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] nvmem: rmem: Fix return value of rmem_read()
Message-ID: <2024022737-haiku-rental-5e7b@gregkh>
References: <20240206042408.224138-1-joychakr@google.com>
 <2024020647-submarine-lucid-ea7b@gregkh>
 <CAOSNQF3jk+85-P+NB-1w=nQwJr1BBO9OQuLbm6s8PiXrFMQdjg@mail.gmail.com>
 <2024020637-handpick-pamphlet-bacb@gregkh>
 <CAOSNQF2_qy51Z01DKO1MB-d+K4EaXGDkof1T4pHNO10U_Hm0WQ@mail.gmail.com>
 <2024020734-curliness-licking-44c1@gregkh>
 <CAOSNQF2WKang6DpGoVztybkEbtL=Uhc5J-WLvyfRhT3MGWgiaA@mail.gmail.com>
 <CAOSNQF2d27vYTtWwoDY8ALHWo3+eTeBz7e=koNodphVVmeThMQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOSNQF2d27vYTtWwoDY8ALHWo3+eTeBz7e=koNodphVVmeThMQ@mail.gmail.com>

On Tue, Feb 27, 2024 at 12:27:09PM +0530, Joy Chakraborty wrote:
> On Wed, Feb 7, 2024 at 8:33 PM Joy Chakraborty <joychakr@google.com> wrote:
> >
> > On Wed, Feb 7, 2024 at 3:04 PM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Tue, Feb 06, 2024 at 05:22:15PM +0530, Joy Chakraborty wrote:
> > > > > > Userspace will see a false error with nvmem cell reads from
> > > > > > nvmem_cell_attr_read() in current code, which should be fixed on
> > > > > > returning 0 for success.
> > > > >
> > > > > So maybe fix this all up to allow the read to return the actual amount
> > > > > read?  That feels more "correct" to me.
> > > > >
> > > >
> > > > If I change the behavior of the nvmem_reg_read_t callback to negative
> > > > for error and number of bytes actually read for success then, other
> > > > than the core driver I would also have to change all the
> > > > nvmem-provider drivers.
> > > > Is it okay to do so ?
> > >
> > > Sure, why not?  That seems like the correct fix to me, right?
> >
> > Sure, I can do that.
> >
> > Is it okay to change the if checks on the return code to "if (rc < 0)"
> > instead of "if (rc)" as a fix for the immediate issue with how return
> > value from rmem is handled which can be applied to older kernels.
> > In a separate patch I can change the definition of nvmem_reg_read_t()
> > to return ssize_t instead of int and make corresponding changes to
> > nvmem-provider drivers.
> >
> > Does that sound okay ?
> 
> Hi Greg,
> 
> Sent a patch https://lore.kernel.org/all/20240219113149.2437990-2-joychakr@google.com/
> to change the return type for read/write callbacks.
> Do I mark that with the "Fixes:" tag as well ?

Is it actually fixing a bug?  Or just evolving the api to be more
correct over time?  I think the latter.

> It affects a lot of files so might not be able to easily pick to an
> older kernel when needed.

What is it fixing that older kernels need?

And do not worry about stable kernels while doing development, only
take that into consideration after your changes are accepted.

thanks,

greg k-h

