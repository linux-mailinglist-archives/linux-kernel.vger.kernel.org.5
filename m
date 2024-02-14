Return-Path: <linux-kernel+bounces-65598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B1E1854F47
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C138C283EE4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A96A60887;
	Wed, 14 Feb 2024 16:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZF3d/G5z"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07FD604DC
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 16:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707929934; cv=none; b=BTXXKHCoj9T6GLcDuBJFg0a03yfBW5g57DeAp+H/YC5R8rmDACxYZmVboJiqqFf91WPXwOzpvumi2SJ6B1K5xXR3JxG8cDM2EKPi9nu0JIX6tinYu3eQBnHV+N7YfkZ1/ic3JL/QMffBxvHuLAYctkDpJj77riIYtCSsfAqbs4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707929934; c=relaxed/simple;
	bh=OSsaNG2FvzVU0LHsrYNC/eZp5qr5JVJ6bAlNSP1GGaI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=edj/MusEAzk7y2lV6rzIUvL8EHfTh5bRG5AUzOO6QxVLImD3m1jBCjYNkn/WfRX/JmdrkLh074FbX/x55iLig2eucFusK0Oxldd+eClWJ3WViBNQX0DtJhxt8bKviirpAzzyvhnVbHlGoykLECT1S5G4y9N0nF1/jpaypW+IFTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZF3d/G5z; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5639175bf70so5667a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 08:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707929931; x=1708534731; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QyOK3EJeEyKJEt81jU19f6sSTlRmH4ZoITaYsVw9nEo=;
        b=ZF3d/G5zDd+JCzwBb6Z0JSjev/gYAck3SRMrFgzDy7jip8jjj3ifVxsuS61A1IF1Ne
         KrKN6PccBPXHoOtMNHLt+UaFzqAwHmgY085ezuWAddlXL20wMu59SwCVa6zygN3eUq7c
         Su14HW9NP0bsm/CWe0hW8AM8biONOmKFOKR6Sawd+oa7CKf8oAn4gpPsWZqph7jrzZeh
         7MHnxWGJ7mogYpXA+latifu9NVqnEriZxBckvy5LPr8ec+9ncAUh7TVHoztwb1DVyfKX
         dc6mNQNge954Yl8/obotKSo4koZbU8dFmVXnp0VSbVwDOuUFmZ1PgjM6007KtVxyYh6Y
         xQUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707929931; x=1708534731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QyOK3EJeEyKJEt81jU19f6sSTlRmH4ZoITaYsVw9nEo=;
        b=RH10WA/MuAttXsOU3bSrQRnzNC6Z0nTfFft9aZfC3NCtSI0chrZz+YBJgFmv1okgdq
         mjisxkM0TBdPSFPUM2aqYwzwF5blvAHNIwBNmxcDnR6ofir6/THkQsINXz36e/y68WdD
         mvgDW8IUjX6xj/HBFU9RIIPRW2GVC6iwa3F3znroOMaYNC1l2jkcd8j8P9Tb4HAtr0NC
         ffz8pWeeyTg0ZqfOvE2UHNYbl/p/X5FCGDhXWldo7GnnqZvj44eVbRzO4AsRAOs+GX4m
         Jphe0ZOX/AsZickjf1aeeE9BgTsfLLZ1VNi6iq+GT7YOYf9ltPLDXW7bF+DpZq/4uEn/
         et2Q==
X-Forwarded-Encrypted: i=1; AJvYcCV5JLx7OZOzTo12/zm9Ib7q9J6G4TcWRSEQ8/yFK1O8eBE9VYkrOuwbr+gyNXU+L8YwYi5XlrraaDXn9IcBbyYpvh1c/dXLQaLGYBmZ
X-Gm-Message-State: AOJu0YxXu5BZrGc9oVlTli32KOm8bE7Xe85Qgz0hylQajVa7LIvnd/hn
	+UR9f1wYOgWzVHE8H5SK+s35E5s2StpLn60PJF/w2pYlmzKAi1EgUyCXU6tPaBh7EeiZlWPqcAZ
	VjldJS0GuQdS4VeJ1qCBkFv2yP0RQlkoVk+KE
X-Google-Smtp-Source: AGHT+IE4tG1X1dYxzIYp2Bzh7QoWLOwjRxwWH/t/jCIoU3Yg+wA31sQ+QEU+t1UUq0hSu9m5cPhcEd5LSb+oOd0di18=
X-Received: by 2002:a50:8d13:0:b0:560:1a1:eb8d with SMTP id
 s19-20020a508d13000000b0056001a1eb8dmr205884eds.7.1707929930734; Wed, 14 Feb
 2024 08:58:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202165315.2506384-1-leitao@debian.org> <CANn89iLWWDjp71R7zttfTcEvZEdmcA1qo47oXkAX5DuciYvOtQ@mail.gmail.com>
 <20240213100457.6648a8e0@kernel.org> <ZczSEBFtq6E6APUJ@gmail.com>
 <CANn89iJH5jpvBCw8csGux9U10HwM+ewnL1A7udBi6uwAX6VBYA@mail.gmail.com> <ZczvGJ90L7689F6J@gmail.com>
In-Reply-To: <ZczvGJ90L7689F6J@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 14 Feb 2024 17:58:37 +0100
Message-ID: <CANn89i+zF3k4OyhJsK3sg5zNsFzKAQ5G_ANYEaxOfc41B7S18w@mail.gmail.com>
Subject: Re: [PATCH net-next v3] net: dqs: add NIC stall detector based on BQL
To: Breno Leitao <leitao@debian.org>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, pabeni@redhat.com, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>, 
	weiwan@google.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	horms@kernel.org, Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Johannes Berg <johannes.berg@intel.com>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	"open list:TRACING" <linux-trace-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 5:49=E2=80=AFPM Breno Leitao <leitao@debian.org> wr=
ote:
>
> On Wed, Feb 14, 2024 at 04:41:36PM +0100, Eric Dumazet wrote:
> > On Wed, Feb 14, 2024 at 3:45=E2=80=AFPM Breno Leitao <leitao@debian.org=
> wrote:
> > >
> > > On Tue, Feb 13, 2024 at 10:04:57AM -0800, Jakub Kicinski wrote:
> > > > On Tue, 13 Feb 2024 14:57:49 +0100 Eric Dumazet wrote:
> > > > > Please note that adding other sysfs entries is expensive for work=
loads
> > > > > creating/deleting netdev and netns often.
> > > > >
> > > > > I _think_ we should find a way for not creating
> > > > > /sys/class/net/<interface>/queues/tx-{Q}/byte_queue_limits  direc=
tory
> > > > > and files
> > > > > for non BQL enabled devices (like loopback !)
> > > >
> > > > We should try, see if anyone screams. We could use IFF_NO_QUEUE, an=
d
> > > > NETIF_F_LLTX as a proxy for "device doesn't have a real queue so BQ=
L
> > > > would be pointless"? Obviously better to annotate the drivers which
> > > > do have BQL support, but there's >50 of them on a quick count..
> > >
> > > Let me make sure I understand the suggestion above. We want to disabl=
e
> > > BQL completely for devices that has dev->features & NETIF_F_LLTX or
> > > dev->priv_flags & IFF_NO_QUEUE, right?
> > >
> > > Maybe we can add a ->enabled field in struct dql, and set it accordin=
g
> > > to the features above. Then we can created the sysfs and process the =
dql
> > > operations based on that field. This should avoid some unnecessary ca=
lls
> > > also, if we are not display sysfs.
> > >
> > > Here is a very simple PoC to represent what I had in mind. Am I in th=
e
> > > right direction?
> >
> > No, this was really about sysfs entries (aka dql_group)
> >
> > Partial patch would be:
>
> That is simpler than what I imagined. Thanks!
>

>
> for netdev_uses_bql(), would it be similar to what I proposed in the
> previous message? Let me copy it here.
>
>         static bool netdev_uses_bql(struct net_device *dev)
>         {
>                if (dev->features & NETIF_F_LLTX ||
>                    dev->priv_flags & IFF_NO_QUEUE)
>                        return false;
>
>                return true;
>         }

I think this should be fine, yes.

