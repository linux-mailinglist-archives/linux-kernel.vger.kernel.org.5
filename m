Return-Path: <linux-kernel+bounces-168146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 499088BB444
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D612F1F21DFE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 19:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993A2158A1B;
	Fri,  3 May 2024 19:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IrXHQso/"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D371586C1
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 19:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714765331; cv=none; b=bL4gKAgzlY46UggRW6xNhd+AF+Dc4/xnJlyLSDxckOLtS/vGclYPBPKY2QqoQvpYzRSx6zu4rwjkVtjCucoI3QzsRqOJWcVokmKOvnN9zuqlbwUi9NMDW14eM42jkB9re4+gIGylB+SNEXIQgUJu+LaCQa4twAGzD+1tSN2dk9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714765331; c=relaxed/simple;
	bh=lmgSiRO/qeWY2rx3mwtsVmBlqWlnJWkwnyepOJ7YHs4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FuuIVYxP86oy4/4ME6r+qIN13a0DUem258dVTJ7xk842FEpSPUPtPo0ezHZydBmW8MAO/qe735xQfH3oAckP4Onl3/rMnTm8O90ZF9asmuRP/HwtD1Hmyrx5BW1kc6CBYZEFOkV8ZTRrTajQo7BbZ2CBxfyUoucmbpv+01FD+GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IrXHQso/; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7d9c78d7f97so184839f.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 12:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1714765329; x=1715370129; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=isnNwgzpej5QkXxVDz6RxdNZolwJVMQ0OEWi8JJK3c8=;
        b=IrXHQso/djxTaGVRQVaL6eY7k0DqNt4AQj4iPIdo/DBGq1/waMHcvBjmHfkge53yoA
         Xm5pkX6X5wjaJNw34/ydyZJkohHgcpUdxtbooDLLi3pOItibFjWOgYQOxI47pYRf4O9e
         Y0qiAidljMSuNVuSTnhT2+C3qBZJe9VfFn38o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714765329; x=1715370129;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=isnNwgzpej5QkXxVDz6RxdNZolwJVMQ0OEWi8JJK3c8=;
        b=sY2XJmLPXQzhOSSSpc2zSE/87gQh5+v/4sgMgZqlV9XgYu7//UKnIoRnFv9pgKml+5
         k2KpiwnyzmDveK+EZZaCVTvd5r5O+Cn5YsQoxbc63bqAo8lBGo8mDv+AWk4KSWgEBMGt
         m4jBIoPbFP9gqVDBAvGTEbh8KYmDY099+6W1BsM6S807YXL2jtU5OAQ4HTC99cas8TCf
         34PefVvVJgroiRpwVhSDMXgDN3+kIhMzSkcnidYJZd4Fb/BrePsegJj/ykHtLbrKMLTq
         WHQoXztgbWuZnAI/DJrrgnTiI2zCm59ooxCGN1C3VaShRRMM+0HamkjmTiyS34j+jhoI
         +knw==
X-Gm-Message-State: AOJu0Yy5wtka/YDhuLPIieaVUoHOoFGNh9KkP1wSOrAlQLQxdrw6zsoh
	i3FdazPjwKyI2mKraJ8D32mwAkK1hhfohHjgOqTWD4ZsZe+7hVWssrjpRymt3xqVHevE/LxZNE1
	QfNA=
X-Google-Smtp-Source: AGHT+IGDzFDyA3HpFHwZS3KljRezBBycS88K71+0k0BMI8DZsfKR3K6BNeDKfqhfDL+rDMO2Aw6qnA==
X-Received: by 2002:a05:6e02:219c:b0:36b:15e0:de18 with SMTP id j28-20020a056e02219c00b0036b15e0de18mr4188255ila.0.1714765329490;
        Fri, 03 May 2024 12:42:09 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id i8-20020a056e021b0800b0036c6ad53d1dsm790397ilv.50.2024.05.03.12.42.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 May 2024 12:42:09 -0700 (PDT)
Message-ID: <a8811c10-692e-411f-bc08-c25c38f824fe@linuxfoundation.org>
Date: Fri, 3 May 2024 13:42:08 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftest/tty: Use harness framework in tty
To: Shengyu Li <shengyu.li.evgeny@gmail.com>, shuah@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240430150508.82467-1-shengyu.li.evgeny@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240430150508.82467-1-shengyu.li.evgeny@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/30/24 09:05, Shengyu Li wrote:
> Similarly, this one is based on automated tools and a very
> small percentage of manual modifications to automatically refactor
> the version that uses kselftest_harness.h, which is logically clearer.
> 

Similar to what? How does refactoring help?


Follow the imperative mood to write change logs:

https://www.kernel.org/doc/html/latest/process/submitting-patches.html

> Signed-off-by: Shengyu Li <shengyu.li.evgeny@gmail.com>
> ---

thanks,
-- Shuah


