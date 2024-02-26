Return-Path: <linux-kernel+bounces-81915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43173867C1E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:34:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE4342906F1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE92012BE95;
	Mon, 26 Feb 2024 16:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3+y5CG6l"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16ADB53E3B
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 16:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708965254; cv=none; b=qOZ3g8EjAzriV3ers5DESEHBlty+ScCHzmx7vCkeflKa/mYDGfuQxFN9uNI/1IbSOsyP88EPAo7fb3KpjWdSLe+XWEum505qnucsL0szuQVy+J0Ee9lfCiHjmrMtkP60eHtOUeJuY99Ofl1PgZOpxCSnfpv0VsO/0LLZ8Te8nuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708965254; c=relaxed/simple;
	bh=0Je/xyJNOmt8LnetPj4GAFEnGSht95roZ4AZfCYPybM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bTUNnSEME5hS+3DAtx8lE85Uf+g45E5tsWn5GNZsvJ8xUt1SEN1eA0/95PjgpCY2PedZER5bG3zHnXosxRQsAtubIS0qTGvhX9jBhpldHnoSPpMCi5y/AiwRPuqHNTyC9ivlbFEi3qFXhCECE5vgk9+3LXX/ZP37VtjMbwUVq7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=3+y5CG6l; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YIKBIoMShyksYDWbzXo21USJBXSV3r0b6hDsivUJBHM=; b=3+y5CG6lqh+d9k/MMPUbfVA+Uu
	8YpH7cuXvmT4tQpvddiNI+NX/BEEKPyXzqcDI9wmIpO0F2hMb7vQegJsNsXM0YYcZ7DbUxtMOtH5T
	ES2n7uffSMRuln3Q/H2W1zlxevTPP22x7FX4utpgKqLSyOxe+OqVdWe/ja+cpCSeDRvdJ5cHVtdk+
	e0sgndG4edrWVs1mJLFlF5SgQ27WKcEz293nglw3DgSAP/Ekcy9c9EPZrLZj62r2X8EjmvVv5XV6D
	33EiADc3goyCjm3HJ7UIQF7gjPXIyPyTfOwoGLIZT4F5urxLxxJhrh8hxgLDd7y+EjkwLiea4NvXs
	b7U81N1g==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1redvc-00000001grL-2EmP;
	Mon, 26 Feb 2024 16:34:11 +0000
Date: Mon, 26 Feb 2024 08:34:08 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: russ.weight@linux.dev, gregkh@linuxfoundation.org, rafael@kernel.org,
	linux-kernel@vger.kernel.org, masahiroy@kernel.org
Subject: Re: [PATCH] firmware_loader: Use init_utsname()->release
Message-ID: <Zdy9gKO5Q6K4IE8J@bombadil.infradead.org>
References: <20240222145819.96646-1-john.g.garry@oracle.com>
 <Zddt-U-6SdxkxqmD@bombadil.infradead.org>
 <51483aaf-d64a-4eee-b256-ab126483ad6c@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51483aaf-d64a-4eee-b256-ab126483ad6c@oracle.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Fri, Feb 23, 2024 at 02:29:19PM +0000, John Garry wrote:
> > Could you also test the selftests to ensure nothing is broken ?
> > 
> > ./tools/testing/selftests/firmware/fw_run_tests.sh
> 
> I am running this now, but it does not seem stable on a v6.8-rc5 baseline. I
> am seeing hangs. Are there any known issues?

I tested next-20240108 and so no issues.

Lemme upgrade.

Note you also need /lib/udev/rules.d/50-firmware.rules removed if
you have it.

  Luis

