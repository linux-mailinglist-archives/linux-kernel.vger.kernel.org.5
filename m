Return-Path: <linux-kernel+bounces-65067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49ACF854764
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 11:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B2ED1C221D7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99061803E;
	Wed, 14 Feb 2024 10:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ksRL3MzM"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443A9199B9
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 10:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707907322; cv=none; b=l5dw6yh03zuFXFqBlSBHMpd3hrFgL7fe8eZ72fQKIqaP+BjBB8joG6FcZbut+FYZJjHad1G+UJAiqkuCdclS3e2Y1VR1LOZtmQDrqXPJBmQLude+DCguVdYL9dqb5BW5a9LM/gKICAuj1iYL//PF8eX3AK4wgOFEaUUtTfvI3AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707907322; c=relaxed/simple;
	bh=Fsio90MCTcJobx/kjsKS9/65FS/cnF5natMw+uTBE7Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EDzhSoUsFkACYB72bck3EaODZN8o12UCOTEx767isACXyfIX6oJNi8X1tbFOwiusSAL7VPaI5Loyz0XlZdn57mJZ7Qv8j3pF4NOaRgWlhoS4559ebP3r5vrSGmFYoYiIKkxhrmJcyDtL/EzJovoB213ol8F1zdt2OxPPX6OXuS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ksRL3MzM; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-33b66883de9so3738242f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 02:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707907318; x=1708512118; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MOZ3NQSNTdxmjncsYgG8hdi7Xq9Y2E4kScScNugHfyg=;
        b=ksRL3MzMZt6USIOuXYhzWIwbYE3FI1foGubXdHBtPVCcsQlPzZuYcn8OWAXQBx5+f6
         iaIkoLnedH26JqOBsLQ/A5dw8zsL6Bxo4m/iUQf4YXTQ87xzXZ04TtbL4/s5EvMxZcIE
         FIX2D7BgfBDdXi7fuA6SVujVHNFBeBEw4nGBE/mMGAnZJiVBM386qTOvhiywlkKNZB1J
         wtmpgzOacMPDroq+I4kkEuRnxf13TQbWtiGe5WGvrVI9ud5uZSfKqbxjphJFFTKUBpGA
         /xaqnVfMesn5Tnxox8O07MrRP9NsKPU/KLZnuh1A5sftcRQ8ZnaJ8/WzV/AZ4dUWdcgc
         BSpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707907318; x=1708512118;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MOZ3NQSNTdxmjncsYgG8hdi7Xq9Y2E4kScScNugHfyg=;
        b=DHL8Qu8iu8mSdxW5KB3W+jukbS+qVtzTXu7xHAkXCQtra5AQxUdqanzSLn4fAiozrF
         L/GMFb24KjUbsoUcOKJzulpgsLtUTSIm6Ll6Z6+AzIebBzvNxQkhhOZgVQwOZHXOSGnd
         6U5d294VBXBLJLlqBAsCKMeubQkyOPOB3CGVwDYgq6ftJV2xVh2UCkOOpdSQ5ERjUjTt
         oAomL0oD6bbSmYWdXNGUQilhBWa61PaaFY4qNc+f51zm8oZ4x23KkdCsSiIe0sEBn0Di
         bzNBNLbMQU5hQ3Tvz60BRMtRKUqm251NDbQsBFjwf394hFpBxN/iYoW8v+7EMLqCwf/W
         ziew==
X-Forwarded-Encrypted: i=1; AJvYcCXR6mrX+9000dM01pRFmOQPXr1yoQhv8w92Ctr04KxZO3jJsI3Ogu7fuZSIxypmk3ovNJi+XwG88RGwLKGN2E1RM/ezliSYWCabAfs2
X-Gm-Message-State: AOJu0YyCwAAVFwgqdopX4MLrf9ZZQgG/8r+wWgTuD3pcnr3V+Lx4s8LW
	tOu7tKUqgVB8CH2rUkAyulEvfdCMoJk58lvnFgH5p018z3nudHb3nGLK1LvQvdI=
X-Google-Smtp-Source: AGHT+IHFpS8luZdfBGUJZwl9gb+mhUEvvqFez76v07DcEI1qb4dztbhpmdVGzfXAYFAdApCiUzJFcw==
X-Received: by 2002:a5d:420a:0:b0:33b:8782:985a with SMTP id n10-20020a5d420a000000b0033b8782985amr1212002wrq.21.1707907318435;
        Wed, 14 Feb 2024 02:41:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUWZUWRDED2uEHIfFV082ydqvqAB/GYew2iGk1VeE0C2TKI6XMT98+GgA8qWsCLOlqBXgRWjdA2DQ5TfSPUoFDAfVy+VjbqbJofWd2MpnIZHGuIyYSFEyOZto7uIw7CS2f3CzPHC0rOv8ESc9t0KFw3naJgNQjUX/kHheomAHUPPoeYVnq8XknazH6ui+4780KXebG6LCtWNBLx4tGx3dgI4SeUs8J+FT9zSwVTEffonkD9GXQC1UK2nj9tKuir4Y5v9EFlnA==
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id bt25-20020a056000081900b0033b792ed609sm9942435wrb.91.2024.02.14.02.41.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 02:41:58 -0800 (PST)
Message-ID: <47aeb22c-9450-4501-8bec-e9d69e8f4f08@linaro.org>
Date: Wed, 14 Feb 2024 11:41:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] PM: QoS: Add a performance QoS
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: caleb.connolly@linaro.org, lina.iyer@linaro.org, lukasz.luba@arm.com,
 quic_manafm@quicinc.com, quic_priyjain@quicinc.com,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231213175818.2826876-1-daniel.lezcano@linaro.org>
 <20231213175818.2826876-2-daniel.lezcano@linaro.org>
 <CAJZ5v0gfz9Lafz20s2AourmKuqQMS9g4heqj=afLbbp_B-2FMA@mail.gmail.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0gfz9Lafz20s2AourmKuqQMS9g4heqj=afLbbp_B-2FMA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi Rafael,

On 12/02/2024 18:30, Rafael J. Wysocki wrote:
> On Wed, Dec 13, 2023 at 6:58 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>

[ ... ]

> 
> I sent a comment on the first patch in the series and please note that
> 0-day has reported build issues with this one.  I guess it needs to be
> refreshed.
> 
> At the general level, I think that it would be good to add at least
> one user of this framework along with it, as a matter of illustration
> how it is going to (or at least how it is intended to) be used.  For
> example, what is going to happen when user space updates one of the
> limits via sysfs for a given device?

I think Caleb is doing a port of the QMI TMD series he posted to the 
performance QoS.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


