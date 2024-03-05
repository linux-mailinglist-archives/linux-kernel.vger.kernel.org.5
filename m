Return-Path: <linux-kernel+bounces-91554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72CC4871395
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 03:23:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4BDB1C21252
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 02:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080B41862E;
	Tue,  5 Mar 2024 02:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KCHQ9M8s"
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEA2182A0;
	Tue,  5 Mar 2024 02:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709605377; cv=none; b=G5fCvOr3nV3nGWlThpQdbQAsPf8CaGH8AF3BV9ZCG/eEYxh3JbuSXOkvbQLY6K69XwoQITVBV5XDsb0R/xNcWR/CeviRFM4VlRIqc7IE3pymLqmRm12LzOyuUHfhMqh1NpoHD8003o4/2OMxEDVBGsobSlkn4PKju+NBXANnY5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709605377; c=relaxed/simple;
	bh=lyDBQ+22yrp72E595L3mg2lYk2PEqYaqKKUdLQjHJus=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cPwLySoI6ZOfQQkIVYwJbDPDxm66xZpZEW4pHvf9w1hksnln5RaNO2R04kAGF+jFavg9SD6QFM+e2ojiSl4mZdiXbt3+3o/vDywObLjfcsmXIglmELbEvAF/QvSC64PEw6KG8VYb9AQ0hyRRs5oIENgwnVw2OUKSt0INXsyOTgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KCHQ9M8s; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-4726656a997so749586137.3;
        Mon, 04 Mar 2024 18:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709605375; x=1710210175; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lyDBQ+22yrp72E595L3mg2lYk2PEqYaqKKUdLQjHJus=;
        b=KCHQ9M8srG17nzn8br+B6ip1EQ98WVVa8SYBTNE2DlbjB3uRBu2jHZGVGBJBh+gLPz
         DVUk9AN+wAS1B4ozU8TcKiDY5831konaikp0tVOE19XA1DY+dG9elFL2mvLKmmo9yVXc
         e2KbzyK2q+fmjDSptvyGHAxSIRB1DsAWzcTWJA18ZquQGAaCfY58WsFFBazbPVOPnRAN
         9HOzOVj6krZk0cJMohKmE2Vn0wgnEanQB0ZByzfuFKvOLzySsMNfa17Ab6/YupmAVzA2
         7RYLa14ZDjVx62sfOUcQKJjPVfiXQu+xfYCuNaoRwEMy+zRtGhEbYbB4SEH/ixX3mYuZ
         qCnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709605375; x=1710210175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lyDBQ+22yrp72E595L3mg2lYk2PEqYaqKKUdLQjHJus=;
        b=Zh1zyIKxc7YZ5o+dH0n9Th/RKurvecfhNl6So5IehC5Vok2bwAkuxHSOg799Fc+w9U
         ny6jn/NYbRTJxsH+0rY6L5+1llfYCJu82kDwS7gME8WMMXyIn7YFJiTc9bhEV+LUwljB
         iSRfzCqk2SgiinSudCqfygdGVlkt49D97Ft2dszCIE5ueOgw8IcBcw8wq9T46gSUOli4
         aITPsmDizKfNb9nfrhlN3DF0DeT6Q4+IeZ6+LgpBs2FbxzXt8GOZ+E2H+eoO93Ia8uuM
         QfJKfiUy9581YmUVvyBSX4SlGJH+iDr7fNvC/H4oNzKgQY3yU0+bkzUODrAwdGGu7H65
         QXKg==
X-Forwarded-Encrypted: i=1; AJvYcCUjxKE4kJWurRlQUvZIb/G86OhKJDOR0MnWonRbxxo6QvZ1nAC98SC9Sf8YSXa9dAa25vPVUPQVhzJk/t9raS/WgAuaDNOpfzTKuH2W6xMbkSj9a9tMV5VcHxbqqGHuPLs/c8k+
X-Gm-Message-State: AOJu0Yypm/nNdYP8BSTH9CeN9CZsUy9LBJ+8RZSUnztuP+I/TvwqIp7+
	zjqADLUFsh+93HA1lADnweYW3GgZo94+4/nSVGqq3PD5gwT8MyFJB10+Yt8P5IofAAdBobeLmIx
	semlyjSc370F0WtNSnoqjGse2VgM=
X-Google-Smtp-Source: AGHT+IEJjbVykwk6l7yGQdOtaLiYdeBNq/pEj+9wBlBNqTGI1CEUlzvLT+rU73oRpT1flJVazofNP8/bDQLys9OKogI=
X-Received: by 2002:a67:efcf:0:b0:470:4454:c40e with SMTP id
 s15-20020a67efcf000000b004704454c40emr573764vsp.14.1709605374582; Mon, 04 Mar
 2024 18:22:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227192704.376176-1-e.velu@criteo.com> <827d22da-fb32-1012-422d-d283b28ce5ec@intel.com>
In-Reply-To: <827d22da-fb32-1012-422d-d283b28ce5ec@intel.com>
From: Erwan Velu <erwanaliasr1@gmail.com>
Date: Tue, 5 Mar 2024 03:22:43 +0100
Message-ID: <CAL2Jzuzf54qcsCM4CAUOLaogWrBL=Mm4ma_4pRbaf8A=dZeOFQ@mail.gmail.com>
Subject: Re: [PATCH] i40e: Prevent setting MTU if greater than MFS
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Erwan Velu <e.velu@criteo.com>, Jesse Brandeburg <jesse.brandeburg@intel.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, intel-wired-lan@lists.osuosl.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le lun. 4 mars 2024 =C3=A0 23:10, Tony Nguyen <anthony.l.nguyen@intel.com> =
a =C3=A9crit :
> > Signed-off-by: Erwan Velu <e.velu@criteo.com>
>
> The Author and Sign-off needs to be fixed; they don't match.
>
> WARNING: From:/Signed-off-by: email address mismatch: 'From: Erwan Velu
> <erwanaliasr1@gmail.com>' !=3D 'Signed-off-by: Erwan Velu <e.velu@criteo.=
com>'

Yeah, I have a complicated email setup between my personal and
professional emails.
I'll see how I can fix that.

I was also wondering if I shouldn't subtract I40E_PACKET_HDR_PAD from
the mfs to be more accurate, can you confirm this ?

If one can have a look at what is the exact procedure to fix the MFS
size when too small, that would be lovely/ideal in addition to my
patch.

