Return-Path: <linux-kernel+bounces-144805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C00668A4AE7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0B9C1C2160D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E9F3BBC1;
	Mon, 15 Apr 2024 08:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LNOp/XEF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A073DBB3;
	Mon, 15 Apr 2024 08:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713171262; cv=none; b=YBfAbVwxi3/nR9AXM4erIJXTrqhe0ulszYuEBAcj4hCOtQufOIZaZo8EcX7pZlGiDGwCAh/eUDO0xHDuMRx99bkh40fRJVVBQ1oqyIB9aStOcyEswjdmL+Mwgc92EyVNeHwTDTNdLA5NL8xYb3+72QmRbr1w7GbmYeeuZKm7DJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713171262; c=relaxed/simple;
	bh=d9f0zzycMk8FolwGEZh4k9sAUmS3fGw0FkwVSzCwe20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pKKniEzSpXbfUKxge4uhn5TmVlJryMB5DMYm4jTWqNuwU7JcJRLPU6S8sh+mmgqcEPziV3lp5M7r53dvqkMBe/jbSXl2G5x8T858J5bwfUeLFE6QgnSCGVLXCB2BvWOCu1VylkxPO+aPq6ous0GAvQPDKlqNedmEV4deZ66lBts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LNOp/XEF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AD59C113CC;
	Mon, 15 Apr 2024 08:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713171262;
	bh=d9f0zzycMk8FolwGEZh4k9sAUmS3fGw0FkwVSzCwe20=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LNOp/XEFmMwN2clilfH0hFvFqUH0Q13JXuuVhayJhpaC3PujkYT0TLUGeAt/9PmAU
	 Uj+tiv4pAFAHMlBrGG+eczeXpCjJE3VizCn1DUfA5tdqHAt7Z7QIUcl9Ct0BcX6Qeu
	 8zo1z2fVJFr9qJSyNJh1i/EvfcEom61bwq7xtDq9Ktowt/0XHqf1VF7TjVDAq1n+zI
	 Xg5O9e8LE48JcofmTSTzllqYCvVZn3lnzLZoG4BN8WLUML/tAVRU3iL/fz/+Q7IeP1
	 pWQ7VpKL9IrgDXgcftIy+4nRI7Lwtk3bDWsunwKY1ppOMT1sD3Q4xf/CP+S6VZLZbv
	 72fVwat/wd2jw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rwI6W-000000007XJ-08eY;
	Mon, 15 Apr 2024 10:54:20 +0200
Date: Mon, 15 Apr 2024 10:54:20 +0200
From: Johan Hovold <johan@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/52] USB: store owner from modules with
 usb_serial_register_drivers()
Message-ID: <ZhzrPA1wP7bER6Pi@hovoldconsulting.com>
References: <20240328-module-owner-usb-serial-v1-0-bc46c9ffbf56@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328-module-owner-usb-serial-v1-0-bc46c9ffbf56@linaro.org>

On Thu, Mar 28, 2024 at 11:05:38PM +0100, Krzysztof Kozlowski wrote:
> Merging
> =======
> All further patches depend on the first patch.
> 
> Description
> ===========
> This is going to be a bit of a patch-bomb, but with trivial patches, so
> I think it is still acceptable. If it is too much, apologies and I will
> solve it.

No, sending 51 trivial one-line cleanup patches like this is not
acceptable.

This is just one logical change so squash them all into one patch for
the entire subsystem (i.e. this series should contain two patches).

> Modules registering driver with usb_serial_register_drivers() might
> forget to set .owner field.
> 
> Solve the problem by moving this task away from the drivers to the core
> amba bus code, just like we did for platform_driver in commit

"amba" copy pasta.

> 9447057eaff8 ("platform_device: use a macro instead of
> platform_driver_register").

> Krzysztof Kozlowski (52):
>       USB: serial: store owner from modules with usb_serial_register_drivers()
>       USB: serial: aircable: drop driver owner initialization
..
>       USB: serial: xsens_mt: drop driver owner initialization

>  53 files changed, 12 insertions(+), 75 deletions(-)

Johan

