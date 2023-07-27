Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 171B0764543
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 07:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbjG0FGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 01:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbjG0FGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 01:06:51 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F59C2719
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 22:06:48 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fc0aecf15bso5845815e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 22:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690434407; x=1691039207;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=milfg91uG9nlhd9aFLAx/8EHBpoWNiimDW9/5MxR5qE=;
        b=SqR9wDcJ/K9nwJZJepovao+MkVJ0TdNofeVh2YnRg6VO5GiudH5oFn9h/1FfQVVRvE
         8ZlNCHSEvsdhsZZLJ/5/Qf6CQU21Up1ossb+IZGHnWbf3PBHoWsebzYMi7f6OFiplMtg
         vxOHMSqN7wXgOitTUOvdlJvqxngxskbpjADUWJ5O9YwOwTDGd5d65DZWQXSIRGR3uIvh
         eJFw4HlIr+gmRESJdtIIdDKmvInlWwYviZwGGR/2npA+DAy/Vx2D9df3Cyh2YOuxOaUw
         UrJW3ILC8IxAsiSNhTUwdSZjzW5ONxcy9Uev32d5oWZE0JPFcth5s74HwccZfDhaNYbq
         PLug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690434407; x=1691039207;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=milfg91uG9nlhd9aFLAx/8EHBpoWNiimDW9/5MxR5qE=;
        b=UmkDTZmc3x3cZnbi1GvxvemC19XvWcWg1YFrboGUcMOD6mbqIDzbGIxQiOo2xi0DNr
         N2+M1ICZyewDBO7saMFwM1NwdGFfWvGFT0VVsC4FFwdRdX4F+iJ/0qT0CuYYgyX3Nhjm
         d7FZRUEd9JpGWvHMZmbNKVJPvDxlVOPeYVdwb61y5Ls3f4NHYSzB8drlK2KU7LqOC7Km
         C1ogLc0AWqB6lM1ZauwC3rxBFCEHBqIynYoosrJT5UqfMPnIjwy70BIMvlwn5iMK+YSt
         v9gqHwLThh36NZXICjnNOLmf2jJ6fUF4gTE5V8cEMY3VZ+8z/2WODImxmeqgZZyuDS5F
         66tQ==
X-Gm-Message-State: ABy/qLbObMPTF3/JuRG8cWeii3YsCHddNIebyVz4lkuEGbsOWswah2dC
        zQgj6i+BaVD67L35dlTIBIQ5OA==
X-Google-Smtp-Source: APBJJlG46aaIJPrxFkx4O+Yb8zxZMWWUWxRjBLDV7QlqtwQ/xfDUhdChhPo0mRSZ0sY0wDCljBBp8w==
X-Received: by 2002:adf:f4c6:0:b0:314:ca7:f30b with SMTP id h6-20020adff4c6000000b003140ca7f30bmr767822wrp.54.1690434407115;
        Wed, 26 Jul 2023 22:06:47 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id n7-20020a5d6b87000000b003175fef2a32sm820827wrx.55.2023.07.26.22.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 22:06:46 -0700 (PDT)
Date:   Thu, 27 Jul 2023 08:06:44 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     oe-kbuild@lists.linux.dev,
        Anjelique Melendez <quic_amelende@quicinc.com>, pavel@ucw.cz,
        lee@kernel.org, thierry.reding@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        agross@kernel.org, andersson@kernel.org
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        luca.weiss@fairphone.com, konrad.dybcio@linaro.org,
        u.kleine-koenig@pengutronix.de, quic_subbaram@quicinc.com,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pwm@vger.kernel.org,
        Anjelique Melendez <quic_amelende@quicinc.com>
Subject: Re: [PATCH v2 3/7] soc: qcom: add QCOM PBS driver
Message-ID: <85e4f0ef-baf8-4588-a10c-d64821c8c518@kadam.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725193423.25047-4-quic_amelende@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anjelique,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Anjelique-Melendez/dt-bindings-soc-qcom-Add-qcom-pbs-bindings/20230726-034011
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20230725193423.25047-4-quic_amelende%40quicinc.com
patch subject: [PATCH v2 3/7] soc: qcom: add QCOM PBS driver
config: parisc-randconfig-m041-20230726 (https://download.01.org/0day-ci/archive/20230727/202307270539.1JVFQf6W-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230727/202307270539.1JVFQf6W-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202307270539.1JVFQf6W-lkp@intel.com/

smatch warnings:
drivers/soc/qcom/qcom-pbs.c:97 qcom_pbs_wait_for_ack() warn: should this be 'retries == -1'

vim +97 drivers/soc/qcom/qcom-pbs.c

c261225d90e1d3 Anjelique Melendez 2023-07-25   68  static int qcom_pbs_wait_for_ack(struct pbs_dev *pbs, u8 bit_pos)
c261225d90e1d3 Anjelique Melendez 2023-07-25   69  {
c261225d90e1d3 Anjelique Melendez 2023-07-25   70  	u16 retries = 2000, delay = 1000;
c261225d90e1d3 Anjelique Melendez 2023-07-25   71  	int ret;
c261225d90e1d3 Anjelique Melendez 2023-07-25   72  	u8 val;
c261225d90e1d3 Anjelique Melendez 2023-07-25   73  
c261225d90e1d3 Anjelique Melendez 2023-07-25   74  	while (retries--) {

Change this to while (--retries) {

c261225d90e1d3 Anjelique Melendez 2023-07-25   75  		ret = qcom_pbs_read(pbs, PBS_CLIENT_SCRATCH2, &val);
c261225d90e1d3 Anjelique Melendez 2023-07-25   76  		if (ret < 0)
c261225d90e1d3 Anjelique Melendez 2023-07-25   77  			return ret;
c261225d90e1d3 Anjelique Melendez 2023-07-25   78  
c261225d90e1d3 Anjelique Melendez 2023-07-25   79  		if (val == 0xFF) {
c261225d90e1d3 Anjelique Melendez 2023-07-25   80  			/* PBS error - clear SCRATCH2 register */
c261225d90e1d3 Anjelique Melendez 2023-07-25   81  			ret = qcom_pbs_write(pbs, PBS_CLIENT_SCRATCH2, 0);
c261225d90e1d3 Anjelique Melendez 2023-07-25   82  			if (ret < 0)
c261225d90e1d3 Anjelique Melendez 2023-07-25   83  				return ret;
c261225d90e1d3 Anjelique Melendez 2023-07-25   84  
c261225d90e1d3 Anjelique Melendez 2023-07-25   85  			dev_err(pbs->dev, "NACK from PBS for bit %u\n", bit_pos);
c261225d90e1d3 Anjelique Melendez 2023-07-25   86  			return -EINVAL;
c261225d90e1d3 Anjelique Melendez 2023-07-25   87  		}
c261225d90e1d3 Anjelique Melendez 2023-07-25   88  
c261225d90e1d3 Anjelique Melendez 2023-07-25   89  		if (val & BIT(bit_pos)) {
c261225d90e1d3 Anjelique Melendez 2023-07-25   90  			dev_dbg(pbs->dev, "PBS sequence for bit %u executed!\n", bit_pos);
c261225d90e1d3 Anjelique Melendez 2023-07-25   91  			break;
c261225d90e1d3 Anjelique Melendez 2023-07-25   92  		}
c261225d90e1d3 Anjelique Melendez 2023-07-25   93  
c261225d90e1d3 Anjelique Melendez 2023-07-25   94  		usleep_range(delay, delay + 100);
c261225d90e1d3 Anjelique Melendez 2023-07-25   95  	}
c261225d90e1d3 Anjelique Melendez 2023-07-25   96  
c261225d90e1d3 Anjelique Melendez 2023-07-25  @97  	if (!retries) {

Otherwise this check needs to be: "if (retries == USHRT_MAX)".

Btw, I really feel like people are generally better off declaring list
iterators as int whenever possible.  I have written a very rude blog
to that effect.
https://staticthinking.wordpress.com/2022/06/01/unsigned-int-i-is-stupid/

c261225d90e1d3 Anjelique Melendez 2023-07-25   98  		dev_err(pbs->dev, "Timeout for PBS ACK/NACK for bit %u\n", bit_pos);
c261225d90e1d3 Anjelique Melendez 2023-07-25   99  		return -ETIMEDOUT;
c261225d90e1d3 Anjelique Melendez 2023-07-25  100  	}
c261225d90e1d3 Anjelique Melendez 2023-07-25  101  
c261225d90e1d3 Anjelique Melendez 2023-07-25  102  	return 0;
c261225d90e1d3 Anjelique Melendez 2023-07-25  103  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

