Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEC077E2E46
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 21:39:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233009AbjKFUjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 15:39:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232927AbjKFUi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 15:38:58 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52543D75
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 12:38:53 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6ce291b5df9so3133970a34.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 12:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699303132; x=1699907932; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DWHeQJn6b5QGJ2aLzpvGAlFnz6fZ5+dr6mLoVmK8xZY=;
        b=L2hrkzf3yRvLh+xsRRlhQGs500s46wfx7XQf1XNzEgEYfyYAS1qPcCrFjhQtiRFqCH
         ejIX7xQ1RuDzAOZ3HIOoeZvZZutbpw3xAbm5ms0Nz3ZOCYSupRPIZMCMQnqeR1jwrtQz
         K6vbeVtLqR+gwJKMW+XLXzobUb42l1Tsf392Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699303132; x=1699907932;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DWHeQJn6b5QGJ2aLzpvGAlFnz6fZ5+dr6mLoVmK8xZY=;
        b=J6nzVei8TrBw9028LyVSGmNdqE51B7he/J3Uhc87kJgx7tLkV8HmcQHm4B/ZXXwYZo
         LAVezsusqPwpwOQ1V7OZ0pzA8LsNIpzj/YlHxBZxea6Su3gzivlo4HxF1TdyiPevG25B
         z2mDWLJDeMOySx1uKx6ZjX+A7r7RGC9SSbyTtdrq7Q0lJoS77lF6bnb1BsgD/RiWYwHu
         9dsVMoZt4w5quMsJjHl8wS/IZ8tMO4jOal2cI+jwslhqe2la7zMb0v7VWVWrUAxTg2Jr
         CGHQt/zNgoIJcAOIkmUrQ5zSgscXiooXJlZsKf+0bnU1QxCCpLzGrchc1wyrjWYWBdiO
         snwA==
X-Gm-Message-State: AOJu0Yw95ivPXbaQqdGDND6dzR6VCPADV4RY/veaY1tt9a2vOcx5fEJx
        dG5jvrJAYalgQ9o2Kuyjgc96meiH2LZhBhZOr+2Ejx+qEI+Kzvxk
X-Google-Smtp-Source: AGHT+IFqrf+5iybuubxTs0TinjyxKuo+fHf9DhrkjYerZ24qeAd6518K5hcdcrjXkEixbQq221w/0z4sR+6TLpiMYu0=
X-Received: by 2002:a05:6830:20c5:b0:6c0:a95b:44e4 with SMTP id
 z5-20020a05683020c500b006c0a95b44e4mr30185671otq.38.1699303132688; Mon, 06
 Nov 2023 12:38:52 -0800 (PST)
MIME-Version: 1.0
References: <20231106202718.2770821-1-hsinyi@chromium.org> <20231106202718.2770821-4-hsinyi@chromium.org>
 <CAD=FV=WZS0ADX+0MyK3W75BkJ6qcohbj0ZC5CvnT0gedx0z0gg@mail.gmail.com>
In-Reply-To: <CAD=FV=WZS0ADX+0MyK3W75BkJ6qcohbj0ZC5CvnT0gedx0z0gg@mail.gmail.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Mon, 6 Nov 2023 12:38:26 -0800
Message-ID: <CAJMQK-gmu71-s_RoiWUAd_HHtJm_yN1YQ6+p+aQyKWKz1ACDsQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] drm/panel-edp: Avoid adding multiple preferred modes
To:     Doug Anderson <dianders@chromium.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 6, 2023 at 12:33=E2=80=AFPM Doug Anderson <dianders@chromium.or=
g> wrote:
>
> Hi,
>
> On Mon, Nov 6, 2023 at 12:27=E2=80=AFPM Hsin-Yi Wang <hsinyi@chromium.org=
> wrote:
> >
> > diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/=
panel-edp.c
> > index 0fb439b5efb1..54dbbdf62ec0 100644
> > --- a/drivers/gpu/drm/panel/panel-edp.c
> > +++ b/drivers/gpu/drm/panel/panel-edp.c
> > @@ -594,8 +594,20 @@ static int panel_edp_get_modes(struct drm_panel *p=
anel,
> >                                       p->detected_panel !=3D ERR_PTR(-E=
INVAL) &&
> >                                       p->detected_panel->override_edid_=
mode;
> >
> > -       /* probe EDID if a DDC bus is available */
> > -       if (p->ddc) {
> > +       /*
> > +        * If both edid and hard-coded modes exists, only add hard-code=
d modes
> > +        * to avoid multiple preferred modes.
> > +        */
> > +       if (p->desc->num_timings || p->desc->num_modes) {
> > +               /*
> > +                * Add hard-coded panel modes. Don't call this if there=
 are no
> > +                * timings and no modes (the generic edp-panel case) be=
cause it
> > +                * will clobber the display_info that was already set b=
y
> > +                * drm_add_edid_modes().
> > +                */
> > +               num +=3D panel_edp_get_non_edid_modes(p, connector);
> > +       } else if (p->ddc) {
> > +               /* probe EDID if a DDC bus is available */
>
> As per discussion in v2, I think if you have the "ddc" you still want
> to fetch the EDID, you just don't want to add the modes from the EDID.
> This will mean that the EDID is present in sysfs if userspace wants to
> look at it for whatever reason.
>
Ack. Will update this.

> -Doug
