Return-Path: <linux-kernel+bounces-162298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7758B5935
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 097612809A5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9350548EC;
	Mon, 29 Apr 2024 12:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vPKOdYBh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DD610971;
	Mon, 29 Apr 2024 12:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714395468; cv=none; b=UzGZvjVXUfc1ccWSGHvllKvvz4xHmHmTONGv0yIR//QJ7PFzvxwM27Z4IP2doD//XqvfwpQBhJ0IJWnjyD+rV8WoRGAUKankmwfIgEMBR5ZogwR05skey6PejmfuY+USQGFXpbkUAerA+IQwbrME+f60jy8WwLOXdfLK42tJPxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714395468; c=relaxed/simple;
	bh=szOipog58uDKQbq3rAwx1O2WRdTgbJ6PtSPilHFTcyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KQfHZ5JR2qXORd1DdZwptWyNZAdBXrtZM7PYg2L7+ifb67YdKEjSFpB/b42W5fQ8nmWnedqbEbjgwjEZ2NP4Ni3PcxsS8v2KvSTzovnpESt9PY7m30+gu4E8tOf6KVvafMrZD9lUzNuX3tPK6enkcIA8XAf8mQeUdvgq+nvLsHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vPKOdYBh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15165C4AF17;
	Mon, 29 Apr 2024 12:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714395467;
	bh=szOipog58uDKQbq3rAwx1O2WRdTgbJ6PtSPilHFTcyk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vPKOdYBhYxfxgg84blVbmKXkH4I8XVvqkXnVC5rpmsKRgOGOg0J3chsFG5yIkBpKk
	 Px3JvrOfoEXJcX5e6/WOWaZo95+M8KM1PSmlsTHIrvS3GBgreWCXuzmfaglaCDSRG3
	 J+rTHCVIcbXXy/gF1437bPFzlSyG0G3uMHUqnUcwqAGEVpw81K80tR66IoME3i0q7X
	 ArNjAr/FkyGJ2qSYMW8w6mRAW98KVvGkx8hPjj5hE7sKrlhXBYtkRry5rNXkWXl/+a
	 sFUSPd6YETlv0vzcyz2HhMUAca7dUKOnlGcIl9GOjaTWLnvSRDVmOTcPaHE6lH55u1
	 Q10No13LLAgyg==
Date: Mon, 29 Apr 2024 13:57:42 +0100
From: Simon Horman <horms@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: intel-wired-lan@lists.osuosl.org,
	Michal Kubiak <michal.kubiak@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH iwl] idpf: don't enable NAPI and interrupts prior to
 allocating Rx buffers
Message-ID: <20240429125742.GX516117@kernel.org>
References: <20240426144408.1353962-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240426144408.1353962-1-aleksander.lobakin@intel.com>

On Fri, Apr 26, 2024 at 04:44:08PM +0200, Alexander Lobakin wrote:
> Currently, idpf enables NAPI and interrupts prior to allocating Rx
> buffers.
> This may lead to frame loss (there are no buffers to place incoming
> frames) and even crashes on quick ifup-ifdown. Interrupts must be
> enabled only after all the resources are here and available.
> Split interrupt init into two phases: initialization and enabling,
> and perform the second only after the queues are fully initialized.
> Note that we can't just move interrupt initialization down the init
> process, as the queues must have correct a ::q_vector pointer set
> and NAPI already added in order to allocate buffers correctly.
> Also, during the deinit process, disable HW interrupts first and
> only then disable NAPI. Otherwise, there can be a HW event leading
> to napi_schedule(), but the NAPI will already be unavailable.
> 
> Fixes: d4d558718266 ("idpf: initialize interrupts and enable vport")
> Reported-by: Michal Kubiak <michal.kubiak@intel.com>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


