Return-Path: <linux-kernel+bounces-65441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2146F854D20
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:42:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD08F281AAB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D005D75E;
	Wed, 14 Feb 2024 15:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dCRZfiQy"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66D05D49E
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 15:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707925314; cv=none; b=eLAnhuL1KhYiKxKMoM38iqA2CInG38eka35SvKY68U+YCaEzdnYgOyLKVAulBYuSU4sWwylMGPZrTVvzaLXiDRUE6occRIqz606DI90lcCNfNSMsdNk7Resjw7Qifx5VVAFK0s7b8olfcyh5HHBQBWJjqu96wGAMvyFPWM4MUNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707925314; c=relaxed/simple;
	bh=EIEkv/XLD+cnUEMJDO7B1AIZaiYtCJIbv4xIqENV9i4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M8/z9hyAk6CRy5yHwkSH8Lh1jeSZCB1bGcbQHs50VTQkGVcQBnMz6vHVPKk9/MxC0WO4l2qf79025N6HRDkinft/QxpCo4lR4mv7rXBdH39CuW0Cp97wb3MjRsb7cOURfCpUtO/fg6XyyjPUI3fjOzkN+EUtBs0kzfPq78BL91o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dCRZfiQy; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-56101dee221so24704a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 07:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707925311; x=1708530111; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lO0kPo0wQG6yAYplBE7Kc5TleYz6hCDgP3CJnwE4tbo=;
        b=dCRZfiQyLanCe1ui5uNglIotP3qd0Ux9/M985+bZHcx00GD2dqjIWxQf9l9NKFndit
         RKogoqUmSQEB2s55ko3LPuQUVX0nXowma194yK4ZnciuNi0QOIOGM52ysX0PzyMmuFoO
         uN0ywAcuIgW1t3IL4W6tH15gQc2rMSkqnpnyGPQ14ICcZRtK2idQafa3toivZX4ca64s
         nI4/2Mx9KBBGo0LpZNMbw6HiSWp6d+GoKRVyFETBmpD+N17Zp/W3Ddytabb26VQdmoa3
         BPw8rbWzcS0GmsEgWMTogxE+k43i3Z7ccgRNXPr+91P0H99B37paFQx2t6TTElioaseY
         5Chg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707925311; x=1708530111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lO0kPo0wQG6yAYplBE7Kc5TleYz6hCDgP3CJnwE4tbo=;
        b=wr8YlVl5Gq14dSnaywcxPdWct6tOU4zq4u2KY7mDBUu9XIvUqeegP16v+0My6utNfl
         jElcEB/T6HkoSKdsogAONbIXs3F080rXtu1TwkxVMnvL5e8hoJ9nxSb107vDofQgeoXW
         DTTNKy+o9ew71o5sSWJo7LmUq9PIzryS2Cjudk7B6tXp8vBmCq/rd8EEqi9ZpKKMVEyG
         r+ZmYNTYYpLi+gf+D9j2jT4q9Zp1aMNtt+EpJUokDQqhFLHnYNq1c0mulL24Ulq4gw7/
         trakwAJgK95fkdYHoDvUXC8CFBrBlFDxk3WVOAkiWTZ5gMYDc0eG8dYe4cjXXEZxcF1O
         BAOg==
X-Forwarded-Encrypted: i=1; AJvYcCXmHsH9VZ5LI5QkoIx2mYRSrP5fQZSYlaO+o9DPZzA0yc0N2D3OkBfzbG7i+MtsGwvCnxHZx59RBus6d3/Ui4U8zvhuy2wLlSipfjyw
X-Gm-Message-State: AOJu0Yw+GOP/q/uhVt+sJCMkVp/NhCsElIx/3UoXjcq7d8mNAMig0pZ3
	1LC8yYDFztVUcOwRdp7gbyqdlPMgoRLoSDecQawuQuaM7IPUe09OntWspv/T+0XvxgwDu0w5opS
	VzSxYVebDB0YOXAlTnUo77m5QiFkErsu9uuz8
X-Google-Smtp-Source: AGHT+IGZrs4RnYp9/24pN5bbUPApqhRCBE7WKazJ5JEnTm3wEg//WCOkvJ+VnTPX1QbkYdaYOVepveYAIBvz8vlJsMo=
X-Received: by 2002:a50:99d2:0:b0:563:847d:2e02 with SMTP id
 n18-20020a5099d2000000b00563847d2e02mr111874edb.2.1707925310648; Wed, 14 Feb
 2024 07:41:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202165315.2506384-1-leitao@debian.org> <CANn89iLWWDjp71R7zttfTcEvZEdmcA1qo47oXkAX5DuciYvOtQ@mail.gmail.com>
 <20240213100457.6648a8e0@kernel.org> <ZczSEBFtq6E6APUJ@gmail.com>
In-Reply-To: <ZczSEBFtq6E6APUJ@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 14 Feb 2024 16:41:36 +0100
Message-ID: <CANn89iJH5jpvBCw8csGux9U10HwM+ewnL1A7udBi6uwAX6VBYA@mail.gmail.com>
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

On Wed, Feb 14, 2024 at 3:45=E2=80=AFPM Breno Leitao <leitao@debian.org> wr=
ote:
>
> On Tue, Feb 13, 2024 at 10:04:57AM -0800, Jakub Kicinski wrote:
> > On Tue, 13 Feb 2024 14:57:49 +0100 Eric Dumazet wrote:
> > > Please note that adding other sysfs entries is expensive for workload=
s
> > > creating/deleting netdev and netns often.
> > >
> > > I _think_ we should find a way for not creating
> > > /sys/class/net/<interface>/queues/tx-{Q}/byte_queue_limits  directory
> > > and files
> > > for non BQL enabled devices (like loopback !)
> >
> > We should try, see if anyone screams. We could use IFF_NO_QUEUE, and
> > NETIF_F_LLTX as a proxy for "device doesn't have a real queue so BQL
> > would be pointless"? Obviously better to annotate the drivers which
> > do have BQL support, but there's >50 of them on a quick count..
>
> Let me make sure I understand the suggestion above. We want to disable
> BQL completely for devices that has dev->features & NETIF_F_LLTX or
> dev->priv_flags & IFF_NO_QUEUE, right?
>
> Maybe we can add a ->enabled field in struct dql, and set it according
> to the features above. Then we can created the sysfs and process the dql
> operations based on that field. This should avoid some unnecessary calls
> also, if we are not display sysfs.
>
> Here is a very simple PoC to represent what I had in mind. Am I in the
> right direction?

No, this was really about sysfs entries (aka dql_group)

Partial patch would be:

diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index a09d507c5b03d24a829bf7af0b7cf1e6a0bdb65a..094e3b2d78cca40d810b2fa3bd4=
393d22b30e6ad
100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -1709,9 +1709,11 @@ static int netdev_queue_add_kobject(struct
net_device *dev, int index)
                goto err;

 #ifdef CONFIG_BQL
-       error =3D sysfs_create_group(kobj, &dql_group);
-       if (error)
-               goto err;
+       if (netdev_uses_bql(dev)) {
+               error =3D sysfs_create_group(kobj, &dql_group);
+               if (error)
+                       goto err;
+       }
 #endif

        kobject_uevent(kobj, KOBJ_ADD);
@@ -1734,7 +1736,8 @@ static int tx_queue_change_owner(struct
net_device *ndev, int index,
                return error;

 #ifdef CONFIG_BQL
-       error =3D sysfs_group_change_owner(kobj, &dql_group, kuid, kgid);
+       if (netdev_uses_bql(ndev))
+               error =3D sysfs_group_change_owner(kobj, &dql_group, kuid, =
kgid);
 #endif
        return error;
 }
@@ -1768,7 +1771,8 @@ netdev_queue_update_kobjects(struct net_device
*dev, int old_num, int new_num)
                if (!refcount_read(&dev_net(dev)->ns.count))
                        queue->kobj.uevent_suppress =3D 1;
 #ifdef CONFIG_BQL
-               sysfs_remove_group(&queue->kobj, &dql_group);
+               if (netdev_uses_bql(dev))
+                       sysfs_remove_group(&queue->kobj, &dql_group);
 #endif
                kobject_put(&queue->kobj);
        }

