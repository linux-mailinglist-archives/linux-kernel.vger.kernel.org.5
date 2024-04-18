Return-Path: <linux-kernel+bounces-149396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D47B8A9097
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 03:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05D6BB21CD5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 01:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9704EB36;
	Thu, 18 Apr 2024 01:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f9ZfRgc+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AF64AED6;
	Thu, 18 Apr 2024 01:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713403487; cv=none; b=bXx/UX/CuvNlyyO84iil2j0/qL2TBdh7fYNO3fTYE2115s4rc0MuyXT/Ny4sIVwEmDazDMHxWkbYbjpXRtp1/a7Foif5ZxL7UI3Um/BOcojzTlQYwjeGMTV5hAvM627RMACNDtzGEZk6kek865VGdEAC+YwKkzv68diO5bSh2wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713403487; c=relaxed/simple;
	bh=drxJSdAcZeC/CUWvT5J1zYNMdGOjJPjzTzBsfHrC6Ic=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZVqsBMg6iWO2DdPjL1z7Inm6j/55Lx/eAeVTWkT9mkxMaOYuo9+e5EaQC3rVms4s9udw2NU1daPuO7wLqHyZjK+NBhopHx50/bvU5KNAr1BjVB0J9D+qxk/QHhH1caMkFLu3Xgo4XHkuX0m0V74nXBur5+lh53YGRy6qcfKWcNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f9ZfRgc+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42F0AC072AA;
	Thu, 18 Apr 2024 01:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713403486;
	bh=drxJSdAcZeC/CUWvT5J1zYNMdGOjJPjzTzBsfHrC6Ic=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=f9ZfRgc+DbHZFe5T8NopRGRaF/eXoFQEgr17C46wdynJEJgsWAjMQb+KvThPwKfmk
	 MJU1gaJHjiNsFC9ZE+wHxatQY1a+6zZlEARai+twc7Yi2rrKQCAQILONTrTss+jwK3
	 0jqxZjN5iOs707x83Eyu/q/LtRm6OXCsKnVgVAltfeMFREcth7NVRSceg560dhB55g
	 ZsUiAJ1YvObFTvBS7TeX9yu01vZ9M7HBz1eTK3ejttMyvFWwRd4HaxeEoQQrC+HlWS
	 FcqdVox9OASlkFg636eOp1vdimTqDXFOx/b3vZbwdDy00L6STk7nzfeJAqlMIw9Y8O
	 wfADOj4fEM5CQ==
Date: Wed, 17 Apr 2024 18:24:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mahesh Bandewar <maheshb@google.com>
Cc: Netdev <netdev@vger.kernel.org>, Linux <linux-kernel@vger.kernel.org>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 Richard Cochran <richardcochran@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
 Sagi Maimon <maimon.sagi@gmail.com>, Jonathan Corbet <corbet@lwn.net>, John
 Stultz <jstultz@google.com>, Mahesh Bandewar <mahesh@bandewar.net>
Subject: Re: [PATCHv1 next] ptp: update gettimex64 to provide ts optionally
 in mono-raw base.
Message-ID: <20240417182445.019fb351@kernel.org>
In-Reply-To: <20240416215942.150202-1-maheshb@google.com>
References: <20240416215942.150202-1-maheshb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 16 Apr 2024 14:59:42 -0700 Mahesh Bandewar wrote:
>  		if (extoff->n_samples > PTP_MAX_SAMPLES
> -		    || extoff->rsv[0] || extoff->rsv[1] || extoff->rsv[2]) {
> +		    || extoff->rsv[0] || extoff->rsv[1]
> +		    || (extoff->clockid != CLOCK_REALTIME
> +			&& extoff->clockid != CLOCK_MONOTONIC_RAW)) {

Since you're touching this condition it's probably a good opportunity
to fox the coding style.

