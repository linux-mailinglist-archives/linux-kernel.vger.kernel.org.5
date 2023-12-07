Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3AA1808096
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 07:22:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjLGGWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 01:22:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjLGGWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 01:22:15 -0500
Received: from smtp.smtpout.orange.fr (smtp-15.smtpout.orange.fr [80.12.242.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C828D4B
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 22:22:20 -0800 (PST)
Received: from [192.168.1.18] ([92.140.202.140])
        by smtp.orange.fr with ESMTPA
        id B7m1rSAZd33VXB7m1r3STG; Thu, 07 Dec 2023 07:22:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1701930138;
        bh=4vdrRLFCnP7xUS6SueOm2vXaBS/ChKMge64ed0bJe/Y=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=oGzDlgAjZhGZsLfCXgMx4vh6mcwWYU4wJJ89qpihCpC0qh2bAASqzT6aCsQhYlCMr
         Cn2I5kYl9JUN4HCkYLnS6p0uiAVR+8hKwQ3L6VDustH20bs0ujFxhB+UIZV3aF4KQs
         n/Ar2QVdoAaG24X7vNFkSnW8r/E/XETIDvzKA3CbO3aWF/x8oszLUytVXjIetj97UD
         ROTqo48ZvCQDMjtaP/NjabzdhQqJ0aTjH+b1dAuNmgYDCk1vWiQx4YXDlIVg0nn2kJ
         AixU20WdOLBSL97KJrjuz+hzcTZC5PRO+BUFIYJDp9XFTE6b9sAlcivLRIhMMmfSxk
         mWFZybIfDLRrg==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 07 Dec 2023 07:22:18 +0100
X-ME-IP: 92.140.202.140
Message-ID: <4f53df8e-0957-44b6-b18e-e4362800e180@wanadoo.fr>
Date:   Thu, 7 Dec 2023 07:22:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 13/14] crypto: iaa - Add IAA Compression Accelerator
 stats
Content-Language: fr
To:     Tom Zanussi <tom.zanussi@linux.intel.com>,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        fenghua.yu@intel.com, vkoul@kernel.org
Cc:     dave.jiang@intel.com, tony.luck@intel.com,
        wajdi.k.feghali@intel.com, james.guilford@intel.com,
        kanchana.p.sridhar@intel.com, vinodh.gopal@intel.com,
        giovanni.cabiddu@intel.com, pavel@ucw.cz,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        dmaengine@vger.kernel.org
References: <20231205212530.285671-1-tom.zanussi@linux.intel.com>
 <20231205212530.285671-14-tom.zanussi@linux.intel.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20231205212530.285671-14-tom.zanussi@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 05/12/2023 à 22:25, Tom Zanussi a écrit :
> Add support for optional debugfs statistics support for the IAA
> Compression Accelerator.  This is enabled by the kernel config item:
> 
>    CRYPTO_DEV_IAA_CRYPTO_STATS
> 
> When enabled, the IAA crypto driver will generate statistics which can
> be accessed at /sys/kernel/debug/iaa-crypto/.
> 
> See Documentation/driver-api/crypto/iax/iax-crypto.rst for details.
> 
> Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> ---

> +void update_max_adecomp_delay_ns(u64 start_time_ns)
> +{
> +	u64 time_diff;
> +
> +	time_diff = ktime_get_ns() - start_time_ns;
> +
> +	if (time_diff > max_adecomp_delay_ns)
> +

Nit: unneeded NL.

> +		max_adecomp_delay_ns = time_diff;
> +}

CJ
