Return-Path: <linux-kernel+bounces-156479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D959A8B031A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 09:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94727287D55
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 07:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997C5158D78;
	Wed, 24 Apr 2024 07:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XPLSCmfl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE23158A3D
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 07:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713943282; cv=none; b=MeHpjDjVxIvckGvBIV2czMG9ftF6YiEe3oi++E6SnTxIWsHXbGIIovN6k7IHGKn40RINNyYaxr3ri1hlDWjmC7oFhvDKjD09Hwj/PlIK8CAo8jcks8FepeKe+6+EKY3ThcxOxa/bde2ePQ1DPNqrp5wsKIOu0GGxsiirzB2TPJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713943282; c=relaxed/simple;
	bh=yo10sCOTCq85cFaAQnC6NyfO+wxyu7SYxXfs03uIpew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I2zdYWOHosin/aR7mckOlP3yTxwm1kW20dfHtgLgLrC/njLbcgTTLVEa5Z1COzNAK7YoHvXRMKpiwTl9583DVoLPYaXqfpWaDqeOU9yzkUNATjRMT3gENIhP9LoryAVRJ3r9+a8VEpV6h1JwK2gYIXA71VhszMFGbieOarxZ9Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XPLSCmfl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77684C3277B
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 07:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713943281;
	bh=yo10sCOTCq85cFaAQnC6NyfO+wxyu7SYxXfs03uIpew=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XPLSCmfloq8T/oP3OB8NHhq11ye8mXu1Vifv95c+Af6au1jz/WcK7iAK77M4xVFtn
	 bLbXg2W1yHbIEh9QMQ7lZQPFDRTMU6qZnSCDbTJXl+Sv6762UlfHQvy9Km7ATe1xgH
	 Q0pg7lKCNggZ0vPLSgw8958aQlAlIoL/wYU5riZnRm0J910sqGLcnSJdaZn1zjauwS
	 jWF8E53a6ikKfclAzDNwg8Vf1S1afhKsu51aS+6bt1n2bNPrylJ7z/iGyNUk6+wInH
	 851a4yq5zB4VFUEgfvOzxphhhLtpQSTP00YEPnxstS3jtFCf8kLukhJxPTh5BTo1hb
	 gUIdifMrER3ZA==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-22edec341c2so3179763fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 00:21:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVFjMBuGW/QC6D6b6e/L3lnCOJa/YzbicE+q/C/WxOBN6HqipIukSb4Z88prosm7VQLRvkLNIMcBnFNJrLPROr7Rbctpf6NAOpRjYfs
X-Gm-Message-State: AOJu0YxNn7iMqgD3UiiYs4f4wOiYrTdmoDzLnp5J1NCAQzoYWSxor3h+
	Ijw+aZpR6bvkpW7gtFj1HeFGmxguS3VfHBSPmS+MynA/EeXd/8u3Vd/Ryy1Lh7OmlgVXiiroPTG
	2A7BVXvH63C/5OR8a/SJW/kI2Mqg=
X-Google-Smtp-Source: AGHT+IHW5fgXuqOMVpY2Tx+J8nWc+mX3gSxAg88PIk1pWLvHwBZB7PqIfBqZeeJ36YmWfKZW2d/5zsjWpeSF0EHmNZ8=
X-Received: by 2002:a05:6871:a9ca:b0:22e:bf56:7dc with SMTP id
 wp10-20020a056871a9ca00b0022ebf5607dcmr1599885oab.13.1713943280775; Wed, 24
 Apr 2024 00:21:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e9ead449-6ea6-4017-b26a-3a80ea6d4018@moroto.mountain>
In-Reply-To: <e9ead449-6ea6-4017-b26a-3a80ea6d4018@moroto.mountain>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Wed, 24 Apr 2024 16:21:09 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8=8i+=_Ww9WCN28+9rbLpF__M1F6n_FeavRX2VnKvrBQ@mail.gmail.com>
Message-ID: <CAKYAXd8=8i+=_Ww9WCN28+9rbLpF__M1F6n_FeavRX2VnKvrBQ@mail.gmail.com>
Subject: Re: fs/smb/server/smb2pdu.c:1992 smb2_tree_connect() error:
 uninitialized symbol 'share'.
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: oe-kbuild@lists.linux.dev, lkp@intel.com, oe-kbuild-all@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Steve French <stfrench@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2024=EB=85=84 4=EC=9B=94 24=EC=9D=BC (=EC=88=98) =EC=98=A4=ED=9B=84 3:28, D=
an Carpenter <dan.carpenter@linaro.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=
=B1:
Hi Dan,
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t master
> head:   9d1ddab261f3e2af7c384dc02238784ce0cf9f98
> commit: e9d8c2f95ab8acaf3f4d4a53682a4afa3c263692 ksmbd: add continuous av=
ailability share parameter
> config: x86_64-randconfig-161-20240424 (https://download.01.org/0day-ci/a=
rchive/20240424/202404241435.Yxr6Wapq-lkp@intel.com/config)
> compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009=
708b4367171ccdbf4b5905cb6a803753fe18)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> | Closes: https://lore.kernel.org/r/202404241435.Yxr6Wapq-lkp@intel.com/
>
> New smatch warnings:
> fs/smb/server/smb2pdu.c:1992 smb2_tree_connect() error: uninitialized sym=
bol 'share'.
I will fix it.
Thanks for your report.

