Return-Path: <linux-kernel+bounces-56227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA2284C79D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:38:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A2E51F2A25D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806E422307;
	Wed,  7 Feb 2024 09:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="q0tCTZHz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9AA21A19;
	Wed,  7 Feb 2024 09:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707298448; cv=none; b=t0nLnPPeN8ySq7vo4miutr/iaCFitPRzUcy+IFrVs2drRXdrkDQnJ5pUpfqJo2n+vQ0eNt+LcqYUU/tCDVb/XpNCL74VBPsP7w9WIDYrZFk56RxcEthCARACF68sTOYi9mPdZ0NdPffpjwKVnMV2WrHe5AaG+hxjQ7m964ElAQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707298448; c=relaxed/simple;
	bh=9R+OqVqHBHqXShJWLZL21KpJxHNGYryJFB0/wiYofsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mpc7nvWd8gxkRVMZMnKfzpz3ro5ADC8LHcUuxrKuhx15H+miSn8ciqR0memSUPupnD84w+2mPNHQ9TUJoA9qmVpPrIFXWlrM1T2SvsC+GeDdPV9T+v4jquroYP/FYCekmYEYtcFn+7fzTVUUhHBBex4h9kvAPIVfjXVQWN5X3HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=q0tCTZHz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 426F5C4166B;
	Wed,  7 Feb 2024 09:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707298447;
	bh=9R+OqVqHBHqXShJWLZL21KpJxHNGYryJFB0/wiYofsQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q0tCTZHzfz4ufqkHQuwMlNf6iCoTUGviJZAWNr6pCgQC721qmFl8AHu5w0SiUlwYJ
	 /0/LkZWcqYDVffT+HArmOxVz5S9KqFTAd/S9Q84jwsj1/OfDRFVetlBd32odP0F800
	 5Cp0BzeUAIswopiMKi4qo7acj20qKrzg7i7kB8FQ=
Date: Wed, 7 Feb 2024 09:34:02 +0000
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Joy Chakraborty <joychakr@google.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	linux-kernel@vger.kernel.org, manugautam@google.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] nvmem: rmem: Fix return value of rmem_read()
Message-ID: <2024020734-curliness-licking-44c1@gregkh>
References: <20240206042408.224138-1-joychakr@google.com>
 <2024020647-submarine-lucid-ea7b@gregkh>
 <CAOSNQF3jk+85-P+NB-1w=nQwJr1BBO9OQuLbm6s8PiXrFMQdjg@mail.gmail.com>
 <2024020637-handpick-pamphlet-bacb@gregkh>
 <CAOSNQF2_qy51Z01DKO1MB-d+K4EaXGDkof1T4pHNO10U_Hm0WQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOSNQF2_qy51Z01DKO1MB-d+K4EaXGDkof1T4pHNO10U_Hm0WQ@mail.gmail.com>

On Tue, Feb 06, 2024 at 05:22:15PM +0530, Joy Chakraborty wrote:
> > > Userspace will see a false error with nvmem cell reads from
> > > nvmem_cell_attr_read() in current code, which should be fixed on
> > > returning 0 for success.
> >
> > So maybe fix this all up to allow the read to return the actual amount
> > read?  That feels more "correct" to me.
> >
> 
> If I change the behavior of the nvmem_reg_read_t callback to negative
> for error and number of bytes actually read for success then, other
> than the core driver I would also have to change all the
> nvmem-provider drivers.
> Is it okay to do so ?

Sure, why not?  That seems like the correct fix to me, right?

thanks,

greg k-h

