Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3377A964C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbjIURHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbjIURHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:07:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F37D359D;
        Thu, 21 Sep 2023 10:03:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E38C5C4E770;
        Thu, 21 Sep 2023 15:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695311117;
        bh=E1dhxis8ZumBm0hKaOMOgVxtcqW/DF2vSRD3c8E34to=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hnb53gE9VP9wyiDUEYS9uM+cYkAMgpeaQr7Zkpf0rCGGzVG+CalXEkvwN+Nvrlgwn
         SShkMPiln06WcGb3i3GYwdQqgmB2SkXTR+yQd2iHhdeBhlJkwWBWw9tE5WFfRbjNV+
         PywkpmRf30b8hWmQupUhSJghVx8L2s7Qnkv2eTdEQB2MzfqZgXK1HOGUCm5HDSSm0s
         X4NhbhVqZsl1pL04z4TTwAyUI946pLdhf9ycusxuBkbXLz3BK0F9iD9tupyAdb4kgN
         DfUx88OB9vJBn9cWIN9QjnMbPme61mEW7+BOHGCmSyw9SRc7OhW1JafPQoDNsUsWV5
         Uh/US7cqytnug==
Received: (nullmailer pid 396045 invoked by uid 1000);
        Thu, 21 Sep 2023 15:45:14 -0000
Date:   Thu, 21 Sep 2023 10:45:14 -0500
From:   Rob Herring <robh@kernel.org>
To:     David Lechner <dlechner@baylibre.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>
Subject: Re: [PATCH 4/4] iio: resolver: add new driver for AD2S1210
Message-ID: <20230921154514.GA383967-robh@kernel.org>
References: <20230920170253.203395-1-dlechner@baylibre.com>
 <20230920170253.203395-5-dlechner@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230920170253.203395-5-dlechner@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 12:02:53PM -0500, David Lechner wrote:
> This adds a new driver for Analog Devices, Inc. AD2S1210 resolver to
> digital converter. The driver is based on the staging driver with the
> following improvements:
> 
> Fixes:
> - Fix use before initialization bug in probe.
> - Fix not checking error returns in probe.
> - Remove spi_setup() and spi_set_drvdata() from probe.
> - Fix ordering of devm_iio_device_register()
> - Remove incorrect hysteresis logic
> 
> Changes:
> - Use BIT/GENMASK macros.
> - Use devicetree to get CLKIN frequency (was sysfs attribute).
> - No longer bit-shift the raw value for IIO_CHAN_INFO_RAW.
> - Use regmap for register access.
> - Remove config sysfs attribute.
> - Use gpio array for mode and resolution gpios.
> - Invert sample gpio logic and use GPIO_ACTIVE_LOW in devicetree.
> - Change hysteresis to use IIO_CHAN_INFO_HYSTERESIS instead of custom
>   device attribute.
> - Rename fexcit attribute to excitation_frequency.
> - Use devicetree to specify resolution instead of sysfs attribute.

Why? sysfs allows a user to change at run-time. DT is a firmware 
change. What/who determines the resolution? Unless it's the hardware 
design/designer, it probably doesn't belong in DT.

Rob
