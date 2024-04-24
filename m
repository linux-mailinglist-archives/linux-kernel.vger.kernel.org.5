Return-Path: <linux-kernel+bounces-157532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B93638B126C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 584561F212FC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA83171CC;
	Wed, 24 Apr 2024 18:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yw1Lqou+"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6887E14A85
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 18:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713983610; cv=none; b=nw9fsWVedntjtoh2XZLKI3etG9IahR8kTy//IG/78lNXiEfjXqlOch3qRrd4SeXgSKOuy1Qm2gX3IopI0PrdWvBqFlB+o/dnqytycbUnafVtL9+DxkN+Kjf+BwGOEiyCKxThb8ivr+TGTI5ZaapN8ojlX8Bci2MzkQEh9JOu5h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713983610; c=relaxed/simple;
	bh=kHEzDIv3XUVBHeAWKXNAdviJULHuAQPFpdGHRXmFYH0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=YXYVzo19nq3oTvLGC6rMUELG8k9/FPIHIKVflKGRncpgIMtKdRLD8Hcgy89NAxAF6RkGCAb0sYX/aBaFBMgqtjPcnQjYa9xom3D0d5n4klkSSu518ZFOSObuW7jLhjZH61oy+vlIDvtCgmbm/VTAo0+3gvIpKnHCcJc52ZKhgHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yw1Lqou+; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-56e479dd170so9205a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 11:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713983607; x=1714588407; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mymcTcoFnmfCuBd9tSV1M+VIzBLDz8u1np2D12YjbSY=;
        b=Yw1Lqou+vXWr27j+oT1pxFZe0HRYk0UsWeANvWi64xrOFWD4zf6J4SN20H42Dlq2o1
         O6Ew8h8Nq0NweAGKVMxQEMKr3kTtGetbqaKc1zKSy4VH+pLbXDXdvhO/UiKUlyvX2uYZ
         Onbyhcs8mwR0r/lmI1vm31YXjMdpqQPUxSWXVDPOJnhg2UEuk6kHAd32B+Xatb/+QOpc
         UMIoj8fXcx7Iz16vraUHUASOyL7iQaWwyCVoo9zd57EN8PjUWch4TNmK4aSVZzgcVIPU
         L03pFxZU8eBAdGbnZRQfPV7mJHGDZ7i3qZThVCrywZYpLNbw+J/MWrDHt5cQ7lyXvwtc
         Vn5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713983607; x=1714588407;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mymcTcoFnmfCuBd9tSV1M+VIzBLDz8u1np2D12YjbSY=;
        b=A1Rrh2sml7H1F3ycGaosAz7YySbLwJWQouQbiBxzqLE+ze2JEBGQLausAYEPSHEaZ0
         ecTFVis++D/6++ZN2YisvPt4qPlJIhJVu2ctCVYbQfL6lSc6goZjLi1lJfnUj8wGsFYZ
         u6qh71pF5EbGglavrz4MM1h0hhUtJ7HDFeaS0Vi2N8McvF11yQXf4JTyI1bMPDzkCSQd
         EtxBU1cUnXlAzmAvLKfD4jENHNKBpQx/fsnY/LbVm5B61WQyugYVgvyVM7zoYeFzEUi3
         IRa2pHuyvmacj5EQr/XkAFK6JmXFASWtpRFiFJeByx5NgT3sTVzwsrtQ0kZDsXVuDSTN
         BBsw==
X-Forwarded-Encrypted: i=1; AJvYcCWvu/+xlXpzf0k67u1ZyMAWjyNEZqsy0a45uuqNGXzrbIDSjKEjTuDG3vg10auR9Lgb373gFEvD5g+UrmeSxA71DWPUEYOStS1CxmR2
X-Gm-Message-State: AOJu0YxaoENo4tJcgw1b9SprXR9OASX7IR3zrDYwWTkHj/1U1X0ZHBab
	e/Y8Cv6NTyTz+YQlT7JbflapW5KX1o0H9eksRsMcZQLoo21uI4aA
X-Google-Smtp-Source: AGHT+IE9WvvwGZMCcIImCTKQ+CZB4Pk3J+Ehqq7A2TXWkBPqei7QD2l8gfXMiDVCtONY53pQNY2vbg==
X-Received: by 2002:a50:9e81:0:b0:56f:e1af:58ab with SMTP id a1-20020a509e81000000b0056fe1af58abmr2749373edf.4.1713983606461;
        Wed, 24 Apr 2024 11:33:26 -0700 (PDT)
Received: from [192.168.0.104] (p57935690.dip0.t-ipconnect.de. [87.147.86.144])
        by smtp.gmail.com with ESMTPSA id g22-20020a056402091600b005721f9fbb60sm2265577edz.63.2024.04.24.11.33.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 11:33:26 -0700 (PDT)
Message-ID: <78b521eb-4e89-4c01-8dfc-1fb990e6887d@gmail.com>
Date: Wed, 24 Apr 2024 20:33:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [RFC] staging: gdm724x: How to proceed with drivers gdmtty and
 gdmulte
To: Jonathan Kim <jonathankim@gctsemi.com>, Dean ahn <deanahn@gctsemi.com>,
 Won Kang <wonkang@gctsemi.com>, support@gctsemi.com
References: <f82fffbf-a983-4ab4-897b-b5a810426f04@gmail.com>
 <igi27iwrzg3ovgj3sym4gsi45timpkt4vkl5ss5dbftdzat6p4@ctxcjocvunpt>
Content-Language: en-US
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <igi27iwrzg3ovgj3sym4gsi45timpkt4vkl5ss5dbftdzat6p4@ctxcjocvunpt>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Sirs,

Won Kang contributed a driver gdm724x to the Linux kernel staging 
subsystem in 2013. Have you done any tests with this hardware in the 
years up to today?

struct usb_device_id lists the following devices the driver can work with:
PID_GDM7240		0x8000
PID_GDM7243		0x9000

but on http://www.linux-usb.org/usb.ids I can only find:
0x1076  GCT Semiconductor, Inc.
	0x0031  Bluetooth Device
	0x0032  Bluetooth Device
	0x8002  LU150 LTE Modem [Yota LU150]

I am asking because I tried to find a test device to test it. That is 
difficult in 2024.

Do you think the driver can be removed or should it stay in the mainline 
kernel?

Thanks for your response.

Regards,

Philipp Hortmann




