Return-Path: <linux-kernel+bounces-43958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 868C6841B9C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 06:55:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4299328A6AE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 05:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7217381C5;
	Tue, 30 Jan 2024 05:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k4kmbGct"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC9732186
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 05:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706594140; cv=none; b=c0IMkXzvd5KtuZu5tbII28sJsBvzM8N9LbWAUTDrxJJNIsetQpoJhUjGsWCOmy5e9O65u86YS34tvWqhojIjoJYKs/u3cBsMsm2wuAVUIL5MGUZhvW3DPiXAaxa7mpGJtmC0aJxOcVMLBo08OjSO0og3//06urPPVBsQ0q0afu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706594140; c=relaxed/simple;
	bh=ytRH3/bgE5JjShBfSCqigfj2RMd/ircaJKsVHOj4KD8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sbYiZq+shmvoja+pTFPVthkd8bt3Cq1Y365rCr4Ji8EoRMNDcjjmeFWSBg4r3MLu3WkSnJXYNdRXdo23CR8oJV8e6gH7iB88fzjcIX3yloYVjYSiyTbpcD5hjYNlrOFV3QKCxMRZz8Ec0Ur4NLYmsy58IJ0eAFAQHQVFvPlCqRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k4kmbGct; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-510f37d673aso2759681e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 21:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706594136; x=1707198936; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iNSFIzC99NdyScbVziFYqKRK4spLwzlJEsIkJFIvX98=;
        b=k4kmbGctp/MZ9N/Ne4SlknhfRmOo2oGI/l5iZlLfRGeXsrbUwEqnzIQtIK5mz8Gy9i
         525Ym+nGeEaMz66PlbkVS8RLenh+XHGMiqVBSNT+Gb7aVtTnjVEJB4Jnqzb4ZUB62Iqz
         ySBe9QugWU8Acx4dp411jG/Ht5Re23HVGjaOIjNo7KH57LpeDJ8bvOStNDXSOhDhHlXl
         tb2TvcoA/IDqutFGDTvBFurYRVo4wK9ICdYxQQS/VfX56YmzuzQtWwFDZ71IZEaffPoB
         XZwo5Dl2PdwHfjSU/4kkdsyi+VOQrf3ZW9EfwyzG2aPO27ePrt2pc8G9kJvtETJFGxH7
         ztjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706594136; x=1707198936;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iNSFIzC99NdyScbVziFYqKRK4spLwzlJEsIkJFIvX98=;
        b=fUxJwhsmBgfXvMWfffN8flAGYFWAnybb/Fj+/gJElLi9B75Rdel/bpBnEHwhL6Bh06
         ye+YmK8MFE0U4nr56UhCW9TfHdFixeAs0qhsPHg1bP97WpYsAbKbfYquhQx/zThITfEr
         nnzx3PT0dIik+C7pzPts3le1mTubhZZCiZK8PvT5ro69ISkxqCLH6n63fmQpT1s+5R7Y
         gFo4lPXFqGBNJTxMDtgIOpD/huwMlTy5lXq0wjyodM1JARnI8rPHN7edLERWc3/QM5mM
         vUEeBdHezfABYiWGgrlmfmVFAap6m3MsXyq4dgvKEaIP+tEufmAxmLBXaz87v8D7m3Hl
         /jJQ==
X-Gm-Message-State: AOJu0YxA0ai8sGhXWGBj9VS3wOmrA1zUqfeBJQyyMIco/+iOkCq4E+R/
	b6+OqagLIWqaL2ChW8uaQKM8loJGCqs4ijrIywp9aa/9yZughmdntW3MElfp5Qs1T8lzSTInNv5
	QQ8Afdcl0dus2ROP0BGoEcfc/brs=
X-Google-Smtp-Source: AGHT+IGHlMEGhni9zMb1H1khXMv3ERnRcpgP/0GXIgGCkwDzndrvZgzna31q8ELC48RoCoaV220ZTuzLL9aoHrod0sM=
X-Received: by 2002:a05:651c:2cc:b0:2cd:7039:e281 with SMTP id
 f12-20020a05651c02cc00b002cd7039e281mr209926ljo.8.1706594136011; Mon, 29 Jan
 2024 21:55:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129175423.1987-1-ryncsn@gmail.com> <20240129175423.1987-3-ryncsn@gmail.com>
 <87wmrrgz40.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87wmrrgz40.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Tue, 30 Jan 2024 13:55:18 +0800
Message-ID: <CAMgjq7DJau-aaOt4909j7mZirdy1XaQPL7ybYrsO1tQmhSsipw@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] mm/swap: move no readahead swapin code to a
 stand-alone helper
To: "Huang, Ying" <ying.huang@intel.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Hugh Dickins <hughd@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@suse.com>, 
	Yosry Ahmed <yosryahmed@google.com>, David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 1:40=E2=80=AFPM Huang, Ying <ying.huang@intel.com> =
wrote:
>
> Kairui Song <ryncsn@gmail.com> writes:
>
> > From: Kairui Song <kasong@tencent.com>
> >
> > No feature change, simply move the routine to a standalone function to
> > be re-used later. The error path handling is copied from the "out_page"
> > label, to make the code change minimized for easier reviewing.
>
> The error processing for mem_cgroup_swapin_charge_folio() failure is
> changed a little.  That looks OK for me.  But you need to make it
> explicit in change log.  Especially, it's not "no feature change"
> strictly.

Yes, you are correct, I thought it was hardly observable for users, so
ignored that, let me fix the commit message then. Thanks for the
suggestion.

>
> --
> Best Regards,
> Huang, Ying

