Return-Path: <linux-kernel+bounces-105233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46BC987DADA
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 17:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01226282119
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 16:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DA171BC58;
	Sat, 16 Mar 2024 16:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="usmkwvGt"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196391BC4F
	for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 16:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710606985; cv=none; b=d1nebu43AIdwdshKck8q9RcxuBu518b9eyxfoGmvffECsiCvHLcrOj9Piwn7AqcLAbtMV1Y4Tx0nlWlDFFV0MycSIFhCL6cMPNDfE+VDlHG6t3GDA41UqK4GVSXz5dKBOroD7+jPKI1ZTpyG6zmEn1XKzYuAqUj9GI/sydeYqBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710606985; c=relaxed/simple;
	bh=JYnUU9mew6YYRRbOZD1xZx7zv6EKUVNC17TuBzdPVnM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Zm/9rSdNxFzbF5VRbOue5SshYFcfsrH8IxetATTHzwpAtRcPxxJGUFOpVSOdzAsSRUt1DPdDM39xrrHdArcrNKToi/YpjVCU/+fTnLqOQemcNQPfnxc+xYbOIlr/Nh4uSl9ZPKM4SLoeEyscU7FHRqXoqshm1nb/2OmJiWLkTqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=usmkwvGt; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1def81ee762so2845935ad.0
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 09:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1710606982; x=1711211782; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sIgc4K5sBCYB4E9ohg/qM50cErwvd5n316PNE/cXMG4=;
        b=usmkwvGttxF5Zavn705EiZMQJZVxO0vPLBAH5P+og98Bt3tgpVUWQapUbhIejwMJSe
         yb+v1aHdpfUay1HPHWVEk/HegBu7pd0MgnIkyY7qKmk0GSZu8ew7qng/6LPr4RrHG4/z
         2g66L0c5uuAra7R8wXR7HX6Tm7ucn60qV1TlyYYTM8XG76K/LdkiXHvLdudSL0VotH0O
         596DBVuoUYC+z+6oDpOxlwD6weGQmh7+cvPfbG8SkXI280apDKcHE/0RXSceA7As33Vk
         7DnmsQrlleEOspwz31zH447pCXdJpGIUoCCwCa0hLsW7c7xPBFgCc8I5gZR5YvSPVBnd
         5etg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710606982; x=1711211782;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sIgc4K5sBCYB4E9ohg/qM50cErwvd5n316PNE/cXMG4=;
        b=c0DaDYQLGrWkK/HK+9y+vRHuejVwuXYQ/BmtV8LvffIaAYSA0LnUwdIhv/EEvX17PU
         2dJBFXgZmr5bD9Xf9AVNKUopOBofbWG7JLFo4S1MBU/YGpeqs8WIZopgYDFVuDXyE0xN
         lBbNgp6gd3F+Y89L7r2zs0XdIogNUQiwphCeON2U+MSIKA1vmPDDfPna7rIt75P3FyBz
         QuxEfiPFjfUbUgCDQ2Zh4P4K2vyq6HME5YGNWOiCGa6y/PPaW8r5cf2ApGlnMaTvftJH
         6scBOfmGL1Tqipf+AmCK4e8g7odIeTvxEtK5O7fYD0Aeh/EDNt116wv9h4vOmD2TajvQ
         3wiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRL8YCvt4AKoHISmemiQdT2OTKCCuQ0MpI2n0sXd1CGrDW9ST2uomIEy+L1UPiueGtiDJ28OfKs92I47DrbConbsco/VxT+rOTROh8
X-Gm-Message-State: AOJu0YxFa/R26nXPDYnkSR14hGe87WCyyZ62FvtaIJahGC7enneD0up/
	ZlmiaCxTlDznXdRaclrILIsTJa3slQVMFeGakYW8VF4bsHPjFKpEDHSdoqgHDpw=
X-Google-Smtp-Source: AGHT+IGAYUOz3ilALO1v+qbSb1zIMsdRvT5sanMsg9H8UcdIm+tW41XkuRhmWuFdjqwgPhwvJPfCVA==
X-Received: by 2002:a17:903:24e:b0:1dc:c28e:2236 with SMTP id j14-20020a170903024e00b001dcc28e2236mr9620830plh.2.1710606982426;
        Sat, 16 Mar 2024 09:36:22 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id mp16-20020a170902fd1000b001dbb6fef41fsm5991127plb.257.2024.03.16.09.36.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Mar 2024 09:36:21 -0700 (PDT)
Message-ID: <7c16c203-8b5f-41cd-8c86-cba36887b505@kernel.dk>
Date: Sat, 16 Mar 2024 10:36:21 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [io-uring?] KMSAN: uninit-value in io_sendrecv_fail
Content-Language: en-US
To: syzbot <syzbot+f8e9a371388aa62ecab4@syzkaller.appspotmail.com>,
 asml.silence@gmail.com, io-uring@vger.kernel.org,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <0000000000004db6840613c99fc6@google.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <0000000000004db6840613c99fc6@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Let's try this one more time:

#syz test git://git.kernel.dk/linux.git io_uring-6.9

-- 
Jens Axboe



