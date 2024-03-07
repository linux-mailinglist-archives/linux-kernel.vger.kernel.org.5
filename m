Return-Path: <linux-kernel+bounces-96259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F35875965
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 22:32:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27E951F265D2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 21:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962BB13DB99;
	Thu,  7 Mar 2024 21:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oha3frPF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tq50TjM+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBCB13B7BC
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 21:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709847120; cv=none; b=gmGo2UUV83089FSZqwJlKc+kZNtSNkkyqclcibFnCWgrbAjgo7GzswOdgzP1zWp3EeNbzl7yIpfCi87hycp+argxhiZBk46sigECMc3KJRBEejlfJONXvxrEuWvAnakfxc8yaA98+ZyuEzGOaE+l45B75DCXS5rABHXkRhGGwuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709847120; c=relaxed/simple;
	bh=0c3EqmFBxzx+Pi5NdpcntUOYhbiCkTM++ae8l7XVHFM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=B+1dKumJ5OuDopC+IlModBuh0HzEp+yfvDMWQcRy60sSvy8pJuHJzs0VUdCO43Escu00tK2C2XD+lEss4R9cAxVwUv1XUMelA2bg96/oCMnEE+hqQuwEF5xHOTVocxtk2AghKh7DV6HBncslysfhounca7c0bGjtc3kkwG7dD2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oha3frPF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tq50TjM+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709847117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QfgcBRPKSBvdMdEI3H9cjtQssr5Yeco6kuE77aOhTtI=;
	b=oha3frPF/+IrEqbtW/0QSSCZvzsPNZY0ypsLOz8ttcHlKmC7tLPhCDex8JFWshQHsTkoWO
	Isb5zeZY74q7LSm6AInMEuH2MOLzXgB0ylkSgtz9ov1t9F+x3IVf8AL+hkwCeFBbVJrAgW
	i6EOzHqHsJLBk4cRuFtJyWCtTKZPiA7KURZ92EZ3+2aLDNqqJymtkrK2Ox7JhyBpvlhYCW
	3yD6zv4cIbpIxvuHOYtGBcpUt1V85kDbTP/VHHd5EBxVvX/aCEn7NaIjMuyHEnNffdkIMn
	DLvfji3VmSssx+PlH/YkEl5QlJNnMA83If2Ued542Cg2ZxBMM/fk/L9ls+DPlQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709847117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QfgcBRPKSBvdMdEI3H9cjtQssr5Yeco6kuE77aOhTtI=;
	b=tq50TjM+CUpaOTD+9KJHE8GBKwZWEe2L+CYKg2bYZO14o02QPE/9dHVzr/vlfgmJSz1nW8
	GVBxqsO0wWOjL8DQ==
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, LKML
 <linux-kernel@vger.kernel.org>, Daniel Bristot de Oliveira
 <bristot@redhat.com>
Subject: Re: [RFD] Remove irq_timings
In-Reply-To: <CAPDyKFpnh8nUNXtWUueisExtfabawhsjtEGTnH7RxKeD7=03dQ@mail.gmail.com>
References: <875xyqg2yr.ffs@tglx>
 <79fadb9b-c4c8-4727-b812-7e519556cce1@linaro.org>
 <CAPDyKFoynM_gN=tzsWnE_xAgmy6R8Hie-_yO5zoJTjwNjR38Hg@mail.gmail.com>
 <87jzn5eqej.ffs@tglx>
 <CAPDyKFpnh8nUNXtWUueisExtfabawhsjtEGTnH7RxKeD7=03dQ@mail.gmail.com>
Date: Thu, 07 Mar 2024 22:31:57 +0100
Message-ID: <871q8lu3si.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Mar 07 2024 at 12:54, Ulf Hansson wrote:
> On Thu, 15 Feb 2024 at 15:46, Thomas Gleixner <tglx@linutronix.de> wrote:
>> No. I just stumbled over it (again) and wondered whether it is ever
>> going to be used or not. If not there is no point to carry dead weight
>> around, but there is no hurry.
>
> Maybe a small chat about it at the next LPC? Then we can see if I have
> been able to play more with it.

Works for me.

Thanks,

      tglx

