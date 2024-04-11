Return-Path: <linux-kernel+bounces-141542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C0B8A1F91
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 21:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8F20286192
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156E7175A6;
	Thu, 11 Apr 2024 19:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GkXdMT0y"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F07171C9
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 19:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712864245; cv=none; b=P1YpBY6P+qVDKZOftb/2m/mhLZjeqV7YG4GRt3lOrYpBblsMiXeH6i964hInzX+ADTlR86JBeHVYW67Gy+JCpU4a1Tg2SLJiF276iDEVhFy/IAaf4AgtVyl8Hqv6b2fXynV81Ngi1rFjVtmQTep3vgoE5C27FdE3pnQRIMmdenc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712864245; c=relaxed/simple;
	bh=Gl8eUkD08CMPCn17a5LUCFQwsdrr+BTJp82u/LJ464E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fogO81BAjIAlTmvh38v48c2KBaLu7ipx9achO2G/FHpR+N8RwCpx+MlFioh37DEvoDJVHRnCQ31ihH0gUnN6H2feKqf1XmJSxMiDofKsRolwtpZmqveOYa6QEnIjSoKgNgkJrMOrMnihHGZNL0Z6KhKQFquL7RpQysCKKW6YliU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GkXdMT0y; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-69b40061bbeso1256176d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 12:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712864243; x=1713469043; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7gaZ8PNPW8x1uU3bx7SgotAf3Gi9LIM4a4uzTn6Vt2w=;
        b=GkXdMT0yPgfIZdOMrvvyM2Yk42tja2P6tBgQigKhubso6S/gOlDFUZq8IdJz8GYdWZ
         KnvveHtPrhdKdwqB+DVDlAAXKaj5UvAS3dxzToB4L6HSoRcDscY2XxpPsc5+HSJutfxK
         LS3dbhoZogsApJAWOKfWKpsVWcyC2z0K8wxw1rk9ZVSLs9zsoRTkVlmGPZo8OjL+UNUh
         oFUTO7Lup1W05prPGRSDNI9bFE4m10M5t1w6/p2qXOnp8VyuBaBLAObSaIuRfUQxyN8T
         ksQqMWQBp897v5dy427z/YdubVW2yKg2gTf8It0perft6oQkOVNUyjuZX9AQ6GqIhCat
         0IpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712864243; x=1713469043;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7gaZ8PNPW8x1uU3bx7SgotAf3Gi9LIM4a4uzTn6Vt2w=;
        b=C3Y/zLVrDeuIjWINbz7GnOlfWblAFCwxl1XgdrnFPE4BtY9hZieWINgBkjPYCW8v+b
         E+AWiX50TpyKftH/tucuICfCQVZOEAeo5KgPiHb8WqElyO4dG1z6hMradsWI7I6NG6mS
         SqfLWqRhysHX8jwqDCH9FJa2+n9+RSSokaKkyKc/Xol0SY/JSvhZibV9VvHzr9WN6s97
         GFvCLEWeNd9E8Z8pEtIcwKWiPDQ6IRPfDm8Y7rIvXpow/LTXz6l0U43ezEIp93sG0V8U
         /BJ9ji5gskAyN4zyletK0aMgg8HsEu3O3zQiqRv5Mbaw+nHeybE0D4t4XIO1raXXA6Sl
         gcvA==
X-Forwarded-Encrypted: i=1; AJvYcCXBIsgbMWvMgm7AJbbYR/mGNZHXF/9lrMap9Cpl3IfbsMnm9eG9YW5M0gSy67LipLW2BeHIvaf4halOZTYrt65BpCZTW2SqL59T1NN/
X-Gm-Message-State: AOJu0Yzl0TjbtgC/hW0ufztmpVBLdB9R5uS7HBtoQaS/5puneiIWvHur
	RLT87ZZU5fYi1pO6fDaXzEU04b+lyJBHP+2O7IosVtdSCzjz1v1JPZ2i8DOtJiAVaqvXEyQsY1K
	AUWKeKbkqZBrs+5AwIO+Q0xeWKZzB08BlZMhI
X-Google-Smtp-Source: AGHT+IHrTNsTajLfM6vlDskL/RW7t8LKDaCP9DtOscLyK8RqjJnIqxBEqvIo/4H4Zc/+wNBbw0jAa1TTD0veOmsdSPM=
X-Received: by 2002:a05:6214:1933:b0:69b:1e64:413d with SMTP id
 es19-20020a056214193300b0069b1e64413dmr734971qvb.52.1712864242836; Thu, 11
 Apr 2024 12:37:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240408180918.2773238-1-jfraker@google.com> <20240409172602.3284f1c6@kernel.org>
 <66175758bab7c_2dcc3c294a@willemb.c.googlers.com.notmuch>
In-Reply-To: <66175758bab7c_2dcc3c294a@willemb.c.googlers.com.notmuch>
From: John Fraker <jfraker@google.com>
Date: Thu, 11 Apr 2024 12:37:11 -0700
Message-ID: <CAGH0z2Hn-D1_wEZEN-Y9+hO1c+Ddn3dsO5_XCG6qQ8KioeGeGg@mail.gmail.com>
Subject: Re: [PATCH net-next] gve: Correctly report software timestamping capabilities
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Shailend Chand <shailend@google.com>, Willem de Bruijn <willemb@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Junfeng Guo <junfeng.guo@intel.com>, 
	Ziwei Xiao <ziweixiao@google.com>, Jeroen de Borst <jeroendb@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2024 at 8:22=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Jakub Kicinski wrote:
> > On Mon,  8 Apr 2024 11:09:01 -0700 John Fraker wrote:
> > > gve has supported software timestamp generation since its inception,
> > > but has not advertised that support via ethtool. This patch correctly
> > > advertises that support.
> > >
> > > Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
> > > Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
> > > Signed-off-by: John Fraker <jfraker@google.com>
> >
> > I think it should be a single line diff:
> >
> > +     .get_ts_info =3D ethtool_op_get_ts_info,
> >
> > right?
>
> If inserted above .get_link_ksettings that works. The current
> ordering is not based on actual struct layout anyway.
>
> Probably all statements should just end in a comma, including a
> trailing comma. To avoid these two line changes on each subsequent
> change.

Thanks all!

I'll send the one-line v2.

> The rest of the discussion in this thread is actually quite
> unrelated to this patch. Didn't meant to sidetrack that.

