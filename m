Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0C2F785111
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 09:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233108AbjHWHDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 03:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233106AbjHWHDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 03:03:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E39E65;
        Wed, 23 Aug 2023 00:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692774176; x=1724310176;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=q5D2ljU2JGIhPaZ1OlS467jEnnsJpuDAECJw5x3ZlBo=;
  b=WUFbsjQwmK5KY2QmfYLG3MnB0LCrO72V9V14nq65zmnzXHWnLYYxfOj2
   rblJWGFDw3Ect53mD9hTaR9fyKFYoL52XDmdMb5F7ExOdXw31zT0bFsH8
   7UR11ZyjBdsH5cNsW2EcUhiOP/sB2U5tjoUess4CmVF7JZyQUEnfr1Z4t
   7PoHMrafFvxxMtzlXcb4eGP9mRryna+A0jlAGOUY0SGepWLG0325ZeF5P
   kZOQPc6MDCYKGj0sRR9k73bBioGdRdj7p0C5TbUMm1eygBsvDX6An6M17
   RlBklyECC60V8mqzwbfHZ+ZzeGOnKN2jNnfUEwChl5GtIZVEfwrnn2Ryc
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="359071539"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="359071539"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 00:02:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="880293467"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 23 Aug 2023 00:02:56 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 23 Aug 2023 10:02:51 +0300
Date:   Wed, 23 Aug 2023 10:02:51 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Abdel Alkuor <alkuor@gmail.com>
Cc:     devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, abdelalkuor@geotab.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v4 0/2] Add support for TPS25750
Message-ID: <ZOWvG1MQw37IOHcM@kuha.fi.intel.com>
References: <cover.1692559293.git.alkuor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1692559293.git.alkuor@gmail.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 20, 2023 at 03:32:25PM -0400, Abdel Alkuor wrote:
> TPS25750 is USB Type-C and PD controller. The device is
> highly configurable using App Customization online Tool 
> developed by TI to generate loadable binary.
> 
> TPS25750 supports three modes; PTCH, APP, and BOOT. A configuration
> can only be applied when the controller is on PTCH mode.
> 
> The controller attempts to load a configuration from EEPROM on
> I2Cm bus. If no EEPROM is detected, then the driver tries to load
> a configuration on I2Cs bus using a firmware file defined
> in DT.
> 
> The driver implements the binary loading sequence which 
> can be found on pg.53 in TPS25750 Host Interface Technical
> Reference Manual (Rev. A) https://tinyurl.com/y9rkhu8a
> 
> The driver only supports resume pm callback as power management is
> automatically controlled by the device. See pg.47 in TPS25750
> datasheet https://tinyurl.com/3vfd2k43
> 
> v4:
>  - PATCH 1: No change
>  - PATCH 2: Fix comments style and drop of_match_ptr
> v3:
>  - PATCH 1: Fix node name
>  - PATCH 2: Upload tps25750 driver patch
> v2:
>  - PATCH 1: General properties clean up
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Abdel Alkuor (2):
>   dt-bindings: usb: Add ti,tps25750
>   USB: typec: Add TI TPS25750 USB Type-C controller
> 
>  .../devicetree/bindings/usb/ti,tps25750.yaml  |   81 ++
>  drivers/usb/typec/Kconfig                     |   13 +
>  drivers/usb/typec/Makefile                    |    1 +
>  drivers/usb/typec/tps25750.c                  | 1077 +++++++++++++++++
>  drivers/usb/typec/tps25750.h                  |  162 +++
>  5 files changed, 1334 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/ti,tps25750.yaml
>  create mode 100644 drivers/usb/typec/tps25750.c
>  create mode 100644 drivers/usb/typec/tps25750.h

TPS25750 has the same host interface as TI TPS65xxx controllers, no?
The register offsets at least are exactly the same.

You need to first try to incorporate support for TI25750 support into
the existing tipd driver (drivers/usb/typec/tipd/).

thanks,

-- 
heikki
