Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B51C7D4B57
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 10:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233957AbjJXI5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 04:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233903AbjJXI5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 04:57:53 -0400
Received: from mx.kernkonzept.com (serv1.kernkonzept.com [IPv6:2a01:4f8:1c1c:b490::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09CAAC;
        Tue, 24 Oct 2023 01:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kernkonzept.com; s=mx1; h=In-Reply-To:Content-Type:MIME-Version:References:
        Message-ID:Subject:Cc:To:From:Date:Content-Transfer-Encoding:Reply-To:
        Content-ID:Content-Description;
        bh=Uk5O71GDx72WXdUblzMnR+VVcl72M4KhBs4KQ0VulsE=; b=i69p3ITxAqu1CLZFHv8iB+el7V
        BhuDUjSZlAXc/kX4+RvjR0IBupPGEEdxj4aieR8knlCHyImJHQHuauSCEW+tnoBHyUIzJ0ItkCGsD
        D9AIcKCtlVRclMAlBHmrleCy7cbxYeK2TMAML5GUe5m21nA4XNAMlZ1vZ3rA9O8Y8uG01tOvqa5h1
        o6MtRe0zY1LEzGPehXSEIJ6hUxU8/DJdWwlqEkqI3lubs76hIDfP0BfaqPwgnwFYgxwaof43nQD4E
        z3inVnOtC5UoVG12bUb/bTBJOPKnaNby3hEyslCHRV95LZ7GuRbxbbKeexuJA3raNtpwozgFYXCyj
        IdGsUhLw==;
Received: from [10.22.3.24] (helo=kernkonzept.com)
        by mx.kernkonzept.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.96)
        id 1qvDEN-000hTc-32;
        Tue, 24 Oct 2023 10:57:43 +0200
Date:   Tue, 24 Oct 2023 10:57:38 +0200
From:   Stephan Gerhold <stephan.gerhold@kernkonzept.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>
Subject: Re: [PATCH RFC 1/2] regulator: core: Disable unused regulators with
 unknown status
Message-ID: <ZTeHAqL5QB2w33RN@kernkonzept.com>
References: <20231004-reg-smd-unused-v1-0-5d682493d555@kernkonzept.com>
 <20231004-reg-smd-unused-v1-1-5d682493d555@kernkonzept.com>
 <80307316-f55e-4540-9c5f-655844c3b3f4@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80307316-f55e-4540-9c5f-655844c3b3f4@sirena.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 01:09:11PM +0100, Mark Brown wrote:
> On Wed, Oct 04, 2023 at 04:17:17PM +0200, Stephan Gerhold wrote:
> 
> > Instead of -EINVAL we could also use a different return code to indicate
> > the initial status is unknown. Or maybe there is some other option that
> > would be easier? This is working for me but I'm sending it as RFC to get
> > more feedback. :)
> 
> The more normal thing here would be -EBUSY I think - -EINVAL kind of
> indicates that the operation will never work while in reality it could
> possibly work in future.  Though for the RPMH it's not really the case
> that it ever supports readback, what it does is have it's own reference
> counting in the driver.  Rather than doing this we should probably have
> logic in the core which sees that the driver has a write operation but
> no read operation and implements appropriate behaviour.

Yep, I agree that it would be nicer to handle this case in the core,
rather than duplicating the logic in all the RPM-related drivers.

I think it does not change much for this patch, though. Even when
implemented in the core we still need to represent this situation
somehow for regulator_is_enabled(). Simply returning 0 (disabled) or
1 (enabled) would be wrong. Do you think returning -EBUSY would be
appropriate for that?

The second challenge I see on a quick look is that both
qcom_smd-regulator.c and qcom-rpmh-regulator.c use their reference
counter internally in other function (e.g. to decide if a voltage change
should be sent, see "vreg->enabled" checks). I think we would also need
to add some rdev_is_enabled() function that would expose the core
reference counter to the driver?

Tracking the enable state in the driver (the way it is right now) is not
that much code, so I'm not entirely sure if we might actually end up
with more code/complexity when moving this to the core.

Thanks,
-- 
Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Kernkonzept GmbH at Dresden, Germany, HRB 31129, CEO Dr.-Ing. Michael Hohmuth
