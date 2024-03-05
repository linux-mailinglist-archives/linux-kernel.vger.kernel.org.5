Return-Path: <linux-kernel+bounces-91448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7928711A2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 01:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD8711C2191F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 00:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D72910F7;
	Tue,  5 Mar 2024 00:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bA+suA2x"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5EC38F
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 00:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709598320; cv=none; b=MQkQYjbNwGqrP9bPMJYHTYMyVNxeqInFeMxm/vrJ4o8QtJkHfJ6S6js+RIBMKvd19R9D3MqLaUz5o8ngb1StbFfIx9E503QhSk0k1/d8CxiwhEz12ipoyqUnOMTdUeV/Y/pFL99qg/1o+otv0L/0ptdKd2whFYrKvMkE8M89Wsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709598320; c=relaxed/simple;
	bh=YBogo24J4oBkTlnWGyxK72muXgmgt39KFTxP1mpezRI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=naij6RZBKOxehEp2iN0oNwNmXjGf1lezqbJpcKUKAroyuvQxzw4e3CCzfreCuHdtgPLT5J8wmdyF6O2Z924mg1FGZegRYWSxAS+rCgDHyOSKZ/jDkRRxRgr3H5v68yce10fhS7D+2TUvaSvTXu5+P5VJ4FbZGOOkFW7+oXAZgyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bA+suA2x; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d288bac3caso62405051fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 16:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709598316; x=1710203116; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YBogo24J4oBkTlnWGyxK72muXgmgt39KFTxP1mpezRI=;
        b=bA+suA2xrKdibDvtfkDM4o8vPaDhdOOljTjQs48pp/RzrNGEfaRnD/GjpWt31BMCHO
         im3CO6GGPdhO95S/aVFW2gIHNO/p7n6bKRBccXb93wQXm5Zbq6yAJzYPQX641oIlDJvq
         NqA34feuNsZ3nd4wXNoEAf9uj92N+7cHGDooM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709598316; x=1710203116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YBogo24J4oBkTlnWGyxK72muXgmgt39KFTxP1mpezRI=;
        b=qQlDvo7CZFp0GD3Vb7Bh99wcITwViHUhJ5C4pKKbwR8DFBr7m1DgQ+IGnizTuuR9UR
         JjkUJhT8aPbHtvqpQ8Ee/nPtdFu8VGa2rpExRXut384VMM8fl5ALaDLct0NQZ512FXvR
         9WJSIrn/o3AKMOJGurZ08AoAAK1T+1Do9dHda+TKqunOCYjckfXl8m0H0qF66U8V3bXv
         bJ9d5ROpnNohxDAiDU0MB86quIwwybbWQRbu66FN/G2Gx7ptBFPHKxrvrxRwxQKMj6MD
         s5EirYMkCcwziCcqky57iVPDxTqOf8+n+potCyujCqgPaWVWGgzoa8WUar3wKeZ0H/Ec
         idug==
X-Forwarded-Encrypted: i=1; AJvYcCXy5BSrrx2l3UQ7cM6cC45Z+y0Oj+IO17Oa8KePLRLuPZgqHOKw7fNYMeJN4dW8AVox8M3bPe21HhvViii4Ohh3/nVd17PdXDAFuDkG
X-Gm-Message-State: AOJu0Yz9QxYpNxT25dHTnL03Y4o9UKAsoI9It+EB9IlKF6Qz5UWTtlm3
	x3pwx1VkuzBVB10mfGiMCd5sVl4jR2F4pbYeAxcTpSltfRIx2jxUcsP+cv2T7Q4Lwf+EIy5j4v6
	gwy7w
X-Google-Smtp-Source: AGHT+IGW9cGHqEysPgMaUYZ+A8/RgEztUlp9Pd6ekPS8G+FdK8DHXt+3qxIcgz7u4S1goQ8TWf8kFA==
X-Received: by 2002:ac2:4e08:0:b0:513:49f7:70f with SMTP id e8-20020ac24e08000000b0051349f7070fmr207594lfr.57.1709598315759;
        Mon, 04 Mar 2024 16:25:15 -0800 (PST)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com. [209.85.128.43])
        by smtp.gmail.com with ESMTPSA id lb10-20020a170906adca00b00a45380dfd09sm1947403ejb.105.2024.03.04.16.25.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 16:25:14 -0800 (PST)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-412c79213c8so14225e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 16:25:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXEIwnywMX3R+MDO58zzyh4JzA745AVz/jg8WWWv/TaDgfAusIg4KBCXOt2hxNhv44n2m2tpE/XQsjfNyhLBVEgdOsPjLTuwkAK+f9x
X-Received: by 2002:a05:600c:34d2:b0:412:e426:a1a7 with SMTP id
 d18-20020a05600c34d200b00412e426a1a7mr22561wmq.1.1709598314010; Mon, 04 Mar
 2024 16:25:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304195214.14563-1-hsinyi@chromium.org> <20240304195214.14563-3-hsinyi@chromium.org>
 <87a5nd4tsg.fsf@intel.com> <CAJMQK-j4wGah=szyUW53hu-v6Q4QjgR7WMLKnspoFaO9oPfaQw@mail.gmail.com>
 <874jdl4k01.fsf@intel.com> <CAJMQK-iWHoh6s-hkcNULzZLjMg9UnTuWfjaJ=YfnHU3sQ1NBEg@mail.gmail.com>
In-Reply-To: <CAJMQK-iWHoh6s-hkcNULzZLjMg9UnTuWfjaJ=YfnHU3sQ1NBEg@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 4 Mar 2024 16:24:58 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UOhTGnhtc9gOQ5C_aAdgVcB+K7NL9RGm4umunF91Wkpg@mail.gmail.com>
Message-ID: <CAD=FV=UOhTGnhtc9gOQ5C_aAdgVcB+K7NL9RGm4umunF91Wkpg@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] drm/edid: Add a function to check monitor string
To: Hsin-Yi Wang <hsinyi@chromium.org>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Mar 4, 2024 at 4:19=E2=80=AFPM Hsin-Yi Wang <hsinyi@chromium.org> w=
rote:
>
> > > Probably change to u32 drm_edid_get_panel_id(const struct drm_edid
> > > *);? Given that we still need to parse id from
> > > drm_edid_read_base_block().
> >
> > No, we no longer need to parse the id outside of drm_edid.c. You'll hav=
e
> > the id's in panel code in the form of struct drm_edid_ident (or
> > whatever), and use the match function to see if the opaque drm_edid
> > matches.
> >
> drm_panel prints the panel_id info on whether the panel is detected or no=
t.
> https://elixir.bootlin.com/linux/v6.8-rc7/source/drivers/gpu/drm/panel/pa=
nel-edp.c#L792
>
> Is it okay to remove this information?

Hmmm, I guess it also is exported via debugfs, actually. See
detected_panel_show() in panel-edp.c. We probably don't want to remove
that...

