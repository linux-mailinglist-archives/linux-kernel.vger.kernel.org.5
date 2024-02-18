Return-Path: <linux-kernel+bounces-70563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F1D85992E
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 20:58:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CCE7281370
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 19:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A419971B2B;
	Sun, 18 Feb 2024 19:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VeWCQl+c";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="drctSBOo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FBD6F060
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 19:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708286329; cv=none; b=JlxmZFTPq9IyfjRvCWG07fVLca3vqq8WL14oZaAwXBsx1+jtaOA6VkWxSDA0ZhS8LjUVWQhW3o/QN1L/n0WnHvweN3xGNqjo8oX/7aBA0j5U4yRp/JOUMXQLZdYEPql/1liU3Eqird/1Hlh/rxRllwBUJYO5dAzTXtzo5zkEIok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708286329; c=relaxed/simple;
	bh=LVq7wL5w79lHBLiMpD3VDi5h8Q2ZtCNMBxs7RuaxEWg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NhZt6mCSNvZgh/h88rfLOM7zXYGs3XvzkQ67zTv9ed1Mai4W4IHMXYQcJ1O0Z3M31WWD7QU+palteFKDNmLb50R5khg7dvupVbZEV13heRxa1dNZ5deYQ2YdJe+zyZmepcbTSgL3Qw8vYrjvCKFCwBJtO3bZvFjXwNTR5x+P/kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VeWCQl+c; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=drctSBOo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708286325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1TIkhbGZWUbi2CMyuYC1zHRmB3sv78+cLqqJ5ekH0lE=;
	b=VeWCQl+c9hJoUJ4b6+6B7ZZq/HPBCmR6V1VCu4PqNsMkbqahjPCBd1nl3m43x1TyQl9avB
	ytfOKr3eSdCmwrQiEKMm7nWcVokHb3LtmPSncIpIdXAIrs+ft+OMqcNP/5uscz9MDypioy
	aEPb3VO2pUdzqm3rw7cyka1/iZCeZ0wc6P7zpViI8JPqrhmd8VYsvQ4Kh0tSNx5mjd59x/
	Fmum4Az7cnQydasHhZVcJ+m4DpS4XP+o33Mcw4bFXVRiSfgMqye2WoEK6KcoihMxCRtv3Z
	Wge0GpQWJg+kWp5cuCK2X/V9BBIMsPMHFY4RjdIlLrI3gzLppD7pBkyvwtkHHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708286325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1TIkhbGZWUbi2CMyuYC1zHRmB3sv78+cLqqJ5ekH0lE=;
	b=drctSBOolE06j7lN0n6V7r5M2yMlqxRpP5ChXrgl3Zijr9hI+9arVHJBWRwiCXHqx+bq/b
	SqxsHCWzODTwWpBw==
To: "chenjun (AM)" <chenjun102@huawei.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Cc: "xuqiang (M)" <xuqiang36@huawei.com>
Subject: Re: [PATCH] irqchip/mbigen: Fix incorrect null pointer check
In-Reply-To: <45fe193a87fc4a5cb2e3233386b47dc7@huawei.com>
References: <20240129130003.18181-1-chenjun102@huawei.com>
 <874jecisku.ffs@tglx> <45fe193a87fc4a5cb2e3233386b47dc7@huawei.com>
Date: Sun, 18 Feb 2024 20:58:44 +0100
Message-ID: <87a5nxbl3f.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 18 2024 at 03:13, chenjun (AM) wrote:
> =E5=9C=A8 2024/2/13 18:09, Thomas Gleixner =E5=86=99=E9=81=93:
>> On Mon, Jan 29 2024 at 21:00, Chen Jun wrote:
>>=20
>> That's not about an incorrect NULL pointer check. That's about using a
>> function which is guaranteed to return NULL on your platform, no?
>>=20
>>> bus_get_dev_root(&platform_bus_type) always returns NULL.
>>=20
>> Lacks an explanation why this always returns NULL.
>>=20
>
> Thank you for the reply.
>
> bus_get_dev_root returns sp->dev_root set in subsys_register.
> And subsys_register is not called by platform_bus_init.
>
> So, for platform_bus_type, bus_get_dev_root always returns NULL.

Please add this information to the change log.

Thanks,

        tglx

