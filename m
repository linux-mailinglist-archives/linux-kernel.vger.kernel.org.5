Return-Path: <linux-kernel+bounces-155241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 460848AE743
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:02:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B3AA1C225FD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9682F130A6C;
	Tue, 23 Apr 2024 13:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kl.wtf header.i=@kl.wtf header.b="Wyv+irvR"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CFA76048;
	Tue, 23 Apr 2024 13:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713877320; cv=none; b=fqABQjbbMBpDXf08k6AxckbkA1Hc3vpq8SKCq+i/GWHL/mhPaW7WviWWOWtqQbqfE/afbU/WKu4D5/M5tgJorgTsRrTPVlI2/2s6+PQsPXqYdeZMQwWpBMOCKGf/Fw6JKmXy9Fmr5SQ/NnxadVSRYi5aHSfWD9zioQAKr1ROdPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713877320; c=relaxed/simple;
	bh=3OdiHaW3XfhNrYYNY1DDe5kYJ8SC6l+BMHyms2q7tnU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qv4lsIS/yXQsJM/vaZduPyzAFkERkgZurLT8ar+skGbOoqIXiSz3v5+DcI5CEmLzpKDF315/EGi02dPUUv0RSApWxsuDeF9cx6A50k/P4ayo0JxTVygYPW2IpWKNc2uRhpza016iDu8rHWjGZ/I085CkY/RtIGnBL5GcW/TquE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kl.wtf; spf=pass smtp.mailfrom=kl.wtf; dkim=pass (2048-bit key) header.d=kl.wtf header.i=@kl.wtf header.b=Wyv+irvR; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kl.wtf
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kl.wtf
Message-ID: <25f3ac4f-0c0d-4183-93f1-e7069579420b@kl.wtf>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kl.wtf; s=key1;
	t=1713877316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VpVOPDgVjeP7Gtlmu1PRLEP/ygT17A2RK4mO+N4cqNo=;
	b=Wyv+irvR4ZYduylvRUwSHbWf4iMmQpftpA/uNh2NL1nVlyetSHpb0fS8lB/5gsl+LwYi1u
	q06elO7BC16qV59p3Y5R9jRlTvhyPwmBzq/2Uhf3vJkFjXSCxhZmfrrpIOcdpQy0N5nH7/
	sE0yR/UTrfdcXO+owPbhlLf3+DnyVjSjcpCDM5bgSvWaUbeiCh1jSuxPrlVkX7D72NnrPF
	qD4V1MGcotN3Fn01E5F4+OxnR8ImoXPQT4UBh2BPog7yTtiktXjovWe+FfT/dv8UyVqTjR
	V/0rGl7Nhb2BraGMV/mFLb2XU4Rs0ZdPEUFy6ZbGvFJP0UUFkFkda1UzvE9x7A==
Date: Tue, 23 Apr 2024 15:01:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] HID: i2c-hid: wait for i2c touchpad deep-sleep to
 power-up transition
To: =?UTF-8?Q?=C5=81ukasz_Majczak?= <lma@chromium.org>
Cc: Johan Hovold <johan@kernel.org>, benjamin.tissoires@redhat.com,
 dianders@chromium.org, dtor@chromium.org, hdegoede@redhat.com,
 jikos@kernel.org, johan+linaro@kernel.org, kai.heng.feng@canonical.com,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 mripard@kernel.org, rad@chromium.org
References: <CAE5UKNqufWZfKLAXLcpBYKQpJEVt6jPD4Xtr=Nesh34VkNOETg@mail.gmail.com>
 <81e1b870-37f9-4ef2-9a3d-87015f32546b@kl.wtf>
 <Zh0qKeI-YPDE-NVT@hovoldconsulting.com>
 <535f3756-80d9-4599-bf73-a8785d18c399@kl.wtf>
 <CAE5UKNqPA4SnnXyaB7Hwk0kcKMMQ_DUuxogDphnnvSGP8g1nAQ@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kenny Levinsen <kl@kl.wtf>
In-Reply-To: <CAE5UKNqPA4SnnXyaB7Hwk0kcKMMQ_DUuxogDphnnvSGP8g1nAQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 4/23/24 1:32 PM, Łukasz Majczak wrote:
> Unfortunately, your fix doesn't help in our case as there is no sleep
> before the second call to
> i2c_hid_fetch_hid_descriptor().

Yeah, I checked with a logic analyzer and only see ~50µs delay from the 
I2C timeout, and 50 is according to my quick math less than the 400 you 
mention is the requirement. That means that the current resume path also 
lacked a sleep, as it tried power commands in immediate succession.

I have made a v2 with your sleeps added, and added you as Co-developed-by.

Link: https://lore.kernel.org/all/20240423122518.34811-1-kl@kl.wtf/

> Saying more, this STM exposes two i2c addresses (connected physically
> to the same bus)
> one is the HID interface and the other one gives an access to the base
> firmware and is
> served by cros_ec_i2c driver and actually thanks to this driver,
> touchpad is woken up because
> In the resume path cros_ec_i2c "starts talking" through the i2c bus
> thus generating a wakeup
> interrupt.

Ah, that explains why you did not find an issue with the resume path. In 
the patch-series I sent, the boot (hid descriptor fetch) and resume 
(power on) wake-up paths are fully aligned so neither have to rely on 
such "adjacent drivers" waking up the i2c-hid device.

