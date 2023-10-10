Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0127BFA25
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 13:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbjJJLqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 07:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbjJJLqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 07:46:03 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D902EA4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 04:46:01 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-3232e96deaaso1349716f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 04:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1696938360; x=1697543160; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aiA4D11X2sFtXKvFj+BVZkBdxaJKzeEbh5cY8Yxytvg=;
        b=GWGMs53od8yUrlA7N4SoxSsh2ZToEPeBj3Rpp+VJFhZn5gtJWgk2cQfJ5xogoiQqUR
         jbV+gSb9JkOQS2z8iE6aFgQckIx8TNsSpye63zupsFBMDI1ULBRExnoNTE1r/7W2Nwv0
         6vsSPucoUJzQO8M6+++2+Zc9IvadJXeA1sAnI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696938360; x=1697543160;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aiA4D11X2sFtXKvFj+BVZkBdxaJKzeEbh5cY8Yxytvg=;
        b=ry4pNs3RNtfzB0I8YgUrhTzcIbBZCHw4TJpz/dZBqKXwRx+nWUBIgvpeLZzA9IWxhG
         vZIJa3SNmsmdLXymsed4TL5LK1qXgRS8PKDP66VBMGiJspZzM1zV8AsPlT3BRvuz7Za6
         iDlxiWHw0O+kRv2KkWvNJVvRuwmy586NCRVRY/jY37/+cp9G2jGId3D+mqZk4eh7gUxk
         O5fec8Pj2t3nMl/zmBEhJrNTOQePYE49cvNR0NpjGwya2IDXehc+Uxlhs5aVjIAqOxFR
         c9duyaDJSGtxcufrkpsvH2h3IGUNWTMm8yjKiTAgeV3GFx9mc5dfixZ6olJaM4Znn5ZA
         Er0w==
X-Gm-Message-State: AOJu0Yxc32uFTAlbEZkZRWLlvYVKsYOS+K17Ux8gehojZdVH3aPbPuzc
        netquS/885wAhN4ScKBaI+sX8g==
X-Google-Smtp-Source: AGHT+IE4/UvRoJK4tGLVIxW4ixF9DbnO2siW/LMpb7C9C8dsXdtbYclfJKlYBA0WjLwnhm1UDv3LbA==
X-Received: by 2002:a5d:6909:0:b0:320:8f0:b93d with SMTP id t9-20020a5d6909000000b0032008f0b93dmr14892975wru.3.1696938360227;
        Tue, 10 Oct 2023 04:46:00 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id h9-20020a5d6889000000b0031c52e81490sm12640936wru.72.2023.10.10.04.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 04:45:59 -0700 (PDT)
Date:   Tue, 10 Oct 2023 13:45:57 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Ondrej Zary <linux@zary.sk>
Cc:     Helge Deller <deller@gmx.de>, jiapeng.chong@linux.alibaba.com,
        linux-fbdev@vger.kernel.org, javierm@redhat.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        tzimmermann@suse.de, Zhang Shurong <zhang_shurong@foxmail.com>
Subject: Re: [PATCH] video: fbdev: arkfb: fix possible object reference leak
Message-ID: <ZSU5dZJqd8CIFzM6@phenom.ffwll.local>
Mail-Followup-To: Ondrej Zary <linux@zary.sk>, Helge Deller <deller@gmx.de>,
        jiapeng.chong@linux.alibaba.com, linux-fbdev@vger.kernel.org,
        javierm@redhat.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, tzimmermann@suse.de,
        Zhang Shurong <zhang_shurong@foxmail.com>
References: <tencent_55C1A344A101B55762ECA6A6366D0B0F8C05@qq.com>
 <b9e51034-bc6c-81d8-39ef-9fc74fa09c62@gmx.de>
 <202310061634.02110.linux@zary.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202310061634.02110.linux@zary.sk>
X-Operating-System: Linux phenom 6.5.0-1-amd64 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2023 at 04:34:01PM +0200, Ondrej Zary wrote:
> On Friday 06 October 2023, Helge Deller wrote:
> > On 10/5/23 09:01, Zhang Shurong wrote:
> > > Add missing pci_disable_device() in error path in ark_pci_probe().
> > 
> > Do you have this hardware and tested your patch?
> > I'm sure there is a reason, why "pci_disable_device()" was commented
> > out in the original submission in commit 681e14730c73c...
> 
> pci_disable_device() call is disabled in many fbdev drivers because
> calling it might prevent display from working.

Yeah I've recently hit some _really_ interesting regression report where
essentially fbdev driver and vgacon where managing the hardware
collaboratively. There's enormous amounts of "this shouldn't work like
that, but it is how it does" going on in old fbdev drivers, and what you
brought up is also what I immediately thought of.

This patch feels way too risky to me that we should apply it ...
-Sima

> 
> > 
> > Additionally I'm wondering why your patch doesn't show up in
> > the fbdev patchwork, although you added linux-fbdev mailing list.
> > Probably a vger issue.
> > 
> > Helge
> > 
> > 
> > > Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
> > > ---
> > >   drivers/video/fbdev/arkfb.c | 4 ++--
> > >   1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/video/fbdev/arkfb.c b/drivers/video/fbdev/arkfb.c
> > > index 60a96fdb5dd8..6c4e5065646f 100644
> > > --- a/drivers/video/fbdev/arkfb.c
> > > +++ b/drivers/video/fbdev/arkfb.c
> > > @@ -1064,7 +1064,7 @@ static int ark_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
> > >   err_dac:
> > >   	pci_release_regions(dev);
> > >   err_request_regions:
> > > -/*	pci_disable_device(dev); */
> > > +	pci_disable_device(dev);
> > >   err_enable_device:
> > >   	framebuffer_release(info);
> > >   	return rc;
> > > @@ -1085,7 +1085,7 @@ static void ark_pci_remove(struct pci_dev *dev)
> > >
> > >   		pci_iounmap(dev, info->screen_base);
> > >   		pci_release_regions(dev);
> > > -/*		pci_disable_device(dev); */
> > > +		pci_disable_device(dev);
> > >
> > >   		framebuffer_release(info);
> > >   	}
> > 
> > 
> 
> 
> 
> -- 
> Ondrej Zary

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
