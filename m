Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26ECA7FB1EF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 07:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343644AbjK1GZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 01:25:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232892AbjK1GZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 01:25:09 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 981AC1A2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 22:25:15 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40b4744d603so12379325e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 22:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701152714; x=1701757514; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AztDr/PX7XV6GxnUCezhc7mi8f7rsQ2h0k5PO8WzIi4=;
        b=Ro1Ze+sGCBVGhMJwMqy/xKq+Kafz7vjlA+VCuRTR4kSquzfSXbx04vXgPFFbO2gH1U
         C7T9yAIfjc+WhXiEustA2JubGxvcIULMHZSOhA6QvZ9p8T4gxSQR12WhESbGUcWQf+Ho
         lzSwwekq1xs/1BgIZRGxzNlQLuQ8Rp6i60DcFhxNDArgXUUPffw1V9qKtlH6miV/ZrxA
         gEBGxUUDgY64u4I2TK2FX73ZSfu4OyZanlhUt1mkmKKZHGYlH+7BIrZjvsa8QW3+MSuW
         ge0p0CHP1Hp9ZXqZQ8I7L5pYsroMBu9esO4Hr5xVlw8xYrqqVN8ZRq8nrYjGGa1x/c7l
         jvow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701152714; x=1701757514;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AztDr/PX7XV6GxnUCezhc7mi8f7rsQ2h0k5PO8WzIi4=;
        b=U7lt/mER9yRE8QcT0ppUTF89vBG31U2pTa6Cs4qaRLVHvDsGwvdG63JwYufJO0bwA3
         G+4IQfD91/dDeyjAvu/hO09W3CWIHd/RybPlEatww0ukRP1meMGD4cBkWURNRO/PrcJH
         hqBpiOb17rsLbb/kfxB1aPKPCU+C/q/kxuPHpthkOl4R4XmD1AR1yYLrcNj1YLYS+2AD
         ZdMR0CMlFDGH7PtrtBXtA4Lw5rU2ixiUrCXnF492YgoaGv5Ywon0RDRDbdLPaKe+UmbU
         tMj7+tLlgQ+4VDE9Yr8JlDhnh/Zv5lN0yiOwlRPKqF9ghwlJfdwASjTV+EXdk8zYAbQv
         C80A==
X-Gm-Message-State: AOJu0Yy2b6s6U4/1Pkz349N9CmR+snJXFSbIRbTE5KWx+RE1iiED1EdP
        cxRuvK/PH5lrB3Uv0l4u1h3VHA==
X-Google-Smtp-Source: AGHT+IGZRRriVRMB0blg2rSEXFK0La4zXTF63IwPjb70QBHHyJE0DxMzqh4VW8kV8N+ek/nNlAFikg==
X-Received: by 2002:a5d:44cd:0:b0:332:ead6:3596 with SMTP id z13-20020a5d44cd000000b00332ead63596mr8309050wrr.45.1701152714078;
        Mon, 27 Nov 2023 22:25:14 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id o10-20020adfcf0a000000b00332cda91c85sm13879380wrj.12.2023.11.27.22.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 22:25:13 -0800 (PST)
From:   Dan Carpenter <dan.carpenter@linaro.org>
X-Google-Original-From: Dan Carpenter <dan.carpenter@oracle.com>
Date:   Tue, 28 Nov 2023 09:25:11 +0300
To:     oe-kbuild@lists.linux.dev,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: drivers/crypto/stm32/stm32-crc32.c:108 stm32_crc_get_next_crc()
 warn: can 'crc' even be NULL?
Message-ID: <9661b53b-8853-4994-94be-9549278a2aac@suswa.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   df60cee26a2e3d937a319229e335cb3f9c1f16d2
commit: 9e4e24414cc6b45bd887d746a59691e295431ddf arm64: introduce STM32 family on Armv8 architecture
config: arm64-randconfig-r081-20231127 (https://download.01.org/0day-ci/archive/20231128/202311281111.ou2oUL2i-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce: (https://download.01.org/0day-ci/archive/20231128/202311281111.ou2oUL2i-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>
| Closes: https://lore.kernel.org/r/202311281111.ou2oUL2i-lkp@intel.com/

smatch warnings:
drivers/crypto/stm32/stm32-crc32.c:108 stm32_crc_get_next_crc() warn: can 'crc' even be NULL?
drivers/crypto/stm32/stm32-hash.c:1168 stm32_hash_irq_thread() warn: inconsistent indenting

vim +/crc +108 drivers/crypto/stm32/stm32-crc32.c

10b89c43a64eb0 drivers/crypto/stm32/stm32-crc32.c Nicolas Toromanoff 2020-05-12  102  static struct stm32_crc *stm32_crc_get_next_crc(void)
b51dbe90912a0c drivers/crypto/stm32/stm32_crc32.c Fabien DESSENNE    2017-03-21  103  {
b51dbe90912a0c drivers/crypto/stm32/stm32_crc32.c Fabien DESSENNE    2017-03-21  104  	struct stm32_crc *crc;
b51dbe90912a0c drivers/crypto/stm32/stm32_crc32.c Fabien DESSENNE    2017-03-21  105  
b51dbe90912a0c drivers/crypto/stm32/stm32_crc32.c Fabien DESSENNE    2017-03-21  106  	spin_lock_bh(&crc_list.lock);
49c2c082e00e0b drivers/crypto/stm32/stm32-crc32.c Nicolas Toromanoff 2020-05-12  107  	crc = list_first_entry(&crc_list.dev_list, struct stm32_crc, list);
10b89c43a64eb0 drivers/crypto/stm32/stm32-crc32.c Nicolas Toromanoff 2020-05-12 @108  	if (crc)

list_first_entry() always returns non-NULL but if the list is empty then
the pointer is invalid (but still non-NULL).  Did you mean
list_first_entry_or_null()?

10b89c43a64eb0 drivers/crypto/stm32/stm32-crc32.c Nicolas Toromanoff 2020-05-12  109  		list_move_tail(&crc->list, &crc_list.dev_list);
b51dbe90912a0c drivers/crypto/stm32/stm32_crc32.c Fabien DESSENNE    2017-03-21  110  	spin_unlock_bh(&crc_list.lock);
b51dbe90912a0c drivers/crypto/stm32/stm32_crc32.c Fabien DESSENNE    2017-03-21  111  
10b89c43a64eb0 drivers/crypto/stm32/stm32-crc32.c Nicolas Toromanoff 2020-05-12  112  	return crc;
10b89c43a64eb0 drivers/crypto/stm32/stm32-crc32.c Nicolas Toromanoff 2020-05-12  113  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

