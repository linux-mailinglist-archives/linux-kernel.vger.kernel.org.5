Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E53D7C8B1E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 18:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232433AbjJMQWK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 13 Oct 2023 12:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbjJMQVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 12:21:51 -0400
Received: from postfix2.imaqliq.com (postfix2.imaqliq.com [93.189.151.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452992691;
        Fri, 13 Oct 2023 09:20:59 -0700 (PDT)
Received: from verse.imaqliq.com (verse.imaqliq.com [93.189.151.95])
        by postfix2.imaqliq.com (Postfix) with ESMTP id 783C61C2B9C;
        Fri, 13 Oct 2023 19:20:56 +0300 (MSK)
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
In-Reply-To: <5765a10c-8f75-4bf4-830b-b5fba501d164@linaro.org>
References: <5765a10c-8f75-4bf4-830b-b5fba501d164@linaro.org>,
        <OF55521400.7512350F-ON00258A47.003F7254-00258A47.0040E15C@gdc.ru> <20231013141818.adq6eujrx2wueobp@CAB-WSD-L081021>
Subject: Re: [PATCH v4] tty: serial: meson: fix hard LOCKUP on crtscts mode
From:   Pavel Krasavin <pkrasavin@imaqliq.com>
To:     neil.armstrong@linaro.org
Cc:     "Dmitry Rokosov" <ddrokosov@salutedevices.com>,
        Pavel Krasavin <pkrasavin@imaqliq.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Jiri Slaby" <jirislaby@kernel.org>,
        "Kevin Hilman" <khilman@baylibre.com>,
        "Jerome Brunet" <jbrunet@baylibre.com>,
        "Martin Blumenstingl" <martin.blumenstingl@googlemail.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Date:   Fri, 13 Oct 2023 16:20:50 +0000
Message-ID: <OFCBF5B209.BF3CBB33-ON00258A47.0059CADD-00258A47.0059CC5B@gdc.ru>
X-Mailer: Lotus Domino Web Server Release 12.0.2 November 03, 2022
X-MIMETrack: Serialize by http on verse/com(Release 12.0.2|November 03, 2022) at 10/13/2023
 16:20:50,
        Serialize complete at 10/13/2023 16:20:50,
        Serialize by Router on verse/com(Release 12.0.2|November 03, 2022) at 10/13/2023
 16:20:55
X-KeepSent: CBF5B209:BF3CBB33-00258A47:0059CADD;
 type=4; name=$KeepSent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-KLMS-Rule-ID: 1
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Lua-Profiles: 180614 [Oct 13 2023]
X-KLMS-AntiSpam-Version: 6.0.0.2
X-KLMS-AntiSpam-Envelope-From: pkrasavin@imaqliq.com
X-KLMS-AntiSpam-Rate: 10
X-KLMS-AntiSpam-Status: not_detected
X-KLMS-AntiSpam-Method: none
X-KLMS-AntiSpam-Auth: dmarc=fail header.from=imaqliq.com policy=none;spf=softfail smtp.mailfrom=imaqliq.com;dkim=none
X-KLMS-AntiSpam-Info: LuaCore: 539 539 807534d9021bfe9ca369c363d15ac993cd93d4d9, {rep_avail}, {Tracking_arrow_text}, {Tracking_from_domain_doesnt_match_to}, verse.imaqliq.com:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;gdc.ru:7.1.1;93.189.151.95:7.1.2;imaqliq.com:7.1.1, FromAlignment: s, {Tracking_dmark_f}, ApMailHostAddress: 93.189.151.95
X-MS-Exchange-Organization-SCL: -1
X-KLMS-AntiSpam-Interceptor-Info: scan successful
X-KLMS-AntiPhishing: Clean, bases: 2023/10/13 15:28:00
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, bases: 2023/10/13 14:32:00 #22183459
X-KLMS-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry, Neil,

----- "Neil Armstrong" <neil.armstrong@linaro.org> писал(а): -----
>> On 13/10/2023 16:18, Dmitry Rokosov wrote:
>> I believe it would be necessary to include a 'Fixes' tag for that. Neil,
>> what do you think?
>> Since a HARDLOCKUP is an undesirable situation, I don't think we want to
>> have it in the LTS kernels either.

> Yes, and please keep the previous Reviewed-by Dmitry and I added on v3 and send a v5 with the Fixes added.
Sorry for this.

> It should be:
> Fixes: ff7693d079e5 ("ARM: meson: serial: add MesonX SoC on-chip uart driver")
Got it.

> Hopefully it will be the last iteration.
I'll do my best. Thank you for your work on this patch.

Regards,
Pavel.
