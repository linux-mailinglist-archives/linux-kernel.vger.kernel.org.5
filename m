Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B50B7F84E5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 20:48:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346072AbjKXTsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 14:48:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345941AbjKXTsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 14:48:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A6019D
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 11:48:26 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4A9AC433C8;
        Fri, 24 Nov 2023 19:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700855305;
        bh=gHKTHd4j6XIRhnKYt2oXigfwGIV0dPhrNVHUTzvpRoU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tk/ZA1fOo/2PhLRWDhGROiIRCbpMNrCE+cBhmeIO9lm2vm//WJMCYJyRAdVoKv/v5
         OrCucJRpWOBX1qS9vnCVkI3jD+ajRhxZ6MSkxd9midiWgqgXhlolm+EsqXoyC0aRRr
         1dOs6vz+6mz0/vGHRgWv3jyRLiq0zNk1P7+DUFfJ7GynUd35Ay2t3/TwhHktNuRldA
         LKY7J6fM3+KMxiVYW7kL/3pugMTkQ2/nNuLdcuRE114gPsPuDVfXNo1fd3pvgu8cBr
         vd3AxT4gv2fzhEWMlhamBuxgEk8cXfaWzXnLNXO53TLoL3DfaamJbl/uj//AaU7+HN
         OyCnK4Afvj+RA==
Received: by pali.im (Postfix)
        id A2532891; Fri, 24 Nov 2023 20:48:22 +0100 (CET)
Date:   Fri, 24 Nov 2023 20:48:22 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Armin Wolf <W_Armin@gmx.de>
Cc:     jdelvare@suse.com, linux@roeck-us.net, hdegoede@redhat.com,
        markgross@kernel.org, ilpo.jarvinen@linux.intel.com,
        platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/9] hwmon: (dell-smm) Add support for WMI SMM
 interface
Message-ID: <20231124194822.3vtgoi7cgeszjbyp@pali>
References: <20231123004820.50635-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231123004820.50635-1-W_Armin@gmx.de>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 23 November 2023 01:48:11 Armin Wolf wrote:
> This patch series adds support for an alternative SMM calling
> backend to the dell-smm-hwmon driver. The reason for this is
> that on some modern machines, the legacy SMM calling interface
> does not work anymore and the SMM handler can be called over
> ACPI WMI instead.
> 
> The first four patches prepare the driver by allowing to
> specify different SMM calling backends, and by moving most of
> the DMI handling into i8k_init() so that the DMI tables can
> keep their __initconst attributes (the WMI SMM backend driver
> does not probe at module init time). The fifth patch does some
> minor cleanup, while the next three patches implement the new
> WMI SMM calling backend. The last patch adds the machine of
> the user who requested and tested the changes to the fan control
> whitelist.
> 
> If the driver does not detect the legacy SMM interface, either
> because the machine is not whitelisted or because the SMM handler
> does not react, it registers an WMI driver which will then bound
> to the WMI SMM interface and do the remaining initialization.
> 
> The deprecated procfs interface is not supported when using the
> WMI SMM calling backend for the following reason: the WMI driver
> can potentially be instantiated multiple times while the deprectated
> procfs interface cannot. This should not cause any regressions
> because on machines supporting only the WMI SMM interface, the
> driver would, until now, not load anyway.
> 
> All patches where tested on a Dell Inspiron 3505 and a Dell
> OptiPlex 7000.
> 
> Changes since v3:
> - Using unsigned integers for registers
> - use TAB instead of space after comma
> 
> Changes since v2:
> - Rework WMI response parsing
> - Use #define for method number
> 
> Changes since v1:
> - Cc platform driver maintainers
> - Fix formating inside documentation
> 
> Armin Wolf (9):
>   hwmon: (dell-smm) Prepare for multiple SMM calling backends
>   hwmon: (dell-smm) Move blacklist handling to module init
>   hwmon: (dell-smm) Move whitelist handling to module init
>   hwmon: (dell-smm) Move DMI config handling to module init
>   hwmon: (dell-smm) Move config entries out of i8k_dmi_table
>   hwmon: (dell-smm) Introduce helper function for data init
>   hwmon: (dell-smm) Add support for WMI SMM interface
>   hwmon: (dell-smm) Document the WMI SMM interface
>   hwmon: (dell-smm) Add Optiplex 7000 to fan control whitelist
> 
>  Documentation/hwmon/dell-smm-hwmon.rst |  38 +-
>  drivers/hwmon/Kconfig                  |   1 +
>  drivers/hwmon/dell-smm-hwmon.c         | 604 +++++++++++++++++--------
>  drivers/platform/x86/wmi.c             |   1 +
>  4 files changed, 454 insertions(+), 190 deletions(-)
> 
> --
> 2.39.2
> 

For me it looks good, you can add for whole series:
Reviewed-by: Pali Rohár <pali@kernel.org>
