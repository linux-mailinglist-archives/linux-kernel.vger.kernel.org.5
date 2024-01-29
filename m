Return-Path: <linux-kernel+bounces-42113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F3D83FC71
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 04:01:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 475661C2203E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 03:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17F510A0C;
	Mon, 29 Jan 2024 03:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S6zWdLaB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8551078D
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 03:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706497299; cv=none; b=JSMB66fo5kyrwaTCAbZV5115RIh3Rb/zldl/r721vuqNGYsVOVbAm83X77f0etVnHwTSy77EpRswrpipH2DbbzOaNurbkAMZ0oM1IKMxPpI6ToD+kRRqpX0mLHhsnZ0wJqH8jvRMzdjn+q1GQH2Tl/cy3CGDJPEPibT0DiwywKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706497299; c=relaxed/simple;
	bh=Q1j+KR/FHxsj92SR8cJe4NVvdgceho6xI2qepjHH75w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G/TQhWYggpQy1KvTpr3tuSQIM2sQh1qR09roJeWXInJWlzZtx3b5GsYNOpY+MrhvW5lzmQBZV5SK5R7fpq9evPBeqJ9AP8Xg60aAnqTFj5UCEsKmK4zwujxwBO01nTqfoFbWcfauf1ANSZ/VvsieOsoDzy63c5SYKmrSyZ+jD6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S6zWdLaB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706497296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uZgzfc4q8wyPtVrbuYJMWOoz4ZtMUHFMRKeo6UesNQA=;
	b=S6zWdLaBwGTNfptAzO+HzaPX6XJlvW+g3MqXn0naqYDUMFpHPzJoKkbBx3X2M58wi+bZkC
	n9UXHYYOJXllywZnqa51u5uCta2F6Y4HunrraW5hi487Tu7gT58Dq98KPI4Kzlrlhjsyr1
	NSJevGxfC+QS8zcFWe3Ta+CiRy1XRLU=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-30-VQoPQ3B4NfGhgCr6SrlVGg-1; Sun, 28 Jan 2024 22:01:35 -0500
X-MC-Unique: VQoPQ3B4NfGhgCr6SrlVGg-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5ce53c43ea1so1606765a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 19:01:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706497294; x=1707102094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uZgzfc4q8wyPtVrbuYJMWOoz4ZtMUHFMRKeo6UesNQA=;
        b=omFdE3DlfJibTAX6k5OsMHHSxfMSLCr4+uKEgO8CTw2V5/Ucn+4TyMzScFQJ0A13KP
         UVCGfgCKe5+/kw8w/6rjBckAj4PYIU1VV4MIOagwIlsS/uTgKK01AZjj4QNBvNqE/zgs
         3V4Xafy/zOgRa7UMj/jg6MjldGg/lD3iHaezDkc9rLHrtngf5TbUil7g4RwMZkV0jJUc
         ehjoof+22988fQ+0B1pVsHdDs7F1zQy6dicP5zSM5bNpdzomYfLYJkjY14IxDlwHEBRy
         makr59CoGbx3Z+IiTUC4DO8gQhNSeL+oKG2cIYcqwD3hUocgQIxmhmSYT/kxsNIGDmlQ
         TwEA==
X-Gm-Message-State: AOJu0YwFENDp50FYK/t31YEIy/Ryk51eG0A8XVMrvmF+XWIfo6BY6XTE
	/g2V3X1ZMnxFvepHuxlMlr1xtlidBXAQupcPVnpXrLAmWPQYQkeiaUBblc73Oc8b1d2qP61c6q9
	f3ohJMDlaDRy+4rwl1mSHYV+L+ucafPsdBmDHCkBSXHdWfnaV/lhqQKcICo7TIdoIeDf/c7WXEY
	a76++Y3+WiL9AwoUFSU9i6FJKt5E7mec1WjcPY
X-Received: by 2002:a05:6a20:94c5:b0:19c:ae3f:7d66 with SMTP id ht5-20020a056a2094c500b0019cae3f7d66mr336817pzb.22.1706497294004;
        Sun, 28 Jan 2024 19:01:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFoxEHMOKR/5pPlKSrxDnjA4Jbr438TXbeFSA5fz8V8JIMvQlrEC41/kgPZWiUu4rkmzPD7EI6y0pVnptQ/S40=
X-Received: by 2002:a05:6a20:94c5:b0:19c:ae3f:7d66 with SMTP id
 ht5-20020a056a2094c500b0019cae3f7d66mr336803pzb.22.1706497293738; Sun, 28 Jan
 2024 19:01:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126002550.169608-1-stephen@networkplumber.org>
In-Reply-To: <20240126002550.169608-1-stephen@networkplumber.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 29 Jan 2024 11:01:22 +0800
Message-ID: <CACGkMEvtuiYCQ+_SnjZGFrnSa6DzcZQr=CkKYx9eoQB-uaOV_g@mail.gmail.com>
Subject: Re: [PATCH] net/tun: use reciprocal_scale
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 8:26=E2=80=AFAM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> Use the inline function reciprocal_scale rather than open coding
> the scale optimization.  Also, remove unnecessary initializations.
> Resulting compiled code is unchanged (according to godbolt).
>
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


