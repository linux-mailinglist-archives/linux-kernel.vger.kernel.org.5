Return-Path: <linux-kernel+bounces-51703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4845848E62
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 15:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D19F1F22210
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 14:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83C51E51A;
	Sun,  4 Feb 2024 14:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="C1Ep+fA6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF924225AF
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 14:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707056716; cv=none; b=fd99ldUIEpydAOcvRSqmlT2g95TJTqh2TLfZ5/y9DikIPFPWG/GFYv8hiqVAmG+LfjH9xRX/Cm1mHLZ8wL0/3EsZkqgU95OjJ2sjAfx4yRXgrHymV0uW9dSqmghy1B9Hf0Ql0tD06eH5IOzr5n9quGhJi8WUQmMxhOjLqVhjZGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707056716; c=relaxed/simple;
	bh=NT2XD6VBdb8OEYy7TvFvZRbiB/tRZCdf4w4GaiWgFFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T9LWLyRjErDgbr0WF+RX4XCQPTTAyjpWnMkvORGE4L6tgiswZWB7wtmX/A93S2eG8/AgF+7QMlfbjxXIa5ErbnYshWk7HffNLVxzE8Sz0umVhiOo0Ki4yMAghQGOkwwO2ZwDCGfuWVtFlX2DcsLsxpwltZgkJblD/smCwhZWIWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=C1Ep+fA6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C9F5C433F1;
	Sun,  4 Feb 2024 14:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707056715;
	bh=NT2XD6VBdb8OEYy7TvFvZRbiB/tRZCdf4w4GaiWgFFY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C1Ep+fA6AEjzFpuW7IjoH6/22U9qScN3znf0WP0U5sFNtF1QpVDJPMZcj3VVFpEz/
	 +zdekJbJ7N0dGg7QI0zJ6dA9fQbGYQFsbA/4KcFae0hD9mpI6Mrzzzou+BBymxH3G3
	 VeFXnq1x/Kqu5JF1fj6ji7t5ztg5bztdCdKNHWdI=
Date: Sun, 4 Feb 2024 06:25:13 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>,
	Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] time: struct bus_type cleanup
Message-ID: <2024020403-generous-trifle-6e63@gregkh>
References: <20240204-bus_cleanup-time-v1-0-207ec18e24b8@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240204-bus_cleanup-time-v1-0-207ec18e24b8@marliere.net>

On Sun, Feb 04, 2024 at 10:40:14AM -0300, Ricardo B. Marliere wrote:
> This series is part of an effort to cleanup the users of the driver
> core, as can be seen in many recent patches authored by Greg across the
> tree (e.g. [1]). Specifically, this series is part of the task of
> splitting one of his TODOs [2].
> 
> ---
> [1]: https://lore.kernel.org/lkml/?q=f%3Agregkh%40linuxfoundation.org+s%3A%22make%22+and+s%3A%22const%22
> [2]: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git/commit/?h=bus_cleanup&id=26105f537f0c60eacfeb430abd2e05d7ddcdd8aa
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> 
> ---
> Ricardo B. Marliere (2):
>       clocksource: make clocksource_subsys const
>       clockevents: make clockevents_subsys const

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

