Return-Path: <linux-kernel+bounces-47460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A01CB844E3E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 01:59:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAE7D1C25845
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 00:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BBC83FF4;
	Thu,  1 Feb 2024 00:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VKrw3sd/"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2BA210D;
	Thu,  1 Feb 2024 00:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706749181; cv=none; b=YMpSmra187yoRemHnOx+7kcPD6GwaDYoL+kqnJfbgHWNGb9ScwTLfAkd8rZCViBPns8GnKXtSM1SRFE8Xx37siiusmVJiT5AwNBZUnoTWd0MOjccb8I9mPqgR6qoZ9CoTFmbtLF0Rib78GOoTwJ9CQzPrdmIjftfkcpO+SSYHfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706749181; c=relaxed/simple;
	bh=qmCE2eb4SQrR5zjTO0TKNUCnAcQHCUe34CrmP1TWssg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dDqy66hqdIQvH27KxXyLnwXQvEXzwwu30ELx3FgazoxlpiIOpjzZ66vlDMqM2uo6/0rpn1u0teXvGuFY0fvn5Jfy6FvzpHuDh1uyODz554pWHr5UQ5I89Qg+Nus8ZxtFInSBzwqzWsV1RYvdkECPIZAfIspicAfcD43iE0jqUQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VKrw3sd/; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dc6d7e3b5bfso171074276.2;
        Wed, 31 Jan 2024 16:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706749179; x=1707353979; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fnA6L1M+2ngP3XBAVkCJ/2X93cQHtcov6Oy79KZ7gIg=;
        b=VKrw3sd/vlX1yb9zSvlP0CBcRUwjivMH5Km+37zPg7M07XeaM/lu5pEr3L4OYtLRXf
         7W9Qa7Jxv1BnF6u5pKlQ2hmO/iPJD2HrJVRcjmsdwvLnGPAvXd1b/oZ56dOWvJ2fSSLF
         Ik96LrkyNxAwZs/PNTbx7+2a/gCH9FImVp8AmyyjnRQz2yJ0vGsWB7j+F0vTTuSmt+Y4
         ojtsk+/qDQkwmyDsVOj+R5OUuwwQp7AAFy+Mn5TP7AQSTIBWqWh5+tFsYjWQXPnbm0KE
         x0LRX8CKkaBrQUIJ6YP0A+CCjmrdBOVI242I7L0atwn2LbcYn8LoBq5sZ/ZKihOB/acl
         HemQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706749179; x=1707353979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fnA6L1M+2ngP3XBAVkCJ/2X93cQHtcov6Oy79KZ7gIg=;
        b=T+FD7iYpZLsMZL/uiCAEZzV/bZPgk707ub3UU7zN8ueMLHcPZ8vjJPUfjjCeP+itzA
         W9xuwYNo8wHId38Yjg3xVOpAFAwyhklkmepYRKKlI1/hRUxkoYcTq+VJD/vT1oXYuSbi
         txE+nHku1R3UDQXCeQCXdpurWVh8l91SH5xBAQeteAllcmAN21B9m/UBvLMze0reMTwF
         NAB2wt4FLsQ8GsN/os/+HmNpnFAeYWMQ7qpSpfnBjS+hsWenB70gTpL3cM63oSUIt1bL
         BU+GtYllgUpZHyqpOFtYMFXrVIkZ9mViBKiQBGBX9wT4/96MpSdJGVhkeDudqaqxwkVg
         Ysaw==
X-Gm-Message-State: AOJu0Yza6SLOAz+AZEVD0CklojqpOU4TjgYKG2nF4Ir0CXS85LhfBpFe
	B51HRH2VRcmdnCNdCMx/WmxRgMKnKMQJoc0kf0qDt3HjEX2aOePKbtohXBBUnuR0+nGLXiM/xbt
	oxNfsSnw7bxtIe5Z6w2WyHwZJ/Kw5SOQ1Lm8=
X-Google-Smtp-Source: AGHT+IH+sI9yJQvIvZr607dY7V2Hw5Wgr4Mq7UB6jdlS+TAeU4Whu2zcygKmUuAXqLwjM6y65ECm9pwU04l3Eq8PBZM=
X-Received: by 2002:a25:c793:0:b0:dc6:6307:d194 with SMTP id
 w141-20020a25c793000000b00dc66307d194mr796730ybe.48.1706749178945; Wed, 31
 Jan 2024 16:59:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131134621.1017530-1-hayatake396@gmail.com> <20240131131258.47c05b7e@kernel.org>
In-Reply-To: <20240131131258.47c05b7e@kernel.org>
From: takeru hayasaka <hayatake396@gmail.com>
Date: Thu, 1 Feb 2024 09:59:27 +0900
Message-ID: <CADFiAc+y_SXGtVqZkLoiWw-YBArMovMkuWw3X596QDwEtdBJ2g@mail.gmail.com>
Subject: Re: [PATCH net-next v6] ethtool: ice: Support for RSS settings to GTP
 from ethtool
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, intel-wired-lan@lists.osuosl.org, 
	netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mailhol.vincent@wanadoo.fr, 
	vladimir.oltean@nxp.com, laforge@gnumonks.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jakub-san
Thank you for your review.
I apologize for the delay in resubmitting the patch.

> Could you split the uAPI changes and the driver changes to two separate
> commits? You should post them as a patch series, but combining them
> into a single commit makes the uAPI addition to easy to miss.

Understood. I will split the patches and submit them separately in v7.

Thanks
Takeru

2024=E5=B9=B42=E6=9C=881=E6=97=A5(=E6=9C=A8) 6:13 Jakub Kicinski <kuba@kern=
el.org>:
>
> On Wed, 31 Jan 2024 13:46:22 +0000 Takeru Hayasaka wrote:
> >  .../device_drivers/ethernet/intel/ice.rst     | 21 ++++-
> >  drivers/net/ethernet/intel/ice/ice_ethtool.c  | 82 +++++++++++++++++++
> >  drivers/net/ethernet/intel/ice/ice_flow.h     | 31 +++++--
> >  drivers/net/ethernet/intel/ice/ice_lib.c      | 37 +++++++++
> >  include/uapi/linux/ethtool.h                  | 48 +++++++++++
>
> Could you split the uAPI changes and the driver changes to two separate
> commits? You should post them as a patch series, but combining them
> into a single commit makes the uAPI addition to easy to miss.
> --
> pw-bot: cr

