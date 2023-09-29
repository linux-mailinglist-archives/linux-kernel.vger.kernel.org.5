Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF1CE7B3276
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 14:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233136AbjI2MZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 08:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232834AbjI2MZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 08:25:33 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11556BE;
        Fri, 29 Sep 2023 05:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1695990303; x=1696595103; i=linosanfilippo@gmx.de;
 bh=TenpcTfOohBab9z9eVMlTxbvlVMgx1dJkTKbPhjwukk=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=WuIVEcPk5a1WvpY9W2Y8nqujqULZ6iEZ5jOY/6EQUVCdiHF/raRelwH5F2tXcj8Yo4+4ozgpN1s
 xOZqSd8/WhY4Oq9HXxL6kBkOcPeKs77tfCUD/POxZo1LaYFG+7s8BNcsN44Ckc53Pb0FQZ/PZ2GfF
 tPg32tNJhfAGXoo+dnEklFOKZLgfC1DYHrUCs24p+ZO241r8wsXg/1WhUJDlPSr6V7zrGWcZOHa7p
 MOySmRJKFZnvyqcmsObooEbCTTW2R5pFV+9SMELhrOrzprYeG6oA0sy/GkILf7StaLWh+Nd3NgyCU
 d6aiWNOtDKgZk/dG+YXQKpi3VToqXZ5A9wPA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.2.42] ([84.162.21.41]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MmDIo-1rU61e3t7g-00iEo2; Fri, 29
 Sep 2023 14:25:03 +0200
Message-ID: <f02ec46b-e5b4-9dc5-438b-a30e78fc75a2@gmx.de>
Date:   Fri, 29 Sep 2023 14:25:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 5/6] serial: core: make sure RS485 is cannot be enabled
 when it is not supported
Content-Language: en-US
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de,
        ilpo.jarvinen@linux.intel.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, l.sanfilippo@kunbus.com,
        lukas@wunner.de, p.rosenberger@kunbus.com, stable@vger.kernel.org
References: <20230928221246.13689-1-LinoSanfilippo@gmx.de>
 <20230928221246.13689-6-LinoSanfilippo@gmx.de>
 <20230929081712.7824dca40828ff873b3352ff@hugovil.com>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
In-Reply-To: <20230929081712.7824dca40828ff873b3352ff@hugovil.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:84dlL3fttkr2NESD1TPWrzphRjfJQepQN6MMFoeHnH0oHQrxWYi
 j3/FagZ21ujnSqzGbiF9iJYj/JDfGXFxgymKIr9E3Rs+kcDPwrvmrHuFLx8IDr3ygc+qvCB
 d5d1LrcdbS3CLzl+mnrf6+kWkHwA6HaeFpFZsxiydgHdl/o+053kEankiZgZ8rqZGkUPwFH
 U8o0n3+2Sj0G4ZED/PbhQ==
UI-OutboundReport: notjunk:1;M01:P0:0dBSFCuOJAU=;55FRe+lvo4AdB3hLG4D/9ePWkT+
 xssTCNduB8w+KSUrYtDRqCfLJjlHik0OLQDl2BPLxV1UnA/pSUL1kccfplyjNJ9NiIU6kxKWw
 JWgNX6q9F4fTv51BWzp1kubnoDm5sQQSYivUsFTtZ8g+7o43JCSxQCy29EbKlUXSOFlp0qCmO
 scDf/iR2AGHK9Lrqf6CGYFnr7ES0PZvcaaw1vysPgzQkXIdBj5HjFCz24PpyjOoiBnR2tX2K1
 r8BlMkaKddFsJeAdyFHK0G6+aeqwCZub9J8xwcUtmQWADDcBtWUJhh7gL2+UNinfunOGCgtDB
 bzsa1yw4Izadu42FVViv8DKhV8fr0QP7li2/bm7ocUc8n90o8kAEV2trOAlUCrOumTzpC1sil
 JeAOSxqo7wVNSmt8+muS7PBJ/5/SPeR/Bszlm5wwzZq+8M82V795XGoD37RXOTC38JCFNFt4M
 87qnlKVw6c/dlGHiQdoI904LKp5D9mFCbttOnWthMH25yhwQd6qOXHylyc5oUd53xG+uJKED+
 8qR3yIi0ZSwonJG01JYpNyWoIto1O8OX5kkA4u3SxKxfC8NQDgwT/bPuFLyFafrtOxKktKMs5
 0ivCzO1AGpb6Tc4PLQSHHsyJQFlM2FDEMx2wFDeRuwcS6IUkPNxuVpl7Qs8PlcId+ZH5puUu2
 T9gnFL5ydyZv0qGKVxs+wBYFChb7jr+ZgvIAxe5FiJYIlTI9npORnznixe7vjt/OIFn/FVqyr
 ryXeJ0sVFLeFB094dQ9doTiPp0fQrbVFKs4GvpOPHrCVFN1r2xVpjVk6+X1CAIJzOM0HepM4m
 Z/1O06MQmjJ2uQh9t4eIjuQQgId1Ax9pmtYVbXfgy5SPM1Vdi6OBh/noY82Rx8DdmZ2RIW/dF
 wHBneTBOI1cNQEP4gwK2WjwCuXPCDOeqTiLueWxmLwEdExg7e5e9ytNes3BLcj/P1m8xyEi22
 IhB8Jw==
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 29.09.23 14:17, Hugo Villeneuve wrote:
> Hi,
> remove superfluous "is" after RS485 in patch title.
>
> Hugo.
>

Indeed, I will fix this, thanks!

BR,
Lino


