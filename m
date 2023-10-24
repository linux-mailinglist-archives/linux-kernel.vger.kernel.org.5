Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 246907D4E36
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 12:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234287AbjJXKqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 06:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234315AbjJXKqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 06:46:43 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E8DD7E
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 03:46:39 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40839652b97so33786675e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 03:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698144398; x=1698749198; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0SpGzt5EPQBKeC5ysJFqlAOyND1HqZsJcmX27vUekos=;
        b=IiCW4XiUdZSNPzBj7xCjxINtjZMTVW1jjz1jTf0RozZ+lxMDFdd0bsZ/nhLk/dE6JA
         FP0/GPOCh6gU3Wwuc1tb6RdmZNB9+3hML8y4ENN/E3jfDKSPwCc9PDVDT2nvmmYISdEW
         NXTkcqIDcNwkJ9hrgLrQZvFd7fzSM51mQ82Rk2BurgDfksTNmSr4cItQ+wK0xfNFx/Aa
         X1UQvmtLvGPXBuM3RPO/eRCSQ+n2IXOvVDW/9VsTuiGmKuyB96yxkFvgt6ey1XS4eF5z
         F0rXsnlj6S5Jbtpk0Inpwc5u9HFii68Sc9ExQK/8aKdtzXtgc/D5tK7uREG9Imcq+sjy
         PMSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698144398; x=1698749198;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0SpGzt5EPQBKeC5ysJFqlAOyND1HqZsJcmX27vUekos=;
        b=op1WDLy9BWmCppVrZjRGAk2Nf0Zu+auwoCGfdV2R3Le3HKsfjA1FaObfz1h2lBA0zp
         F5DHEhb6Gyq6yVO+tEMx23m8avmrfiSFVcMZ4j3fy6rZAxJiiP4NJX+niJ7jpsrnZ/kn
         hjthzDc/seZcVr4VEyY3LBMsCzO62W7W1J9xI6a0YJ1H4CtyM6VUGM8aQb04vJ0uWPVE
         bn4n2tj3eWd9ZZlsCzSHDujpEE0H/b9/jQoj5z1BDpWyjjt188XF/XEPMnq9Erl9hUav
         xOhC4UjIJjvvE0CRcSeV9/NNYxT08Nhfof8SpI67jJDQcX6t5kcFg4lvPNRQXhtrtcwH
         bZ0w==
X-Gm-Message-State: AOJu0YwgnqUkZVw4cBgrQVRkjZBGEKW3zIATooqNnTY+z3Xo4lFDMfrM
        p69ntS1j1stntvg29X2/4L9yhA==
X-Google-Smtp-Source: AGHT+IFal9H1jvC4Q3PK0I2LyrVEO/TLp7BWA+0hdBEGG9xbWftlWywwFOwOKjSW9JtgKcK+ozdIAQ==
X-Received: by 2002:a05:600c:19d1:b0:405:3955:5881 with SMTP id u17-20020a05600c19d100b0040539555881mr9060319wmq.36.1698144397131;
        Tue, 24 Oct 2023 03:46:37 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id e23-20020adf9bd7000000b0032d893d8dc8sm9757680wrc.2.2023.10.24.03.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 03:46:36 -0700 (PDT)
Date:   Tue, 24 Oct 2023 13:46:33 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     oe-kbuild@lists.linux.dev, Manas Ghandat <ghandatmanas@gmail.com>,
        dave.kleikamp@oracle.com, shaggy@kernel.org
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        Manas Ghandat <ghandatmanas@gmail.com>,
        Linux-kernel-mentees@lists.linuxfoundation.org,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        syzbot+9924e2a08d9ba0fd4ce2@syzkaller.appspotmail.com
Subject: Re: [PATCH] jfs: fix slab-out-of-bounds Read in dtSearch
Message-ID: <f5a9e854-5b6c-49bd-9888-525906665966@kadam.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016171130.15952-1-ghandatmanas@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Manas,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Manas-Ghandat/jfs-fix-slab-out-of-bounds-Read-in-dtSearch/20231017-152500
base:   https://github.com/kleikamp/linux-shaggy jfs-next
patch link:    https://lore.kernel.org/r/20231016171130.15952-1-ghandatmanas%40gmail.com
patch subject: [PATCH] jfs: fix slab-out-of-bounds Read in dtSearch
config: i386-randconfig-141-20231022 (https://download.01.org/0day-ci/archive/20231024/202310241724.Ed02yUz9-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231024/202310241724.Ed02yUz9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202310241724.Ed02yUz9-lkp@intel.com/

smatch warnings:
fs/jfs/jfs_dtree.c:636 dtSearch() warn: impossible condition '(stbl[index] > 128) => ((-128)-127 > 128)'

vim +636 fs/jfs/jfs_dtree.c

^1da177e4c3f41 Linus Torvalds   2005-04-16  567  int dtSearch(struct inode *ip, struct component_name * key, ino_t * data,
^1da177e4c3f41 Linus Torvalds   2005-04-16  568  	     struct btstack * btstack, int flag)
^1da177e4c3f41 Linus Torvalds   2005-04-16  569  {
^1da177e4c3f41 Linus Torvalds   2005-04-16  570  	int rc = 0;
^1da177e4c3f41 Linus Torvalds   2005-04-16  571  	int cmp = 1;		/* init for empty page */
^1da177e4c3f41 Linus Torvalds   2005-04-16  572  	s64 bn;
^1da177e4c3f41 Linus Torvalds   2005-04-16  573  	struct metapage *mp;
^1da177e4c3f41 Linus Torvalds   2005-04-16  574  	dtpage_t *p;
^1da177e4c3f41 Linus Torvalds   2005-04-16  575  	s8 *stbl;
                                                        ^^^^^^^^

^1da177e4c3f41 Linus Torvalds   2005-04-16  576  	int base, index, lim;
^1da177e4c3f41 Linus Torvalds   2005-04-16  577  	struct btframe *btsp;
^1da177e4c3f41 Linus Torvalds   2005-04-16  578  	pxd_t *pxd;
^1da177e4c3f41 Linus Torvalds   2005-04-16  579  	int psize = 288;	/* initial in-line directory */
^1da177e4c3f41 Linus Torvalds   2005-04-16  580  	ino_t inumber;
^1da177e4c3f41 Linus Torvalds   2005-04-16  581  	struct component_name ciKey;
^1da177e4c3f41 Linus Torvalds   2005-04-16  582  	struct super_block *sb = ip->i_sb;
^1da177e4c3f41 Linus Torvalds   2005-04-16  583  
6da2ec56059c3c Kees Cook        2018-06-12  584  	ciKey.name = kmalloc_array(JFS_NAME_MAX + 1, sizeof(wchar_t),
6da2ec56059c3c Kees Cook        2018-06-12  585  				   GFP_NOFS);
09aaa749f637b1 Joe Perches      2007-11-13  586  	if (!ciKey.name) {
^1da177e4c3f41 Linus Torvalds   2005-04-16  587  		rc = -ENOMEM;
^1da177e4c3f41 Linus Torvalds   2005-04-16  588  		goto dtSearch_Exit2;
^1da177e4c3f41 Linus Torvalds   2005-04-16  589  	}
^1da177e4c3f41 Linus Torvalds   2005-04-16  590  
^1da177e4c3f41 Linus Torvalds   2005-04-16  591  
^1da177e4c3f41 Linus Torvalds   2005-04-16  592  	/* uppercase search key for c-i directory */
^1da177e4c3f41 Linus Torvalds   2005-04-16  593  	UniStrcpy(ciKey.name, key->name);
^1da177e4c3f41 Linus Torvalds   2005-04-16  594  	ciKey.namlen = key->namlen;
^1da177e4c3f41 Linus Torvalds   2005-04-16  595  
^1da177e4c3f41 Linus Torvalds   2005-04-16  596  	/* only uppercase if case-insensitive support is on */
^1da177e4c3f41 Linus Torvalds   2005-04-16  597  	if ((JFS_SBI(sb)->mntflag & JFS_OS2) == JFS_OS2) {
^1da177e4c3f41 Linus Torvalds   2005-04-16  598  		ciToUpper(&ciKey);
^1da177e4c3f41 Linus Torvalds   2005-04-16  599  	}
^1da177e4c3f41 Linus Torvalds   2005-04-16  600  	BT_CLR(btstack);	/* reset stack */
^1da177e4c3f41 Linus Torvalds   2005-04-16  601  
^1da177e4c3f41 Linus Torvalds   2005-04-16  602  	/* init level count for max pages to split */
^1da177e4c3f41 Linus Torvalds   2005-04-16  603  	btstack->nsplit = 1;
^1da177e4c3f41 Linus Torvalds   2005-04-16  604  
^1da177e4c3f41 Linus Torvalds   2005-04-16  605  	/*
^1da177e4c3f41 Linus Torvalds   2005-04-16  606  	 *	search down tree from root:
^1da177e4c3f41 Linus Torvalds   2005-04-16  607  	 *
^1da177e4c3f41 Linus Torvalds   2005-04-16  608  	 * between two consecutive entries of <Ki, Pi> and <Kj, Pj> of
^1da177e4c3f41 Linus Torvalds   2005-04-16  609  	 * internal page, child page Pi contains entry with k, Ki <= K < Kj.
^1da177e4c3f41 Linus Torvalds   2005-04-16  610  	 *
^1da177e4c3f41 Linus Torvalds   2005-04-16  611  	 * if entry with search key K is not found
^1da177e4c3f41 Linus Torvalds   2005-04-16  612  	 * internal page search find the entry with largest key Ki
^1da177e4c3f41 Linus Torvalds   2005-04-16  613  	 * less than K which point to the child page to search;
^1da177e4c3f41 Linus Torvalds   2005-04-16  614  	 * leaf page search find the entry with smallest key Kj
^1da177e4c3f41 Linus Torvalds   2005-04-16  615  	 * greater than K so that the returned index is the position of
^1da177e4c3f41 Linus Torvalds   2005-04-16  616  	 * the entry to be shifted right for insertion of new entry.
^1da177e4c3f41 Linus Torvalds   2005-04-16  617  	 * for empty tree, search key is greater than any key of the tree.
^1da177e4c3f41 Linus Torvalds   2005-04-16  618  	 *
^1da177e4c3f41 Linus Torvalds   2005-04-16  619  	 * by convention, root bn = 0.
^1da177e4c3f41 Linus Torvalds   2005-04-16  620  	 */
^1da177e4c3f41 Linus Torvalds   2005-04-16  621  	for (bn = 0;;) {
^1da177e4c3f41 Linus Torvalds   2005-04-16  622  		/* get/pin the page to search */
^1da177e4c3f41 Linus Torvalds   2005-04-16  623  		DT_GETPAGE(ip, bn, mp, psize, p, rc);
^1da177e4c3f41 Linus Torvalds   2005-04-16  624  		if (rc)
^1da177e4c3f41 Linus Torvalds   2005-04-16  625  			goto dtSearch_Exit1;
^1da177e4c3f41 Linus Torvalds   2005-04-16  626  
^1da177e4c3f41 Linus Torvalds   2005-04-16  627  		/* get sorted entry table of the page */
^1da177e4c3f41 Linus Torvalds   2005-04-16  628  		stbl = DT_GETSTBL(p);
^1da177e4c3f41 Linus Torvalds   2005-04-16  629  
^1da177e4c3f41 Linus Torvalds   2005-04-16  630  		/*
^1da177e4c3f41 Linus Torvalds   2005-04-16  631  		 * binary search with search key K on the current page.
^1da177e4c3f41 Linus Torvalds   2005-04-16  632  		 */
^1da177e4c3f41 Linus Torvalds   2005-04-16  633  		for (base = 0, lim = p->header.nextindex; lim; lim >>= 1) {
^1da177e4c3f41 Linus Torvalds   2005-04-16  634  			index = base + (lim >> 1);
^1da177e4c3f41 Linus Torvalds   2005-04-16  635  
7812e358b5edde Manas Ghandat    2023-10-16 @636  			if (stbl[index] > 128 || stbl[index] < 0)

If it's stbl is an s8 so it can't be > 128.

7812e358b5edde Manas Ghandat    2023-10-16  637  				goto out;
7812e358b5edde Manas Ghandat    2023-10-16  638  
^1da177e4c3f41 Linus Torvalds   2005-04-16  639  			if (p->header.flag & BT_LEAF) {
^1da177e4c3f41 Linus Torvalds   2005-04-16  640  				/* uppercase leaf name to compare */
^1da177e4c3f41 Linus Torvalds   2005-04-16  641  				cmp =
^1da177e4c3f41 Linus Torvalds   2005-04-16  642  				    ciCompare(&ciKey, p, stbl[index],
^1da177e4c3f41 Linus Torvalds   2005-04-16  643  					      JFS_SBI(sb)->mntflag);
^1da177e4c3f41 Linus Torvalds   2005-04-16  644  			} else {
^1da177e4c3f41 Linus Torvalds   2005-04-16  645  				/* router key is in uppercase */
^1da177e4c3f41 Linus Torvalds   2005-04-16  646  
^1da177e4c3f41 Linus Torvalds   2005-04-16  647  				cmp = dtCompare(&ciKey, p, stbl[index]);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

