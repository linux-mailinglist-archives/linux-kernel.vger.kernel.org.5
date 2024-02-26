Return-Path: <linux-kernel+bounces-82028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B928D867DEB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 18:17:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB7901C2B91D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8DC130AF7;
	Mon, 26 Feb 2024 17:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SPfUUlCW"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A438112C554
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 17:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708967450; cv=none; b=HAKURMKqoJt7IqcZ5sFCj+4i0zjiR0DaVNVTB0+hybREoz4UfgYfQ5PzCJDMSgMC1i05Zt/vF5h2Y4Hcs7/TPxYCG7/j2/hqobGAVz6ScUmdHUgI7zBZC2EGXaE71VXRcnRVc1DbzgqCQzDHRR7xnhfJW1nGitqABhUsFGZUTQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708967450; c=relaxed/simple;
	bh=Q72qtY+Ta8xKB/FMRYl8kiCwmSZk/FK5F25O6IrJhRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CkiUqvloxe+c9GRYQai6dvF9cCKPKFljsUdDYEkXhD9ZrB04FQURmK6DEDmItmQd4eyIxysKDglV3+tj3cOCbB5xIp2eRyyqHTjtfAVWbfwopwLbm+ADWIWPlBu7ESRLnc3MlGREwSKkjCoSSXaYwan+p9fArs8unzt92KVTWHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SPfUUlCW; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ZgB1CchgcigLlqcA5Q8s7LGYKisNW7kuEZm15h0/YYU=; b=SPfUUlCWBaPFKLLIEavNlrzliA
	3voSJqCjhnUP+lkaK21lMuJJftZbmIbftBJEoRkH7Q33HQenknHZnpJhSa3NfDaowvRRfF2SMawYk
	fDcOj1OubD2s8QWXO+R+mkuGsIsAkUBbDDqzAYKPV4T7iZR66J/IRdT/7wXe3dY3+peE0CjS4JrEL
	BGBQFIYLBVaxEs6o+kDB/Fwxz6dKap6LdNhZsnCoK2LjyPlrntH4cQmtAnYANUrTNcvdbLwCpLCBi
	uQI0ir39G6n9fJIU7HRbU8A40OaaenNyVVNErXe8A+D9wK4of7LXgiEV5RP7JWBIz94oHnSnwW80/
	Wcm5nHrg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1reeV5-00000001rJq-0Vyn;
	Mon, 26 Feb 2024 17:10:47 +0000
Date: Mon, 26 Feb 2024 09:10:47 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: russ.weight@linux.dev, gregkh@linuxfoundation.org, rafael@kernel.org,
	linux-kernel@vger.kernel.org, masahiroy@kernel.org
Subject: Re: [PATCH] firmware_loader: Use init_utsname()->release
Message-ID: <ZdzGF9bxLn3Slbgi@bombadil.infradead.org>
References: <20240222145819.96646-1-john.g.garry@oracle.com>
 <Zddt-U-6SdxkxqmD@bombadil.infradead.org>
 <51483aaf-d64a-4eee-b256-ab126483ad6c@oracle.com>
 <Zdy9gKO5Q6K4IE8J@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zdy9gKO5Q6K4IE8J@bombadil.infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Mon, Feb 26, 2024 at 08:34:11AM -0800, Luis Chamberlain wrote:
> On Fri, Feb 23, 2024 at 02:29:19PM +0000, John Garry wrote:
> > > Could you also test the selftests to ensure nothing is broken ?
> > > 
> > > ./tools/testing/selftests/firmware/fw_run_tests.sh
> > 
> > I am running this now, but it does not seem stable on a v6.8-rc5 baseline. I
> > am seeing hangs. Are there any known issues?
> 
> I tested next-20240108 and so no issues.
> 
> Lemme upgrade.
> 
> Note you also need /lib/udev/rules.d/50-firmware.rules removed if
> you have it.

I don't see any hung tasks on next-20240226. Perhaps its with your
config that it is triggered.

  Luis

