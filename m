Return-Path: <linux-kernel+bounces-106666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB4187F1BA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 22:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FCF1281B53
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 21:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F016758201;
	Mon, 18 Mar 2024 21:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Cd2rvKxY"
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C49158131
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 21:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710795947; cv=none; b=eNQp5vsGS6TsDhRp1ZmLLp0+6FS37MVmsbKBM8QEdQVRjXcBuy/32rJnoLXysta2eGLGzWNHI9kyERqxDNGF7OgmSdXjr5EpKyqgwPdt9Eda238O7xwTSglGvHIeDWeoWKml6+mnTeZvFgMFiTVurzXyQ4bPGW6HqLn2uXxrrxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710795947; c=relaxed/simple;
	bh=mhEDrR9C7YEoGmhM49MXiXEW0net0pIPpVQcSKsrjxU=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=l8zgP5k+9EE0lWeNcUT5fMtMPkeQnw41FYDZ/ju+geXNVnH/9kMTb+9znhV4mhxlNHbAo5zFx7q8rB/F01vlRiLMcSnm34Nrwpk9gwnW0M0lrj01wtmbrYHw2LkihRArTgu/XeqZ1bE9G05Kl1EIXTcML3TqP++nB32XGE+kF0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=Cd2rvKxY; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-22200c78d4fso2011546fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 14:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1710795944; x=1711400744; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Oc7CYcOIjU7/6iBC8IZweQUGbpgg4UYyzRmGvk3Smcg=;
        b=Cd2rvKxYH000We5oWwfC/L1x7/fjHAD0dldRas9UAjG8RGhSeqJ4TK3mQuNzLngwQq
         YU5tWQRs5VRkoQmpWrQ9EtUASJiYIjlWTV9ISlriVG1x/ChL8GPPJOrUyFgaV6o3cOJR
         ck+vauPMkjBNpRMNANtcOMW40AtcfSGJSDZSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710795944; x=1711400744;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oc7CYcOIjU7/6iBC8IZweQUGbpgg4UYyzRmGvk3Smcg=;
        b=EKrw38+kuaDyY3kIvLOfbqv484pcc2/my2hlcy18Z7KGlq8nX0kqs29v6oibmD7TjD
         KLbr0xWzkXz+watAwly9d8UpTGPTjB9Rd3/8wFnJwUN5/k7BpsJWTxwqjrywQ9rNPClQ
         qf9sY29RawR30W3qXjnoZBELFd+1K7aQ8yXEgZurCUAxmhHf0Fv1T2q1oiLW//kL6FsU
         KQY7YHDcL9VxDmUxehIocE7LcuYQP20RfdbLy5/0GsbWQlmI0BafFw/j5YWJYYn4aXbq
         2+FcWV5zpFKEpaYnw3YP63yPg4bCTEyTLSAYlqqtk5bCh8P8hpujgIWM+Bf0y56AIPjs
         UO2Q==
X-Gm-Message-State: AOJu0Yzv/J0sszJ214bDFsVPAC2L1XmbN0GzmesbQ7eGJoZpC7Ze/P9B
	2VnOisCBjZsbsrJ6KtdWCNTM32GburRkbOWHdUlTFaieyNpdQdjf1Zbhkq96Id8=
X-Google-Smtp-Source: AGHT+IHW33l7BhtlKga5NrVN1zzblIpi1h58wHOlcqfnnpO0183ZjvtHvYrb1MW3aDsUS/gWGPIT/g==
X-Received: by 2002:a05:6870:548e:b0:221:1c2f:23ee with SMTP id f14-20020a056870548e00b002211c2f23eemr14426318oan.22.1710795944325;
        Mon, 18 Mar 2024 14:05:44 -0700 (PDT)
Received: from smtpclient.apple ([192.145.116.24])
        by smtp.gmail.com with ESMTPSA id u11-20020ad45aab000000b006942dcac56asm2755948qvg.103.2024.03.18.14.05.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 14:05:43 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Joel Fernandes <joel@joelfernandes.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 rcu/dev 1/2] rcu/tree: Reduce wake up for synchronize_rcu() common case
Date: Mon, 18 Mar 2024 17:05:31 -0400
Message-Id: <404E28F5-B018-4CE7-BE57-D0362B0C9969@joelfernandes.org>
References: <ZfiOwtPfnxXW4JX3@pc636>
Cc: linux-kernel@vger.kernel.org, frederic@kernel.org, boqun.feng@gmail.com,
 neeraj.iitr10@gmail.com, rcu@vger.kernel.org, rostedt@goodmis.org,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Josh Triplett <josh@joshtriplett.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>
In-Reply-To: <ZfiOwtPfnxXW4JX3@pc636>
To: Uladzislau Rezki <urezki@gmail.com>
X-Mailer: iPhone Mail (21D61)



> On Mar 18, 2024, at 2:58=E2=80=AFPM, Uladzislau Rezki <urezki@gmail.com> w=
rote:
>=20
> =EF=BB=BFHello, Joel!
>=20
> Sorry for late checking, see below few comments:
>=20
>> In the synchronize_rcu() common case, we will have less than
>> SR_MAX_USERS_WAKE_FROM_GP number of users per GP. Waking up the kworker
>> is pointless just to free the last injected wait head since at that point=
,
>> all the users have already been awakened.
>>=20
>> Introduce a new counter to track this and prevent the wakeup in the
>> common case.
>>=20
>> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>> ---
>> Rebased on paul/dev of today.
>>=20
>> kernel/rcu/tree.c | 36 +++++++++++++++++++++++++++++++-----
>> kernel/rcu/tree.h |  1 +
>> 2 files changed, 32 insertions(+), 5 deletions(-)
>>=20
>> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
>> index 9fbb5ab57c84..bd29fe3c76bf 100644
>> --- a/kernel/rcu/tree.c
>> +++ b/kernel/rcu/tree.c
>> @@ -96,6 +96,7 @@ static struct rcu_state rcu_state =3D {
>>    .ofl_lock =3D __ARCH_SPIN_LOCK_UNLOCKED,
>>    .srs_cleanup_work =3D __WORK_INITIALIZER(rcu_state.srs_cleanup_work,
>>        rcu_sr_normal_gp_cleanup_work),
>> +    .srs_cleanups_pending =3D ATOMIC_INIT(0),
>> };
>>=20
>> /* Dump rcu_node combining tree at boot to verify correct setup. */
>> @@ -1642,8 +1643,11 @@ static void rcu_sr_normal_gp_cleanup_work(struct w=
ork_struct *work)
>>     * the done tail list manipulations are protected here.
>>     */
>>    done =3D smp_load_acquire(&rcu_state.srs_done_tail);
>> -    if (!done)
>> +    if (!done) {
>> +        /* See comments below. */
>> +        atomic_dec_return_release(&rcu_state.srs_cleanups_pending);
>>        return;
>> +    }
>>=20
>>    WARN_ON_ONCE(!rcu_sr_is_wait_head(done));
>>    head =3D done->next;
>> @@ -1666,6 +1670,9 @@ static void rcu_sr_normal_gp_cleanup_work(struct wo=
rk_struct *work)
>>=20
>>        rcu_sr_put_wait_head(rcu);
>>    }
>> +
>> +    /* Order list manipulations with atomic access. */
>> +    atomic_dec_return_release(&rcu_state.srs_cleanups_pending);
>> }
>>=20
>> /*
>> @@ -1673,7 +1680,7 @@ static void rcu_sr_normal_gp_cleanup_work(struct wo=
rk_struct *work)
>>  */
>> static void rcu_sr_normal_gp_cleanup(void)
>> {
>> -    struct llist_node *wait_tail, *next, *rcu;
>> +    struct llist_node *wait_tail, *next =3D NULL, *rcu =3D NULL;
>>    int done =3D 0;
>>=20
>>    wait_tail =3D rcu_state.srs_wait_tail;
>> @@ -1699,16 +1706,35 @@ static void rcu_sr_normal_gp_cleanup(void)
>>            break;
>>    }
>>=20
>> -    // concurrent sr_normal_gp_cleanup work might observe this update.
>> -    smp_store_release(&rcu_state.srs_done_tail, wait_tail);
>> +    /*
>> +     * Fast path, no more users to process. Remove the last wait head
>> +     * if no inflight-workers. If there are in-flight workers, let them
>> +     * remove the last wait head.
>> +     */
>> +    WARN_ON_ONCE(!rcu);
>>=20
> This assumption is not correct. An "rcu" can be NULL in fact.

Hmm I could never trigger that. Are you saying that is true after Neeraj rec=
ent patch or something else? Note, after Neeraj patch to handle the lack of h=
eads availability, it could be true so I requested him to rebase his patch o=
n top of this one.

However I will revisit my patch and look for if it could occur but please le=
t me know if you knew of a sequence of events to make it NULL.
>=20
>>    ASSERT_EXCLUSIVE_WRITER(rcu_state.srs_done_tail);
>>=20
>> +    if (rcu && rcu_sr_is_wait_head(rcu) && rcu->next =3D=3D NULL &&
>> +        /* Order atomic access with list manipulation. */
>> +        !atomic_read_acquire(&rcu_state.srs_cleanups_pending)) {
>> +        wait_tail->next =3D NULL;
>> +        rcu_sr_put_wait_head(rcu);
>> +        smp_store_release(&rcu_state.srs_done_tail, wait_tail);
>> +        return;
>> +    }
>> +
>> +    /* Concurrent sr_normal_gp_cleanup work might observe this update. *=
/
>> +    smp_store_release(&rcu_state.srs_done_tail, wait_tail);
>> +
>>    /*
>>     * We schedule a work in order to perform a final processing
>>     * of outstanding users(if still left) and releasing wait-heads
>>     * added by rcu_sr_normal_gp_init() call.
>>     */
>> -    queue_work(sync_wq, &rcu_state.srs_cleanup_work);
>> +    atomic_inc(&rcu_state.srs_cleanups_pending);
>> +    if (!queue_work(sync_wq, &rcu_state.srs_cleanup_work)) {
>> +        atomic_dec(&rcu_state.srs_cleanups_pending);
>> +    }
>> }
> No need an extra "{}" pair.

I do prefer it for readability but I am ok with dropping it.

Thanks!

 - Joel=20


>=20
>>=20
>> /*
>> diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
>> index bae7925c497f..affcb92a358c 100644
>> --- a/kernel/rcu/tree.h
>> +++ b/kernel/rcu/tree.h
>> @@ -420,6 +420,7 @@ struct rcu_state {
>>    struct llist_node *srs_done_tail; /* ready for GP users. */
>>    struct sr_wait_node srs_wait_nodes[SR_NORMAL_GP_WAIT_HEAD_MAX];
>>    struct work_struct srs_cleanup_work;
>> +    atomic_t srs_cleanups_pending; /* srs inflight worker cleanups. */
>> };
>>=20
>> /* Values for rcu_state structure's gp_flags field. */
>> --
>> 2.34.1
>>=20

