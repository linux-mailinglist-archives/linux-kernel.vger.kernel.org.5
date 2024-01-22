Return-Path: <linux-kernel+bounces-34040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E12837241
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:17:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0807D1F330B0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2DD33E476;
	Mon, 22 Jan 2024 19:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="X9ISJbza"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FADD3DB93
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 19:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705950805; cv=none; b=LgLX19Sxmu8W+30BhiL7Mc4ZEsWFqXDJKo41D8+Pgnjsa6QksFpFqicKJhiR7Z/Tz3BqjR+ZAYM1gh3m658lewsnqLvRcYSpj5ckrSaEF+bjWitA0f++TLBUFF2uNhvLY2sgtaVHp3+tMOtyvHet83bxTrMLuLLyEAQjKUM4nFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705950805; c=relaxed/simple;
	bh=AA99IbHEqg33AL5D9QM97dKtQa8fHo0ZMYf+NpFTY7k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FvNKeJrpHGXVuBssDDhF7U8ZCz9pyKAUlVvGSxlTolwsWEk7AAhwGo90uED1iY7VNxIEdkQKf9IeyoCFb0dC2suLl1Ou0GJXeECOsaOdWCKjSLaU2hy1I03J4ANIruoHJ4aFuhSlDI7VmngynpSmfOpVBwi74NsOxiJGDRPhvoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=X9ISJbza; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6d9b23698c0so336882b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 11:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1705950802; x=1706555602; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Orh3DxVuy7FomCJWRBsIA4WQS0J2kl2fyD9SPWqPEOE=;
        b=X9ISJbzaotRvxTuY5yH9U4Rw4lvoFNLJZVRxccwSaOu+Nh6WQyFFQ1LKWR4xfRVULK
         JTC/9EpaWC5DF6cwDSejLpQO+pOpMrMNurc2IJfe8a7w3CFcfPqfFpyGJa6hvbGp5L5Y
         kimqpYvHLiwoj+jRtgq5tmufLZ8uYElu/ywyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705950802; x=1706555602;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Orh3DxVuy7FomCJWRBsIA4WQS0J2kl2fyD9SPWqPEOE=;
        b=aJinyvQLwyp42mCRP12lVz0tTHt0qRyhccm1me29eSvHCxwrRnFMA4kufKmMST3xTK
         3WrkG13O/QoTbxHk6BCOC0fWE4ACtcQL2A+naivzFjZp+kepNTk+McyiY2jki9TsLBOw
         7sbJxXif/fZFSk+5hhB3sCs8b6Boyx0J/oOdAWDV3EZNRxalhZDBI3sbJ15W79VRLPgL
         vPalflNnZ72WTLRJ4MecEMS5JrjqkI/dtcNpDq2mgKU1cO6oyhNDQlLOFI9k7Mkro2cx
         tZswAJJYuIlRyJupajCH4IizwFFG2ejEU5ao95zkkj4k814RyGA7fuk5flL5y0e+v8SX
         dn4g==
X-Gm-Message-State: AOJu0Yw08wtttgyErd4xAR0xwjLE30B3tzxxuLAcRXbMpWnBg5kk1BDR
	6q3zMVHXeqT/K46r+G1vjdWXB56/9KL6sUxcpQpULx02t/P/EzeB3yxaE4WrGM4=
X-Google-Smtp-Source: AGHT+IFrnrfK1GWSY6pwqy3Nbmm5rF6MprDzUI8W87suZU5V3ednnqkhMYqEpdgd7aM9WBBh8DZhSg==
X-Received: by 2002:a05:6a20:2d0b:b0:19a:bffa:f28b with SMTP id g11-20020a056a202d0b00b0019abffaf28bmr10903560pzl.2.1705950802683;
        Mon, 22 Jan 2024 11:13:22 -0800 (PST)
Received: from [128.240.1.152] (rbi200e.jcresorts.com. [206.170.126.10])
        by smtp.gmail.com with ESMTPSA id ca28-20020a056a02069c00b005bdd8dcfe19sm7521738pgb.10.2024.01.22.11.13.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 11:13:22 -0800 (PST)
Message-ID: <e68d6618-dd7a-436b-8609-d447fdf9e86a@linuxfoundation.org>
Date: Mon, 22 Jan 2024 12:13:18 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] kselftest/seccomp: Report each expectation we
 assert as a KTAP test
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>, Kees Cook <keescook@chromium.org>,
 Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>,
 Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Anders Roxell <anders.roxell@linaro.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240122-b4-kselftest-seccomp-benchmark-ktap-v2-0-aed137eaea41@kernel.org>
 <20240122-b4-kselftest-seccomp-benchmark-ktap-v2-2-aed137eaea41@kernel.org>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240122-b4-kselftest-seccomp-benchmark-ktap-v2-2-aed137eaea41@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/22/24 09:04, Mark Brown wrote:
> The seccomp benchmark test makes a number of checks on the performance it
> measures and logs them to the output but does so in a custom format which
> none of the automated test runners understand meaning that the chances that
> anyone is paying attention are slim. Let's additionally log each result in
> KTAP format so that automated systems parsing the test output will see each
> comparison as a test case. The original logs are left in place since they
> provide the actual numbers for analysis.
> 
> As part of this rework the flow for the main program so that when we skip
> tests we still log all the tests we skip, this is because the standard KTAP
> headers and footers include counts of the number of expected and run tests.
> 
> Tested-by: Anders Roxell <anders.roxell@linaro.org>

Hi Mark,

This patch is missing Signed-off-by. Please fix and resend. I will pull both patches.
1/2 is okay.

thanks,
-- Shuah


