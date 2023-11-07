Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9A57E4781
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 18:47:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343791AbjKGRrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 12:47:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234059AbjKGRrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 12:47:40 -0500
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E7012B;
        Tue,  7 Nov 2023 09:47:37 -0800 (PST)
Received: from mail.denx.de (unknown [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: festevam@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 5BA6A86A4B;
        Tue,  7 Nov 2023 18:47:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1699379255;
        bh=z2skP0QUuom9Ov5APPRdXBVMApL55yJrBa+TcMmxoQU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Yw5kdngFnOTAS7eWIR/o6di5DUvkthxkDPFFhVvDyN16Kw2uRLH686n37ZCkS0X+a
         2l8iEiJTc6V9zN9iNaYJBEqHg0fNUc/uvFkxuejLlCJr7EbnyNoYwiBeLIRdPA21Os
         wetV5ZibCWWYDPe0zGGrE98nsKX85VFAwU/eIFJHN42F0g9VqrKq/WTr3yuFsO+GoL
         +zJPLAix2+kIqqaNdj/h/cGI+OlzwudcqqPc0xvkY/WtZghzZAss4BxXPOIyyvsO10
         u8TNY0IM7vEIZiQMvvaCLaCB03H08uNdAYpOfEJYZbbq7qudSWj3kE+GPfPeJ9rvMJ
         QjXBDGuavSaPg==
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 07 Nov 2023 14:47:35 -0300
From:   Fabio Estevam <festevam@denx.de>
To:     Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        =?UTF-8?Q?S=C3=A9bastien_Szymanski?= 
        <sebastien.szymanski@armadeus.com>, Stefan Agner <stefan@agner.ch>,
        Shawn Guo <shawnguo@kernel.org>, Marek Vasut <marex@denx.de>,
        NXP Linux Team <linux-imx@nxp.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: imx6q: Only disabling 792MHz OPP for i.MX6ULL
 types below 792MHz
In-Reply-To: <20231107163136.63440-1-cniedermaier@dh-electronics.com>
References: <20231107163136.63440-1-cniedermaier@dh-electronics.com>
Message-ID: <188c5e1cddc05f9bd44510e0a4f988df@denx.de>
X-Sender: festevam@denx.de
User-Agent: Roundcube Webmail/1.3.6
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

Thanks for your patch.

On 07/11/2023 13:31, Christoph Niedermaier wrote:
> For a 900MHz i.MX6ULL CPU the 792MHz OPP is disabled. There is no
> convincing reason to disable this OPP. If a CPU can run at 900MHz,
> it should also be able to cope with 792MHz. Looking at the voltage
> level of 792MHz in [1] (page 24, table 10. "Operating Ranges") the
> current defined OPP is above the minimum. So the voltage level
> shouldn't be a problem. Although in [2] (page 24, table 10.
> "Operating Ranges") 792MHz isn't mentioned there isn't note that
> 792MHz OPP isn't allowed. Change it to only disable 792MHz OPP for

I find this part:

"792MHz isn't mentioned there isn't note that 792MHz OPP isn't allowed."

a bit confusing.

Maybe:

"However in [2] (page 24, table 10. "Operating Ranges"), it is not 
mentioned that 792MHz OPP isn't allowed."


> [1] https://www.nxp.com/docs/en/data-sheet/IMX6ULLIEC.pdf
> [2] https://www.nxp.com/docs/en/data-sheet/IMX6ULLCEC.pdf
> 
> Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
> Reviewed-by: Marek Vasut <marex@denx.de>

I think it is worth adding a Fixes tag so that this fix could be 
backported
to stable kernels.

Reviewed-by: Fabio Estevam <festevam@denx.de>

Thanks
