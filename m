Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04184758BE2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 05:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbjGSDMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 23:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbjGSDMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 23:12:50 -0400
Received: from out28-121.mail.aliyun.com (out28-121.mail.aliyun.com [115.124.28.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234A1EC;
        Tue, 18 Jul 2023 20:12:48 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07720535|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00838821-0.000344401-0.991267;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047208;MF=wangweidong.a@awinic.com;NM=1;PH=DS;RN=26;RT=26;SR=0;TI=SMTPD_---.Tx4TxI5_1689736357;
Received: from ubuntu-VirtualBox..(mailfrom:wangweidong.a@awinic.com fp:SMTPD_---.Tx4TxI5_1689736357)
          by smtp.aliyun-inc.com;
          Wed, 19 Jul 2023 11:12:40 +0800
From:   wangweidong.a@awinic.com
To:     krzysztof.kozlowski@linaro.org
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        ckeepax@opensource.cirrus.com, colin.i.king@gmail.com,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        doug@schmorgal.com, fido_max@inbox.ru, flatmax@flatmax.com,
        herve.codina@bootlin.com, kiseok.jo@irondevice.com,
        krzysztof.kozlowski+dt@linaro.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, liweilei@awinic.com, perex@perex.cz,
        pierre-louis.bossart@linux.intel.com, rf@opensource.cirrus.com,
        robh+dt@kernel.org, shumingf@realtek.com, tiwai@suse.com,
        trix@redhat.com, wangweidong.a@awinic.com, yijiangtao@awinic.com,
        zhangjianming@awinic.com
Subject: Re: [PATCH V1 3/5] ASoC: codecs: ACF bin parsing and check library file for aw88261
Date:   Wed, 19 Jul 2023 11:12:37 +0800
Message-ID: <20230719031237.41530-1-wangweidong.a@awinic.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <98292541-8435-53cb-22d9-716ed6541485@linaro.org>
References: <98292541-8435-53cb-22d9-716ed6541485@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Krzysztof,
Thank you very much for your advice, 
 but I have a few questions I'd like to discuss with you

On 18/07/2023 16:41, krzysztof.kozlowski@linaro.org wrote:
> On 17/07/2023 13:58, wangweidong.a@awinic.com wrote:
>> From: Weidong Wang <wangweidong.a@awinic.com>
>> 
>> The AW88261 is an I2S/TDM input, high efficiency
>> digital Smart K audio amplifier with an integrated 10.25V
>> smart boost convert

> So all your commits are doing the same?

I will modify the commit information and differentiate the commit 
 information for each file

>> 
>> Signed-off-by: Weidong Wang <wangweidong.a@awinic.com>
>> ---
>>  sound/soc/codecs/aw88261/aw88261_lib.c | 997 +++++++++++++++++++++++++
>>  sound/soc/codecs/aw88261/aw88261_lib.h |  91 +++
>>  2 files changed, 1088 insertions(+)
>>  create mode 100644 sound/soc/codecs/aw88261/aw88261_lib.c
>>  create mode 100644 sound/soc/codecs/aw88261/aw88261_lib.h
>> 
>> diff --git a/sound/soc/codecs/aw88261/aw88261_lib.c b/sound/soc/codecs/aw88261/aw88261_lib.c
>> new file mode 100644
>> index 000000000000..b8f00708dacf
>> --- /dev/null
>> +++ b/sound/soc/codecs/aw88261/aw88261_lib.c
>> @@ -0,0 +1,997 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +//
>> +// aw88261_lib.c  -- ACF bin parsing and check library file for aw88261
>> +//
>> +// Copyright (c) 2023 awinic Technology CO., LTD
>> +//
>> +// Author: Jimmy Zhang <zhangjianming@awinic.com>
>> +// Author: Weidong Wang <wangweidong.a@awinic.com>
>> +//
>> +
>> +#include <linux/crc8.h>
>> +#include <linux/i2c.h>
>> +#include "aw88261_lib.h"
>> +#include "aw88261_device.h"
>> +
>> +#define AW88261_CRC8_POLYNOMIAL 0x8C
>> +DECLARE_CRC8_TABLE(aw_crc8_table);
>> +
>> +static char *profile_name[AW88261_PROFILE_MAX] = {

> Cannot be const char *?

I will modify it according to your suggestion

...

>> +EXPORT_SYMBOL_GPL(aw88261_dev_load_acf_check);

> Why?

This function is also called in the aw88261.c file

Best regards,
Weidong Wang
