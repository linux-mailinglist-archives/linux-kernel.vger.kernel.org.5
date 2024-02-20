Return-Path: <linux-kernel+bounces-73795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F4785CB55
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 00:00:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C587E28431F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 23:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48852154C0D;
	Tue, 20 Feb 2024 22:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Tlv+6+/T"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3C915442A
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 22:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708469968; cv=none; b=rn0bgUShFaU9RmmRvtWsQujnJ9ZgFnN2b5IahhS8cF/PuCrfspH+PpDx3tDVVqSCQR5JpDrjelQTKg3qWQIxMPHa7+koAhJYXozq14gwe9ByfKWfxiOnXPI4XlpWwlqh7PcWMqeyySyCEvltcBwTM6hiskP/oM8V5ikW+lzeeLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708469968; c=relaxed/simple;
	bh=MDZCWsmKvMGEa46SRETSicuTwaCJTwrBj/zXUk8APA4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RxukmVGlbH49IXkbuKCJQJpYRF7OQSpjxFZRY6oBtwRsoUb6Zixs9UHj8GeGdQj7/YfJNchrpdP7QXnv0lheRVa8vZSz/S51XjU8JgKfKv4WmkVXKcEgYLlAz5RjFfigBN910AZ/TJ+DXmak1nx6eHfXMGI18iA1+OwuPOeTMrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Tlv+6+/T; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7c00a2cbcf6so44428639f.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 14:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1708469965; x=1709074765; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JHMVX/ExxqMdI2rhfJfkQUX0waT3oxRIMLB343ygR3o=;
        b=Tlv+6+/TsiwXpgl0HIY0JmwPuKzq5oFK56jhhz5T9RSr10t5VmTzMqdSQyDyfo54OL
         +IBeZsf8pqMUqXFMfrj9xjXz6XHwiB+vUbM1RhuwbX0rHClt9S8taNRCss1CNCpBCxQd
         Hdr64+zfDQKMhTupjc+Apsn4BKQIlbVSf9zo8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708469965; x=1709074765;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JHMVX/ExxqMdI2rhfJfkQUX0waT3oxRIMLB343ygR3o=;
        b=u0OkN5QzxEbw+UWb+Qf+FDvtUP+tu4ymCkuSd4qOvxQNpyrN94xpWpXQDEGZ3aXmXq
         S1wRX+dFfvDDEcIRI9Yk47WylYiTktTnviQOO3PlKWTm/JbdOduuvF8z+2f8UjePreV1
         KAPipJ3xkJnAYUZU5Vn8xjgs6GpJzrtNf+TvewZ0EGo3s+4ARk1GkCuq/fhq5WfGUcBj
         50w+eJKpE0ZwqpidqH8Ae8eObWjgY8/oDiMtZ49dGlq13+LAUtLJn0ZnvdbVobXZXDHv
         1x8emeTWYhhYY59+QOpAA99yWgRQaerHvwsgYnt0WKRdc2ljoIgpg+wyILaA6KLioP4x
         EbMw==
X-Forwarded-Encrypted: i=1; AJvYcCW3uuEg73K/hI9VNeOiECgiabfCr5daLQVXeLb8s8P1dMH422q3yytLuM3uq8qzFFSJfOSfmGTBGSttRIosewDj26cvEVTlgARbJhCo
X-Gm-Message-State: AOJu0YyRyEppLKfCQK1bw2CcxLs0RDKOFlatWeZGY/6O21U4t4nE+Bj6
	GwpCJ2PUQTAuZ+q/fy1KgLSUh/On+xKuRmVDNqJ8Lg9ZvvieVnlj2Bd6cjILHGfui0k7nIVz2w9
	y
X-Google-Smtp-Source: AGHT+IHT1dQvrPrw2fge445q5Py2GfYn/8+IdRUhOWUuhU7imfwnmG9ujKrJwqklesl4qAhz9ZIt2w==
X-Received: by 2002:a05:6602:722:b0:7c7:5da8:8602 with SMTP id g2-20020a056602072200b007c75da88602mr4287639iox.1.1708469965640;
        Tue, 20 Feb 2024 14:59:25 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id b7-20020a5edc07000000b007c45ab3dc34sm2483821iok.29.2024.02.20.14.59.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 14:59:25 -0800 (PST)
Message-ID: <a301dcd6-19fb-4884-8f4b-264613312634@linuxfoundation.org>
Date: Tue, 20 Feb 2024 15:59:25 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] selftests: ktap_helpers: Add some missing helpers
Content-Language: en-US
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Shuah Khan <shuah@kernel.org>
Cc: kernel@collabora.com, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Laura Nao <laura.nao@collabora.com>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240131-ktap-sh-helpers-extend-v1-0-98ffb468712c@collabora.com>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240131-ktap-sh-helpers-extend-v1-0-98ffb468712c@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/31/24 15:02, Nícolas F. R. A. Prado wrote:
> This series adds a few missing functions to the shell KTAP helpers
> script which are present in the C counterpart, kselftest.h.
> 
> This series depends on
> "selftests: Move KTAP bash helpers to selftests common folder"
> https://lore.kernel.org/all/20240102141528.169947-1-laura.nao@collabora.com/
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> ---
> Nícolas F. R. A. Prado (4):
>        selftests: ktap_helpers: Add helper to print diagnostic messages
>        selftests: ktap_helpers: Add helper to pass/fail test based on exit code
>        selftests: ktap_helpers: Add a helper to abort the test
>        selftests: ktap_helpers: Add a helper to finish the test
> 
>   tools/testing/selftests/kselftest/ktap_helpers.sh | 39 +++++++++++++++++++++--
>   1 file changed, 37 insertions(+), 2 deletions(-)
> ---
> base-commit: f1ca07220ad16a9efae7f68e4bade0db89b63a3c
> change-id: 20240131-ktap-sh-helpers-extend-805b77ca773c
> 
> Best regards,

Applied to next for Linux 6.9-rc1

thanks,
-- Shuah

