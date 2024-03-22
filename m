Return-Path: <linux-kernel+bounces-111461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC23886CB0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C6931C2148B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 13:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB95E46542;
	Fri, 22 Mar 2024 13:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A1YrjZ6q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0020C46521
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 13:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711113607; cv=none; b=IQAm9Kn/IIYRTQm7QK5UFEfBBF8sMwIHZHWAdvf0E6rm3Du6jcbcL924u1DR8Br1EP9k5Nlg457GwGjo73KbdEXoMQTtXEpHe7+wKCFMCeuGroYBwR7D7GaSgQTwngVzv/1hXj9cxs9TPBTtz3yVuGBXz0IZX+AyX9yeMPZNN64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711113607; c=relaxed/simple;
	bh=prvrAvxH2CImXFxyQ5e6hd6neKkkvJjK1A/VThwiIyE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zmo7GCGxfABFP+0REFyvFJBAUs/Cov8tCCqqxedAFLLScVgQz0qVY/rMUjXzbhf4mURA1Y1kkPPwCmTw7hLvqDrcZ7wNKhF0kN2QKD/VdvydQWGzFlXyb2MP8g0lK5D8TqJK/3KoVxz94nfHGgNgJEoDcRtX0e+C1p+BuiotRpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A1YrjZ6q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8E5EC433B2
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 13:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711113606;
	bh=prvrAvxH2CImXFxyQ5e6hd6neKkkvJjK1A/VThwiIyE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=A1YrjZ6quDkuYk2hBCU6LJgd4xlX3NeLB45WRL3HJAC88Xd63GtkIjU5lhmIifjyQ
	 ys2MYtHvDInEOuHVRnNedSGnvof/BtYbX1We9nkadEOkRDSUop93Z7r4BvVrEnlFb9
	 wlt7B4kuitxwkWXQNE7VmRmtpkDDuxy5EOwez5tb+XXjbVR3Co7qx8TShH2A7WFgnZ
	 slwceEenxxaVqmQB1Jj2LvrFtDJ0LxqABg0HQ6DzXe7SQ5MbLy2u+w9l2+7SE5fZMU
	 GZayiLo8pXr5mJUeCpTY57GHAKPca/4RovQuQrbrcQdP9roiRhQZaQlNx72wzrlIUW
	 kYGaC6FFSLWdQ==
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-366bc265e58so7764645ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 06:20:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXtxze9GI72C5/tQ/6ZZb9sbbsntxzkKsWk/iLGDjwZyf9yaYzD0sqOhfW+ekh2OCPPCH0As3bRluzAhKtori6w2Ds76sDFSj9PlpMx
X-Gm-Message-State: AOJu0YxfjqQQTrPLNzpzELPUppZ0UDTz5pWWSe3PxwWcNbBjKO27ey2J
	GUqRCop4AGWOhII9rZ+9VzC0OkS/32ya1bOISY573DzpSGetTdIOeAX7llv2frt2jRZoA/xycde
	07G1r7JcsSWMf9EWbw3fmvfHrIVyqMABwF75P
X-Google-Smtp-Source: AGHT+IGB2R6wow2zgHKtqMYRQUOZXQD3hm7dQSeNn7YINb3EJhIs4lc91U2CA2bP5HCcYQXPXPtxXwEtC2bpxLD6fkY=
X-Received: by 2002:a92:4a0e:0:b0:366:bcbd:ed84 with SMTP id
 m14-20020a924a0e000000b00366bcbded84mr2669991ilf.15.1711113605975; Fri, 22
 Mar 2024 06:20:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311150058.1122862-1-ryan.roberts@arm.com>
 <20240311150058.1122862-5-ryan.roberts@arm.com> <87jzm751n3.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <d6ac1097-2ca3-4e6d-902d-1b942cacf0fb@arm.com> <8734skryev.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <b22a222b-7fd8-4648-84a7-21d35f529f27@arm.com> <87r0g3q9cz.fsf_-_@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87r0g3q9cz.fsf_-_@yhuang6-desk2.ccr.corp.intel.com>
From: Chris Li <chrisl@kernel.org>
Date: Fri, 22 Mar 2024 06:19:52 -0700
X-Gmail-Original-Message-ID: <CAF8kJuOLUnEuQjOnHiEeN3a__60Op=eBRHu9pzKHe60iLKi-KA@mail.gmail.com>
Message-ID: <CAF8kJuOLUnEuQjOnHiEeN3a__60Op=eBRHu9pzKHe60iLKi-KA@mail.gmail.com>
Subject: Re: Can you help us on memory barrier usage? (was Re: [PATCH v4 4/6]
 mm: swap: Allow storage of all mTHP orders)
To: "Huang, Ying" <ying.huang@intel.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Matthew Wilcox <willy@infradead.org>, Gao Xiang <xiang@kernel.org>, Yu Zhao <yuzhao@google.com>, 
	Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, Barry Song <21cnbao@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ying,

Very interesting question.

On Thu, Mar 21, 2024 at 7:40=E2=80=AFPM Huang, Ying <ying.huang@intel.com> =
wrote:
>
> Hi, Paul,
>
> Can you help us on WRITE_ONCE()/READ_ONCE()/barrier() usage as follows?
> For some example kernel code as follows,
>
> "
> unsigned char x[16];
>
> void writer(void)
> {
>         memset(x, 1, sizeof(x));
>         /* To make memset() take effect ASAP */
>         barrier();
> }
>
> unsigned char reader(int n)
> {
>         return READ_ONCE(x[n]);
> }
> "
>
> where, writer() and reader() may be called on 2 CPUs without any lock.
> It's acceptable for reader() to read the written value a little later.

I am trying to see if your program can convert into a litmus test so
the linux memory model tools can answer it for you.
Because you allow reader() to read written value a little later, there
is nothing the test can verify against. The reader can see both before
or after the writer's update, both are valid observations.

To make your test example more complete, you need the reader/writer to
do more actions to expose the race. For example, " if (READ_ONCE(x[n])
y =3D 1;"  Then you can ask the question whether it is possible to
observe x[n] =3D=3D 0 and y=3D=3D 1. That might not be the test condition y=
ou
have in mind, you can get the idea.

We want to have a test example that shows the result observable state
to indicate the bad things did happen(or not possible).

> Our questions are,
>
> 1. because it's impossible for accessing "unsigned char" to cause
> tearing.  So, WRITE_ONCE()/READ_ONCE()/barrier() isn't necessary for
> correctness, right?

We need to define what is the expected behavior outcome to be
"correct", possibly including the before and after barrier actions.

Chris

>
> 2. we use barrier() and READ_ONCE() in writer() and reader(), because we
> want to make writing take effect ASAP.  Is it a good practice?  Or it's
> a micro-optimization that should be avoided?
>
> --
> Best Regards,
> Huang, Ying
>

