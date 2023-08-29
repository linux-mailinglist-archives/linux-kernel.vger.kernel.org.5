Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEB7178C814
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 16:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237133AbjH2OyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 10:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237180AbjH2OyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 10:54:00 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FBAE199
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 07:53:35 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-68a3cae6d94so3876548b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 07:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693320803; x=1693925603;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9EA9BB4QNaOUVi29wtBC2+U4B+xg7qHBDtCTKmBdpKg=;
        b=IsMKftYji921OMFGSZNsWjHzaJGbRhjnUGQ96zHIPOUk0Hx97smz5kFPxjM80H8t0z
         NyflYuycfY9MbZysDTN1rkMrv1sDNGC8quPF9H5uupLC4V3rIQ+JLFbWkIojM3buc7Tn
         2t/+iH/XrY1+gWVBnSd12629DGxjljWEGk1xLifSmraZ+oui5MClnWQPVp+qdwhfasV7
         6BEqOcAY/wraaRviUg8u4nzcqxHKxG5k5okrgZIf27iILyaTeohJJsi6QPT/GpMYvQFu
         gZ1Rfx5Elbi457IZmBnEiUf/k64vj92vvKKC+S/kqiuM1sU41XstYf4tr0hAwWA1tOTz
         H04A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693320803; x=1693925603;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9EA9BB4QNaOUVi29wtBC2+U4B+xg7qHBDtCTKmBdpKg=;
        b=cnpkg0nvdjKg/glVtFTmaumGm8La6vJTzf4ZtSvbT8+/EiJoE//oWCFZPmnZosRb2r
         1+I+f1n+Y691TTDOjPqvhQWpNXnOI8mLdBlKGBuKLmsFG4Xu6uX+YyH8/G3HUKoPl22Q
         m9wFKCFnFYq+CIOUlEi5HaTDJlOQbhTumRuDyTL0QxV7MVmPeJUSkhlYR9zWXuEndh0t
         bRCHeNBkWTY7Cf75gP3LU1zTsp2XOodDfFJeUYvIgOAWnI0agP3FkIos6CndGaJie7i9
         /GUKvrLqeXtXm2WOQoEM5l9bq/Umm9JpIQm0kwkj/iVi6NqIhWxdv1scnpjdHY5QnTOs
         1VDw==
X-Gm-Message-State: AOJu0Yyb0FyxcL1DYOEpcyPCBRdTaYB9vxQBnC6wn1+4aQUwdKNlLte0
        GJXiH8/67ph91spCNGUbp9o=
X-Google-Smtp-Source: AGHT+IG6ZDLvcuRS3mG1tSB6mplHq/KfN1zFgA/5DXm2br+XhwKFkekTInD/z9pEyhrgzoG9Xw6ttg==
X-Received: by 2002:a05:6a20:5518:b0:13a:6413:9004 with SMTP id ko24-20020a056a20551800b0013a64139004mr24871187pzb.43.1693320802837;
        Tue, 29 Aug 2023 07:53:22 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t21-20020aa79395000000b0068be3489b0dsm8886647pfe.172.2023.08.29.07.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 07:53:22 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 29 Aug 2023 07:53:21 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Wilczynski, Michal" <michal.wilczynski@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        andriy.shevchenko@intel.com, artem.bityutskiy@linux.intel.com,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, lenb@kernel.org, jgross@suse.com,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH] ACPI: processor: Move MWAIT quirk out of acpi_processor.c
Message-ID: <24860c20-0e08-46d6-8016-5cbbb97b4550@roeck-us.net>
References: <c7a05a44-c0be-46c2-a21d-b242524d482b@roeck-us.net>
 <CAJZ5v0jASjc_RYp-SN5KMGJXDv8xbMOqJscLF3wG8rdE2_KJGw@mail.gmail.com>
 <3fd2e62d-0aa9-1098-3eb3-ed45460a3580@intel.com>
 <CAJZ5v0hnNK4O_HyinvTp01YxXR7V4vzpMhf85yW9M2=52-O2Fg@mail.gmail.com>
 <60bea4fb-9044-76f1-fe2b-ddc35c526d5c@intel.com>
 <CAJZ5v0hkNFof_Wy0FmPAizuOT9WPEEPW+R27UCgERhS1ZKjOBw@mail.gmail.com>
 <6a50e2c7-a73b-ff02-3e36-e7477ea7dc4d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a50e2c7-a73b-ff02-3e36-e7477ea7dc4d@intel.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023 at 04:38:33PM +0200, Wilczynski, Michal wrote:
> 
[ ... ]
> For the fix:
> Acked-by: Michal Wilczynski <michal.wilczynski@intel.com>
> 

Or just drop it. From Ard Biesheuvel's e-mail sent to 0-day:

    > Hello all,
    >
    > The Linux community is currently in the process of deprecating the
    > Itanium IA-64 architecture, which no longer has a maintainer or any
    > actual users.
    >
    > We aim to remove it entirely from the Linux tree before the end of the
    > year, but one of the first steps is to stop build testing it - there
    > is really no point any longer in spending any cycles on this, and it
    > is definitely undesirable to inform developers by email if their
    > changes result in any build issues on IA-64.
    >
    > So please remove IA64 from the set of architectures that are build
    > tested by LKP.

This is from the 0-day commit log disabling ia64 build tests. I have now
disabled ia64 in my build tests as well.

Sorry for the noise.

Guenter
