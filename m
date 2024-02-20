Return-Path: <linux-kernel+bounces-72335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D30485B220
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 06:10:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8390282117
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 05:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2F356760;
	Tue, 20 Feb 2024 05:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s1bSu8xA"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D83055E56
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 05:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708405819; cv=none; b=ah7UZMF1esv7xjq+c8zNfg4gc4wqvkZ2PoeodXXFExr04t/NlY3g2MjKC1Rr4CV6YZaj6mOo/GFT9m0k0A6xmmzKr+2nARMa+2qT4r/Wg3J/9Dya6I7SnPKd9Yh2DyDX7i7wgBeNDOugr9HbmCDzRJ5/O0H4M5H99Y6E19kPQiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708405819; c=relaxed/simple;
	bh=V8GgnQehLYc2k+M0VZUA6t5uZXuBt3AHWfO3bV+AkqA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=m6iLLfljt0nV8kRv1+B48mJvpIV+89l0dYkm69WziVeG/yrdWvB7xob10NanbMFNzMPJxf//QOeM1m8YfPONFZkXIiCD+m0JR5TFWqwNX6UUV0Hcped+PNhcGvprBpUxmF9rdltkzX0FrJGc+NBp0Y0EwbmZISgcDsCpPYnkBrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s1bSu8xA; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-607fc3e69adso39543357b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 21:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708405816; x=1709010616; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IgyfdjCU+hZCcbLLD6KYpoV/bfbjieZdWhMNZ1uBaPU=;
        b=s1bSu8xAuTuQ9sZkJw956yKIlZUqIXQ78cL568qnpl4a/EfLNiwLy7eZ2oilQzFq/s
         YCXfOTGIid9MG3l5ppg1Wje+29O+LQGCgRH2ABGOVSGXoYGvmnY+rMlltkvWTmypldH+
         VovFkEUN+JpOlGVmbYyYF9s4Ua2fM4lRddX+l+e/PSsJsHSYHIMk21kIgWdOgutrCNZP
         4KMftRBcK3zUcPBcroHHMlE1mGGB6JcJ0FEEoZJdSHxcbiyF7aCUnysIZJYL1N6WGtEw
         3pv2XCze6gwSPsNkap2qsrtPc8C0sXr/R7/toKWyf0mTOdJ2/tNdkEQpP0ybwhgtPcLM
         I3DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708405816; x=1709010616;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IgyfdjCU+hZCcbLLD6KYpoV/bfbjieZdWhMNZ1uBaPU=;
        b=jMvCr3rQwsdDsf7KuW6VqBNt0WKwwlipJTpPGJOvw6R+40tAYoXvtzf7bFYgccPzxz
         izBP8HwIipmYC3/wJSMPGRn7JGQ8dxt2w4eyqORtDA0mc7ET7wHuP7jUQPbSUp7+0lBO
         7wls6BGC2RnAhCygLqVrg7BFAU0OgiIVWj1ee5IrU9Dm5aO3A/8EyJ7yiYx+k3P7nbl/
         ewOGsyazpSbRAamRSUp858ThO1nRdze5fjRzY/bOxYX0R5c6Hc7JPeIhAISBkZh4pR4k
         +rwLh8wvRGBYq8bn9J2uR7JzilHHxCYwsynw0e0HzkBF/RJLetMNKksjUpe+h9Vfscko
         WwPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgNah22luj6PsvClIBc2B2O5wpJIH9/oZyvJQbb4/8Di6s56pDCJV/3HeI1mrJ5N0uP9nhSstMFw55/cPbZ/OG00r4pzeHbH+1mj8P
X-Gm-Message-State: AOJu0YzXmnL8VtBk/AqjFZy+61outCHV/c9GJzQdgNepWEp08FKTTg5G
	UP6pJ7nZsrti3icY6vaM/5YJmIp6T5kSLMQRwLyxvSZOCv+ffeBYXHI37QyIww==
X-Google-Smtp-Source: AGHT+IG7BwM7vxRSUewnnRf0BMipko/Du7E1sEN5r/nlk7GYRj97y1scNbrhkgcW7UvpbKb7YyKbBw==
X-Received: by 2002:a81:6946:0:b0:607:805a:6da4 with SMTP id e67-20020a816946000000b00607805a6da4mr15686343ywc.2.1708405816108;
        Mon, 19 Feb 2024 21:10:16 -0800 (PST)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id d85-20020a814f58000000b0060851394832sm445379ywb.90.2024.02.19.21.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 21:10:15 -0800 (PST)
Date: Mon, 19 Feb 2024 21:10:13 -0800 (PST)
From: Hugh Dickins <hughd@google.com>
To: Charan Teja Kalla <quic_charante@quicinc.com>
cc: Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
    willy@infradead.org, rientjes@google.com, surenb@google.com, 
    fvdl@google.com, quic_pkondeti@quicinc.com, linux-mm@kvack.org, 
    linux-kernel@vger.kernel.org, Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH V7 2/2] mm: shmem: implement POSIX_FADV_[WILL|DONT]NEED
 for shmem
In-Reply-To: <64ed46f4-459c-63b0-a69e-81353e9fcbc9@quicinc.com>
Message-ID: <c3e3117d-e752-9a34-0000-05811c7327e2@google.com>
References: <cover.1676378702.git.quic_charante@quicinc.com> <631e42b6dffdcc4b4b24f5be715c37f78bf903db.1676378702.git.quic_charante@quicinc.com> <2d56e1dd-68b5-c99e-522f-f8dadf6ad69e@google.com> <eeeba374-9247-96fd-c9f5-8cba8761f1b9@quicinc.com>
 <aa4352d8-a549-32e5-874f-1cfee2a5b3e@google.com> <e8e85d7d-edf1-7a8b-8cfe-9976dd9cfb0b@quicinc.com> <64ed46f4-459c-63b0-a69e-81353e9fcbc9@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463762175-1004148714-1708405815=:18844"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463762175-1004148714-1708405815=:18844
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 14 Feb 2024, Charan Teja Kalla wrote:

> Hello Hugh,
>=20
> Based on offline discussion with some folks in the list, it seems that
> this syscall can be helpful. This patch might have forgotten and I hope
> this ping helps in resurrecting this thread.

Charan, it's not forgotten, but it was relayed to you through another
channel a month ago, that I did not expect to have time to think about
this for 3 months.  Countdown says 2 months to go now.

I realize that it's frustrating for you; it's unpleasant for me too.

>=20
> On 5/18/2023 6:16 PM, Charan Teja Kalla wrote:
> > On 5/17/2023 5:02 PM, Hugh Dickins wrote:
> >>> Sure, will include those range calculations for shmem pages too.
> >> Oh, I forgot this issue, you would have liked me to look at V8 by now,
> >> to see whether I agree with your resolution there.  Sorry, no, I've
> >> not been able to divert my concentration to it yet.
> >>
> >> And it's quite likely that I shall disagree, because I've a history of
> >> disagreeing even with myself on such range widening/narrowing issues -
> >> reconciling conflicting precedents is difficult =F0=9F=99=81
> >>
> > If you can at least help by commenting which part of the patch you
> > disagree with, I can try hard to convince you there:) .
> >=20
> >>> Please let me know if I'm missing something where I should be countin=
g
> >>> these as NR_ISOLATED.
> >> Please grep for NR_ISOLATED, to see where and how they get manipulated
> >> already, and follow the existing examples.  The case that sticks in my
> >> mind is in mm/mempolicy.c, where the migrate_pages() syscall can build
> >> up a gigantic quantity of transiently isolated pages: your syscall can
> >> do the same, so should account for itself in the same way.
>=20
> Based on the grep, it seems almost all the call stacks that isolates the
> folios is for migrating the pages where after migration the NR_ISOLATED
> is decremented (in migrate_folio_done()). The call paths are(compaction,
> memory hotplug, mempolicy).
>=20
> The another call path is reclaim where we isolate 'nr' pages belongs to
> a pgdat, account/unaccount them in NR_ISOLATED across the reclaim.
>=20
> I think it is easy to account for the above call paths as we know "which
> folio corresponds to which pgdat".
>=20
> Where as in this patch, we are isolating a set of folios(can corresponds
> to different nodes) and relying on the reclaim_pages() to do the swap
> out. It is straightforward to account NR_ISOLATED while isolating, but
> it requires unaccounting changes in the shrink_folio_list() where folio
> is being freed after swap out.  Doing so requires changes in all the
> code places(eg: shrink_inactive_list()), where it now requires to
> account NR_ISOLATED while isolating and the shrink_folio_list()
> unaccounts it.
>=20
> So, accounting NR_ISOLATED requires changes in other code places where
> this patch has not touched.

That surprises me, though I do recall that there's an irritating
asymmetry in where NR_ISOLATED is accounted and unaccounted.
I have not checked what you say there, may do so in 2 months.

>=20
> If isolating a large amount of pages and not being recorded in
> NR_ISOLATED is really a problem, then may I please know your opinion on
> isolating(with out accounting) and reclaiming in small batches? The
> batch size can be considered as SWAP_CLUSTER_MAX of pages.

In most circumstances, omitting to account NR_ISOLATED wouldn't show
up as a problem; in low memory it would.  Splitting into small batches
without accounting might be an easier and better way; but whatever I
say in a hurried unthoughtful reply is likely to be wrong.

I am not convinced that isolating is even appropriate: I think I
hinted before that I would want to compare what you do here with what
shmem_swapin_range() does in mm/madvise.c, and the shmem_collapse_swapin()
I'll be proposing to avoid swapin while building up THP in collapse_file().

But it may well be that you've found the switching of LRUs essential:
I'm not prejudging, just saying I cannot rush to judgment.  And this
is also a new UAPI for tmpfs, so should not be rushed then regretted.

But if you can find another champion to force this into mm/shmem.c
for you faster than I can manage, well, I don't own any Linux source.
It's not unusual for me to limp along later and rearrange things to
suit my preference.

Hugh

>=20
> > I had a V8 posted without this into accounting. Let me make the changes
> > to account for the NR_ISOLATED too.
>=20
> Thanks,
> Charan
---1463762175-1004148714-1708405815=:18844--

