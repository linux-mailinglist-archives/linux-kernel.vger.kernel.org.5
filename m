Return-Path: <linux-kernel+bounces-86675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B3986C8E2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 13:10:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E29E1F2430E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 12:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30F67CF2F;
	Thu, 29 Feb 2024 12:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mIw4MI3h"
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2AB7CF05
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 12:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709208645; cv=none; b=Qvl+qk1xkbibvW1o0hfoZWClrdzMAL+GLdXoQ4kSvCKWENfgNL1TpzUsYenq57mNuwGo0e+PNJrkze6yMPwJWOWuN2Qr8bmtaC41jq80QygImGElHLgEbe5HbtLYfLSbbrIhz6ChZZdUPDQumXd5LVztmUJJW2smJzOvJD01Tl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709208645; c=relaxed/simple;
	bh=mfjPd1U+adc4ve4QA4w3oWWCP/Tc0obx8xoCqiQXCVs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bSWBN270b9M/xJFWg/mT/9nvhoYtX+HC8iWLJgfuvRB2qsaKE5+Rp1NJMXiYH/9nCuxfeDELChWWsmtYg6xeyUl+I6WATbIZ7HAXtu2JxTSb80hfsdOZE7FRmnH3+AmzXpBDSeqfZMSFfqciUNckzx+6tTdcsORw+F/xTet7XaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mIw4MI3h; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-22008177fbeso438089fac.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 04:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709208643; x=1709813443; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/+Qo/2XnVO5nScjBtm3TPkC+ZUg/4p0urWGvzwJEw5s=;
        b=mIw4MI3hAP+mIiVpdfpcEHAl1u3+YjIrOwX7O3cCzXSNLq1W3E05gH25TEPWAn+xJy
         0OS2o4A6mjgy7h2fLku4Jav5bMy9+gFs44XYjUpimQKqHz5OAoWO+sScH8E1PDW9s22q
         1wbrPmhvVec8adKwpgr/EpAJ23pAshN+QvhuiV8dvLR9BWQrcaPDl6k/MYloznxuxfC6
         cckTTsq6ytWBonSyEAE1/21dxy0kOsOplaAskzgRCVmX7ISNUNScet90A15ZELEJnUoT
         XKDR9eKR4/asbcO5AUWTuwRB4IeKWUUkcp4PH+jDoYchg6DFdU9NW5rBI1g2NgrAqoBw
         Sfaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709208643; x=1709813443;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/+Qo/2XnVO5nScjBtm3TPkC+ZUg/4p0urWGvzwJEw5s=;
        b=A5L2kv2SpeTE8eEoAXTQ4vBzeDXI1YVQF9dbFQQX1kTCnluLFku9z0A7p+bOauuAbL
         /Ar2V2mUI2rSNbxrXk3amoLRKxVMuSYdGJwsAky4avlfGeg0PlJUjmzXFMTt8e+NnUkk
         vJZK64fQrbxHdvwkJjL6XwwMt8ZJCL9gbd1Cj1I80sDs360sW4FkG9QZau2qVG31I9ca
         AgLiFC9uIIKGQ6pMjxa59HydtAhKF6CN/nPGQGq0gXSHebBE+jLFuoZxMlb0E7IEYs1D
         xM8B6E/6DFmsJlRwkZ2YJ9b+R1P3gzAdCRGHMt9bmkoH45RPIQWsVtDsvM1sXYC9S3gf
         myOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFWweqAMg8lFOPcIYDgMGfoqhrkUX6fVV9JeXfeYPRETvdmQ47qb4s+83xuqCzIolgTRk3YCkFSjCxIgWoTK4htr1zijPD7r3C+V3K
X-Gm-Message-State: AOJu0Yyj8x5M2qLO1c4Nwq1kb3FAUwFw3m4rhWxWDF5y1RzOAPFARqqs
	cIsxmlYv4s6Nj07EafiWMEG4mAbQXBKr0rA8+DNESn9j40UlwD2T3WzMBffcgzlavvr7hGQr89K
	DRR0E/YGRt5UZMoVMpYAFevUAHdA=
X-Google-Smtp-Source: AGHT+IGUVoQ714QJc9vcJ2svVF3mHGj7gtzdBFuR8RdkaH1wpZ+HKqVbcgS4w1RJNF7tFji7AfPhtYyoiSLMa/WlnWI=
X-Received: by 2002:a05:6871:e028:b0:21e:90a3:1871 with SMTP id
 by40-20020a056871e02800b0021e90a31871mr1865744oac.50.1709208643166; Thu, 29
 Feb 2024 04:10:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240226082349.302363-1-yu.c.chen@intel.com> <CAB8ipk9N9verfQp6U9s8+TQgNbA5J0DWkOB1dShf20n0xbx94w@mail.gmail.com>
 <Zd9QRBaWVgmZ5Df8@chenyu5-mobl2>
In-Reply-To: <Zd9QRBaWVgmZ5Df8@chenyu5-mobl2>
From: Xuewen Yan <xuewen.yan94@gmail.com>
Date: Thu, 29 Feb 2024 20:10:32 +0800
Message-ID: <CAB8ipk9NFXrPM3jMi7U9hWNy-gSiqSWuUu_tBXs0Xgb3R66S_Q@mail.gmail.com>
Subject: Re: [RFC PATCH] sched/eevdf: Return leftmost entity in pick_eevdf()
 if no eligible entity is found
To: Chen Yu <yu.c.chen@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Abel Wu <wuyun.abel@bytedance.com>, Tim Chen <tim.c.chen@intel.com>, 
	Tiwei Bie <tiwei.btw@antgroup.com>, Honglei Wang <wanghonglei@didichuxing.com>, 
	Aaron Lu <aaron.lu@intel.com>, Chen Yu <yu.chen.surf@gmail.com>, 
	linux-kernel@vger.kernel.org, kernel test robot <oliver.sang@intel.com>, 
	Xuewen Yan <xuewen.yan@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yu

On Wed, Feb 28, 2024 at 11:25=E2=80=AFPM Chen Yu <yu.c.chen@intel.com> wrot=
e:
>
> Hi Xuewen,
>
> On 2024-02-28 at 17:04:49 +0800, Xuewen Yan wrote:
> > Hi Yu
> >
> > On Mon, Feb 26, 2024 at 4:26=E2=80=AFPM Chen Yu <yu.c.chen@intel.com> w=
rote:
> > >
> > > There is occasional report from lkp that the kernel hits the NULL poi=
nter
> > > exception:
> > >
> > > [  512.079810][ T8305] BUG: kernel NULL pointer dereference, address:=
 0000002c
> > > [  512.080897][ T8305] #PF: supervisor read access in kernel mode
> > > [  512.081636][ T8305] #PF: error_code(0x0000) - not-present page
> > > [  512.082337][ T8305] *pde =3D 00000000
> > > [  512.082829][ T8305] Oops: 0000 [#1] PREEMPT SMP
> > > [  512.083407][ T8305] CPU: 1 PID: 8305 Comm: watchdog Tainted: G    =
    W
> > > [  512.086203][ T8305] EIP: set_next_entity (fair.c:?)
> > >
> > > This is caused by NULL candidate returned by pick_eevdf() as Abel ana=
lyzed.
> > > After
> > > commit 2227a957e1d5 ("sched/eevdf: Sort the rbtree by virtual deadlin=
e")
> > > the NULL candidate would trigger the NULL pointer exception. While be=
fore
> > > this commit, there would be warning.
> > >
> > > This NULL entity issue was always there before above commit. With deb=
ug
> > > patch to print the cfs_rq and all the entities in the tree, we have t=
he
> > > information when the issue was reproduced:
> > >
> > > [  514.461242][ T8390] cfs_rq avg_vruntime:386638640128 avg_load:2048=
 min_vruntime:763383370431
> > > [  514.535935][ T8390] current on_rq se 0xc5851400, deadline:18435852=
013562231446
> > >                         min_vruntime:18437121115753667698 vruntime:18=
435852013561943404, load:629
> > > [  514.536772][ T8390] Traverse rb-tree from left to right
> > > [  514.537138][ T8390]  se 0xec1234e0 deadline:763384870431 min_vrunt=
ime:763383370431 vruntime:763383370431 non-eligible
> > > [  514.537835][ T8390]  se 0xec4fcf20 deadline:763762447228 min_vrunt=
ime:763760947228 vruntime:763760947228 non-eligible
> > > [  514.538539][ T8390] Traverse rb-tree from topdown
> > > [  514.538877][ T8390]  middle se 0xec1234e0 deadline:763384870431 mi=
n_vruntime:763383370431 vruntime:763383370431 non-eligible
> > > [  514.539605][ T8390]  middle se 0xec4fcf20 deadline:763762447228 mi=
n_vruntime:763760947228 vruntime:763760947228 non-eligible
> > > [  514.540340][ T8390] Found best:0x0
> > > [  514.540613][ T8390] BUG: kernel NULL pointer dereference, address:=
 00000074
> > >
> > > We can see that non of the entities in the tree are eligible, neither=
 is
> > > the current entity on this cfs_rq. As a result, curr is set to NULL:
> > > if (curr && (!curr->on_rq || !entity_eligible(cfs_rq, curr)))
> > >         curr =3D NULL;
> > >
> > > and the best is set to NULL, which caused the problem:
> > > if (!best || (curr && entity_before(curr, best)))
> > >         best =3D curr;
> > >
> > > The cause is that, the curr is eligible, but vruntime_eligible()
> > > returns false. And the false negative is due to the following
> > > code in vruntime_eligible():
> > >
> > > return avg >=3D (s64)(vruntime - cfs_rq->min_vruntime) * load;
> > >
> > > According to the log, vruntime is 18435852013561943404, the
> > > cfs_rq->min_vruntime is 763383370431, the load is 629 + 2048 =3D 2677=
,
> > > thus:
> > > s64 delta =3D (s64)(18435852013561943404 - 763383370431) =3D -1089282=
3530978643
> > >     delta * 2677 =3D 7733399554989275921
> > > that is to say, the multiply result overflow the s64, which turns the
> > > negative value into a positive value, thus eligible check fails.
> > >
> > > So where is this insane huge vruntime 18435852013561943404 coming fro=
m?
> > > My guess is that, it is because the initial value of cfs_rq->min_vrun=
time
> > > is set to (unsigned long)(-(1LL << 20)). If the task(watchdog in this=
 case)
> > > seldom scheduled in, its vruntime might not move forward too much and
> > > remain its original value by previous place_entity().
> >
> > Could you please test the follow patch:
> >
> > https://lore.kernel.org/all/20240130080643.1828-1-xuewen.yan@unisoc.com=
/
> >
> > Because the se->vruntime would be changed in place_entity() and
> > reweight_eevdf(),
> > however, now the vlag may exceed eevdf's limit in some scenarios, it ma=
y cause
> > the vrunitme's error.
> >
>
> Thanks for providing this fix. I took a quick look at your patch, and it =
looks
> reasonable to me. I'm not quite sure if the vlag issue is the root cause =
of
> this NULL candidate problem, say, if the abnormal vlag happens, it should=
 satisfy:
> curr->vlag =3D=3D curr->deadline ?

Actually, this is just a situation, because in set_next_entity(), it
would set the valg be equal to deadline, and if using the vlag to
update the vruntime, the vruntime is most likely wrong.
However, even if vlag is normal, after the calc: ((W + w_i)*vl'_i / W)
or (w/w'), it may also be an out-of-bounds value.
For example: if change the nice from -20(weight:88761) to
19(weight:15), its vlag would be 88761/15=3D5917*vlag.

>
> According to the data,
> curr->deadline =3D
> cfs_rq->min_vruntime =3D 763383370431
> cfs_rq->avg_vruntime =3D 386638640128
> entity_key =3D -10892823530978643
> avg =3D -6851585614346926319
> load =3D 2677
> so avg_vruntime() =3D 18444185410266494357
> curr->vlag =3D 8333396704550953
> which does not equal to curr->deadline =3D 18435852013562231446
>
> Anyway, if we want to root cause why vruntime is behind cfs_rq->min_vrunt=
ime so
> much, we can add more debug code to further investigation. And we will al=
so leverage
> lkp to test your vlag fix patch set.

Yes, maybe you can see more information by adding log in place_entity().

BR

>
> > >
> > > The proper fix should deal with the overflow of entity_key() * load, =
but
> > > I don't have much clue on that, so propose this conservative method t=
o
> > > restore the previous behavior before the mentioned commit.
> > >
> > > Fixes: 2227a957e1d5 ("sched/eevdf: Sort the rbtree by virtual deadlin=
e")
> > > Reported-by: kernel test robot <oliver.sang@intel.com>
> > > Closes: https://lore.kernel.org/lkml/202401301012.2ed95df0-oliver.san=
g@intel.com/
> > > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> > > ---
> > >  kernel/sched/fair.c | 13 ++++++++++++-
> > >  1 file changed, 12 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index 533547e3c90a..fb9202f464e2 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -880,7 +880,7 @@ static struct sched_entity *pick_eevdf(struct cfs=
_rq *cfs_rq)
> > >         struct rb_node *node =3D cfs_rq->tasks_timeline.rb_root.rb_no=
de;
> > >         struct sched_entity *se =3D __pick_first_entity(cfs_rq);
> > >         struct sched_entity *curr =3D cfs_rq->curr;
> > > -       struct sched_entity *best =3D NULL;
> > > +       struct sched_entity *best =3D NULL, *leftmost;
> > >
> > >         /*
> > >          * We can safely skip eligibility check if there is only one =
entity
> > > @@ -905,6 +905,8 @@ static struct sched_entity *pick_eevdf(struct cfs=
_rq *cfs_rq)
> > >                 goto found;
> > >         }
> > >
> > > +       leftmost =3D se;
> > > +
> >
> > Maybe judging which of the deadlines of curr and se is smaller is bette=
r?
> >
>
> Yes it is donable. When the NULL pointer exception happens, the deadline =
of
> current is very large(nearly u64 overflow), we might always choose se
> if we compare them.
>
> thanks,
> Chenyu

--
xuewen

