Return-Path: <linux-kernel+bounces-65682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A02185505D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:32:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EE5F1F225A2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9111D85265;
	Wed, 14 Feb 2024 17:30:39 +0000 (UTC)
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFB97D418;
	Wed, 14 Feb 2024 17:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707931839; cv=none; b=rrEz999gGkT9K/XLkAqGx0zSNzBj/VGpNZhzv8Moeb2ivhJoQcZ0tDTk8/Q1HzVZ1kEShbKT1MCHDPI9Ox9roLnaxYl4GFVKB/VMLsxF4XmKgKKsBvuF5PZdOuNNE/tl71MFRXnJ7P/DEtQn/WVXKhWIqNbGVM+PKIMAhF+16WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707931839; c=relaxed/simple;
	bh=BFo+fUsQbhvTcAAh/NibHj4MU8E7arHXI/XnKbwQbss=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BOYhzd4YTucJB3XtDVv4OImy9myBgozlGT4Y8r36bw2nHtm/2fqCMl6bDVFfkJWGJfDl9Hldo9q3TCNFAEVY7+IVgKOI2Slnv9PyUfHIQMDUupVnFKKH+t4cYWs49lYU9/40+uSU7cXxrI2/fUAbakHryswlp+ro3L6KBBGSjUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: by air.basealt.ru (Postfix, from userid 490)
	id 784922F20241; Wed, 14 Feb 2024 17:30:28 +0000 (UTC)
X-Spam-Level: 
Received: from [192.168.0.103] (unknown [178.76.204.78])
	by air.basealt.ru (Postfix) with ESMTPSA id 513142F20256;
	Wed, 14 Feb 2024 17:30:26 +0000 (UTC)
Message-ID: <1044d472-c733-3901-9df9-41a29b2c9fb4@basealt.ru>
Date: Wed, 14 Feb 2024 20:30:25 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH ver.2] gtp: fix use-after-free and null-ptr-deref in
 gtp_genl_dump_pdp()
Content-Language: en-US
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 edumazet@google.com, laforge@gnumonks.org, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, nickel@altlinux.org,
 oficerovas@altlinux.org, dutyrok@altlinux.org, stable@vger.kernel.org
References: <20240214162733.34214-1-kovalev@altlinux.org>
 <ZczvJKETNyFE5Glm@calendula>
 <a4463193-fd73-eca3-616b-d75176d947c6@basealt.ru>
 <Zcz0tG9XMqLHMKs+@calendula>
From: kovalev@altlinux.org
In-Reply-To: <Zcz0tG9XMqLHMKs+@calendula>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

14.02.2024 20:13, Pablo Neira Ayuso wrote:
> Ok, then a series of fixes probably needs to happen so each maintain
> can review and apply them.
>
> Maybe some of these subsystems above can only be compiled built-in, so
> that cannot trigger.
>
> In any case, are you up to pick on that series?
>
> Thanks.
Yes, I can prepare several patches with the same commit message. Is it 
better to send them individually (like this patch) or in a series with a 
brief preliminary description (PATCH 0/x)?

-- 
Regards,
Vasiliy Kovalev


