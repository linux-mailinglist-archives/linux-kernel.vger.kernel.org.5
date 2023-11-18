Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93E017F0044
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 16:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjKRPPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 10:15:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjKRPPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 10:15:12 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D601BD5;
        Sat, 18 Nov 2023 07:15:08 -0800 (PST)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1r4N2J-0003pM-Ac; Sat, 18 Nov 2023 16:15:07 +0100
Message-ID: <f4439fd1-7c2d-4a96-9116-1dbe04fceac0@leemhuis.info>
Date:   Sat, 18 Nov 2023 16:15:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: spi: imx: Increase imx51 ecspi burst length fails on imx6dl and
 imx8mm
Content-Language: en-US, de-DE
From:   Thorsten Leemhuis <regressions@leemhuis.info>
To:     Stefan Moring <stefan.moring@technolution.nl>
Cc:     Linux kernel regressions list <regressions@lists.linux.dev>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@bigler.io, Mark Brown <broonie@kernel.org>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
References: <8a415902c751cdbb4b20ce76569216ed@mail.infomaniak.com>
 <e4f12422-1c47-4877-88b3-dfa9917331a2@leemhuis.info>
In-Reply-To: <e4f12422-1c47-4877-88b3-dfa9917331a2@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1700320509;be0fda14;
X-HE-SMSGID: 1r4N2J-0003pM-Ac
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.11.23 16:13, Linux regression tracking (Thorsten Leemhuis) wrote:
> [CCing people that worked on the relevant commits as well as the
> regression list, as it should be in the loop for regressions:
> https://docs.kernel.org/admin-guide/reporting-regressions.html]

Sorry for the spam, hit "send" before actually adding Stefan and Mark,
which now are among the recipients.

> On 18.11.23 15:25, linux@bigler.io wrote:
>> After upgrade from kernel 6.5.11 to 6.6.1 the spi-devices on my hw 
>> colibri-imx6dl and verdin-imx8mm are not working anymore (TPM2 and SPI-SRAM).
>>
>> Analyzing the problem showed that the 2 commits introduced the problem:
>>
>> spi: Increase imx51 ecspi burst length based on transfer length
>> 15a6af94a2779d5dfb42ee4bfac858ea8e964a3f
>>
>> spi: imx: Take in account bits per word instead of assuming 8-bits
>> 5f66db08cbd3ca471c66bacb0282902c79db9274
>>
>> Reverting the commits solved the problem.
>>
>> The analyse with the logic-analyser showed a wrong number of transmitted  
>> bytes and wrong data.
>> When I try to send 127 Byte with a incrementing pattern (0x01,0x02,0x03,..),
>> 504 Bytes are sent (0x00,0x00,0x01 0x00,0x00,0x00,0x02, 0x00,0x00,0x00,0x03).
>> We tested with different sizes and patterns, all are not ok.
>> While analysing the configuration and code I was not able to see any obvious
>> mistake.
>>
>> Has someone else discovered such misbehaviour or has any idea what is wrong?
>> Best Regards
> 
> Thx for the report!
> 
> [TLDR: I'm adding this report to the list of tracked Linux kernel
> regressions; the text you find below is based on a few templates
> paragraphs you might have encountered already in similar form.
> See link in footer if these mails annoy you.]
> 
> To ensure the issue doesn't fall through the cracks unnoticed, I'm
> adding it to regzbot, the Linux kernel regression tracking bot:
> 
> #regzbot ^introduced 15a6af94a27
> #regzbot title spi: spi-devices on colibri-imx6dl and verdin-imx8mm are
> not working anymore
> #regzbot ignore-activity
> 
> This isn't a regression? This issue or a fix for it are already
> discussed somewhere else? It was fixed already? You want to clarify when
> the regression started to happen? Or point out I got the title or
> something else totally wrong? Then just reply and tell me -- ideally
> while also telling regzbot about it, as explained by the page listed in
> the footer of this mail.
> 
> Developers: When fixing the issue, remember to add 'Link:' tags pointing
> to the report (the parent of this mail). See page linked in footer for
> details.
> 
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> That page also explains what to do if mails like this annoy you.
