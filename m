Return-Path: <linux-kernel+bounces-53495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9216B84A4A1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 20:58:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C431C1C213FB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B200513A872;
	Mon,  5 Feb 2024 19:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Pzp5iMs2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A956413B2AA
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 19:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159825; cv=none; b=RBbtL1rTB04XQcPCT+S4Z31m8YZAS51AQJua/lTwQt4yyOTRO45pKqtjPLrD5fz6H48RDqH+d/abCPQ4A9ZuhJ14EskxMtDW0lGy87e2W0gI8nGXKoqpaKMfYkJA4+XoLXfcQqXoz0XqqUo9BXJWPnAVbZcY/LO1/3g7BdN3Nrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159825; c=relaxed/simple;
	bh=GXjD/rRoFrhMHi5VOUmupIgP5YWbLXkneuejfG8wT2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FWyAqJScrp6iNKQ4lr6iP/13K8V66+TZUELC7tWje+eGDFPfUZ/g6eTYJrljsiJJFtH5mG3UNS3TN3cY0Z62LQxlwbBiQPS3n+gS8dJe3Y4aHeDzIXpg0UawOF1vtY47JkJJdc8S95AMAgtEGGMxIYYqLmuloBdcLcEhgqS3uVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Pzp5iMs2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A84AC43142;
	Mon,  5 Feb 2024 19:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707159825;
	bh=GXjD/rRoFrhMHi5VOUmupIgP5YWbLXkneuejfG8wT2Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pzp5iMs2KqdUObWfpjZDisXPnshAsKebopJB8cgkbIxuLd9mwax/Gu+s3wvWbuAzz
	 dgGdGOCFMbgb0DPf0hqMVKsmUY1rdFraI+W+L/EirGNT8xgLANFnUOEf1yj/Qnqlgz
	 d/A1JVji/lV8svQx7LMv7+muEZkmORTignxBaAJM=
Date: Mon, 5 Feb 2024 04:49:19 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] intel_th: make intel_th_bus const
Message-ID: <2024020515-refinery-audacity-1d5d@gregkh>
References: <20240204-bus_cleanup-hwtracing-v1-1-23adbf4e6bb5@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240204-bus_cleanup-hwtracing-v1-1-23adbf4e6bb5@marliere.net>

On Sun, Feb 04, 2024 at 04:52:18PM -0300, Ricardo B. Marliere wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the intel_th_bus variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

