Return-Path: <linux-kernel+bounces-78087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F1D860EB9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DB211F259F2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B75D81B95F;
	Fri, 23 Feb 2024 09:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WkbqpIJv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TmU5CmpV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A436043168
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 09:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708682040; cv=none; b=WDjCyychHTrLYuZIAvOuLeNMtXLeV2tJvZP+6E3IR8jHXQD9O5Ncp+UOBONN/2IJ+gXbHLy7wTDNwbig9PMKN+MrV2Wztu15gyXWp8cBVhb4eejmIh1CZ10d4naekIEUcu78C6mNuaQQ1nqsN2162UMGdJ06Oie+N4rPJCH1ZFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708682040; c=relaxed/simple;
	bh=15JKpdXZhIFgQysB2xQcKWDPsSSnO169msTlHUvmytc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tpSOVqDkLAYvnRacTx3r/9sm8C92ObZfrEruv4wKCNRsrs9RbhdjYW4JvWvKUeRcOgcq44CD3qePmxxrYpLugaZGNqGV65bXNJzuft2NzvgG+ovzsSPclh8ksgQtYRfRqO5m4Q8C8MnfBQzEV2G5cTnxH1rsUM1oQItm2+Y0jVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WkbqpIJv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TmU5CmpV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708682036;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=15JKpdXZhIFgQysB2xQcKWDPsSSnO169msTlHUvmytc=;
	b=WkbqpIJv4/uyYQtGtMco+Uer6lFjqrM+RUmCUpBvRK1owNmWbvGiFsIALpg9imOtptTmHL
	2UReiesqmeaclesSXBPdMHDHZMInYOvOJPKfVcJTIh4oxZusfk2vinc274C5tb2iUoZqJL
	7GMLOI8iAE8Gclha6F/38n3brm6Me733FS0GKcv5IeYIibUz3YiLDbEBQmZWw++Ctf1an/
	epSgmW8HCayDeYcAC5vDmz+tPOddYEIFR3/ENTxmfkIJiHk31bYv0KID5Z2sBm7qsS3BAx
	CfC1YWitzGI5DUBSi0NTGxYmxOMKj5kHgwKltvFwd2mKObH3edceAxY94b9Cdg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708682036;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=15JKpdXZhIFgQysB2xQcKWDPsSSnO169msTlHUvmytc=;
	b=TmU5CmpVMJR5cWmSwtWnTmfJIxg482lLLl8HO7WuKSonCBtQAozRWiEqsvX21S8n0Lu0GB
	z4AkhxDjIeUK7jAg==
To: Nipun Gupta <nipun.gupta@amd.com>, gregkh@linuxfoundation.org,
 maz@kernel.org, jgg@ziepe.ca, linux-kernel@vger.kernel.org
Cc: git@amd.com, harpreet.anand@amd.com, pieter.jansen-van-vuuren@amd.com,
 nikhil.agarwal@amd.com, michal.simek@amd.com, abhijit.gangurde@amd.com,
 srivatsa@csail.mit.edu, Nipun Gupta <nipun.gupta@amd.com>
Subject: Re: [PATCH v8 2/2] add wrapper msi allocation API and export msi
 functions
In-Reply-To: <20240223092447.65564-2-nipun.gupta@amd.com>
References: <20240223092447.65564-1-nipun.gupta@amd.com>
 <20240223092447.65564-2-nipun.gupta@amd.com>
Date: Fri, 23 Feb 2024 10:53:56 +0100
Message-ID: <87v86fcxqj.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Feb 23 2024 at 14:54, Nipun Gupta wrote:

Subject wants a proper subsystem prefix, no?

I fixed it up for you this time.

