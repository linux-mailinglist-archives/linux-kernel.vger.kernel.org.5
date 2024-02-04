Return-Path: <linux-kernel+bounces-51363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 231EE848A2D
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 02:27:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA999B2515F
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 01:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B75B4683;
	Sun,  4 Feb 2024 01:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FWxgAFRx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C5F17CE
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 01:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707010049; cv=none; b=TwlKiIc+/IsZfC+rDbNTzXSXd6CIoupoHAHzXq3EtP+Tr5lwCvC+VW92OU9yaTTfmlW6hO7wnMRgo2+T297r02QMmspTe1k+fOt5nf9MtJcRcbD2ae0VTYdGHGff3Tm6opM+/NOGkAuLwqb/n7rDbQrcMFo4OXOyOgIrBeem7Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707010049; c=relaxed/simple;
	bh=C2iaeOFXYpDh1pgAfITwdaN8Gw9hOmWA6JpkGL/Xp4w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G5h8kNK5nv711rXT94LhzXjYBWR3hZilHiPe0xw+k8jYp3qt3EzzULyQvRTUfb7WoO2Op+iQoyPhBW7jtskNkDXotGn9MWd5eZXvEMONXBGl4q+Fm6KkP/fbnAog2O8d9GdmldQxyphHjgUkBu03jEjLW8SSN4fkM23avggid3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FWxgAFRx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707010046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hDU9do/S72QAfTFtnTp/XvI11FLMd8x1l5eXuy6iPJs=;
	b=FWxgAFRxyvYDeuRFtT6ETQgejDjaQkA3zuOC4F+BF8bYRHk8hN5cXg7rXoLiO51AHoGXQ/
	g1sPSapHiwVih/t3hXqBb57rh+stnLQ2IZEFcGVCPjGOw6HyNZzp57i+XnGoG5W+3EPkM6
	V+sB8Pw2JV5rMcrcX0Gw2buKaThk7m4=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-q1RmQqIgNZ-yf-ejxGfYbg-1; Sat, 03 Feb 2024 20:27:24 -0500
X-MC-Unique: q1RmQqIgNZ-yf-ejxGfYbg-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-5d1bffa322eso4134453a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 03 Feb 2024 17:27:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707010043; x=1707614843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hDU9do/S72QAfTFtnTp/XvI11FLMd8x1l5eXuy6iPJs=;
        b=OF91GjjWRS446YvX2VzrYBYcRDGwP/WaDxDJ2NvLC22eryUGpfoZoGJ2OggyNpxF5B
         77ptS8HIKpZwg0qSKTgTj2m07j9g6zer95UE6YZBVJIKzN2QjZ7rFVnYPLw8AVL+2AnW
         XltQiMANixKdsLxJAsBjU3+o0uG0LTXWPBRq/lD9rhtlL9Rr1f1U+Y8K+/2D7FT1Bvi0
         4Vqpp+298qkke+vLR7ddX5iq0OZ9hDCxznQrGsESkpKUEWaOIYkOmzdTXVX10X2NAYPr
         gBxw/z0C1yMgmTAx3gDkEG3AulKsXCSQVIveexSuaWB87iBD5hZHtU+V4iGiEvRNBaIm
         6aAA==
X-Gm-Message-State: AOJu0YzsOhUBcuhLKkn0NzNKYBNZ03U2Jq771rqc359ZSTTxl/muJM3j
	2hwESwxQoBe6IOBarZmQte1i7nUVKI3Kg1tBiH3LTVQxn4X1dXsMHeAWPSVQ0bquBKqA369OwXK
	XTON88pf718ekepA38NVP5E8SmmCM/Cuy8Yo3rr+o9YhvLGLnl6IarUW1p4FFcX79MjMiADGlI0
	JnqPLVNLnMEwK1PjrpxOGBo/QUwWTp0LGe0KPz
X-Received: by 2002:a05:6a21:998c:b0:19c:6cee:fc33 with SMTP id ve12-20020a056a21998c00b0019c6ceefc33mr15448586pzb.18.1707010043589;
        Sat, 03 Feb 2024 17:27:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IED1R1TM8U8UO1Bj+V5vOzhoMT/QrJZl7RDJ7RsXlT4MddjbAwHHI7yztzKREXPa3j7e1zslg9CjnswRjioqKY=
X-Received: by 2002:a05:6a21:998c:b0:19c:6cee:fc33 with SMTP id
 ve12-20020a056a21998c00b0019c6ceefc33mr15448581pzb.18.1707010043349; Sat, 03
 Feb 2024 17:27:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1706860400-61484-1-git-send-email-wangyunjian@huawei.com>
In-Reply-To: <1706860400-61484-1-git-send-email-wangyunjian@huawei.com>
From: Jason Wang <jasowang@redhat.com>
Date: Sun, 4 Feb 2024 09:27:12 +0800
Message-ID: <CACGkMEseJJE7=yhMi_7xTeR4jrNiZwDoJte7zPv1smyAY-KH4A@mail.gmail.com>
Subject: Re: [PATCH net-next v2] tun: Implement ethtool's get_channels() callback
To: Yunjian Wang <wangyunjian@huawei.com>
Cc: willemdebruijn.kernel@gmail.com, kuba@kernel.org, davem@davemloft.net, 
	jiri@resnulli.us, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	xudingke@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 3:53=E2=80=AFPM Yunjian Wang <wangyunjian@huawei.com=
> wrote:
>
> Implement the tun .get_channels functionality. This feature is necessary
> for some tools, such as libxdp, which need to retrieve the queue count.
>
> Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>
> ---
>   v2: add conditional on IFF_MULTI_QUEUE
> ---
>  drivers/net/tun.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


