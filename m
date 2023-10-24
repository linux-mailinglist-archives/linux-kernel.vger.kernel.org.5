Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE9E7D5AEA
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 20:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343773AbjJXSww convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 24 Oct 2023 14:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232357AbjJXSwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 14:52:50 -0400
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB2610E0;
        Tue, 24 Oct 2023 11:52:48 -0700 (PDT)
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5845b7ee438so373390eaf.1;
        Tue, 24 Oct 2023 11:52:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698173567; x=1698778367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LVYlVHR9pYIMuvG17VXitFil99pf6BKjPqJU/KKqj2w=;
        b=TedL5jTYnSv3GWo0PiW6bYGzHAPW7KqvueUFQUmNd3enjZOpfFMdcqUJ6pvyCcbhiS
         d6nKJ8iBq2eGagZLZg76Yd15oVWnc1csZdKT4LAEsRjvMVXoR2iToIcS4H/cvnWvt3Yw
         F1F/2SZFR4DCwZIthExya3hhiHzHbPFM6UlSL/aio2DV1dh3ibGSV9NfemW1pViVKGlS
         +cV8UQhG+UoqUaR0uAbsMBApdzW3FeYTVeTezyV8sa2el10W8V5Gduh9sHO/3OvI1tNK
         3FKI7JUa9OlWQwRdd4Uuy92Fq5x85/P3mEQevI1DPce8Hro2mlX5DJI/wZdkWQ1f2bl8
         5spQ==
X-Gm-Message-State: AOJu0YzB+2m+4iJjDPszJP0hPwFqfiy4CKpMoxd+lbb8FRDfTNA9PHZc
        4UoQrVmgHw+AQj0HQktJE7G8+OWJ6OQmlBRWnOM=
X-Google-Smtp-Source: AGHT+IHDPdUZo5h0lWf1OFlLr+zHVQ2nSUpiByu4SZLn0AGulo7kbvG9QdpdztMYUErED+CQYZZunIjx3OMjoaASS20=
X-Received: by 2002:a4a:df4e:0:b0:57c:6e35:251e with SMTP id
 j14-20020a4adf4e000000b0057c6e35251emr13615268oou.1.1698173567342; Tue, 24
 Oct 2023 11:52:47 -0700 (PDT)
MIME-Version: 1.0
References: <20231004183455.27797-1-ville.syrjala@linux.intel.com>
 <6d207eef73fb2ad32264921ae7d1a536b6b8da61.camel@intel.com>
 <ZR22I-9YgGW9vADB@intel.com> <ZTf6qwCLR3YEwL9K@intel.com> <CAJZ5v0jzqZBHqh8dxChwJ65wT-pU3+9HxVi5f7DAcOTFpYTb9Q@mail.gmail.com>
 <ZTgRhFbp5wdsTa5W@intel.com>
In-Reply-To: <ZTgRhFbp5wdsTa5W@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 24 Oct 2023 20:52:36 +0200
Message-ID: <CAJZ5v0hBdPJB_BL9ux0NDUZQfOBddP7w3mcAO-AUGPnosA+Jhg@mail.gmail.com>
Subject: Re: [Intel-gfx] [PATCH] powercap: intel_rapl: Don't warn about BIOS
 locked limits during resume
To:     =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Zhang, Rui" <rui.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 8:48 PM Ville Syrjälä
<ville.syrjala@linux.intel.com> wrote:
>
> On Tue, Oct 24, 2023 at 08:31:34PM +0200, Rafael J. Wysocki wrote:
> > On Tue, Oct 24, 2023 at 7:11 PM Ville Syrjälä
> > <ville.syrjala@linux.intel.com> wrote:
> > >
> > > On Wed, Oct 04, 2023 at 09:59:47PM +0300, Ville Syrjälä wrote:
> > > > On Wed, Oct 04, 2023 at 06:45:22PM +0000, Pandruvada, Srinivas wrote:
> > > > > On Wed, 2023-10-04 at 21:34 +0300, Ville Syrjala wrote:
> > > > > > From: Ville Syrjälä <ville.syrjala@linux.intel.com>
> > > > > >
> > > > > > Restore enough of the original behaviour to stop spamming
> > > > > > dmesg with warnings about BIOS locked limits when trying
> > > > > > to restore them during resume.
> > > > > >
> > > > > > This still doesn't 100% match the original behaviour
> > > > > > as we no longer attempt to blindly restore the BIOS locked
> > > > > > limits. No idea if that makes any difference in practice.
> > > > > >
> > > > > I lost the context here. Why can't we simply change pr_warn to pr_debug
> > > > > here?
> > > >
> > > > I presume someone wanted to make it pr_warn() for a reason.
> > > > I don't mind either way.
> > >
> > > Ping. Can someone make a decision on how this should get fixed
> > > so we get this moving forward?
> >
> > I thought we were going to replace the pr_warn() with pr_debug().
>
> I didn't get any answer whether anyone wants to keep the pr_warn().
> If everyone is happy with pr_debug() that then I can send a patch
> for it.

Yes, please.
