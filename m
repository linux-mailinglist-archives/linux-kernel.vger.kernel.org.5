Return-Path: <linux-kernel+bounces-153261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2098A8ACBA3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4F0D1F239C6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 11:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48AC5146012;
	Mon, 22 Apr 2024 11:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cEdrstWI"
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C87014600B
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 11:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713784058; cv=none; b=eY/uL9w/mUPGEYSRd8ZGyIjB4bl4VtId1t4m835kQ9xoa7IW9MAdCXHh5MvMnY62BMK1X2u0JkjWDvAYKPRaSqSANrSeqH2NTm8AJf8gkGRAAsG2Ym64zjSt0CFhup8YSzERocUjtiMdUYckKae/eqyAXE5585JmvBTLP7tEvDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713784058; c=relaxed/simple;
	bh=X7zGnsNLrQuP7nYlXlYVVCmr9CGkehAVy8UcOaw88/8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cr/BTBTMBitpd2hE/A96DMODC22nRlIuWm87cCpucAToAVhazCTvrT/lG9y4XNeJ1DGd7VakjJfoRzpTAFOylFrFHJ6QOHPD3TVkkC05UNUr7K6ubiycFcAgicBI3UTYXqfXHunUdFX37yq727NIDIPaDVQR+B3oePEw5sVEDzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cEdrstWI; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-23319017c4cso2845729fac.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 04:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713784056; x=1714388856; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X7zGnsNLrQuP7nYlXlYVVCmr9CGkehAVy8UcOaw88/8=;
        b=cEdrstWIq0VDYsFrAYNuMwleYyd9tCDqDS1IZDkxD5I+zPJ2FPZP4RpPaB/Bo/3w/j
         ek4B3OzkrxkS9ETqsB4tXsGvY3LRoADCRsOEFLoTFetNn9tY5NyvvTd+wZf7XV/3GJfB
         Y6JtfpDLPYN1aeCD2k+pKMfQUaJJ4N5TV9qpYEW13qEfTR6JfSbz1bj+S6cUDd0eswJQ
         Yw8Dgm4sC2DYsB2W9ty80yiP5D5mi4NsrZX+SOgvunhFKNdd/qkkczpa01ZhvH+bu0N6
         SHY6LvH87P6sni6zlDIxBUE6AU0mcKXbUVNuju8/Gwtz+Uj5E7Iwio0RnxEpccP24OvA
         Fp7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713784056; x=1714388856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X7zGnsNLrQuP7nYlXlYVVCmr9CGkehAVy8UcOaw88/8=;
        b=C8biaXX3YalRXktSIla8YRPn7e9uHJ8HVzELjHAUknChpN4q2XNO2WeJ1aVuz20/Gi
         koDfXFPwAlIGyNb8i5PEWFYOTOQRLmCElR4gNi/b/nWJDYAsNaALxaKAjz55V8aJ5rPb
         cecXv6oBm4NoWYTnHYPPFNpY+Pj5FAyyAgowHutL636+yPihRpCb3+ZPlYQjWmtdj3rN
         Jtw3RC+noyZWFAW2pqDdSOdKoRrc1HamNYHb1+MDBdRq07goovkjK6wJS6ckpBwMIrfn
         5k97ygGJKK0ytkA51qUFpgBXgrKId5cffzjjLU088pG9d3qLPwmx/5rKKdtGeUoFwUvb
         M/wQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDVNB7c/BOIbuzLsdXPMX9dNRTb3QDKDwgKZbUWoE7NMZYM6qMgrvkwKCPWlBpPRtaSzNiqjErVFFOPaCTlXIBf+URS58nYiwDteeI
X-Gm-Message-State: AOJu0YxizdDqia7SF7By6Xz/TBVW5c1rMUXWGcBQtlbrkQ0kd8q0loM/
	0+kNFoaKU5gA0VHlb3OKUtFMc5GHiz65mcBaAbdbeGKxcrgjvs6q0gBv4zcS9X3X8qPpfWLA7rj
	NELsPuSjeY+Ff9PKW3WA+7z6ba5Y=
X-Google-Smtp-Source: AGHT+IF82a7Paz+bdskoT43coWi3SeLdmaFTwxYKXDkAd1w4YwPB0u8PnY5t8UJo5ZP+IQmRDWvGCwKsvapYjSdWcwY=
X-Received: by 2002:a05:6870:a3d1:b0:22e:dfd0:9a4f with SMTP id
 h17-20020a056870a3d100b0022edfd09a4fmr12341353oak.24.1713784056423; Mon, 22
 Apr 2024 04:07:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422082238.5784-1-xuewen.yan@unisoc.com> <CAB8ipk-LhSuMsp0DdzjEJN-4XEBT1_ri6BPH_nvxSgFZONMT2Q@mail.gmail.com>
 <20240422094157.GA34453@noisy.programming.kicks-ass.net>
In-Reply-To: <20240422094157.GA34453@noisy.programming.kicks-ass.net>
From: Xuewen Yan <xuewen.yan94@gmail.com>
Date: Mon, 22 Apr 2024 19:07:25 +0800
Message-ID: <CAB8ipk9M1wLXV7MWMBYGMhKbY71QqwkvchiENeWTg7JERe6kZw@mail.gmail.com>
Subject: Re: [PATCH v2] sched/eevdf: Prevent vlag from going out of bounds
 when reweight_eevdf
To: Peter Zijlstra <peterz@infradead.org>
Cc: Xuewen Yan <xuewen.yan@unisoc.com>, mingo@redhat.com, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com, 
	yu.c.chen@intel.com, ke.wang@unisoc.com, di.shen@unisoc.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 5:42=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Mon, Apr 22, 2024 at 04:33:37PM +0800, Xuewen Yan wrote:
>
> > On the Android system, the nice value of a task will change very
> > frequently. The limit can also be exceeded.
> > Maybe the !on_rq case is still necessary.
> > So I'm planning to propose another patch for !on_rq case later after
> > careful testing locally.
>
> So the scaling is: vlag =3D vlag * old_Weight / weight
>
> But given that integer devision is truncating, you could expect repeated
> application of such scaling would eventually decrease the vlag instead
> of grow it.
>
> Is there perhaps an invocation of reweight_task() missing? Looking at

Is it necessary to add reweight_task in the prio_changed_fair()?

> set_load_weight() I'm suspicious of the task_has_idle_policy() case.

