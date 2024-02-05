Return-Path: <linux-kernel+bounces-53602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A24184A5D7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3D5B28B772
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 20:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72010183302;
	Mon,  5 Feb 2024 19:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="H6mBj4p0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF2C15B4C5;
	Mon,  5 Feb 2024 19:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159839; cv=none; b=V3xYGnkmufIIlvDt7crUOLk9eVWvvqqH0bUKy6A2We5G6jtCYW0V5bN4YVVmxis3cgCp66isfiP4dLxo/Ee7iIOuXFBOGFhGfFcpFprj+5z85a1xLOyDcPtDCu0G5Jvfkj7Co4F1Pxwh4K0Y76dHW6k7wTXgUW42vbB6OBIRHuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159839; c=relaxed/simple;
	bh=JS0rLE0gDCoPrvmO8t1oRrM76E6Y2uXxbFDJB1HChLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jViIM5+9ZUhXhr2YaMlOmX33V5sIHVCOT5ErtxqBJ04GURJ+yqaXJmGsfJz1uBSxfhbYfpbUbxH4UzMjw8Jki2iz7FnplWk7D6k8YNzi8SY3Et5rbs0p0GrSNY4TyLE4eSKfC6R/wNGrwRmf8bcql2JzWFrm8fw/j1uqe2K5h9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=H6mBj4p0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89324C43143;
	Mon,  5 Feb 2024 19:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707159838;
	bh=JS0rLE0gDCoPrvmO8t1oRrM76E6Y2uXxbFDJB1HChLU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H6mBj4p0eZ8ZO5IHwibE7/ibG4dpevzChSRCkLFui91PHFomONcpj+dbRWmqf8syP
	 j0tVZyOzcCeSTHxpuWTMEDbgrjOzgXg1Ovcq6T3q5iggY+yN8PNSUT2ttUn8TmziJa
	 m70tmYSIyQNbzkPaIHXGZbLoSsv1pywfjTd+lcuQ=
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

