Return-Path: <linux-kernel+bounces-41121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F0383EC27
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 09:56:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7C0928594C
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 08:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066981E872;
	Sat, 27 Jan 2024 08:56:19 +0000 (UTC)
Received: from mail.enpas.org (zhong.enpas.org [46.38.239.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55781DA20;
	Sat, 27 Jan 2024 08:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.38.239.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706345778; cv=none; b=tVO+FU19fsW4ppB3JpOEACcQskFU9rfboIRhQ027TuHsZ1gUcwsLvk+24sRYKtH5E/W6Mcimoz5WFNxF1MexTObDZInjqo/Fey6nP5wMUmtChCT3hDucAbFo5kz/Cam+OQPB2hFbgdmefDJgrOpZv/M6OPrUBrqAPZaaVI2BwaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706345778; c=relaxed/simple;
	bh=fKTqPFmjcbrn5mx/kpZY6Pndn77FM2q8pN7HO7W8cbA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XCv+SAnDYJKgP8WgIEML9460sIAjxN774FS2Tj4D7kInnDY4nkR4BViR51hw0MCVDjo2ZYOzDqeCriSkO+NXs/oQZ7eV/91+vr0tQQAD8Nb/fuJY1orJFLt25EuQlt/p8G6yugHR0TJxxuBuaVLV6MalGZig62KheGZZkWFxXmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enpas.org; spf=pass smtp.mailfrom=enpas.org; arc=none smtp.client-ip=46.38.239.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enpas.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enpas.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by mail.enpas.org (Postfix) with ESMTPSA id 71ACB1015FF;
	Sat, 27 Jan 2024 08:56:11 +0000 (UTC)
Message-ID: <8ffc26cd-b5b3-4a29-bc6f-fad4be302044@enpas.org>
Date: Sat, 27 Jan 2024 17:56:08 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/7] HID: playstation: DS4: Don't fail on FW/HW version
 request
Content-Language: en-US
To: Roderick Colenbrander <thunderbird2k@gmail.com>
Cc: Roderick Colenbrander <roderick.colenbrander@sony.com>,
 Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <benjamin.tissoires@redhat.com>,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240115144538.12018-1-max@enpas.org>
 <20240115144538.12018-4-max@enpas.org>
 <CAEc3jaDD76e+Lkwc8WSac30-kXBYKP6_R2+kM4+Z_RVOinD9Kg@mail.gmail.com>
From: Max Staudt <max@enpas.org>
In-Reply-To: <CAEc3jaDD76e+Lkwc8WSac30-kXBYKP6_R2+kM4+Z_RVOinD9Kg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/25/24 09:43, Roderick Colenbrander wrote:
> On Mon, Jan 15, 2024 at 6:51 AM Max Staudt <max@enpas.org> wrote:
>>
>>          ret = dualshock4_get_firmware_info(ds4);
>>          if (ret) {
>>                  hid_err(hdev, "Failed to get firmware info from DualShock4\n");
>> -               return ERR_PTR(ret);
>> +               hid_err(hdev, "HW/FW version data in sysfs will be invalid.\n");
>>          }
> 
> This looks good. Perhaps could have been a hid_warn then, but err is
> probably fine.

I didn't think about it and kept the hid_err that was already there :)

I agree, and maybe we can take this further: If this code block is not a fatal error anymore, maybe it makes sense to change *both* lines to hid_warn?

If you prefer this, then I'll update the other patches accordingly.


Max


