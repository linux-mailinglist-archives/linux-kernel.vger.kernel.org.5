Return-Path: <linux-kernel+bounces-128318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BED37895948
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 18:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F7EB1F238D5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977031420CC;
	Tue,  2 Apr 2024 16:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="LWK3upwT"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC54136990;
	Tue,  2 Apr 2024 16:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712074103; cv=none; b=sC8R6aWGhPSyP08G6a9f4FzOr7HGlr8w9iMzreZDr82ZQkuZPkNZRpM7Ywlxka0pigo/I7UDc82RlcEN/WoP/7bBKw9uOSqEMo3XkOHWc0QY8Afh6G6mUzxCc67uHw77dE9vlYDwIqzOk0UUHefVas4fU6A/wrrwtYztwwXGg4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712074103; c=relaxed/simple;
	bh=23pqOOguUxwf+LlNromuawcHxktlPOCtCpPzM0ENPtI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=U7320wLkYk3WOetci8ThHdqH4S1maTaWOvM/xan7V3k4m+fTcRmkhMyMjSHkvTLJn4MFbOFbL238MQgwb3+AtQKpnvdWGNJwHHiW6Qf3POoU+8whYwBSJphqqPO2Zeim4Bam8JC+dm5JqhIolTme+91deqWsotw27re74HZdtBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=LWK3upwT; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 9FF5247C3C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1712074101; bh=23pqOOguUxwf+LlNromuawcHxktlPOCtCpPzM0ENPtI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=LWK3upwTNkKNQHwEia1hNlcwpjRg+QpVu/4dVwwvnol6g/XonRQE/Kq/h6+/Mjq7g
	 JumnRrJA/Gj2qQtrETtRIJjzyP8tIsp/ttgYNATOgzWcSnQUBSJakaWC7f/I/y0fla
	 f14iwDjScbHjc3PhV6az7p23WxYcAheUJx6a7hh00QVZhfAi/TLF45pLaLU9FVrQz9
	 M4rehryoyTe/7O/sZCPZpWImuCzyydB20oio1EXeegq+FEGP3nsmW4Ki1w8uihJAsH
	 eXB98prpB0pGc3YNe4l/hUW+q4WR/W0YxKGkfaEEM2d/H2I4RUWhtIOLMTaA3xiQ3l
	 HRg2krCW25+Qw==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::646])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 9FF5247C3C;
	Tue,  2 Apr 2024 16:08:21 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Niklas Cassel <cassel@kernel.org>, Frank Li <Frank.Li@nxp.com>
Cc: rdunlap@infradead.org, hch@infradead.org, dmaengine@vger.kernel.org,
 imx@lists.linux.dev, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 lizhijian@fujitsu.com, mst@redhat.com
Subject: Re: [PATCH v2 1/1] docs: dma: correct dma_set_mask() sample code
In-Reply-To: <ZgwnsEWQXluVsWm-@ryzen>
References: <20240401174159.642998-1-Frank.Li@nxp.com> <ZgwnsEWQXluVsWm-@ryzen>
Date: Tue, 02 Apr 2024 10:08:20 -0600
Message-ID: <87r0fnvjbf.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Niklas Cassel <cassel@kernel.org> writes:

>> +dma_set_mask_and_coherent() will never return failure when bigger then 32.
>
> Nit:
> s/then/than/

I hadn't pushed anything yet, so I took the liberty of going and fixing
this one, thanks.

jon

