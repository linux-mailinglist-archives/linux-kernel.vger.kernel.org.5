Return-Path: <linux-kernel+bounces-71986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B70CC85AD75
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 21:48:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FD2E1C219B1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 20:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26109535BE;
	Mon, 19 Feb 2024 20:48:38 +0000 (UTC)
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72EC1EEE3
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 20:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708375717; cv=none; b=m0Kq12H6iQ5oXr1J3dBefqa7jaItnu4qUWkTfC4to9jcVSezB+v0qsFbxZeChL3iA6Hkkky080T2hvdfJ7f/KN+Q5o2twDZ+s3Fv6e2fxBnORmnC0KHZijmEnSvP/PJeEI9MjB6EGOFhQ4F7ejyXF0sofJT/zJDSKQmcfG6IEgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708375717; c=relaxed/simple;
	bh=hsIQy+euu5gHabYwqp91w8v7ot17RD1Hbvntagxcb4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oUQ+kuuAk/rNz7K4YVtFHwXVepOuN3Hlzzls4A01LgXV9Jfu/ISjJls1cYE6aOCqIB8AEA1+/DrTZndShv9Jk+pw/vJaIwO8tRHOwcq+Smqw6GDF/MNV2I/iTlfpEbpOVX8b0FMldkH4eBVtrBdMBGxMPFTypX30u+2QBPxBwsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 41JKmLNZ017647;
	Mon, 19 Feb 2024 21:48:21 +0100
Date: Mon, 19 Feb 2024 21:48:21 +0100
From: Willy Tarreau <w@1wt.eu>
To: Rodrigo Campos <rodrigo@sdfg.com.ar>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] Misc fixes for strlcpy() and strlcat()
Message-ID: <20240219204821.GA9819@1wt.eu>
References: <20240218195110.1386840-1-rodrigo@sdfg.com.ar>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240218195110.1386840-1-rodrigo@sdfg.com.ar>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Rodrigo,

On Sun, Feb 18, 2024 at 04:51:02PM -0300, Rodrigo Campos wrote:
> As requested by Willy and Thomas[1], here go some more fixes and tests for
> strlcpy() and strlcat().
> 
> The first patch just fixes the compilation when the compiler might replace some
> code with its strlen() implementation, which will not be found. Therefore, we
> just export it as that can happen also on user-code, outside of nolibc.
> 
> The rest of the commits:
> 	* Fix the return code of both functions
> 	* Make sure to always null-terminate the dst buffer
> 	* Honor the size parameter as documented
> 	* Add tests for both functions
> 
> All has been checked against the corresponding libbsd implementation[2].
> 
> Let me know what you think ?

This time everything looked good to me and I queued them into the fixes
branch since they address a real corner-case bug. I finally decided not
to change your comment for '/*' on a single line because it turns out
that the file in question almost exclusively uses the shorter, net-style
comments like you did, and you were probably inspired by the surrounding
ones.

Many thanks for your work and your patience ;-)
Willy

