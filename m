Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0273178191D
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 12:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbjHSKwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 06:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbjHSKwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 06:52:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C698F5246;
        Sat, 19 Aug 2023 03:50:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5826E6222E;
        Sat, 19 Aug 2023 10:50:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39AB7C433C8;
        Sat, 19 Aug 2023 10:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692442210;
        bh=UOf0VrNbj7jijgQLUEJOQOBTWQ8bE2tlLoIK1cWZfF4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kei/cEnCzd9vylrM81C/pPpoNImWO9ct/BfmNbABJtoIAiUdlMrA6QirCewN8nGsl
         E+/EyT5QuE5r/CU3d6rHBMKoRtj1M4beqjlpX4igDLY31/WCHuJE9cep162hACy+zA
         MkHvny2Q8i8kBUce3Avd2yXp9bzBiQ31Ho3RWg+I=
Date:   Sat, 19 Aug 2023 12:50:07 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     Evan Quan <evan.quan@amd.com>, Andrew Lunn <andrew@lunn.ch>,
        rafael@kernel.org, lenb@kernel.org, johannes@sipsolutions.net,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, alexander.deucher@amd.com,
        rdunlap@infradead.org, quic_jjohnson@quicinc.com, horms@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [V9 1/9] drivers core: Add support for Wifi band RF mitigations
Message-ID: <2023081919-mockup-bootleg-bdb9@gregkh>
References: <20230818032619.3341234-1-evan.quan@amd.com>
 <20230818032619.3341234-2-evan.quan@amd.com>
 <2023081806-rounding-distract-b695@gregkh>
 <2328cf53-849d-46a1-87e6-436e3a1f5fd8@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2328cf53-849d-46a1-87e6-436e3a1f5fd8@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 05:49:14PM -0500, Limonciello, Mario wrote:
> 
> 
> On 8/18/2023 4:24 PM, Greg KH wrote:
> > On Fri, Aug 18, 2023 at 11:26:11AM +0800, Evan Quan wrote:
> > >   drivers/base/Makefile                         |   1 +
> > >   drivers/base/wbrf.c                           | 280 ++++++++++++++++++
> > 
> > Why is a wifi-specific thing going into drivers/base/?
> > 
> > confused,
> > 
> > greg k-h
> 
> The original problem statement was at a high level 'there can be
> interference between different devices operating at high frequencies'. The
> original patches introduced some ACPI library code that enabled a mitigated
> for this interference between mac80211 devices and amdgpu devices.
> 
> Andrew Lunn wanted to see something more generic, so the series has morphed
> into base code for things to advertise frequencies in use and other things
> to listen to frequencies in use and react.
> 
> The idea is supposed to be that if the platform knows that these mitigations
> are needed then the producers send the frequencies in use, consumers react
> to them.  The AMD implementation of getting this info from the platform
> plugs into the base code (patch 2).
> 
> If users don't want this behavior they can turn it off on kernel command
> line.
> 
> If the platform doesn't know mitigations are needed but user wants to turn
> them on anyway they can turn it on kernel command line.

That's all fine, I don't object to that at all.  But bus/device-specific
stuff should NOT be in drivers/base/ if at all possible (yes, we do have
some exceptions with hypervisor.c and memory and cpu stuff) but for a
frequency thing like this, why can't it live with the other
wifi/frequency code in drivers/net/wireless/?

In other words, what's the benefit to having me be the maintainer of
this, someone who knows nothing about this subsystem, other than you
passing off that work to me?  :)

thanks,

greg k-h
