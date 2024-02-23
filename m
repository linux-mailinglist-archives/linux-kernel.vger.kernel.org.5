Return-Path: <linux-kernel+bounces-78077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08602860EA3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:52:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B147528337A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E48AB5CDCC;
	Fri, 23 Feb 2024 09:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1vu0rbpM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8oW4AbDC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BD8262BD
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 09:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708681853; cv=none; b=hdTPDlsmt++vvGRHrrAph1SJDS5Xf2OsSDZvZBtpwesIarZrv59ZPVYqrh6AbQzKSHaF/6fjNAU+Lpf2d7xA55lSGbX7mhf5XUuQmHCaRSQzLQO8fKRhkGcDiGn9C/T0yIKhX9Wd4jbGV8EGTIfYiFqkyRDAAL1AebwaeeR2v2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708681853; c=relaxed/simple;
	bh=CH/athNNCs7W93TaqmWZwdOkjOtZoS0EuyIz4P0rkgg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Bo7yx+GEJnWq+2uyXrfcrsqc6qS5LBYTBijsmvA52kgy1Tsx/3NHb6TF228dwtB9YnDLXX9l+l9yKbqTVHA3vwPlMOl0eKETtF625Vnrv4stLz6mb4fQiFg5LgKoFbXArRM72XycCs4RGIpdgebVqU6fiOTIrQlSCwJFQRtzkB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1vu0rbpM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8oW4AbDC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708681850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CH/athNNCs7W93TaqmWZwdOkjOtZoS0EuyIz4P0rkgg=;
	b=1vu0rbpMdHDB9ZNbu1Ou5qhkEM1KhPAuJXxw3TKKw4e9Uxtu1RxEojcRFJp3xwHqVQlY17
	XlXpDRIALrxImAes2XLoBspZ1+TsKoTwTjcpiq8NJn9OYC8N26MbeDitaqF/PfN78anp6/
	0T87YY6/NcmBFsqEUSty8T6O0DGSZf4nCQg1t+ginJyOEx1iXo/yNJDNXe7/fGxIg7Irks
	ybxh8oS25mSnDp1UtE3duKGEMW7G16qRrTpBu86iiU6/xAHoexUXSRafHHq7MqmPsfd+os
	BZKG/c81XEYmqq1m26TPrzy+5vL3xtClICKas7ySceNLJdJLG8Qm/MipfdNTSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708681850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CH/athNNCs7W93TaqmWZwdOkjOtZoS0EuyIz4P0rkgg=;
	b=8oW4AbDCwGqyI+9FF1LRK/2iPFSScjI6/JyI+jt/b+9T9qpf8baZbQETd3+nviZ/ALl+yQ
	xnAWvJtS6oDFMRBQ==
To: Nipun Gupta <nipun.gupta@amd.com>, gregkh@linuxfoundation.org,
 maz@kernel.org, jgg@ziepe.ca, linux-kernel@vger.kernel.org
Cc: git@amd.com, harpreet.anand@amd.com, pieter.jansen-van-vuuren@amd.com,
 nikhil.agarwal@amd.com, michal.simek@amd.com, abhijit.gangurde@amd.com,
 srivatsa@csail.mit.edu, Nipun Gupta <nipun.gupta@amd.com>
Subject: Re: [PATCH v8 1/2] cdx: add MSI support for CDX bus
In-Reply-To: <20240223092447.65564-1-nipun.gupta@amd.com>
References: <20240223092447.65564-1-nipun.gupta@amd.com>
Date: Fri, 23 Feb 2024 10:50:49 +0100
Message-ID: <87y1bbcxvq.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Feb 23 2024 at 14:54, Nipun Gupta wrote:

> Add CDX-MSI domain per CDX controller with gic-its domain as
> a parent, to support MSI for CDX devices. CDX devices allocate
> MSIs from the CDX domain. Also, introduce APIs to alloc and free
> IRQs for CDX domain.
>
> In CDX subsystem firmware is a controller for all devices and
> their configuration. CDX bus controller sends all the write_msi_msg
> commands to firmware running on RPU and the firmware interfaces with
> actual devices to pass this information to devices
>
> Since, CDX controller is the only way to communicate with the Firmware
> for MSI write info, CDX domain per controller required in contrast to
> having a CDX domain per device.
>
> Co-developed-by: Nikhil Agarwal <nikhil.agarwal@amd.com>
> Signed-off-by: Nikhil Agarwal <nikhil.agarwal@amd.com>
> Co-developed-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
> Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
> Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
> Reviewed-by: Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>
> Tested-by: Nikhil Agarwal <nikhil.agarwal@amd.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

