Return-Path: <linux-kernel+bounces-59758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A7484FB70
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 19:02:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DD161F2A5E1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 18:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22C07FBBC;
	Fri,  9 Feb 2024 18:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iJiRiBSR"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D357BAF3
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 18:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707501682; cv=none; b=tiAjzNktHq0PxrTuNm+kt09gbXi/RRPoX7Gdst6WN/e04ybc1Mjm5X2m9E+waT5de7O3AgJvXCVEUB7YwQQ7B3Gg5cLonCWnzbjU4YkGL8o4ODwrGFZ3MsVmDusGMT1ZYgqOfFZhm/Bd68ADQpTV44L154XmBTaAEeSOZ6q9oWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707501682; c=relaxed/simple;
	bh=tWnDDTX6hjvn4zZMWScUR1a3jczggxxhhlZFG78n9SA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EcYugDox1vvpmAChy5Xl+aJSHV1yjoUiwdzEc0c0sUeJUKuIdiKBet2s2JT/p9TlGds1qW6+KeM1C0WpUP18LncfKuXN3XZ2PRCaSMYUQ12s23hGIBcAyuqf9l01iIey2/R/2XKfLFZQ6XNnmD+LnUyuINdIp5RrWFoRa+CUrr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=iJiRiBSR; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dc74e33fe1bso1234148276.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 10:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707501679; x=1708106479; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DxAXd9578hDdusxvxqROEMfzhHSW5iLGGo5hRVlkaFc=;
        b=iJiRiBSRIncIsn3DVJ3tybiJ+sQA+7Bo4C9dA7k4FZy+QZLxXnRINZ/f9SR1DWhd5/
         NHDhBlALK6qguizN8lwDn9SMBRvnD5mq+WraiRliah9nM31AXpcgM0vC5Zk4va+xuIZV
         S5XZgZwsgRrJM+NDv86NLYComeWGhcp3nRE5o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707501679; x=1708106479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DxAXd9578hDdusxvxqROEMfzhHSW5iLGGo5hRVlkaFc=;
        b=sLtPI0cAv8k8Bkzss2FMn/gxXPyi/YDjZW9NlFihUPqnS7yvRQ+mU0sArFdqCw+jwi
         2iEkbuZjNjip+pgXE4FjFqVXoRYwjX1MX1n7Y/hqNvnDT996bHvhwP1dAfqO8OhgPJHT
         oG8OQdIKOGnMhYpenPYqUHiar/zIZTOQDge1SbU8uu6t11KCXYc+olfXBaTzvLJbZ4mb
         V5u1dHrw7ZfXFuJswvxd9yEmMmAHjtiFmCh/aMwpuw/jT6CC3BIScss4KRoqcZlfkkuZ
         g1VEiZexbrEC51zbWYmrzj/CDiIMRXPERehXwLkr3aoEhbz9hmnfxC6E5wtEHjCltAx7
         F0Sg==
X-Gm-Message-State: AOJu0YxMx5ZhYBSUg0jF3tfpzzbsmhoORAUe0tGwAHrj27MHJtg9KN37
	uaXy1l4SgE70QFGTl9CY6tnRonYk3Bh10tNZMPrZP25Gm0bEZBqfxO44qIzYhEN8szoI43fvXUD
	seqTIh5Zms7oYeVzZiRD87oTJhByuJ5eAVMye
X-Google-Smtp-Source: AGHT+IGn0jV1pZIEIiivUmj+U1vOUnk7Ltih/wE24bOuFmmcWlsGf0dF5J3/tWHDdX/y20KgLcQrUQao7heE0UcjZN0=
X-Received: by 2002:a25:9cc8:0:b0:dc6:19ea:9204 with SMTP id
 z8-20020a259cc8000000b00dc619ea9204mr1878634ybo.61.1707501678528; Fri, 09 Feb
 2024 10:01:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209060353.6613-1-abhishekpandit@chromium.org>
 <20240208220230.v4.1.Iacf5570a66b82b73ef03daa6557e2fc0db10266a@changeid> <ZcY2kVlUn7SJ5pW8@smile.fi.intel.com>
In-Reply-To: <ZcY2kVlUn7SJ5pW8@smile.fi.intel.com>
From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date: Fri, 9 Feb 2024 10:01:07 -0800
Message-ID: <CANFp7mW0F_zyaKJg0LusT6Cp4h0_8Z4jq+R1GUGtpyZrv99iVw@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] usb: typec: ucsi: Limit read size on v1.2
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-usb@vger.kernel.org, 
	jthies@google.com, pmalani@chromium.org, 
	Neil Armstrong <neil.armstrong@linaro.org>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hans de Goede <hdegoede@redhat.com>, 
	Rajaram Regupathy <rajaram.regupathy@intel.com>, Saranya Gopal <saranya.gopal@intel.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024 at 6:28=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Feb 08, 2024 at 10:02:38PM -0800, Abhishek Pandit-Subedi wrote:
> > Between UCSI 1.2 and UCSI 2.0, the size of the MESSAGE_IN region was
> > increased from 16 to 256. In order to avoid overflowing reads for older
> > systems, add a mechanism to use the read UCSI version to truncate read
> > sizes on UCSI v1.2.
>
> ...
>
> > +     if (ucsi->version <=3D UCSI_VERSION_1_2)
> > +             buf_size =3D min_t(size_t, 16, buf_size);
>
> Please, avoid using min_t(). Here the clamp() can be used.
I think this is likely the 4th time I've been tripped up by an
undocumented practice in this patch series. <linux/minmax.h> says
nothing about avoiding min_t -- why prefer clamp()? Please add the
recommendation here
(https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/in=
clude/linux/minmax.h#n10)
and I am more than happy to change it after.

> Shouldn't magic number be defined?
The comment right above this line documents the number.
As this is the only use right now, I don't see a need to make it a
macro/constant yet.

>
> --
> With Best Regards,
> Andy Shevchenko
>
>

Cheers,
Abhishek

