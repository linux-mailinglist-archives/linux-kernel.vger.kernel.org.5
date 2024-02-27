Return-Path: <linux-kernel+bounces-83273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA178869125
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:00:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AA63284BDB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B1513AA47;
	Tue, 27 Feb 2024 13:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qHPIAmcT"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BE513A897
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 13:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709038802; cv=none; b=gbbq+Qb/914fvMQg/V0YHwvCrhyhm7+SXEwb4Pqjk0ehkHKL4iEIko4GYqlnN7d8SK/S6J8OQZtp5GwaPnaksKpGEvQh6vUapNpcWHTVcWBXqm1TfgnSZ9DipHl6SBrq9tkbGLC+pkBm0caVtpQE18F7/5A5qwmuQaGvf2INE6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709038802; c=relaxed/simple;
	bh=I10uGC1qtIuJ+UJtVBU20Etuw7E4FDlWKdCWQwJ390c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rvnQnhHZbrXUmKavXqsszCLfGNgGh2WngxL2AMm3VtxsnBg2uc+1Irte1FzkexAow2QHeeHmXY+Ag/oIouGTgOI3qPldcYvITSpAxD2BRY0iqEZVCpU1Pm0LIiqXQMOl9Aoast4s9jn4u7RDA3UgljCV6rGcXzDeWJ856ytOJ/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qHPIAmcT; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ujrjDTxC+5c7xTmbdkShM1Fj8zI+Et+XU5QhlYyLywY=; b=qHPIAmcTyNQfy+KHCUmjENK62+
	Dqbz79SdBhzM8PAj00TEylhvOB4IWjw6Zr+tfkszPjY2F/U7wLKdN+5mAqOX2qVAINQMiFCB6TJDv
	lFlpodBdBw1g+nHdDucg6/QBBoESqP9VYvU5uRMWDXTJFJgPnZAX2VgZqP/DUEo9edIUr6xDBNQcI
	8on53XLmKb85UW0HOe9qPyu3zoGo/euT32KzL5Q3ZKH869HwyOaIuCiH8d46F8t+2u77gpIFPMg4Z
	8ow6oBHZMkUzgxcPj2vofa/9XHZW44DpPaDLJP+B26NPU9eQx5twq6UK1Rj7I/UsEADhzw+MBWE72
	R06wJ/Og==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rex3v-00000005Hs1-1DfE;
	Tue, 27 Feb 2024 12:59:59 +0000
Date: Tue, 27 Feb 2024 04:59:59 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: russ.weight@linux.dev, gregkh@linuxfoundation.org, rafael@kernel.org,
	linux-kernel@vger.kernel.org, masahiroy@kernel.org
Subject: Re: [PATCH] firmware_loader: Use init_utsname()->release
Message-ID: <Zd3cz7yYezir-P7e@bombadil.infradead.org>
References: <20240222145819.96646-1-john.g.garry@oracle.com>
 <Zddt-U-6SdxkxqmD@bombadil.infradead.org>
 <51483aaf-d64a-4eee-b256-ab126483ad6c@oracle.com>
 <Zdy9gKO5Q6K4IE8J@bombadil.infradead.org>
 <ZdzGF9bxLn3Slbgi@bombadil.infradead.org>
 <cb0c185c-54f8-4b43-856f-685cc5ed3fc4@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb0c185c-54f8-4b43-856f-685cc5ed3fc4@oracle.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Mon, Feb 26, 2024 at 05:13:44PM +0000, John Garry wrote:
> On 26/02/2024 17:10, Luis Chamberlain wrote:
> > > > I am running this now, but it does not seem stable on a v6.8-rc5 baseline. I
> > > > am seeing hangs. Are there any known issues?
> > > I tested next-20240108 and so no issues.
> > > 
> > > Lemme upgrade.
> > > 
> > > Note you also need /lib/udev/rules.d/50-firmware.rules removed if
> > > you have it.
> 
> I have this:
> ubuntu@jgarry-ubuntu-bm5-instance-20230215-1843:~/mnt/linux2$ more
> /lib/udev/rules.d/50-firmware.rules
> # stub for immediately telling the kernel that userspace firmware loading
> # failed; necessary to avoid long timeouts with
> CONFIG_FW_LOADER_USER_HELPER=y
> SUBSYSTEM=="firmware", ACTION=="add", ATTR{loading}="-1"
> 
> So I can remove it.

You can keep it on a distro use case, but for testing it is important to
remove it.

> > I don't see any hung tasks on next-20240226. Perhaps its with your
> > config that it is triggered.
> OK, I'll check again when I get a chance, but I am not so keen on checking
> linux-next in general.

What kernel are you seeing this issue on?

  Luis

