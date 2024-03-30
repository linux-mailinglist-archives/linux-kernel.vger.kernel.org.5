Return-Path: <linux-kernel+bounces-125620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF138929B8
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 09:39:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B1362834D5
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 08:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5257ABA4B;
	Sat, 30 Mar 2024 08:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gt6kr7Yc"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01ED2BA22
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 08:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711787940; cv=none; b=uiraYKD/6HrckbEcIdA6QyRe6xFlMQJ+IzZYH7laMSZ7oA4YK8S2QYLi7lAbuZnoADyxSLn/+IZx1TXe/XznxXY34XBwNWq6wLOpaHdkSPTn1bHyJRxKSTDqkNrSzGf683Jxw7vXnCh3Ab+UdSFNq9gBhqRK3su+FyhtMKNeyWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711787940; c=relaxed/simple;
	bh=99nS6E5hfEX4eZ1ns3irfjDUaedYAY2Pc9AcDzzlVvI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tx/F6zN5rNhIbYBDPzBnVxFUAAbdjT1BKfGVqhbt0MrVBahD7h7wnbGgqDFNqu7KAetwa7d71bFuXWZDZpmwjxNCQNDUa/yGQkzu0cJjCylQImiavMU7/ugZAcOXYXNavJlIf2hqSEe8xtoHYO5DG3jPy3o5A/RWu867+WmLW+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gt6kr7Yc; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a469dffbdfeso99124166b.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 01:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711787937; x=1712392737; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+29tVCvEh72BJXmexedWaujnyoNB4PTusgrjxb8rRVo=;
        b=gt6kr7YcoUBGKm9wq5XrtxKgmC0cZX7BpEibc+3v8Er/C2F66rUm7rh13bpC2QheUQ
         7E0RTA/AZZK9YLKEEUxmQFHiq68JvibVl3OufN85zD6NE7jBjw+E/mFRLVLva2CdW35f
         Fwa5isGIKmee3KwgAUJMTZzVl2IqvcBSyEbQ5XWCjxRYqeUYUuz5PyKxpP46IBtA041s
         JTuHoHOhovcrqJAMtU1nyOqcy68vHhjSh8AwL7RIeW3moXad4++bGaN/tlyS8lw/hZGK
         UGPbCkRJ7z8sIYBfVAo3w+hXWHb4tFx4sMqSz8Oi1LgXMcBPqbQD8C97biVblyyXD54L
         HEyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711787937; x=1712392737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+29tVCvEh72BJXmexedWaujnyoNB4PTusgrjxb8rRVo=;
        b=Y4bx4aBWx5qQVs5RFVv5lR4892OMBd9j36S3YfYzgS2OkmyJHAM8a3VgCyK2ieHiNv
         VbrxrClUzVtHrC65WixH9t6oFnJo2YUCtxKSoUxa/qUBSP82WhMzkS1kn0Cax3YdwmMR
         pHDUIPhnUEy10b5QVI32Og+ajezzuvRG+r2BCUrssutRPnNUpnAkrHYCQEZSswPSI/ge
         r3iR5U8DCWeiai2cZynCM7Rt7Ohj48Nlxz7WM58YLpWXZKIUF4CmrEGYjRhDeXo7QLjc
         y39NxvuStTg3s/NIiksQUSs42cqW5yMQPjRYEaojmsuEwy/D3OZ+dqFuOevlRRk7ODCH
         saKg==
X-Gm-Message-State: AOJu0Yz93BtFnZiVC+rexggb5KP3h5SyBtod1722usLO9nOzfvuoz0aW
	pLDYItFTD0dhRyMh4zgNPEYaWE0x+SRZPuioVof+TXSizgovz6wVDRz22X+PMv3LUQZ0zB3S+kj
	1pufXb0eXGdvA+6CYPd6chfmqWhVvqsdAb8RdTiU4
X-Google-Smtp-Source: AGHT+IHq0KsC3lNFh1hPNeVRRbf8ajfjD0biapfM7ZT//q/8YvFh7SGqicscMkrTFFCbo6vIIOBKM9ZHJ8QNYi1eo1c=
X-Received: by 2002:a17:906:49a:b0:a4d:f85a:c458 with SMTP id
 f26-20020a170906049a00b00a4df85ac458mr2724093eja.4.1711787937236; Sat, 30 Mar
 2024 01:38:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240328064539.95795-1-richard120310@gmail.com>
 <20240328123608.a20ba1260aa9467df9f4256d@linux-foundation.org> <CAH5jb=aY1y19=XAKJG4368Ey6Sq3759euKsWLkLMATO9ac55sw@mail.gmail.com>
In-Reply-To: <CAH5jb=aY1y19=XAKJG4368Ey6Sq3759euKsWLkLMATO9ac55sw@mail.gmail.com>
From: =?UTF-8?B?6YSt5Lul5paw?= <richard120310@gmail.com>
Date: Sat, 30 Mar 2024 16:38:45 +0800
Message-ID: <CAH5jb=b=SXSRQM0YHb0fz5Rt+k1DMfuVQ-Fj+Sa20XrNM+vwqg@mail.gmail.com>
Subject: Re: [PATCH] rbtree: Introduce rb_remove()
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>> We wouldn't merge a change like this unless there are callers of the
>> new function.  Please tell us everything about that.

The last reply didn't follow the requested plain text form, I'm sorry about
 that, again thanks for your patience and time on reviewing my patch.

Best Regards,

I Hsin Cheng.

=E9=84=AD=E4=BB=A5=E6=96=B0 <richard120310@gmail.com> =E6=96=BC 2024=E5=B9=
=B43=E6=9C=8829=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=885:10=E5=AF=AB=
=E9=81=93=EF=BC=9A
>>
>> We wouldn't merge a change like this unless there are callers of the
>> new function.  Please tell us everything about that.
>
>
> I see, thanks for your review and the explanation.
>
> Andrew Morton <akpm@linux-foundation.org> =E6=96=BC 2024=E5=B9=B43=E6=9C=
=8829=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8A=E5=8D=883:36=E5=AF=AB=E9=81=93=
=EF=BC=9A
>>
>> On Thu, 28 Mar 2024 14:45:39 +0800 I Hsin Cheng <richard120310@gmail.com=
> wrote:
>>
>> > Implement the function "rb_remove()", which can perform the removal of=
 a
>> > certain key from the tree. Once the node with the searched key is foun=
d,
>> > we call "rb_erase()" to perform the removal of the node, otherwise the
>> > key doesn't exists in the tree then we return NULL.
>> >
>> > ...
>> >
>>
>> We wouldn't merge a change like this unless there are callers of the
>> new function.  Please tell us everything about that.
>>

