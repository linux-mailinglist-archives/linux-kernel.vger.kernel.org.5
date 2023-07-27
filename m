Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBE87765100
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 12:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234082AbjG0KZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 06:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234072AbjG0KYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 06:24:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14CD53AAF;
        Thu, 27 Jul 2023 03:24:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 174F561E12;
        Thu, 27 Jul 2023 10:24:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4924C433C7;
        Thu, 27 Jul 2023 10:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690453457;
        bh=kOpq2Rqf0U8SKxfPvgA2k2zHDoA/cmp6l7XutklD4OE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=goyWfYbQExutZwjItnrCLlgv8n7vVQCY2X2TkzyOnmkzY4GNKu9a41ihr7RmqAa4a
         J7A4HvzFaMDakoOAr9ZgWyJiwpd1gji4uJcllffhpCkpCKMq2hCSYcqHvXjM808zH6
         DEClxV3fQzdlP5OvZS912+wXJaaIkqkpAa6dc+LOBK2O4Ga504P8sAWK07WaaFo7yG
         7T3GQt4DmTHmdSEPsoycKPwZNdqv8KHU8suRak+s6UVdSNrtPxJoNOhd0bQLWa3QGm
         hbAIlTIh9MFRIvuazaqgnx1OGzNx7/WH4RB97hMfFTwZZFFcL+6nKS1/d1LgIYyWmx
         /dowfhjCC/J5g==
Message-ID: <242cdfbc-5b11-015d-5123-fc6aadd1c918@kernel.org>
Date:   Thu, 27 Jul 2023 19:24:16 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: Scsi_bus_resume+0x0/0x90 returns -5 when resuming from s3 sleep
Content-Language: en-US
To:     TW <dalzot@gmail.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     regressions@lists.linux.dev,
        Mario Limonciello <mario.limonciello@amd.com>,
        Bart Van Assche <bvanassche@acm.org>,
        LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
References: <0e272abe-292d-d58f-cf80-55868e793abc@gmail.com>
 <6b66dd9a-8bd5-2882-9168-8e6e0848c454@leemhuis.info>
 <c70caa9e-164c-fee5-8f85-67f6d02373ab@kernel.org>
 <b0ed86e0-3e4a-d4d1-7b9d-c57f20538a80@gmail.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <b0ed86e0-3e4a-d4d1-7b9d-c57f20538a80@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/27/23 19:06, TW wrote:
> I retried on 6.5 rc3 without the Nvidia drivers and still received the same
> error and going to try for the patch next but got a malformed patch error on
> line 6 for the first patch for libata-scsi.c. The other two seem to go through
> just fine however.

Which other two patches are you talking about ?

> Also the bugzilla link is similar to what I have but the disk doesn't
> disappear, comes back but just takes awhile to come back out of sleep mode.

The switch to async resume has revealed many issues with the way ata devices
are resumed with regard to their scsi representation. The issues manifest in
different form. The drive "gone" problem was fixed recently. The start-stop
command seem to cause most of the time a delay in resume that several users
noticed. In your case though, it is an outright failure.

Hence the *single* patch I asked you to test (another user with a delay issue
is testing the same as well). Not sure what other patches you are talking about.

-- 
Damien Le Moal
Western Digital Research

