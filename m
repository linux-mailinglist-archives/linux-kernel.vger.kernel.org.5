Return-Path: <linux-kernel+bounces-82819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A97868A11
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 08:43:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD176B254A5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 07:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195E454BD8;
	Tue, 27 Feb 2024 07:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xen0n.name header.i=@xen0n.name header.b="CgwrGYZK"
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A1454BCB;
	Tue, 27 Feb 2024 07:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.28.160.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709019781; cv=none; b=L/GakyDjFCCK+xURU42pqp5ZU/AuM3EVnNwzd988Ald46uQ2IEj1nI42UsTU3RH0scqrdj1wO8yDYD16K9OUHb4YtJXuaTAHfr8XHFlBqf/ane3PznNctnT5bAuewflnxZ29VvfSKXQudAQ5uHFwjT1RFzMND8TGRD+bDghOu4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709019781; c=relaxed/simple;
	bh=VeQQz1LGeycIAUL/EG5r7Rx6hXmeV3PR/rjB1cNm8r8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QkpbUbB8prCN5QKh535Wk3yl4XMFMeHSzL0atKRBU9tkG+fIuLLuRwoCQsc/YlA58TWlgHYjsjdnTyChpYKMbmyZxYPkP+K72JJ9e8ORWd3I3RwtO6IlNkLAnPtDZBN3nGnzZDP/SBXRvfOI5WYjw3DkYaWzyjy928muWiOmA/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xen0n.name; spf=pass smtp.mailfrom=xen0n.name; dkim=pass (1024-bit key) header.d=xen0n.name header.i=@xen0n.name header.b=CgwrGYZK; arc=none smtp.client-ip=115.28.160.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xen0n.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xen0n.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
	t=1709019771; bh=VeQQz1LGeycIAUL/EG5r7Rx6hXmeV3PR/rjB1cNm8r8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CgwrGYZKopCqIHyNKix56CRK6Zx1FUln27PllXLGI28yYptJmjITlqfLEMtm1+nzb
	 VBHf+/dtpa3ZpccqLfMSWZSqrHmMtyLuCmr5LNDPHnPuQlFCU74W52hcMcjWsH2bQS
	 gXk/+Npz+yt5Oelq7n7rp+hkdXvNUxrpeaZELIII=
Received: from [28.0.0.1] (unknown [101.230.251.34])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 0419B60121;
	Tue, 27 Feb 2024 15:42:50 +0800 (CST)
Message-ID: <0a7d0a9e-c56e-4ee2-a83b-00164a450abe@xen0n.name>
Date: Tue, 27 Feb 2024 15:42:49 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] loongarch/crypto: Clean up useless assignment operations
Content-Language: en-US
To: =?UTF-8?B?5YWz5paH5rab?= <guanwentao@uniontech.com>,
 =?UTF-8?B?546L5pix5Yqb?= <wangyuli@uniontech.com>,
 herbert <herbert@gondor.apana.org.au>, davem <davem@davemloft.net>,
 chenhuacai <chenhuacai@kernel.org>
Cc: linux-crypto <linux-crypto@vger.kernel.org>,
 loongarch <loongarch@lists.linux.dev>,
 linux-kernel <linux-kernel@vger.kernel.org>
References: <20240226080328.334021-1-wangyuli@uniontech.com>
 <48afa638-9145-40ee-9868-fa82a1fce271@xen0n.name>
 <tencent_29355025499B47007555CE13@qq.com>
From: WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <tencent_29355025499B47007555CE13@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/26/24 16:25, 关文涛 wrote:
> Sure,but we not seem to have "crc.w.d.w" dword asm in loongarch 32bit mode,now the whole file can only run in 64bit mode?
> 
> Thanks.

Sorry. I have checked the manual and it turns out you & Yuli are 
correct: even though the narrower CRC instructions doesn't require 
GRLEN=64, they still *aren't* part of LA32 (LoongArch reference manual 
v1.10, Volume 1, Table 2-1). Counter-intuitive as it is, the original 
patch is correct nevertheless.

I'm going to amend my review shortly.

-- 
WANG "xen0n" Xuerui

Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/


