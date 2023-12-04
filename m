Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A757B802B2E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 06:03:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbjLDFAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 00:00:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjLDFAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 00:00:30 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 098EEE6
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 21:00:37 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-40b2ddab817so41377375e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Dec 2023 21:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701666033; x=1702270833; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ru/NPj09V1ASiEGDCszqcY2Rb4Q+L/jQQ4h1Ot3L8XU=;
        b=fRdzqUSJVk+LuT3rPfr+CyqFGUuBdjbJEEFxA7UYPRFGyC2T/gygOCQaMdghvXA02g
         QFsz1TmxxBIb4oCN71Y4W2xl+LImsXA5mXBZYkoQ0UjHaSpcKvv4z8mn1AYK6VwpY0pp
         SfTKIDwpaJxNl6EU5XtX5aLhfXMqxjkG7iMdNPDFHLjZM7lBeEpuc9HmOhCFW7wc0OSL
         Vuv5QfBigVJxsHuESIwPNefyFiWSu3tBWBMiumMCKCHg5aOl37n5w9gdOEXfhkDCwUDf
         5yLA7WRAgGpD+hcOBAo0jOOIvLvzHc/27yqIrB5PDpkq1yVyj1c/1E3dFVXKnzkfgNcq
         Z2Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701666033; x=1702270833;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ru/NPj09V1ASiEGDCszqcY2Rb4Q+L/jQQ4h1Ot3L8XU=;
        b=LJUu3Xq39L59yWFdOLG7Csqm0N5QRNkZ2HkKBFPtjqbHYigHxJXdmSUyMiS26r0Pxm
         NJVWo8xN3KRn2EIn+0RhJ6NzxyyFJaGzbTtmlGfd+7zYk2+9KhoX1sTKfXAlF55Lba8E
         Ojasxs6lO1ZRDiAqCwAZjC9AZCLavaB69u2q2MP9ZLGvID3CVVJHjJSm+oJSr/t7xKt8
         becexLemwinv4fO43KtlE35HCzlLvXJ9N+DVZPgebBWn/zlLD7E8Hgqq5u/V5OUGqFfB
         7Uttbq2LAJb8jaye5WSYc2avq1HuTiJ/f4Xf3tkhIJA6qDqrM5MeiqH75NcIG5EJqQo/
         71wQ==
X-Gm-Message-State: AOJu0YwUfZcKi8wIoaH3R8QJOUbZ0NsmT9HqV6wqd7SMF5/O8+CcOMdi
        3EoLVigtMeCffUUy9sq62kge4w==
X-Google-Smtp-Source: AGHT+IEkXJrUkXJJogule3Vldy+8qcSDhRA/unZzuiLtfHzdZ3i9H6s6WVRZBg9D6M0qgUEnPEOnng==
X-Received: by 2002:a7b:ce8b:0:b0:40b:5e59:daa3 with SMTP id q11-20020a7bce8b000000b0040b5e59daa3mr1958418wmj.182.1701666033441;
        Sun, 03 Dec 2023 21:00:33 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id o15-20020a05600c510f00b004064cd71aa8sm12143279wms.34.2023.12.03.21.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 21:00:32 -0800 (PST)
Date:   Mon, 4 Dec 2023 08:00:29 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     oe-kbuild@lists.linux.dev,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        devicetree@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH 2/2] serial: core: implement support for rs485-mux-gpios
Message-ID: <bb7376cd-27b9-4585-9c98-140a29808b0f@suswa.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231120151056.148450-3-linux@rasmusvillemoes.dk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rasmus,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Rasmus-Villemoes/dt-bindings-serial-rs485-add-rs485-mux-gpios-binding/20231120-231551
base:   v6.7-rc2
patch link:    https://lore.kernel.org/r/20231120151056.148450-3-linux%40rasmusvillemoes.dk
patch subject: [PATCH 2/2] serial: core: implement support for rs485-mux-gpios
config: hexagon-randconfig-r071-20231121 (https://download.01.org/0day-ci/archive/20231203/202312031811.pmLZJIf5-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20231203/202312031811.pmLZJIf5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202312031811.pmLZJIf5-lkp@intel.com/

New smatch warnings:
drivers/tty/serial/serial_core.c:3651 uart_get_rs485_mode() warn: passing zero to 'PTR_ERR'

Old smatch warnings:
drivers/tty/serial/serial_core.c:2996 iomem_base_show() warn: argument 3 to %lX specifier is cast from pointer

vim +/PTR_ERR +3651 drivers/tty/serial/serial_core.c

7cda0b9eb6eb9e Andy Shevchenko       2023-10-03  3641  	dflags = (rs485conf->flags & SER_RS485_RX_DURING_TX) ?
163f080eb717d2 Christoph Niedermaier 2022-12-02  3642  		 GPIOD_OUT_HIGH : GPIOD_OUT_LOW;
7cda0b9eb6eb9e Andy Shevchenko       2023-10-03  3643  	desc = devm_gpiod_get_optional(dev, "rs485-rx-during-tx", dflags);
7cda0b9eb6eb9e Andy Shevchenko       2023-10-03  3644  	if (IS_ERR(desc))
7cda0b9eb6eb9e Andy Shevchenko       2023-10-03  3645  		return dev_err_probe(dev, PTR_ERR(desc), "Cannot get rs485-rx-during-tx-gpios\n");
7cda0b9eb6eb9e Andy Shevchenko       2023-10-03  3646  	port->rs485_rx_during_tx_gpio = desc;
163f080eb717d2 Christoph Niedermaier 2022-12-02  3647  
da0ccd117da1e4 Rasmus Villemoes      2023-11-20  3648  	dflags = (rs485conf->flags & SER_RS485_ENABLED) ? GPIOD_OUT_HIGH : GPIOD_OUT_LOW;
da0ccd117da1e4 Rasmus Villemoes      2023-11-20  3649  	desc = devm_gpiod_get_optional(dev, "rs485-mux", dflags);
da0ccd117da1e4 Rasmus Villemoes      2023-11-20  3650  	if (IS_ERR(desc))
da0ccd117da1e4 Rasmus Villemoes      2023-11-20 @3651  		return dev_err_probe(dev, PTR_ERR(port->rs485_mux_gpio),
                                                                                          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
s/port->rs485_mux_gpio/desc/

da0ccd117da1e4 Rasmus Villemoes      2023-11-20  3652  				     "Cannot get rs485-mux-gpios\n");
da0ccd117da1e4 Rasmus Villemoes      2023-11-20  3653  	port->rs485_mux_gpio = desc;
da0ccd117da1e4 Rasmus Villemoes      2023-11-20  3654  
c150c0f362c1e5 Lukas Wunner          2020-05-12  3655  	return 0;
ef838a81dd4de1 Uwe Kleine-König      2017-09-13  3656  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

