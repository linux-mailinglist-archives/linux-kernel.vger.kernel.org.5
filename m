Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2767F16E1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 16:12:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234098AbjKTPMR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 20 Nov 2023 10:12:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234205AbjKTPMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 10:12:09 -0500
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD00131;
        Mon, 20 Nov 2023 07:12:06 -0800 (PST)
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3b2e08526b9so935274b6e.0;
        Mon, 20 Nov 2023 07:12:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700493125; x=1701097925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S+m0kC6g1pw6dndsJtMqNEaQgc0zf06MzggkuivSPh0=;
        b=a6hBWe+vrO1CjJb5DGKslZsCbxE4XeRS1gJyezZpOhdjwYP6ggu92Yqey0BGRZX1xS
         buT2bOFVcbf4wiahBvDtdPsUFs17Sy1p5CRCTvrHt4F0At8ViWpJRoBS5y2nbRMVWqgA
         EyEmrvYv6s09qPjCjFSYT2eAQykWh36jBr/hArJQgPO1BNWeIQdbQ4Xno3awEi+JYxyl
         o/jW+CwmqSUs9gM/UYZjNpLziK4YnpD9foRMRlZ29f8OzTw5KrrOCBWWJJjgiMhBULHK
         IExfRl3uooHkk+BUSjpSH2tg9kaV5S+aWywA58JbZph49L6PDpSWMDWEt8bpYIZyghjK
         F41w==
X-Gm-Message-State: AOJu0Yw1lhnEbcfjWUxL2vuSS3hNOfNO5DchCHYzuJ59+67RII9+iy1Q
        ngwRK/TAnR09M6h/uQ4rOgrS2G8+Kul+iMKQ2iVlO+iI
X-Google-Smtp-Source: AGHT+IHSUSPPFTcw8FMSSNGm1jay0/0THjIE7X5TrQf4EMgupzCk+cjrGR4G9U3eM/ZKrCfPpjKg98MAciT1ixshXxs=
X-Received: by 2002:a4a:d44c:0:b0:584:1080:f0a5 with SMTP id
 p12-20020a4ad44c000000b005841080f0a5mr6925354oos.1.1700493125450; Mon, 20 Nov
 2023 07:12:05 -0800 (PST)
MIME-Version: 1.0
References: <20231002135458.2603293-1-andriy.shevchenko@linux.intel.com>
 <6531d1e01d0e1_7258329440@dwillia2-xfh.jf.intel.com.notmuch> <ZVt1J_14iJjnSln9@smile.fi.intel.com>
In-Reply-To: <ZVt1J_14iJjnSln9@smile.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 20 Nov 2023 16:11:54 +0100
Message-ID: <CAJZ5v0hk2ygfjU7WtgTBhwXhqDc8+xoBb+-gs6Ym9tOJtSoZ4A@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] ACPI: NFIT: Switch to use acpi_evaluate_dsm_typed()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Michal Wilczynski <michal.wilczynski@intel.com>,
        nvdimm@lists.linux.dev, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 4:03 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Oct 19, 2023 at 06:03:28PM -0700, Dan Williams wrote:
> > Andy Shevchenko wrote:
> > > The acpi_evaluate_dsm_typed() provides a way to check the type of the
> > > object evaluated by _DSM call. Use it instead of open coded variant.
> >
> > Looks good to me.
> >
> > Reviewed-by: Dan Williams <dan.j.williams@intel.com>
>
> Thank you!
>
> Who is taking care of this? Rafael?

I can apply it.
