Return-Path: <linux-kernel+bounces-126411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD1D8936ED
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 04:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 333AC28121D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 02:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363EB1FAA;
	Mon,  1 Apr 2024 02:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="NGJC7Tvj"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00914137E
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 02:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711938492; cv=none; b=D2aCcVGKPh/U+mNvVfzoKiVsTbXnNdfTJTCnSmftafX1pEK4Ah939TkLPnMarCYJR6RBsO1ahsbwFEF2lW7o5FpLmnN0JIAkEdw5qNIvVwN0Rtlp0vJPsc+R2BoFImMPrNz8BAj8XeI97dpt5240a7b6JmpV8yeQbyeOVji+h6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711938492; c=relaxed/simple;
	bh=LfhO/ttDrHhRYeW84ygSeWSEB8losPLPFBPFAJz+dqo=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=fjOPQxefTQH9lyMPVqIEDiWMDfjPe7wPCP2gCIKuTVUc6M7i73RonXX42uVEZIh/ws0wj0CKIXSDOMfw6VCBxSOmjdlgQ922S7t9S1IDERV3zW2/CK3bO+LmolvvlHBbJL+kqNTf3u7rGs+YpZ839GKWTB//QNQfm3wutsBfFT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=NGJC7Tvj; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6eafbcc5392so927680b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 19:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1711938490; x=1712543290; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LfhO/ttDrHhRYeW84ygSeWSEB8losPLPFBPFAJz+dqo=;
        b=NGJC7TvjkbbUANZ68vwWACYvXSzt19xDrG1EtWchEK+0EY8D3h3IaJH0C/KTiu5W4l
         ihqf4CHw49NrT103cuDil55C/J8q3Oxb/npu4Hf82NIAKE2OWCqjPSHb7bDo24Xw+CT/
         JC0Tj5+IAusX1ZHMkYkGr1+pHmo/XvO/rKvZ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711938490; x=1712543290;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LfhO/ttDrHhRYeW84ygSeWSEB8losPLPFBPFAJz+dqo=;
        b=JjmbZR8TFCC3eVRJlOZtg9bFW14AM3ha6AUiQ7zKNaFHi8mBxA5F8cTkkw5O62YFxK
         nDuUM7XxtnoIQsqy+6xp4D5VJ+0FG5K9uikI512ZHC7jAAyHO5Noq/6A47fdAB+nQcz3
         IKloLfbTW5re39GLhY4y98Z95Dkypmtp+bKmutfYvJFcJc2z5CTsaGs3QXjDP+E08CLb
         yNbqevMoiGRbrG52FbeSJVO/FjwnK/sFdAzHYZcMTdv9rjHWHoo/njQKtM3wgd5Cw37s
         H+sty3X17uZ/i0WIb368d602PXy/1NK4Wy0zzYX8uqVodTH5//qlUIS4PmsnZRJzVW0c
         mdbA==
X-Gm-Message-State: AOJu0Yz52tzabmQeFfrKNtamNt/VveXrRwgWykNCplHkdo1zmHKDTXk1
	lok4D1x5PS+zJq5Lj7JK2dFuXrVgl1vihbAyZaQqLJrUlP2Bk/wKx5dAFYC01Uo=
X-Google-Smtp-Source: AGHT+IEo7v0nQkkhmt17kaM/JYiwK7RoHw0U7Q9CpORk17x7Qn038TFiQedTaFsGabLvfukwIBvJPA==
X-Received: by 2002:a05:6a20:ea8:b0:1a3:a092:5746 with SMTP id fk40-20020a056a200ea800b001a3a0925746mr5387679pzb.50.1711938489912;
        Sun, 31 Mar 2024 19:28:09 -0700 (PDT)
Received: from smtpclient.apple ([103.98.78.155])
        by smtp.gmail.com with ESMTPSA id bi8-20020a170902bf0800b001e0b2851db7sm7592434plb.105.2024.03.31.19.28.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Mar 2024 19:28:09 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Joel Fernandes <joel@joelfernandes.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 02/10] rcu: Move rcu_preempt_depth_set() to rcupdate.h
Date: Mon, 1 Apr 2024 07:57:56 +0530
Message-Id: <B89CA77D-2E7C-4AE7-B4AA-06BF681A983A@joelfernandes.org>
References: <CAJhGHyDjoQ3TrApksYJ5o1ooU4s8rzys2UnfF6EFzGwkaSVaKA@mail.gmail.com>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org, x86@kernel.org,
 Lai Jiangshan <jiangshan.ljs@antgroup.com>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <quic_neeraju@quicinc.com>,
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Zqiang <qiang.zhang1211@gmail.com>
In-Reply-To: <CAJhGHyDjoQ3TrApksYJ5o1ooU4s8rzys2UnfF6EFzGwkaSVaKA@mail.gmail.com>
To: Lai Jiangshan <jiangshanlai@gmail.com>
X-Mailer: iPhone Mail (21D61)



> On Mar 31, 2024, at 9:46=E2=80=AFPM, Lai Jiangshan <jiangshanlai@gmail.com=
> wrote:
>=20
> =EF=BB=BFOn Sun, Mar 31, 2024 at 7:10=E2=80=AFPM Joel Fernandes <joel@joel=
fernandes.org> wrote:
>>=20
>>=20
>>=20
>>>> On Mar 28, 2024, at 1:20=E2=80=AFPM, Lai Jiangshan <jiangshanlai@gmail.=
com> wrote:
>>>=20
>>> =EF=BB=BFFrom: Lai Jiangshan <jiangshan.ljs@antgroup.com>
>>>=20
>>> Prepare for arch-specific-defined rcu_preempt_depth_set().
>>>=20
>>> No functionality change intended, but it has to be defined as a macro
>>> as rcupdate.h is a very low level header included from areas that don't
>>> even know about the task struct "current".
>>=20
>> Sorry I did not follow changelog. If some rcupdate.h includers do not kno=
w
>> about task_struct, how does adding a macro that uses current help?
>>=20
>=20
> Hello
>=20
> This is how macro works and it expands blindly based on tokens on the
> usage-sites.
>=20
> And rcu_preempt_depth() & rcu_preempt_depth_set() are not universally
> used wrappers, the user can simply also include linux/sched.h to make
> they work.

Oh I see, so by hiding it in a macro, the code remains unexpanded. That make=
s sense..

Thanks.





>=20
> Thanks
> Lai

