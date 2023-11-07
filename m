Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9F17E3487
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 05:29:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233410AbjKGE3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 23:29:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233360AbjKGE3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 23:29:36 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC337FD
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 20:29:32 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-53e3b8f906fso8718112a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 20:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699331371; x=1699936171; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XQPupM1di7b1ZBbV6KY9DZ/O22wNMYRCE8a+kZseFTo=;
        b=TH0F2xAzbb8tqQJPNw/iEHMRV3bE6v3vjSTuPKv9BMBHkWQqJINq0nXT/1y7fecLv9
         ix/vSNkDwXFidk1MDTbrsKsAdpZ7oqSLJCcQA9DFS8CZHB7HlzMbbIDd03cdDWuA35I7
         MttQtXtZmHea+DIrknvqgQ6H+qTlzbi2zpMAScfBoLeADfc4f8J3IBGj7qxcP1zhMvlw
         pmS5JOI3QOYwx/6qYG4QxCFzFuwj2Q5ByxnuvzuvA9j07JwoEbDgwPi8C0svVAa6H1ej
         anf2Jtg8ztvTURj9dQW4fcUFrqAg3Fmz5JRVwoP0uPZ0a/UVXkmC7BoXyV3+NEzpEG2B
         JniA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699331371; x=1699936171;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XQPupM1di7b1ZBbV6KY9DZ/O22wNMYRCE8a+kZseFTo=;
        b=ED7J1hnzNHF2f+gPhPG++98jB7+jBWUrJojpdXuqeeOAjEyLjhIb1sIWXHWUj7rAWy
         nGLrrOL3uEq45yAOYtTrIfgJX3qcF9lQrFT7dDLnYGDMQnxZBgKSPvLC6lAqCwL7Io4D
         1CmsNNGvZfsFiwdxahU+EHcAI3qr1WP7HDTxbfO7UMzRDGRHoKNx6aRxZ6IpnKSp7Zc+
         +gsQYRDO1yrG8lkCf65BcUMtul+H7qcxIhfM5/Wo9TKYEuRB53HCjJK3T2UzXaGh1fiX
         fbyCThv8E1ovN3EBRGML4mPdNmFBJYijSgrOsBUUcQz6qRHkh+MkJD2VuDmQFFbflPYf
         g85w==
X-Gm-Message-State: AOJu0Yx+kOd50omltmt8Xhu9AyD7ZJRHA0sWVl27QiL8koiNbQ0JTIFe
        tX5CQhPRaG7/uRCggeC6YkX5ee0f0YyZ2sKlK7A=
X-Google-Smtp-Source: AGHT+IE3ONDYmgnxRFMxvojQ+tQ5zt/oZDZhMVQWIp3GH2Q1sfQixeF4Snh10gF6cjzCMiWLj6E1dA==
X-Received: by 2002:a50:cd5d:0:b0:543:d584:7d8f with SMTP id d29-20020a50cd5d000000b00543d5847d8fmr10459341edj.32.1699331371328;
        Mon, 06 Nov 2023 20:29:31 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id t26-20020a056402241a00b00543597cd190sm4972319eda.47.2023.11.06.20.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 20:29:31 -0800 (PST)
Date:   Tue, 7 Nov 2023 07:29:28 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     oe-kbuild@lists.linux.dev, Arnd Bergmann <arnd@arndb.de>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Javier Martinez Canillas <javierm@redhat.com>
Subject: drivers/video/fbdev/hyperv_fb.c:1077 hvfb_getmem() error:
 uninitialized symbol 'base'.
Message-ID: <f08ac5bc-23af-4334-a045-e417e9a9d76b@kadam.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d2f51b3516dade79269ff45eae2a7668ae711b25
commit: a07b50d80ab621f4f18d429068a43cffec26691f hyperv: avoid dependency on screen_info
config: x86_64-randconfig-161-20231106 (https://download.01.org/0day-ci/archive/20231107/202311070802.YCpvehaz-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce: (https://download.01.org/0day-ci/archive/20231107/202311070802.YCpvehaz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202311070802.YCpvehaz-lkp@intel.com/

smatch warnings:
drivers/video/fbdev/hyperv_fb.c:1077 hvfb_getmem() error: uninitialized symbol 'base'.
drivers/video/fbdev/hyperv_fb.c:1077 hvfb_getmem() error: uninitialized symbol 'size'.

vim +/base +1077 drivers/video/fbdev/hyperv_fb.c

3546448338e76a drivers/video/fbdev/hyperv_fb.c Jake Oshins       2015-08-05   992  static int hvfb_getmem(struct hv_device *hdev, struct fb_info *info)
68a2d20b79b105 drivers/video/hyperv_fb.c       Haiyang Zhang     2013-04-29   993  {
9069fd54960304 drivers/video/hyperv_fb.c       Gerd Hoffmann     2014-02-26   994  	struct hvfb_par *par = info->par;
9069fd54960304 drivers/video/hyperv_fb.c       Gerd Hoffmann     2014-02-26   995  	struct pci_dev *pdev  = NULL;
68a2d20b79b105 drivers/video/hyperv_fb.c       Haiyang Zhang     2013-04-29   996  	void __iomem *fb_virt;
9069fd54960304 drivers/video/hyperv_fb.c       Gerd Hoffmann     2014-02-26   997  	int gen2vm = efi_enabled(EFI_BOOT);
81d2393485f099 drivers/video/fbdev/hyperv_fb.c Thomas Zimmermann 2022-12-19   998  	resource_size_t base, size;
3a6fb6c4255c38 drivers/video/fbdev/hyperv_fb.c Wei Hu            2019-12-09   999  	phys_addr_t paddr;
9069fd54960304 drivers/video/hyperv_fb.c       Gerd Hoffmann     2014-02-26  1000  	int ret;
68a2d20b79b105 drivers/video/hyperv_fb.c       Haiyang Zhang     2013-04-29  1001  
3a6fb6c4255c38 drivers/video/fbdev/hyperv_fb.c Wei Hu            2019-12-09  1002  	if (!gen2vm) {
68a2d20b79b105 drivers/video/hyperv_fb.c       Haiyang Zhang     2013-04-29  1003  		pdev = pci_get_device(PCI_VENDOR_ID_MICROSOFT,
68a2d20b79b105 drivers/video/hyperv_fb.c       Haiyang Zhang     2013-04-29  1004  			PCI_DEVICE_ID_HYPERV_VIDEO, NULL);
68a2d20b79b105 drivers/video/hyperv_fb.c       Haiyang Zhang     2013-04-29  1005  		if (!pdev) {
68a2d20b79b105 drivers/video/hyperv_fb.c       Haiyang Zhang     2013-04-29  1006  			pr_err("Unable to find PCI Hyper-V video\n");
68a2d20b79b105 drivers/video/hyperv_fb.c       Haiyang Zhang     2013-04-29  1007  			return -ENODEV;
68a2d20b79b105 drivers/video/hyperv_fb.c       Haiyang Zhang     2013-04-29  1008  		}
68a2d20b79b105 drivers/video/hyperv_fb.c       Haiyang Zhang     2013-04-29  1009  
81d2393485f099 drivers/video/fbdev/hyperv_fb.c Thomas Zimmermann 2022-12-19  1010  		base = pci_resource_start(pdev, 0);
81d2393485f099 drivers/video/fbdev/hyperv_fb.c Thomas Zimmermann 2022-12-19  1011  		size = pci_resource_len(pdev, 0);
3a6fb6c4255c38 drivers/video/fbdev/hyperv_fb.c Wei Hu            2019-12-09  1012  
3a6fb6c4255c38 drivers/video/fbdev/hyperv_fb.c Wei Hu            2019-12-09  1013  		/*
3a6fb6c4255c38 drivers/video/fbdev/hyperv_fb.c Wei Hu            2019-12-09  1014  		 * For Gen 1 VM, we can directly use the contiguous memory
3a6fb6c4255c38 drivers/video/fbdev/hyperv_fb.c Wei Hu            2019-12-09  1015  		 * from VM. If we succeed, deferred IO happens directly
3a6fb6c4255c38 drivers/video/fbdev/hyperv_fb.c Wei Hu            2019-12-09  1016  		 * on this allocated framebuffer memory, avoiding extra
3a6fb6c4255c38 drivers/video/fbdev/hyperv_fb.c Wei Hu            2019-12-09  1017  		 * memory copy.
3a6fb6c4255c38 drivers/video/fbdev/hyperv_fb.c Wei Hu            2019-12-09  1018  		 */
3a6fb6c4255c38 drivers/video/fbdev/hyperv_fb.c Wei Hu            2019-12-09  1019  		paddr = hvfb_get_phymem(hdev, screen_fb_size);
3a6fb6c4255c38 drivers/video/fbdev/hyperv_fb.c Wei Hu            2019-12-09  1020  		if (paddr != (phys_addr_t) -1) {
3a6fb6c4255c38 drivers/video/fbdev/hyperv_fb.c Wei Hu            2019-12-09  1021  			par->mmio_pp = paddr;
3a6fb6c4255c38 drivers/video/fbdev/hyperv_fb.c Wei Hu            2019-12-09  1022  			par->mmio_vp = par->dio_vp = __va(paddr);
3a6fb6c4255c38 drivers/video/fbdev/hyperv_fb.c Wei Hu            2019-12-09  1023  
3a6fb6c4255c38 drivers/video/fbdev/hyperv_fb.c Wei Hu            2019-12-09  1024  			info->fix.smem_start = paddr;
3a6fb6c4255c38 drivers/video/fbdev/hyperv_fb.c Wei Hu            2019-12-09  1025  			info->fix.smem_len = screen_fb_size;
3a6fb6c4255c38 drivers/video/fbdev/hyperv_fb.c Wei Hu            2019-12-09  1026  			info->screen_base = par->mmio_vp;
3a6fb6c4255c38 drivers/video/fbdev/hyperv_fb.c Wei Hu            2019-12-09  1027  			info->screen_size = screen_fb_size;
3a6fb6c4255c38 drivers/video/fbdev/hyperv_fb.c Wei Hu            2019-12-09  1028  
3a6fb6c4255c38 drivers/video/fbdev/hyperv_fb.c Wei Hu            2019-12-09  1029  			par->need_docopy = false;
3a6fb6c4255c38 drivers/video/fbdev/hyperv_fb.c Wei Hu            2019-12-09  1030  			goto getmem_done;
3a6fb6c4255c38 drivers/video/fbdev/hyperv_fb.c Wei Hu            2019-12-09  1031  		}
3a6fb6c4255c38 drivers/video/fbdev/hyperv_fb.c Wei Hu            2019-12-09  1032  		pr_info("Unable to allocate enough contiguous physical memory on Gen 1 VM. Using MMIO instead.\n");
a07b50d80ab621 drivers/video/fbdev/hyperv_fb.c Arnd Bergmann     2023-10-09  1033  	} else if (IS_ENABLED(CONFIG_SYSFB)) {
81d2393485f099 drivers/video/fbdev/hyperv_fb.c Thomas Zimmermann 2022-12-19  1034  		base = screen_info.lfb_base;
81d2393485f099 drivers/video/fbdev/hyperv_fb.c Thomas Zimmermann 2022-12-19  1035  		size = screen_info.lfb_size;
3a6fb6c4255c38 drivers/video/fbdev/hyperv_fb.c Wei Hu            2019-12-09  1036  	}

base and size not initialized on else path.

3a6fb6c4255c38 drivers/video/fbdev/hyperv_fb.c Wei Hu            2019-12-09  1037  
3a6fb6c4255c38 drivers/video/fbdev/hyperv_fb.c Wei Hu            2019-12-09  1038  	/*
3a6fb6c4255c38 drivers/video/fbdev/hyperv_fb.c Wei Hu            2019-12-09  1039  	 * Cannot use the contiguous physical memory.
3a6fb6c4255c38 drivers/video/fbdev/hyperv_fb.c Wei Hu            2019-12-09  1040  	 * Allocate mmio space for framebuffer.
3a6fb6c4255c38 drivers/video/fbdev/hyperv_fb.c Wei Hu            2019-12-09  1041  	 */
3a6fb6c4255c38 drivers/video/fbdev/hyperv_fb.c Wei Hu            2019-12-09  1042  	dio_fb_size =
3a6fb6c4255c38 drivers/video/fbdev/hyperv_fb.c Wei Hu            2019-12-09  1043  		screen_width * screen_height * screen_depth / 8;
3a6fb6c4255c38 drivers/video/fbdev/hyperv_fb.c Wei Hu            2019-12-09  1044  
c4b4d7047f16a8 drivers/video/fbdev/hyperv_fb.c Saurabh Sengar    2022-04-27  1045  	ret = vmbus_allocate_mmio(&par->mem, hdev, 0, -1,
3546448338e76a drivers/video/fbdev/hyperv_fb.c Jake Oshins       2015-08-05  1046  				  screen_fb_size, 0x100000, true);
9069fd54960304 drivers/video/hyperv_fb.c       Gerd Hoffmann     2014-02-26  1047  	if (ret != 0) {
3546448338e76a drivers/video/fbdev/hyperv_fb.c Jake Oshins       2015-08-05  1048  		pr_err("Unable to allocate framebuffer memory\n");
68a2d20b79b105 drivers/video/hyperv_fb.c       Haiyang Zhang     2013-04-29  1049  		goto err1;
9069fd54960304 drivers/video/hyperv_fb.c       Gerd Hoffmann     2014-02-26  1050  	}
68a2d20b79b105 drivers/video/hyperv_fb.c       Haiyang Zhang     2013-04-29  1051  
5f1251a48c17b5 drivers/video/fbdev/hyperv_fb.c Dexuan Cui        2020-11-17  1052  	/*
5f1251a48c17b5 drivers/video/fbdev/hyperv_fb.c Dexuan Cui        2020-11-17  1053  	 * Map the VRAM cacheable for performance. This is also required for
5f1251a48c17b5 drivers/video/fbdev/hyperv_fb.c Dexuan Cui        2020-11-17  1054  	 * VM Connect to display properly for ARM64 Linux VM, as the host also
5f1251a48c17b5 drivers/video/fbdev/hyperv_fb.c Dexuan Cui        2020-11-17  1055  	 * maps the VRAM cacheable.
5f1251a48c17b5 drivers/video/fbdev/hyperv_fb.c Dexuan Cui        2020-11-17  1056  	 */
5f1251a48c17b5 drivers/video/fbdev/hyperv_fb.c Dexuan Cui        2020-11-17  1057  	fb_virt = ioremap_cache(par->mem->start, screen_fb_size);
68a2d20b79b105 drivers/video/hyperv_fb.c       Haiyang Zhang     2013-04-29  1058  	if (!fb_virt)
68a2d20b79b105 drivers/video/hyperv_fb.c       Haiyang Zhang     2013-04-29  1059  		goto err2;
68a2d20b79b105 drivers/video/hyperv_fb.c       Haiyang Zhang     2013-04-29  1060  
d21987d709e807 drivers/video/fbdev/hyperv_fb.c Wei Hu            2019-09-18  1061  	/* Allocate memory for deferred IO */
d21987d709e807 drivers/video/fbdev/hyperv_fb.c Wei Hu            2019-09-18  1062  	par->dio_vp = vzalloc(round_up(dio_fb_size, PAGE_SIZE));
d21987d709e807 drivers/video/fbdev/hyperv_fb.c Wei Hu            2019-09-18  1063  	if (par->dio_vp == NULL)
d21987d709e807 drivers/video/fbdev/hyperv_fb.c Wei Hu            2019-09-18  1064  		goto err3;
d21987d709e807 drivers/video/fbdev/hyperv_fb.c Wei Hu            2019-09-18  1065  
d21987d709e807 drivers/video/fbdev/hyperv_fb.c Wei Hu            2019-09-18  1066  	/* Physical address of FB device */
d21987d709e807 drivers/video/fbdev/hyperv_fb.c Wei Hu            2019-09-18  1067  	par->mmio_pp = par->mem->start;
d21987d709e807 drivers/video/fbdev/hyperv_fb.c Wei Hu            2019-09-18  1068  	/* Virtual address of FB device */
d21987d709e807 drivers/video/fbdev/hyperv_fb.c Wei Hu            2019-09-18  1069  	par->mmio_vp = (unsigned char *) fb_virt;
d21987d709e807 drivers/video/fbdev/hyperv_fb.c Wei Hu            2019-09-18  1070  
3546448338e76a drivers/video/fbdev/hyperv_fb.c Jake Oshins       2015-08-05  1071  	info->fix.smem_start = par->mem->start;
d21987d709e807 drivers/video/fbdev/hyperv_fb.c Wei Hu            2019-09-18  1072  	info->fix.smem_len = dio_fb_size;
d21987d709e807 drivers/video/fbdev/hyperv_fb.c Wei Hu            2019-09-18  1073  	info->screen_base = par->dio_vp;
d21987d709e807 drivers/video/fbdev/hyperv_fb.c Wei Hu            2019-09-18  1074  	info->screen_size = dio_fb_size;
68a2d20b79b105 drivers/video/hyperv_fb.c       Haiyang Zhang     2013-04-29  1075  
3a6fb6c4255c38 drivers/video/fbdev/hyperv_fb.c Wei Hu            2019-12-09  1076  getmem_done:
5fbcc6708fe32e drivers/video/fbdev/hyperv_fb.c Daniel Vetter     2023-04-06 @1077  	aperture_remove_conflicting_devices(base, size, KBUILD_MODNAME);
3cb73bc3fa2a3c drivers/video/fbdev/hyperv_fb.c Kairui Song       2020-10-14  1078  
a07b50d80ab621 drivers/video/fbdev/hyperv_fb.c Arnd Bergmann     2023-10-09  1079  	if (!gen2vm) {
a07b50d80ab621 drivers/video/fbdev/hyperv_fb.c Arnd Bergmann     2023-10-09  1080  		pci_dev_put(pdev);
a07b50d80ab621 drivers/video/fbdev/hyperv_fb.c Arnd Bergmann     2023-10-09  1081  	} else if (IS_ENABLED(CONFIG_SYSFB)) {
3cb73bc3fa2a3c drivers/video/fbdev/hyperv_fb.c Kairui Song       2020-10-14  1082  		/* framebuffer is reallocated, clear screen_info to avoid misuse from kexec */
3cb73bc3fa2a3c drivers/video/fbdev/hyperv_fb.c Kairui Song       2020-10-14  1083  		screen_info.lfb_size = 0;
3cb73bc3fa2a3c drivers/video/fbdev/hyperv_fb.c Kairui Song       2020-10-14  1084  		screen_info.lfb_base = 0;
3cb73bc3fa2a3c drivers/video/fbdev/hyperv_fb.c Kairui Song       2020-10-14  1085  		screen_info.orig_video_isVGA = 0;
3cb73bc3fa2a3c drivers/video/fbdev/hyperv_fb.c Kairui Song       2020-10-14  1086  	}
9069fd54960304 drivers/video/hyperv_fb.c       Gerd Hoffmann     2014-02-26  1087  
68a2d20b79b105 drivers/video/hyperv_fb.c       Haiyang Zhang     2013-04-29  1088  	return 0;
68a2d20b79b105 drivers/video/hyperv_fb.c       Haiyang Zhang     2013-04-29  1089  
68a2d20b79b105 drivers/video/hyperv_fb.c       Haiyang Zhang     2013-04-29  1090  err3:
68a2d20b79b105 drivers/video/hyperv_fb.c       Haiyang Zhang     2013-04-29  1091  	iounmap(fb_virt);
68a2d20b79b105 drivers/video/hyperv_fb.c       Haiyang Zhang     2013-04-29  1092  err2:
696ca5e82c057a drivers/video/fbdev/hyperv_fb.c Jake Oshins       2016-04-05  1093  	vmbus_free_mmio(par->mem->start, screen_fb_size);
3546448338e76a drivers/video/fbdev/hyperv_fb.c Jake Oshins       2015-08-05  1094  	par->mem = NULL;
68a2d20b79b105 drivers/video/hyperv_fb.c       Haiyang Zhang     2013-04-29  1095  err1:
9069fd54960304 drivers/video/hyperv_fb.c       Gerd Hoffmann     2014-02-26  1096  	if (!gen2vm)
68a2d20b79b105 drivers/video/hyperv_fb.c       Haiyang Zhang     2013-04-29  1097  		pci_dev_put(pdev);
9069fd54960304 drivers/video/hyperv_fb.c       Gerd Hoffmann     2014-02-26  1098  
68a2d20b79b105 drivers/video/hyperv_fb.c       Haiyang Zhang     2013-04-29  1099  	return -ENOMEM;
68a2d20b79b105 drivers/video/hyperv_fb.c       Haiyang Zhang     2013-04-29  1100  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

