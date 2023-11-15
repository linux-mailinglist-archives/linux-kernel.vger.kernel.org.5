Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D20EE7EC75E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 16:33:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjKOPdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 10:33:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjKOPdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 10:33:52 -0500
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C81101;
        Wed, 15 Nov 2023 07:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1700062428;
        bh=0NwkqGMmlxRkONEuO4KbmE3UnNfjeoUyBXz8wtpcI6I=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=iU09SIHBmcpVTgbcYJxzjAW/StJk21020JMEkRL7HtMXPbIQrZRdc6PDKNjk79RmF
         84AQ4X1+tnR5rLk0bzgNGLV6BHCCKqpFULgwcv/i3Oi2fgX/X9vU8b1I26Y1tISWuI
         WWsS/WG3PrtXOvhiAua79ZxfMQpmHNLcAxYSOSnWcrNeiB6ytB6YCgykv1ldzxJ1Rh
         2IYLNTeUNTDsOAeZwHEY/i2jxEPpgR8YIKk7NWdJyMRiz5MnGnASJIdssBpYPXbNtL
         5BrGbUiQ/ZMdsAkf1l9MscLC4IZN39gBEewmbo5HPgNEaUbaLsSTmQEfKkyiR1Cy81
         sXybTB4xdCvTQ==
Received: from [172.25.85.137] (unknown [12.186.190.1])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4SVnJD4Zz9z1cB6;
        Wed, 15 Nov 2023 10:33:48 -0500 (EST)
Message-ID: <8431b227-d053-4a9a-a278-2a43753fdaf7@efficios.com>
Date:   Wed, 15 Nov 2023 10:34:16 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/media_tests: fix a resource leak
Content-Language: en-US
To:     zhujun2 <zhujun2@cmss.chinamobile.com>, shuah@kernel.org
Cc:     ivan.orlov0322@gmail.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231114093812.7169-1-zhujun2@cmss.chinamobile.com>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20231114093812.7169-1-zhujun2@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-11-14 04:38, zhujun2 wrote:
> The opened file should be closed in main(), otherwise resource
> leak will occur that this problem was discovered by code reading

Fixing resource leaks for one-off test cases (processes execute and
then immediately exit) seems to be something that would fit in the
definition of "trivial", so I would advise to perhaps send those
patches to kernel-janitors@vger.kernel.org ?

[...]

> +
> +	close(fd);

These added calls to close(2) miss handling of possible close errors
(check return value and use errno to print an error).

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

