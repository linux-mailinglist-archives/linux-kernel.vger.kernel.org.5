Return-Path: <linux-kernel+bounces-138300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B1D89EF82
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 12:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F1451C22468
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 10:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9D3158206;
	Wed, 10 Apr 2024 10:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lPB1FYWV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BGqfAdXl";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lPB1FYWV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BGqfAdXl"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91624D59F
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 10:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712743582; cv=none; b=YxaqlV6keTux1BbTsaNVYbOgngAc0z76r0ec2VfTh3OATs2xY6L6REYYsUdtdAsPLMXQW15utM8lFUgpsqqUf7PErZNR2XQgRshfS08rhG5KGZyncrWVZGCSP7a6w5dBQrF+qRm1vueXtBLcJF6aJrUbLx1S406Vr3vUj8bDPwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712743582; c=relaxed/simple;
	bh=ICCVsvv1oFh7Mpy2AZgqS3nTixbRpJsflLizmXA3ZkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YDerB4VrVHAbl2crc93XcoVRegQeX1zJLW334t3FksL4vGsz5L8MzhWZ1tpFR7cgToJ2zbefGuDjsKBkODhJKbNJ48GbtZycogFAipuGlsVWLr6gXJBz+ilxqt7Kfu7InRI6Sv68aYAWaj+u1/7dVBR0285lvRjiVh/+9T253UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lPB1FYWV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BGqfAdXl; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lPB1FYWV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BGqfAdXl; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CAACE5CA2C;
	Wed, 10 Apr 2024 10:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712743577; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4TpUgcWW5x0vb4JdI1qMHUTdMa7eR+Z/vXiUTvIkUX8=;
	b=lPB1FYWVxPMycAN8jS+EPKYsLaR0LuMfBUqgvQ/+sDdU2UMR7/CDXktQ+WvkD86V5ezca/
	1JrY9pvYxiwSjB3R1hwJiZmlTMFh39JmC4WLYEPmVmZpbZehT6AMh0OtWgU3C+4X3l0nbv
	pGymrKLOHMKxPDKqPLX6dX1G6WS0xBU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712743577;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4TpUgcWW5x0vb4JdI1qMHUTdMa7eR+Z/vXiUTvIkUX8=;
	b=BGqfAdXlNIhgRpo6x/D1j1Z1wF1oFhMcxl69GYYP+zJMTIch16TkOFPq9k7CvGYyckNRSH
	gfGCTXLUSj9z24Cg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712743577; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4TpUgcWW5x0vb4JdI1qMHUTdMa7eR+Z/vXiUTvIkUX8=;
	b=lPB1FYWVxPMycAN8jS+EPKYsLaR0LuMfBUqgvQ/+sDdU2UMR7/CDXktQ+WvkD86V5ezca/
	1JrY9pvYxiwSjB3R1hwJiZmlTMFh39JmC4WLYEPmVmZpbZehT6AMh0OtWgU3C+4X3l0nbv
	pGymrKLOHMKxPDKqPLX6dX1G6WS0xBU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712743577;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4TpUgcWW5x0vb4JdI1qMHUTdMa7eR+Z/vXiUTvIkUX8=;
	b=BGqfAdXlNIhgRpo6x/D1j1Z1wF1oFhMcxl69GYYP+zJMTIch16TkOFPq9k7CvGYyckNRSH
	gfGCTXLUSj9z24Cg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id B69AE13A92;
	Wed, 10 Apr 2024 10:06:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id qxcfK5lkFmYmaAAAn2gu4w
	(envelope-from <dwagner@suse.de>); Wed, 10 Apr 2024 10:06:17 +0000
Date: Wed, 10 Apr 2024 12:06:17 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, 
	James Smart <james.smart@broadcom.com>, Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/6] nvme-tcp: short-circuit reconnect retries
Message-ID: <ejsaj5wnhlukb5rbjtnxh7vxpakcd62ee5cimb35mcvv7jqxod@5cnmbyfmnnwn>
References: <20240409093510.12321-1-dwagner@suse.de>
 <20240409093510.12321-4-dwagner@suse.de>
 <91c49412-4251-4e13-80df-9148208aeac7@grimberg.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91c49412-4251-4e13-80df-9148208aeac7@grimberg.me>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns]

On Tue, Apr 09, 2024 at 11:40:03PM +0300, Sagi Grimberg wrote:
> > +/*
> > + * Evaluate the status information returned by the LLDD
> 
> We usually say transport, less so LLDD.

Updated the documentation accordingly.

> > + * 1) The LLDD reports an negative status. There was an error (e.g. no
> > + *    memory) on the host side and thus abort the operation.
> > + *    Note, there are exception such as ENOTCONN which is
> > + *    not an internal driver error, thus we filter these errors
> > + *    out and retry later.
>
> What is this ENOTCONN here? From what I see its just a random
> escape value to bypass the status check. I think that 0 would do the same
> wouldn't it?

ENOTCONN is issued by the reset handler. Sure, 0 will work as well, so
if the consense is that the reset handler should do that. see below.

> > -	if (nvmf_should_reconnect(ctrl)) {
> > +	if (recon && nvmf_should_reconnect(ctrl)) {
> 
> its weird to have a condition that checks _and_ condition
> of two different "should reconnect" conditions.
> 
> Why don't we simply pass the status to nvmf_should_reconnect()
> and evaluate there?

Sure, makes sense.

> >   static void nvme_tcp_error_recovery_work(struct work_struct *work)
> > @@ -2295,7 +2300,7 @@ static void nvme_tcp_error_recovery_work(struct work_struct *work)
> >   		return;
> >   	}
> > -	nvme_tcp_reconnect_or_remove(ctrl);
> > +	nvme_tcp_reconnect_or_remove(ctrl, -ENOTCONN);

Here is the source of ENOTCONN.

