Return-Path: <linux-kernel+bounces-24249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B5782B9BF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 03:55:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FA1C1F23E26
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 02:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B279EDDBA;
	Fri, 12 Jan 2024 02:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="QaoTr9z2"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7D0C151
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 02:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [IPV6:2601:646:8002:4641:eb14:ad94:2806:1c1a] ([IPv6:2601:646:8002:4641:eb14:ad94:2806:1c1a])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 40C2skmQ060187
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Thu, 11 Jan 2024 18:54:46 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 40C2skmQ060187
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2023121201; t=1705028087;
	bh=uK0/9rbfDfcAI/GGyRYe4b5BWbtxjK6N6VZfagVqrDE=;
	h=Date:Subject:From:To:References:In-Reply-To:From;
	b=QaoTr9z22PwK9nPBDrsNqpSc5YA67jS7MSgMLqTQD8QkuDSUderJTN6oKqVQ7mWsn
	 AMEfL+1Ys0TBWRRhkY6+hCPRyE3SxdfNwNz8AcyDJETRgsWiBp7xr6S4bSUnHdOL3b
	 HKKdcKsCDNnSrDVl5c14J4Agoa32y7VBTwQsFsyCRfqLfniH1JWqFTV5bLG+imJDXl
	 3fUFl8NI2rsCPHQisFkwoLyEZSPmkVaNBJ9GGsOrpLT3ALXj1FgjzhUJhzlgQxJKtc
	 djMqKwbvMAmnR+j4FmeZkt6hRsIE3/LgTyQjykn5j0M3rxpdKhVrim3vzL9DYFyy3L
	 gFeGgK7wm8fIg==
Message-ID: <49231a98-d39f-4920-8d9f-e60aa014f518@zytor.com>
Date: Thu, 11 Jan 2024 18:54:41 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/45] C++: Convert the kernel to C++
Content-Language: en-US
From: "H. Peter Anvin" <hpa@zytor.com>
To: David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org,
        pinskia@gmail.com
References: <152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk>
 <3465e0c6-f5b2-4c42-95eb-29361481f805@zytor.com>
In-Reply-To: <3465e0c6-f5b2-4c42-95eb-29361481f805@zytor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

One thing I forgot to mention that would be quite useful is careful use 
of namespaces. For example, putting init functions in their own 
namespace would have not only make it a lot harder to call init 
functions from non-init functions by mistake (calling init::func() 
explicitly is a highly visible "I really do mean to do this."

However, it also let us do separate init versions of functions like 
cpu_feature_enable() that contain optimizations that aren't actually 
usable at init time (alternatives have not been applied.) The idea is 
*not* to change the code, but rather the compiler will simply prefer 
init:: functions from inside other init:: functions (a direct 
consequence of how namespaces work.)

	-hpa

