Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8D547CBD57
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 10:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234708AbjJQI1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 04:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjJQI1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 04:27:09 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A93B0;
        Tue, 17 Oct 2023 01:27:06 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3833E240002;
        Tue, 17 Oct 2023 08:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1697531225;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V9RqjAr2qnLGSR32tAtTp3+NiG84U4voNqHqPUb3Jxc=;
        b=KfvPlVpgfS25r0+BHMHsTI+mssMt455BJEQYmxA2tLX0ukgtsxtFurlO8NpuKvvDiB9lWZ
        QSbs/muTmycKUetEmsxmeF3H2jky11G4+XfcXw3c0zedJLQyOH1QoPqUYBWAXBYQOGNscv
        W2p89fpzB5IkuSZaPAjqSVT65rQH5d1wNeeKq4o6DdG8ieJ+dOAs5BolVsETV4mwlGhxB6
        TEgZtEt8Tait4Gl0pemq2pKNarxS0ofyHLg9AkPoenAOhn5rFCd5ji8+037RjDD6ZwiLZy
        Dz8/TPNbTGup89OIcXFNIc+na/l5ZRlHykwqfqzfaGdcIAiSeoicGPqD9B3cNQ==
Message-ID: <bd234d26-f418-4ff7-b6a2-9a81526aa61a@bootlin.com>
Date:   Tue, 17 Oct 2023 10:28:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: wilc1000: use vmm_table as array in wilc struct
To:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Kalle Valo <kvalo@kernel.org>,
        Michael Walle <mwalle@kernel.org>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Ajay Singh <ajay.kathat@microchip.com>, stable@vger.kernel.org
References: <20231016-wilc1000_tx_oops-v2-1-8d1982a29ef1@bootlin.com>
 <bb95048f-2540-4d42-abb2-3132d33cd6c3@quicinc.com>
 <74eac5f2-228b-4775-a101-53b2fdd5bf86@bootlin.com>
 <32ab8646-d41d-4dd2-a8c8-93845f198462@quicinc.com>
Content-Language: en-US
From:   =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
In-Reply-To: <32ab8646-d41d-4dd2-a8c8-93845f198462@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/23 00:51, Jeff Johnson wrote:
> On 10/16/2023 2:23 PM, Alexis Lothoré wrote:
>> Hello Jeff,
>>
>> On 10/16/23 17:26, Jeff Johnson wrote:
>>> On 10/16/2023 1:29 AM, Alexis Lothoré wrote:
>>> this is probably OK since the values are constant, but kcalloc() is generally
>>> preferred
>>
>> Ok, I can submit a new version with kcalloc. One thing that I do not understand
>> however is why checkpatch.pl remains silent on this one. I guess it should raise
>> the ALLOC_WITH_MULTIPLY warning here. I tried to dive into the script to
>> understand why, but I drowned in regexes (and Perl, with which I am not familiar
>> with). Could it be because of both sides being constant ?
> 
> I also drown when looking at checkpatch.pl -- so many "write-only" regexes! But
> I think the following is what excludes your patch:
> $r1 =~ /^[A-Z_][A-Z0-9_]*$
> 
> It is a compile-time constant so the compiler can flag on overflow, so it's your
> call to modify or not.

Thanks for taking a look. I have tried to tweak those lines to see if it makes
checkpatch raise the warning, without success.

Anyway, I agree with your initial statement, let's keep the code base
homogeneous and replace kzalloc with kcalloc

> /jeff

-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

