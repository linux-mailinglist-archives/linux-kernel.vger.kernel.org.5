Return-Path: <linux-kernel+bounces-61368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60FB4851177
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9205F1C22E5F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 10:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4028939AD8;
	Mon, 12 Feb 2024 10:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GKzShdse"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7658138FA1
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 10:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707734749; cv=none; b=aufQ2bM/jQjLVRJyzEDeeQOvH4goEzB7NC9T8aJ0RqTsM9gEd5FXDT5vrhMEYlfcpmn/a56nhclJKa0AwWer5KBOGAPBtV4zStn792Wa4BkBVkRwGF8pQS2dcbSMuxgxIaBqzrEfg1OtZTdy+5P4JQDm5t1uY+QTzd2jz5oBVeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707734749; c=relaxed/simple;
	bh=BRFpUnq4148MioG1AC1d4qj1hPHEOF+Rac7kCKLRavo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B8BvdknrzGaJMJfBKomut7b758WuuWhH8EBle3e8xYQU7+B4g8Od6kGWoZbjLhnZZyQXl93HvV5FA2OcPBQHTqP3/3TIAWJl3dqFF7jcwe7l3clkQT0iTjCNEJCViwRfyZo5gsuasV87FsE8pGzwODR5c1zo7QrN5Mrv/Alc/Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GKzShdse; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FD98C433C7;
	Mon, 12 Feb 2024 10:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707734748;
	bh=BRFpUnq4148MioG1AC1d4qj1hPHEOF+Rac7kCKLRavo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GKzShdse5//Phd4LZjWVRbH7tPOZLTkMuEQVEVhfq1gJUyIZ7j7XgytOeMf6dJ/PH
	 kaM5qZP1Dkk1C+BgjwCoI0VlMkLCOntOP+9w4A0kytNHRGbZIkRNRbx6qdZdfYgHnH
	 wNTLQ+VgbDdk+lZs/GFekLXsCWz7n79lAMlWHT50=
Date: Mon, 12 Feb 2024 11:45:45 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] ARM: struct bus_type cleanup
Message-ID: <2024021241-cussed-suds-ffff@gregkh>
References: <20240211-bus_cleanup-rmk-v1-0-65668e578d55@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240211-bus_cleanup-rmk-v1-0-65668e578d55@marliere.net>

On Sun, Feb 11, 2024 at 12:45:06PM -0300, Ricardo B. Marliere wrote:
> This series is part of an effort to cleanup the users of the driver
> core, as can be seen in many recent patches authored by Greg across the
> tree (e.g. [1]).
> 
> ---
> [1]: https://lore.kernel.org/lkml/?q=f%3Agregkh%40linuxfoundation.org+s%3A%22make%22+and+s%3A%22const%22
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> 

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

