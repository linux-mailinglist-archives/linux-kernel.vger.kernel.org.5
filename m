Return-Path: <linux-kernel+bounces-53583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2ED684A5C0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 514F11F27B63
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 20:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E44317ED5D;
	Mon,  5 Feb 2024 19:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wRYGX71x"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB85814D447;
	Mon,  5 Feb 2024 19:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159837; cv=none; b=tMAQEW7+MLbcmjZX1YnPC9D+Ghw8H2so9mNohTB+aD7EWJr84O0CFWrERXyIueye/5A/OhkXJdD5wHF6TX+q08NJV9whZT+JMTmANh+knHk4dsQPIQ9Jgpq5Gd3gZ8XGY0s40rRu012GeYYVrRyeVvdUfOASPXcW5IqBqKSuPQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159837; c=relaxed/simple;
	bh=JS0rLE0gDCoPrvmO8t1oRrM76E6Y2uXxbFDJB1HChLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AF4dSB0jOOeC6MUK55e0yVCE9XUbGdrvgI5Z3R89ELcp1Fa6Wg98u1/i0TZuuRNx1wiOSFo8LyL0c18sfQkSscL9hj8g9fDX8u6gsQpXcGQsk7DB7HJHnYoXeHk84jxFUsk1rrUkSEwCC1SLprtyZgmdVWFR9onGJ8gGAXdH2/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wRYGX71x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DFD4C4166D;
	Mon,  5 Feb 2024 19:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707159836;
	bh=JS0rLE0gDCoPrvmO8t1oRrM76E6Y2uXxbFDJB1HChLU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wRYGX71x+SOJrlrWZUzkzjVusSLzPVtYCKv8DvOJLwZ41gLPWr/ZZWGTasYcOqdXP
	 n26h0x6e0KdfJMcza1dggXXKBGdBAL5NzmKw5fsKGsftrNN4X/o7Yy1DbvP2OSgIvN
	 c8DqZq3w+mcpKnt2gJaVWOuvRvzPMC+j2NOp06lM=
Date: Mon, 5 Feb 2024 04:50:30 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Tzung-Bi Shih <tzungbi@kernel.org>,
	Brian Norris <briannorris@chromium.org>,
	Julius Werner <jwerner@chromium.org>,
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: coreboot: make coreboot_bus_type const
Message-ID: <2024020511-confound-chirping-38f7@gregkh>
References: <20240204-bus_cleanup-firmware-v1-1-d1bff946606d@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240204-bus_cleanup-firmware-v1-1-d1bff946606d@marliere.net>

On Sun, Feb 04, 2024 at 01:10:18PM -0300, Ricardo B. Marliere wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the coreboot_bus_type variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

