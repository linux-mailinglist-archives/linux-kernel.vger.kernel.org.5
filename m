Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6502F7932E3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 02:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234318AbjIFA0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 20:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjIFA0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 20:26:34 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08EE61B4
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 17:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1693959982;
        bh=SoE91qXRUWPW46au5ZyRyW+Vo6UxCIMGnTtt90mJC8g=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=TGGTLwPik/3NFf/PrvJzgebV0Y9QD2/ny56oBlpGS3B9emuR5f/Y+GwteBDdvERMl
         MUfo2x0f5Sm/c+eJw+C65nk3t1b43cWw1qJ4h2twuu4BqDYnZhJUECY8UXGO2lyD71
         5j0gkWox/hrTFStFUggOUF19EGRnQX/s2SJ40PKybnUfW/K84ratUn9A0iOWFihE4y
         QGiS5Cu4dMRnVH0BXnBTTnCBrgzlzCuict3jcoUrOFA+zNvcbfB/KLiLNmKpJAdn5U
         cqn2gCG4bv4r8dyz/Y3Su5Iy7rjv8FTFRjIRiXktJwJoRvtwCeXNihiYOjB4xG1ZNz
         6dC6ZTLDpy8tw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RgNTV1HXSz4wxR;
        Wed,  6 Sep 2023 10:26:22 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Lee Jones <lee@kernel.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        geert@linux-m68k.org
Subject: Re: [PATCH] mfd: cs42l43: Use correct macro for new-style PM
 runtime ops
In-Reply-To: <20230904144008.GG13143@google.com>
References: <20230822114914.340359-1-ckeepax@opensource.cirrus.com>
 <20230904144008.GG13143@google.com>
Date:   Wed, 06 Sep 2023 10:26:17 +1000
Message-ID: <87zg20cfkm.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Jones <lee@kernel.org> writes:
> On Tue, 22 Aug 2023, Charles Keepax wrote:
>
>> The code was accidentally mixing new and old style macros, update the
>> macros used to remove an unused function warning whilst building with
>> no PM enabled in the config.
>> 
>> Fixes: ace6d1448138 ("mfd: cs42l43: Add support for cs42l43 core driver")
>> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
>> ---
>>  drivers/mfd/cs42l43.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>> 
>> diff --git a/drivers/mfd/cs42l43.c b/drivers/mfd/cs42l43.c
>> index 37b23e9bae823..7b6d07cbe6fc6 100644
>> --- a/drivers/mfd/cs42l43.c
>> +++ b/drivers/mfd/cs42l43.c
>> @@ -1178,8 +1178,8 @@ static int cs42l43_runtime_resume(struct device *dev)
>>  }
>>  
>>  EXPORT_NS_GPL_DEV_PM_OPS(cs42l43_pm_ops, MFD_CS42L43) = {
>> -	SET_SYSTEM_SLEEP_PM_OPS(cs42l43_suspend, cs42l43_resume)
>> -	SET_RUNTIME_PM_OPS(cs42l43_runtime_suspend, cs42l43_runtime_resume, NULL)
>> +	SYSTEM_SLEEP_PM_OPS(cs42l43_suspend, cs42l43_resume)
>> +	RUNTIME_PM_OPS(cs42l43_runtime_suspend, cs42l43_runtime_resume, NULL)
>>  };
>>  
>>  MODULE_DESCRIPTION("CS42L43 Core Driver");
>
> Acked-by: Lee Jones <lee@kernel.org>
>
> If anyone wants to submit this directly to Linus before -rc1, please, be
> my guest.

But you're the MFD maintainer, aren't you? So I think everyone is
expecting you to send it to Linus.

cheers
