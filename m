Return-Path: <linux-kernel+bounces-101552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B54AE87A8A0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 14:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70037281D12
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 13:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D229941232;
	Wed, 13 Mar 2024 13:44:05 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DA040872
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 13:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710337445; cv=none; b=IXrscjx9x4G+O6NCAeLtxO/GuQA9I5oPYwuPxYflR0DdxE/sFgiDV4ae0+mI8NEDH13XPPIeGGr2vG9CAHnH1pEaxILjSNsstrmMqMeNghM+Qy7UFofe8VzHTmv7enWvbExSVWKKsofZl5ia6gUyXpZW6WOqZKEt9NimkBuaENk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710337445; c=relaxed/simple;
	bh=k3FXLqgWmUFo8cDlorJgat0uASGMvswchYqV5m9L6fQ=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=HISimtXxcAw21mYAkoo9hi/pjRQ9GaFyrCTVrjQhGk5qYp6H71JMo9CJgakSYcIhXS0FOgtAqRUmOQwBwknJQyzfBzSvAmWRBGLOjIjz4AfcY0nSDJOuObIAYiBJiTqCRJ46uNUr46NJJa5vpGCQhs7VQjlm3X5ylTYmtuzFRnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TvsDD3nMcz1FMJR;
	Wed, 13 Mar 2024 21:43:40 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 580CE1400FD;
	Wed, 13 Mar 2024 21:43:56 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 13 Mar 2024 21:43:55 +0800
Subject: Re: [PATCH] mtd: ubi: avoid expensive do_div() on 32-bit machines
To: Arnd Bergmann <arnd@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Richard
 Weinberger <richard@nod.at>, Miquel Raynal <miquel.raynal@bootlin.com>,
	Vignesh Raghavendra <vigneshr@ti.com>, Daniel Golle <daniel@makrotopia.org>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20240313084707.3292300-1-arnd@kernel.org>
 <4f945f4a-ac29-3ef7-9e15-123962f2a0e9@huawei.com>
 <e0684202-6926-4bd1-86f6-2bb682524712@app.fastmail.com>
 <1a12c8ed-0cb5-5650-24a2-84b021c444c3@huawei.com>
 <b08aaae4-8c69-47eb-9658-5f3f5c8e4056@app.fastmail.com>
 <610231c3-c3ee-e543-1a8a-8e1098ee6a7c@huawei.com>
 <21cd0f32-c94b-4b2b-8fa6-ebe12756b0c4@app.fastmail.com>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <ecc5d070-a773-1180-b50c-59088b23695e@huawei.com>
Date: Wed, 13 Mar 2024 21:43:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <21cd0f32-c94b-4b2b-8fa6-ebe12756b0c4@app.fastmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600013.china.huawei.com (7.193.23.68)

在 2024/3/13 21:39, Arnd Bergmann 写道:

>> Thanks for explaination, which means that do_div is used for 64-bit
>> division to solve the link failure caused by missed libgcc. Since
>> parameter 'from' is u32, there is no need to invoke do_div on a 32-bit
>> platform, you just want to stop the wasting behavior on a 32-bit
>> platform. Do I understand right?
> 
> Yes, correct.
> 
>        Arnd
> .
> 
How do you find it? I mean there are so many types and many do_div 
callers, do you have a static check tool?

