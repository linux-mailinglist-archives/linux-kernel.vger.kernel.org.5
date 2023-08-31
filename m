Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32BB578E8C0
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 10:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239737AbjHaIvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 04:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231590AbjHaIvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 04:51:07 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D481A6
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 01:51:04 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9a1c0bbfad9so7836866b.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 01:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1693471863; x=1694076663; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jWDq5kck7RscMt2sEXB5y+sPvFhAbNEGrptUJ7vQOfk=;
        b=dY4LfGDfxPip4PyJTgfcGF20nFfteC7VY2JdxALjBowqW7JsL080LRd22tGkelCRNM
         eMjcUdttp9CyMRoCu6Rgjv1Wqtv7ftTgYU0G/i2hYRUCvAWPiCtkq/9XAz21yZI8weu6
         vs3Uiww+YdyjyohBOxQ/3FrTu27etIdgLbWqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693471863; x=1694076663;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jWDq5kck7RscMt2sEXB5y+sPvFhAbNEGrptUJ7vQOfk=;
        b=RVZ9dLchDREj17+HSKDkl3SGTquFqnDfC7HKVNmFrKYcYjObBnw0O3wXVCWtW+jAns
         3qI4beoOc+6eNrxOuZv1A1JL3t4kAHdPy06v84tM5y/Pt/WdLu5i0gkQDmXZFYC7+dxV
         EQ0m9qsorHMPomYJpjmPa9deX8pt+YXrUFU5UUonC9C9aW9MVNSNGKpQx9LnU6zMvG15
         Og7xdF8qTo8bZWzJBeFC/wHQ/7sxTnQobIUB8++OIf/ABKr9heaU6/V93RfCORdjdSVF
         +XV+vsSKXwYtU8zkFGofDO09otke1pwLJeGi9FxSp/Vih21HWarqXxZ+WwhLN7s2I6y6
         Tp3Q==
X-Gm-Message-State: AOJu0YyIMOLpJTxSy2FtWk1gK85OKZB6Bk07lA8je7JilnsfibVhj/xb
        RnVakbcEGKbhyY5GRNeymmyEIQ==
X-Google-Smtp-Source: AGHT+IHL7Z0g4vh5rzA9SEaNtkyHr08VO+jBiI+WkQ1eiFzmLVjUGcuFX9+sxNcwd5J+kRbpi0kN8Q==
X-Received: by 2002:a17:906:19:b0:9a1:f96c:4bb9 with SMTP id 25-20020a170906001900b009a1f96c4bb9mr3193922eja.6.1693471862805;
        Thu, 31 Aug 2023 01:51:02 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id u23-20020a170906951700b0099cf840527csm510831ejx.153.2023.08.31.01.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 01:51:02 -0700 (PDT)
Date:   Thu, 31 Aug 2023 10:51:00 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-fbdev@vger.kernel.org, Helge Deller <deller@gmx.de>,
        Rob Clark <robdclark@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jingoo Han <jg1.han@samsung.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fbdev: Update fbdev source file paths
Message-ID: <ZPBUdJwZzvYYrNei@phenom.ffwll.local>
Mail-Followup-To: Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-fbdev@vger.kernel.org, Helge Deller <deller@gmx.de>,
        Rob Clark <robdclark@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jingoo Han <jg1.han@samsung.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20230829200253.1473891-1-j.neuschaefer@gmx.net>
 <d9a02d20-8b59-cbdd-d054-eac14f9771d2@suse.de>
 <ZPA26xdbTRdfuveS@probook>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZPA26xdbTRdfuveS@probook>
X-Operating-System: Linux phenom 6.4.0-2-amd64 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2023 at 08:44:59AM +0200, Jonathan Neuschäfer wrote:
> On Wed, Aug 30, 2023 at 09:10:26AM +0200, Thomas Zimmermann wrote:
> > Hi
> > 
> > Am 29.08.23 um 22:02 schrieb Jonathan Neuschäfer:
> > > The files fbmem.c, fb_defio.c, fbsysfs.c, fbmon.c, modedb.c, and
> > > fbcmap.c were moved to drivers/video/fbdev, and subsequently to
> > > drivers/video/fbdev/core, in the commits listed below.
> > > 
> > > Reported by kalekale in #kernel (Libera IRC).
> > > 
> > > Fixes: f7018c213502 ("video: move fbdev to drivers/video/fbdev")
> > > Fixes: 19757fc8432a ("fbdev: move fbdev core files to separate directory")
> > > Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> > 
> > IMHO these comments might just be removed.
> 
> I think it's nice to have some sort of visual separation between groups
> of functions in fb.h, which these comments provide at the moment.
> Therefore I'm currently leaning towards my patch as it is, but I'm
> willing to have my mind changed and do a v2 which just removes the
> comments.

Just the filename without the full path maybe? That's enough to find the
right file, and it's also better at highlighting the actual important part
of the comment since the path is very redundant.
-Sima

> 
> 
> Thanks
> 
> > 
> > Best regards
> > Thomas
> > 
> > > ---
> > >   include/linux/fb.h | 12 ++++++------
> > >   1 file changed, 6 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/include/linux/fb.h b/include/linux/fb.h
> > > index ce7d588edc3e6..3cda5b9f2469b 100644
> > > --- a/include/linux/fb.h
> > > +++ b/include/linux/fb.h
> > > @@ -592,7 +592,7 @@ extern ssize_t fb_sys_write(struct fb_info *info, const char __user *buf,
> > >   	__FB_DEFAULT_SYS_OPS_DRAW, \
> > >   	__FB_DEFAULT_SYS_OPS_MMAP
> > > 
> > > -/* drivers/video/fbmem.c */
> > > +/* drivers/video/fbdev/core/fbmem.c */
> > >   extern int register_framebuffer(struct fb_info *fb_info);
> > >   extern void unregister_framebuffer(struct fb_info *fb_info);
> > >   extern int fb_prepare_logo(struct fb_info *fb_info, int rotate);



-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
