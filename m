Return-Path: <linux-kernel+bounces-24199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F39FB82B8F0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 02:07:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2422E1C242A4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 01:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C266517E8;
	Fri, 12 Jan 2024 01:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="JVaFkVBF"
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7914814
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 01:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=JirkDiOLIcgfiGK4i5BgIE2o8L87QMTz7u6sXd+9BV4=; b=JVaFkVBF5jTqT/2Cklldtky4u9
	iZiPGCxo8jTrdkIsUg1hSrG0hokegysZuJ41/XonuehxCmXIhvAenvVRvvGJkFZqrndwyrJdFr3SS
	ICJKXxwzj8oRuZzi9XuZdSZ7aU2vaRf0rfJ+uCDzLRXqPHMwtJVTnDokYZLx+R9brSpvOt5MSDA0w
	d5UTPTJom3lYdw3K2Gahdkq3IthpFYcuvG++gRcnM9pk1zWvFKexIsGVUngPOIQr3fZuBxp7khVKB
	ZgVVNS/fpBTrhj4Cn7NhnayFERr4l8qc4gYCRq7PcN+Onopre0ZW08joIR6Ivgm3GqAReAglGgrzJ
	BYSSGqTQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rO60E-00DVoZ-12;
	Fri, 12 Jan 2024 01:06:30 +0000
Date: Fri, 12 Jan 2024 01:06:30 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Guilherme =?iso-8859-1?Q?Gi=E1como_Sim=F5es?= <trintaeoitogc@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: new library
Message-ID: <20240112010630.GZ1674809@ZenIV>
References: <5AFF5BF9-BD11-4A60-BD42-7EC516164D41@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5AFF5BF9-BD11-4A60-BD42-7EC516164D41@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Jan 11, 2024 at 09:48:46PM -0300, Guilherme Giácomo Simões wrote:

> For ex: 1234 -> "12.34", and i show this in dmesg output: [09876] 12.34

Er...  What's wrong with "%d.%0*d", n / 100, 2, n % 100 in sprintf/printk/etc.
arguments?  It's slightly messier if you want to handle the negatives as well,
but also not impossible - "%s%d.%0*d", n < 0 ? "-" : "", abs(n) / 100, 2, abs(n) % 100
will do it, kernel and userland alike.  And I'm pretty sure it's going to be cheaper
than your solution...

