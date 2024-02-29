Return-Path: <linux-kernel+bounces-86353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0341C86C44F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26AB01C20A88
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 08:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588D855E6E;
	Thu, 29 Feb 2024 08:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ceKTU5oi"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DF755C13
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 08:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709196941; cv=none; b=riF7fDvhTJdaWgs5MOP92arQwBviQZzUd/8AhsW1DBcoghys9DEVFgPXu4S5bBuYn85HndZobXJip2+PGkCAk0uMCMbW9MaF3wDBT/0qCGQAIv9sQYcXcoVCfmPiN1BARtPGc9uGoTOaWDa4lCAQY0enb5R0X5ndvqG0dD6uhTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709196941; c=relaxed/simple;
	bh=3eiVAnXutPSgjA/7X0nO+xyLGj0ZVBBzJ4J9ik27/ng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A6bWvdXO9s9K74U1RU7yCKwm3xW1xF2TKDx7iGCBSXHbkWIjLX1UxnvyqFZVkvRN8Y0fZzRks8Tn4mhm9Sfm1hycPJMMqeBRM6AtNcxKU4H5OCl4V2L2YDla67zPxTQ80dYSiZm67xzIi4G1gB4S6+kgsm6G7k2YSoq/0qPIJYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ceKTU5oi; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-565223fd7d9so6472a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 00:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709196937; x=1709801737; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iBB3ZRtHtlRaOVjaKAvj1TeBqt93SACeJpqho7/F2vs=;
        b=ceKTU5oiHQiqU2r6afNb9vvIZHA/I73wzBqy+qRmLCEc/AM/ez9zqZwb+e8+r68Yi9
         nI9nBJnsmRCIW8/+731B4ucxvt9WaqXCIOf+O3OcMw2yIQNUK+ZduuMuYWosFy37XJrB
         qYMH7zf2zBl144CKOhi4ik5Mr5cvZOUwawg5HfTmsfPXSgLU5ZY151HLpPn7/ecfwEAs
         4sPXwAp1H8xkHcWILNIWIjipXN5kNUXTSUWyWffZ8KORQDXiddl6ekC5ih1UwcqXOg+U
         nkukfeJFbtlcEhAZHd6HNsiO7mBDDO+DKMqc4ytHEZ0TMeq1Omp8OTfXnM1p1Us1KHXP
         5W+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709196937; x=1709801737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iBB3ZRtHtlRaOVjaKAvj1TeBqt93SACeJpqho7/F2vs=;
        b=sikKehA7apjPgQUWVitur+wMtCZHPSh7zFW6aTYHC4gdkI19GabNnkUk/aKVoIK8KY
         AHPFiu8whPW/4yGoulDa3CkUFSku9KonZU6Kawye4EpxQJYv3QN2PMm8T//gSauBlt3e
         GOKX75+b9zyu482jP4oepkk3RScFPJyeTtpQBjuViSTOTCfffIZQqADLwN4eqI45vI1p
         S5MCcC3SGfHMA9ZFfP/yNWlmrw3PSFMxk9QXTYbiGCptXRthiaewKoiNHlOTd5wYG7S1
         rbY9JRK8v7vYOUKiarXixT17yATYvR1w+lQzv/aJlU3fYdLDg8yaxejP/GCAwAFMbwh2
         tnTw==
X-Forwarded-Encrypted: i=1; AJvYcCWGgoU0L6hifaQVpo7mib8g/AjdDAw5n3QjfmDfmiq6ujgL+hiMI2yL5f4KvMsN48jaob94aWMd+qTDHf5JXR9ut7wMAI33AkSZ3zG7
X-Gm-Message-State: AOJu0YzEftkjyGOEGFPfJ0jAuQ6ByFa38nPjUDYiXMrzknCgVHlNMCWO
	+hO2l2n7CaxS0QgPn2ZyP0RWlUVZHw0H9cOwlBxanDXzc5BJthYatuRruXbup7h6hOC77ooPZDw
	MCpmYMXyWUJhSRjRriZp2cFbJXCDhO6h71J1Z
X-Google-Smtp-Source: AGHT+IGynF+a6/344UeE1w8xJSD5fMiW6denW7bKWrVT2N4O3XLJEnj8jcArzi200u9QX3eURd05eVbMTlwTlbDE+8c=
X-Received: by 2002:a05:6402:2227:b0:561:a93:49af with SMTP id
 cr7-20020a056402222700b005610a9349afmr51902edb.7.1709196937172; Thu, 29 Feb
 2024 00:55:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3fcf3a2c-1c1b-42c1-bacb-78fdcd700389@linux.vnet.ibm.com>
 <85b78dad-affa-47c3-9cd0-79a4321460b8@linux.dev> <CANn89iJEzTjwxF7wXSnUR+NyDu-S-zEOYVXA+fEaYs_1o1g5HQ@mail.gmail.com>
 <a1fdd2c2-4443-458e-86db-280e7cbd4a36@linux.vnet.ibm.com>
In-Reply-To: <a1fdd2c2-4443-458e-86db-280e7cbd4a36@linux.vnet.ibm.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 29 Feb 2024 09:55:22 +0100
Message-ID: <CANn89iKdaMFCKnGRL4ffnbyrr2PUaKn1hoiu4VZ=sRyX=Vy0Wg@mail.gmail.com>
Subject: Re: [revert 0d60d8df6f49] [net/net-next] [6.8-rc5] Build Failure
To: Tasmiya Nalatwad <tasmiya@linux.vnet.ibm.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, arkadiusz.kubalewski@intel.com, 
	jiri@nvidia.com, kuba@kernel.org, 
	"abdhalee@linux.vnet.ibm.com" <abdhalee@linux.vnet.ibm.com>, 
	"mputtash@linux.vnet.com" <mputtash@linux.vnet.com>, "sachinp@linux.vnet.com" <sachinp@linux.vnet.com>, 
	venkat88@linux.vnet.ibm.com, 
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 9:04=E2=80=AFAM Tasmiya Nalatwad
<tasmiya@linux.vnet.ibm.com> wrote:
>
> Greetings,
>
> I have tried the patch provided below. Moving struct to file
> "net/core/rtnetlink.c" is not resolving the problem. Please find the
> below traces.
>
> --- Traces ---
>
> In file included from ./include/linux/rbtree.h:24,
>                   from ./include/linux/mm_types.h:11,
>                   from ./include/linux/mmzone.h:22,
>                   from ./include/linux/gfp.h:7,
>                   from ./include/linux/umh.h:4,
>                   from ./include/linux/kmod.h:9,
>                   from ./include/linux/module.h:17,
>                   from net/core/rtnetlink.c:17:
> net/core/rtnetlink.c: In function =E2=80=98netdev_dpll_pin=E2=80=99:
> ./include/linux/rcupdate.h:439:9: error: dereferencing pointer to
> incomplete type =E2=80=98struct dpll_pin=E2=80=99
>    typeof(*p) *local =3D (typeof(*p) *__force)READ_ONCE(p); \
>           ^
> ./include/linux/rcupdate.h:587:2: note: in expansion of macro
> =E2=80=98__rcu_dereference_check=E2=80=99
>    __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
>    ^~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/rtnetlink.h:70:2: note: in expansion of macro
> =E2=80=98rcu_dereference_check=E2=80=99
>    rcu_dereference_check(p, lockdep_rtnl_is_held())
>    ^~~~~~~~~~~~~~~~~~~~~
> net/core/rtnetlink.c:1059:15: note: in expansion of macro
> =E2=80=98rcu_dereference_rtnl=E2=80=99
>          return rcu_dereference_rtnl(dev->dpll_pin);
>                 ^~~~~~~~~~~~~~~~~~~~
>    CC      crypto/algboss.o
> net/core/rtnetlink.c:1063:1: error: control reaches end of non-void
> function [-Werror=3Dreturn-type]
>   }
>   ^
>    CC      crypto/authenc.o
>    CC      crypto/authencesn.o
>    CC      crypto/af_alg.o
>    CC      crypto/algif_hash.o
>    CC      crypto/algif_skcipher.o
>    CC      crypto/algif_rng.o
>    CC      crypto/algif_aead.o
>    AR      arch/powerpc/kernel/built-in.a
> cc1: some warnings being treated as errors
> make[4]: *** [scripts/Makefile.build:243: net/core/rtnetlink.o] Error 1
> make[4]: *** Waiting for unfinished jobs....
>    CC      lib/kobject_uevent.o
>    AR      drivers/net/mdio/built-in.a
>    AR      net/802/built-in.a
>    AR      drivers/connector/built-in.a
>    CC      lib/vsprintf.o
>    AR      ipc/built-in.a
>    AR      net/nsh/built-in.a
>    CC      lib/dynamic_debug.o
> In file included from ./arch/powerpc/include/generated/asm/rwonce.h:1,
>                   from ./include/linux/compiler.h:251,
>                   from ./include/linux/instrumented.h:10,
>                   from ./include/linux/uaccess.h:6,
>                   from net/core/dev.c:71:
> net/core/dev.c: In function =E2=80=98netdev_dpll_pin_assign=E2=80=99:
> ./include/linux/rcupdate.h:462:36: error: dereferencing pointer to
> incomplete type =E2=80=98struct dpll_pin=E2=80=99
>   #define RCU_INITIALIZER(v) (typeof(*(v)) __force __rcu *)(v)
>                                      ^~~~
> ./include/asm-generic/rwonce.h:55:33: note: in definition of macro
> =E2=80=98__WRITE_ONCE=E2=80=99
>    *(volatile typeof(x) *)&(x) =3D (val);    \
>                                   ^~~
> ./arch/powerpc/include/asm/barrier.h:76:2: note: in expansion of macro
> =E2=80=98WRITE_ONCE=E2=80=99
>    WRITE_ONCE(*p, v);      \
>    ^~~~~~~~~~
> ./include/asm-generic/barrier.h:172:55: note: in expansion of macro
> =E2=80=98__smp_store_release=E2=80=99
>   #define smp_store_release(p, v) do { kcsan_release();
> __smp_store_release(p, v); } while (0)
> ^~~~~~~~~~~~~~~~~~~
> ./include/linux/rcupdate.h:503:3: note: in expansion of macro
> =E2=80=98smp_store_release=E2=80=99
>     smp_store_release(&p, RCU_INITIALIZER((typeof(p))_r_a_p__v)); \
>     ^~~~~~~~~~~~~~~~~
> ./include/linux/rcupdate.h:503:25: note: in expansion of macro
> =E2=80=98RCU_INITIALIZER=E2=80=99
>     smp_store_release(&p, RCU_INITIALIZER((typeof(p))_r_a_p__v)); \
>                           ^~~~~~~~~~~~~~~
> net/core/dev.c:9081:2: note: in expansion of macro =E2=80=98rcu_assign_po=
inter=E2=80=99
>    rcu_assign_pointer(dev->dpll_pin, dpll_pin);
>    ^~~~~~~~~~~~~~~~~~
>
> On 2/28/24 20:13, Eric Dumazet wrote:
> > On Wed, Feb 28, 2024 at 3:07=E2=80=AFPM Vadim Fedorenko
> > <vadim.fedorenko@linux.dev> wrote:
> >> On 28/02/2024 11:09, Tasmiya Nalatwad wrote:
> >>> Greetings,
> >>>
> >>> [revert 0d60d8df6f49] [net/net-next] [6.8-rc5] Build Failure
> >>>
> >>> Reverting below commit fixes the issue
> >>>
> >>> commit 0d60d8df6f493bb46bf5db40d39dd60a1bafdd4e
> >>>       dpll: rely on rcu for netdev_dpll_pin()
> >>>
> >>> --- Traces ---
> >>>
> >>> ./include/linux/dpll.h: In function =E2=80=98netdev_dpll_pin=E2=80=99=
:
> >>> ./include/linux/rcupdate.h:439:9: error: dereferencing pointer to
> >>> incomplete type =E2=80=98struct dpll_pin=E2=80=99
> >>>     typeof(*p) *local =3D (typeof(*p) *__force)READ_ONCE(p); \
> >>>            ^
> >>> ./include/linux/rcupdate.h:587:2: note: in expansion of macro
> >>> =E2=80=98__rcu_dereference_check=E2=80=99
> >>>     __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
> >>>     ^~~~~~~~~~~~~~~~~~~~~~~
> >>> ./include/linux/rtnetlink.h:70:2: note: in expansion of macro
> >>> =E2=80=98rcu_dereference_check=E2=80=99
> >>>     rcu_dereference_check(p, lockdep_rtnl_is_held())
> >>>     ^~~~~~~~~~~~~~~~~~~~~
> >>> ./include/linux/dpll.h:175:9: note: in expansion of macro
> >>> =E2=80=98rcu_dereference_rtnl=E2=80=99
> >>>     return rcu_dereference_rtnl(dev->dpll_pin);
> >>>            ^~~~~~~~~~~~~~~~~~~~
> >>> make[4]: *** [scripts/Makefile.build:243: drivers/dpll/dpll_core.o] E=
rror 1
> >>> make[4]: *** Waiting for unfinished jobs....
> >>>     AR      net/mpls/built-in.a
> >>>     AR      net/l3mdev/built-in.a
> >>> In file included from ./include/linux/rbtree.h:24,
> >>>                    from ./include/linux/mm_types.h:11,
> >>>                    from ./include/linux/mmzone.h:22,
> >>>                    from ./include/linux/gfp.h:7,
> >>>                    from ./include/linux/umh.h:4,
> >>>                    from ./include/linux/kmod.h:9,
> >>>                    from ./include/linux/module.h:17,
> >>>                    from drivers/dpll/dpll_netlink.c:9:
> >>> ./include/linux/dpll.h: In function =E2=80=98netdev_dpll_pin=E2=80=99=
:
> >>> ./include/linux/rcupdate.h:439:9: error: dereferencing pointer to
> >>> incomplete type =E2=80=98struct dpll_pin=E2=80=99
> >>>     typeof(*p) *local =3D (typeof(*p) *__force)READ_ONCE(p); \
> >>>            ^
> >>> ./include/linux/rcupdate.h:587:2: note: in expansion of macro
> >>> =E2=80=98__rcu_dereference_check=E2=80=99
> >>>     __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
> >>>     ^~~~~~~~~~~~~~~~~~~~~~~
> >>> ./include/linux/rtnetlink.h:70:2: note: in expansion of macro
> >>> =E2=80=98rcu_dereference_check=E2=80=99
> >>>     rcu_dereference_check(p, lockdep_rtnl_is_held())
> >>>     ^~~~~~~~~~~~~~~~~~~~~
> >>> ./include/linux/dpll.h:175:9: note: in expansion of macro
> >>> =E2=80=98rcu_dereference_rtnl=E2=80=99
> >>>     return rcu_dereference_rtnl(dev->dpll_pin);
> >>>            ^~~~~~~~~~~~~~~~~~~~
> >>> make[4]: *** [scripts/Makefile.build:243: drivers/dpll/dpll_netlink.o=
]
> >>> Error 1
> >>> make[3]: *** [scripts/Makefile.build:481: drivers/dpll] Error 2
> >>> make[3]: *** Waiting for unfinished jobs....
> >>> In file included from ./arch/powerpc/include/generated/asm/rwonce.h:1=
,
> >>>                    from ./include/linux/compiler.h:251,
> >>>                    from ./include/linux/instrumented.h:10,
> >>>                    from ./include/linux/uaccess.h:6,
> >>>                    from net/core/dev.c:71:
> >>> net/core/dev.c: In function =E2=80=98netdev_dpll_pin_assign=E2=80=99:
> >>> ./include/linux/rcupdate.h:462:36: error: dereferencing pointer to
> >>> incomplete type =E2=80=98struct dpll_pin=E2=80=99
> >>>    #define RCU_INITIALIZER(v) (typeof(*(v)) __force __rcu *)(v)
> >>>                                       ^~~~
> >>> ./include/asm-generic/rwonce.h:55:33: note: in definition of macro
> >>> =E2=80=98__WRITE_ONCE=E2=80=99
> >>>     *(volatile typeof(x) *)&(x) =3D (val);    \
> >>>                                    ^~~
> >>> ./arch/powerpc/include/asm/barrier.h:76:2: note: in expansion of macr=
o
> >>> =E2=80=98WRITE_ONCE=E2=80=99
> >>>     WRITE_ONCE(*p, v);      \
> >>>     ^~~~~~~~~~
> >>> ./include/asm-generic/barrier.h:172:55: note: in expansion of macro
> >>> =E2=80=98__smp_store_release=E2=80=99
> >>>    #define smp_store_release(p, v) do { kcsan_release();
> >>> __smp_store_release(p, v); } while (0)
> >>> ^~~~~~~~~~~~~~~~~~~
> >>> ./include/linux/rcupdate.h:503:3: note: in expansion of macro
> >>> =E2=80=98smp_store_release=E2=80=99
> >>>      smp_store_release(&p, RCU_INITIALIZER((typeof(p))_r_a_p__v)); \
> >>>      ^~~~~~~~~~~~~~~~~
> >>> ./include/linux/rcupdate.h:503:25: note: in expansion of macro
> >>> =E2=80=98RCU_INITIALIZER=E2=80=99
> >>>      smp_store_release(&p, RCU_INITIALIZER((typeof(p))_r_a_p__v)); \
> >>>                            ^~~~~~~~~~~~~~~
> >>> net/core/dev.c:9081:2: note: in expansion of macro =E2=80=98rcu_assig=
n_pointer=E2=80=99
> >>>     rcu_assign_pointer(dev->dpll_pin, dpll_pin);
> >>>     ^~~~~~~~~~~~~~~~~~
> >>> make[4]: *** [scripts/Makefile.build:243: net/core/dev.o] Error 1
> >>> make[4]: *** Waiting for unfinished jobs....
> >>>     AR      drivers/net/ethernet/built-in.a
> >>>     AR      drivers/net/built-in.a
> >>>     AR      net/dcb/built-in.a
> >>>     AR      net/netlabel/built-in.a
> >>>     AR      net/strparser/built-in.a
> >>>     AR      net/handshake/built-in.a
> >>>     GEN     lib/test_fortify.log
> >>>     AR      net/8021q/built-in.a
> >>>     AR      net/nsh/built-in.a
> >>>     AR      net/unix/built-in.a
> >>>     CC      lib/string.o
> >>>     AR      net/packet/built-in.a
> >>>     AR      net/switchdev/built-in.a
> >>>     AR      lib/lib.a
> >>>     AR      net/mptcp/built-in.a
> >>>     AR      net/devlink/built-in.a
> >>> In file included from ./include/linux/rbtree.h:24,
> >>>                    from ./include/linux/mm_types.h:11,
> >>>                    from ./include/linux/mmzone.h:22,
> >>>                    from ./include/linux/gfp.h:7,
> >>>                    from ./include/linux/umh.h:4,
> >>>                    from ./include/linux/kmod.h:9,
> >>>                    from ./include/linux/module.h:17,
> >>>                    from net/core/rtnetlink.c:17:
> >>> ./include/linux/dpll.h: In function =E2=80=98netdev_dpll_pin=E2=80=99=
:
> >>> ./include/linux/rcupdate.h:439:9: error: dereferencing pointer to
> >>> incomplete type =E2=80=98struct dpll_pin=E2=80=99
> >>>     typeof(*p) *local =3D (typeof(*p) *__force)READ_ONCE(p); \
> >>>            ^
> >>> ./include/linux/rcupdate.h:587:2: note: in expansion of macro
> >>> =E2=80=98__rcu_dereference_check=E2=80=99
> >>>     __rcu_dereference_check((p), __UNIQUE_ID(rcu), \
> >>>     ^~~~~~~~~~~~~~~~~~~~~~~
> >>> ./include/linux/rtnetlink.h:70:2: note: in expansion of macro
> >>> =E2=80=98rcu_dereference_check=E2=80=99
> >>>     rcu_dereference_check(p, lockdep_rtnl_is_held())
> >>>     ^~~~~~~~~~~~~~~~~~~~~
> >>> ./include/linux/dpll.h:175:9: note: in expansion of macro
> >>> =E2=80=98rcu_dereference_rtnl=E2=80=99
> >>>     return rcu_dereference_rtnl(dev->dpll_pin);
> >>>            ^~~~~~~~~~~~~~~~~~~~
> >>> In file included from net/core/rtnetlink.c:60:
> >>> ./include/linux/dpll.h:179:1: error: control reaches end of non-void
> >>> function [-Werror=3Dreturn-type]
> >>>    }
> >>>
> >> Hi, Eric!
> >>
> >> Looks like we have to move struct dpll_pin definition to
> >> include/linux/dpll.h to have this fixed, right?
> >>
> > No idea what is wrong. Is it powerpc specific ? Some compiler version ?
> >
> > netdev_dpll_pin() could be moved to net/core/rtnetlink.c, this is the o=
nly user.

OK, it seems netdev_dpll_pin() has to be moved in a place the
structure is known,
because rcu_dereference() needs to know its size.

I do not see other solution than this, otherwise we have to add more
pollution to include/linux/netdevice.h

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index a9c973b92294bb110cf3cd336485972127b01b58..40797ea80bc6273cae6b7773d0a=
3e47459a72150
100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2469,7 +2469,7 @@ struct net_device {
        struct devlink_port     *devlink_port;

 #if IS_ENABLED(CONFIG_DPLL)
-       struct dpll_pin __rcu   *dpll_pin;
+       void __rcu *dpll_pin;
 #endif
 #if IS_ENABLED(CONFIG_PAGE_POOL)
        /** @page_pools: page pools created for this netdevice */

