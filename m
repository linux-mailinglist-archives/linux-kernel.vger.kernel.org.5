Return-Path: <linux-kernel+bounces-69234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 015A885860F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 20:17:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFD34281ECB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD678136643;
	Fri, 16 Feb 2024 19:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sBB/HeoT"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001411350ED;
	Fri, 16 Feb 2024 19:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708111039; cv=none; b=e67cBdYr1NteFC7vtt9+qUi9RdbhZF4Sz+lpsKsq+uc0Gs8jOqzn1MoOFE2SGjhMalby7OVbQrReTMu6Wzws+ITKkJIV7mftUeTrlhvuobe+Ad67jCHguMwIv/VfrDEFv3UR0veDx067wzmNsgTUwu7VGmXG4uur7UsYJOk6lfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708111039; c=relaxed/simple;
	bh=qnVycgC6PT38wLbjka6ATJ/Q+9q7NmRau89BQzqRAjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YSoQrNqx58frxMhJUOda5bfgWb41FfgIhxIsWNV8wxoD6tk5bJb8j4TAfP8DXAZe+mkF+qnkPkeH57QdwB9eclfHctYWWOSt4dXwy5OKFRZOgrFQiBkDJb1C0u/PNm0GIjTntGscNq03yetiOFFHkVFU5SfPX6VGXQO6RqyNGyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=sBB/HeoT; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zm17Aa/JqozFDFprYkW1jzkLivImpQkuYJ6UV/JX6II=; b=sBB/HeoT+q+N1cJzi4ck5dQhg1
	YVIp/c8ZFZNKtqamLOtntvw3La2y7reLIxfgQeL2TWhtxe29i8iD/FJL3W/RqFi2AIrxpXjVd3CiP
	hC0PcwNRhQXVdXUT7ogVam/gKYRNUWPTnyEHAyGkwnjy1viCHVr1iepAro14pb/Fk5DDNvOSM78JF
	jfERmd9XkWTjLkXDAPgVADLjcz4TbYFsk9XdQiPNnNT+6XpgD5l+ZZ03aXr6wkk48i9MGhmvBDvQQ
	fjzGlhUBvPe49oqyz9Ay8BhWr+9W5kb3HicrlOIXMWp9Sflt1cZ2sz6YV7r5XAsPYkKbNEOhj+TJL
	IiDt5lTQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rb3i0-00000003TL5-0ctN;
	Fri, 16 Feb 2024 19:17:16 +0000
Date: Fri, 16 Feb 2024 11:17:16 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
	Kees Cook <keescook@chromium.org>,
	"linux-hardening @ vger . kernel . org" <linux-hardening@vger.kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2] module: Don't ignore errors from set_memory_XX()
Message-ID: <Zc-0vEqOvjnai8Dp@bombadil.infradead.org>
References: <21037bf38438a285f5dff9501668f1675bc45989.1708070781.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21037bf38438a285f5dff9501668f1675bc45989.1708070781.git.christophe.leroy@csgroup.eu>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Fri, Feb 16, 2024 at 09:14:27AM +0100, Christophe Leroy wrote:
> set_memory_ro(), set_memory_nx(), set_memory_x() and other helpers
> can fail and return an error. In that case the memory might not be
> protected as expected and the module loading has to be aborted to
> avoid security issues.
> 
> Check return value of all calls to set_memory_XX() and handle
> error if any.
> 
> Add a check to not call set_memory_XX() on NULL pointers as some
> architectures may not like it allthough numpages is always 0 in that
> case. This also avoid a useless call to set_vm_flush_reset_perms().
> 
> Link: https://github.com/KSPP/linux/issues/7
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Applied and pushed, thanks!

  Luis

