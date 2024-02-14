Return-Path: <linux-kernel+bounces-66025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A93085558A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 23:07:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD4DA1C20B38
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 22:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD95141993;
	Wed, 14 Feb 2024 22:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="btJEAflX"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB9613EFFE;
	Wed, 14 Feb 2024 22:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707948425; cv=none; b=tO1sN1g3RDOfZU56s7XLr0uj2l1owcvDAtoJxFY3w5OWzqd0DjJdKtKFCppIonk4yNf95ppDqyOaNH8BGBl2tH11dH3aJqzgjnpeQ/idaBwL5Qo8bq0gS9vizoTa6kl9rtKzPRIKfIz3rcYJ8UHIna68zTssXSY02EO7D51siYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707948425; c=relaxed/simple;
	bh=aix0FqqDegJfqcNO9XdPVBl5grLqx3B0T2kNMQA0DFw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=p/e5dwGVl9AZc1CwJzKWbO94zS36pb65CW0TK7AssPOlcf86no/3KsxeapJLcCgrmV7uzON68sEQcwE4ooLZ7bK49LI20nNqrTpEBuuXS96DngyUn4vR2DDpv0xGkk/p1C6cYTtqD6RgCBCTBYJpkomS1XiTqx1/6hAt8Br8ZLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=btJEAflX; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 6E01742A45
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1707948417; bh=aix0FqqDegJfqcNO9XdPVBl5grLqx3B0T2kNMQA0DFw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=btJEAflXWsVdFlM1rBcmrSGNyYw1KQKJl1Z3VRcjZgbPQKfaET71njsfQC92EoCtx
	 tXtCNeOr4KZxVotQRbXMBYSNp/vdURLGapdKsl8+iEUEu89FBq8lj5OlzEV+08cY5l
	 yPIhBTh41svqSp0ioORWG2/ae/ybiYU75zbcoX6Op9vo0X0BxYtodCwd9gDEJlTGKD
	 SWe2nBj0gDq7+jjPRBhLu1H8KnJOfm3LHhFAS9JPDIDHLqpjCduXBg+7u7WS2wMjdN
	 d02vMko2CSPDayIUtlzNBhQTyHh7i1OCWb8qUE9U48fr+5OCIIaXhQgrynqEdh/aqz
	 KYps049pOiPeA==
Received: from localhost (unknown [IPv6:2601:280:5e00:625:67c:16ff:fe81:5f9b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 6E01742A45;
	Wed, 14 Feb 2024 22:06:57 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Trilok Soni <quic_tsoni@quicinc.com>, Carlos Bilbao
 <carlos.bilbao@amd.com>, Greg KH <gregkh@linuxfoundation.org>, Jeffrey
 Hugo <quic_jhugo@quicinc.com>
Cc: avadhut.naik@amd.com, alexs@kernel.org, iyanteng@loongson.cn,
 2023002089@link.tyut.edu.cn, quic_bjorande@quicinc.com,
 linux-arm-msm@vger.kernel.org, workflows@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: embargoed-hardware-issues.rst: Fix
 Trilok's email
In-Reply-To: <4d36cb5f-141b-5e01-783e-47059d0d5083@quicinc.com>
References: <20240202164119.4090703-1-quic_jhugo@quicinc.com>
 <2024020223-eskimo-armoire-a517@gregkh>
 <78af3df9-693f-49a5-b6bd-02a146506e7e@amd.com>
 <4d36cb5f-141b-5e01-783e-47059d0d5083@quicinc.com>
Date: Wed, 14 Feb 2024 15:06:56 -0700
Message-ID: <87plwyzon3.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Trilok Soni <quic_tsoni@quicinc.com> writes:

> On 2/2/2024 9:06 AM, Carlos Bilbao wrote:
>> On 2/2/24 10:48, Greg KH wrote:
>>> On Fri, Feb 02, 2024 at 09:41:19AM -0700, Jeffrey Hugo wrote:
>>>> The servers for the @codeaurora domain have long been retired and any
>>>> messages addressed to @codeaurora will bounce.
>>>>
>>>> Trilok has an entry in .mailmap, but the raw documentation files still
>>>> list an old @codeaurora address.=C2=A0 Update the address in the
>>>> documentation files for anyone reading them.
>>>>
>>>> Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
>>>> ---
>>>> =C2=A0 Documentation/process/embargoed-hardware-issues.rst=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2 +-
>>>> =C2=A0 .../translations/sp_SP/process/embargoed-hardware-issues.rst=C2=
=A0=C2=A0=C2=A0 | 2 +-
>>>> =C2=A0 .../translations/zh_CN/process/embargoed-hardware-issues.rst=C2=
=A0=C2=A0=C2=A0 | 2 +-
>>>> =C2=A0 .../translations/zh_TW/process/embargoed-hardware-issues.rst=C2=
=A0=C2=A0=C2=A0 | 2 +-
>>>> =C2=A0 4 files changed, 4 insertions(+), 4 deletions(-)
>>>
>>> I think we need an ack from Trilok for this :)
>>=20
>> Assuming ack from Trilok, regarding the Spanish documentation,
>>=20
>> Reviewed-by: Carlos Bilbao <carlos.bilbao@amd.com>
>
> Looks good to me. Thank you.
>
> Reviewed-by: Trilok Soni <quic_tsoni@quicinc.com>=20

Applied, thanks.

jon

