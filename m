Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABA337B3269
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 14:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233303AbjI2MWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 08:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233227AbjI2MWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 08:22:42 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5210510CC;
        Fri, 29 Sep 2023 05:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1695990137; x=1696594937; i=linosanfilippo@gmx.de;
 bh=xXPMCQlQMHAN7z2B8m8BZwNfXtx90kosemQzOpKXnko=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=cs4A75BpuZ7QCe11ccx/6XRbwZTfmxs/E/86ivB+7O6fvWndwZwZHI5vPiPQxTinH+eMQv3rtEA
 sItE21wioFA6iKLGYRF/FNNcPeNs6nKr7h+eiZYKbn6N74mPTFmrOEF54UXCCm8sNnQ73QvUTypao
 Kch4mJg18QavUotfhbzb0QJDMqLm4U7JoCIIfllHZt0GYWmtVLFAXTxrA8G13NSBvQLb4yuVZGFpw
 hOIV7L4bCywApJwVZkf5xcHUjTG+zaGEwnvSqTBYezKmAjFyer/E/vD9qXBmHj0r7P60SUT3+cxZU
 LVQxURb6SsUlV0SGYpn24IVSqaAoZDc/l1yQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.2.42] ([84.162.21.41]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MaJ7v-1r7MNg0biv-00WEdQ; Fri, 29
 Sep 2023 14:22:17 +0200
Message-ID: <7ba24ee0-8e86-e8ed-3d54-0bc627b3d0f1@gmx.de>
Date:   Fri, 29 Sep 2023 14:22:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 6/6] serial: imx: do not set RS485 enabled if it is not
 supported
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     jirislaby@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        ilpo.jarvinen@linux.intel.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, l.sanfilippo@kunbus.com,
        lukas@wunner.de, p.rosenberger@kunbus.com
References: <20230928221246.13689-1-LinoSanfilippo@gmx.de>
 <20230928221246.13689-7-LinoSanfilippo@gmx.de>
 <2023092948-canteen-pushy-7f54@gregkh>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
In-Reply-To: <2023092948-canteen-pushy-7f54@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CqKy0l2F8rtf/u9MwFRpOZI8ZeFpKu7wuqN0TsJffBcSurCL6kb
 e1SRVIDNzV5uN8ZsP5cOcxlpq3o3ylmxYOf4F2agJtv+0vrO1PFGl1DWRTs1LwV3CHrxOLU
 AXwDsdPLtT1SF6UlKGok+XFSE/KmIRkDQ8kx2UITSbU6EVdC9G2IH05Jw78ewql9ngJGfXE
 r8FgCZ5TN+/S/thS/uXWQ==
UI-OutboundReport: notjunk:1;M01:P0:8ynMcPUexjA=;y22yA5M1G9ntv/LRJ7G5piXoPsz
 LGpTaWrpD0VT/BBO2wYIAhjDxQmWccB6yNBztwMsNk+F3bvA7waUMNAMPRHhd7Z6q1L2u09la
 fW/Fj6QnJszld4QdKwnA5k1p03Zjd5WsUauYvOCBfnVeJ2JIOnUfxuBSPTYPzhtZDrpfPF6Jd
 uRT+PtSOeHWM3tTebnww9QOEXnqcnF/qLzpU1bs7QdR4bvcyQlVKdxyMk0KwjunB6kScC4aog
 RmMv3bxD25i1GRw3LwjU3M/Fx086UmkHJ0cd6rpOWwKAEfZS10zH/52+teXOjHumKmnJAKmg+
 q/vx3yLVSlvDBex0rUFaN7hqIVceoIEgL5xLlDNYjIcfrGoEIaKfTrWQDfAbzC2s7uAFx9y2Z
 6PchrPMZ2Gscp00cb4nJ7BxIA83KiMGD1lq1Ry7dThEyNeDr5zzEbU8JBHzkXn3PYjWyGw5FT
 APSLvuWNvsVyLdIvzKhGodfG5gHg0GJ5xxAJHCbmGoyp+WhU0zYFid9pVaTpL2gLYfsx3VbtL
 WRvt3/yw/E4KMVGryBS+tajmS2gzwrYbsog7G00Mqo5Rd3iRBUIEbFWoItz5iGIEpYKGx3u9/
 pct47YSu2fe5eQHxTj5l45Pdjb+w6RK+3gSFlb+PoIG61609ey3QNbiyLhqeB5ZO6lAe9TVft
 x5iRqJ1QJrP7ykFhle36UaVkAXPge7VF8/NQoxPRbOPBxzdrGjS1ogaSH03QE0CdO7sWJj2Gj
 aH5ZlWX4/dt0AAl5jgi1bK69yhPiSYQA+llyQmI+Qnso+5W4wiuz9frTj8IBV678lPA2MX0dF
 YJ8K0wWzEBc6Ak3FdsmACt9UIXtpq5DxUqOn4oOWATNjxMlENhi5bZMITnvi44Fm/VE+Kzz72
 uMwtbDqhcvFNseuzdJgJJa8uwPESknIVoZ8jdKjuQ3WGjwHOADNwicNLYmjukvtLcnfN2dEee
 bbzqeX+IUd7f4IqltUHCdFoZil8=
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29.09.23 07:51, Greg KH wrote:
> On Fri, Sep 29, 2023 at 12:12:46AM +0200, Lino Sanfilippo wrote:
>> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
>>
>> If the imx driver cannot support RS485 it sets the UARTS rs485_supporte=
d
>> structure to NULL. But it still calls uart_get_rs485_mode() which may s=
et
>> the RS485_ENABLED flag.
>> The flag however is evaluated by the serial core in uart_configure_port=
()
>> at port startup and thus may lead to an attempt to configure RS485 even=
 if
>> it is not supported.
>>
>> Avoid this by calling uart_get_rs485_mode() only if RS485 is actually
>> supported by the driver. Remove also a check for an error condition
>> that is not possible any more now.
>>
>> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
>> ---
>>  drivers/tty/serial/imx.c | 14 ++++++--------
>>  1 file changed, 6 insertions(+), 8 deletions(-)
>
> Why is this patch not marked for stable?
>

Right, it should be, I will correct this, thanks!
