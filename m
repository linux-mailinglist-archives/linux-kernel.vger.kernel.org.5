Return-Path: <linux-kernel+bounces-83301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 350AA869188
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF29B1F258D3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D252513DBA5;
	Tue, 27 Feb 2024 13:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vLKrpY/A"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9159D13B2B2
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 13:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709039764; cv=none; b=tNTVnYf93HLSdVofi6ERKaomn6omffLnAJgIsn/9MOwHupLIPzD7Ngc/CsED5gqKsVrbMS9GyFWIUEy97nVhKOLpuahrVXAExv9wvWAH2iPv3+8QxtrfT7lKLPBsDU2oSpn1be5C4+B5JJ+VDm6CFCLwoJ+RmlDyyvODiTX98v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709039764; c=relaxed/simple;
	bh=8w6yJF1pf4+K6HFovn6W+rqsOmD2i17OUax9f7eXWyk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YY5PtU1MSsiDYHhuPNBZWJReQK5TSxpsHoT5JRO6VFpfubJZ/tPu0RfU/xsXzG7OqvvIwfqn0RiVdcewGv4+keDFwI7qx6n3fjMDsU/dUxJUwLyavcweFW2kylKO5/4NnBxWODPFHRB7Hb5nCkntRKPE0dkD+Qr6bRxCXG1i4Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vLKrpY/A; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5664e580cb7so1880a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 05:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709039761; x=1709644561; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8w6yJF1pf4+K6HFovn6W+rqsOmD2i17OUax9f7eXWyk=;
        b=vLKrpY/A4zfOmqzSoINzuw+iWIWRwy2h/ojgvl2E665yZQIcnqoDD7ipZ6KhHMLwe3
         5Jikn4mOq/o+DtX59Mi1aWqkH9qHQLMr0b2RH6X0s9irAe88HUL2NAhOdOf4OG8wn1j8
         ygFcqqkcy0sd6eiC+oylqTKdAcKY6bGQsRoe2d/Rm816dkImEkLY1eTGVX1q2Yx6OZLt
         GZXz4iBpBaq5nu0dNY5fCZjclsCcN0B7xnYFXoPLbw2QIcCwoQOaUQ+ZIn+PjnoqvfaR
         RcntMirsxu2+Jb5lRb09CFS8t0ORdFUrV/9v38acVU/cW14IKh1zZb4ZFE4XZdOR6z0g
         Kf6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709039761; x=1709644561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8w6yJF1pf4+K6HFovn6W+rqsOmD2i17OUax9f7eXWyk=;
        b=SWFLAzt7B3d7l3KrKW98mLMS8aAUemeaJAYmU2Q1H1IS6cC0jh8ooxJ9F/6XUuG2Ep
         JE6h+Gwab6FTLF/yT0UDs+KONyS4LIv5Z4hdYHs2qaZxU+HnJ7VLM4adXyJA+gkoe7W5
         p3vunzMJczAY3etLxren0Zk8S36l5bfzyOjx+VGC1+fXsjl2l4TA9vjtT4wXZPeo14+l
         PF1YbMFmJgHI5fkfNCQgvEHhMcP7QFv0tUc66qk3VfNb05PguQ0rvOXHa6wXYCA0VSxp
         yr77gY74ASQJ+75bjluTvqsW6uQ6NYuOnfOt0yufFV78fNUAB8FZqfg31zjIMeG3Uc97
         7Gmw==
X-Forwarded-Encrypted: i=1; AJvYcCWfWcHM5dHz1aDuZETqrP9ykN8A7QZQVYPUDkCVsTuvn9qFQfzVFyM4TifOnJoiVG3nt7pbKKZb3Ih9DgJr1j9QkmqAfzIi6Q4kamUo
X-Gm-Message-State: AOJu0YyWO20qO1LItPqa1dMUwMuseY/tzWmqtyYgTFpDT0DQNeCauph3
	1g6/jFFIntpcERZBr1tzkTsQMDZVjIdu8SNDMfvlR8adBiAo5A0W9J9giy761AG2P9pRIP9WHna
	jL0DakHIrz1sMaDTz8C87hW/peirnMngPXI6F
X-Google-Smtp-Source: AGHT+IEgjBD8SQeKmPmPD9H4CjpoRfz+TkEI9OjKFyRvAUJNO94nVp/JGZDOO6FVOyYwFb4JeZW6mcvO4K31zgBwh5I=
X-Received: by 2002:a50:d490:0:b0:565:733d:2b30 with SMTP id
 s16-20020a50d490000000b00565733d2b30mr237561edi.4.1709039760718; Tue, 27 Feb
 2024 05:16:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANn89iJoHDzfYfhcwVvR4m7DiVG-UfFNqm+D1WD-2wjOttk6ew@mail.gmail.com>
 <20240227062833.7404-1-shijie@os.amperecomputing.com> <CANn89iL2a2534d8QU9Xt6Gjm8M1+wWH03+YPdjSPQCq_Q4ZGxw@mail.gmail.com>
In-Reply-To: <CANn89iL2a2534d8QU9Xt6Gjm8M1+wWH03+YPdjSPQCq_Q4ZGxw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 27 Feb 2024 14:15:49 +0100
Message-ID: <CANn89iLAPhxCuy9omqdTjBT96yK2wE5o5gG+nJNegf+ioo=Aug@mail.gmail.com>
Subject: Re: [PATCH v2] net: skbuff: set FLAG_SKB_NO_MERGE for skbuff_fclone_cache
To: Huang Shijie <shijie@os.amperecomputing.com>
Cc: kuba@kernel.org, patches@amperecomputing.com, davem@davemloft.net, 
	horms@kernel.org, ast@kernel.org, dhowells@redhat.com, linyunsheng@huawei.com, 
	aleksander.lobakin@intel.com, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, cl@os.amperecomputing.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 1:55=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>

> BTW SLUB is gone, time to remove FLAG_SKB_NO_MERGE and simply use SLAB_NO=
_MERGE

Ignore this part, I was thinking about SLOB.

