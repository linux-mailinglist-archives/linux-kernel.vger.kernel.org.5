Return-Path: <linux-kernel+bounces-16003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 597038236E6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 22:03:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA50E2878E3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 21:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA10C1D6A5;
	Wed,  3 Jan 2024 21:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="Adts07q7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067901D692;
	Wed,  3 Jan 2024 21:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Received: from localhost (unknown [IPv6:2601:280:5e00:7e19::646])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 45B098E3;
	Wed,  3 Jan 2024 21:03:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 45B098E3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1704315812; bh=iR0cbg1POh/5swWdt13ITCDKZofHsKJuPDbc9ByDZGU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Adts07q7XU3S9G9jGDNTCSvkKeQTRbx87Sw2IYDBMrJr17LRcpiCstNQCEadPr4cv
	 0FCEsvwrKsLELLi2wm62KWbEgIMY0vJYEpTZC+iVorQzO9nviAPJpvCgPdGLwELCPb
	 MwbQtjyZiAqo5FsJVPEqkJaIc3BFIDRvQ9IZ69fojmvrTiIAt3Dk+ZFZtsrKOZA9IY
	 wfMO9prgLzGctDrm7MmgXAYltcEt4RUvk6p/NjIcYXpuIVcoKa9Q3WJP+BBuyYTByp
	 ZuUrnQQay6tM1v3Felpc+3wt6lOCyAtEiQe5EBeI66A3IZqoaX25jw4QxYLekP/9y/
	 51dOes4vT6paA==
From: Jonathan Corbet <corbet@lwn.net>
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, linux-doc@vger.kernel.org, Mauro Carvalho
 Chehab <mchehab@kernel.org>
Subject: Re: [PATCH] scripts/get_abi.pl: ignore some temp files
In-Reply-To: <20231228233113.5218-1-rdunlap@infradead.org>
References: <20231228233113.5218-1-rdunlap@infradead.org>
Date: Wed, 03 Jan 2024 14:03:31 -0700
Message-ID: <87plyi86zg.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Randy Dunlap <rdunlap@infradead.org> writes:

> When there are filenames of the form ".orig" or ".rej" in
> the Documenatation/ABI/ subdirectories, there can be confusing or
> erroneous output generated. Example: the file
> Documenation/ABI/testing/sysfs-bus-papr-pmem.orig causes this
> warning message:
>
> Documentation/ABI/testing/sysfs-bus-papr-pmem:2: WARNING: unknown document: '/powerpc/papr_hcalls'
>
> Prevent this by skipping over filenames that may be created by
> patch/diff tools etc.
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Acked-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> ---
>  scripts/get_abi.pl |    1 +
>  1 file changed, 1 insertion(+)
>
> diff -- a/scripts/get_abi.pl b/scripts/get_abi.pl
> --- a/scripts/get_abi.pl
> +++ b/scripts/get_abi.pl
> @@ -93,6 +93,7 @@ sub parse_abi {
>  	return if ($mode & S_IFDIR);
>  	return if ($file =~ m,/README,);
>  	return if ($file =~ m,/\.,);
> +	return if ($file =~ m,\.(rej|org|orig|bak)$,);

Applied, thanks.

It would have been nice to create all of those files with a .abi
extension so we didn't have to do this kind of blocklisting, but so be
it.

Should we exclude emacs-style ~ files too?

jon

