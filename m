Return-Path: <linux-kernel+bounces-125116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA5C89204C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 16:22:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 609781C27E70
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755512032C;
	Fri, 29 Mar 2024 15:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="djX+2aS3"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E245B1FBA
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 15:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711725202; cv=none; b=DZju2R8NzedAIlfJIM2WHwrxkiT17BaiiOCGI3qcyx5LLn884F3DT2HfVB/99D6VysAO5VSPFgZmz1bcQ/0s5f3KnwZF0LIqNksZbJ8Zd7NnCVR3+qjePEaPXXezALs/QLf1hWX/rmo/lnbEWb3tePbK9ALdjmOX1Yr7W0v2HR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711725202; c=relaxed/simple;
	bh=HZiOyoM4VReLCl+X3HGduolzIuLdTAfpmEDmlPASeuI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WKngaJ65F33Me6O18QpmnUibzjbwbitoBZlb7kfcwLCUNTD0inftr4NR0rU/MD5QRjBY3tEwg+1aRbJSlArENOXsRtm6uNMs/r6yNqyEV74QNEe1RgKoZ4fNPHLHXsfajvmIrrYY4HCmMeCxfWEFDyav/drN1wvfIZqFEHg/rUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=djX+2aS3; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6145a4c79cfso3239117b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 08:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711725200; x=1712330000; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HZiOyoM4VReLCl+X3HGduolzIuLdTAfpmEDmlPASeuI=;
        b=djX+2aS3pWI4vhKDEMK2bsBNCLGQllZFW7EJyzjtNIU0aMmIqdTS7ayaPlFHczVMLi
         Sn4zxIN/jM0BArCoSfdUYlBBRSBPcyU44TEz4+4nVlqIiebjpGWhb3izL0WR3X06JMNd
         Gz/PHTenWtWTk9Io1GqgU+HGjjnWtIOrVs1uDmrOoB1OsoYV+oXBMyw33rZJWGlfT4Pt
         87DQ5Qu2GZDVmT5aa3xJob4OFry1zrYql6dhgR48/syyLjDeQ0rkC9NVIk0dxSuRaqKX
         kDVbJNJpxofTwwT3nduleOPwsr1ThUjlE9ot3ru1qHVcXqyoe5OcxXoYErPqUmTHZO6/
         EUrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711725200; x=1712330000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HZiOyoM4VReLCl+X3HGduolzIuLdTAfpmEDmlPASeuI=;
        b=SJ41dnHans0MU91ICVLrwxmph/Xh4PutoQtx1mpw8Y0R/HaEMDkoeSjjXuN83fjWze
         iDkSAA+PangDLWb3KAt4fm6y0r6EtxsqcsnromD0fAJHUV/IEJTVvb2c3LPAFKnPheo0
         E8bSpBiv05srqKF/AABKwtbmcamWFR56/kBrsg/4WNtudVcBQFjWTn/WsU0+dDMXBQjm
         dfRMCSX9KJ2sDEVbHkfpB98WBdnDSokOSJqhlaYvRX7FGmlc/IIPHmyHQQk3xWA/5RO0
         Ou5PRsxkzd3hIkDBNDOS6qWqtlB7Jh4XL4EWqmIXwLl5ufli+kTC4uHZHPiae3Cjmrx/
         HvYg==
X-Forwarded-Encrypted: i=1; AJvYcCXMpPTjeYdijqQv1X7v716gdrMC4gyvB71vCGv6Z6sUzb3UF7PU6dbiAZXxlGOmmhOOjrHEu0O8w5PXBdyd1YAMfn417bD43YL+oEmK
X-Gm-Message-State: AOJu0YxXjLBrTBZ3l5x1bTyzRcAKXG4nVKo0ly4yJYFUBuB/KFQoRBQb
	JDNl3AWSQhIQEMNMexPZUBDBJOBAzoNb/FlCNzYEQv28DP7cloVoaD6B43fIJL4Z/BVpIc3KZxk
	x8vMUBERnc5/bcf1uLkWR7tQ8F6P5+MQOtz3u9g==
X-Google-Smtp-Source: AGHT+IHF+X6lAFwbbieIRJcKZCH7PclLjdVuA/2sH7ZxvnkV8S/IDSIfi8m2Dyjx59O7tKG7z0wumej4bOA5crbW44E=
X-Received: by 2002:a25:aae3:0:b0:dcc:97e4:bc61 with SMTP id
 t90-20020a25aae3000000b00dcc97e4bc61mr2648037ybi.57.1711725199846; Fri, 29
 Mar 2024 08:13:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325-public-ucsi-h-v2-0-a6d716968bb1@chromium.org>
 <20240325-public-ucsi-h-v2-3-a6d716968bb1@chromium.org> <1b040be3-acd7-40dc-bc9b-24ea6d4b8377@linaro.org>
 <CAB2FV=614YLrsj6yPxRd1uVsF4n3EabLoXwL1Mtrk9Eg+5Mo9g@mail.gmail.com>
In-Reply-To: <CAB2FV=614YLrsj6yPxRd1uVsF4n3EabLoXwL1Mtrk9Eg+5Mo9g@mail.gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 29 Mar 2024 17:13:08 +0200
Message-ID: <CAA8EJprn_95+ZnwmAHEQpQjQqZ5-Na1pj32TCY5BFMt7Uv7eWA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] platform/chrome: cros_ec_ucsi: Implement UCSI PDC driver
To: Pavan Holla <pholla@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Benson Leung <bleung@chromium.org>, 
	Tzung-Bi Shih <tzungbi@kernel.org>, Guenter Roeck <groeck@chromium.org>, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, 
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>, chrome-platform@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 29 Mar 2024 at 17:09, Pavan Holla <pholla@chromium.org> wrote:
>
> Hi Dmitry,
>
> Thanks for the review.
>
> On Thu, Mar 28, 2024 at 8:32=E2=80=AFAM Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> > While it's fine to use platform/chrome for platform drivers, please
> > place drivers which have a subsystem into the subsystem dir. I think we
> > don't want to hunt UCSI implementations all over the codebase. Please
> > use drivers/usb/typec/ucsi/ location for your driver. This also removes
> > a need for a global header.
>
> I agree with your assessment that drivers/usb/typec/ucsi/ is a good
> location for the driver currently. However, the driver is still in
> early stages of development. We may have to account for PDC/ EC quirks
> (we have multiple vendors), add FW update functionality outside the
> UCSI spec, or add PDC logging functionality. While I'd like to write
> separate drivers for those, some of this functionality will need to
> acquire a lock over communication to the PDC. Even if I were to write
> separate drivers for new functionality related to the PDC, maybe it's
> better for all ChromeOS PDC related drivers to reside in the same
> location. I am not sure what form this driver will take in the near
> future, thus I would prefer to keep it in platform/chrome. Maybe
> cros_ec_ucsi isn't the best name here, cros_ec_pdc probably conveys
> the intention better.

In such a case please consider using auxilliary device bus or MFD
cells to describe pdc / ucsi relationship. See how this is handled for
pmic-glink / ucsi_glink.
The drivers/platform should really be limited to simple drivers, which
don't have a better place. Otherwise it becomes a nightmare to handle
driver changes (this applies not only to the UCSI but also to other
drivers which have their own subsystem tree).

--=20
With best wishes
Dmitry

