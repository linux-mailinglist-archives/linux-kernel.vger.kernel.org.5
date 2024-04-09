Return-Path: <linux-kernel+bounces-136914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D5889D9CB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A9EB1C228CC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F8FB12F381;
	Tue,  9 Apr 2024 13:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kJuO/K7/"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418D8129E7A;
	Tue,  9 Apr 2024 13:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712668066; cv=none; b=gWiQttspZRLNLMvIlOEU3Uttru78keRRH/wQNzpOurxcn8qFtU5mFxdeO3+eJV0xDEIWkwx+BjvKCDh1ifMVmcN9E233GRJrRWeTTvvdCz5xlH+bBmgmrBUqIM7TwP8HcIVnnCxrG5Nw9ff9j3Bn1hYSArblEpYXIJYpV2av4d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712668066; c=relaxed/simple;
	bh=JN/xRVfnG75kasVUTn1o2Nlnh37spjVebvIOlAwrxH0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E0hnZk+MMRk/lrhesxyEffQas72ZSE787RhyLXseNfDI/q6SBs/hv8EKMVpuVE+FTSVyEvCwCVliuw0BsipD+Iu5bQCfW2fY0QWIsMWh2UaVNSoPCzWccvbxzEuEsLaXc6/L0W7z9i3XSmEqI4xkyT1/6hLpt8TfAfn1WQl6Hzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kJuO/K7/; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-343cb97e7f5so958908f8f.0;
        Tue, 09 Apr 2024 06:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712668064; x=1713272864; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JN/xRVfnG75kasVUTn1o2Nlnh37spjVebvIOlAwrxH0=;
        b=kJuO/K7/szUnYQsQNShZu7idzfdbc+Lrc/gPdS6Mmi7zeWdIkRzJax5b8ob98biInU
         YVmrtdBlyo2iX4AsAop0MOC5nmdY+H9hA82S279QYNoSb7+eOr341ABX7sMopE/vWbFE
         40S8dXZ/toRJhZxTfqxTD/bzK5IBXldghxV31BiNLzmeXP7Y/vgUmDj6arjqLzgKUtwV
         0fDXgtOhnPIZPy1EvuPPC10ihz8hMNW+Hi13Ip15jCOWRCbam5x1UAnAEHtk3r1C7ReH
         8RWtu9QLZdC2yoL+4OY6PUYI5y6ms399DN6Bid1+apgXI0BiDPdjR9Osu2weAUI0LTVX
         n+ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712668064; x=1713272864;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JN/xRVfnG75kasVUTn1o2Nlnh37spjVebvIOlAwrxH0=;
        b=ToYArFEk/dmX1xh/UWgDUK+SwTT1s5yzi10IEyIpwE2j0oUAOyyXiKf0Yo2Vlgl+rM
         HmcAicYVB/xSogOz4PW4Nt2zoZlGfugd8mhO9vCTUhukpYskxIQ6MBFVFPCa0T8cRuRL
         Bg47DTpy2y4H1wJSx6it5rz/B0WRUC/JnXWr7jX0wxafliAaE6mKn7hs5CJPTps6FLgA
         Q8s4jdzcMmFNpqbu1uSUExjjE3fwdLW3ALQbePWGegYATJp7YMn5um/WDY4nqEDFVxmF
         bMLR+rBq0MPZ4WQDUrWKvCp5REYbN4ZVrPPOXxqdwkEVMe2u9jzPxQUO450WV9vHUuQd
         Ly5A==
X-Forwarded-Encrypted: i=1; AJvYcCX5kJBe11mxogpLVnU+ubWUYUni6AjA4B3aYtpvfeJ7ZVTlj4uLMRSbD7IYR9Mg2VJsaQEwbk9eY7h5QaT+ERpdxqDz2P8kIrE7YoDgF9druYJa0kCuhIlqPZE8+LUMuAn3pM1+Ngy2UjTs45l+
X-Gm-Message-State: AOJu0YwCn4ITO/MjvLXx97NGbAhrOsflkRzk/HR0hVTopRv78mSyLeFu
	VawRT+sYZCquz7PbSaJmVDAfC9ePuwn58SAfzN0ix2Kw+zojT5TV
X-Google-Smtp-Source: AGHT+IEJ4LqPNVe5bdubUNjQU1zcwKWQfnQH+JHUZHlf6Tzq5XQT1zxrBbrh2JKSy2BHLndJQoK9EA==
X-Received: by 2002:a5d:628f:0:b0:343:760d:29c8 with SMTP id k15-20020a5d628f000000b00343760d29c8mr8067527wru.1.1712668063342;
        Tue, 09 Apr 2024 06:07:43 -0700 (PDT)
Received: from [10.0.0.4] ([37.170.252.166])
        by smtp.gmail.com with ESMTPSA id dm14-20020a0560000bce00b003437a76565asm11409760wrb.25.2024.04.09.06.07.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 06:07:42 -0700 (PDT)
Message-ID: <7cf0848b-f44c-42ad-848a-369a249bff77@gmail.com>
Date: Tue, 9 Apr 2024 15:07:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/socket: Ensure length of input socket option param >=
 sizeof(int)
To: Edward Adam Davis <eadavis@qq.com>, pmenzel@molgen.mpg.de,
 edumazet@google.com
Cc: netdev@vger.kernel.org, johan.hedberg@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 luiz.dentz@gmail.com, marcel@holtmann.org,
 syzbot+d4ecae01a53fd9b42e7d@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com
References: <234da60a-709f-4430-b594-386b7c2b65f5@molgen.mpg.de>
 <tencent_15CA920ADD9ADDCA19654FBE8DB5A5B88D07@qq.com>
Content-Language: en-US
From: Eric Dumazet <eric.dumazet@gmail.com>
In-Reply-To: <tencent_15CA920ADD9ADDCA19654FBE8DB5A5B88D07@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 4/9/24 14:15, Edward Adam Davis wrote:
> The optlen value passed by syzbot to _sys_setsockopt() is 2, which results in
> only 2 bytes being allocated when allocating memory to kernel_optval, and the
> optval size passed when calling the function copy_from_sockptr() is 4 bytes.
> Here, optlen is determined uniformly in the entry function __sys_setsockopt().
> If its value is less than 4, the parameter is considered invalid.
>
> Reported-by: syzbot+837ba09d9db969068367@syzkaller.appspotmail.com
> Reported-by: syzbot+b71011ec0a23f4d15625@syzkaller.appspotmail.com
> Reported-by: syzbot+d4ecae01a53fd9b42e7d@syzkaller.appspotmail.com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>


I think I gave my feedback already.

Please do not ignore maintainers feedback.

This patch is absolutely wrong.

Some setsockopt() deal with optlen == 1 just fine, thank you very much.



