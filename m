Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67CB88135B9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 17:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443492AbjLNQIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 11:08:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjLNQIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 11:08:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B6EE8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 08:08:48 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB93BC433C7;
        Thu, 14 Dec 2023 16:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702570128;
        bh=7VdQ12yzugL+1GbrdoTtZ7vj4jv3wa5jxL47AyNqvsk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZHjBO8lWhnQOepC1LMp4PWZfEceaLGvxOpYWiG9SrVosws48/QT47+jviCXOc9Nwr
         sWwdnRdQR8vUXkpZcndzlrAtOzDvSydeHZ7MsqtakVLS0fIN4h3H+kWHuOsjc2qwZd
         H+y9DxAkLzeVghLeBd5Zn83xxdcJD6qdhFWMkIOTqvbgZpwJ3gH7HM24HDf1cr4YVy
         VxXTWQkUISumkeL41JwVyz+XMs9AWJvpfasCmZvLibyWHnwWwgvFMEajfq5Y4FnKkJ
         uNfwwNiNAV9Xi7Wcq2yq+farVAhAG22Cb8+hVbjdv8P9laoiArWPLrOBM0DtDI/8Np
         bBTyW0hUmdagg==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan@kernel.org>)
        id 1rDoGS-0005mK-2v;
        Thu, 14 Dec 2023 17:08:44 +0100
Date:   Thu, 14 Dec 2023 17:08:44 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] soc: qcom: pmic_glink: Fix boot when QRTR=m
Message-ID: <ZXsojADuspUVLbIn@hovoldconsulting.com>
References: <20231213210644.8702-1-robdclark@gmail.com>
 <ZXqr0RFw9KsP876v@hovoldconsulting.com>
 <CAA8EJpoSvaq9imP-dT4p=4jveZyFmh=OoWOP7jWGo4OYkHQDTA@mail.gmail.com>
 <ZXsKzsij3Xb50Ap9@hovoldconsulting.com>
 <CAA8EJpqBstKyAfUcBPzoF2CitTwWBZ9Xhd28Y+FCo14OoBqkxw@mail.gmail.com>
 <ZXsMoFiivUCWA0yr@hovoldconsulting.com>
 <ZXshe83quTE0jO_Z@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXshe83quTE0jO_Z@hovoldconsulting.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2023 at 04:38:35PM +0100, Johan Hovold wrote:

> I took a closer look at this and indeed we do have code that triggers a
> reprobe of a device in case there was a successful probe while the
> device was probing.
> 
> This was introduced by commit 58b116bce136 ("drivercore: deferral race
> condition fix") and the workaround for the reprobe-loop bug that hack
> led to is to not return -EPROBE_DEFER after registering child devices as
> no one managed to come up with a proper fix. This was documented here:
> 
> 	fbc35b45f9f6 ("Add documentation on meaning of -EPROBE_DEFER")
> 
> But please spell this out in some more detail in the commit message, and
> add a Fixes and CC stable tag.

And please update the commit summary as I've been booting with QRTR=m
all along just fine. I guess the issue is if you have pmic_glink
built-in or in the initramfs but forgot to include qrtr or similar?

Johan
