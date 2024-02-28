Return-Path: <linux-kernel+bounces-85411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9781086B588
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:06:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DCC828AEC0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 17:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA75815D5CF;
	Wed, 28 Feb 2024 17:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="sZl8QxOi"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7104915D5AE
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 17:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709139959; cv=none; b=H/Kr1zqLKqXgeKMJkryUAfJPFQNeThg7uWN/J9MXW4ZRea2Kln68bJdH9UgGiycmi5qEPIoEVghrF6jj6MN/xwOyBq1EBKKksszPCXaKJN3OuvKPvjpyLoqOo6LOA+xHB7YcMg5QgyjwGjwyQ5a9vpyIMLUsIzICDLNgM27YNZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709139959; c=relaxed/simple;
	bh=xsjOnfV9ueS/E2C/cSWGm39SXO3D/7ApeGNI6RuZo9g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sI0y1MoOueHOKFI1Kg3TJpTythxbM6vcP2yT0LMARRj0kKiPrVy7hypzSWqEaT1Z2HS2uf7ExbixO6TsMvGYXQCQ5X4bqiixzmJxKXsBO38nYLJPTVlCuCHYqYXbGc4pNkc1GVBo3kaEedpJEZENvmEkpO4isv+15uMK34KC4Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=sZl8QxOi; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=mBC3pgi3Jdc2YKejyvmMgNdf8EHNn5L2lgfo9Ko6DEA=;
	t=1709139956; x=1710349556; b=sZl8QxOiLktsZggT9NnLdc473yvUOYZ7hjLq9kqBwuuZyd8
	dOMANhSSttAk6bAuQv24zBuM7rvv0OHIOexmxLgUc1dPZUT2D3XG1ww//xhDn+YOgYFhkqpXU6eUd
	J1b/4u+U0yrDnCfqGFNMIpJVM4j0Ljyjvy58Ohta45PYGlHlsE9R4jfXcZS8sv9rF6Xu1LC91Bg7Q
	Tjw0ljh1HWiioic+YZP3PXmykSetIHn/vOGpMbl3n1ERSoh75Y6bFW5Ww48Vzs5UUw/6dp0axoZO1
	q88ZDduEg9qrxfsHDSJrtCS98z7Tl4hoZl3/LHI+3d07IiJbBWGa6A3JiYGhmuAQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rfNNQ-0000000CIq1-2nGv;
	Wed, 28 Feb 2024 18:05:52 +0100
Message-ID: <84e4f0d70c5552dd7fa350c61c28de9637628ee6.camel@sipsolutions.net>
Subject: Re: [PATCH v2 2/4] devcoredump: Add dev_coredumpm_timeout()
From: Johannes Berg <johannes@sipsolutions.net>
To: =?ISO-8859-1?Q?Jos=E9?= Roberto de Souza <jose.souza@intel.com>, 
	linux-kernel@vger.kernel.org, intel-xe@lists.freedesktop.org
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>, Mukesh Ojha
 <quic_mojha@quicinc.com>,  Jonathan Cavitt <jonathan.cavitt@intel.com>
Date: Wed, 28 Feb 2024 18:05:51 +0100
In-Reply-To: <20240228165709.82089-2-jose.souza@intel.com>
References: <20240228165709.82089-1-jose.souza@intel.com>
	 <20240228165709.82089-2-jose.souza@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

> Current 5-minute timeout may be too short for users to search and
> understand what needs to be done to capture coredump to report bugs.

Conceptually, I'm not sure I understand this. Users should probably have
a script to capture coredumps to a file in the filesystem, possibly with
additional data such as 'dmesg' at the time of the dump.

Having this stick around longer in core kernel memory (not even
swappable) seems like a bad idea?

What kind of timeout were you thinking? Maybe you'd want 10 minutes? An
hour?

Also, then, why should the timeout be device-specific? If the user is
going to need time to find stuff, then surely that applies regardless of
the device?

So ... I guess I don't really like this, and don't really see how it
makes sense. Arguably, 5 minutes even is too long, not too short,
because you should have scripting that captures it, writes it to disk,
and all that can happen in the space of seconds, rather than minutes.
It's trivial to write such a script with a udev trigger or similar.

If we wanted to, we could even have a script that not only captures it
to disk, but also deletes it again from disk after a day or something,
so if you didn't care you don't get things accumulating. But I don't see
why the kernel should need to hang on to all the (possibly big) core
dump in RAM, for whatever time. And I also don't like the device-
dependency very much, TBH.



But if we do go there eventually:

> +void dev_coredumpm(struct device *dev, struct module *owner,
> +		   void *data, size_t datalen, gfp_t gfp,
> +		   ssize_t (*read)(char *buffer, loff_t offset, size_t count,
> +				   void *data, size_t datalen),
> +		   void (*free)(void *data))
> +{
> +	dev_coredumpm_timeout(dev, owner, data, datalen, gfp, read, free,
> +			      DEVCD_TIMEOUT);
> +}
>  EXPORT_SYMBOL_GPL(dev_coredumpm);

This could be a trivial static inline now, if you just put DEVCD_TIMEOUT
into the header file. Seems better than exporting another whole function
for it. Then you also don't need the no-op version of it.

johannes


