Return-Path: <linux-kernel+bounces-166646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 579DE8B9D87
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 17:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7392CB23E84
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 15:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A8815DBB9;
	Thu,  2 May 2024 15:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vcz9AVg/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B4815B54A;
	Thu,  2 May 2024 15:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714663971; cv=none; b=Gt0oMFHcacAlyOzw1VFQWWN5MNxoWvUBVDtaXHQkSkg0U0tcmiVcjSMHN0i06CZErhWYBOsrjEVKDrKP8V1XNmRUXnzoJ6awzauDcIcRvLbcXc7P88grLOXqq1fNMOAP5WqcJCj0pxRApdv2Tsd9AAywS7HVrerPU6v/mZAjuZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714663971; c=relaxed/simple;
	bh=bf/1e5X6MQnq+5zpLbTrl3tKRyd+voc6WKWYkkFNtZk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nZill3ze8p9/b12MDTbSeFJ4wW11KlfN2UXCv+AgsSZkMm53q6peNNUCAaY3e8pJE7KDXXWSIs/3Cmqjpufq5NASy5DJDsaYKNn9/ea24/5QJOrfJ2irjbtAY9f7vmkmVpDnueIJmq98vla6WesbInD5StYqluQm87/MMAt0noU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vcz9AVg/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8F29C32789;
	Thu,  2 May 2024 15:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714663971;
	bh=bf/1e5X6MQnq+5zpLbTrl3tKRyd+voc6WKWYkkFNtZk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Vcz9AVg/dymJQbxR4piY+k7MV/Lyu4r7eibWtHV2H1a/o1EXqD0PzDBaS/QGmfiL1
	 qIz6psfCUTDYZRCrI+CNapN2sMepRa7i78zeLceILwHrMKw1rYbjocqKD2wJqEgvPB
	 cDN29hfkd9gYt35gNZ2HSNUVwiDbni4cljRAZRQ29I4tChV/BK/fm/BZFUIhhY1Fg8
	 4pHwIhSvTa9+i2x3/8jo1QDuDCC+7CZcFAsTW0Fl/yQyRsytRha+o7eaqfCUfBkBCU
	 awZkqfupbDxyFPgA//U8Zz04BoEyHMklZLXcVo0+ApL0fZhe62rYF8dpF+A+7lvTqs
	 XLGWLAnOFSyjg==
Message-ID: <97db72b7-a336-4114-9012-c77493c239e8@kernel.org>
Date: Thu, 2 May 2024 09:32:50 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next v5 3/6] net: add code for TCP fraglist GRO
Content-Language: en-US
To: Felix Fietkau <nbd@nbd.name>, netdev@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: willemdebruijn.kernel@gmail.com, linux-kernel@vger.kernel.org
References: <20240502084450.44009-1-nbd@nbd.name>
 <20240502084450.44009-4-nbd@nbd.name>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240502084450.44009-4-nbd@nbd.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/2/24 2:44 AM, Felix Fietkau wrote:
> This implements fraglist GRO similar to how it's handled in UDP, however
> no functional changes are added yet. The next change adds a heuristic for
> using fraglist GRO instead of regular GRO.
> 
> Acked-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> ---
>  net/ipv4/tcp_offload.c   | 21 +++++++++++++++++++++
>  net/ipv6/tcpv6_offload.c |  9 +++++++++
>  2 files changed, 30 insertions(+)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>


