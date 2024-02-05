Return-Path: <linux-kernel+bounces-53321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA8C84A351
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 20:15:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5F1A1F25F63
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6DAE605CD;
	Mon,  5 Feb 2024 19:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="z71oNa9U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2CD60246
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 19:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159792; cv=none; b=DepBSoANjH/MqYvmv4MGQRXY69CtrD6OXppa7bVBTrJv09TCnQBew7mgZZbrBnARN6iOR0WShvc70/1y/8L5sL6vCgZVjve3xpyLpN80E8d7++ujeoGPMQkn9zRZAxMShFEkuekthNWQtb5kfqumXJAcHSxLJBnQJIB+2So2v68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159792; c=relaxed/simple;
	bh=9JYun6OKHv+kvMP09/1pbBtaCNVt/H2fMIxp02ZsbXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PGA+dH5yKs5OWOJu0CMUSisqrrtSB2Vk+9EHMvZSi4bDo3tay4iMqJhy/EEZnlTZpabgonxH2aTXb3xVDz+ID4k5dv2W3JCZaYAwbkDNTC8BoBiXFwvKt4g+2RzzzBzD9jWiHWNYRlmKd3G/LcH90nzq8sXfrTR4Z29+g6NHgYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=z71oNa9U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E28BC433A6;
	Mon,  5 Feb 2024 19:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707159791;
	bh=9JYun6OKHv+kvMP09/1pbBtaCNVt/H2fMIxp02ZsbXs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=z71oNa9UgaJ5Krqox2ruzV60X+8OX2UfQyYFOR4N+DjkHuBYsuyEU9uzm0NCWx2uR
	 msvvbUIxvKf3k+8XTBYkhKqxPtwfIrMufyYsMqN9jgb6mvEAF8caAzM+qfAUZ8MJXh
	 STRxSVwzezP1icdloB9JR0/2dV27cov00pFGahSU=
Date: Mon, 5 Feb 2024 04:46:53 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spmi: make spmi_bus_type const
Message-ID: <2024020549-lapel-swipe-2c91@gregkh>
References: <20240204-bus_cleanup-spmi-v1-1-ef7f278f1987@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240204-bus_cleanup-spmi-v1-1-ef7f278f1987@marliere.net>

On Sun, Feb 04, 2024 at 05:38:38PM -0300, Ricardo B. Marliere wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the spmi_bus_type variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

