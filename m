Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5447F5835
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 07:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344777AbjKWGaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 01:30:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344704AbjKWGaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 01:30:01 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EEF618E
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 22:30:06 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-332c46d5988so324388f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 22:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700721005; x=1701325805; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X7PLG5qku9qQV0uDNGnepcBPSOxctgjb510bjUV05bA=;
        b=gHBWObMQ34TCoaAhkr8GsEemhnYxM/WntptmAxgT5Q6RW+UsRB/nHYQ0pBSzkRHUhw
         O/bR7z//WwJFY2mezz2me+3Mliws8gZ0oOPA4dhH35LkvifLhjvXRIaEtQXZmVRsPiqX
         Z8NxcgLDFVObWqJyWTChj10xu/tk7p57MMSYGZLG8RgsSNe/QAW6qg1RUfM454XXRuvy
         b0AmCxarF8mYgpjRA7rShyN8cGuWeS71O86Y8jQ4sHDcbSZTZt6XytBdmCqzzFyVkwhu
         3ZvvN5teib9kcARn82SEVj8NKvfYg/iYsr1BiTsE5ckQZvcaOxrV+OkvMB0uFXRkn2ol
         gM9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700721005; x=1701325805;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X7PLG5qku9qQV0uDNGnepcBPSOxctgjb510bjUV05bA=;
        b=J1KtAQh+vxN40lZgagJmZDsj3Vjz5tjIdBldi5dXc9E+vMlUIXp06Q8033zmyM6X3d
         Kdx0j3FnJ6UI9xSj0yDF8wQ2+nDX+HMEGkGLCzAn2mylxumAhe86B248mYZ/brBzbHRC
         SlRMB5DXFmBCdLUPxAYmtLey4I9Gd3+d+A1FHnTN5VGfg9Ix/GaiFszZw5c43ZyHjBri
         T6kAh8qphvce08HR/JhzW1H+ymmLKRDPSaCmSpl70+i5QxZ/aiTPXDq0LE4nz54TRrfe
         KMkrrKyJM+3D8KO+4lTwS27qOXrPpYk7VhC70V4L7CcGcoCAS8KQT/znu6uVFCGh9hVo
         vq+A==
X-Gm-Message-State: AOJu0YwS1+WMbSpCo3PzVm2/Ro5iLtqjMvLMsOROwyWIWN1hDoYt2w5h
        VB31EqxCSCYjFmWBCj/NEdl6ig==
X-Google-Smtp-Source: AGHT+IEOQKjIO/ymr99oSKi2CVqhWw7ZkjrjTukMENMkvxDS5SVrbC3/TD7uSFL+KrdRU/SU+HcdmA==
X-Received: by 2002:a5d:4dc3:0:b0:31f:ef77:67e4 with SMTP id f3-20020a5d4dc3000000b0031fef7767e4mr2984362wru.37.1700721004867;
        Wed, 22 Nov 2023 22:30:04 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id f12-20020a5d664c000000b003316be2df7fsm653784wrw.17.2023.11.22.22.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 22:30:04 -0800 (PST)
From:   Dan Carpenter <dan.carpenter@linaro.org>
X-Google-Original-From: Dan Carpenter <dan.carpenter@oracle.com>
Date:   Thu, 23 Nov 2023 09:30:01 +0300
To:     oe-kbuild@lists.linux.dev,
        "marcelo.schmitt@analog.com" <marcelo.schmitt@analog.com>,
        beniamin.bia@analog.com, paul.cercueil@analog.com,
        Michael.Hennerich@analog.com, lars@metafoo.de, jic23@kernel.org,
        marcelo.schmitt1@gmail.com
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        Marcelo Schmitt <marcelo.schmitt@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] iio: adc: Add support for AD7091R-8
Message-ID: <bde42756-5153-42fa-b9d6-769a2978c337@suswa.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <514295a9b760b44a710425803a41decddd3e8df8.1700595310.git.marcelo.schmitt1@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/marcelo-schmitt-analog-com/MAINTAINERS-Add-MAINTAINERS-entry-for-AD7091R/20231122-093706
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/514295a9b760b44a710425803a41decddd3e8df8.1700595310.git.marcelo.schmitt1%40gmail.com
patch subject: [PATCH 6/7] iio: adc: Add support for AD7091R-8
config: x86_64-randconfig-161-20231122 (https://download.01.org/0day-ci/archive/20231123/202311230719.KwwC9NyC-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce: (https://download.01.org/0day-ci/archive/20231123/202311230719.KwwC9NyC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>
| Closes: https://lore.kernel.org/r/202311230719.KwwC9NyC-lkp@intel.com/

smatch warnings:
drivers/iio/adc/ad7091r-base.c:53 ad7091r_set_mode() warn: ignoring unreachable code.

vim +53 drivers/iio/adc/ad7091r-base.c

ca69300173b642 Paul Cercueil   2019-11-15  32  static int ad7091r_set_mode(struct ad7091r_state *st, enum ad7091r_mode mode)
ca69300173b642 Paul Cercueil   2019-11-15  33  {
ca69300173b642 Paul Cercueil   2019-11-15  34  	int ret, conf;
ca69300173b642 Paul Cercueil   2019-11-15  35  
ca69300173b642 Paul Cercueil   2019-11-15  36  	switch (mode) {
ca69300173b642 Paul Cercueil   2019-11-15  37  	case AD7091R_MODE_SAMPLE:
ca69300173b642 Paul Cercueil   2019-11-15  38  		conf = 0;
ca69300173b642 Paul Cercueil   2019-11-15  39  		break;
ca69300173b642 Paul Cercueil   2019-11-15  40  	case AD7091R_MODE_COMMAND:
ca69300173b642 Paul Cercueil   2019-11-15  41  		conf = AD7091R_REG_CONF_CMD;
ca69300173b642 Paul Cercueil   2019-11-15  42  		break;
ca69300173b642 Paul Cercueil   2019-11-15  43  	case AD7091R_MODE_AUTOCYCLE:
ca69300173b642 Paul Cercueil   2019-11-15  44  		conf = AD7091R_REG_CONF_AUTO;
ca69300173b642 Paul Cercueil   2019-11-15  45  		break;
ca69300173b642 Paul Cercueil   2019-11-15  46  	default:
ca69300173b642 Paul Cercueil   2019-11-15  47  		return -EINVAL;
ca69300173b642 Paul Cercueil   2019-11-15  48  	}
ca69300173b642 Paul Cercueil   2019-11-15  49  
fccb9cf346d38a Marcelo Schmitt 2023-11-21  50  	/* AD7091R-2/4/8 don't set normal, command, autocycle modes in conf reg */
fccb9cf346d38a Marcelo Schmitt 2023-11-21  51  	if (st->chip_info->type == AD7091R5) {
fccb9cf346d38a Marcelo Schmitt 2023-11-21  52  		return 0;

I normally ignore when people add a return 0 to stub out code because
it's obviously deliberate.  But this is a patch to add support for new
hardware and it's stubbing out the existing:

	ret = regmap_update_bits()

For existing users...  It feels like if that's necessary then it should
be done in a separate commit.

ca69300173b642 Paul Cercueil   2019-11-15 @53  		ret = regmap_update_bits(st->map, AD7091R_REG_CONF,
ca69300173b642 Paul Cercueil   2019-11-15  54  					 AD7091R_REG_CONF_MODE_MASK, conf);
ca69300173b642 Paul Cercueil   2019-11-15  55  		if (ret)
ca69300173b642 Paul Cercueil   2019-11-15  56  			return ret;
fccb9cf346d38a Marcelo Schmitt 2023-11-21  57  	}
ca69300173b642 Paul Cercueil   2019-11-15  58  
ca69300173b642 Paul Cercueil   2019-11-15  59  	st->mode = mode;
ca69300173b642 Paul Cercueil   2019-11-15  60  
ca69300173b642 Paul Cercueil   2019-11-15  61  	return 0;
ca69300173b642 Paul Cercueil   2019-11-15  62  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

