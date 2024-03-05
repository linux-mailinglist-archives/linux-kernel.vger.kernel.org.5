Return-Path: <linux-kernel+bounces-92883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49093872786
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 20:25:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0094A282913
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 19:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F3638FAF;
	Tue,  5 Mar 2024 19:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="a/S6N4L4"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF251AADC
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 19:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709666743; cv=none; b=IDi1ZC69LPYoDoAbstPxw5SppeaJXplYYgqyQJIKPrxaKI/cNlQoxrJtcWe9siclPt3oLk6c2Cum3jlCOv/lCy1o78BL1W03g6O6Mwt3lCmoLR8pd1UueAM24XjvFmRezu4OtrUlr6NrCR7iNQv4mWr+HNk2mq2JXa9h4klasxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709666743; c=relaxed/simple;
	bh=lH9upXPo8fAqoa2VSZfcmS1U9Z4D2hFBTDPU4cgRW0c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GeqxbOWrjEzvBbzakeLD7lGK31i+ruHBU2jBwR2/aurb2oZ5Dlwb4CV8oP/I1hNyRVthSG11MJqacawXY7gGiQWDZGcPzWUvfbS/O6E4u3C4HHRljO2PggO0nBx49xcE8kO5bLU3MiLq3k+1u7M9Rabo/nOdn8W8IW1nO7nwLsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=a/S6N4L4; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a44d084bfe1so459999066b.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 11:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709666739; x=1710271539; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PI3ziWecqb71x1qdwv3LFcK01YCTBUMC8i/sCtMexTo=;
        b=a/S6N4L4Mu5sim05OY1B/YOUUT5hSlvJ4jdHP+eXSSqrzYVEtZT+7Eiem69FNEmoMe
         lZv5w2ruWRpo1cKy4EA7EoseWvcfZek1XfrjkYoLGKko1bn7FnQ1vxmsFyJtpF00NUNq
         3O9L+Vn15uXH4JsZXJVFCm1V9Bi0VqqU4DgFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709666739; x=1710271539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PI3ziWecqb71x1qdwv3LFcK01YCTBUMC8i/sCtMexTo=;
        b=somcRniQdFEIxP6fSyNfFb0tAOrtQ/qWcloQWyenCKuhpqgxwbMskqawOyStbGEhss
         zLoUBW1yG2Q61TDPo+CvLBmT38odM265//NfZzrifbBoz7NhoVnBWpS+T/cxQwD2Q/V/
         HpSeff5t/17XwpG+EqlzvYuqZfv3ZItCoqe+fJTnLtQO0HlCCbJFmXIrgBqg/hnsCk8M
         MU8u3P+ew+T3VzGW0/sHFaGWZd2CsaonYmqd7h1Ts30QlQGiB3eYWSvEGMcED1aX4PCW
         7uqJBZEdbkEeOD6znx8aIcsIF9697BsnlTuRg4MdVkpBoZgW49Djefeqjprf6g/bd5LA
         rvQA==
X-Forwarded-Encrypted: i=1; AJvYcCW6yr5Ldy1CfZeqVvZyrgyOBDssQl1LDtjQyOXxvzyohHGr/h0ze3nOIamMKreOkVMzjGsi/3y9JV+tT4DPZlZik5l9Z13GkbmVsTL+
X-Gm-Message-State: AOJu0YyOBwUZAxAGnHRXprFmNdkD6rYtl3TZfSG7xQpjwYLVpQyCR6y0
	ZL4OD81zoayA6P6J01R5vWSRivZ526c15qt5fibRUzsxrU/Hku+Qfyr0dNq4UyyOWafqxnLiKLU
	5DA==
X-Google-Smtp-Source: AGHT+IGfAVxKJBS3UUZFqyGkyDfs+xwfPoYqbjHJfyQp5q7JWej5AMTo7FDd6AIfKDJ0ztVsuIom7Q==
X-Received: by 2002:a17:906:4a10:b0:a43:2c94:9420 with SMTP id w16-20020a1709064a1000b00a432c949420mr9342625eju.60.1709666738915;
        Tue, 05 Mar 2024 11:25:38 -0800 (PST)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com. [209.85.128.41])
        by smtp.gmail.com with ESMTPSA id mp4-20020a1709071b0400b00a3d11feb32esm6364555ejc.186.2024.03.05.11.25.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 11:25:37 -0800 (PST)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-412d84ffbfaso12875e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 11:25:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWHTMRofFqXv3qruUwMUt0UzX7q5zyMR/Wuu5mDxoebQuSZtxfOuJuOda0II6gDmbSmsFrHk6V6WAyD3bymg8hbyiS52Sf1Sia7jbR9
X-Received: by 2002:a7b:ce91:0:b0:412:d6be:a32b with SMTP id
 q17-20020a7bce91000000b00412d6bea32bmr209479wmj.6.1709666737510; Tue, 05 Mar
 2024 11:25:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304195214.14563-1-hsinyi@chromium.org> <20240304195214.14563-3-hsinyi@chromium.org>
 <87a5nd4tsg.fsf@intel.com> <CAJMQK-j4wGah=szyUW53hu-v6Q4QjgR7WMLKnspoFaO9oPfaQw@mail.gmail.com>
 <874jdl4k01.fsf@intel.com> <CAJMQK-iWHoh6s-hkcNULzZLjMg9UnTuWfjaJ=YfnHU3sQ1NBEg@mail.gmail.com>
 <CAD=FV=UOhTGnhtc9gOQ5C_aAdgVcB+K7NL9RGm4umunF91Wkpg@mail.gmail.com> <87y1ax2iu1.fsf@intel.com>
In-Reply-To: <87y1ax2iu1.fsf@intel.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 5 Mar 2024 11:25:20 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WzLLeEw-b0Kug-Pm-9EYm7eHvmukEUJ8VHnu-4YY3WNQ@mail.gmail.com>
Message-ID: <CAD=FV=WzLLeEw-b0Kug-Pm-9EYm7eHvmukEUJ8VHnu-4YY3WNQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] drm/edid: Add a function to check monitor string
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Hsin-Yi Wang <hsinyi@chromium.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Mar 5, 2024 at 12:17=E2=80=AFAM Jani Nikula <jani.nikula@linux.inte=
l.com> wrote:
>
> On Mon, 04 Mar 2024, Doug Anderson <dianders@chromium.org> wrote:
> > Hi,
> >
> > On Mon, Mar 4, 2024 at 4:19=E2=80=AFPM Hsin-Yi Wang <hsinyi@chromium.or=
g> wrote:
> >>
> >> > > Probably change to u32 drm_edid_get_panel_id(const struct drm_edid
> >> > > *);? Given that we still need to parse id from
> >> > > drm_edid_read_base_block().
> >> >
> >> > No, we no longer need to parse the id outside of drm_edid.c. You'll =
have
> >> > the id's in panel code in the form of struct drm_edid_ident (or
> >> > whatever), and use the match function to see if the opaque drm_edid
> >> > matches.
> >> >
> >> drm_panel prints the panel_id info on whether the panel is detected or=
 not.
> >> https://elixir.bootlin.com/linux/v6.8-rc7/source/drivers/gpu/drm/panel=
/panel-edp.c#L792
> >>
> >> Is it okay to remove this information?
> >
> > Hmmm, I guess it also is exported via debugfs, actually. See
> > detected_panel_show() in panel-edp.c. We probably don't want to remove
> > that...
>
> You currently print the information via panel->detected_panel, which is
> a struct edp_panel_entry *. That doesn't change. It'll be slightly
> restructured to contain a struct drm_edid_ident, which will not be an
> opaque type.

Hmm. As Hsin-Yi pointed out to me offline. Somehow we'll need to get
the actual panel ID out. Right now in panel-edp.c we have:

dev_warn(dev,
  "Unknown panel %s %#06x, using conservative timings\n",
  vend, product_id);

Where "vend" and "product_id" come from the panel ID of a panel that
we didn't recognize. For instance:

  Unknown panel BOE 0x0731, using conservative timings

We need to still be able to print this message for unrecognized
panels. Then when we see field reports including this message we know
that somehow we ended up shipping an unrecognized panel.

Any suggestions on what abstraction you'd like to see to enable us to
print that message if everything is opaque?

-Doug

