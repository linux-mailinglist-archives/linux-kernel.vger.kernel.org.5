Return-Path: <linux-kernel+bounces-101724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B48B787AB05
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:24:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C81F1F22D3D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3248B482D1;
	Wed, 13 Mar 2024 16:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="NSI9SwQL"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CA6481D0
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 16:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710347073; cv=none; b=NhnI8lhyQ/2Fd2YcXYBlyrxcXv//0nm313i7dCYnwWx7d2xKpVt0tviB00N6JJYscV94Uu2Nisvo0mv+fSvpCGDbQNdq+PEfxop4ZvuaZw/52BD0u2KDfo1ki2O3FaeAGxK6Qy6XhlcJW2Mf4qgIBYpA1wgAASarpIsAwEigr2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710347073; c=relaxed/simple;
	bh=PBnvN89TcXRBQ8oX99GovCTrRkyYDZspIJ40zlbYcq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GpxLA3LXKCcqnLmUGmjvYKuXhlKILwuWoTeEAzrbd4hlxqWJE1uKZdfy34VNetzlqrFuth5GNqu0YLnb2Hv6IB44VSNusOlJlDZ/FvzC5+iZZPihGiYpB238KvrLAlDy0bOVX+s66dcsw2XL4KLyVU7TUKYAOexxPoddcBxAvSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=NSI9SwQL; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710347070;
	bh=PBnvN89TcXRBQ8oX99GovCTrRkyYDZspIJ40zlbYcq0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NSI9SwQLPyfUvrLVdDBXkZAsMalEMg8xb0jAkCqVjAc0HFz94zKHFjHSpUs5RPgq9
	 bAaR85p3hK5HeRCMs/aAH06zfZ43c55OzixUtqZr3BgydhnLx2rnHeecasUjxIScYS
	 4RqeXAEt7O7Xl2601NOeT1ofddUd49F8pIDMa8QXdmbuUcJBUoLZjizmXzMoyZWBu2
	 B4HbbGnnPveo5AlufJl71ek48IHNQ6HwykJhiyCEH23Yej2XF3Mh00FRKdBjQ3q8b3
	 HgOaioOG4yDPPmHVevQz3BP4qwP44MBpuLjnAif+Jb5mntdpIIOpc0pQIpjC6VQjAP
	 /ha3GCZWG51Xw==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sebastianfricke)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id AE7A83780B5F;
	Wed, 13 Mar 2024 16:24:29 +0000 (UTC)
Date: Wed, 13 Mar 2024 17:24:27 +0100
From: Sebastian Fricke <sebastian.fricke@collabora.com>
To: Marc Zyngier <maz@kernel.org>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de,
	bartosz.golaszewski@linaro.org
Subject: Re: RFC: fake IRQchip
Message-ID: <20240313162427.lgvfvo7u6phdsbb7@basti-XPS-13-9310>
References: <20240308143755.jey6kr3ftlzxt6lg@basti-XPS-13-9310>
 <874jdfrabn.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <874jdfrabn.wl-maz@kernel.org>

Hey Marc,

On 09.03.2024 10:03, Marc Zyngier wrote:
>Hi Sebastian,
>
>On Fri, 08 Mar 2024 14:37:55 +0000,
>Sebastian Fricke <sebastian.fricke@collabora.com> wrote:
>>
>> Hey,
>>
>> I am one of the maintainers of the media subsystem and we are currently
>> reviewing a patch [1], where the author has developed a polling
>> mechanism for a driver, while the hardware (Wave5 Codec) actually always
>> expects an interrupt line to be present and the only reason why this
>> isn't uphold is because the SoC has a defect, causing the interrupt line
>> to be disabled.
>> As I am a bit reluctant to litter a driver with workarounds for defective
>> hardware, I suggested to the author, that he could implement fake
>> IRQchip, which does polling in the background. This could first be
>> implemented in the driver directory and then later possibly upstreamed
>> to /drivers/irqchip.
>> So, far I've got a few approving comments for that idea, but I would
>> really like to know what the irqchip folks think about this.
>>
>> Now my question is basically, what do you think about such a solution? Would
>> you accept such a fake irqchip driver, that can be used by
>> hardware without an interrupt line to fake one? Do you think there is a
>> better solution or do you think that my suggestion has hidden traps?
>
>The problem with this approach is that it cannot be a generic irqchip,
>because it needs to know about the endpoint device to find out when
>the interrupt has been cleared. This is specially true for level
>signalling. If the device was only doing edge signalling, I could see
>a vague path forward, but that's not the case here (as evidenced by
>the DT bindings).
>
>My view on this is that given that the workaround has to know quite a
>few things about the generating device, it is better kept close to the
>driver code.

Alright thanks for your feedback. So in that case implementing polling
is definitely the better option as implementing a unique fake IRQchip
per driver seems not very efficient.

>
>Thanks,
>
>	M.

Greetings,
Sebastian

>
>-- 
>Without deviation from the norm, progress is not possible.

