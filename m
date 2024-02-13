Return-Path: <linux-kernel+bounces-63397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A90A852EC7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B33521C21C4D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75D8374CF;
	Tue, 13 Feb 2024 11:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M+6A+gST"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1877A3716F
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 11:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707822443; cv=none; b=DdW715hPT/TgB/IJh1TTKZyENjTDk33ElKZUU6t2w0bgUqvUBiN2mbwKEyimb1u5/Q6pSNCQBMZmeAMxxIzebh0soyLKlJC8vPZt5KaH2r5QEEq9qgr0Kulida/RjNH4jr99kXRJfJaDCYqxpRj3k8xx6D2HhhYlPXMqcQKbhA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707822443; c=relaxed/simple;
	bh=SqunHtrvFwYnQvIwCU1g/MQj1X7k63z6csH8PPzRGLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VMknFAcw4ER7LAFIdnlOXg0Y60AojUbOTaaVs+hqpy7A0hitrUqbzBFT1aUjqH5xTvHeuAx/zCVPUpbK4dpnmnA477ckgiKwokShbAhJY6mgWyMinl0z4nsekeeF4/9a0l/i5uYLVntilVmrgSvlJzbI9nrjbKbsycAHVoQ2kQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M+6A+gST; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 038E2C43390;
	Tue, 13 Feb 2024 11:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707822442;
	bh=SqunHtrvFwYnQvIwCU1g/MQj1X7k63z6csH8PPzRGLY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M+6A+gSTyXvo+h+hOlshTqHPFA7I02qsemV1ENC2VWwWyI7uTuhKb5IfCyBCT8LhJ
	 4okjJfy7yqQYvVIcN9bD0krqsEjefu9tUchHtsy1N5D6OkqTdRu2vxYH4og1+2fIO3
	 TfspQq9npeeCU1oxaYUMYdJL+TVwEk250TKNLDCM=
Date: Tue, 13 Feb 2024 12:07:18 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dio: make dio_bus_type const
Message-ID: <2024021313-undecided-stainless-23ed@gregkh>
References: <20240212-bus_cleanup-dio-v2-1-3b1ba4c0547d@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212-bus_cleanup-dio-v2-1-3b1ba4c0547d@marliere.net>

On Mon, Feb 12, 2024 at 08:41:01AM -0300, Ricardo B. Marliere wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the dio_bus_type variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

