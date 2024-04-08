Return-Path: <linux-kernel+bounces-135537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE7589C74F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 16:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BD9F1C2175D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A4513EFFB;
	Mon,  8 Apr 2024 14:44:21 +0000 (UTC)
Received: from mail.enpas.org (zhong.enpas.org [46.38.239.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8AAF13E8A5;
	Mon,  8 Apr 2024 14:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.38.239.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712587461; cv=none; b=e1mJgZtbPrL8eViclofde9jKDNhXTGv3dF3NU/ZKrNtfRNZs5SWjWVz+n6zImktJFiqS6ZBJBEXHBs2fw9E0+GMkKEeZWVWgzi2l6go9Oi4G2I8xp1mC33ib/6XitB6kRIzIp4Fw/5WvsnMUIM2Y9pGIVyyCi6nVKRtVaYUtkZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712587461; c=relaxed/simple;
	bh=wdCqeWCNPqMNXMoEct0ohidFtAQJvY01dRzjjqnSPJU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pp6eOr3Ow6HSrlHTSAZY0BHlIFiG/hgQgW+uZr6i8CVqGj4+GvqlHoyghDWm5DZ4yUMEQpQ2UWfo7zwnuriW0SQBndCUSEoCWaBTejdwNr+8/IMKPkaJqOeAHl/gB1l33tqfLwsp+I0KE3Bvdsva+PaKXW1WHSMLAJAZK7CjhsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enpas.org; spf=pass smtp.mailfrom=enpas.org; arc=none smtp.client-ip=46.38.239.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enpas.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enpas.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by mail.enpas.org (Postfix) with ESMTPSA id 9C2CA1014A8;
	Mon,  8 Apr 2024 14:44:08 +0000 (UTC)
Message-ID: <07848795-14e3-4020-9e60-e3221ff6ef80@enpas.org>
Date: Mon, 8 Apr 2024 16:44:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] HID: playstation: DS4: Don't fail on calibration
 data request
Content-Language: en-US
To: Dan Carpenter <dan.carpenter@linaro.org>, Jiri Kosina <jikos@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 Roderick Colenbrander <roderick.colenbrander@sony.com>
References: <d0e5bb97-3e18-44ac-89b0-503cfe16417f@moroto.mountain>
From: Max Staudt <max@enpas.org>
In-Reply-To: <d0e5bb97-3e18-44ac-89b0-503cfe16417f@moroto.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/8/24 09:41, Dan Carpenter wrote:
> Hello Max Staudt,
> 
> Commit a48a7cd85f55 ("HID: playstation: DS4: Don't fail on
> calibration data request") from Feb 8, 2024 (linux-next), leads to
> the following Smatch static checker warning:
> 
> drivers/hid/hid-playstation.c:1904 dualshock4_get_calibration_data() error: uninitialized symbol 'acc_x_minus'.
> drivers/hid/hid-playstation.c:1904 dualshock4_get_calibration_data() error: uninitialized symbol 'acc_x_plus'.
> drivers/hid/hid-playstation.c:1910 dualshock4_get_calibration_data() error: uninitialized symbol 'acc_y_minus'.
> drivers/hid/hid-playstation.c:1910 dualshock4_get_calibration_data() error: uninitialized symbol 'acc_y_plus'.
> drivers/hid/hid-playstation.c:1916 dualshock4_get_calibration_data() error: uninitialized symbol 'acc_z_minus'.
> drivers/hid/hid-playstation.c:1916 dualshock4_get_calibration_data() error: uninitialized symbol 'acc_z_plus'.


Hi Dan, Jiri,

Thanks for the report!


Jiri, if you prefer to do so, please feel free to stop/revert this patch for now, and I'll send a better one soon.

The label "no_buffer_tail_check" was meant to jump straight to the sanity checks in order to have them write the fallback calibration values. But I missed that the part in between the two sanity checks can actually make the second sanity check pass with bogus values - as shown by Dan's check.


Max


