Return-Path: <linux-kernel+bounces-121409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A151588E79A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CC091F326FD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF72131BC6;
	Wed, 27 Mar 2024 14:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XwU7YQaN"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6C71327E9;
	Wed, 27 Mar 2024 14:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711548701; cv=none; b=GPszvykbs9HH9uSFvX47R5xqQlDQZo6lbqezSOw9vsteLdlyX2M5XnDG/BfhijK5gvCfNJ/WlI8iWAWmaDyGkU2QNWeDv60nKw0AL1zBpG1ck+Nq1fXEoP+vfm5S4X1buAUsZD3TL2JDXkAiDD0hJ7bYTeJS902VHknTEhGB6W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711548701; c=relaxed/simple;
	bh=SGhC7f/OXl3SNF2nNKvyBrQPvyFTC9D9zvBTzNsTSAI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FF4yTobC0TChDHD9fNuDEy4cATk12XWfXllNoU9tTUd9+eOX3vHpOPlgsQm6XgFaKAwKYIzflR2V2IpXChkdjZ/l86npLCsj+AeunW/j3aPDKjIzElQHiGOiTxBN4V4Su9aN5SbSCooP3QE7QfYbuJ1Gbpjcc+iSLAl7o5pfKYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XwU7YQaN; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-512b3b04995so3775660e87.3;
        Wed, 27 Mar 2024 07:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711548697; x=1712153497; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IyJDkbjfmOBYuYreKRli55h3QqY7VDOWn83SMTw8obc=;
        b=XwU7YQaNEnjXB4uAiH4v6y3H5rVwZv/b5Cu2SPdOQ3a5w/sd9g+ozOGeFK+lA6XG47
         /B23EMVl67HoV31q8AXZUOosCzi8RmCoyjBs4EFyU64nifKCU3cAwO/EUlvJ45w4CWU2
         n2+6/FHxic+h+c/VOHSRpzt6ROYx/uxVpMz7Ps5euUslyeRO4WO+Cxi3rJTxHupRx5xX
         T9/JJppgj7mW+KGTT3+9ABThoqI/UWBrFJgjKKMJgrINFHm2FYx8U0BDJrN3ufnsZ3wH
         mKAJfi4HuN/tAL0p+sT8KYdp7yVQkvg4sYY8zwO9wBQ0sHRlBSnEIQNSK532sozCNknr
         Mtdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711548697; x=1712153497;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IyJDkbjfmOBYuYreKRli55h3QqY7VDOWn83SMTw8obc=;
        b=Er+jUV718VFIAhsf7eY6SFijo01U+3gKHl0RMenLuk6quKqiNYHyZvew1y0TYlDWnO
         QTk5jcWcUJdQRpkDFsMJ9dA1N0wQ984NM3so7etsNa9zsJZ6FtCwJJmc+Yxwy7Dnxx8F
         Ig3hVIQEyhLog1DNFK6I+U8OVBQC9AWdafar6c3Mi/1gM8D/aw9OrPMXqikIDwwR1/4U
         w3AoT/r/pYk30Ujsm6mIILOe5LjV0GvyCjlV9LXhgj64ZZ9GVdlAGxcRTAff8WBMi0cX
         OxjSLZ64yUtMrONJnegMjYHrbtGiFPrMCoTGY5ME1ADhhA+6qRJMZ6r7Q/PesRTrFhHh
         7mHA==
X-Forwarded-Encrypted: i=1; AJvYcCVuy7RZCuQ5HbgdDOkF5KV8yqt4XLOKvbltRV/i1c/xgAkkGE1NFr2BRGBtLaMSPDqfjB3yC4vi6W0vOPsYp3mDDDnNgtzN9lc2kVLBTh/Q1McSLncZ6r8yKQUPwkLiOTUREcOF/3giKA==
X-Gm-Message-State: AOJu0Yx3bUG+KqHALRDE7rvx3l+ETjb53+L6lV1+15xoSXkzK7M/SMBA
	8TO/GrkDDB3QiSKWfoe+JkRDj1mh6S+suilrw8x9QbcHPTF33Ptz
X-Google-Smtp-Source: AGHT+IFnHmjmaTtiFBPUmuK7dtkmFwbJFIBG4stNIA1T2gnG9pi0Ma5TRetOj1+9JKO6OpqRl8wCFg==
X-Received: by 2002:ac2:48a4:0:b0:515:a6dd:9657 with SMTP id u4-20020ac248a4000000b00515a6dd9657mr1693604lfg.16.1711548697135;
        Wed, 27 Mar 2024 07:11:37 -0700 (PDT)
Received: from [192.168.42.63] (mobile-access-6df024-232.dhcp.inet.fi. [109.240.36.232])
        by smtp.gmail.com with ESMTPSA id br36-20020a056512402400b00515b071bc71sm892262lfb.305.2024.03.27.07.11.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 07:11:36 -0700 (PDT)
Message-ID: <c6f5a515-61a1-4d87-a029-4000fa96f10e@gmail.com>
Date: Wed, 27 Mar 2024 16:11:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] mfd: rohm-bd71828: Add power off functionality
Content-Language: en-US, en-GB
To: Andreas Kemnade <andreas@kemnade.info>
Cc: lee@kernel.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240326192258.298143-1-andreas@kemnade.info>
 <20240326192258.298143-3-andreas@kemnade.info>
 <815e1cdc-145e-4880-96a0-d9c21308b9b3@gmail.com>
 <20240327140451.65ff8e18@aktux>
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20240327140451.65ff8e18@aktux>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/27/24 15:04, Andreas Kemnade wrote:
> Hi,
> 
> On Wed, 27 Mar 2024 09:32:29 +0200
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> It's worth noting that there is another PMIC, BD71879, which, from the
>> driver software point of view, should be (almost?) identical to the
>> BD71828. I believe the BD71828 drivers should work with it as well - if
>> not out of the box, at least with very minor modifications.
>> Unfortunately I don't know products where the BD71879 is used or if it
>> is sold via distributors - so I don't know if adding a DT
>> compatible/chip type define for it would be beneficial.
> 
> yes, you already told we thet the BD71828 drivers are compatible with
> the BD71879 and I am using the latter.
> But that at least should be commented somewhere, so that
> people do not raise questions, like: Do I have some strange board revision,
> etc?
> The most terse form to comment it is a separate dt compatible so we are
> prepare any "almost identical" surprises.

I agree. Reason why I haven't done this already is that I don't always 
(like in this case) know which of the variant are eventually sold. So, 
it's balancing dance between adding compatibles for ICs that will never 
been seen by large audience, and missing compatibles for some of the 
variants.

This is also why I was interested in knowing which variant you had, and 
where was it used.

But yes, I think that as the BD71879 has obviously been found by a 
community linux kernel user - it would make sense to add a compatible 
for it!

Do you feel like adding the compatible 'rohm,bd71879' in 
rohm,bd71828-pmic.yaml as part of this series(?)

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


