Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56CFE8051D3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 12:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376999AbjLELQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 06:16:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376995AbjLELQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 06:16:05 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2BDA116
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 03:16:11 -0800 (PST)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1rATPF-0002Xs-96; Tue, 05 Dec 2023 12:16:01 +0100
Message-ID: <653b592b-bd6a-48f8-acca-c617c5c8c1a3@pengutronix.de>
Date:   Tue, 5 Dec 2023 12:15:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/2] arm64: boot: Support Flat Image Tree
Content-Language: en-US
To:     Doug Anderson <dianders@chromium.org>,
        Simon Glass <sjg@chromium.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Tom Rini <trini@konsulko.com>,
        lkml <linux-kernel@vger.kernel.org>,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Terrell <terrelln@fb.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Will Deacon <will@kernel.org>, linux-kbuild@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>
References: <20231129172200.430674-1-sjg@chromium.org>
 <20231129172200.430674-3-sjg@chromium.org>
 <30f32467-51ea-47de-a272-38e074f4060b@pengutronix.de>
 <CAPnjgZ25xoXsi74XYY0E8ucQiowQqPdZgUHrfVNAYWKZEYODHg@mail.gmail.com>
 <875f0dbc-1d78-4901-91b2-6ad152bcea5a@pengutronix.de>
 <CAPnjgZ0UCkm5QCx+JXe1ggSshozPnOLB6cN=UoJyMn6S4wfFkg@mail.gmail.com>
 <06281f7c-e0f2-405c-95a9-0f7e9e84a7f6@pengutronix.de>
 <CAPnjgZ2TT+0BvbjwfnGLQ3EPEXnLW6f1epiFdaBHRYaSAn5xsA@mail.gmail.com>
 <8fbc81b1-31ab-46b0-87f4-b8bd8e8e2b47@pengutronix.de>
 <CAPnjgZ1iyxk0bb56QR10N5aSphRYhLsw7Ly=z2i6rQCxP_AYPw@mail.gmail.com>
 <5e8f42f8-2b03-4033-b6d2-9b3139f081d5@pengutronix.de>
 <CAPnjgZ2RjNzqJTRZSWvuscQhs+f8CG=fDcEO=qKXNeQLP53LnQ@mail.gmail.com>
 <CAD=FV=WXQrbnjeVOLp--vmLzScvW9VLFRu+apSY4WnL9JFk-AQ@mail.gmail.com>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <CAD=FV=WXQrbnjeVOLp--vmLzScvW9VLFRu+apSY4WnL9JFk-AQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 04.12.23 18:52, Doug Anderson wrote:> On Sat, Dec 2, 2023 at 8:37 AM Simon Glass <sjg@chromium.org> wrote:
>> On Thu, 30 Nov 2023 at 19:04, Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
>>> On 30.11.23 21:30, Simon Glass wrote:
>>>> On Wed, 29 Nov 2023 at 12:54, Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
>>>>> On 29.11.23 20:44, Simon Glass wrote:
>>>> I don't have an example to hand, but this is the required mechanism of
>>>> FIT. This feature has been in place for many years and is used by
>>>> ChromeOS, at least.
>>>
>>> I see the utility of a FIT configuration with
>>>
>>>     compatible = "vendor,board-rev-a", "vendor,board-rev-b";
>>>
>>> I fail to see a utility for a configuration with
>>>
>>>     compatible = "vendor,board", "vendor,SoM", "vendor,SoC";
>>>
>>> Any configuration that ends up being booted because "vendor,SoC" was matched is
>>> most likely doomed to fail. Therefore, I would suggest that only the top level
>>> configuration is written into the FIT configurations automatically.
>>
>> Firstly, I am not an expert on this.
>>
>> Say you have a board with variants. The compatible string in U-Boot
>> may be something like:
>>
>> "google,veyron-brain-rev1", "google,veyron-brain", "google,veyron",
>> "rockchip,rk3288";
>>
>> If you then have several FIT configurations, they may be something like:
>>
>> "google,veyron-brain-rev0", "google,veyron-brain", "google,veyron",
>> "rockchip,rk3288";
>> "google,veyron-brain-rev1", "google,veyron-brain", "google,veyron",
>> "rockchip,rk3288";
>> "google,veyron-brain-rev2", "google,veyron-brain", "google,veyron",
>> "rockchip,rk3288";
>>
>> You want to choose the second one, since it is a better match than the others.

Now imagine, you are building a kernel that has no DT support for the Veyron,
but instead has support for the Phytec RK3288 PCM-947:

  phytec,rk3288-pcm-947", "phytec,rk3288-phycore-som", "rockchip,rk3288

As far as I understand U-Boot code, A veyron U-Boot would boot the Phytec DT
if CONFIG_FIT_BEST_MATCH is set, although it's a bad match and a boot failure
should rather have occurred.

>> +Doug Anderson who knows a lot more about this than me.
> 
> Hopefully this is all explained by:
> 
> https://docs.kernel.org/arch/arm/google/chromebook-boot-flow.html

Thanks Doug, this was helpful. The missing information to me was that
depthcharge only compares the top-level board compatible in addition
to runtime generated board compatibles, unlike what U-Boot seems to do.

barebox only compares its top-level compatible against the FIT configuration
compatibles, so adding a full compatible list to the configuration nodes as done
by this series should be ok there as well. I think U-Boot could run into
issues though as described above.

Out of curiosity: I only heard about Depthcharge before as exploitation toolkit
for U-Boot. Can you point me at some documentation on what the Depthcharge bootloader
does what U-Boot (which was presumably used before?) doesn't?

Thanks,
Ahmad

> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

