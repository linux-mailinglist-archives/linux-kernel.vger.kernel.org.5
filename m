Return-Path: <linux-kernel+bounces-52869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE2A849DA0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D62081C24C72
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39052C684;
	Mon,  5 Feb 2024 15:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="oX3xciPi"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9B42C19C;
	Mon,  5 Feb 2024 15:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707145245; cv=none; b=aO3jz/nIX08tZo97WzCTLDougVfmPTE2CPVpLbxHRTVg9t2noH2qYHOxBKdsFQHLzpKrTo4ep5WQAQm9hJoccih+oV59DK7D1s0iTX5widpMIQ1+4LF/g7o+Nm+aH6YKJHa72Ua7wp+aeeoD0N6tNzEfEmbvbYB6cFHvJx+N0mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707145245; c=relaxed/simple;
	bh=G/upHH50MlPuOxBBaB3xXpKK9F7lVAXSgZQ2cx/UUr0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZecgAJOh80lKflqo46M2Ul0twSxUjatNMRtea2dI1fPvceb0ciq2ldfvqzG5xuvreq4PVVpGG7CkymSTTfzcb6dnwx2mKc0skZ23/uDjJZ2qiwU+C/cHdwdlnlmXxob5YDPjk94lcf5alN3/whewdQ5BvYaQyj0TlMFhUqb+Fhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=oX3xciPi; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8545EFF814;
	Mon,  5 Feb 2024 15:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707145241;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PEE4+JdfTjyn6YerADKkv+gio5Qai05SHvunF75uvZU=;
	b=oX3xciPiOpgsx1o4tDNRxIBoA7dmBw3a39tOa1P386RMNRDh0M00hwbtZuiQQg6pZ/wtHS
	HSgTnpDkxu/BejnrNyEVqNww/V2jr2k0ZJ1+hx3SYYdgB73/NdEeZBcHt3bjBPzZ6FlYMY
	IjC2YdExejSDAcHawCwPefQ9a1DbrsbPuIAmum/7i00XyTJZWQZRw3hJ3Ly44jsone5EDw
	QxORhCF4x1c0u6roUFaB8F4RX6oGu+FWBJmuS82JVdOIntjx8Phy7oZ70xXKLJnwd+vbY7
	HHum87IPtjxZ9/EtxpZCe5nlAi0ygarL1gEABTngUxDw4/mTwf42W5KxSHnH1Q==
Date: Mon, 5 Feb 2024 16:00:33 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Vadim Fedorenko  <vadim.fedorenko@linux.dev>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Andrew Lunn <andrew@lunn.ch>, Mark Brown
 <broonie@kernel.org>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 5/6] net: wan: fsl_qmc_hdlc: Add runtime timeslots
 changes support
Message-ID: <20240205160033.2c017f46@bootlin.com>
In-Reply-To: <a8845eca2d9bab5d7805c19a16811820671c41f2.camel@redhat.com>
References: <20240130084035.115086-1-herve.codina@bootlin.com>
	<20240130084035.115086-6-herve.codina@bootlin.com>
	<a8845eca2d9bab5d7805c19a16811820671c41f2.camel@redhat.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Hi Paolo,

On Thu, 01 Feb 2024 13:01:51 +0100
Paolo Abeni <pabeni@redhat.com> wrote:

[...]
> >  
> > +static int qmc_hdlc_xlate_slot_map(struct qmc_hdlc *qmc_hdlc,
> > +				   u32 slot_map, struct qmc_chan_ts_info *ts_info)
> > +{
> > +	DECLARE_BITMAP(ts_mask_avail, 64);
> > +	DECLARE_BITMAP(ts_mask, 64);
> > +	DECLARE_BITMAP(map, 64);
> > +	u32 array32[2];
> > +
> > +	/* Tx and Rx available masks must be identical */
> > +	if (ts_info->rx_ts_mask_avail != ts_info->tx_ts_mask_avail) {
> > +		dev_err(qmc_hdlc->dev, "tx and rx available timeslots mismatch (0x%llx, 0x%llx)\n",
> > +			ts_info->rx_ts_mask_avail, ts_info->tx_ts_mask_avail);
> > +		return -EINVAL;
> > +	}
> > +
> > +	bitmap_from_arr64(ts_mask_avail, &ts_info->rx_ts_mask_avail, 64);
> > +	array32[0] = slot_map;
> > +	array32[1] = 0;
> > +	bitmap_from_arr32(map, array32, 64);  
> 
> What about using bitmap_from_u64 everywhere ?

Yes indeed.
Will be updated in the next series iteration.

Thanks for this review.
Best regards,
Hervé

