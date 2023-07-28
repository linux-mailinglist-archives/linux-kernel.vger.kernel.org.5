Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 620F076621D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 04:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232741AbjG1CxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 22:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232682AbjG1CxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 22:53:03 -0400
Received: from mail-m12739.qiye.163.com (mail-m12739.qiye.163.com [115.236.127.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22CD41738;
        Thu, 27 Jul 2023 19:53:00 -0700 (PDT)
Received: from [172.16.12.49] (unknown [58.22.7.114])
        by mail-m12739.qiye.163.com (Hmail) with ESMTPA id 0C91D4A019F;
        Fri, 28 Jul 2023 10:52:49 +0800 (CST)
Message-ID: <0ba154fe-5104-845c-a348-cebd4ee31716@rock-chips.com>
Date:   Fri, 28 Jul 2023 10:52:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCHv2 1/2] clk: rockchip: rk3588: make gate linked clocks
 ignore unused
To:     Jagan Teki <jagan@edgeble.ai>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org,
        Peter Geis <pgwipeout@gmail.com>,
        Finley Xiao <finley.xiao@rock-chips.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Vincent Legoll <vincent.legoll@gmail.com>
References: <20230403193250.108693-1-sebastian.reichel@collabora.com>
 <20230403193250.108693-2-sebastian.reichel@collabora.com>
 <CA+VMnFz4USPcXmQMyUB9n5EVmvQrJARDvnpO7iBrXZ8q2xcyAA@mail.gmail.com>
 <20230713193812.px7q4sdfdppuywsg@mercury.elektranox.org>
 <CA+VMnFwjFx5+h9=KGR-1o0ejSaxbE=-5wH3iqEEkn6k4q_he7Q@mail.gmail.com>
From:   zhangqing <zhangqing@rock-chips.com>
In-Reply-To: <CA+VMnFwjFx5+h9=KGR-1o0ejSaxbE=-5wH3iqEEkn6k4q_he7Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGR1OHVYYTRlLSEoYH0gYT09VEwETFh
        oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk5DTUtIVUpLS1VKQl
        kG
X-HM-Tid: 0a899a69c1aab212kuuu0c91d4a019f
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OhQ6Mio4CD1KCjgcSFEwFh40
        GjFPCw5VSlVKTUJLTkpJTExLSUpLVTMWGhIXVQETGhUcChIVHDsJFBgQVhgTEgsIVRgUFkVZV1kS
        C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUxISE83Bg++
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/7/14 13:33, Jagan Teki 写道:
> Hi Sebastian,
>
> On Fri, 14 Jul 2023 at 01:08, Sebastian Reichel
> <sebastian.reichel@collabora.com> wrote:
>> Hello Jagan,
>>
>> On Thu, Jul 13, 2023 at 08:25:03PM +0530, Jagan Teki wrote:
>>> On Tue, 4 Apr 2023 at 01:03, Sebastian Reichel
>>> <sebastian.reichel@collabora.com> wrote:
>>> [...]
>>>> + * Recent Rockchip SoCs have a new hardware block called Native Interface
>>>> + * Unit (NIU), which gates clocks to devices behind them. These effectively
>>>> + * need two parent clocks.
>>>> + *
>>>> + * Downstream enables the linked clock via runtime PM whenever the gate is
>>>> + * enabled. This implementation uses separate clock nodes for each of the
>>>> + * linked gate clocks, which leaks parts of the clock tree into DT.
>>>> + *
>>>> + * The GATE_LINK macro instead takes the second parent via 'linkname', but
>>>> + * ignores the information. Once the clock framework is ready to handle it, the
>>>> + * information should be passed on here. But since these clocks are required to
>>>> + * access multiple relevant IP blocks, such as PCIe or USB, we mark all linked
>>>> + * clocks critical until a better solution is available. This will waste some
>>>> + * power, but avoids leaking implementation details into DT or hanging the
>>>> + * system.
>>>>    */
>>> Does it mean the clk-link topology in the downstream kernel can be
>>> reused the same as normal clock notation?
>> Yes.
>>
>>> For example, I'm trying to add HCLK_VO1 directly to VO1 syscon instead
>>> of routing to pclk_vo1_grf(done downstream)
>>>        vo1_grf: syscon@fd5a8000 {
>>>                 compatible = "rockchip,rk3588-vo-grf", "syscon";
>>>                 reg = <0x0 0xfd5a8000 0x0 0x100>;
>>>               clocks = <&cru HCLK_VO1>;
>> You need PCLK_VO1 (which is currently not exposed; I somehow missed
>> it).
Maybe this submission is helpful

The true GATE_LINK callback is implemented.

https://patchwork.kernel.org/project/linux-clk/patch/20230728020810.29732-4-zhangqing@rock-chips.com/

  vo1_grf: syscon@fd5a8000 {
                compatible = "rockchip,rk3588-vo-grf", "syscon";
                reg = <0x0 0xfd5a8000 0x0 0x100>;
              clocks = <&cru PCLK_VO1GRF>;

When enable pclk_vo1grf,will enable pclk_vo1_root and hclk_vo1.

>>>        };
>>>
>>> This seems breaking syscon for vo1_grf and observed a bus error
>>> while accessing regmap.
>> I investigated the issue you are seeing some weeks ago when my
>> co-workers started to work on HDMI RX and TX. You are probably
>> just missing this patch:
>>
>> https://gitlab.collabora.com/hardware-enablement/rockchip-3588/linux/-/commit/ecc6415344957fa88356cec10f8b75a9da603a7b
> In fact, I tried this solution as well, by connecting the PCLK_VO1GRF.
>
>          vo1_grf: syscon@fd5a8000 {
>                  compatible = "rockchip,rk3588-vo-grf", "syscon";
>                  reg = <0x0 0xfd5a8000 0x0 0x100>;
>                  clocks = <&cru PCLK_VO1GRF>;
>          };
>
> But the result seems the same, accessing vo1_grf triggers an abort [1]
>
> [1] https://gist.github.com/openedev/e241da8180341ffbf4dc6a26de7efa31
>
> Thanks,
> Jagan.

-- 
张晴
瑞芯微电子股份有限公司
Rockchip Electronics Co.,Ltd
地址：福建省福州市铜盘路软件大道89号软件园A区21号楼
Add:No.21 Building, A District, No.89 Software Boulevard Fuzhou, Fujian 350003, P.R.China
Tel:+86-0591-83991906-8601
邮编：350003
E-mail:elaine.zhang@rock-chips.com
****************************************************************************
保密提示：本邮件及其附件含有机密信息，仅发送给本邮件所指特定收件人。若非该特定收件人，请勿复制、使用或披露本邮件的任何内容。若误收本邮件，请从系统中永久性删除本邮件及所有附件，并以回复邮件或其他方式即刻告知发件人。福州瑞芯微电子有限公司拥有本邮件信息的著作权及解释权，禁止任何未经授权许可的侵权行为。

IMPORTANT NOTICE: This email is from Fuzhou Rockchip Electronics Co., Ltd .The contents of this email and any attachments may contain information that is privileged, confidential and/or exempt from disclosure under applicable law and relevant NDA. If you are not the intended recipient, you are hereby notified that any disclosure, copying, distribution, or use of the information is STRICTLY PROHIBITED. Please immediately contact the sender as soon as possible and destroy the material in its entirety in any format. Thank you.

****************************************************************************

