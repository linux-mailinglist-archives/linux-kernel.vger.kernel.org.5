Return-Path: <linux-kernel+bounces-70152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C3B85940B
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 03:28:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 213131C20C40
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 02:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 524DB1859;
	Sun, 18 Feb 2024 02:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ctvy/73a"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE1F1103
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 02:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708223275; cv=none; b=UBdQNb2yl6g3OdQGHMKwRt55SAR4izWMU8PZRerw9yb/6pfUl1oIDLzb/9QqqpwCFHbix0WAkD7FFGOB2jGDfhalzU7y9GKBxY48z9mUKJT6msMSj/jx4t8iPclE9fxkjeA7azFn+8tND0PeOVEPp664te1Q5SbfsQP8D/N+RUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708223275; c=relaxed/simple;
	bh=nKsx+TvlDRCfg/EURkIhikZLmq+YLEYvNN++aBLHASQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LiuzPgRdy4+IlVyUMDT6NXVJrYjcdvv3jP+pUDXm3DcySWD5iBCy1AVOWINbar0shehnw57ncrkH2wBgj2doF05+A7xKukKKg0iXQhOQh4/8UXgBih4vglN1+xo29xTaEGKOwidwlIps5kAyFFCUesjMjNRpeMi1Yc3hcxY5gHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ctvy/73a; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708223273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nKsx+TvlDRCfg/EURkIhikZLmq+YLEYvNN++aBLHASQ=;
	b=ctvy/73arG1HA38XR+aC6wtD29ePQIEZZcCzpFdQ7DaEtbIXvVjHtxZoZGvxnwKVf8kn2e
	GkMEjnEux8Pf/0fzc89ag+4HB4L+JCTPGIG60Xn/R6KR+550yu1U3/+xeJLy5wJ/Ty8EJa
	jn7EGrGqZH9dj+HVOw9ChmszDrz0Nik=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-0WtojXbbPsCN9uuhT3NUgw-1; Sat, 17 Feb 2024 21:27:50 -0500
X-MC-Unique: 0WtojXbbPsCN9uuhT3NUgw-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-299678318dbso299549a91.3
        for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 18:27:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708223270; x=1708828070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nKsx+TvlDRCfg/EURkIhikZLmq+YLEYvNN++aBLHASQ=;
        b=h/fVvbB5qMXPREvg1LxFg98m7kFvNAJY4W2grCOYfT0iSDfp7xJ7XtKRBtQgWm/nrX
         HB6Udh2uB+GWzRGve8ysTmuLsATj3VI1JfP5enpZpM267G4Y+z/TRPxEcsGwx6c8BdrV
         wc+TKeODN91h+fpboGpmAh56Y1En78TUvJxc+yfAHKFwKbW7z62Jr9+D3fMVUDbV1AeB
         sW7TW6yogbMKQA8x5eZpVvjbIh2WvKV3r+iiopQ/DwzO8Uu1RtvqZJt5errS0j2YZvQ0
         8D1Dj6QuETXBUoaKhVhJKjcbvk36ZEJ5ANI9Ry0E46RJIj0UdUT4pGYi7GzDCvkWz+Oy
         VOow==
X-Forwarded-Encrypted: i=1; AJvYcCXEodQj6PP/dtt7OPFdigZ+3O1ZNU2KoJ7J1FybM6o/cyeKUUS7K5ktIrPGrNQFVflZihfzitUAd6vWxJk2l9FYhy/AorfEIhOYLQlO
X-Gm-Message-State: AOJu0YzqbZb1qyT5mjBnC3+OVaLXDCfTQcCBFo/j7Z742q/N4fBnpiim
	R/0mnM9YD+04WQnpUwvFv/t2Rv8E0pk5YN6aRENnfupcvSHlkgWhns9TEqRgZz3gCiOuZFCI4A1
	oPhmblZWWTXUniqVVvFMPqfPQDQF2Giso3SOLkOEBLj3gyXlsQ9q1iOcU33j7L+NdzlNg2vJbHp
	slB0COb/kgTevD7K7xJLy/EzRXk+HnsCSLhRE5
X-Received: by 2002:a17:90b:78e:b0:299:3e54:83fe with SMTP id l14-20020a17090b078e00b002993e5483femr3558428pjz.36.1708223269860;
        Sat, 17 Feb 2024 18:27:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGO+Z325KAFI0GSZHw8iD5qIOQx10QeQ1N76fEOCkdUvi6n8sFtZCH4pi9EU3V0YpRBSBxKSb8bnmRvh9gR8PM=
X-Received: by 2002:a17:90b:78e:b0:299:3e54:83fe with SMTP id
 l14-20020a17090b078e00b002993e5483femr3558413pjz.36.1708223269552; Sat, 17
 Feb 2024 18:27:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201092559.910982-1-yukuai1@huaweicloud.com>
 <20240201092559.910982-2-yukuai1@huaweicloud.com> <CALTww2-ZhRBJOD3jXs=xKFaD=iR=dtoC9h2rUQi5Stpi+tJ9Bw@mail.gmail.com>
 <64d27757-9387-09dc-48e8-a9eedd67f075@huaweicloud.com> <CALTww28E=k6fXJURG77KwHb7M2OByLrcE8g7GNkQDTtcOV48hQ@mail.gmail.com>
 <d4a2689e-b5cc-f268-9fb2-84c10e5eb0f4@huaweicloud.com>
In-Reply-To: <d4a2689e-b5cc-f268-9fb2-84c10e5eb0f4@huaweicloud.com>
From: Xiao Ni <xni@redhat.com>
Date: Sun, 18 Feb 2024 10:27:38 +0800
Message-ID: <CALTww28bUzmQASme3XOz0CY=o86f1EUU23ENmnf42UVyuGzQ4Q@mail.gmail.com>
Subject: Re: [PATCH v5 01/14] md: don't ignore suspended array in md_check_recovery()
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: mpatocka@redhat.com, heinzm@redhat.com, blazej.kucman@linux.intel.com, 
	agk@redhat.com, snitzer@kernel.org, dm-devel@lists.linux.dev, song@kernel.org, 
	jbrassow@f14.redhat.com, neilb@suse.de, shli@fb.com, akpm@osdl.org, 
	linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, yi.zhang@huawei.com, 
	yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 18, 2024 at 9:46=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> Hi,
>
> =E5=9C=A8 2024/02/18 9:33, Xiao Ni =E5=86=99=E9=81=93:
> > The deadlock problem mentioned in this patch should not be right?
>
> No, I think it's right. Looks like you are expecting other problems,
> like mentioned in patch 6, to be fixed by this patch.

Hi Kuai

Could you explain why step1 and step2 from this comment can happen
simultaneously? From the log, the process should be
The process is :
dev_remove->dm_destroy->__dm_destroy->dm_table_postsuspend_targets(raid_pos=
tsuspend)
-> dm_table_destroy(raid_dtr).
After suspending the array, it calls raid_dtr. So these two functions
can't happen simultaneously.


>
> Noted that this patch just fix one case that MD_RECOVERY_RUNNING can't
> be cleared, I you are testing this patch alone, please make sure that
> you still triggered the exactly same case:
>
> - MD_RCOVERY_RUNNING can't be cleared while array is suspended.

I'm not testing this patch. I want to understand the patch well. So I
need to understand the issue first. I can't understand how this
deadlock (step1,step2) happens.

Regards
Xiao
>
> Thanks,
> Kuai
>


