Return-Path: <linux-kernel+bounces-36911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BBBB83A88F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 12:52:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D83712870FC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 11:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4167D60B96;
	Wed, 24 Jan 2024 11:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eZGLJSE6"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52A960870
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 11:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706097142; cv=none; b=GHIdxeXGSysqwhq49HcVA5KWOM6NRoBd+w8qL2pejYhjS94uWk6ZseOs5ZAcvEJuiQbgzyQreCE0QlKyl6vBsY21JHJhS/SeloiHNAqxyTQ3tXKRfhcSDplTu/kYOldOPzLRu381xnm5DtIyxMuAh9+XQYhwR2BEhqeIUyL3cFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706097142; c=relaxed/simple;
	bh=a5H0E6j7eGE53aTaLLK9h7jLJDl/erd4lNXiZJRMz+g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YzlH88kcnR7vRqw9WtyWaTbpDJepMDjpDrq7AoNpzY+hGID1WEyGKt7sNbE/DqyXUmUK4230AsUT1chIQx6PPsl8ij8GYvJdpWdJfsvKXNtbhMHBggS9dfSstsCMmpMPlqaizVfjZbnYXrGVmEs2tBZeoI2d2Da31sOP2OxvvZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eZGLJSE6; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-55c24a32bf4so11068a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 03:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706097139; x=1706701939; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a5H0E6j7eGE53aTaLLK9h7jLJDl/erd4lNXiZJRMz+g=;
        b=eZGLJSE60NS52Eu/xG6t2f64BKl8C2qfddlfy/YDBOL7i7ZpDMyiA9QfLxzBVmXi04
         ru/CQwDfo1HNxg1T+lDP7+TyHv7PtItWQB6Vv1pbhvEIrlW+Kn8cVxFhZKdIrNlbSxlM
         14LIceO5WI8MwnYdhlznhpvpaHtqFanGSntfoblYTke0qi20+qK2UmvEC64ietv3fcjx
         I3fuK45MCJnwShiAsDRem5+bi0POHWc5H/MxvW3t9W9b1wAiqb1Qezh5HCHkOOTP0RgB
         pHiLy8jghVButNhnQYyktIf8PQj6Gx737JcL5GkPIeGRg6eBGFDDfFcINC5+jRWTl4qX
         vHtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706097139; x=1706701939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a5H0E6j7eGE53aTaLLK9h7jLJDl/erd4lNXiZJRMz+g=;
        b=LyjDioAHTsIgBM406XH4JSe/Y90wiE/Im0PVUgFCI2R9yrOMdZsFQrRW9EbA6Aql/6
         qygHUsUlh5Ca6oMh4CKsl1LPsnAUtwfneaWk3m7WjCAyr+7Xdb8zWs5eSYOnTl6ibEie
         0xt26VV/FvJh4IeadcmtlY/CaWOKYmqaIjqEPq8eLkXdkJeOwHDlRhtAYKhTUSe1g7w3
         ILV5tRN/Uh60UD+1Kjls4UufEY9l6TqamjsQ1INiuWE9GKAwS/clDrK4OfLrvI3VcOVg
         Wp9/t73Spn6MJhDYC+M7USqpTx17tRJcLoP0H7TFt3doxx7dkGfm0uBsoxrKmawQumul
         lTyA==
X-Gm-Message-State: AOJu0YzlH4vHaCNXkXTHqiVNB5brdxgjTh1jtk9+tNfo9ZW4XVssAh+f
	/3dpI/2SrppZUVi7UdM9lddJUGhA0P13Nz2Vn2wwT61+vmP8mi+Fm2/HkgOIvg93x46BfeYMXGK
	Vt4ZfSDW7QiOv2/ONuTPYB+8Mp3MK3ciyoHro
X-Google-Smtp-Source: AGHT+IH/GHZq8Aih5T2bhKVnYYebke8oNKPl/T86BTOCByN90Bn9Mikn6W5nbeRbtjUxaevlh+Dm2IHuIzUofLLwBx0=
X-Received: by 2002:a05:6402:368:b0:55c:6a45:d6de with SMTP id
 s8-20020a056402036800b0055c6a45d6demr94542edw.0.1706097138639; Wed, 24 Jan
 2024 03:52:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124101404.161655-1-kovalev@altlinux.org> <20240124101404.161655-2-kovalev@altlinux.org>
 <CANn89iLKc8-hwvSBE=aSTRg=52Pn9B0HmFDneGCe6PMawPFCnQ@mail.gmail.com> <1144600e-52f1-4c1a-4854-c53e05af5b45@basealt.ru>
In-Reply-To: <1144600e-52f1-4c1a-4854-c53e05af5b45@basealt.ru>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 24 Jan 2024 12:52:04 +0100
Message-ID: <CANn89iKb+NQPOuZ9wdovQYVOwC=1fUMMdWd5VrEU=EsxTH7nFg@mail.gmail.com>
Subject: Re: [PATCH 1/1] gtp: fix use-after-free and null-ptr-deref in gtp_genl_dump_pdp()
To: kovalev@altlinux.org
Cc: pablo@netfilter.org, laforge@gnumonks.org, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, osmocom-net-gprs@lists.osmocom.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, nickel@altlinux.org, 
	oficerovas@altlinux.org, dutyrok@altlinux.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 12:20=E2=80=AFPM <kovalev@altlinux.org> wrote:
>
> 24.01.2024 13:57, Eric Dumazet wrote:
> > Oh wait, this is a 5.10 kernel ?
> Yes, but the bug is reproduced on the latest stable kernels.
> > Please generate a stack trace using a recent tree, it is possible the
> > bug has been fixed already.
>
> See [PATCH 0/1] above, there's a stack for the 6.6.13 kernel at the
> bottom of the message.

Ah, ok. Not sure why you sent a cover letter for a single patch...

Setting a boolean, in a module that can disappear will not prevent the
module from disappearing.

This work around might work, or might not work, depending on timing,
preemptions, ....

Thanks.

