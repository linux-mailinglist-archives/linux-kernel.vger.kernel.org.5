Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8007D5422
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 16:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234512AbjJXOdF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 24 Oct 2023 10:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234500AbjJXOdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 10:33:02 -0400
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B432B8F;
        Tue, 24 Oct 2023 07:33:00 -0700 (PDT)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-1e9e4636ce6so816616fac.0;
        Tue, 24 Oct 2023 07:33:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698157980; x=1698762780;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fbg6/Pf1XWF9qiAo/Bp62JB8vPkBgG8ganuOuh0wuf8=;
        b=tzs9spvNuWbWclMrStZfrCtlFW6hponatDdM9HBAVCNzkEHPozhznVlKu4ewiDiHI/
         5AhIhQzTp3fnckFdEi1Q++Njc+xm9ddHWjDV96NPkSG6cFomkXVvMoVVkjXyTSdRXwKQ
         RmLn0yR8fGLjVgkYpvJo0Sfj6YlOvHVuPsWbqdtmG+kxjTJA2DrCd+ucc+oYTeXsZjjQ
         0Tj/4KlTFkwV5UFdKF7EuL8oK344NQEQGmr+wJ3/KjvwGOxQEnULcQZGd8Aa4Iok6sKw
         /zyfr8jkeFWs/FqWdqpZu6rpqPmAwSilgeTok0s5kUSjUo7rw/dz8vtdyhP/0vcT3xQ0
         eLRQ==
X-Gm-Message-State: AOJu0YxOfoNxF+PZ1azdXgX1ZB8FyGVvj+iepm3ha6QNzEASZaFolZi9
        a8dclehjiRysD76e/aB4hlZFJD8az0uxqPsx3E0TpVx0
X-Google-Smtp-Source: AGHT+IGxdYwV+5t593nxdBm55S75OJLko9wE0PsBu2QC9lWamPymlRTCxskxQktjdzG3dQGMeihta+/uXq2E5VLwAw8=
X-Received: by 2002:a05:6871:220e:b0:1e9:adec:bf5e with SMTP id
 sc14-20020a056871220e00b001e9adecbf5emr12630628oab.2.1698157979897; Tue, 24
 Oct 2023 07:32:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230712223448.145079-1-jeshuas@nvidia.com> <DM6PR12MB3371BA50E3B76D2266273901DB09A@DM6PR12MB3371.namprd12.prod.outlook.com>
 <SJ1PR11MB6083426D3C663F47E707CF1AFC09A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <DM6PR12MB3371D86F80417641B8479B28DB0EA@DM6PR12MB3371.namprd12.prod.outlook.com>
 <DM6PR12MB3371FA3AEEA4D17D94C889D5DB1BA@DM6PR12MB3371.namprd12.prod.outlook.com>
 <DM6PR12MB337153EE2DDDB427096446F0DBF2A@DM6PR12MB3371.namprd12.prod.outlook.com>
 <DM6PR12MB3371083F4E6BCE4A8D2389E7DBC5A@DM6PR12MB3371.namprd12.prod.outlook.com>
 <DM6PR12MB33710C8FE59EB3CB1404ABC0DBD8A@DM6PR12MB3371.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB33710C8FE59EB3CB1404ABC0DBD8A@DM6PR12MB3371.namprd12.prod.outlook.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 24 Oct 2023 16:32:48 +0200
Message-ID: <CAJZ5v0g2TsBo4hxsJBo5a-ggD2Cj65VS=tokpoRaNwzWbPoeNw@mail.gmail.com>
Subject: Re: [PATCH V2] ACPI: APEI: Use ERST timeout for slow devices
To:     Jeshua Smith <jeshuas@nvidia.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "bp@alien8.de" <bp@alien8.de>
Cc:     "keescook@chromium.org" <keescook@chromium.org>,
        "gpiccoli@igalia.com" <gpiccoli@igalia.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 5:45 PM Jeshua Smith <jeshuas@nvidia.com> wrote:
>
> Can we get this merged please, or at least instructions for what needs to happen to get it merged?

So there are 3 designated reviewers for APEI: Tony Luck, Borislav
Petkov and James Morse.  I need an ACK or Reviewed-by from one of
them, so I can proceed with an APEI patch.

Thanks!

> -----Original Message-----
> From: Jeshua Smith
> Sent: Monday, October 2, 2023 10:10 AM
> To: Luck, Tony <tony.luck@intel.com>; keescook@chromium.org; gpiccoli@igalia.com; rafael@kernel.org; lenb@kernel.org; james.morse@arm.com; bp@alien8.de
> Cc: linux-acpi@vger.kernel.org; linux-kernel@vger.kernel.org; linux-hardening@vger.kernel.org; linux-tegra@vger.kernel.org; Thierry Reding <treding@nvidia.com>; Jonathan Hunter <jonathanh@nvidia.com>
> Subject: RE: [PATCH V2] ACPI: APEI: Use ERST timeout for slow devices
>
> Resending due to lack of responses.
>
> -----Original Message-----
> From: Jeshua Smith
> Sent: Monday, September 11, 2023 10:16 AM
> To: Luck, Tony <tony.luck@intel.com>; keescook@chromium.org; gpiccoli@igalia.com; rafael@kernel.org; lenb@kernel.org; james.morse@arm.com; bp@alien8.de
> Cc: linux-acpi@vger.kernel.org; linux-kernel@vger.kernel.org; linux-hardening@vger.kernel.org; linux-tegra@vger.kernel.org; Thierry Reding <treding@nvidia.com>; Jonathan Hunter <jonathanh@nvidia.com>
> Subject: RE: [PATCH V2] ACPI: APEI: Use ERST timeout for slow devices
>
> Any further questions? Anything else holding up this patch?
>
> -----Original Message-----
> From: Jeshua Smith <jeshuas@nvidia.com>
> Sent: Friday, August 4, 2023 7:05 PM
> To: Luck, Tony <tony.luck@intel.com>; keescook@chromium.org; gpiccoli@igalia.com; rafael@kernel.org; lenb@kernel.org; james.morse@arm.com; bp@alien8.de
> Cc: linux-acpi@vger.kernel.org; linux-kernel@vger.kernel.org; linux-hardening@vger.kernel.org; linux-tegra@vger.kernel.org; Thierry Reding <treding@nvidia.com>; Jonathan Hunter <jonathanh@nvidia.com>
> Subject: RE: [PATCH V2] ACPI: APEI: Use ERST timeout for slow devices
>
> Thanks for the reply.
>
> It's not very easy to see. It's just a bit down from the link you sent. It's the last possible action in the Serialization Actions table:
> https://uefi.org/specs/ACPI/6.5/18_Platform_Error_Interfaces.html#serialization-actions
>
> 18.5.1.1. Serialization Actions
>
> GET_EXECUTE-_OPERATION_TIMINGS
>
> Returns an encoded QWORD:
> [63:32] value in microseconds that the platform expects would be the maximum amount of time it will take to process and complete an EXECUTE_OPERATION.
> [31:0] value in microseconds that the platform expects would be the nominal amount of time it will take to process and complete an EXECUTE_OPERATION.
>
> -----Original Message-----
> From: Luck, Tony <tony.luck@intel.com>
> Sent: Friday, August 4, 2023 10:31 AM
> To: Jeshua Smith <jeshuas@nvidia.com>; keescook@chromium.org; gpiccoli@igalia.com; rafael@kernel.org; lenb@kernel.org; james.morse@arm.com; bp@alien8.de
> Cc: linux-acpi@vger.kernel.org; linux-kernel@vger.kernel.org; linux-hardening@vger.kernel.org; linux-tegra@vger.kernel.org; Thierry Reding <treding@nvidia.com>; Jonathan Hunter <jonathanh@nvidia.com>
> Subject: RE: [PATCH V2] ACPI: APEI: Use ERST timeout for slow devices
>
> External email: Use caution opening links or attachments
>
>
> > Can the maintainers please respond to my patch?
>
> Can you give a reference to the ACPI spec where this timing information is documented? I'm looking at ACPI 6.5 and don't see anything about this.
>
> https://uefi.org/specs/ACPI/6.5/18_Platform_Error_Interfaces.html#error-serialization
>
> -Tony
