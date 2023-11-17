Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 614527EFB2D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 23:09:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232759AbjKQWJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 17:09:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234061AbjKQWJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 17:09:04 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3803FD7A
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 14:09:01 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-6ce2988d62eso1303272a34.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 14:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700258940; x=1700863740; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xUVc511gN5OSpetib0BtsSnCKuFu68FlIwOoywnOLzA=;
        b=ai3OHyyWSNE/9BnKouUbiQPHpZIrxaaBNhN0RcMh/3scyimUIAOPwDFWUIariZevQL
         loW8rhHm2+skTxD5/pI7spP22BEz3ty9ki2PuPIkTi3KGvnXbkenA6Cj3V4LlzURlrAO
         PLg4y4t84pWvqZidfM6qOM2POWfBz0nYKOqSM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700258940; x=1700863740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xUVc511gN5OSpetib0BtsSnCKuFu68FlIwOoywnOLzA=;
        b=NEeXv+WRCcV1Pc7v1WczGLEDdrrs/NB00pTXl0vXr9CvESHE0vV3fDWLdNMBCgZ4tL
         EuRrwK7Yi0tg7YfvYCrA0SLoiZDPdXH4PfwjzBo//+0hu7oGWj0pO/9rCJm66ZMRjFwh
         ZdbGAi66JcCZ2qj+o+0m49lgj/aBpX6sSvvs0W8vqBWa9zW7x1KT/o4BGrNLkkQbuS1q
         VYWnYqs3CP6SvOE1oW6arQFy8iB+hH+bwboR0ObVp0SMdaQNjDJpWfacC5nbe39A1R3r
         7mpR37mZU6kXNYrfV1gIaAjbyuvvX6jdONEQIGrQOHneUvmqVvKUxcc/3ZqhszY6yvSf
         4iJA==
X-Gm-Message-State: AOJu0Yzja6lOVsYlXfsUwWYJT0ZntC6jzwOGh5t83qe9N6pA3/44bZJs
        ZRYPap3PUWpbiLFbMD8C22aqBqEUNKE7knZ40MrlQA==
X-Google-Smtp-Source: AGHT+IFiWNTHuBd6H11UhItgAGgFvK9eyWsVkIf8k2d/LqKmWmGRl0fk8DZLVaJKw+Pga2D49h6Wg/xhaA6qM5ggtJY=
X-Received: by 2002:a9d:66d0:0:b0:6ce:29cd:b699 with SMTP id
 t16-20020a9d66d0000000b006ce29cdb699mr584807otm.10.1700258940488; Fri, 17 Nov
 2023 14:09:00 -0800 (PST)
MIME-Version: 1.0
References: <20231117215056.1883314-1-hsinyi@chromium.org> <20231117215056.1883314-2-hsinyi@chromium.org>
 <2023111738-bondless-sketch-f201@gregkh>
In-Reply-To: <2023111738-bondless-sketch-f201@gregkh>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Fri, 17 Nov 2023 14:08:34 -0800
Message-ID: <CAJMQK-i1CySjb1K7SHR40wnmc+TN5k0MhDef6OhYimPchzGn2g@mail.gmail.com>
Subject: Re: [PATCH v7 1/3] drm/panel-edp: Add override_edid_mode quirk for
 generic edp
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2023 at 2:06=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Fri, Nov 17, 2023 at 01:46:32PM -0800, Hsin-Yi Wang wrote:
> > Generic edp gets mode from edid. However, some panels report incorrect
> > mode in this way, resulting in glitches on panel. Introduce a new quirk
> > additional_mode to the generic edid to pick a correct hardcoded mode.
> >
> > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> > Reviewed-by: Douglas Anderson <dianders@chromium.org>
> > ---
> > v6->v7: split usecase to another patch.
> > ---
> >  drivers/gpu/drm/panel/panel-edp.c | 48 +++++++++++++++++++++++++++++--
> >  1 file changed, 45 insertions(+), 3 deletions(-)
>
> <formletter>
>
> This is not the correct way to submit patches for inclusion in the
> stable kernel tree.  Please read:
>     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.ht=
ml
> for how to do this properly.
>
Forgot to -cc: stable, these patches don't need to be picked to stable.

> </formletter>
