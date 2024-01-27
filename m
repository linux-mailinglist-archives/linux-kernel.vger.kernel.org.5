Return-Path: <linux-kernel+bounces-41104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6852C83EBEE
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 09:03:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2547A284AC7
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 08:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3801A1DDFF;
	Sat, 27 Jan 2024 08:03:04 +0000 (UTC)
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F571D6B6;
	Sat, 27 Jan 2024 08:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706342583; cv=none; b=TiBTWCvfPuVBfqo+qSTH3/ZXV9A5YbKMnx5k4K4pg8xBO7c4yUziG4pCWFjcXldFcswBBbhIFlS/wJU+QErsDqjkGCN24pdEtacof52jWCDE6XkAt80pesv1gast8QqxFRVu4+SVBl6oeu0vma14iM9qPD4VCmToS1jPvy8V5E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706342583; c=relaxed/simple;
	bh=jCdjWKQK7HL95zpeESitIw6yDltgmHC4OEMcv4BXJ3Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DQO7FUGtflXuO2mBF95HKuG816wFJ8snpOunGl45YYLRAaLAQm90V2QSDK1l2rrT+bDGxFKG2q5w9wB17SiXOXbXMRSll7jnGGmfTj5Or38xqIdmRo4eZpztJCVTIlqBTjI4ZJm+XCPus/eZ1Cmb6fAql1gQnzepD9tJT6gElHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: by air.basealt.ru (Postfix, from userid 490)
	id 32F5A2F20227; Sat, 27 Jan 2024 08:02:58 +0000 (UTC)
X-Spam-Level: 
Received: from [192.168.0.102] (unknown [178.76.204.78])
	by air.basealt.ru (Postfix) with ESMTPSA id 9D48B2F2021D;
	Sat, 27 Jan 2024 08:02:54 +0000 (UTC)
Message-ID: <57fda449-0d18-485a-0858-39f48722fe27@basealt.ru>
Date: Sat, 27 Jan 2024 11:02:53 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 0/2] smb: client: fix "df: Resource temporarily
 unavailable" on 5.10 stable kernel
Content-Language: en-US
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
 Greg KH <greg@kroah.com>
Cc: stable@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-cifs@vger.kernel.org,
 samba-technical@lists.samba.org, keescook@chromium.org, sfrench@samba.org,
 corbet@lwn.net, natechancellor@gmail.com, ndesaulniers@google.com,
 "pc@manguebit.com" <pc@manguebit.com>,
 "Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com>,
 Shyam Prasad N <nspmangalore@gmail.com>,
 Vegard Nossum <vegard.nossum@oracle.com>,
 Darren Kenny <darren.kenny@oracle.com>
References: <20240126193143.245122-1-kovalev@altlinux.org>
 <2024012613-woozy-exhume-7b9d@gregkh>
 <472d92aa-1b49-43c9-a91f-80dfc8f25ad3@oracle.com>
From: kovalev@altlinux.org
In-Reply-To: <472d92aa-1b49-43c9-a91f-80dfc8f25ad3@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

27.01.2024 09:42, Harshit Mogalapalli wrote:
> We can reproduce this on 5.15.148(latest 5.15.y) and Mohamed reported 
> this on 6.1.y, so we need backports there as well.

in the 6.1.72 kernel, this problem was fixed by the commit [1] "smb3: 
Replace smb2pdu 1-element arrays with flex-arrays", which was proposed 
in this series of patches.


[1] https://lore.kernel.org/all/2024010937-eggplant-bauble-d556@gregkh/T/

-- 
Regards,
Vasiliy Kovalev


