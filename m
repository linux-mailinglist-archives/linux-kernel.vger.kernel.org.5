Return-Path: <linux-kernel+bounces-55716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0917B84C0BA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 00:17:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0A801C21C07
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 23:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 449171CA8E;
	Tue,  6 Feb 2024 23:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZPYE8AHW"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8BC1C69E
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 23:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707261412; cv=none; b=TRS56XCjxdgPGdIbAjjkrcYa7hiRJ6w6lRFL5srtYL9kDVmEFnMgBL8oXDqS//s/SDmNK3Tti6cbbde8pkfH/xn1kWlqg4c8BjWxL7yrgZeMvhCV4NjxfP62GkWs8wDfbf8yn3XJwYIPlgxLhJDyJFLM4Y+Hezq6n/8FE1/PE3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707261412; c=relaxed/simple;
	bh=hjuXYFp0BpgB4Emdhlo042pzBYM3c/njLOXBtfjA7Dc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V5YlDdld9+SQJI5BWoeEgxrzMMgMMZOvWYVUHxJW1EXQAVWkOuFxNbJ6UCosTIXgS2iC+FYu1uG6rDvrKDm6+B5r2TcW1uUr8xFN1/o/Ip5ZCcK+qy25BBBFHBZBUOSLO7H9xgWAgfWz9KyQRsvtehTcLqQmIw5kTr/N6jepzEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZPYE8AHW; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-56037115bb8so5240a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 15:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707261409; x=1707866209; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hjuXYFp0BpgB4Emdhlo042pzBYM3c/njLOXBtfjA7Dc=;
        b=ZPYE8AHWOs4CPiuoscGW7O3dGurxeEK8xYw4jAtFaHzIOr/DTTGp3RTQMyOZ/oQEN5
         ngMxhaBJcs8UAQT7j3Hi7Bo3uCvM+2ffUfnSaUSBxxNz3W44YqH1diGs2aE/GtAFbz6y
         pXRbHkXkQRh4RzYy2ojefsw9qnIqsd9PzLYTcGeW4Ruf9gTeD37a6GpwRnhdFN+Pwgj0
         e/jOfynZUhqEf/cIh+HUQ20YTd4PgTNLWZA2IwS1P72/MObZxn4+djLr/LB95BHcLfMc
         sD0iQv1BWSwCFpXgbnS80WwKYcD4Ar3FP7P1O16xd9hWdhjrnWNzxAPOQVHw55J3Cxq0
         sogw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707261409; x=1707866209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hjuXYFp0BpgB4Emdhlo042pzBYM3c/njLOXBtfjA7Dc=;
        b=lvpiGhS9MQlsgRQaRphHC5eDFSfpaOVbSDTPxxfcnqO02TpA4YXrtqBaSHPueoJWRP
         BCqd0ftJYfn2vIIDmf2s/Mii66z30t6/sJ+/WBl1ETEaStJxo+q4iUg4OVY+cZurTFrF
         ujhcqatR+XcgSHGEPjn0yMfSjrVsgSEVVakieYZ7R2IaxSqH1Rk24v8BmcL5e47jFg73
         vDnjnFsl2QRuVZOOfmLKRzyzUvWAi07sEFDBs1mC1D3Hj5hwA3PPIFWrPepNCpZrZibh
         Tibv5ePavgqAwdpXR7c52A889EokH6DGhFuruTJPacAm4N4V/JUedZ/lWDG/drYPHrcD
         13CA==
X-Gm-Message-State: AOJu0Ywq6I+gLho0IujWEyM2gGqRgM//LTUo5UTqgphdW56jBmWurJmo
	kHkRCYao/2sPrU1K6/fZcvjOb5pEk7vUzdA8swLtyyqg/tOnFwtGiWT5lgj4QwcEawJmK6kokKV
	WBiCmA85iiZ42pmei1Zd3OwISeDks1BBDrnfNZFrpYx4sQWS2Xg==
X-Google-Smtp-Source: AGHT+IFVLHOeVS3oFWFpqfR2BnXJ2QDNRGI0rWqOwWejn1ZrttMuYSvIlJQWucqQHUWngwl2NRRgXBVL/bLssOk8rXY=
X-Received: by 2002:a50:9f08:0:b0:55f:a1af:bade with SMTP id
 b8-20020a509f08000000b0055fa1afbademr74668edf.4.1707261408799; Tue, 06 Feb
 2024 15:16:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1699104759.git.quic_charante@quicinc.com>
 <a8e16f7eb295e1843f8edaa1ae1c68325c54c896.1699104759.git.quic_charante@quicinc.com>
 <ZUy1dNvbvHc6gquo@tiehlicka> <5c7f25f9-f86b-8e15-8603-e212b9911cac@quicinc.com>
 <ZVNQdQKQAMjgOK9y@tiehlicka> <342a8854-eef5-f68a-15e5-275de70e3f01@quicinc.com>
 <CAAa6QmRnfTOCD0uaxVbbiDRWtwzC9y+gZDFOjYF2YWDTrXyMNQ@mail.gmail.com>
 <5adb12eb-8403-5860-28eb-5f6ab12f3c04@quicinc.com> <ZbOQC0mYNsX0voKM@tiehlicka>
 <CAAa6QmQwSRn=XdHjyjNxX0PrBCKbOovBVCYaDHKAzAzYYFZwug@mail.gmail.com> <Zbe-fEYUJYzq_3Ij@tiehlicka>
In-Reply-To: <Zbe-fEYUJYzq_3Ij@tiehlicka>
From: "Zach O'Keefe" <zokeefe@google.com>
Date: Tue, 6 Feb 2024 15:15:38 -0800
Message-ID: <CAAa6QmR0SVqXmZD4QCP3JuVc=YmfZPH8LOA980JTKHseu85iMg@mail.gmail.com>
Subject: Re: [PATCH V3 3/3] mm: page_alloc: drain pcp lists before oom kill
To: Michal Hocko <mhocko@suse.com>
Cc: Charan Teja Kalla <quic_charante@quicinc.com>, akpm@linux-foundation.org, 
	mgorman@techsingularity.net, david@redhat.com, vbabka@suse.cz, 
	hannes@cmpxchg.org, quic_pkondeti@quicinc.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Axel Rasmussen <axelrasmussen@google.com>, 
	Yosry Ahmed <yosryahmed@google.com>, David Rientjes <rientjes@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 7:04=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> On Fri 26-01-24 14:51:26, Zach O'Keefe wrote:
> [...]
> > Node 0 DMA32 free:66592kB min:2580kB low:5220kB high:7860kB
> [...]
> > free_pcp:8040kB local_pcp:244kB free_cma:0kB
> > lowmem_reserve[]: 0 0 16029 16029
> > Node 0 Normal free:513048kB min:513192kB low:1038700kB high:1564208kB
> [...]
> > mlocked:12344kB bounce:0kB free_pcp:790040kB local_pcp:7060kB
> [...]
> > mlocked:1588kB bounce:0kB free_pcp:253500kB local_pcp:12kB
> [...]
> > I'm not familiar with these changes, but a quick check of recent
> > activity points to v6.7 commit fa8c4f9a665b ("mm: fix draining remote
> > pageset") ; is this what you are referring to?
>
> No, but looking at above discrepancy between free_pcp and local_pcp
> would point that direction for sure. So this is worth checking.
> vmstat is a periodic activity and it cannot really deal with bursts
> of memory allocations but it is quite possible that the patch above
> will prevent the build up before it grows that large.
>
> I originally referred to different work though https://lore.kernel.org/al=
l/20231016053002.756205-10-ying.huang@intel.com/T/#m9fdfabaee37db1320bbc678=
a69d1cdd8391640e0
> merged as ca71fe1ad922 ("mm, pcp: avoid to drain PCP when process exit")
> and the associated patches.

Thanks for the response, Michal, and also thank you for the reference here.

It'll take me a bit to evaluate how these patches might have helped,
and if draining pcpu would have added anything on top. At present,
that might take me a bit to get to, but I just wanted to thank you for
your response, and to leave this discussion, for the moment, with the
ball in my court to return w/ findings.

Thanks,
Zach

> --
> Michal Hocko
> SUSE Labs

