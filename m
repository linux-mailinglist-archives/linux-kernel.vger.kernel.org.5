Return-Path: <linux-kernel+bounces-62771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5713852584
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 02:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93672289DDF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D3A18049;
	Tue, 13 Feb 2024 00:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UrymaaAS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3704414277;
	Tue, 13 Feb 2024 00:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707785235; cv=none; b=Tm44Xoj9TnU0viyrKqBEiWC+9am9Ok0dVEVA7koQ/rJNmq61bc2JB6bNWLONRI2176MAmznN+r4QXhVcsUdO02AaMxJPfFpOtgkabc9e/U0HKF/Z2JxEETwt2BRl7ni5kklcGULZxxxbYkmyARilGl3r1rCn0A5+FUcSW07G3g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707785235; c=relaxed/simple;
	bh=SvBXqSXqx/IU2Uu/cVG0aL08ZmNuUmG+ampjAH8u2BE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LZ9cJ/rHuBzB6PthBR9bUh9Jx/AwHmyicBSWnE+TOWkoi0UjZE+mugEyIrnzR6IX241a/NAUvv6hwipMIQGWcmqrGY4w6nYQcrYmoFXbZKa4/1Pfw4xmomGwatXXUP3GdBNWRG7bIrKdDMO2WpGk3j9KMSv672rd8istQeWWhMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UrymaaAS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48378C433F1;
	Tue, 13 Feb 2024 00:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707785234;
	bh=SvBXqSXqx/IU2Uu/cVG0aL08ZmNuUmG+ampjAH8u2BE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UrymaaAScNyBE/rX+yMWMZQtDF016sykuUMpBIgJFmeldtduekgY+PpoXXvep71Vr
	 n34BVy0YPyBy2IuzNL/pg8lK7KiDhbPw4jHf+k1Kjt9p/rdQ5CSGPkhnTKlH27rr9r
	 E/uecn6/N19jXLxxLzrRmi35ZQtSzM6TAXjANtpz8LR2g08fmAu+IBdIMvuTuifLjM
	 UwVWsnWXa+Xbdwg8hIBTuKEHU1U+BBGSMQDuTmOmiIVA9xDX3Mc993BiTTzkOZByB8
	 D2JOpEVzLbzXaPOjKPMN9613HmsGhrb/IOp6q7dEeXTpM1NM4pCxzewPhmg9WBKwq5
	 vh8lAihme+N2w==
Date: Mon, 12 Feb 2024 16:47:13 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Subbaraya Sundeep Bhatta <sbhatta@marvell.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
 <edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>, Sunil
 Kovvuri Goutham <sgoutham@marvell.com>, Linu Cherian
 <lcherian@marvell.com>, Geethasowjanya Akula <gakula@marvell.com>,
 Hariprasad Kelam <hkelam@marvell.com>, Naveen Mamindlapalli
 <naveenm@marvell.com>, "horms@kernel.org" <horms@kernel.org>
Subject: Re: [PATCH 1/2] octeontx2-af: Remove the PF_FUNC validation for NPC
 transmit rules
Message-ID: <20240212164713.1ebd7fef@kernel.org>
In-Reply-To: <CO1PR18MB466623157B4EE9B2C04119E4A1492@CO1PR18MB4666.namprd18.prod.outlook.com>
References: <1707676587-12711-1-git-send-email-sbhatta@marvell.com>
	<CO1PR18MB466623157B4EE9B2C04119E4A1492@CO1PR18MB4666.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 11 Feb 2024 18:46:40 +0000 Subbaraya Sundeep Bhatta wrote:
> Please ignore this patch. My bad this is single patch but sent as 1/2.

Thanks for the heads up, but please keep in mind that "obvious mistakes"
are no excuse to ignore the 24h rule. 
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#tl-dr
-- 
pv-bot: 24h

