Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB3C7B185C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 12:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbjI1KjH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 28 Sep 2023 06:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbjI1KjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 06:39:05 -0400
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B5E126;
        Thu, 28 Sep 2023 03:39:03 -0700 (PDT)
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-57bf04841ccso604710eaf.0;
        Thu, 28 Sep 2023 03:39:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695897543; x=1696502343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k+wNGruj8fd2q2QXRwGYxWU6anD2Gz2agZm2PMKxhlc=;
        b=arR+bIAF7DfbvZYYGu/4pFyrKY49vzrpqJBm7Azd+LHLttqx9AKkeuTCBAhaXN3Z7y
         VV9BT8JVV0hTaw69S/+5wzCHYeHAd7RXyY5TdBW0tB6n4Sq+8Wgg7IUsFclX0yfLH4uB
         R+V4vwtJuozOAMs0UXsqAbkhHXvNeLtbTYDGrCYY5boBIaDzMHMSogbZ/0il17QCrlgA
         hc/RqGDUljK7PcKVru0ZenrK4M6qfEVXRklAtkQak0OQQdX1bqWAf1zq+vERQ4GmUVna
         j54ugAAJnpT/4ecbJJQyByM9qsVVHmrqX0M1CqVVrYPeikJogpPE6116oUJ//jxJk1oa
         iTIg==
X-Gm-Message-State: AOJu0YyUWQahDQBGLzJWIDJntkda8R4c+rSczdqQuVNstZ/dIdp+iu07
        fkhzRE5UIuF+YC4CxraQoixY0SJ3SV1VVMRDvIc=
X-Google-Smtp-Source: AGHT+IFbOdzyw82mFw6M0xmJh9GamBL7n1WU5OKnabWEhcAa0YWYBxZYa8bX9V90P5l1IqmMaB9idUJe0gXdgn/lGMQ=
X-Received: by 2002:a4a:d081:0:b0:57b:94b7:c6ba with SMTP id
 i1-20020a4ad081000000b0057b94b7c6bamr880684oor.0.1695897543181; Thu, 28 Sep
 2023 03:39:03 -0700 (PDT)
MIME-Version: 1.0
References: <1957441.PYKUYFuaPT@kreacher> <45837158.fMDQidcC6G@kreacher> <065636fa-e6ac-4fcb-5d78-b3f281ac4609@linaro.org>
In-Reply-To: <065636fa-e6ac-4fcb-5d78-b3f281ac4609@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 28 Sep 2023 12:38:51 +0200
Message-ID: <CAJZ5v0gjGL_4Fs=_iO086tmBP6E+oQoo+Jix_PH0dspbZ9yn2g@mail.gmail.com>
Subject: Re: [PATCH v1 10/13] thermal: core: Allow trip pointers to be used
 for cooling device binding
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2023 at 9:10 AM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 21/09/2023 20:01, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Add new helper functions, thermal_bind_cdev_to_trip() and
> > thermal_unbind_cdev_from_trip(), to allow a trip pointer to be used for
> > binding a cooling device to a trip point and unbinding it, respectively,
> > and redefine the existing helpers, thermal_zone_bind_cooling_device()
> > and thermal_zone_unbind_cooling_device(), as wrappers around the new
> > ones, respectively.
> >
> > No intentional functional impact.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
>
> Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Thanks so much for all of the reviews!

I'll now apply the patches for which you have given tags and respin
the rest (governor changes) as a separate series on top of them.
