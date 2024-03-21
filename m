Return-Path: <linux-kernel+bounces-110547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0558A886062
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 19:14:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2C43285CAD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 18:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF8913340E;
	Thu, 21 Mar 2024 18:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gXgctHp8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEB31292CE;
	Thu, 21 Mar 2024 18:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711044842; cv=none; b=pU7AH/N9AiUmtsT8UvY6HX+KTtGzPe9CziZIrTcBkDA2m/MIz2c7B6ekzEkUSGe+Aq3wqpoj+bugtJU6+/bv2DWV5j1VKLoj1VA0H91/CtcXDKUTebngcDpA+yfDVg48VlR+sxkEwLL3MPP8oypoqsg9rbV3g3EzBWJZ5fbh6VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711044842; c=relaxed/simple;
	bh=XUlN3uXoacGlQBJNEV343fyloPlUcDzqZL5AIHjXbco=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QDv3oKJzJomyJf8O+9HGKc9McGLhuLZ4uecdejr5lg3Z8IY3c8cBtISAfTWQxYfOAb8MHvR0MgPpJsp0RSm6KI+h9aPQsjm86ZVik8f2Wt/Q8PbsTzKckby1O71+8AJI4R/cZOR3PsHE3ypz5g/rN/1LxzZjrATYSCaJUTSlYO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gXgctHp8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CD4DC433F1;
	Thu, 21 Mar 2024 18:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711044842;
	bh=XUlN3uXoacGlQBJNEV343fyloPlUcDzqZL5AIHjXbco=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=gXgctHp8kphN9fq2pXjJI2fDGR1kFRn1bGLZ1eU/Rj7LyeHn7k4kQGIVaOZ2OoJ3S
	 g18Xf5PB7CLUvvToJ8f8M8Xv7+dvp1hLwAngdLcDAGrGrWw0Bs5ZVTmqd1ufcgwBTh
	 0kA+RCWGZrbkwEeRDyIkseVYk8WIOBJmjMvUmc9yDSJCpCTAetCbQ9IXORFnv+1xCf
	 Z6NbUqy1IWQTJg+Uc1/ZlbbEzVEP4pLSsohohT+r/lDz9Tbzbkg2BZocbPY7WI1Fgh
	 Nj5flbZND0cHPRKHr6KvIY2qzZSbqRkj9JDMqiYFu1/xvy8AhiAZpULnx78Lnj2Pa+
	 omVb1Ic+a3FVQ==
From: Lee Jones <lee@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: Flavio Suligoi <f.suligoi@asem.it>, Lee Jones <lee@kernel.org>, 
 Daniel Thompson <daniel.thompson@linaro.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>, 
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <74347f67-360d-4513-8939-595e3c4764fa@moroto.mountain>
References: <74347f67-360d-4513-8939-595e3c4764fa@moroto.mountain>
Subject: Re: (subset) [PATCH] backlight: mp3309c: fix signedness bug in
 mp3309c_parse_fwnode()
Message-Id: <171104484009.147635.12745541732945934686.b4-ty@kernel.org>
Date: Thu, 21 Mar 2024 18:14:00 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.4

On Sat, 16 Mar 2024 12:45:27 +0300, Dan Carpenter wrote:
> The "num_levels" variable is used to store error codes from
> device_property_count_u32() so it needs to be signed.  This doesn't
> cause an issue at runtime because devm_kcalloc() won't allocate negative
> sizes.  However, it's still worth fixing.
> 
> 

Applied, thanks!

[1/1] backlight: mp3309c: fix signedness bug in mp3309c_parse_fwnode()
      commit: 84a053e072c8aacff8074ac5d6f7a4e7ff745209

--
Lee Jones [李琼斯]


