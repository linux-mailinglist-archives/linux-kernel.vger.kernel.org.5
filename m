Return-Path: <linux-kernel+bounces-78515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85FEB86145E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:44:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24FDD1F249C7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6682232D;
	Fri, 23 Feb 2024 14:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="coMqQ7hy"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1508E4C8C
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 14:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708699393; cv=none; b=WV0vEn3zWZxJ7xWH/AdXisHwtTXA8wn5X4nk+AAugo7fhLY/Q9vuxfajyxDcsSMmGXTWwATQJ31h4j/M6XYUWON8jNJ/ps39nKSu02IFIqe4vEcVyao9qab0gs3KXc9/qEsrwt90iJRJkb0e6glkeMsGWUTzhzJ6HsgMcxw0dBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708699393; c=relaxed/simple;
	bh=LCCnxhxOKUUGScjoj8X/h+vtjtJ8g9tt6GUc6Qartj0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QofJ2ToiX0e7dRpMfFaSCiTQkxGz+0d/vt+d9F2/QvuJ7YKS41cCROudeKZaOSwHflHVvW+laTknycownX7TcGnRBq+2+ua9Jw0Z+Z+AvU4jdGha6Q0DOIrulBStRWtlMHRzevik+8yfq7T0KGBhbXXCyviZS74SsAmYMpm2ZKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=coMqQ7hy; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d748f1320aso522985ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 06:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1708699391; x=1709304191; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GaiOkbA7+hcdvvfDFyD524BR9JUDgPVysbGQWfqsDPs=;
        b=coMqQ7hyMeoPDlFryqCi3Yjbj8HfuO3QSwyNknqI0QT0YLje91naBj96S2Ih/IdesG
         DzoNG+Ay2A9iUZMIi7XZSkmf4fAXgTO3Ar8FrMRnFNIp+oRI3m1yPUIIUUdDRAUjnma7
         wcEWDGI0UTI69e9QwCXSm1PcnDK4cqXFvOsCjYswgZOeEJt2MrRfT/ikELxCr3Lmpwoq
         CCPh8/eelf27Yp4nh6Ra04qJRySpfJIZ4qZHiPMp0wvNlX2LgOJH85h/GFLRb8SF/b9k
         EBugKy1QHd30vIcempHm2my3vLgu9TuMge+3n+p/lp/y4yUfeyLP4YzcMm8pauvNuwVJ
         BqRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708699391; x=1709304191;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GaiOkbA7+hcdvvfDFyD524BR9JUDgPVysbGQWfqsDPs=;
        b=HySMsA+OS4qHB1V8SHUxRoxWXHXlz8MTn715jDSp6XpdYYXtTpOfdRyrWmXRRqNFqK
         te24/u30xUhFxn4lFyXglyFDxESG49JVSmzHLnz5BvheQaAkQRMwFee1FLHpThVi6le1
         T+GlPu7WxcI5T9Zz33El9kkqN9iOhurpF0T8YBHXgAU4P3YlH1wMGBOGBAK1Vaxq6Pjb
         0Z/mWV5FwgaoCrp1Z8DiNABNOuP5BbHZ+T4OT2L5cuC+ZQIfFnhscRZ4WkhvbWuugzmh
         BGJVuhkvV9y6kx6thLtoyU6GEoLcf6Yzzqpi9sNSxFd1S+S6pl5YQzbrkTOlkbtgLi3l
         SVOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWU0H4fdjv9kh2Z7oSah9YQs6hvpKlZ7StA5TfsBtUX/xD2cgNXMdsT1TMQsiBIX/f+jEe+kMCIB1Ziy9fuIc0+aG5p2DkBfCNQBVC3
X-Gm-Message-State: AOJu0YxaIe2UIFuGSRdF6MhGMguE7TqVRRkvuC66bKBXyM8UEAIpsu0+
	RpicgmBmZRyNtt5CXGm7dZq75QTXt1KQwrgJWWyKHPl7Nxf+mf60mxlUWEeuQaU=
X-Google-Smtp-Source: AGHT+IFCe2OmI6udUtrLrpGM7CH6IcwXuOjaaWwTj2TJkeKJuL+YC18h5jSygUOYCFe/1oOsbioDdw==
X-Received: by 2002:a17:90a:3f16:b0:299:3fb4:4f28 with SMTP id l22-20020a17090a3f1600b002993fb44f28mr1673303pjc.4.1708699391114;
        Fri, 23 Feb 2024 06:43:11 -0800 (PST)
Received: from [172.20.8.9] (071-095-160-189.biz.spectrum.com. [71.95.160.189])
        by smtp.gmail.com with ESMTPSA id z15-20020a17090ab10f00b002995e9aca72sm1522284pjq.29.2024.02.23.06.43.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Feb 2024 06:43:10 -0800 (PST)
Message-ID: <3cbe7ad1-421a-493c-9cb2-9234e139923f@kernel.dk>
Date: Fri, 23 Feb 2024 07:43:08 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: gadget: f_fs: Fix NULL pointer dereference in
 ffs_epfile_async_io_complete()
Content-Language: en-US
To: Selvarasu Ganesan <quic_selvaras@quicinc.com>,
 Greg KH <gregkh@linuxfoundation.org>
Cc: brauner@kernel.org, jack@suse.cz, jlayton@kernel.org,
 keescook@chromium.org, peter@korsgaard.com, hayama@lineo.co.jp,
 dmantipov@yandex.ru, quic_linyyuan@quicinc.com, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, quic_ppratap@quicinc.com,
 quic_wcheng@quicinc.com, quic_jackp@quicinc.com
References: <20240223054809.2379-1-quic_selvaras@quicinc.com>
 <2024022302-routine-schematic-b4fd@gregkh>
 <d2f40e2d-cbbd-41f9-9aa6-41d0f251ffda@quicinc.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <d2f40e2d-cbbd-41f9-9aa6-41d0f251ffda@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/23/24 4:35 AM, Selvarasu Ganesan wrote:
> Here?s what the code might look like with a new lock:
> 
> static void ffs_epfile_async_io_complete(struct usb_ep *_ep,
>                                          struct usb_request *req)
> {
> ....
> spin_lock(&ffs->new_lock);
> if (ffs && ffs->io_completion_wq)
>     queue_work(ffs->io_completion_wq, &io_data->work);
> spin_unlock(&ffs->new_lock);
> ....
> }
> 
> 
> 
> static void ffs_data_put(struct ffs_data *ffs) {
> ...
> destroy_workqueue(ffs->io_completion_wq);
> kfree(ffs->dev_name);
> spin_lock(&ffs->new_lock);
> kfree(ffs);
> spin_unlock(&ffs->new_lock);
> ...
> }

This obviously won't work at all, and it's not the right way to fix it
at all. It needs a ref count.

-- 
Jens Axboe


