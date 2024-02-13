Return-Path: <linux-kernel+bounces-63504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96AA985307F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 13:29:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C94811C230BC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6B63E485;
	Tue, 13 Feb 2024 12:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RywdmwzX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AiirTZyZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0675B3D971
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 12:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707827382; cv=none; b=Sipr2qnnp2CDilpHZrxVutUD8cOKFzd3a1kiEnQrT2OOc7Sp38a6bEVdNW6kVaW8rMwhb792J3YDfsxgk6ecPB1+UOPpbXM2dRdQOG4PCpMEDem2XtkSnbjRyIBfb33iH0PhHKm1x1Q7cnHvbWqWtYMjVAwCEU0uwLiCnZxITUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707827382; c=relaxed/simple;
	bh=K+XjohJm9zjC5uAAvjaxZ/IRTygND0lsBRH0mqZpWvc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Owl1DntcASsk2ye1CplgPUyqZUfcKTP0zN2WgAX3j3u/EsqXsblL233vb7hNtQhhKQq9bXuoHcWw8d1OBHtVdGZPer4lXmGyanwJ15HoDCa6jpVqUC8Sm98UdoJJBM0pqdkdP1IZjDGEJwfz/IjrubnEyWGp18MCeUFDyNDAE3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RywdmwzX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AiirTZyZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707827379;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PbEJo2sK2vhPqKtfaiyrgM5WT9LOsasYodgJE8KMnCE=;
	b=RywdmwzXv5qSDVREI8QsT+1d7mrvdQ/WTh0dT9RNmfoFI5bcXDQlFw6HEIrS14LOqw6dMD
	8PLLme8gLhbT3dRW+TXj2tMWlUqNTqe7sof5FC+edSzc4EFPVXCF2UN/hGo3WT5LT3hUZb
	Er3kzNmvwNN0WJHgUG6ZBd6/mzFNpY+t3pTKFIykqCKH12YlJUcI3v8VWywHXhOo44l513
	DltStizVyaYW7xhbgOtomrECaCGy1BgoEzOoJV5KHkmT00MG5pHEB6a2GHd/PIJbesZFSZ
	DXUmJp1NGSBf47tCHTkMQIoywLdMrIsUG+PVd+Ts5VDG7dgM09ePkWTAOmm/mQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707827379;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PbEJo2sK2vhPqKtfaiyrgM5WT9LOsasYodgJE8KMnCE=;
	b=AiirTZyZL83FQp/o5TapCme7C0pMvIX1IQvUbJUVPmBno7EwWtzxiPMnNYL+PQF2hVD/BE
	BFnwRkKjzdHB06DQ==
To: John Stultz <jstultz@google.com>, Pranav Prasad <pranavpp@google.com>
Cc: sboyd@kernel.org, linux-kernel@vger.kernel.org, krossmo@google.com
Subject: Re: [PATCH v2 1/2] alarmtimer: Create alarmtimer sysfs to make
 duration of kernel suspend check configurable
In-Reply-To: <CANDhNCovFCekU3wKYNMZWNgcr1=yyDnKNoehXe-x3Ep6-c58eg@mail.gmail.com>
References: <20240208195622.758765-1-pranavpp@google.com>
 <20240208195622.758765-2-pranavpp@google.com>
 <CANDhNCovFCekU3wKYNMZWNgcr1=yyDnKNoehXe-x3Ep6-c58eg@mail.gmail.com>
Date: Tue, 13 Feb 2024 13:29:39 +0100
Message-ID: <87r0hgh7ik.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 09 2024 at 12:01, John Stultz wrote:
> On Thu, Feb 8, 2024 at 11:56=E2=80=AFAM Pranav Prasad <pranavpp@google.co=
m> wrote:
>>
>> Currently, the alarmtimer_suspend does not allow the kernel
>> to suspend if the next alarm is within 2 seconds.
>> Create alarmtimer sysfs to make the value of 2 seconds configurable.
>> This allows flexibility to provide a different value based on the
>> type of device running the Linux kernel. As a data point, about 40% of
>> kernel suspend failures in a subset of Android devices were due to
>> this check. A differently configured value can avoid these suspend
>> failures which performs a lot of additional work affecting the
>> power consumption of these Android devices.
>>
>> Signed-off-by: Pranav Prasad <pranavpp@google.com>
>
> I might suggest flipping the order of these two patches, as I'm more
> wary of UABI changes, so I don't want to hold up the second patch on
> interface bike shedding.

Correct. It's an orthogonal issue and an optimization on top of the
early check.

Thanks,

        tglx

