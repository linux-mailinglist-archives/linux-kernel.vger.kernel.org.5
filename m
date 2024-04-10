Return-Path: <linux-kernel+bounces-139437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7218A0356
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 00:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69D401F25D28
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 22:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0B119066E;
	Wed, 10 Apr 2024 22:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dxe512Aq"
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E841B1836E1
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 22:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712788102; cv=none; b=VWsk8m3nf5a+F6FlktrC78IHCjdwOFt/lPksj4txu6gJdjK7fNoFIgTl+maS6ZUMOsg4wBFAjci3keofF6ho8PRn7WVOG+LY/1+lZj9fZtd/AWoGkHvEbkaZ2+AJcqAgiy5GIcnBV3HgT6XImyW0kn+IwfCnY9FzN9h6575Du50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712788102; c=relaxed/simple;
	bh=YH+YCK0TtaM4xpNLgp7r4l7WLrbNv3kRu3yjDoe624s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b7lQ/EwhRxBSvjOuEQwlRUcKJCXCLY31Smd07fkQbT4nDKQjS57RZzMBPaV729mSlxFEuUlHUldzAlnddrWQzEm7dm8OvPHsZdA157RWUjz7Umo1dlz6WSZ4AmuKxQ1oiKeSrWPuNrQS2jOvJ+qdwELJa5hn5Tr2teXCkR52R30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dxe512Aq; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-7e128b1ba75so2532738241.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 15:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712788100; x=1713392900; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BB3ccNjO9MqZA0XBab5NYc/mwf8q7S7CIiocRg95hpo=;
        b=dxe512Aq9/lATeSjgr2uPgr0MfleTkvvlpIbJkcbLJVX0pm163yovwpLg0xo89CkM2
         rg4ifL+po9DRJPuK+G9fMI38El9Bg1w3mBG4Xa+/n1esuW0JvsbM6cAONzrKG9Yuf0ev
         +H3st5tH61oy0BClSHycBl6YLTBk1Rq9JwI5U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712788100; x=1713392900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BB3ccNjO9MqZA0XBab5NYc/mwf8q7S7CIiocRg95hpo=;
        b=QXKU4cxpmsShVZvvsCUz3nWDtdcc2cZTDP/4vNsWbpNgmTIHSuzPkrAKtHWm4vct84
         k1ZBwIoMsBcX3NB4vzEzgWfplgE/F33woCsm6kgU6HTWfmxuU7klY6qs42UTdx8HhRV5
         mkhvES9+7dGvDO8M8WZsr712cQKw5VUovMAXbbOi6cwD8jJTq2GzYehD/HrzrxAHueLy
         Svvb0bE/EqRtVdtkfgY5riXC4cduIsCc+BftY2Zv3Zx0qwsz+eAcGfKdG2bwCJyhI5J1
         R/3ucKWVyMlFvwj/oTzwVKamJsTygD2KBi3fmXrRhN/CyEsGTxmECayaBgOmNDwnKtr/
         nxig==
X-Forwarded-Encrypted: i=1; AJvYcCUXfNJqWhuvFE4GaGcgPM93H3b7eEWSuCHXSv9n1Tj2Uc+YhNF5g6KW+J0nPMSNlb/RCYG0D1QOqfjLwB0Ika1o2NTLJlBH5uxaz9E4
X-Gm-Message-State: AOJu0Yx6PE+gCZvS5oZ/o/hwuaOFpxbbrmxzuT7Nl/FCqu2NvY8AAR6T
	W5YGPL2EUR4NEyfPqaI8R2zs+JHsj6qrfvqfyXa5QCNwui7v/UMq9QeD9hMdSr6fCoYUqnSVNL0
	ojR7jzQwAqD0b5EpbdLSe/z+Ugo05NL8GBHlw
X-Google-Smtp-Source: AGHT+IG0DYJSZA6M/0G7T2aTS2ZJ/iILrEXt6TniERHXXkQOUOrG3LvxlW3P/tXtGQZaaYSu1vjHu2wxuT1qlaAsDFc=
X-Received: by 2002:a05:6102:2092:b0:47a:23bb:5302 with SMTP id
 h18-20020a056102209200b0047a23bb5302mr3103418vsr.11.1712788099606; Wed, 10
 Apr 2024 15:28:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240409-public-ucsi-h-v4-0-e770735222a2@chromium.org>
 <20240409-public-ucsi-h-v4-2-e770735222a2@chromium.org> <2024040916-kleenex-machinist-4858@gregkh>
In-Reply-To: <2024040916-kleenex-machinist-4858@gregkh>
From: Pavan Holla <pholla@chromium.org>
Date: Wed, 10 Apr 2024 15:27:43 -0700
Message-ID: <CAB2FV=6We88NrvN8NZYt8NkMFH9N_ZBGyUWVUpGwPdja2X_+NA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] usb: typec: ucsi: Implement ChromeOS UCSI driver
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, Benson Leung <bleung@chromium.org>, 
	Tzung-Bi Shih <tzungbi@kernel.org>, Guenter Roeck <groeck@chromium.org>, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, 
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>, chrome-platform@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I plan to upload the next version after related EC changes land on
ChromeOS. That might take a few weeks.

On Tue, Apr 9, 2024 at 8:16=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Apr 09, 2024 at 02:27:37AM +0000, Pavan Holla wrote:
> > +#define DRV_NAME "cros-ec-ucsi"
>
> KBUILD_MODNAME?

Will replace DRV_NAME with KBUILD_MODNAME.

> > +
> > +#define MAX_EC_DATA_SIZE 256
> > +#define WRITE_TMO_MS 500
>
> What are these and why these values?  And tabs perhaps?

MAX_EC_DATA_SIZE is the number of bytes that can be read or written to in t=
he
UCSI data structure using a single host command to the EC.
WRITE_TMO_MS is the time within which a cmd complete or ack notification mu=
st
arrive after a command is sent to the PPM.

Will add comments and tabs.

> > +     uint8_t ec_buffer[MAX_EC_DATA_SIZE + sizeof(struct ec_params_ucsi=
_ppm_set)];
>
> That's a lot of data on the stack, are you sure you want to do that?
>
> And are you sure you are allowed to have this data on the stack?  It
> never ends up being sent using DMA?

I confirmed that this data isn't DMA'ed. However, I don't mind putting
it on the heap, and will do so in the next version.

> And please, don't use non-kernel types like "uint8_t", use "u8" like
> intended.  This isn't userspace (yes, I know a lot of kernel code uses
> these, but as you are going to change this, might as well change that
> too.)

Ack.

Thanks,
Pavan

