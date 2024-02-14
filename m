Return-Path: <linux-kernel+bounces-65406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F56854C7E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:19:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C3C01C27E09
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC6C5D8E7;
	Wed, 14 Feb 2024 15:19:15 +0000 (UTC)
Received: from alerce.blitiri.com.ar (alerce.blitiri.com.ar [49.12.208.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCFF5D732
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 15:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.208.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707923954; cv=none; b=RPJF1wDME1wgWAxc+00x2cCxsZoCeDgbKAYtmfE6Gp2ie/hFeEfCNg7RMcqH4MeC6QdYn8fwXhuMVRTDrCV6kh+cNxNst+EMaJ4ZZqCQqqgDwQayjH6o1ZjNuXtsHr7DxvStLa0/rXbMxuAzjtCJOD4zR3k8HyF6bPdGfTkBrRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707923954; c=relaxed/simple;
	bh=LPv8oHbl0Uht0dU5YIxSCnDtDf3Dbxixsx9UtlQR0pY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EhiexFlYYEVmVCJ5bOlAzPhSaoGcPQsNc464nqEiF1ney+RqZKkfCf1AiNUt+/x2GDLl+GCb2oCxcbKAzcGm1FIT4nrYbB6gBgf9vOo55huF8d3hzoFGMItSt+NN5O1Gz2PpAR6EVZbBndOqh6czQIcvUbBk4qODJ+KrB0imh60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdfg.com.ar; spf=pass smtp.mailfrom=sdfg.com.ar; arc=none smtp.client-ip=49.12.208.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdfg.com.ar
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sdfg.com.ar
Received: from [192.168.0.26]
	by sdfg.com.ar (chasquid) with ESMTPSA
	tls TLS_AES_128_GCM_SHA256
	(over submission+TLS, TLS-1.3, envelope from "rodrigo@sdfg.com.ar")
	; Wed, 14 Feb 2024 15:19:04 +0000
Message-ID: <7f1a6ae5-be6a-4ea2-b103-8a4a7e34bf44@sdfg.com.ar>
Date: Wed, 14 Feb 2024 12:19:01 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] tools/nolibc: Fix strlcat() return code and size
 usage
To: Willy Tarreau <w@1wt.eu>
Cc: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 linux-kernel@vger.kernel.org
References: <20240129141516.198636-1-rodrigo@sdfg.com.ar>
 <20240129141516.198636-3-rodrigo@sdfg.com.ar> <20240211104817.GA19364@1wt.eu>
 <52c52665-35f5-4111-a9d4-f8669c79bf70@sdfg.com.ar>
 <20240213070243.GB9530@1wt.eu>
Content-Language: en-US
From: Rodrigo Campos <rodrigo@sdfg.com.ar>
In-Reply-To: <20240213070243.GB9530@1wt.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/13/24 08:02, Willy Tarreau wrote:
> Hi Rodrigo,
> 
> On Tue, Feb 13, 2024 at 12:16:06AM +0100, Rodrigo Campos wrote:
>> On 2/11/24 11:48, Willy Tarreau wrote:
>>> Hi Rodrigo,
> I've read it as well and I don't interpret it the same way. I'm reading it
> as "if dst doesn't contain a NUL char before size, its length is considered
> to be size", and the reason is explicitly explained just after:

Very true, I mixed dst and source. Thanks!

>> How are you measuring it there?
>>
>> Sorry, I'm not familiar with this :)
> 
> Oh, sorry for not providing the detalis! I just remove "static" in front
> of the function. 

Thanks for the examples and heuristics to keep code small :)

>> I've been playing, but as I can't measure the size, I'm not sure what is
>> really better. I'd like to play a little once I know how to measure it :)
> 
> Be careful not to spend too much time on it, nm --size and objdump are
> quickly addictive ;-)

Haha, it is definitely addictive.


I'll share some new versions in a minute.

