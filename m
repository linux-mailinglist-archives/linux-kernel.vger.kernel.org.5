Return-Path: <linux-kernel+bounces-80025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E07E88629DB
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 10:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17573281A29
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 09:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5138EEADD;
	Sun, 25 Feb 2024 09:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H2V3KPj/"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206D4EADC
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 09:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708852323; cv=none; b=DPS0kWFGQ1rBPKNALx+HLT48Yut1KiPip5sAuKUxfgmnYcUz929x1prd+aCbvowjuXxq9c7u/sJaZBaNb547/XEAbC6QBtEJDwJHrfyaq6qHr6r6+yPRoY/d223Yd43xT0D3OfkYY0XIyFJ3M9ZsqcgzbXNhCS7u+yycnaIUclo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708852323; c=relaxed/simple;
	bh=QKZiQwmh22yTKv+ll6dGV/xEVkRz1se5lZb9VRo97qc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hljbKIU/WB3AL+g2+6TgCbfPYYyhKdNn3XMbqPYcOg6hkYf2uTGtWwPHGOy8vf/8GfG/Mf1H4bU2bizr6QkxW1mF//qVo+d/khbbSOn2ou3VB+JXfUYU4h/SBeAN51hQ4+/RCwVGIpA5bfhw8ejrWWLldwgtrStNAAptqvgT5No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H2V3KPj/; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dcc86086c9fso2167898276.3
        for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 01:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708852321; x=1709457121; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QKZiQwmh22yTKv+ll6dGV/xEVkRz1se5lZb9VRo97qc=;
        b=H2V3KPj/4hGwom0v1ZEq90X7CeHhgYnAZJqCda7TyqoP5kcXVdERipNS/SygKqdROd
         E+WYhuFSq9+CayKGkAx7gDHR7hIh0oz2sGFXKQsbEWQ/r8+TAmK9S5V6sE8dzzLvYhJv
         P7P1OY4RTQexjjP7jP0GMriFbS7/HQ0NzKScQbdXuFVYPMfOn60G6ksVaXAc61qoegZO
         Ju4sxLeA7s/B7KUzgnLMhUBvUeooohtC8aFvTOtMp9JcfQZjk6olhH1GhYEN8wQNy2HZ
         a8D4FUUCPEU0c1DsLkx47wHKJxPrn+D6aWLLznbwhEW8AD6iWx+RNjntIv88qe/OSOzV
         yTGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708852321; x=1709457121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QKZiQwmh22yTKv+ll6dGV/xEVkRz1se5lZb9VRo97qc=;
        b=ouFfLcAoaUs8oYVhBoR9a/FYlsWijoA5uejflZx2VzV+eq1clLt4Nc+mEQ9vdGDtzb
         c6o0lFVRC6cQHJLNRNaOATc8AmFlPgOEJXGTzSxlOY0GgY7P90+U6F+J3q1tbDKMdyAX
         VJJ322sCHEhB6iWl0HITQW0rqUjskRWbPs8naGtxsCzuWklhwVIiFdTUO5MyGq5SSyJl
         TQUvN8OvBKWtsWyC8xFivXXmLgPjrjbV1ruQxtf8lUHchoLkJwixwPkTZlGkEUMLgytM
         gGPq2yfAYkeO7Ik7fXcoPVGBBpcmOSqhDqXyL1EIOjWc/firbQc8whoieeCH0qG4cm0O
         +aog==
X-Forwarded-Encrypted: i=1; AJvYcCWkya8TR0dc0H6ks5bCXXUzfMcwOf67tXXHvNQhMQL4LRouBo6Yx8hjKdIV73MmQm2WOLTI9eW06fosHL5LPdZTb6tm2thoVUe7S6Xy
X-Gm-Message-State: AOJu0YyGrP7cPhXiMM90ZRB9+h7pBKWfnDK0q9bNnq8Ct9GgZupINYNw
	D1SAzuQDlt3GTXV4Wyi7EtsmBfZ4UVpcRcA5LJdLt37sks+/ggDGHd90bTWY7d/U8yV1oLWVbCZ
	CxP380Z0OmgAUS12Ah/1KtCXfs2o=
X-Google-Smtp-Source: AGHT+IHXT2nRKN0Wwdr0ip21+sZF1bLC2Hvaet/VK2GJH61xMQZo7qYtjxHeLTh3NqCW/oJXC574aLFC5QQxZAkbKJI=
X-Received: by 2002:a25:7555:0:b0:dcc:eb38:199c with SMTP id
 q82-20020a257555000000b00dcceb38199cmr2234116ybc.56.1708852321036; Sun, 25
 Feb 2024 01:12:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHxc4buV_UieeVVBhua3vmT2+2e6qf2B9uoxpSPAg6faGBa=Ww@mail.gmail.com>
 <2024022427-abruptly-vastness-ed23@gregkh>
In-Reply-To: <2024022427-abruptly-vastness-ed23@gregkh>
From: Dileep Sankhla <dileepsankhla.ds@gmail.com>
Date: Sun, 25 Feb 2024 14:41:50 +0530
Message-ID: <CAHxc4bstSZ1EEUv4dFSdQ_r0SGYT_sB+eqA7aZjqFN=fZvhu_w@mail.gmail.com>
Subject: Re: tree for the greybus subsystem
To: Greg KH <gregkh@linuxfoundation.org>
Cc: greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org, pure.logic@nexus-software.ie, johan@kernel.org, 
	elder@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 24, 2024 at 10:57=E2=80=AFAM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
> Then the staging.git tree as shown in MAINTAINERS is the correct one.

Hello Greg,

Thank you for your reply.

I have submitted my patch against the staging.git tree, branch staging-next=
.

Regards,
Dileep

