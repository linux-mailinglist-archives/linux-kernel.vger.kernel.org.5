Return-Path: <linux-kernel+bounces-111677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0868C886F6B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 16:07:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 938581F22BE5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C284D595;
	Fri, 22 Mar 2024 15:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ud7/tMAH"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA384AEF0
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 15:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711120033; cv=none; b=GlHaXJuGUVaKqHx8rame8ka3g50YJRxiQm6yPcdxrI4yJRfzVDb3pENo2o76xuoPXgATNQLPbjSfjGeRDe18Nov+aSo8oueXwGmP7OjClLCwNS/aqQDRNnwjfbJtrtO7VHnRtF4nKU0RX/vwSp6uL1r8sa8Wj+1ub1xtnVXg1HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711120033; c=relaxed/simple;
	bh=bZvs5qIVd2UTsEHcB9KmVNl+Psp8zP+dXnoTaiB4nyQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=prLEwl9Q4HuPOes3iEo5G1x97d/1xC3ivRBIHe2njLNLwrnLurcBxUFGtPnGCYaCQRrYZ5Zzqg+XOvJxhS+VCRL/B+0NJpHn60rBcFr2i1VhB6EPZXs4PJmATJsYfEVxWzdt+cH23jgQZsOUOE2V5npRTDq6StjnT3KSK3molGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ud7/tMAH; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dcbc6a6808fso2193766276.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 08:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711120031; x=1711724831; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h+7mqZoMGMAW7lPkVMDJ4s/qQIQCGi7b18SQcpii1JY=;
        b=Ud7/tMAHXp1ADArylYOgKPRetNOBZ5FaTzGglZxTbz+bSXzt2/Y4DMCMsgIPetdiCi
         OYnJF+fkGby3wjelxWDLNSnj+1/qmIGmZYYf0HxVYl7nLpnnPVM5ZBrFqglL7rtzi2Yq
         Up/pzPAJTsGXHyoC+LqvL/r5M4sWy6momo1ZqLPd9sIkTC7KKtsTx1tC8QrSfmJeqV+L
         i5AvZoLuTmzJLxnoVzOanp52tg/JhbMQXLANcYdcuhWnt77qIqBTJXmuWR360JFJp8Yv
         03YmgtpYn7oyx99P4XZDoSARRgoD8kTlVl4qTbZCB8ssmDhFMHQZMeDYexeFcr/iQz12
         rGxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711120031; x=1711724831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h+7mqZoMGMAW7lPkVMDJ4s/qQIQCGi7b18SQcpii1JY=;
        b=weHO+oYEWGUX/wyy4/8ZFL5V8rzoGypI/m7NQnCPiL7u6QGauY7UNb6sgI6sZA37bF
         rqDOjQH0ojrM1vKsmaOpDNHi9rWjiWf04M41Q+n+8EQite4Lh7B2f1wPZo/kANSWb+V4
         vI0MV5Zy16RXw0iYOE1/PrrPdmzdcaagmRlA8xjqLbymfAsJgIRgJD5Cy/KPyTh51tHq
         mwC9XMUEQXg/pYvkBAJ9+EqKq5oFZ4hUtzbFWiF2N0Z/3H97pQBY4ZFYMTovQj9SSXVM
         FNNWLXVkyWhCsXg6y7Nq5goyfYilbCtw4oebFRCiMahOASgiiY4MFISKGgZTOoNNrOx2
         9IYg==
X-Gm-Message-State: AOJu0YzrM+1PVi2jz9/VG18D5sfkIRWxG05GfwXNN5Xl8YUa+Kua0iE4
	o04lr5X3bwPWuTNoDGcnZ147daf44LJo68bZ8yKJ460gvfi9NuB7KFJXlTm3t0fif1HY13+of7x
	vTkVqUoACg3ngedywdmffpA5vEBI2pQ95fLA=
X-Google-Smtp-Source: AGHT+IEuIT47cBNDnV4D5RMszX2DMbfO/2Ud8P5o8S4HJY69nR2tcVM4ymx3BV9oSI/HNhzWdcpXlS18zj3md+LzLFw=
X-Received: by 2002:a25:6b04:0:b0:dc6:be64:cfd1 with SMTP id
 g4-20020a256b04000000b00dc6be64cfd1mr2457604ybc.36.1711120031222; Fri, 22 Mar
 2024 08:07:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240315140433.1966543-1-hjl.tools@gmail.com> <5f0620c55a01d6a195154783a477ec295cbb4b1c.camel@intel.com>
 <CAMe9rOrgAtQvA=Tj0=T095JmdoRZ8pLuNOY3sT_RwwnznJN2Ow@mail.gmail.com> <7b341bef9c0cab324350873cab75b7e1313a5172.camel@intel.com>
In-Reply-To: <7b341bef9c0cab324350873cab75b7e1313a5172.camel@intel.com>
From: "H.J. Lu" <hjl.tools@gmail.com>
Date: Fri, 22 Mar 2024 08:06:34 -0700
Message-ID: <CAMe9rOq9=7hS-Ohk+5kOnstp4tFFsAF11L=EKdTm+gUt97ugbg@mail.gmail.com>
Subject: Re: [PATCH] x86/shstk: Enable shadow stack for x32
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 7:07=E2=80=AFAM Edgecombe, Rick P
<rick.p.edgecombe@intel.com> wrote:
>
> On Fri, 2024-03-15 at 07:34 -0700, H.J. Lu wrote:
> > > How many people do you think will use this?
>
> I'm concerned that the only use of this will ever be exercise via the
> glibc unit tests, but will still require work to support.

 Correct.  A small glibc change is needed.  Will post it after
my kernel change is merged.


> > >
> > > I would have thought it would require more changes for basic x32
> >
> > This is all needed.
> >
> > > operation. What was the testing exactly?
> >
> > I configured x32 glibc with --enable-cet, build glibc and
> > run all glibc tests with shadow stack enabled.  There are
> > no regressions.  I verified that shadow stack is enabled
> > via /proc/pid/status.
>
> The shadow stack is supposed to be mapped above 4G, so how is this
> supposed to work for x32?

This is not what I see:

(gdb) info reg
..
pl3_ssp        0xf7dcbfe8          0xf7dcbfe8

--
H.J.

