Return-Path: <linux-kernel+bounces-139383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 058688A0250
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 23:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 371911C2212A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 21:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B3618410C;
	Wed, 10 Apr 2024 21:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="M+Otz7iD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BNRsZNUG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3298E15EFAD;
	Wed, 10 Apr 2024 21:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712785371; cv=none; b=dtT0yv7YP87zjYlnzf+uRZTXS6fNZlDRg7gMjpVinh+3oW5InKGlMTO3IcspqnNdsOTOLVlEv+kaurF0ugYLjWAhZXA4u+m+BFbdV90i6Pf5yxsH7y4mOvZHWzg8e4sgKzSdvevGu2Ghi3fm79Jj89r411/pGlNPyOpCO9ZBh0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712785371; c=relaxed/simple;
	bh=RhSkWePUyKhvvxTu7bk/aMeNpx4MhLnzvc0rmPl5cUk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bYY0EfQcrUv9/nAApN2hECMYErdykr7SiUDJxEFnPKsWQsAcOgHh0CY+wt5Q4phTPs6qfP/Qc8hJvWbPTN1gqtDbtuUISrOJYUraJ7J1f6TEd89hUUT3+FOTPPnJTstnkBrSE39TQ9I2gdJsHRpm6meIDr0IQdSScEo+FInriDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=M+Otz7iD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BNRsZNUG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712785368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rdQoqdQaX1sN8iPEH6WMX2czg/lasITlEbkoOin2hhU=;
	b=M+Otz7iD2X7C7p2fY68ZTuik9R515LqrBKtqAZe6YCNUOZtN/nHgE7pYjhpf3qmDe6hDFw
	lbC792tw2Fw1wnHsCNbBwhqrTkIKTstTt0wZOWCZKueTtpaXQMPtHo3hzhpp9PdpK5/ShU
	37Wxw53BaVttssXwZ84yEo86NTI3R5FM+UytgoGXGfdGyPOBN3877MF0hzkFknridrK62J
	fEtKH1uG/GdsdioeORAfX3cAgfiXSGDRJzJYMiKFx5oKsZ++HiN5tUvooCVFF6cmkQazqT
	xPdcxkMqKv487i45rSFGLy8mF3bKj+iQcqLc8R66tyljSjI6byoJh07ylE1vHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712785368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rdQoqdQaX1sN8iPEH6WMX2czg/lasITlEbkoOin2hhU=;
	b=BNRsZNUG+yDoiRPlzWN5GV3sdRog8UFLhJTyU3KDRjgQQqg0buZ1FDEKyc7FWZDvPBQdhi
	1ljTRyGix0KZ1vAw==
To: lakshmi.sowjanya.d@intel.com, jstultz@google.com, giometti@enneenne.com,
 corbet@lwn.net, linux-kernel@vger.kernel.org
Cc: x86@kernel.org, netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, andriy.shevchenko@linux.intel.com,
 eddie.dong@intel.com, christopher.s.hall@intel.com,
 jesse.brandeburg@intel.com, davem@davemloft.net,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com,
 mcoquelin.stm32@gmail.com, perex@perex.cz, linux-sound@vger.kernel.org,
 anthony.l.nguyen@intel.com, peter.hilber@opensynergy.com,
 pandith.n@intel.com, subramanian.mohan@intel.com,
 thejesh.reddy.t.r@intel.com, lakshmi.sowjanya.d@intel.com
Subject: Re: [PATCH v6 02/11] e1000e: remove convert_art_to_tsc()
In-Reply-To: <20240410114828.25581-3-lakshmi.sowjanya.d@intel.com>
References: <20240410114828.25581-1-lakshmi.sowjanya.d@intel.com>
 <20240410114828.25581-3-lakshmi.sowjanya.d@intel.com>
Date: Wed, 10 Apr 2024 23:42:47 +0200
Message-ID: <87a5m03ne0.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Apr 10 2024 at 17:18, lakshmi.sowjanya.d@intel.com wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
>
> Remove convert_art_to_tsc() function call, Pass system clock cycles and
> clocksource ID as input to get_device_system_crosststamp().

This is wrong as this does not pass anything as input. The function is
called from get_device_system_crosststamp() and the data is passed back
via the system_counterval pointer. It also lacks context.

 Something like this:

   "The core code provides a mechanism to convert the ART base clock to
    the corresponding TSC value without requiring an architecture
    specific function.

    All what is required is to store the ART clocksoure ID and the
    cycles value in the provided system_counterval structure.

    Replace the direct conversion via convert_art_to_tsc() by filling in
    the required data.

    No functional change intended."

Hmm?

Thanks,

        tglx


 

