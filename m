Return-Path: <linux-kernel+bounces-28854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 881B08303CA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 11:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02C5D2871B7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C1321B81B;
	Wed, 17 Jan 2024 10:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="FTcsmErh"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5417414A81
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 10:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705488120; cv=none; b=RB0amecpWVTSKAnUE6M4fOnJ0dvQX30QcfFSvujh4BZW2fjYqDbNcYKfTrxz7CWjE3FnYziFKWEuiHIhoj1ZcCGfCKbkF6/u0uKt4lj90HTIy28y/6pKZ8ONplF3HZtAKLd/isTz6TP90IUvgUgpnnRHbXGg8uTNKUdRz0HJ/7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705488120; c=relaxed/simple;
	bh=i5zAIMMhInYEAGrZi/IN3RMlZQssJ1GyHiDWEAWZ3dY=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=YD6zLEBHhNs9W7FjpWcsxvXIEEywTpzshJ+UdBXQdFPIBR7LH7HnCb7bmyf8y1fN5VuzbwPVQcEtA3/3t+rDAB7+vQBTsAwa1OD//KNJZiXzLHO7TMEkVMsvixXuqb549rchtyIlGac0obIvn3sfVMifN5sKsyhgkZug8RV1YgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=FTcsmErh; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-50e7af5f618so12035206e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 02:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1705488116; x=1706092916; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ml/MfLxZA9QQVAxJtw3+x9j+f1i/P0GKune3jqkXEnM=;
        b=FTcsmErhyEIMHIi2/81A/HvyjgarveY2Gqn3vj5/AztA4wm3Kyk3NjnTNHrZ73vKIK
         wTq+wnlQ2LDdIIUjzL1PF5VkpTCYbEGc7biqCJ89NCoHwAO01kq+hBULjhp0/dRqGqRb
         B8itsq6iCChoO2FtsPtxQR60ghWB8rdy2rgvQFFLc+uSMd7ALvVIBj8RzI00bWeq7Xrr
         oq0weMC29RBLZNTP+aXx1FpuLjamCUsJP/EEpWjdlBKYCOx4DFtC7sPTnnSNtuVEQe8d
         I6o6h37S9uTL7qK+SEL5M3mQXrHkzMopOX630MAjpa4bY28fZlx7o1A/LkuIxDp0sW+y
         volA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705488116; x=1706092916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ml/MfLxZA9QQVAxJtw3+x9j+f1i/P0GKune3jqkXEnM=;
        b=Bzv9HYhdrQUgHq+XHUYBAogcEk1pFS9se9VYszUddiBQrKNzN59JNAHY+w3JymRH2k
         j9UAB5Nm4ql5svuFFqz0EHLPUJZwaZEnGf0oP/9D7X63pj3UftXZoSdg+1ZKfpympuqW
         zniXAappZA18zQnpwDopHhee+l7Gw20cjpweDJqKaKvp0w+0B735Avs2E2Y+fi1FgW/I
         +WzOsL2w0tUOjv0Or0LSbs40GNLsFFRC1FxdnMbSxQnUWnCVGq74CCfySlby/SGzxNLa
         GdVuzzvOKQnd3FlF5vlkr5y4u8DmtJFM4tX3+sRtCjFJ2E4a8iLCHzmk72MCxuZR5Ccw
         5DuQ==
X-Gm-Message-State: AOJu0YwjvD0aBBxTLMY1Ulhb1neqC+DG7WUIzqKWv4pJJMbqyI2naXUD
	i+f6jRY1fOf3gz3ZkbnuiHrM1+XrDnlRsSbsw+rAbKnnwG1aFg==
X-Google-Smtp-Source: AGHT+IHn7NoY0mFLYqrNPCg6GN+AmYgIAkxTkpLvX3vOr34ct/gxyyER7E3vRvM/PloFq3rJzA17vTgMsnHIRM879+4=
X-Received: by 2002:ac2:4c41:0:b0:50e:771b:9a9a with SMTP id
 o1-20020ac24c41000000b0050e771b9a9amr4543582lfk.73.1705488116076; Wed, 17 Jan
 2024 02:41:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKEwX=NuXR9Ot1eRFsp9n-3Tq9yhjD9up+jyvXeOzQ4xK9kEPA@mail.gmail.com>
 <CAKEwX=Oj2dR6a4-DeccvcVdJ-J7b=83uCWQAf5u7U0sySudnkw@mail.gmail.com>
 <CAJD7tkb2oda=4f0s8w8xn+t_TM1b2Q_otbb86VPQ9R1m2uqDTA@mail.gmail.com>
 <CACSyD1ODCikYLDzO4LkQeDzB4sqDWCULwCdehw9inP-qyw3_Jg@mail.gmail.com>
 <CAJD7tkY=zmGiPoWNjVaVeU+NPxV2t48J5-CxEP9=nBK8nAh0XA@mail.gmail.com>
 <CAKEwX=Na3dg+KZwvtQi-Nj79Am-1tttDw50_qStkobmYGUC6NA@mail.gmail.com>
 <CACSyD1Pp8gkxwTXZuinm6wiZs0e5U2B5oND4rj29dzmRApFjhQ@mail.gmail.com>
 <CAKEwX=OsTQCJd12S3NajRMRy_s3q3yGFpS7S=_3-yOYK6+ezzA@mail.gmail.com>
 <CACSyD1NgqoFKuHSgdw_bzgK_StsLrNQ+7wHVBqsnHcB-2rD2ow@mail.gmail.com>
 <CACSyD1Np1JbKB9punaigGbJ7y2ZWou1Sr7bczanHv4-1UQZ==A@mail.gmail.com> <ZabvMpeoKzTMUS2U@casper.infradead.org>
In-Reply-To: <ZabvMpeoKzTMUS2U@casper.infradead.org>
From: Zhongkun He <hezhongkun.hzk@bytedance.com>
Date: Wed, 17 Jan 2024 18:41:44 +0800
Message-ID: <CACSyD1PYm4wwQvOjkHZVcfuo-Voa4ABZ--n3K70i+s5ag9KnfA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] mm: zswap: fix the lack of page lru flag
 in zswap_writeback_entry
To: Matthew Wilcox <willy@infradead.org>
Cc: Nhat Pham <nphamcs@gmail.com>, Yosry Ahmed <yosryahmed@google.com>, akpm@linux-foundation.org, 
	hannes@cmpxchg.org, sjenning@redhat.com, ddstreet@ieee.org, 
	vitaly.wool@konsulko.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Chris Li <chrisl@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 5:04=E2=80=AFAM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Tue, Jan 16, 2024 at 09:40:05PM +0800, Zhongkun He wrote:
> > 2)  __read_swap_cache_async has six parameters, so there is no space to
> > add a new one, add_to_lru_head.
>
> That's easy enough.  Define a new set of flags, make one of them the
> equivalent of skip_if_exists.  Something like:
>
> typedef unsigned int __bitwise read_swap_t;
>
> #define READ_SWAP_SKIP_EXISTING ((__force read_swap_t)0x00000001)
> #define READ_SWAP_ADD_TAIL      ((__force read_swap_t)0x00000002)
>
> There's only six callers of __read_swap_cache_async() to convert, so not
> really a big deal.
>

Yes, thanks for your suggestion.
The major problem is not the parameters, but the need to add three function=
s
to deal with a special case.  Thanks again.

