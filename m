Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26F1C78FA85
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 11:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348728AbjIAJN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 05:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232310AbjIAJN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 05:13:28 -0400
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [71.19.156.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8BBE7B
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 02:13:25 -0700 (PDT)
Received: from hatter.bewilderbeest.net (unknown [IPv6:2602:3f:e471:aa00::2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id B81F6162;
        Fri,  1 Sep 2023 02:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1693559604;
        bh=W2Jl8sMSCZT9fmxrqy9p4J94czyEoka/FqDv4PckhAg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kSeeNESOkTXpiGJ93OnKld4c5e8ICgn31alKdWyIPIh9wz9ZPaExLS/P5fk9ZrqV6
         FMSb+L/Uq/XvmOB0sfj+wrcQWlhfiyfKjWImahYxQZUHJ//oudY0IJys4hnVF95Vu8
         Wy5mkZIerren/6RTGSV2FUDo09etO2njl7hUihUU=
Date:   Fri, 1 Sep 2023 02:13:23 -0700
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     broonie@kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 3/3] Documentation: ABI: sysfs-driver-regulator-output
Message-ID: <90b1af83-cb03-476f-9147-eb06247bf09c@hatter.bewilderbeest.net>
References: <20230831121412.2359239-1-Naresh.Solanki@9elements.com>
 <20230831121412.2359239-3-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230831121412.2359239-3-Naresh.Solanki@9elements.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding Greg re: sysfs ABI design...

On Thu, Aug 31, 2023 at 05:14:10AM PDT, Naresh Solanki wrote:
>Adds sysfs-driver-regulator-output
>
>Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
>---
> .../ABI/testing/sysfs-driver-regulator-output         | 11 +++++++++++
> 1 file changed, 11 insertions(+)
> create mode 100644 Documentation/ABI/testing/sysfs-driver-regulator-output
>
>diff --git a/Documentation/ABI/testing/sysfs-driver-regulator-output b/Documentation/ABI/testing/sysfs-driver-regulator-output
>new file mode 100644
>index 000000000000..f9b0a8f810fa
>--- /dev/null
>+++ b/Documentation/ABI/testing/sysfs-driver-regulator-output
>@@ -0,0 +1,11 @@
>+What:		/sys/bus/platform/drivers/regulator-output/*/events
>+Date:		August 2023
>+Description:	Provided regulator events.
>+
>+		Read provides various events the regulator associated with the
>+		driver has encountered. All REGULATOR_EVENT_* are
>+		defined in include/uapi/linux/regulator.h
>+
>+		e.g.
>+		cat /sys/bus/platform/drivers/regulator-output/ssb_rssd32/events
>+		0x0

If we really are going to proceed with a "read with side-effects" 
(clear-on-read) design, that should absolutely be loudly and clearly 
documented, since it's very different from how sysfs files typically 
work and hence a somewhat glaring principle-of-least-surprise violation.  
Also, since from the code it looks like it's intended to be used via 
poll(2), that should be described here as well.


Zev

