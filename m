Return-Path: <linux-kernel+bounces-154415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF018ADBCE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 04:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EE98282D51
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 02:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB4217991;
	Tue, 23 Apr 2024 02:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sFkZE+tY"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAB412B95
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 02:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713838456; cv=none; b=QVQ3dHgNb6tNheDdCfksT7s2Sy4MHZb4JMdDbUqW8DZ7OiGVyGKcXL9MCxPEqEpU4lhW43dluk/Y/0lN6GsuJ8d6JrmXfY9QsOs2b9fRpMjvHYFDa9cWbZ4jsHCFnSX8E9ayOVoiKIHg1+zzRMQmCoxzHlUE0kOLRtqBES7BTSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713838456; c=relaxed/simple;
	bh=zn+qaZake3v4Y2WT9DovzpK7Wjb+5SsAraXjKf+Wj3Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l0Okt+nvIXHkWCJ6kK/JnajvTfX5vyfr6x5d4zN3LbfbF0rS/VVSUUgdthkVOYFKIq+Gdw1G+lBFRdDVRhhU4RAeJjArPrzMiSvkaWi8DlWhS97huIo+DfQE4DQKXS4c/p4EXhrOR2vrKczmGXMin68wT/JMVisRzxgzeHUVCwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sFkZE+tY; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-de45dba15feso5196881276.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 19:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713838453; x=1714443253; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mpECJfr+9B5j7YbKuUViEqVcNFU43HSu/zAM9fBbuao=;
        b=sFkZE+tYE1k5dc6R2nt09g5L793PeA7KEMHbyAF+1pCkcYK7VGILk1aN/witAtLHKj
         1TCQ4UBssSRDE6AgKZeLoC6XahNacUWccuydRdwZsQx3A7+aQ1D5U+PoTBFzUDJ43Z1E
         p2PXkZYq7SUxq51e1lieZzPxx3RSF7k2L7r9+NQ2MPEQPRPcE794nK0gQ50wHZm5/SO+
         1PTsvNtuOZyu1dl5fS1OkXm4+n4x2lH++FwE1jSVrA2z/DITyhbwEWfyoGLWnUyToWdS
         MWdz1SdtrGSC1Ka5zebZbd8F9HTdkWN+az7CrW4MB6P6VDfJ7ujvr/GrErMOucTECVYC
         yYHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713838453; x=1714443253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mpECJfr+9B5j7YbKuUViEqVcNFU43HSu/zAM9fBbuao=;
        b=PdyWCG7eT2e9WtxoNacc1FTABmHPaqd+e5pEz/Qi1TvedO8LqyfXwhYIbXSorfxGYG
         YQ5pLcwT7p8SBaDdgA7wfe58fFdbD/HUW2UjV/PoYhF18jQHoJszGv97nMTnLaxTUvKM
         PUd6Jg0mA0/6ZAX1xXP/+ZCa7eLHeuFsz6IsLzIcfHLpc5gGcr0FlqxGyXhiy30TeQ+i
         42DJv7SCCrP26lj4VDGh6/tlkKZWc4/7O2LT8yM8X6hQCNVOcBMyBgRwybgqQOaTvZnL
         6NTx5i+7+teJua3X7qeh615aKdu/ZLRHE7neWMdhcaEOODrcOjrUufMokY9qv0jzdMNX
         dUyA==
X-Gm-Message-State: AOJu0YyMMTX0f5mXCPbUMp3AqU51P1tZ1sA6C0rx0esqgptQAjSXHBkX
	oq5SKHWUUBFF8K7wk7kps3K3o3kk3SpZlxnNEra5feRwL73IrvIJZkYJcdnLXZo+cMmiLz+o9xU
	uzNoeCXZdFNZLZ0i/zTiRqabwzDdrt+okyZx/
X-Google-Smtp-Source: AGHT+IEETGKP7ih/gauNNEH6U2W0p4647O5QfjYzJ9TVkLjofINRl6tVYtReOchfpAvQpsEGYzZ1zxmjlID1lODHuY8=
X-Received: by 2002:a05:6902:cc1:b0:de4:6e20:aeb4 with SMTP id
 cq1-20020a0569020cc100b00de46e20aeb4mr12034286ybb.18.1713838453305; Mon, 22
 Apr 2024 19:14:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422231730.1601976-1-sashal@kernel.org> <20240422231730.1601976-10-sashal@kernel.org>
In-Reply-To: <20240422231730.1601976-10-sashal@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 22 Apr 2024 19:14:00 -0700
Message-ID: <CAJuCfpEdqBf8FL3Ht8VOuNZC0avRrqGhL7OWamRg2gorerp96Q@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.6 10/29] memblock tests: fix undefined reference
 to `BIT'
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Wei Yang <richard.weiyang@gmail.com>, Michal Hocko <mhocko@suse.com>, 
	Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 4:56=E2=80=AFPM Sasha Levin <sashal@kernel.org> wro=
te:
>
> From: Wei Yang <richard.weiyang@gmail.com>
>
> [ Upstream commit 592447f6cb3c20d606d6c5d8e6af68e99707b786 ]
>
> commit 772dd0342727 ("mm: enumerate all gfp flags") define gfp flags
> with the help of BIT, while gfp_types.h doesn't include header file for
> the definition. This through an error on building memblock tests.
>
> Let's include linux/bits.h to fix it.
>
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> CC: Suren Baghdasaryan <surenb@google.com>
> CC: Michal Hocko <mhocko@suse.com>
> Link: https://lore.kernel.org/r/20240402132701.29744-4-richard.weiyang@gm=
ail.com
> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Sasha, are you backporting 772dd0342727 ("mm: enumerate all gfp
flags") to 6.6 and 6.8 kernels? Just checking because I didn't see any
emails about that and can't find it in stable branches. If not, then
this fixup is not needed there.


> ---
>  include/linux/gfp_types.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/include/linux/gfp_types.h b/include/linux/gfp_types.h
> index 6583a58670c57..dfde1e1e321c3 100644
> --- a/include/linux/gfp_types.h
> +++ b/include/linux/gfp_types.h
> @@ -2,6 +2,8 @@
>  #ifndef __LINUX_GFP_TYPES_H
>  #define __LINUX_GFP_TYPES_H
>
> +#include <linux/bits.h>
> +
>  /* The typedef is in types.h but we want the documentation here */
>  #if 0
>  /**
> --
> 2.43.0
>

