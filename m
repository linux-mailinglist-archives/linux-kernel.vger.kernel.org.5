Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 892B377FD32
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 19:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354088AbjHQRq0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 17 Aug 2023 13:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345619AbjHQRp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 13:45:57 -0400
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580F310C0;
        Thu, 17 Aug 2023 10:45:56 -0700 (PDT)
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-56d26137095so13498eaf.1;
        Thu, 17 Aug 2023 10:45:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692294355; x=1692899155;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BWkl0YmA+wanHY01YLpCh2cN9G0Tpk4oGgxO0aDzIBI=;
        b=VUT6sVebulV3sQTuX38NQ4hVeErVg7o4HEGOxaJPWgqEJGIKWJWzNxb1mst2XzFTMm
         oqhB9je8fpWxZv/bJE7GX3kuEex+Qnoskc6mnXVCwhH9oBQHa2rUwmBIVLk3dVzIcWOu
         qNRgi0jHcPFZIvtOUk7CioRmu8CVnh6mCkwFmDTwy2aiAJo7GJEYoEHY4VWTb9Vgnvtc
         ePKstRCg9QTMVJR9o+Xh2EBggSSiZSV0FSpI+9HmhRWqTFgucuA47PiTA+4h2QhK2dN5
         Wj9tAHZF7goHxSahwolVkQyxsAHB8aPvnS49cNw8/Fcwb1lcGgc520KN2Bt+WbbYTTpW
         XH4Q==
X-Gm-Message-State: AOJu0YxyggZGoXnrrmV3RddaS6fxCUVmcX5QMvaz3O4XqhBIhOnjb6VT
        Qr8ygrssZCbN6yQ3DdVKts9CtLOQ58PoSEs3dBs=
X-Google-Smtp-Source: AGHT+IHhnk8rXE+lSWd/IZpennCiavRiILVG3sX6LXIqDYmGlCxj+jwVFD+6U8/RcrsuRpu1+OGpfUmxfHNZaD6cFLY=
X-Received: by 2002:a05:6820:44a:b0:563:3b56:5dc1 with SMTP id
 p10-20020a056820044a00b005633b565dc1mr508056oou.0.1692294355599; Thu, 17 Aug
 2023 10:45:55 -0700 (PDT)
MIME-Version: 1.0
References: <1690984066-31757-1-git-send-email-lixiaochun.2888@163.com> <SJ1PR11MB6083DA8FD0F3790DA04CF337FC0BA@SJ1PR11MB6083.namprd11.prod.outlook.com>
In-Reply-To: <SJ1PR11MB6083DA8FD0F3790DA04CF337FC0BA@SJ1PR11MB6083.namprd11.prod.outlook.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 17 Aug 2023 19:45:44 +0200
Message-ID: <CAJZ5v0ibftv6WK2fDRwe2CvYUWu0zLhMNM4Ud++C6E-Nbjh6ng@mail.gmail.com>
Subject: Re: [PATCH v1] ACPI: extlog: Fix finding the generic error data for
 v3 structure
To:     "Luck, Tony" <tony.luck@intel.com>,
        Xiaochun Lee <lixiaochun.2888@163.com>
Cc:     "lenb@kernel.org" <lenb@kernel.org>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "xiaocli@redhat.com" <xiaocli@redhat.com>,
        "Huang, Adrian" <ahuang12@lenovo.com>,
        "Li, Xiaochun" <lixc17@lenovo.com>
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

On Wed, Aug 2, 2023 at 6:03 PM Luck, Tony <tony.luck@intel.com> wrote:
>
> > Fix by using acpi_hest_get_payload( ) to find out the correct
> > generic error data for v3 structure. The revision v300 generic
> > error data is different from the old one, so for compatibility
> > with old and new version, change to a new interface to locate
> > the right memory error section that was defined in CPER.
> >
> > Signed-off-by: Xiaochun Lee <lixc17@lenovo.com>
>
> Reviewed-by: Tony Luck <tony.luck@intel.com>

Applied as 6.6 material, thanks!
