Return-Path: <linux-kernel+bounces-61914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 290F9851852
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 16:42:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9AD82877BD
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AFCA3CF41;
	Mon, 12 Feb 2024 15:42:03 +0000 (UTC)
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFFB3D0C6;
	Mon, 12 Feb 2024 15:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707752522; cv=none; b=CpVLdKWe00UVjnDMRb+qLInqOP6wudEKNZHlOtrD+hyFA4oIZmJTk6X71rdSZo1+PCHYhH0HLd1XgKVAZwfhetGax8kPQL8RZY7gFM1P6fuml/vy+jmMwKg6aSuN5PoUPigJFOq+cK3ohhzGxDLzZiSfc/STCHqQNbjcg4tbSOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707752522; c=relaxed/simple;
	bh=KDh/hi7bq9l1c37SzjT6niz4jgYaXc6jpGvcu/VGSRY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QBJ4/e6UoAe1IqYCjxztj4xfCCX2+8KaYAtcv1v72ZTL3ix5hRAosDhjMFZJZ4mbrM4CmN7axY0h7z0RGGjW2A6cB2CH6k/ZfXrY4IzdjIlmlP85GizsrWj//W8dmiN4dxWLpyuM9jDcKmu+AdCmGB9ts2fySCT8GfV3Jk6jRSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-59584f41f1eso1389827eaf.1;
        Mon, 12 Feb 2024 07:42:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707752520; x=1708357320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GnQ+DX+UZqNrdEuB64oB3UZemVisp0yDZJbqJza8AzE=;
        b=wGtnvAy0MLrMEvVxwNzWgN8fT/wSQQhXU4QhKLDnKF2HHBnxS3skcU9ay3qLtyyeZf
         q4h4GpYuLfBTJwFAnFMqgCv5ewVrKSzkJLrxJtXWauE/L/mnT1IGweRfJFKF5hJAxFXY
         1OhDtFooVtDMLY404MhvGOFhD/idnKSKXzfIpGrriVhkeA1sRQ0gXPYoYZdo5TtUkgVN
         /ppPVXwldI4A8ln0vlD1efIUBaq66WcxY0V/E4n9YLB754jwBUaYht+66jHekrNIuYot
         Fod52p+Z0N5dC7uWDvq2DuOSOahXjhCWxaqfSmDuetx0gWEaN2H9+8UgRpK5c34s1L4i
         CAjA==
X-Forwarded-Encrypted: i=1; AJvYcCXVPkOeko91YagwhvSAjdV/JSR/g+BiNQET9P3jBwBgfYMfH+d+Y0dxOZS61JjNP3DC9fnujkW87P6uXfh9mc9Q4owcennX9ZW7+czDwXTn3N2qK667+4pXg4uUqg7dpB1OBXqmrtE=
X-Gm-Message-State: AOJu0YyRb22cDuD6IXWtPQfbyosjBoPhSCUMmEN6aYhIjCeanLDdV052
	FDci/frLPiwcnmRkjdbSeSH75GD/nyEbm2bXlkhC6+r8E80HOkjvETXRRNzjD3b+wGMR5VVf4BN
	OvWNsEGUSzWNIFsKFMye/Y8/wq/0=
X-Google-Smtp-Source: AGHT+IG6J54iAWLm5YCCnmbgxmeODuG0ts8ajxZM15fBAtFD2meyvjhbC98oHV0Zzg6Z+YXsJKngYmXFptmMUzva9cI=
X-Received: by 2002:a05:6820:2b12:b0:59a:bf5:a0da with SMTP id
 dt18-20020a0568202b1200b0059a0bf5a0damr5093840oob.0.1707752520466; Mon, 12
 Feb 2024 07:42:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8eefeeb7-f8e8-49f4-b83c-e67a9e728f41@mailbox.org>
 <20240209154336.7788-1-torvic9@mailbox.org> <d06441c9-db33-4c44-81cd-dc1052f48e43@amd.com>
In-Reply-To: <d06441c9-db33-4c44-81cd-dc1052f48e43@amd.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 12 Feb 2024 16:41:49 +0100
Message-ID: <CAJZ5v0hPkOAkWaDFu79RAcyht5r9CK8pwuVpumL5==1D9cFMYQ@mail.gmail.com>
Subject: Re: [PATCH v3] cpufreq: amd-pstate: Fix min_perf assignment in amd_pstate_adjust_perf()
To: Mario Limonciello <mario.limonciello@amd.com>, Tor Vic <torvic9@mailbox.org>
Cc: Perry.Yuan@amd.com, ray.huang@amd.com, gautham.shenoy@amd.com, 
	rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, Oleksandr Natalenko <oleksandr@natalenko.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024 at 4:50=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On 2/9/2024 09:42, Tor Vic wrote:
> > In the function amd_pstate_adjust_perf(), the 'min_perf' variable is se=
t
> > to 'highest_perf' instead of 'lowest_perf'.
> >
> > Cc: <stable@vger.kernel.org> # 6.1+
> > Fixes: 1d215f0319c2 ("cpufreq: amd-pstate: Add fast switch function for=
 AMD P-State")
> > Reported-by: Oleksandr Natalenko <oleksandr@natalenko.name>
> > Reviewed-by: Perry Yuan <Perry.Yuan@amd.com>
> > Signed-off-by: Tor Vic <torvic9@mailbox.org>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> > ---
> > v2->v3: Resend with git, misconfigured mail client borked v2
> > v1->v2: Add Perry's 'Reviewed-by' and 'Cc: stable' tag
> > ---
> >   drivers/cpufreq/amd-pstate.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.=
c
> > index 08e112444c27..aa5e57e27d2b 100644
> > --- a/drivers/cpufreq/amd-pstate.c
> > +++ b/drivers/cpufreq/amd-pstate.c
> > @@ -577,7 +577,7 @@ static void amd_pstate_adjust_perf(unsigned int cpu=
,
> >       if (target_perf < capacity)
> >               des_perf =3D DIV_ROUND_UP(cap_perf * target_perf, capacit=
y);
> >
> > -     min_perf =3D READ_ONCE(cpudata->highest_perf);
> > +     min_perf =3D READ_ONCE(cpudata->lowest_perf);
> >       if (_min_perf < capacity)
> >               min_perf =3D DIV_ROUND_UP(cap_perf * _min_perf, capacity)=
;
> >

Applied as 6.9 material, thanks!

