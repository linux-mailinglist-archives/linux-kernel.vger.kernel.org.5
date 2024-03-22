Return-Path: <linux-kernel+bounces-110840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F08F88649E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 02:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1031284DAE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 01:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7EE138E;
	Fri, 22 Mar 2024 01:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aeLo/4sk"
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4AB818
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 01:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711070766; cv=none; b=Y5Kk3Y01KgiYU/pyamlz1mwrT5BfWpRvPK8He4MwgjBB/3uhkd2Rq0QvY2vOeNSexIhHtKD37DsclR8q7md7XfYAA7gJ+Lq33OHfe58h/tDjp4aQFjmHj9O8dCvqheMaU/0aSi6rFM4G6aCxeX2NXKzfnaBkjcrF2T00ne2x5r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711070766; c=relaxed/simple;
	bh=sUVutNDgGpGxD172o8zGQS5BMUM10LcVdWVgTqQZdQA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XRN8QGdmUe74W1HRvAXCJRs7TUGc9iGWQVFp7WEXUVoonuwA76WvtOhYKYa3d2tHYpSRnOur4w8OBEbAQAbCQoBrStBZpP0hccDm3Znd/yi89aB+6AubKYGlpw4fRKLW1bOjB3OfLSmI3FmKiRru08htg6scrJdvLSQndkEeLdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aeLo/4sk; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-7e07aabfd87so906973241.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 18:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711070764; x=1711675564; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DnrA7VCP2UghSQHIHzERUpi2aY63j1gM5buPqEdAsC0=;
        b=aeLo/4skA+jJ8SZmW7Ppwtd89e44Gz5zU+UX3gcEUq2dE4ZMXslnPOgiNSbnp6G2E3
         ww9BUnM16KZVlyp894CfmzRd8OtQxPdLiCEQsimRFryUCkMTfG6ppWWC5C62iRisxiCm
         uR8MHONo9vzynrwqeeCPzGN0oGHaKvp31Wc7lnJ/v2zOKVWuOk5Csi6xxYIlMkSupJQz
         i/qD0LqsYqr6LxMnB69vZ6vK8I5PhRMWxELoyVPgd8aov5494H2DBLfv4RqA49GYWcIH
         9KGnhaapQ3M7cHc2yKD69YhenutmbNrTPYvA2ab8U9+8dYki/Xv88+Eoq9OXct4XXj6v
         ftJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711070764; x=1711675564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DnrA7VCP2UghSQHIHzERUpi2aY63j1gM5buPqEdAsC0=;
        b=ZuWdxXQ1ZsHvwvZL2fRLrzw2SE+YS008Xd2sbzngFrYlXu7jxQX1TCiovP/X6EdZM+
         V564MWOpfgFdDlac47h1LmMZX5zkJYiD5nM9su+tkr343NJLVL4salx7Qc5hHu/0V6wv
         ml6AmBN+UhCAwR8KH/gbcamucZbCVbPoVc7gopERUk5NhoLgmbbMVYSZlYeUv+xVhsVR
         tsKmX+j2/3l4BTXJ38Zk43yDpwvdP89KPXUYtV/fOxnTbbrZKxiqmDNKtly6qJJ3flBA
         tyex+2/e0LmHgSOsxlQCGkfNhzaXy92DlBD7QMRM7woQOGpJaBCfDsHpKLa87tSwbxmN
         XWgg==
X-Forwarded-Encrypted: i=1; AJvYcCUO81RFk7CkRWrSmzqQ8t7ovAwyhuv2ztKtXDd0ooi18n/ZsVUIE1l/yIZpbQNMhI21R+CpHN8/Fct8rjfH5zJ0AgcRojzR/MvQN08Q
X-Gm-Message-State: AOJu0YzzCu8czAIykr81NmZCD0HCCkdvlhUGMD5Q2fpp1cI8uutU7XTp
	gHXvKYFHJpJnAqaz6EjvBmeXYverUeG8FWU7ZI5ghl44faRyTX/yVLsETe9zqr/lCT0Jjape0ju
	rJSlenpOzmdgjbG8nG+lBEB9FVrx2RjLObzbfwA==
X-Google-Smtp-Source: AGHT+IEX3LGVYC4fhTEF6otGyeJAhOWJOQ4fPtLG/kizcg2xXDVzlPfBIxephr3HBjwl6XPh7D3ehuvyP21vvXMlokI=
X-Received: by 2002:a05:6102:2c6:b0:476:70e3:98ba with SMTP id
 h6-20020a05610202c600b0047670e398bamr383936vsh.9.1711070764109; Thu, 21 Mar
 2024 18:26:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240314141516.31747-1-liuhailong@oppo.com> <20240315081803.2223-1-liuhailong@oppo.com>
 <ZflTCY-Oaxm0U70u@tiehlicka> <CAGsJ_4w0EHuAwvSFuqUsMO-bLjJwCmN_qjL6NuA043-4rgfgsQ@mail.gmail.com>
 <fdc90410-5698-4cda-a7c2-952480c7e7e6@oppo.com>
In-Reply-To: <fdc90410-5698-4cda-a7c2-952480c7e7e6@oppo.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 22 Mar 2024 14:25:52 +1300
Message-ID: <CAGsJ_4xDTS9_NPzKnqZ1vJk2egLVCSSvCbub3oRX8k9MHQFXLg@mail.gmail.com>
Subject: Re: [PATCH v2] Revert "mm: skip CMA pages when they are not available"
To: =?UTF-8?B?5YiY5rW36b6ZKExhb0xpdSk=?= <liuhailong@oppo.com>
Cc: Michal Hocko <mhocko@suse.com>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "nathan@kernel.org" <nathan@kernel.org>, 
	"ndesaulniers@google.com" <ndesaulniers@google.com>, "trix@redhat.com" <trix@redhat.com>, 
	"linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"llvm@lists.linux.dev" <llvm@lists.linux.dev>, "surenb@google.com" <surenb@google.com>, 
	"zhaoyang.huang@unisoc.com" <zhaoyang.huang@unisoc.com>, 
	"quic_charante@quicinc.com" <quic_charante@quicinc.com>, "yuzhao@google.com" <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 1:27=E2=80=AFAM =E5=88=98=E6=B5=B7=E9=BE=99(LaoLiu)=
 <liuhailong@oppo.com> wrote:
>
> On 2024/3/19 19:09, Barry Song wrote:
> > On Tue, Mar 19, 2024 at 4:56=E2=80=AFPM Michal Hocko <mhocko@suse.com> =
wrote:
> >>
> >> On Fri 15-03-24 16:18:03, liuhailong@oppo.com wrote:
> >>> From: "Hailong.Liu" <liuhailong@oppo.com>
> >>>
> >>> This reverts
> >>> commit b7108d66318a ("Multi-gen LRU: skip CMA pages when they are not=
 eligible")
> >>> commit 5da226dbfce3 ("mm: skip CMA pages when they are not available"=
)
> >>>
> >>> skip_cma may cause system not responding. if cma pages is large in lr=
u_list
> >>> and system is in lowmemory, many tasks would direct reclaim and waste
> >>> cpu time to isolate_lru_pages and return.
> >>>
> >>> Test this patch on android-5.15 8G device
> >>> reproducer:
> >>> - cma_declare_contiguous 3G pages
> >>> - set /proc/sys/vm/swappiness 0 to enable direct_reclaim reclaim file
> >>>   only.
> >>> - run a memleak process in userspace
> >>
> >> Does this represent a sane configuration? CMA memory is unusable for
> >> kernel allocations and memleak process is also hard to reclaim due to
> >> swap suppression. Isn't such a system doomed to struggle to reclaim an=
y
> >> memory?
> Yes, All processes in the system are also hard to reclaim. and all proces=
ses
> enter direct reclaim. with this patch, much of process which should skip_=
cma
> would retry, scan, skipped in the process of isolsate_lru_pages. and syst=
em
> process will have high priority, some normal processes (like kswapd) are
> preempted.
>
>
> Btw. how does the same setup behave with the regular LRU
> >> implementation? My guess would be that it would struggle as well.
> >
> > I assume the regular LRU implementation you are talking about is the LR=
U
> > without skip_cma()?
> >
> > I remember Hailong mentioned something like " it also trigger memory ps=
i
> > event to allow admin do something to release memory" and " without
> > patch the devices would kill camera process".  So it seems the differen=
ce
> > is if a killing will occur.
> >
> > Hailong, would you like to provide more detail?
>
> psi_event triggered after psi_memstall_leave. much system processes
> perform_reclaim scan and skipped and leave without reclaim any pages.
> the process is fast, so lmkd (userspace lowmemory killer) could not work
> as before.

Can you provide more details?

Does PSI still give accurate reports when processes are stuck in an idle lo=
op
because most pages in the LRU list are in CMA? Also, in such a case, will
the LMKD not receive CPU resources to execute?

>
> >
> >> --
> >> Michal Hocko
> >> SUSE Labs
> >>
>

