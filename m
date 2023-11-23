Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11F477F5939
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 08:29:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbjKWH3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 02:29:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjKWH3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 02:29:23 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E61FF9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 23:29:27 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-32df66c691dso378935f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 23:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700724565; x=1701329365; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2RMBpqwTyjetIh1+BcmGtklvAHmEfyIHGOLxM0IItVk=;
        b=EtG8K9ntveX2VEBHsUG1HOufFnia7QYjUdoruN8nr8tDcH5l9XZDxutool/mKAS64Q
         mKxWegRowT288i6rXj+JODbjNIcS3pjgzcOFDE86AAk4nOsOlfFvioKVwH2Y7z9+Kpu6
         c3a2uXQnWT2dP9gmf1RlZHcBP6IYHZQmAhZ6Ba9OC6gnh2YGy8NiW5YPYi79UQSojB6Z
         lLvFWuqt+xcWvsj7hTCLBpAiMAdQoszJNH/SXB2qG6vKTjYSUJhh3Q3Q3uxlppUGMT5s
         5azkNGg1qoEzc1fRyvmDWUvQjSFLdGhvLHi3CPz8Vbp3eCezPjoTpKqls2dbopB1hTaJ
         dRtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700724565; x=1701329365;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2RMBpqwTyjetIh1+BcmGtklvAHmEfyIHGOLxM0IItVk=;
        b=dFbv+cHWhXrGRKWJhXflFnPT71sKE0SCxed2JfG6JcUrJN4T64MbiFS6fl9K7qz4Zw
         rWs/3KUI83HqbXbn09y44IgLTC0Ttd9NMrOdjpMrin9KTLOFDezXpVaUgRduuWCCwGOf
         BCZkZQjDeG1eTK+1dy4H9sdINPj3gdNT3Ol5zL/35hxg+UfMFCLnSX8twXgDY/m4fKW4
         pLNpUiAy6khBFvPbw3F0vTZu3CzXBVPOJLAOzuQJE5f9NaAx24T8LHmAcyvgq9xbXgjh
         V6vf46gcc7tblTCT/+h1M5ERmz6y3PPZOqmjizDWIg3SxoOuVhhVQ/Zv5qiVnoAGBnPA
         GHCw==
X-Gm-Message-State: AOJu0YzYpbJ87W6GxFTv15oYeVh8hXkZRdV3bt5HJo2yf0Knmo54T/KF
        c1xijyiErVnFvJEOqGYfDYBlnQ==
X-Google-Smtp-Source: AGHT+IENxZQbFjO4Md44OEoK0FaFECJUVlCSi3Q9vQd2EcjXWEeut/MXhhi5Ahz6fy/w1bE9RdFDaw==
X-Received: by 2002:a5d:45c1:0:b0:32d:701b:a585 with SMTP id b1-20020a5d45c1000000b0032d701ba585mr2662171wrs.69.1700724565535;
        Wed, 22 Nov 2023 23:29:25 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id k24-20020a5d5258000000b00332c0aace23sm794300wrc.105.2023.11.22.23.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 23:29:25 -0800 (PST)
Date:   Thu, 23 Nov 2023 10:29:22 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     oe-kbuild@lists.linux.dev, Tony Lindgren <tony@atomide.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        "David S . Miller" <davem@davemloft.net>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v3 3/3] serial: core: Move console character device
 handling from printk
Message-ID: <8a4c0b43-cf63-400d-b33d-d9c447b7e0b9@suswa.mountain>
References: <20231121113203.61341-4-tony@atomide.com>
 <6933c98f-7f76-4955-ba0f-89ea340b672d@suswa.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6933c98f-7f76-4955-ba0f-89ea340b672d@suswa.mountain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2023 at 10:24:24AM +0300, Dan Carpenter wrote:
> Hi Tony,
> 
> kernel test robot noticed the following build warnings:
> 
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Tony-Lindgren/printk-Save-console-options-for-add_preferred_console_match/20231121-193809
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
> patch link:    https://lore.kernel.org/r/20231121113203.61341-4-tony%40atomide.com
> patch subject: [PATCH v3 3/3] serial: core: Move console character device handling from printk
> config: parisc-randconfig-r081-20231122 (https://download.01.org/0day-ci/archive/20231122/202311221437.5Gil0Pml-lkp@intel.com/config)
> compiler: hppa-linux-gcc (GCC) 13.2.0
> reproduce: (https://download.01.org/0day-ci/archive/20231122/202311221437.5Gil0Pml-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <error27@gmail.com>
> | Closes: https://lore.kernel.org/r/202311221437.5Gil0Pml-lkp@intel.com/
> 
> smatch warnings:
> drivers/tty/serial/serial_base_bus.c:266 serial_base_add_preferred_console() error: uninitialized symbol 'nmbr_match'.
> drivers/tty/serial/serial_base_bus.c:265 serial_base_add_preferred_console() error: uninitialized symbol 'char_match'.
> 
> vim +/nmbr_match +266 drivers/tty/serial/serial_base_bus.c
> 
> e4ebdcd790e0f3 Tony Lindgren 2023-11-21  261  int serial_base_add_preferred_console(struct uart_driver *drv,
> e4ebdcd790e0f3 Tony Lindgren 2023-11-21  262  				      struct uart_port *port)
> e4ebdcd790e0f3 Tony Lindgren 2023-11-21  263  {
> e4ebdcd790e0f3 Tony Lindgren 2023-11-21  264  	const char *port_match __free(kfree);
> b1b8726ec3f40b Tony Lindgren 2023-11-21 @265  	const char *char_match __free(kfree);
> b1b8726ec3f40b Tony Lindgren 2023-11-21 @266  	const char *nmbr_match __free(kfree);
> 
> These need to be initialized to NULL.
> 
> 	const char *char_match __free(kfree) = NULL;
> 

Let's add a todo to make checkpatch warn about this.

KTODO: make checkpatch warn about __free() functions without an initializer

regards,
dan carpenter


