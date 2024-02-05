Return-Path: <linux-kernel+bounces-53319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D49B84A350
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 20:15:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8093C1C24488
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD6560248;
	Mon,  5 Feb 2024 19:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="z71oNa9U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329385FDAC
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 19:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159791; cv=none; b=YOl0yFhDlXELC0UfOUHQURGCaKZfvmh1T66MOEb02/GpPCDz1JZvwtMYM0hUaLFgdwM5WHFAxE6cXiqNg4R8sVVCbNDbPlp0RC2ix/v4Rig0fp/fa6T6D/JRCQ1WnKOdbxBvz0K1Mg5Eb/y8e2yNgPRjveIMnbYM5GDzsOPTbrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159791; c=relaxed/simple;
	bh=9JYun6OKHv+kvMP09/1pbBtaCNVt/H2fMIxp02ZsbXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RgWF+bGQkyb0Ut//pjQWxLtrQLXXW32IhcrF5E0onJZRo8C/o3sfnAVK1Srluw9bLe9pwIG+sf3/FUKhJrHoKGPDetmWNBpg3oDWm0tn5i3MqZ9hx1uM5cp8/2Ovx9ULzFZ8kVyeOyw/ZfQbEvtDpQ1klAr55LmyPmAY5Ok6tRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=z71oNa9U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84935C433C7;
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

