Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42B857AA7D9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 06:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbjIVEdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 00:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbjIVEdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 00:33:11 -0400
X-Greylist: delayed 10626 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 21 Sep 2023 21:33:05 PDT
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [71.19.156.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B714F1;
        Thu, 21 Sep 2023 21:33:04 -0700 (PDT)
Received: from hatter.bewilderbeest.net (unknown [IPv6:2602:61:7e5d:5300::2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 7504A71B;
        Thu, 21 Sep 2023 21:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1695357184;
        bh=8YhJXVZbP6dpiyW7g8fmW82LVz5b6CyHIGSx77XYF/o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R+K7lrPyYUJBRH6oCed7c7Uh3zR6NY2mxFM8Jzu3HDl0p58goA/QDt3biPMGB5JtD
         Uh7UbkX66lCSsd3zUVDwcRhpuXJ/LLTlXKEoLMMwBJ00M0u1CqngDB+Vz1PpDjEbTY
         Hd+28RTTMeDZkSeVpVLJc+mYhfZYLQjF5ifG+FEY=
Date:   Thu, 21 Sep 2023 21:33:03 -0700
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Andrew Jeffery <andrew@codeconstruct.com.au>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        linux-watchdog@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Eddie James <eajames@linux.ibm.com>,
        Ivan Mikhaylov <i.mikhaylov@yadro.com>
Subject: Re: [PATCH] watchdog: aspeed: Add sysfs attributes for reset mask
 bits
Message-ID: <06a2428d-e1f3-4ecd-bd42-f3e25ffdbced@hatter.bewilderbeest.net>
References: <20230922013542.29136-2-zev@bewilderbeest.net>
 <91be26169ebbddf3c05cd19626478246cb72a72a.camel@codeconstruct.com.au>
 <85ddf493-934f-75c4-7a3a-728289c1ee09@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <85ddf493-934f-75c4-7a3a-728289c1ee09@roeck-us.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2023 at 09:24:40PM PDT, Guenter Roeck wrote:
>On 9/21/23 21:16, Andrew Jeffery wrote:
>>On Thu, 2023-09-21 at 18:35 -0700, Zev Weiss wrote:
>>>The AST2500 and AST2600 watchdog timers provide the ability to control
>>>which devices are reset by the watchdog timer via a reset mask
>>>resgister.  Previously the driver ignored that register, leaving
>>>whatever configuration it found at boot and offering no way of
>>>altering its settings.  Add a 'reset_ctrl' sysfs subdirectory with a
>>>file per bit so that userspace can determine which devices the reset
>>>is applied to.
>>>
>>>Note that not all bits in the hardware register are exposed -- in
>>>particular, the ARM CPU and SOC/misc reset bits are left hidden since
>>>clearing them can render the system unable to reboot.
>>>
>>>Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
>>>---
>>>
>>>I'm porting OpenBMC to a platform that requires that the LPC controller remain
>>>un-reset by a BMC reboot.  With this patch userspace can control the reset
>>>mask of the Aspeed watchdog timer, with a few bits remaining unexposed so as
>>>to prevent some almost-certainly undesirable situations.  If there are other
>>>bits that people feel shouldn't be exposed (or conversely if someone feels
>>>strongly that the "dangerous" bits _should_ be exposed) I can adjust
>>>accordingly.
>>
>>
>>Is there a reason this has to be managed by userspace? It sounds a lot
>>like a property of platform design, in which case exposing this feature
>>in the devicetree might be a better approach.
>>
>
>Same sentiment here.
>
>Guenter
>
>

Yes, and indeed the same thing occurred to me, too, though unfortunately 
not until just *after* I sent the patch...I'll rework it as a DT thing 
instead.

Thanks,
Zev

