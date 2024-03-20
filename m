Return-Path: <linux-kernel+bounces-109145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ADB3881543
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 17:09:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BEB41C22D7E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 16:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B144E54BFD;
	Wed, 20 Mar 2024 16:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rmqTMWnG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB9A54F8A;
	Wed, 20 Mar 2024 16:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710950986; cv=none; b=R0dvnXXKh0o4QjF3nCUWWR1X2jpSMj58i0qqQmZP6D3/npJi2JZ7zlb/CX/d8wMd9VZDdjUNaHGblWCmxR29VErjbPFORrhmfj6a38BWEqlJNjG7smd5/skvbW9VGHpz5PkoPVu4twYEqTlc1r5W4BcTrHqsKsq/M+3/ptfl9oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710950986; c=relaxed/simple;
	bh=eElWcB41AoBcrw2W6dId5StcFH42yYRYig91JzcJ8qQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rBzG1FyVKkI+je9YiT7nIQo4tSdwUUzd2XtiQSZnyUE3gBZy5IB5WiOMgq1GoLiOZjMI+KKIaz0nvhVZcShVV+2f817KrOp51+V/2sHhCcSyNi/WxGwiMXJPGcW53I2/RSteJR8e3QwgkfiwEqprYXux5H0bgHSoU9W6IyJRzbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rmqTMWnG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69B65C433C7;
	Wed, 20 Mar 2024 16:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710950985;
	bh=eElWcB41AoBcrw2W6dId5StcFH42yYRYig91JzcJ8qQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rmqTMWnG3wf+0ACqT2qYY6cOhL1XEakoZB3MoiZ6kCRTdM7wPGnZqlDbki7KZReX+
	 fXNgYPhCRdxxCYkU59i4ZvQCWluxF2XtKaQKParMSlFiKrMCrVsqEATGOOaN9Sb1sy
	 e+hPcjWbB7oVy3CEFEc9SYharoPVcQ5UII1NQMX71rxBVyvSLhMsPLqjNfS/jXUH6A
	 5V3tkZ85nbAufQUswK8ZDlE5t00rJ/XuqYv9mQUZx6EMstW5wVsbDShcyUl8IXvqUh
	 tQN90NgT7fmBMrki+OnsQ7owNSN1U9yM0TUUyw0Z8LFt9URqOcCvnYzUfxB0Frpibm
	 bZpSuSGHSVuEw==
Date: Wed, 20 Mar 2024 16:09:38 +0000
From: Simon Horman <horms@kernel.org>
To: lakshmi.sowjanya.d@intel.com
Cc: tglx@linutronix.de, jstultz@google.com, giometti@enneenne.com,
	corbet@lwn.net, linux-kernel@vger.kernel.org, x86@kernel.org,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org, andriy.shevchenko@linux.intel.com,
	eddie.dong@intel.com, christopher.s.hall@intel.com,
	jesse.brandeburg@intel.com, davem@davemloft.net,
	alexandre.torgue@foss.st.com, joabreu@synopsys.com,
	mcoquelin.stm32@gmail.com, perex@perex.cz,
	linux-sound@vger.kernel.org, anthony.l.nguyen@intel.com,
	peter.hilber@opensynergy.com, pandith.n@intel.com,
	mallikarjunappa.sangannavar@intel.com, subramanian.mohan@intel.com,
	basavaraj.goudar@intel.com, thejesh.reddy.t.r@intel.com
Subject: Re: [PATCH v5 11/11] ABI: pps: Add ABI documentation for Intel TIO
Message-ID: <20240320160938.GV185808@kernel.org>
References: <20240319130547.4195-1-lakshmi.sowjanya.d@intel.com>
 <20240319130547.4195-12-lakshmi.sowjanya.d@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240319130547.4195-12-lakshmi.sowjanya.d@intel.com>

On Tue, Mar 19, 2024 at 06:35:47PM +0530, lakshmi.sowjanya.d@intel.com wrote:
> From: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
> 
> Document sysfs interface for Intel Timed I/O PPS driver.
> 
> Signed-off-by: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
> ---
>  Documentation/ABI/testing/sysfs-platform-pps-tio | 7 +++++++
>  1 file changed, 7 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-platform-pps-tio

Hi Lakshmi,

Please consider adding this new file to the
PPS SUPPORT section in the MAINTAINERS file.

