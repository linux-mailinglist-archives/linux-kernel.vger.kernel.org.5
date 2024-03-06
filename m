Return-Path: <linux-kernel+bounces-94099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F3B8739E7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2AB01C21315
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61691134CC0;
	Wed,  6 Mar 2024 14:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k8OQj27Y"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CEE113473B;
	Wed,  6 Mar 2024 14:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709736974; cv=none; b=DbiIpDF69HFPiVwm+IvREtgrj/Bh5nAEDzheOfg5ymJCd/BuQVUS6UPpIUvmyHxq7tHaxpGkKXniNA1JVysAkyuB5hX/Xd2giM37dN0yAF85K6Uah8KHyo0IVe0tjQBdcn9bxrBlsbTw2m72hYa6V0FLSThzgwsWUEyy4+Ro7fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709736974; c=relaxed/simple;
	bh=CyxIq1hc0Pg4DlvLuQjoD77rmVt1bi1Xy2iXBKgigWk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CC2FTeQrjC+rmvDReyiNzi5ExdzOG4vFVnWhIHvrhvBpV7YaN/n4zKuF1ljLLt7o1vnH+jCFtXxlqApzgQ1E1wBLuFnlZ1JsVhvbRqfd8AxDKnHVibH51nLKRy++xiaAa3PLFTWSkQ6wo+2Vt+MMXodQd/fmiT0/ODjr9O6v6h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k8OQj27Y; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-29954bb87b4so4578775a91.2;
        Wed, 06 Mar 2024 06:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709736972; x=1710341772; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qdH3H/B03w3oeOKNshM2umjOgNwIvpOsc9RqYT8vJJI=;
        b=k8OQj27Yyn5Vjf4kqeANfsBDSeJ0xwIgfb6J/QSGFttXolKulYjIVSQvGcSIFWEGv/
         H7rRoTHDYhnwfY+ivN06jfvkR2syWPSnfHoPUR8jzD9ZTyXjglFK6sH1BriNelOSySXP
         oame3gajzzAdseraSspZo4D5/EDDKlpeKDViC9OzNgrWT/Gic0n3pm07IrNnx26X7LAz
         qaEMFtwVi/nuFU3GslYqIAIYKGIVO1fmkFv+HRhsf5GTPXhahK99XAEv08tXks6Ex+Tk
         qS0ept7Th1qP6iukQjaIl3b7TgFc8OYgJ7mcdFMCSncMnd8/QUs2EshX50HKJNnsiUmK
         Qn2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709736972; x=1710341772;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qdH3H/B03w3oeOKNshM2umjOgNwIvpOsc9RqYT8vJJI=;
        b=rVBosi3j6nDxHoE9LxaIdbMtp57hCgTYaXqYLgZ/1bN/xJJpV/592C26hrITsL1MXu
         ui0Kzo3ZQmKXvU8P/UghTB4OiHqYNU+rrfDt0GGrxHbvTDCvqE+bCB2p7mKq2pH+XkuK
         lRODGOBy+f6+PoAYFVfUNaJYekNB00uFHIkEIKfYfOJYRE+VsGqQtcNdOR4aLI/F8kqO
         zAieppL++bP92ZM73HfxXuOY2BmDdksKdswVtv70GKeIeDAIYXpblPUtESVfZxJMZBYM
         Jr8lXwbN2C1W3OKfE9cfzISgx6Jlb+LQUWJxpS8W4mI4c7DdsD7sYeLJIr11QPdg2gxg
         WYcA==
X-Forwarded-Encrypted: i=1; AJvYcCW5zZGrH3fILml1deJWRREHoSKJ5C42IV+7gsd4y1JP1fOTroL5SAB+HHYsdt99mU+3XLwABZrnX9XoqaQWeTZcS6dq3zXwrX4eWK5c4fZbkPx3VP0g6l9fC/C09qPau6SUkQl4
X-Gm-Message-State: AOJu0YyjYupX507TM79QgGTXkW4MjZLaYeV1DiGEfo4HK3tHL1z6Hq0D
	NPJYy4JEK5EU+12VcjFIabzSek4u004W5DNitKe/v7MCicq/49hj0+2UgN+Iu3nM1CmicGXq5Ed
	tii0Z8ws0jG6XrVAblTVoKQJOPXQ=
X-Google-Smtp-Source: AGHT+IE1Ifk2gRIsxJGsFMox+naGDQZbZsHvmMPliQl1ubSLocfF/8HdJ7TMoRwN8u/u/pDBMuXVrz0M0siJ9kYinmM=
X-Received: by 2002:a17:90a:d514:b0:299:782e:25b0 with SMTP id
 t20-20020a17090ad51400b00299782e25b0mr12209886pju.8.1709736972572; Wed, 06
 Mar 2024 06:56:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304211551.833500257@linuxfoundation.org> <20240304224813.73380-1-sj@kernel.org>
 <CADo9pHi0az-CL_hktmpCVcuoiDaUJn2U208=TwAvBM6YQhfFqw@mail.gmail.com> <2024030653-reforest-gauze-149e@gregkh>
In-Reply-To: <2024030653-reforest-gauze-149e@gregkh>
From: Luna Jernberg <droidbittin@gmail.com>
Date: Wed, 6 Mar 2024 15:56:00 +0100
Message-ID: <CADo9pHi--q0XrROk=NXkf+YBHkj6s3JsWKpJgMJU5judaJrKwg@mail.gmail.com>
Subject: Re: [PATCH 6.7 000/162] 6.7.9-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: SeongJae Park <sj@kernel.org>, stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	damon@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Den ons 6 mars 2024 kl 15:52 skrev Greg Kroah-Hartman
<gregkh@linuxfoundation.org>:
>
> On Tue, Mar 05, 2024 at 12:05:33AM +0100, Luna Jernberg wrote:
> > Works fine on my Arch Linux desktop with model name    : AMD Ryzen 5
> > 5600 6-Core Processor
> > after the Arch Linux manual intervention for new mkinitcpio settings
> > and version in Arch
> >
> > Tested by: Luna Jernberg <droidbittin@gmail.com>
>
> Nit, this should be "Tested-by:" without the ' ', otherwise our tools
> will not pick this up.
>
> thanks,
>
> greg k-h

Alright resent the emails with the right tag format
sorry for the trouble

