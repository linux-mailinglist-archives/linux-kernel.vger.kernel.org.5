Return-Path: <linux-kernel+bounces-125350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE3F892472
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 20:46:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B1411C213F9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 19:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF26413A3FF;
	Fri, 29 Mar 2024 19:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="LsJqFqP0"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B5F139D04;
	Fri, 29 Mar 2024 19:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711741594; cv=none; b=Yz6gHTW4S7ayAmn8404riFyNenqYo01C0qFhr1ESNGehOesNsq+Hw8eg83qroGzv4OD3UHIk5DDmZO5hszJq+sgZRm/5Ljkrx4sg6olgfK5CUz9LOyVzEFSAtlkjJJTFuEvD3XCIu5eO7yAdeJBuQSFOX4suwYHHfZ9WXCYcdTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711741594; c=relaxed/simple;
	bh=zYYB0UTSbRLws4DW2xNoeDK8WItj9tGsyvCKAM5E+ls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sIuSx6SKkUZPvEaVGrtvx7vKNpjyFZPKB7B1fvl/krjvkMSFN9PB0O6nx1ZXqFsUUxrKYV9cibrzCaE29ol8zxZXHM1KNqInb5X+XopTw1C9QR27SCDE+WjlO64a1wrDHlih+Mtx+cX6jlNgqexYKEwDV4+M5v6uxZeVi4s4uqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=LsJqFqP0; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.64.65.59] (unknown [20.29.225.195])
	by linux.microsoft.com (Postfix) with ESMTPSA id 020AB20E6F42;
	Fri, 29 Mar 2024 12:46:31 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 020AB20E6F42
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1711741592;
	bh=cyTA2cENb6Yp33jOnm7DNF77XO+4wSIz79NQQoBF7v0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LsJqFqP02CUKkfUhLZjuUQr1pQ0xb9+ApnC1krA/TWB9Lz5UFhdI7zPFqztKo2pqG
	 7/gwAEzIUcbObSW9ZBpgKl6t7sB0LDeSXzbIjWEQsk/aYlz4DcpboWya7uegZW7AdH
	 mIoWV9PzU/6HQlPtqK6yGo32BtA93gQ9TLv/HSCk=
Message-ID: <07ed50c1-75a9-494c-8a6a-5edcc2d6f932@linux.microsoft.com>
Date: Fri, 29 Mar 2024 12:46:30 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] swiotlb: Do not set total_used to 0 in
 swiotlb_create_debugfs_files()
To: Dexuan Cui <decui@microsoft.com>, hch@lst.de, m.szyprowski@samsung.com,
 robin.murphy@arm.com, zhangpeng362@huawei.com, iommu@lists.linux.dev,
 mhklinux@outlook.com
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20240329192809.17318-1-decui@microsoft.com>
Content-Language: en-CA
From: Easwar Hariharan <eahariha@linux.microsoft.com>
In-Reply-To: <20240329192809.17318-1-decui@microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/29/2024 12:28 PM, Dexuan Cui wrote:
> Sometimes the readout of /sys/kernel/debug/swiotlb/io_tlb_used and
> io_tlb_used_hiwater can be a huge number (e.g. 18446744073709551615),
> which is actually a negative number if we use "%ld" to print the number.
> 
> When swiotlb_create_default_debugfs() is running from late_initcall,
> mem->total_used may already be non-zero, because the storage driver
> may have already started to perform I/O operations: if the storage
> driver is built-in, its probe() callback is called before late_initcall.
> 
> swiotlb_create_debugfs_files() should not blindly set mem->total_used
> and mem->used_hiwater to 0; actually it doesn't have to initialize the
> fields at all, because the fields, as part of the global struct
> io_tlb_default_mem, have been implicitly initialized to zero.
> 
> Also don't explicitly set mem->transient_nslabs to 0.
> 
> Fixes: 8b0977ecc8b3 ("swiotlb: track and report io_tlb_used high water marks in debugfs")
> Fixes: 02e765697038 ("swiotlb: add debugfs to track swiotlb transient pool usage")
> Cc: stable@vger.kernel.org
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>  kernel/dma/swiotlb.c | 4 ----
>  1 file changed, 4 deletions(-)
> 

Sorry, I'm missing a why in this commit message. Can you say what happens if the
total_used and used_hiwater IS blindly set to 0? Is the only effect the change in
the readout of the swiotlb debugfs files?

Thanks,
Easwar


