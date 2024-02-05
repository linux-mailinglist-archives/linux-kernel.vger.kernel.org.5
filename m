Return-Path: <linux-kernel+bounces-53593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDEB084A5CD
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8801C28B12A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 20:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55628180CDC;
	Mon,  5 Feb 2024 19:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OYtC4qzV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F0215836A;
	Mon,  5 Feb 2024 19:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159838; cv=none; b=bxKcndEf4585UQtUURqcZe5Ukr+9EIykI49KVv7fzbCsnrs8Aab5QCJTJa335EHTmhlQZY7Krg5uNcjwiLGVfqm2k1+2nw9tDGeaRjnSFoGFL/qayG42rwobS+JgS/LG4iQukDcZagr8Q1t18nJjhs2KiPjeI6BfduNyW5vnv8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159838; c=relaxed/simple;
	bh=JS0rLE0gDCoPrvmO8t1oRrM76E6Y2uXxbFDJB1HChLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ETMfla1PC7xOURVwbUGxuX3suPT5Sun4bcEXUM761ySKpEnOnmsvkaGaRCg5YpI/e35jNaSpjiA3VTh4lLbAHRRs0zyNlCu6ipXbuh5/pk0pkYFIVu0z4RwTq/GPbb1KcGuiBEmTmdXPNCzEFAQnZfH3PWzNucQhQDAUMNmQjpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OYtC4qzV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99B98C43609;
	Mon,  5 Feb 2024 19:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707159837;
	bh=JS0rLE0gDCoPrvmO8t1oRrM76E6Y2uXxbFDJB1HChLU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OYtC4qzVAJJ0+5qY2hUJ6GJJWJHtzEzSlHt9qA5wK6tO6Idogan95OMqWyvW2m20G
	 W3ZjUsqBwJenxE4LrPEwNfvU/sBhNGbg6oKh3jZIgA35A35E0wQ3vfz8tj2qw2Uprq
	 bFQhQIXPRbqBwjLEujdkQULXI0Ar62yMmMg3WZq8=
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

