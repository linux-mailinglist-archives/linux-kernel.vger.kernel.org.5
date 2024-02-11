Return-Path: <linux-kernel+bounces-60710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4485B8508C2
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 12:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEF551F22173
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 11:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28C35A4CF;
	Sun, 11 Feb 2024 11:14:42 +0000 (UTC)
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978B22E3E1
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 11:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707650082; cv=none; b=ilkWGG+UV5DX8Eo5UDX9AFd/U84aembV2tGqeNqtXYPtLtgUwmbjlG0Sj1dqiKgPo3oS/6t2rXHySGeGl36wy5V01kXjFCpoyKW4Ag5xWH4wn9K17Il3Ba5t+QsDrtVb5QFBrXAR+k2yZyldBA3x5nN+4wXLPpzfrTFb2+gzsaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707650082; c=relaxed/simple;
	bh=/NK2rkSevT7xLFFZVOCMtCYxdFNbLxRJj3xSbCjTgr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t4eGmJiReBaNvQHhVSa7DkC3ZFZmsS50nj6QfsfnwC1RBA+aX5VI/FWlZ6LfQQ2sHe9eYblnlON5LnLZj+QM3WsRMxqKh3w65aYc1WE6X13gz7CK8peKSk3GNVvxkNo4RgBhK+gBjWFs7iPmzHBFtxdmeNHxu32796XEYUN186Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 41BBEanQ022162;
	Sun, 11 Feb 2024 12:14:36 +0100
Date: Sun, 11 Feb 2024 12:14:36 +0100
From: Willy Tarreau <w@1wt.eu>
To: Rodrigo Campos <rodrigo@sdfg.com.ar>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] tools/nolibc: Fix strlcpy() return code and size
 usage
Message-ID: <20240211111436.GD19364@1wt.eu>
References: <20240129141516.198636-1-rodrigo@sdfg.com.ar>
 <20240129141516.198636-4-rodrigo@sdfg.com.ar>
 <20240211110814.GB19364@1wt.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240211110814.GB19364@1wt.eu>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Sun, Feb 11, 2024 at 12:08:14PM +0100, Willy Tarreau wrote:
> And I think we should explicitly mark
> strlen() and the few other ones we're marking weak as noinline so that
> the compiler perfers a call there to inlining.

So actually the weak argument always prevents inlining from happening
so this is not needed (I didn't have it in my previous test).

Willy

