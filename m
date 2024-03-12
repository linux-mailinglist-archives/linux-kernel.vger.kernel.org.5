Return-Path: <linux-kernel+bounces-100514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E04E08798F1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 17:27:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CE781C20C30
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 16:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B137E108;
	Tue, 12 Mar 2024 16:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="VFYXGRZY"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D85FAD5C
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 16:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710260869; cv=none; b=OSwNGf+tr8vbAldd8+hhJECD3ySTw2lRTtIQnQBRx4rXj/XEEP6Ykj9Kexuhxkf27XfgwT+MdEkVYU5SMKeJUdhpZub3X48erfxvtRlbzsM0AdWGbScPMFgKYrv+jWUbNA/DP2Z/AhVG4oNmEY4tyH9LnTVtkmrndyWM48vz4T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710260869; c=relaxed/simple;
	bh=IiHPxi9HDqDLE1si//8MfsUk/2btYoMYFFe/2RxENxA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IzKUPcFsv5dx0OptnXYRg8+Ld/AHzIbiS0BcqsOy0iiYSkyRNzwpUuscwEnV8VDkezCNXeqHod5Hng+0Vu2sQYHxsoPBAlmB2sQlBDuIryuTOffa0yXExCwIIWwKdHg50grTJRBEWNenU7CaYW2Y1pJc6n4xxuIxJYI2SEU/G4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=VFYXGRZY; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d3fae963a8so56036081fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 09:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1710260864; x=1710865664; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZpzQZqruwKja9nyJdz9bHaAc81yn7IMwBg7mOeI7FDA=;
        b=VFYXGRZYTyfKkc4a2IGPdpRd964ZMx/8WOYVehvMqr7vEr34MxYT3j7F6fESCguav7
         vao8KAQ38AjIqnu+OMIyhx6/kf0Q82As2kI83S4epm9HeKcCHDshmH3WXhpQbrCYGWRj
         QwzkRjySjTjtlOdNxOLTfl1i3fEmgI3SnrExIPL+tOMtn5hrVv7YOZRr7Bs9PI3lte3t
         LBXGZEEB84s6IGOSDiD3Aello2yYNI1yo/b9cNr0kWi36o+ib0nZlfMAinUu8WyfGpUg
         j81bxvjJR+qjuj+SOK5byA4lImS4xc4pWHgVJfR5Rmv0hyPETsp3VvP2xgKSi7HRppSD
         Fixw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710260864; x=1710865664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZpzQZqruwKja9nyJdz9bHaAc81yn7IMwBg7mOeI7FDA=;
        b=p9avhuknNhDgs1IWNZAmh7SzjP6QHkuTWrib8qjrMRCzbd0Z1mze7mA4YGmz3piwrS
         nb6JaZOD6HWWS3d7bMEiRVzXCzMt+ftq2Z9HFKQslWhtzdJyhImRbXyJShAV36Y1wAJQ
         BOH8VMd+d/3PH/FYR2+7bRILvlK4RUpQa6+qD/pfI3SfIb2coSfmDjWLjeXe4FncBWtL
         vBzaSVPO7+xo/CCt6wqxlilgvcVmwnHzwfoBEi1w1hv8LHWkhQTRthwt/3MPXBVTgciz
         fQjz2psS34wmvtOmcAXKckkasNV3hUz5Kr86zViWOILzPyLM1mhAKb8N9xQOLadY8P5W
         6tWg==
X-Forwarded-Encrypted: i=1; AJvYcCWi+KgeaYCOo2RFiymoN9eOnopnIuJ9iI7nm77btHILhM6klML1RMT12vizHwcjoru8Vkkg3kT0TYh3gBN1hvKESg5AwFBeXKTdnKne
X-Gm-Message-State: AOJu0YxNnEg0yjZpG3BpEB3uNbr270EvMmoqgQrBvCgEEPrHaupP3oxk
	PWgAv72jAFxZdKPI2ZMtuQztVFGq/Ons8AjsKlFNm8efCiOT9A+1fyLz/AQZ1CRmfEhtktdX94x
	yIatmQczuOpNutBo7OpjsiVfyZ8O8UirVZ6jEZ1e6gtMNog2r3j4=
X-Google-Smtp-Source: AGHT+IEIuT0jIwNFFM4VPIc7a2IxYK887pXkOmohvOecn7TrsQbm837NbP2lQBbqM5cqzMVai9xgCbCZ4XLfqxhkAJU=
X-Received: by 2002:a2e:be84:0:b0:2d3:b502:3fee with SMTP id
 a4-20020a2ebe84000000b002d3b5023feemr6935223ljr.0.1710260864570; Tue, 12 Mar
 2024 09:27:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240312094133.2084996-1-max.kellermann@ionos.com> <58fbe42a-3051-46bf-a3f9-d59da28a9cd7@redhat.com>
In-Reply-To: <58fbe42a-3051-46bf-a3f9-d59da28a9cd7@redhat.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Tue, 12 Mar 2024 17:27:33 +0100
Message-ID: <CAKPOu+8AQ8g_bEOBRoLiiO6eYBGj09YiUx=U0QPnB0Csifa6xw@mail.gmail.com>
Subject: Re: [PATCH v4 00/15] Fast kernel headers: split linux/mm.h
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, willy@infradead.org, sfr@canb.auug.org.au
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 5:10=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
> >   include/linux/mm.h                            | 583 +----------------=
-
> >   include/linux/mm/devmap_managed.h             |  37 ++
> >   include/linux/mm/folio_next.h                 |  27 +
>
> Isn't that a bit excessive? Do we really need that many folio headers?

It would technically be possible to have fewer headers by merging
several of those headers back into one, but then the dependencies will
be heavier, and eventually we'd be back at the large "mm.h" mess that
I would like to get rid of.
My patch set constitutes the balance of "not too many headers" vs
"small set of unnecessary dependencies for each including source file"
according to my taste.

Max

