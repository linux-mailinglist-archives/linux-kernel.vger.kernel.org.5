Return-Path: <linux-kernel+bounces-109750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A94188553A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 08:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CF481C20CD6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 07:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838C95820D;
	Thu, 21 Mar 2024 07:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=email.cloudflare.net header.i=@email.cloudflare.net header.b="j2mc34hv"
Received: from rosemary.ibugone.net (unknown [202.38.75.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22313A1DE
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 07:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=202.38.75.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711007965; cv=fail; b=qrG1qO5ryw3+a0795Mbk18Iw/4SK4LTsTKWZOWUseCgxNaVllxPXv0jH2hFisS+BwR+Vm3E4Z+ZPL25zs3Es/u/NJRkNcPrtsr1TurKdsPSz4vkuSgS7/Vck6d+xhpH8lXzLbGxACiWt+6EYtQmT2rtabiUEsbtTTvWQkchG7eU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711007965; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=quZBfq4MFPXGC04iNw9Nqm2xBBKAEIPOSd9J+6rxm2k8jLJcrJhv8cQmwr2wGlsbWFQqKDotgDJIkNNWW8pcRQBAiNyJi9tY0E6QVoDCdoaNJXjjo18k8EFChefw+Cmw8llejAq8kwOriaCxv9LMflrHgHz5vPANWRqC1MWWQBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=ibugone.com; dkim=pass (2048-bit key) header.d=email.cloudflare.net header.i=@email.cloudflare.net header.b=j2mc34hv; arc=fail smtp.client-ip=202.38.75.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibugone.com
Authentication-Results: rosemary.ibugone.net;
	dkim=pass (2048-bit key; secure) header.d=email.cloudflare.net header.i=@email.cloudflare.net header.a=rsa-sha256 header.s=2023 header.b=j2mc34hv;
	dkim-atps=neutral
Received: by rosemary.ibugone.net (Postfix, from userid 1000)
	id 8460B7A289F; Thu, 21 Mar 2024 15:59:14 +0800 (CST)
X-Original-To: ubuntu@rosemary.ibugone.net
Delivered-To: ubuntu@rosemary.ibugone.net
Received: from i-bie.email.cloudflare.net (i-bie.email.cloudflare.net [104.30.8.184])
	by rosemary.ibugone.net (Postfix) with ESMTPS id 87DB27A186F
	for <ubuntu@rosemary.ibugone.net>; Mon, 18 Mar 2024 05:39:30 +0800 (CST)
X-iDebug-To: i@ibugone.com
X-iDebug-From: hch@lst.de
Received: from verein.lst.de (213.95.11.211)
        by email.cloudflare.net (unknown) id VKCe5lr9PK7b
        for <i@ibugone.com>; Sun, 17 Mar 2024 21:39:25 +0000
Received-SPF: pass (mx.cloudflare.net: domain of hch@lst.de designates 213.95.11.211 as permitted sender)
	receiver=mx.cloudflare.net; client-ip=213.95.11.211; envelope-from="hch@lst.de"; helo=verein.lst.de;
Authentication-Results: mx.cloudflare.net;
	dmarc=none header.from=lst.de policy.dmarc=none;
	spf=none (mx.cloudflare.net: no SPF records found for postmaster@verein.lst.de) smtp.helo=verein.lst.de;
	spf=pass (mx.cloudflare.net: domain of hch@lst.de designates 213.95.11.211 as permitted sender) smtp.mailfrom=hch@lst.de;
	arc=none smtp.remote-ip=213.95.11.211
ARC-Seal: i=1; a=rsa-sha256; s=2023; d=email.cloudflare.net; cv=none;
	b=gXWiobRxXOifIyYnxlJXqu7rrW1pvUW75fJIMt4EU39/H1Eu7ZNBPH27wVd3Y5Q0sqSwZwT5w
	5GBsnI2sjNfbEHkmdO24jhB2YpCVdwNrPQDulRFnZGeJdYBpksCPC5QPoQyJaUmlZVFa+hfi048
	iSVy7AQrjcW5rEDq/J9f7Aig1RHxTaMsrL6UIjqIc8QjUvM5ouQ4OoklkC6Z+6Dd/ljYScPV09J
	Wji8bsAlxSXE1VvH2pl87vsPgeWxy5vMr4tirFbpyRe0riYtpSmj374fkWdG5GnnTCpmusW+VnC
	4ci4wCwYYP12SjljTi6N5jQC1dexGxK5Hqy7OZJuy/9g==;
ARC-Message-Signature: i=1; a=rsa-sha256; s=2023; d=email.cloudflare.net; c=relaxed/relaxed;
	h=In-Reply-To:References:Subject:Cc:To:From:Date:reply-to:resent-date
	:resent-from:resent-to:resent-cc:list-id:list-help:list-unsubscribe
	:list-subscribe:list-post:list-owner:list-archive; t=1710711566;
	x=1711316366; bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=XkNRWBfF8h
	DA51pyZI+zYpy8e9aVNLDrN9vLyURaa/E/sIMNud0FhiuwON7oo8owbPiJ2W1ZeRWFb2yU7vQz4
	cEKOA71LL9TGndv4o5LiQN0R0EO8VBscAvxm760PW6jMX884t1+74KNnXQbEkzBFF8tZBbRo4qV
	c4T2grRD4LYodLfyjBdC2QLlTJ76q6ue2/s6VzO0gjlDyy5RL/W215NAVcvdSbF3M49gl5u97Wk
	jSSnqGfyBi37WWnzIqGQ+MueWWvZ/ejZhcZmYgWZhGDCbWl5xPhcUmWaLMsn06Mn3M02WxIxP8V
	CDPke+X/mfK0xKhxhKutUJXK1Jq0lKOA==;
ARC-Authentication-Results: i=1; mx.cloudflare.net;
	dmarc=none header.from=lst.de policy.dmarc=none;
	spf=none (mx.cloudflare.net: no SPF records found for postmaster@verein.lst.de) smtp.helo=verein.lst.de;
	spf=pass (mx.cloudflare.net: domain of hch@lst.de designates 213.95.11.211 as permitted sender) smtp.mailfrom=hch@lst.de;
	arc=none smtp.remote-ip=213.95.11.211
DKIM-Signature: v=1; a=rsa-sha256; s=2023; d=email.cloudflare.net; c=relaxed/relaxed;
	h=In-Reply-To:References:Subject:Cc:To:From:Date:reply-to:resent-date
	:resent-from:resent-to:resent-cc:list-id:list-help:list-unsubscribe
	:list-subscribe:list-post:list-owner:list-archive; t=1710711566;
	x=1711316366; bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=j2mc34hvFA
	8/QAw2/nq7Nt+wC2w1+8RGql8DcuDyMz+OTBKjNByQ6Vi+mwNAijynrKVMWq5YhKfxDV0qwt36p
	qBTZ+VNOfnajajd4yZkgDHUabulJO3iLT9yErqZjoSzfit/STuoaFmH7k6y+KPxaViMBLcEYUD4
	HihzHQHfAXf2DTFphtMbGg0VeUIRTDzD0MkM653HLeJqKKXYa+/VIIi+mOg2iUXRfkVJ/rUHY2K
	FHlaeIvEhDFelvGrfyA9/byRN861Cas7lHAgKIgzMbetRQbW1dMpoef3ZkDk5xfrnciSNREmCrN
	/o8Edz1luSWoouWZEo0SVk7YltUqcyyg==;
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1D3FA67373; Sun, 17 Mar 2024 21:23:01 +0100 (CET)
Date: Sun, 17 Mar 2024 21:23:00 +0100
From: Christoph Hellwig <hch@lst.de>
To: iBug <i@ibugone.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/nvme: Add quirks for device 126f:2262
Message-ID: <20240317202300.GA5593@lst.de>
References: <20240315192747.1749119-3-i@ibugone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240315192747.1749119-3-i@ibugone.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Status: RO
Lines: 3

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


