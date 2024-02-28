Return-Path: <linux-kernel+bounces-85200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EDC586B224
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 15:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1161B24E86
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA21715958A;
	Wed, 28 Feb 2024 14:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mE9pnVbg"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C435214D452
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 14:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709131435; cv=none; b=LKMg/4VOvKqrAjAhX0A+ACS818yOek4mbI3BPkP6HwF5TMrdpNsJQGRecyBAaWXGzuOotVnHGjjgKf7VRragV6SbmK32rSHMgpyiMd9a2PT/2tiPQMTbVMWLwTGawUUg1p4YM33NCA7q09qKPC6j4k1I5SSXNJpHCSnKpFepHV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709131435; c=relaxed/simple;
	bh=6ZfzkhM/k20UiOkUU26Z5RmTZJunBzLMuNptH38mTPA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JOs85rjIyFTLDMHcW8BPBkyuuKhl3Wy1PSZdzmCgnVUBpd8ow7BIrN6eXwvEQQZomaSrjqiBgdYvKPFX00jGVeMctPcXrWPYjnkEFAdZQ+4lpUaGAbeZU0qjQWjm+D6loUU85J1yuRi2cXtELcAhpBYRC421JikkLENmknWgitA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mE9pnVbg; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5654ef0c61fso14161a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 06:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709131432; x=1709736232; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lnoSRTW8AtUZs4ugNgPMn80qRikhZMN33csdiHtI1dI=;
        b=mE9pnVbgX6/PnAYjA6FUZZH1xSimWSBOmttIBNuCdu+XJ4SdkRKdcUhtzsEjpW4ecT
         yrRmztSN8MQ9VPc76dd2uYRIJ/OmOAMpBCfflWLzNEYYRNo0mN5L1huzzB+dHUlPIxYc
         yZ7COWcTrxRn4VQKZxQOQB6GGbwcP9ASC8AG+nbQWsz23gnDQTOZHhqzIZOyvhuwaNc9
         rIUa52bJX216tj4BoOtsuDFofHiCr9RTDHgN8IFQ2bsl7HN+9xZ+tLV6pNWnB86gzF9D
         OAbjLvtPeBpYzJTr4eI+ASrQMJ6lW4uPunVTp0Ee4qmy8cJTFdU7Bhm6wSoBW0o/a7cM
         Xu8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709131432; x=1709736232;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lnoSRTW8AtUZs4ugNgPMn80qRikhZMN33csdiHtI1dI=;
        b=AVs7L4NM5zC23FQbnNLNLZWGnGIUQYUUU7aXeP8fbmVNg21E82cAfawTqq5YDyn2KD
         qGjzisyxQNvQsABpXKKlyGVnTnSRAP0ojjb6WZ+I8Kvw/DARJ0YZ5t3GTU4c2SJ9dEiv
         ev5mBdwnmIpVRghMp4WrBkVX3OzDb80061H7K7pNOVL5giEC4rj7ZEXRK4u8WWs+0uvU
         1f3QOpFbslpdA9jVJW7dAaH/h0aJWJEcHIQfSq1azWK16WGFzjxlu0P78KNH959JrvNT
         2MoAc1xtkdjb1p5j3nK/EGQqS38mEbR++Z6ETTnDeXFga4MlysGtiKgnLyadm2PH0OWc
         9xEg==
X-Gm-Message-State: AOJu0YwP51uc7kkHWZvGYcORQDOyN7gkXW/IN11Y8QpqhAPAdh0R8Ta6
	jbqGoOM37yGyM+/kTW2fSwpK7yGBPqbtHHDf5xXSL8JgjGTalYRJXwiS/xDwxYrGxRvqvrG1tIJ
	nq7bd9El7pZ8sCMV/wiIgmsPsIsbXDLHQBydY3fJ2NQrIpzAUaRIQ
X-Google-Smtp-Source: AGHT+IEES/VV7npD6iBN4dtbgkaBntnQ1IsMemUX1X8dIdkUpTDG9nT+8rgEDFrJe+qGv5AL0cBHzUd6KSTdSg2+5/0=
X-Received: by 2002:a50:9349:0:b0:565:4f70:6ed with SMTP id
 n9-20020a509349000000b005654f7006edmr42234eda.6.1709131431840; Wed, 28 Feb
 2024 06:43:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3fcf3a2c-1c1b-42c1-bacb-78fdcd700389@linux.vnet.ibm.com> <85b78dad-affa-47c3-9cd0-79a4321460b8@linux.dev>
In-Reply-To: <85b78dad-affa-47c3-9cd0-79a4321460b8@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 28 Feb 2024 15:43:36 +0100
Message-ID: <CANn89iJEzTjwxF7wXSnUR+NyDu-S-zEOYVXA+fEaYs_1o1g5HQ@mail.gmail.com>
Subject: Re: [revert 0d60d8df6f49] [net/net-next] [6.8-rc5] Build Failure
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, arkadiusz.kubalewski@intel.com, 
	jiri@nvidia.com, kuba@kernel.org, 
	"abdhalee@linux.vnet.ibm.com" <abdhalee@linux.vnet.ibm.com>, 
	"mputtash@linux.vnet.com" <mputtash@linux.vnet.com>, "sachinp@linux.vnet.com" <sachinp@linux.vnet.com>, 
	venkat88@linux.vnet.ibm.com, Tasmiya Nalatwad <tasmiya@linux.vnet.ibm.com>, 
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 3:07=E2=80=AFPM Vadim Fedorenko
<vadim.fedorenko@linux.dev> wrote:
>
> On 28/02/2024 11:09, Tasmiya Nalatwad wrote:
> > Greetings,
> >
> > [revert 0d60d8df6f49] [net/net-next] [6.8-rc5] Build Failure
> >
> > Reverting below commit fixes the issue
> >
> > commit 0d60d8df6f493bb46bf5db40d39dd60a1bafdd4e
> >      dpll: rely on rcu for netdev_dpll_pin()
> >
> > --- Traces ---
> >
> > ./include/linux/dpll.h: In function =E2=80=98netdev_dpll_pin=E2=80=99:
> > ./include/linux/rcupdate.h:439:9: error: dereferencing pointer to
> > incomplete type =E2=80=98struct dpll_pin=E2=80=99
> >    typeof(*p) *local =3D (typeof(*p) *__force)READ_ONCE(p); \
> >           ^
> > ./include/linux/rcupdate.h:587:2: note: in expansion of macro
> > =E2=80=98__rcu_dereference_check=E2=80=99
> >    __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
> >    ^~~~~~~~~~~~~~~~~~~~~~~
> > ./include/linux/rtnetlink.h:70:2: note: in expansion of macro
> > =E2=80=98rcu_dereference_check=E2=80=99
> >    rcu_dereference_check(p, lockdep_rtnl_is_held())
> >    ^~~~~~~~~~~~~~~~~~~~~
> > ./include/linux/dpll.h:175:9: note: in expansion of macro
> > =E2=80=98rcu_dereference_rtnl=E2=80=99
> >    return rcu_dereference_rtnl(dev->dpll_pin);
> >           ^~~~~~~~~~~~~~~~~~~~
> > make[4]: *** [scripts/Makefile.build:243: drivers/dpll/dpll_core.o] Err=
or 1
> > make[4]: *** Waiting for unfinished jobs....
> >    AR      net/mpls/built-in.a
> >    AR      net/l3mdev/built-in.a
> > In file included from ./include/linux/rbtree.h:24,
> >                   from ./include/linux/mm_types.h:11,
> >                   from ./include/linux/mmzone.h:22,
> >                   from ./include/linux/gfp.h:7,
> >                   from ./include/linux/umh.h:4,
> >                   from ./include/linux/kmod.h:9,
> >                   from ./include/linux/module.h:17,
> >                   from drivers/dpll/dpll_netlink.c:9:
> > ./include/linux/dpll.h: In function =E2=80=98netdev_dpll_pin=E2=80=99:
> > ./include/linux/rcupdate.h:439:9: error: dereferencing pointer to
> > incomplete type =E2=80=98struct dpll_pin=E2=80=99
> >    typeof(*p) *local =3D (typeof(*p) *__force)READ_ONCE(p); \
> >           ^
> > ./include/linux/rcupdate.h:587:2: note: in expansion of macro
> > =E2=80=98__rcu_dereference_check=E2=80=99
> >    __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
> >    ^~~~~~~~~~~~~~~~~~~~~~~
> > ./include/linux/rtnetlink.h:70:2: note: in expansion of macro
> > =E2=80=98rcu_dereference_check=E2=80=99
> >    rcu_dereference_check(p, lockdep_rtnl_is_held())
> >    ^~~~~~~~~~~~~~~~~~~~~
> > ./include/linux/dpll.h:175:9: note: in expansion of macro
> > =E2=80=98rcu_dereference_rtnl=E2=80=99
> >    return rcu_dereference_rtnl(dev->dpll_pin);
> >           ^~~~~~~~~~~~~~~~~~~~
> > make[4]: *** [scripts/Makefile.build:243: drivers/dpll/dpll_netlink.o]
> > Error 1
> > make[3]: *** [scripts/Makefile.build:481: drivers/dpll] Error 2
> > make[3]: *** Waiting for unfinished jobs....
> > In file included from ./arch/powerpc/include/generated/asm/rwonce.h:1,
> >                   from ./include/linux/compiler.h:251,
> >                   from ./include/linux/instrumented.h:10,
> >                   from ./include/linux/uaccess.h:6,
> >                   from net/core/dev.c:71:
> > net/core/dev.c: In function =E2=80=98netdev_dpll_pin_assign=E2=80=99:
> > ./include/linux/rcupdate.h:462:36: error: dereferencing pointer to
> > incomplete type =E2=80=98struct dpll_pin=E2=80=99
> >   #define RCU_INITIALIZER(v) (typeof(*(v)) __force __rcu *)(v)
> >                                      ^~~~
> > ./include/asm-generic/rwonce.h:55:33: note: in definition of macro
> > =E2=80=98__WRITE_ONCE=E2=80=99
> >    *(volatile typeof(x) *)&(x) =3D (val);    \
> >                                   ^~~
> > ./arch/powerpc/include/asm/barrier.h:76:2: note: in expansion of macro
> > =E2=80=98WRITE_ONCE=E2=80=99
> >    WRITE_ONCE(*p, v);      \
> >    ^~~~~~~~~~
> > ./include/asm-generic/barrier.h:172:55: note: in expansion of macro
> > =E2=80=98__smp_store_release=E2=80=99
> >   #define smp_store_release(p, v) do { kcsan_release();
> > __smp_store_release(p, v); } while (0)
> > ^~~~~~~~~~~~~~~~~~~
> > ./include/linux/rcupdate.h:503:3: note: in expansion of macro
> > =E2=80=98smp_store_release=E2=80=99
> >     smp_store_release(&p, RCU_INITIALIZER((typeof(p))_r_a_p__v)); \
> >     ^~~~~~~~~~~~~~~~~
> > ./include/linux/rcupdate.h:503:25: note: in expansion of macro
> > =E2=80=98RCU_INITIALIZER=E2=80=99
> >     smp_store_release(&p, RCU_INITIALIZER((typeof(p))_r_a_p__v)); \
> >                           ^~~~~~~~~~~~~~~
> > net/core/dev.c:9081:2: note: in expansion of macro =E2=80=98rcu_assign_=
pointer=E2=80=99
> >    rcu_assign_pointer(dev->dpll_pin, dpll_pin);
> >    ^~~~~~~~~~~~~~~~~~
> > make[4]: *** [scripts/Makefile.build:243: net/core/dev.o] Error 1
> > make[4]: *** Waiting for unfinished jobs....
> >    AR      drivers/net/ethernet/built-in.a
> >    AR      drivers/net/built-in.a
> >    AR      net/dcb/built-in.a
> >    AR      net/netlabel/built-in.a
> >    AR      net/strparser/built-in.a
> >    AR      net/handshake/built-in.a
> >    GEN     lib/test_fortify.log
> >    AR      net/8021q/built-in.a
> >    AR      net/nsh/built-in.a
> >    AR      net/unix/built-in.a
> >    CC      lib/string.o
> >    AR      net/packet/built-in.a
> >    AR      net/switchdev/built-in.a
> >    AR      lib/lib.a
> >    AR      net/mptcp/built-in.a
> >    AR      net/devlink/built-in.a
> > In file included from ./include/linux/rbtree.h:24,
> >                   from ./include/linux/mm_types.h:11,
> >                   from ./include/linux/mmzone.h:22,
> >                   from ./include/linux/gfp.h:7,
> >                   from ./include/linux/umh.h:4,
> >                   from ./include/linux/kmod.h:9,
> >                   from ./include/linux/module.h:17,
> >                   from net/core/rtnetlink.c:17:
> > ./include/linux/dpll.h: In function =E2=80=98netdev_dpll_pin=E2=80=99:
> > ./include/linux/rcupdate.h:439:9: error: dereferencing pointer to
> > incomplete type =E2=80=98struct dpll_pin=E2=80=99
> >    typeof(*p) *local =3D (typeof(*p) *__force)READ_ONCE(p); \
> >           ^
> > ./include/linux/rcupdate.h:587:2: note: in expansion of macro
> > =E2=80=98__rcu_dereference_check=E2=80=99
> >    __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
> >    ^~~~~~~~~~~~~~~~~~~~~~~
> > ./include/linux/rtnetlink.h:70:2: note: in expansion of macro
> > =E2=80=98rcu_dereference_check=E2=80=99
> >    rcu_dereference_check(p, lockdep_rtnl_is_held())
> >    ^~~~~~~~~~~~~~~~~~~~~
> > ./include/linux/dpll.h:175:9: note: in expansion of macro
> > =E2=80=98rcu_dereference_rtnl=E2=80=99
> >    return rcu_dereference_rtnl(dev->dpll_pin);
> >           ^~~~~~~~~~~~~~~~~~~~
> > In file included from net/core/rtnetlink.c:60:
> > ./include/linux/dpll.h:179:1: error: control reaches end of non-void
> > function [-Werror=3Dreturn-type]
> >   }
> >
>
> Hi, Eric!
>
> Looks like we have to move struct dpll_pin definition to
> include/linux/dpll.h to have this fixed, right?
>

No idea what is wrong. Is it powerpc specific ? Some compiler version ?

netdev_dpll_pin() could be moved to net/core/rtnetlink.c, this is the only =
user.

diff --git a/include/linux/dpll.h b/include/linux/dpll.h
index 4ec2fe9caf5a3f284afd0cfe4fc7c2bf42cbbc60..72d21e710d7f201d2fc57bb3a32=
b4bc0ff2b1749
100644
--- a/include/linux/dpll.h
+++ b/include/linux/dpll.h
@@ -169,13 +169,4 @@ int dpll_device_change_ntf(struct dpll_device *dpll);

 int dpll_pin_change_ntf(struct dpll_pin *pin);

-static inline struct dpll_pin *netdev_dpll_pin(const struct net_device *de=
v)
-{
-#if IS_ENABLED(CONFIG_DPLL)
-       return rcu_dereference_rtnl(dev->dpll_pin);
-#else
-       return NULL;
-#endif
-}
-
 #endif
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 9c4f427f3a5057b52ec05405e8b15b8ca2246b4b..32dc601fd8ca66dfcd3cb8f38b5=
33314de02d1d2
100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -1053,6 +1053,15 @@ static size_t rtnl_devlink_port_size(const
struct net_device *dev)
        return size;
 }

+static struct dpll_pin *netdev_dpll_pin(const struct net_device *dev)
+{
+#if IS_ENABLED(CONFIG_DPLL)
+       return rcu_dereference_rtnl(dev->dpll_pin);
+#else
+       return NULL;
+#endif
+}
+
 static size_t rtnl_dpll_pin_size(const struct net_device *dev)
 {
        size_t size =3D nla_total_size(0); /* nest IFLA_DPLL_PIN */

