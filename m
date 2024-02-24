Return-Path: <linux-kernel+bounces-79738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E652A862604
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 17:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35B88B217D2
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 16:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959891119C;
	Sat, 24 Feb 2024 16:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="euIG6a8h"
Received: from prime.voidband.net (prime.voidband.net [199.247.17.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C625E2581;
	Sat, 24 Feb 2024 16:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.247.17.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708792254; cv=none; b=fA1crYvXPb5rhNtYBUtvd7FvMFGH6OzUC1sXiFzeLxfNEHXA35eyNCPnX6FkxcaoRlgLqgXG2/Z2rdjQDs1/6LHWeTbhUTPlP/k9hmjfm46wsHashRBsihJ6kX8+LHKMr28cDF6lQUtB7BdWArVPOplIqIomKmKmUtMoCTPk8TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708792254; c=relaxed/simple;
	bh=I/v6RJT0t6DlTDyxc8Am6IgnyzyrcVDcRJCibjDyMC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aVwwJm4mVitoCPCr52z2lxiUPN1KYflQS5Vqk8SmHxExLjXl6sdWcI7kYwaTJq5vQqSFbQGB7wCZgtS63w2pTRLG9TvU/okcPVPfTNuBQcRO6Op9epTwxhKUdT3mZXkG/+njO5/YN0CPbe53hwh3ikDljcdA6T89BZy4HZZynbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name; spf=pass smtp.mailfrom=natalenko.name; dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b=euIG6a8h; arc=none smtp.client-ip=199.247.17.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=natalenko.name
Received: from spock.localnet (unknown [94.142.239.106])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by prime.voidband.net (Postfix) with ESMTPSA id 3B2E06356CC7;
	Sat, 24 Feb 2024 17:30:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
	s=dkim-20170712; t=1708792242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5ZkVS+AT85sSAVnJaOkha5ycb1VJlcSgs87CoFXcMYA=;
	b=euIG6a8hixo1hFd8UHvp0c9mHpWDaOa1NekQRHZMEGYCuF2YYgIRquTNs1V3dcfS3JRR01
	HKtCFL9dzYSlW/8uMZI8m8Jt/L+hPcBBik8xCtucEJA+MzGwsT00E1u/EFJmwi7Vmvcbau
	SGWnLb7+yfYCa8KNxTEB7Km8V1Dy0mo=
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
 Boqun Feng <boqun.feng@gmail.com>
Cc: Zqiang <qiang.zhang1211@gmail.com>,
 Joel Fernandes <joel@joelfernandes.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 "Paul E . McKenney" <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Neeraj Upadhyay <quic_neeraju@quicinc.com>,
 Josh Triplett <josh@joshtriplett.org>, Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Bagas Sanjaya <bagasdotme@gmail.com>,
 Marcus Seyfarth <m.seyfarth@gmail.com>, Tor Vic <torvic9@mailbox.org>
Subject:
 Re: [PATCH 5/6] rcu/nocb: Fix WARN_ON_ONCE() in the rcu_nocb_bypass_lock()
Date: Sat, 24 Feb 2024 17:30:29 +0100
Message-ID: <12387583.O9o76ZdvQC@natalenko.name>
In-Reply-To: <20240201014100.3204532-6-boqun.feng@gmail.com>
References:
 <20240201014100.3204532-1-boqun.feng@gmail.com>
 <20240201014100.3204532-6-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5758540.DvuYhMxLoT";
 micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart5758540.DvuYhMxLoT
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"; protected-headers="v1"
From: Oleksandr Natalenko <oleksandr@natalenko.name>
Date: Sat, 24 Feb 2024 17:30:29 +0100
Message-ID: <12387583.O9o76ZdvQC@natalenko.name>
In-Reply-To: <20240201014100.3204532-6-boqun.feng@gmail.com>
MIME-Version: 1.0

Hello.

On =C4=8Dtvrtek 1. =C3=BAnora 2024 2:40:57 CET Boqun Feng wrote:
> From: Zqiang <qiang.zhang1211@gmail.com>
>=20
> For the kernels built with CONFIG_RCU_NOCB_CPU_DEFAULT_ALL=3Dy and
> CONFIG_RCU_LAZY=3Dy, the following scenarios will trigger WARN_ON_ONCE()
> in the rcu_nocb_bypass_lock() and rcu_nocb_wait_contended() functions:
>=20
>         CPU2                                               CPU11
> kthread
> rcu_nocb_cb_kthread                                       ksys_write
> rcu_do_batch                                              vfs_write
> rcu_torture_timer_cb                                      proc_sys_write
> __kmem_cache_free                                         proc_sys_call_h=
andler
> kmemleak_free                                             drop_caches_sys=
ctl_handler
> delete_object_full                                        drop_slab
> __delete_object                                           shrink_slab
> put_object                                                lazy_rcu_shrink=
_scan
> call_rcu                                                  rcu_nocb_flush_=
bypass
> __call_rcu_commn                                            rcu_nocb_bypa=
ss_lock
>                                                             raw_spin_tryl=
ock(&rdp->nocb_bypass_lock) fail
>                                                             atomic_inc(&r=
dp->nocb_lock_contended);
> rcu_nocb_wait_contended                                     WARN_ON_ONCE(=
smp_processor_id() !=3D rdp->cpu);
>  WARN_ON_ONCE(atomic_read(&rdp->nocb_lock_contended))                    =
                      |
>                             |_ _ _ _ _ _ _ _ _ _same rdp and rdp->cpu !=
=3D 11_ _ _ _ _ _ _ _ _ __|
>=20
> Reproduce this bug with "echo 3 > /proc/sys/vm/drop_caches".
>=20
> This commit therefore uses rcu_nocb_try_flush_bypass() instead of
> rcu_nocb_flush_bypass() in lazy_rcu_shrink_scan().  If the nocb_bypass
> queue is being flushed, then rcu_nocb_try_flush_bypass will return
> directly.
>=20
> Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---
>  kernel/rcu/tree_nocb.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index 9e8052ba14b9..ffa69a5e18f4 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -1391,7 +1391,7 @@ lazy_rcu_shrink_scan(struct shrinker *shrink, struc=
t shrink_control *sc)
>  			rcu_nocb_unlock_irqrestore(rdp, flags);
>  			continue;
>  		}
> -		WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, jiffies, false));
> +		rcu_nocb_try_flush_bypass(rdp, jiffies);
>  		rcu_nocb_unlock_irqrestore(rdp, flags);
>  		wake_nocb_gp(rdp, false);
>  		sc->nr_to_scan -=3D _count;
>=20

Does this fix [1] [2]?

Thank you.

[1] https://bugzilla.kernel.org/show_bug.cgi?id=3D217948
[2] https://lore.kernel.org/lkml/8461340f-c7c8-4e1e-b7fa-a0e4b9a6c2a8@gmail=
=2Ecom/

=2D-=20
Oleksandr Natalenko (post-factum)
--nextPart5758540.DvuYhMxLoT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEZUOOw5ESFLHZZtOKil/iNcg8M0sFAmXaGaUACgkQil/iNcg8
M0u1Iw//eQsWmsGQxRNM+lrI0p7INHxxrwdfnamfNsf0H7grSEZ6ucBuQH9dRPR/
fyxlAazyc0gnHOa+gOf7SQWzUvlHEs9gAP1ozRYexVQMmOit26ROwY5Mqk8hYWbU
Dd4bcbfx8pIhXOoLTU8tznKWYLnGUaQXKe8FFkza6sUv8bc7mQSxHfshOCkHt7aK
WI0TT1fQn8dPf62e03KYUiuPTK40pP1ttfOXldXIZ+kjykdKiKMuWw8vA/6uDMn5
9R5Gtea5bpbJrAv8AeliteEeE2RUuBgHVaL9E4t2pe0VsGbMoGej7UHqZ2KtQjH0
VajCVuanYiptlFRNV7xvUPOF9gFxyUKCJ/lAeX7DYWPnKkovrzZBf7tQ7uhNQ2nf
ygvs54dH0KT3oy3fV00FWLs/Hn93JZYJ4V7S445GOL83aMI4ka3DS5jidSB9AS8c
oKGUQrcwPyE1vca4y/jGTtQkJY6c2wEi3GeNfXG8E/Ab+PSeWBSUqGQezQaprC/M
ngF6CbklJiz/P7B2pD4sC6pzqMg5duBZVXV/97UdV0TvHyZjfrAchuqGwEIBjxuD
MNUHKqcbTK+3ez1uJtIUt3MzTsRVCjXb9CKodv1VexysPWsahKvbT2kNJbSXqHRR
w6owZZGpYS/Zp5Sjy50s7W7RB9Ec61cARZ3W5F88gobq0r61a9A=
=Znbt
-----END PGP SIGNATURE-----

--nextPart5758540.DvuYhMxLoT--




