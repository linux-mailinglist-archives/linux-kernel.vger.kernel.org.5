Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3938C792BE7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346845AbjIERDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 13:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343691AbjIECrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 22:47:12 -0400
Received: from out28-5.mail.aliyun.com (out28-5.mail.aliyun.com [115.124.28.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC289CC7
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 19:47:07 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1763104|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0237881-0.00029532-0.975917;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047190;MF=wangweidong.a@awinic.com;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.UXjJ.KH_1693882020;
Received: from ubuntu-VirtualBox..(mailfrom:wangweidong.a@awinic.com fp:SMTPD_---.UXjJ.KH_1693882020)
          by smtp.aliyun-inc.com;
          Tue, 05 Sep 2023 10:47:03 +0800
From:   wangweidong.a@awinic.com
To:     krzysztof.kozlowski@linaro.org
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org, perex@perex.cz,
        tiwai@suse.com, wangweidong.a@awinic.com, yijiangtao@awinic.com
Subject: Re: [PATCH 3/3] ASoC: aw88395: drop undocumented and unused sound-channel property
Date:   Tue,  5 Sep 2023 10:46:59 +0800
Message-ID: <20230905024659.15071-1-wangweidong.a@awinic.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230904125309.43350-3-krzysztof.kozlowski@linaro.org>
References: <20230904125309.43350-3-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you very much for the proposed patch, but I have some 
questions that I would like to discuss with you

On Mon, Sep 04, 2023 at 12:53 PM +0200, Krzysztof Kozlowski wrote:
> The Devicetree sound-channel property was never accepted and is not
> allowed by bindings.  It is not used by any upstream user, thus
> considering that it was never documented, should be dropped.

This node property is intended for use with multiple PA, to
load different configurations for different PA.
Can I add this sound-channel in the "awinic,aw88395.yaml" file?

> Even though it does not look like from the diff, the property is not
> actually used by the driver, because once set, it is read only in loops
> depending on ddt_num (prof_hdr->ddt_num, cfg_hdr->ddt_num).  The
> variable ddt_num is never set and is always 0, so the loops do not have
> any iteration.  Dropping sound-channel and ddt_num-related loops allows
> to drop empty functions which in turn drop quite a lot of code.  This
> entire code was not possible to execute. 

The ddt_num variable is not always 0, this variable is defined
in the configuration file. The "prof_hdr" variable is assigned by 
the "cfg_hdr" variable. The "cfg_hdr" variable is assigned by "aw_cfg"
aw_cfg is the data obtained through request_firmware.The specific 
process is as follows:

request_firmware ---> cont->data ---> aw_cfg->data --> cfg_hdr --> prof_hdr


> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

> Not tested on hardware... but feature removed here could not work
> according if conforming to documented interface.
---
>  sound/soc/codecs/aw88261.c                   |  13 -
>  sound/soc/codecs/aw88395/aw88395_data_type.h |   1 -
>  sound/soc/codecs/aw88395/aw88395_device.c    |  21 -
>  sound/soc/codecs/aw88395/aw88395_device.h    |   1 -
>  sound/soc/codecs/aw88395/aw88395_lib.c       | 788 -------------------
>  5 files changed, 824 deletions(-)

> diff --git a/sound/soc/codecs/aw88261.c b/sound/soc/codecs/aw88261.c
> index a5de7c704e73..e0527ce2f83e 100644
> --- a/sound/soc/codecs/aw88261.c
> +++ b/sound/soc/codecs/aw88261.c
> @@ -1171,17 +1171,6 @@ static void aw88261_hw_reset(struct aw88261 *aw88261)
>  	usleep_range(AW88261_1000_US, AW88261_1000_US + 10);
>  }

...

Best Regards,
Weidong Wang
