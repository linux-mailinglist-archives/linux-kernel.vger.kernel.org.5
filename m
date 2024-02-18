Return-Path: <linux-kernel+bounces-70442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA448597CC
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 17:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49DC21C20B8C
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 16:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD8C6EB47;
	Sun, 18 Feb 2024 16:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="LW2WGzzD"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784766EB42
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 16:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708274918; cv=none; b=YXJeOv0AyGA79Ib/2Qy21tzJOlhWYQCGQCdVjaetFkf2SVpbuVIm1PqeNo+c08BMZaJX3+11OZ4z5jaK8IX50I+JewhM3tCogh5Lkf72qJrTiiqj+tByAZtKZoJRVIjpj8NnetXfQer2RweaA/rTOWAg4s0/ul53h1uzlaVttYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708274918; c=relaxed/simple;
	bh=KpFfggUZ5hMwU47Zuz91oYFFmXWnyTnZeq8DfngWL8E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eDjTQXvrfslg/xQN+7+m/08zVHgghvOKPPjzgG58GOqLppb9tuPIRMqd8Q6WEdeUeulYIKkVRhPU7pwRnUMX5lBCAf/7GwRzfFvLiSxpYeNHVU7wbBk5ct4OmeHAQjexnjJhmDGjY7ZtqEjJ+6LEn4RSXE7/M/apODPkcfxvIjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org; spf=pass smtp.mailfrom=ieee.org; dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b=LW2WGzzD; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ieee.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ieee.org
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-365220a2c3dso4743435ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 08:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google; t=1708274915; x=1708879715; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=37nms9BmJJEsQJsbt0jcgUsWdlYRkTGGuwtAPDF2YJA=;
        b=LW2WGzzDP38WdWR4YgRHs1KJWpyZpeb3WqDXMGHc7daZZ1UzFQqMdbSzYVLlHy4IPC
         5vwtHiMKNMyo3wwF7vNI6SZo26mxIc8EVd1y05Fr9QN62GYenKfI/wCkVmhHetHWmFz2
         EIU1Zy+Mjty2IbtcRQulO/HwpX0rFbaLqidTI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708274915; x=1708879715;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=37nms9BmJJEsQJsbt0jcgUsWdlYRkTGGuwtAPDF2YJA=;
        b=OF0lU8Ho+PkO8Ib2nr+L+TIzqWojZ2G53s1X2f31uwu7QgJLbuEbXJTbiIATVFvIlg
         irigvyFXfboCSOjMnB6BZOSwZBeX64jpecz3dETP/mcTGMOdpDm4BELwTe0mR24DHkNO
         r7khJYX+RQl8oYc9TQKcGAdciJd2gFu5/EVUUVxkRNdPNABKP76rtc9HbGle/C7zyVxF
         nxcmRk/7KNhpyLikxBGyZ/dORzSs4NlcSTTP5UM1e/zSAXOEqtKl+OReCXt9OmPL5jW3
         IB2GalGVNFEl1UFnZ2K98PT+rqIod4RGU4mYWzAj+chm/eNZYqGE5qL/o6rJijDMH8rF
         pVcA==
X-Forwarded-Encrypted: i=1; AJvYcCXA1owqVsb0ltf4UpLkept8mELxIS4GsZYAMc9/EJcYBonbZJhJA6FKFHQBcb2SAPAaLQ1eh26S8IpNclDUc85d7AHfm7ldC764DWVt
X-Gm-Message-State: AOJu0YwiSQFhaPr0lI4Si1/pVik4I/oqgW0O7YUI/sBO7gqljCZntbIn
	QJT8EaHpCuGnWP4pcC3ROBajHLvHFiPGf+05AVBIKF5m3GBlqysszjjzLGP09w==
X-Google-Smtp-Source: AGHT+IFcE6tBwMe7ot5+O/3t4TbbhIKrINl4J+8hLvJT/caqX8sqYCCWCefFmQzI3F/jhqPVS3tGLw==
X-Received: by 2002:a05:6e02:154c:b0:364:216e:d1dc with SMTP id j12-20020a056e02154c00b00364216ed1dcmr9851712ilu.22.1708274915594;
        Sun, 18 Feb 2024 08:48:35 -0800 (PST)
Received: from [172.22.22.28] (c-98-61-227-136.hsd1.mn.comcast.net. [98.61.227.136])
        by smtp.googlemail.com with ESMTPSA id hm11-20020a0566020f4b00b007c46318b9ccsm1107820iob.14.2024.02.18.08.48.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Feb 2024 08:48:35 -0800 (PST)
Message-ID: <0123aec7-f7ae-454d-9b4a-361e97756242@ieee.org>
Date: Sun, 18 Feb 2024 10:48:33 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] greybus: Avoid fake flexible array for response data
Content-Language: en-US
To: Kees Cook <keescook@chromium.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Johan Hovold <johan@kernel.org>,
 Alex Elder <elder@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
 greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20240216232824.work.862-kees@kernel.org>
 <672fafca-547e-443e-8dd8-80ccd2320767@ieee.org>
 <202402171357.E671B5589@keescook>
From: Alex Elder <elder@ieee.org>
In-Reply-To: <202402171357.E671B5589@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/17/24 3:58 PM, Kees Cook wrote:
> On Sat, Feb 17, 2024 at 02:17:33PM -0600, Alex Elder wrote:
>> On 2/16/24 5:28 PM, Kees Cook wrote:
>>> FORTIFY_SOURCE has been ignoring 0-sized destinations while the kernel
>>> code base has been converted to flexible arrays. In order to enforce
>>> the 0-sized destinations (e.g. with __counted_by), the remaining 0-sized
>>> destinations need to be handled. Instead of converting an empty struct
>>> into using a flexible array, just directly use a pointer without any
>>> additional indirection. Remove struct gb_bootrom_get_firmware_response
>>> and struct gb_fw_download_fetch_firmware_response.
>>
>> The only down side I see is that it sort of disrupts a pattern
>> used on Greybus request handlers (and the response structure definitions).
>>
>> I think a one-line comment in place of each of these two
>> definitions would be helpful, something like:
>> /* gb_fw_download_fetch_firmware_response contains no data */
> 
> Er, maybe this should be "no other data" ? Do you want a v2 of this
> patch?


Sending v2 is probably best, because I'd like to see these
comments.  Greg could fix it up himself but he probably wants
to pull it from the list

And yes, "no other data" is fine, or maybe "no payload"
or "has an empty payload".  Any of those is better than
nothing; you choose.

Thank you.

					-Alex

> 
>> And then add a similar comment above the calls to
>> gb_operation_response_alloc().
>>
>> Otherwise this looks good.
>>
>> Reviewed-by: Alex Elder <elder@linaro.org>
> 
> Thanks!
> 


