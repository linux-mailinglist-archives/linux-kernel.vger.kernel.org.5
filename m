Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA197F88BD
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 08:09:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjKYHJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 02:09:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjKYHJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 02:09:32 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B54BE4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 23:09:38 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-32df66c691dso1655664f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 23:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700896177; x=1701500977; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l28nPCY+SAtqZErjqKxwLI+uxldxRGepvabK0i7Qt8w=;
        b=CJ7SFwwvxcvYkaiztQOrvHQ09o2i+f9xsIqMBn2Sl5FsE5+usIe8M37n+9lrUCysv6
         jFmXmiKhTnRrGRmNzZ0HapbXHbF9TThyuDWjBTWgXPF/yWeYym6BZGfLi6FGt6n09MDi
         UuEJt5LeKWVg7JG1MCfBVLBUBxHZPqdTa2r2i4xuag+wGVaZ123hq3/OFiPCdpVwGmJI
         9FEZr+HOuhfAMH7qjYRsF79C06vje6KHNoeT2zTQGtOMd2gQJgtA8qNs5WjccC0HZSmg
         fzwIcnmjtTVEkIziKjN7lJKcDy5SURIqDrJLf42oND2oOtSsKd+MVRAem2ZMc34XGn7N
         P3RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700896177; x=1701500977;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l28nPCY+SAtqZErjqKxwLI+uxldxRGepvabK0i7Qt8w=;
        b=qXzxAXEgj8LNiDh9o31uQGV9hgmPPxNIyfSM1qylIgYbtDB3cj8fPVwZ1FAZtCaFTJ
         tW4Fsc3Hai5OpwLN2A/Ug8nSHMhtK2nGVxaiGNdCmBsrxuIPJAY1WEatC4FGC/8P2w0C
         Zlkj44O5qnWyQe/s/JzL9GhK9oik6FCWaapvRHCpLCFfVWZzlP/QJ8CDwzZu/wmDrx17
         Es2lppwEOHmEgpHDs0RsPczh5z4WSV44P4K6U8Nwamew6B/1uUt6KdyJKOxyyTAp9uvx
         K0QYQwv/1YBW9211ixqDKUnkSIw/mvAhQ84YGPxs71gi++EU1ezYZ9dLWtlrqk6Cp51q
         fhAw==
X-Gm-Message-State: AOJu0Yx85M4aYcFCo3IUqreTLdQB0h7KuvLytvuVzT0P7e6//svP8COl
        DRdbvlFppHZJan6VbbkB/exA4Q==
X-Google-Smtp-Source: AGHT+IGbX+/0+xxVe33YypZWvA9tEzZb+x2LgjWVLPHq/KeYkKUGzVvy4CKt+gMnKd85VpIHoUNuHg==
X-Received: by 2002:a05:6000:b4c:b0:32f:7bde:fa0 with SMTP id dk12-20020a0560000b4c00b0032f7bde0fa0mr4518355wrb.32.1700896176676;
        Fri, 24 Nov 2023 23:09:36 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id z12-20020a5d640c000000b00332cc7c3aaasm6014498wru.21.2023.11.24.23.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 23:09:36 -0800 (PST)
From:   Dan Carpenter <dan.carpenter@linaro.org>
X-Google-Original-From: Dan Carpenter <dan.carpenter@oracle.com>
Date:   Sat, 25 Nov 2023 10:09:33 +0300
To:     oe-kbuild@lists.linux.dev,
        Ekansh Gupta <quic_ekangupt@quicinc.com>,
        srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 5/5] misc: fastrpc: Add support to allocate shared
 context bank
Message-ID: <e3b1912b-9c6a-487c-aba9-3f630eaf62fd@suswa.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121094844.5764-6-quic_ekangupt@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ekansh,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ekansh-Gupta/misc-fastrpc-Add-fastrpc-multimode-invoke-request-support/20231121-175147
base:   linus/master
patch link:    https://lore.kernel.org/r/20231121094844.5764-6-quic_ekangupt%40quicinc.com
patch subject: [PATCH v7 5/5] misc: fastrpc: Add support to allocate shared context bank
config: arm-randconfig-r081-20231123 (https://download.01.org/0day-ci/archive/20231125/202311250922.W9tgrGT9-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231125/202311250922.W9tgrGT9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>
| Closes: https://lore.kernel.org/r/202311250922.W9tgrGT9-lkp@intel.com/

New smatch warnings:
drivers/misc/fastrpc.c:1621 fastrpc_init_create_process() warn: missing unwind goto?

vim +1621 drivers/misc/fastrpc.c

d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1576  static int fastrpc_init_create_process(struct fastrpc_user *fl,
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1577  					char __user *argp)
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1578  {
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1579  	struct fastrpc_init_create init;
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1580  	struct fastrpc_invoke_args *args;
becdceed7669e5 Ekansh Gupta             2023-11-21  1581  	struct fastrpc_enhanced_invoke ioctl;
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1582  	struct fastrpc_phy_page pages[1];
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1583  	struct fastrpc_map *map = NULL;
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1584  	struct fastrpc_buf *imem = NULL;
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1585  	int memlen;
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1586  	int err;
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1587  	struct {
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1588  		int pgid;
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1589  		u32 namelen;
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1590  		u32 filelen;
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1591  		u32 pageslen;
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1592  		u32 attrs;
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1593  		u32 siglen;
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1594  	} inbuf;
7f1f481263c3ce Jeya R                   2022-02-14  1595  	bool unsigned_module = false;
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1596  
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1597  	args = kcalloc(FASTRPC_CREATE_PROCESS_NARGS, sizeof(*args), GFP_KERNEL);
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1598  	if (!args)
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1599  		return -ENOMEM;
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1600  
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1601  	if (copy_from_user(&init, argp, sizeof(init))) {
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1602  		err = -EFAULT;
b49f6d83e290f1 Thierry Escande          2019-03-07  1603  		goto err;
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1604  	}
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1605  
7f1f481263c3ce Jeya R                   2022-02-14  1606  	if (init.attrs & FASTRPC_MODE_UNSIGNED_MODULE)
7f1f481263c3ce Jeya R                   2022-02-14  1607  		unsigned_module = true;
7f1f481263c3ce Jeya R                   2022-02-14  1608  
7f1f481263c3ce Jeya R                   2022-02-14  1609  	if (is_session_rejected(fl, unsigned_module)) {
7f1f481263c3ce Jeya R                   2022-02-14  1610  		err = -ECONNREFUSED;
7f1f481263c3ce Jeya R                   2022-02-14  1611  		goto err;
7f1f481263c3ce Jeya R                   2022-02-14  1612  	}
7f1f481263c3ce Jeya R                   2022-02-14  1613  
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1614  	if (init.filelen > INIT_FILELEN_MAX) {
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1615  		err = -EINVAL;
b49f6d83e290f1 Thierry Escande          2019-03-07  1616  		goto err;
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1617  	}
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1618  
92fe4bcba19c31 Ekansh Gupta             2023-11-21  1619  	fl->sctx = fastrpc_session_alloc(fl->cctx, fl->sharedcb);
92fe4bcba19c31 Ekansh Gupta             2023-11-21  1620  	if (!fl->sctx)
92fe4bcba19c31 Ekansh Gupta             2023-11-21 @1621  		return -EBUSY;

Should be "ret = -EBUSY; goto err;".

92fe4bcba19c31 Ekansh Gupta             2023-11-21  1622  
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1623  	inbuf.pgid = fl->tgid;
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1624  	inbuf.namelen = strlen(current->comm) + 1;
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1625  	inbuf.filelen = init.filelen;
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1626  	inbuf.pageslen = 1;
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1627  	inbuf.attrs = init.attrs;
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1628  	inbuf.siglen = init.siglen;
84195d206e1fbd Jonathan Marek           2020-09-08  1629  	fl->pd = USER_PD;
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1630  
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1631  	if (init.filelen && init.filefd) {
e90d911906196b Vamsi Krishna Gattupalli 2022-02-14  1632  		err = fastrpc_map_create(fl, init.filefd, init.filelen, 0, &map);
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1633  		if (err)
b49f6d83e290f1 Thierry Escande          2019-03-07  1634  			goto err;
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1635  	}
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1636  
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1637  	memlen = ALIGN(max(INIT_FILELEN_MAX, (int)init.filelen * 4),
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1638  		       1024 * 1024);
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1639  	err = fastrpc_buf_alloc(fl, fl->sctx->dev, memlen,
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1640  				&imem);
b49f6d83e290f1 Thierry Escande          2019-03-07  1641  	if (err)
b49f6d83e290f1 Thierry Escande          2019-03-07  1642  		goto err_alloc;
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1643  
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1644  	fl->init_mem = imem;
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1645  	args[0].ptr = (u64)(uintptr_t)&inbuf;
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1646  	args[0].length = sizeof(inbuf);
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1647  	args[0].fd = -1;
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1648  
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1649  	args[1].ptr = (u64)(uintptr_t)current->comm;
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1650  	args[1].length = inbuf.namelen;
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1651  	args[1].fd = -1;
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1652  
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1653  	args[2].ptr = (u64) init.file;
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1654  	args[2].length = inbuf.filelen;
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1655  	args[2].fd = init.filefd;
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1656  
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1657  	pages[0].addr = imem->phys;
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1658  	pages[0].size = imem->size;
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1659  
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1660  	args[3].ptr = (u64)(uintptr_t) pages;
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1661  	args[3].length = 1 * sizeof(*pages);
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1662  	args[3].fd = -1;
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1663  
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1664  	args[4].ptr = (u64)(uintptr_t)&inbuf.attrs;
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1665  	args[4].length = sizeof(inbuf.attrs);
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1666  	args[4].fd = -1;
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1667  
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1668  	args[5].ptr = (u64)(uintptr_t) &inbuf.siglen;
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1669  	args[5].length = sizeof(inbuf.siglen);
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1670  	args[5].fd = -1;
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1671  
becdceed7669e5 Ekansh Gupta             2023-11-21  1672  	ioctl.inv.handle = FASTRPC_INIT_HANDLE;
becdceed7669e5 Ekansh Gupta             2023-11-21  1673  	ioctl.inv.sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_CREATE, 4, 0);
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1674  	if (init.attrs)
becdceed7669e5 Ekansh Gupta             2023-11-21  1675  		ioctl.inv.sc = FASTRPC_SCALARS(FASTRPC_RMID_INIT_CREATE_ATTR, 4, 0);
e27748f5c08306 Ekansh Gupta             2023-11-21  1676  	ioctl.inv.args = (u64)args;
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1677  
becdceed7669e5 Ekansh Gupta             2023-11-21  1678  	err = fastrpc_internal_invoke(fl, true, &ioctl);
b49f6d83e290f1 Thierry Escande          2019-03-07  1679  	if (err)
b49f6d83e290f1 Thierry Escande          2019-03-07  1680  		goto err_invoke;
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1681  
b49f6d83e290f1 Thierry Escande          2019-03-07  1682  	kfree(args);
b49f6d83e290f1 Thierry Escande          2019-03-07  1683  
b49f6d83e290f1 Thierry Escande          2019-03-07  1684  	return 0;
b49f6d83e290f1 Thierry Escande          2019-03-07  1685  
b49f6d83e290f1 Thierry Escande          2019-03-07  1686  err_invoke:
b49f6d83e290f1 Thierry Escande          2019-03-07  1687  	fl->init_mem = NULL;
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1688  	fastrpc_buf_free(imem);
b49f6d83e290f1 Thierry Escande          2019-03-07  1689  err_alloc:
b49f6d83e290f1 Thierry Escande          2019-03-07  1690  	fastrpc_map_put(map);
b49f6d83e290f1 Thierry Escande          2019-03-07  1691  err:
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1692  	kfree(args);
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1693  
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1694  	return err;
d73f71c7c6ee15 Srinivas Kandagatla      2019-02-08  1695  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

