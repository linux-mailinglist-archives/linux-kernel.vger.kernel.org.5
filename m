Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB0D7D8C65
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 01:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345018AbjJZX4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 19:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjJZX4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 19:56:04 -0400
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E482990;
        Thu, 26 Oct 2023 16:56:00 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 0968E447DB;
        Thu, 26 Oct 2023 23:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1698364558; bh=pTmh+VYaqYyCEUP7RMHQNQzNBEJ1hMyK8YtMXGY9szs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=neYso5Veb7U5FZDDordXOSe+pwCfrauFnvMJW/yBDkhH2UskdCRYMiF0Esx8GJKV6
         10M+QzTSSd8dYLgb2d01XzAx9qiHmHuF4jmmH+AJpAQJqwOqe4gbUYNR0ZdPPHQryr
         aAlq5umdRpu+nh3Os7rMR3IvISt0JCdR/oLQBNhW/exP244zkE3CZM5abJsHYNhYxd
         x7RWBZ/dfxNpyt1iw15Gm+ysWU2CawROFq+0YzWGTGI/w2MzCBq2017dif8d65xBp/
         0ATXccL2wz9hbxDtJBVxbpSN8FkjGUctfSMmRVkV5ehx2W6IEWSUSajgnJMpNR25ME
         nu3/v63LPbj+g==
Message-ID: <006e6dc4-1b5d-f46c-b03f-c60576dcf620@marcan.st>
Date:   Fri, 27 Oct 2023 08:55:54 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] regmap: Ensure range selector registers are updated after
 cache sync
To:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org
References: <20231026-regmap-fix-selector-sync-v1-1-633ded82770d@kernel.org>
 <66c2f5d4-23de-4faf-a816-919516927f94@sirena.org.uk>
Content-Language: en-US
From:   Hector Martin <marcan@marcan.st>
In-Reply-To: <66c2f5d4-23de-4faf-a816-919516927f94@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/10/2023 01.22, Mark Brown wrote:
> On Thu, Oct 26, 2023 at 04:49:19PM +0100, Mark Brown wrote:
>> When we sync the register cache we do so with the cache bypassed in order
>> to avoid overhead from writing the synced values back into the cache. If
>> the regmap has ranges and the selector register for those ranges is in a
>> register which is cached this has the unfortunate side effect of meaning
>> that the physical and cached copies of the selector register can be out of
>> sync after a cache sync. The cache will have whatever the selector was when
>> the sync started and the hardware will have the selector for the register
>> that was synced last.
> 
> Given the nearness to the release I've dropped this into my CI and am
> intending to just apply it as soon as that's done in the hopes that it
> hits tomorrow's -next and gets a bit more coverage, it would be great if
> you could confirm if this fixes the systems where you saw the original
> issue.

Can confirm, this fixes the sleep borking issue on my end after
reverting my workaround.

Tested-by: Hector Martin <marcan@marcan.st>

- Hector

