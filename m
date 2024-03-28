Return-Path: <linux-kernel+bounces-105032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3CC387D7ED
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 03:00:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 241C01C21585
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 02:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85BD63D71;
	Sat, 16 Mar 2024 02:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="UuPGao1x"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406D51C27
	for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 02:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710554440; cv=none; b=sS2xPYXrxNfZyWqJm5CMwsUQrI+bIlXITzZPK3JNnebkKeLsJIsODTVRr6ctz0jWkGHjyUD2hR3pAy3ctZjj6QmTr8MuE7MHmCbks0CXpWvPhHWpjdfH9dWd+VrJgzpcs8mYn6KwJmh6EX+tf1QKSV760Pxku1+rpKLGaidqfwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710554440; c=relaxed/simple;
	bh=VG7OIJFW49Jwu6YetTg/UZGufYausVpptp7BRBu/EQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OBRiprvqDbhOPSrjx0XaMuuLhBgoukQLFVCgn3rvyWHrKxW5WdD6Qhhth3haERuAc1FBrZtuRvrXT9I2aDdpsGgKOkT1iP3PQaDiNQ0ebkfT3xNE2N0Z+4bP3LWKXFuORVMHNtCVrHsLet6P5BSwzPdM24hWwCr5BV6Hm7oUXxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=UuPGao1x; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-116-252.bstnma.fios.verizon.net [173.48.116.252])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 42G20L8D029621
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Mar 2024 22:00:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1710554424; bh=idgkghSz0sUzKRX7HAo4sytYQwnubKAL8qnjaAnVuC4=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=UuPGao1x1pxd9H+l4lkyHQpIODVYWrLNc/aA7678KMHVrpt7vJ0oh/Lgb1bZpZS/E
	 hGDG+CAm/kj8sLsC089DEwuqQhtSOM+DXGJq6oOw9v+fChtNmS1E6ebvu3D7fGNsQu
	 VYI+fzyaQHl9WiklcW8/RbMefw3WqRx9mDMMTJnozuhUQXo2u29UpseHh3mLvAWBNX
	 yI97PPiQxC0yOYmSo4JwOgVko2oP3+qjvPgIG4/tTz5tPdPxZffLXCFRqKI88JDHIu
	 u1C4PEhvykXXM3EH3wfCCoxGkF1fFbaPcC3HIElJ8XoIqcriGhE+z9nVnRrkE56cK1
	 7Azod1QT1BQpg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 52AD415C0C93; Fri, 15 Mar 2024 22:00:21 -0400 (EDT)
Date: Fri, 15 Mar 2024 22:00:21 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: cheung wall <zzqq0103.hey@gmail.com>
Cc: Andreas Dilger <adilger.kernel@dilger.ca>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: KASAN: slab-use-after-free Read in ext4_find_extent
Message-ID: <20240316020021.GD143836@mit.edu>
References: <CAKHoSAu2+dDCR9Dgd4PGYJg2qBqKO+kNThaoFdfVi-AheS3S7w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKHoSAu2+dDCR9Dgd4PGYJg2qBqKO+kNThaoFdfVi-AheS3S7w@mail.gmail.com>

On Thu, Mar 14, 2024 at 02:58:04PM +0800, cheung wall wrote:
> Hello,
> 
> when using Healer to fuzz the latest Linux Kernel, the following crash
> 
> was triggered on:
> 

> HEAD commit: e8f897f4afef0031fe618a8e94127a0934896aba  (tag: v6.8)
> 
> git tree: upstream
> 
> console output: https://pastebin.com/raw/YBKrQHxW
> 
> kernel config: https://pastebin.com/raw/SJFReJfc
> 
> C reproducer: https://pastebin.com/raw/GUVzwEmx
> 
> Syzlang reproducer: https://pastebin.com/raw/9KqQRP2e
> 
> If you fix this issue, please add the following tag to the commit:
> 
> Reported-by: Qiang Zhang <zzqq0103.hey@gmail.com>

This is not reproducible using the above-specified kernel version,
kernel config, and C reproducer using kvm-xfstests.

In any case, looking at the C reproducer, it looks like the reproducer
involves forcibly deactivating the loop device, which requires root
privileges, and so this is not a terribly intereseting bug report.

	    	   	       - Ted

