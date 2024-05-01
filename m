Return-Path: <linux-kernel+bounces-165382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 988138B8C11
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 16:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBCFCB22B15
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 14:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8DB1F17B;
	Wed,  1 May 2024 14:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="WL1gquhr"
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE2012E6A;
	Wed,  1 May 2024 14:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714574570; cv=none; b=UEtTIi/VCG9OtiGxa5Ij33R8YFq/6aOBnJNhB7qJFKL5Yy1fk/vbwXl+5bCpnG5O0jk66V7rWMWqTAeb4gijQeQNVGnajJ13u//l4K75WL+5NdW1h6PHGCkmMb/EwYpejHBXx0Pj+x9JLshzQeP3SB9n1HSyPFRdwNzpw23oSBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714574570; c=relaxed/simple;
	bh=98uGFp/bAZhq4W2SfO2HB6U8NdV4ByxSy8YBzRNg37k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mpqYM5V/9u7KPRh9+Fr7FPek2uTnV2Tp9LY1IL8j1KQtitC/+nAZn3K19l6NooEi7Keczd1zkmNA7awMBHeSP6Cx8juuQy8LMsIGAuSFj4DfPz/OhcE1l98pApy75GFNqP+ohsh05jwaqZ4OuTMbY8XAOcF37B0KEnT/nyRocoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=WL1gquhr; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4VV0Ck12YVz6Cnk94;
	Wed,  1 May 2024 14:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1714574560; x=1717166561; bh=5gQX5q/13dAIh1NaKUWEnN6b
	Qh3K8BCraobwTeKxiF8=; b=WL1gquhrd3V7dzjyqVVT4yMbtPOOS+OUBF8YB1Ft
	+JbqyXxsJu+fNbAdE64LL2quRTZ5szJbH1VYPdnLaqPiXyXAZfkqY/z3ea0TjPtu
	cbH9QX5mna97fXZTsq/Ms7Zny9Gx9U7Fm7HazZGKwcdfPuUM8M7VUJGtWU2nqlL8
	6CqH36aiQ/h60kSqlb2wmlDIWPr4kMP5HjffmqXFBk6EenguZCa9glzzXtTj+ojr
	Ytx6J4keSZFz21vhJJ4SG+DkWgkOIfUqOT+neKj27DVaS4EdX9om+WqXPrFKCP5K
	9qMKykZtdBQ13MUz9JscNBfAqBP25uNpui8shY6J4I2CIA==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 0pmqkY6_0gab; Wed,  1 May 2024 14:42:40 +0000 (UTC)
Received: from [192.168.50.14] (178-117-55-239.access.telenet.be [178.117.55.239])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4VV0Cf55prz6Cnk90;
	Wed,  1 May 2024 14:42:38 +0000 (UTC)
Message-ID: <650ed9f6-fa50-4a3b-939d-633f9e389137@acm.org>
Date: Wed, 1 May 2024 16:42:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -mm 1/2] nilfs2: use integer type instead of enum req_op
 for event tracing header
To: Ryusuke Konishi <konishi.ryusuke@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-nilfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>
References: <20240430080019.4242-1-konishi.ryusuke@gmail.com>
 <20240430080019.4242-2-konishi.ryusuke@gmail.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240430080019.4242-2-konishi.ryusuke@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/30/24 10:00, Ryusuke Konishi wrote:
>   	trace_nilfs2_mdt_submit_block(inode, inode->i_ino, blkoff,
> -				      opf & REQ_OP_MASK);
> +				      (__force int)(opf & REQ_OP_MASK));

Please keep the enum req_op type instead of casting that type away with
"__force int".

Thanks,

Bart.

