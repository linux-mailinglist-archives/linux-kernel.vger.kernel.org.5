Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D50517F885F
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 05:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbjKYE63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 23:58:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjKYE61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 23:58:27 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8EEC1710;
        Fri, 24 Nov 2023 20:58:32 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-3b2df2fb611so1664384b6e.0;
        Fri, 24 Nov 2023 20:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700888312; x=1701493112; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=H7+G6kTUsYcf2EuznU9nGg+6a0PiyVvvTpJ6OmKLYnU=;
        b=gv+OSwCylABvUN1LZmQTP/j0ybV6RsGST6j1x6ms/zskLT0z0jxfvYCEgvZ35M5r03
         CpH+jo+oDTuraekfbR+QJRyWrk9wZZ1oh0PUgQqgX37p0fpUx+gXgTnVq5y0Sf7a6LS3
         92RnmPiQSNt5KioNIRoLhZz/OkirU9NXcpgXKV5meR7iVpp1K1BV3ltVfPAPhNBOxX6X
         bf6W1PScs/xTC13BCoBlPfXrymrmAiottmNI7CrbZmLDZ+95rJ1K2rkBzjebXCsW+WHp
         6W/v31gr94vHGRZyZ3nhIAN3GnvqIdwEZxYTcN6ObWe1PrHPC4yMIhwLQaDiPfxOyczk
         KHCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700888312; x=1701493112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H7+G6kTUsYcf2EuznU9nGg+6a0PiyVvvTpJ6OmKLYnU=;
        b=oSdDpPOIs0puZKUxX3WjgPJCQDxhB1hZbTzQDio8kKzJ/VLolt9fR0y4vunGsktsIJ
         JReTR4YKbi3nZI8uJsXHSyWlz0VNc1CWSyuQtnAlL5gWFsbKQF9P0+eSXS65F0HiA0cz
         NZvl83HxuIuELDqFG+VobdzQx9h2sSP0VrcCvvRaLpDDa3B8exNg0s9X5s1VYzIlHob6
         WiGsVpNdA0fdCuLiPuIN0A1H2S0vzRw0qTyxEWYZ5WCcONmJ9M8IzmHfyyeQPwlTTxlX
         gbyeLyXPAjOwDtTucRPFurf5cfLGloFbocNht2m14F4qxBkvR8ruVIJtjGKX1z5DH/3j
         mV9Q==
X-Gm-Message-State: AOJu0Yw1WCO/7ZY/mpTBz++5JT8XFjgT7/3/lY/2BYYdedYh4FN8uDB2
        sdnsblqpec+upfqQz0zOSoc=
X-Google-Smtp-Source: AGHT+IFeTSL/V+P+KPM4Qgxl19x/Ka79WuZ6Y2vXNvWEwWRybB7C/6fG5QLOW4EjPMH7qokAspkoSg==
X-Received: by 2002:a05:6808:13c2:b0:3b8:3e4d:605e with SMTP id d2-20020a05680813c200b003b83e4d605emr7298648oiw.42.1700888311914;
        Fri, 24 Nov 2023 20:58:31 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:8b5c:82d0:578f:d0])
        by smtp.gmail.com with ESMTPSA id fd39-20020a056a002ea700b006cb7b0c2503sm3703306pfb.95.2023.11.24.20.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 20:58:31 -0800 (PST)
Date:   Fri, 24 Nov 2023 20:58:28 -0800
From:   "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
To:     Alexey Makhalov <amakhalov@vmware.com>
Cc:     Simon Horman <horms@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@linux.intel.co" <dave.hansen@linux.intel.co>,
        "bp@alien8.d" <bp@alien8.d>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Zack Rusin <zackr@vmware.com>,
        Tim Merrifield <timothym@vmware.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "tzimmermann@suse.de" <tzimmermann@suse.de>,
        "mripard@kernel.org" <mripard@kernel.org>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "richardcochran@gmail.com" <richardcochran@gmail.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        Linux-graphics-maintainer <Linux-graphics-maintainer@vmware.com>,
        Pv-drivers <Pv-drivers@vmware.com>,
        Nadav Amit <namit@vmware.com>, Ajay Kaher <akaher@vmware.com>,
        Jeff Sipek <jsipek@vmware.com>
Subject: Re: [PATCH 4/6] input/vmmouse: Use vmware_hypercall API
Message-ID: <ZWF-9DmwakJBonmf@google.com>
References: <20231122233058.185601-1-amakhalov@vmware.com>
 <20231122233058.185601-5-amakhalov@vmware.com>
 <20231124194646.GW50352@kernel.org>
 <A64E0517-57D9-47DF-8DD8-040EE6843246@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <A64E0517-57D9-47DF-8DD8-040EE6843246@vmware.com>
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 25, 2023 at 01:22:58AM +0000, Alexey Makhalov wrote:
> On Nov 24, 2023, at 11:46 AM, Simon Horman <horms@kernel.org> wrote:
> > 
> > On Wed, Nov 22, 2023 at 03:30:49PM -0800, Alexey Makhalov wrote:
> >> Switch from VMWARE_HYPERCALL macro to vmware_hypercall API.
> >> Eliminate arch specific code. No functional changes intended.
> >> 
> >> Signed-off-by: Alexey Makhalov <amakhalov@vmware.com>
> > 
> > Hi Alexey,
> > 
> > it is not strictly related to this patch, but I notice than an x86_64
> > allmodconfig build with W=1 using gcc-13 fails to compile this file.
> > 
> > It appears that the problem relates to both priv->phys and
> > psmouse->ps2dev.serio->phys being 32 bytes.
> > 
> > 
> > drivers/input/mouse/vmmouse.c: In function ‘vmmouse_init’:
> > drivers/input/mouse/vmmouse.c:455:53: error: ‘/input1’ directive output may be truncated writing 7 bytes into a region of size between 1 and 32 [-Werror=format-truncation=]
> >  455 |         snprintf(priv->phys, sizeof(priv->phys), "%s/input1",
> >      |                                                     ^~~~~~~
> > drivers/input/mouse/vmmouse.c:455:9: note: ‘snprintf’ output between 8 and 39 bytes into a destination of size 32
> >  455 |         snprintf(priv->phys, sizeof(priv->phys), "%s/input1",
> >      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >  456 |                  psmouse->ps2dev.serio->phys);
> >      |                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > 
> > ...
> 
> Hi Simon, thanks for reporting the issue.
> Zack, please take a look.

We want the truncation behavior and we do not want GCC to make noise
about these, that is why "format-truncation" is explicitly disabled for
normal compiles. I guess we should exclude it even when we compile with
W=1 instead of doing pointless changes in the drivers.

Thanks.

-- 
Dmitry
