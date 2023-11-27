Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3B47F9BF6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 09:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232536AbjK0In3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 03:43:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232397AbjK0In1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 03:43:27 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976FEE1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 00:43:33 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-32f737deedfso2395718f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 00:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701074612; x=1701679412; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2xnOF1CxvID+dtjKdZtlw3NSe8y8zSJxuj2ZIPYY3uU=;
        b=g4Wbg/OtayEgRhrO/Daxjnxmw074IbzCWAAjMvb1N5dxQS/UwJoJjDgiF1ZddZG0Wq
         Kah/SOH5vHMdoks5mNica5BvV4cJDXq3OunWuQa6psVzKfPPDo5xR/t/3+cME0l+Bix/
         wr3SgQkuXMVvN8F9xZe5LnR4YqZL0zG0raaKS/C203yvCVYrkGW824gD/dsu7/cdlH8M
         B7QRns+W3lPwY8v1TokEoj21EHg8rnWc6THz+m0GFas/iZnTNqajItKX58O14P3U8P5z
         8mdZep3wpqfUMUHuquYehO5YqhpQzmJkSn5pJzBqIoKBgLKUqxYGzYvwBUM2H7qpK/6F
         Ybgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701074612; x=1701679412;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2xnOF1CxvID+dtjKdZtlw3NSe8y8zSJxuj2ZIPYY3uU=;
        b=rT/Mz7loBntFO/CdFui6PYE8jaQfWt0VeKp8CJjdFfzTDJeFkZ0FInFjKFr1SHhOMk
         75Hwu1efDZDCfbk/9Xe139/71Wl+sMSs07ShtTwIh4Iuv9OG+6iWiBQIZ7CP5xXIhEJ4
         KaebZUZoO9lnckRe+flLDs0/xK0/gt6Hdwn1v5IZs9Abp1utim9g3KRe52REVeZX810z
         ZduSQXikuioIryHm/TL/oYJ5IhDqZlEBU0dq25zERFBESaQ83PKcvemtujX0RPM5S+Ye
         Ngtl1sCY6TcrJYI6pRMCCpqBuyYYfHrcsZCWLnAmtiNkDTDt8hRNnweTXMxcEJZDIWmE
         AmDw==
X-Gm-Message-State: AOJu0Yya1WdHXh16mVAJIRa77ctx350yJox1SBRlhfvN1Kr2PA31ij0P
        Hp1isGBFU3NQcoGcPt5o2e4Oeg==
X-Google-Smtp-Source: AGHT+IEk54NjVWopu9izapGPvppfJzH7fiDJYjBKBIuzRtGaobPqV2lbJB4Y3jcA3sJh2RPzNIxL/A==
X-Received: by 2002:a5d:4f8c:0:b0:332:ca1a:c3a0 with SMTP id d12-20020a5d4f8c000000b00332ca1ac3a0mr7700858wru.52.1701074612004;
        Mon, 27 Nov 2023 00:43:32 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id e15-20020a5d594f000000b00332fda15055sm3362220wri.111.2023.11.27.00.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 00:43:31 -0800 (PST)
From:   Dan Carpenter <dan.carpenter@linaro.org>
X-Google-Original-From: Dan Carpenter <dan.carpenter@oracle.com>
Date:   Mon, 27 Nov 2023 11:43:29 +0300
To:     oe-kbuild@lists.linux.dev, Ivan Vecera <ivecera@redhat.com>,
        intel-wired-lan@lists.osuosl.org
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        Jacob Keller <jacob.e.keller@intel.com>,
        Wojciech Drewek <wojciech.drewek@intel.com>,
        Simon Horman <horms@kernel.org>, mschmidt@redhat.com,
        netdev@vger.kernel.org
Subject: Re: [PATCH v5 4/5] i40e: Fix broken support for floating VEBs
Message-ID: <25111205-a895-46a2-b53f-49e29ba41b16@suswa.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124150343.81520-5-ivecera@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ivan,

kernel test robot noticed the following build warnings:

url:    https://github.com/intel-lab-lkp/linux/commits/Ivan-Vecera/i40e-Use-existing-helper-to-find-flow-director-VSI/20231124-230616
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
patch link:    https://lore.kernel.org/r/20231124150343.81520-5-ivecera%40redhat.com
patch subject: [PATCH v5 4/5] i40e: Fix broken support for floating VEBs
config: x86_64-randconfig-161-20231127 (https://download.01.org/0day-ci/archive/20231127/202311270851.Ie6aegcS-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce: (https://download.01.org/0day-ci/archive/20231127/202311270851.Ie6aegcS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>
| Closes: https://lore.kernel.org/r/202311270851.Ie6aegcS-lkp@intel.com/

New smatch warnings:
drivers/net/ethernet/intel/i40e/i40e_main.c:14743 i40e_veb_release() error: potentially dereferencing uninitialized 'vsi'.

Old smatch warnings:
[ low confidence ]
drivers/net/ethernet/intel/i40e/i40e_main.c:5966 i40e_set_bw_limit() warn: error code type promoted to positive: 'speed'
drivers/net/ethernet/intel/i40e/i40e_main.c:13476 i40e_queue_pair_toggle_rings() warn: missing error code? 'ret'
drivers/net/ethernet/intel/i40e/i40e_main.c:14272 i40e_vsi_setup_vectors() warn: missing error code? 'ret'
drivers/net/ethernet/intel/i40e/i40e_main.c:15566 i40e_init_recovery_mode() warn: 'vsi->netdev' from register_netdev() not released on lines: 15566.

vim +/vsi +14743 drivers/net/ethernet/intel/i40e/i40e_main.c

41c445ff0f482bb Jesse Brandeburg 2013-09-11  14715  void i40e_veb_release(struct i40e_veb *veb)
41c445ff0f482bb Jesse Brandeburg 2013-09-11  14716  {
0aab77d67d37d09 Ivan Vecera      2023-11-24  14717  	struct i40e_vsi *vsi, *vsi_it;
41c445ff0f482bb Jesse Brandeburg 2013-09-11  14718  	struct i40e_pf *pf;
41c445ff0f482bb Jesse Brandeburg 2013-09-11  14719  	int i, n = 0;
41c445ff0f482bb Jesse Brandeburg 2013-09-11  14720  
41c445ff0f482bb Jesse Brandeburg 2013-09-11  14721  	pf = veb->pf;
41c445ff0f482bb Jesse Brandeburg 2013-09-11  14722  
41c445ff0f482bb Jesse Brandeburg 2013-09-11  14723  	/* find the remaining VSI and check for extras */
0aab77d67d37d09 Ivan Vecera      2023-11-24  14724  	i40e_pf_for_each_vsi(pf, i, vsi_it)
0aab77d67d37d09 Ivan Vecera      2023-11-24  14725  		if (vsi_it->uplink_seid == veb->seid) {
93a1bc91a1ccc5a Ivan Vecera      2023-11-24  14726  			if (vsi_it->flags & I40E_VSI_FLAG_VEB_OWNER)
0aab77d67d37d09 Ivan Vecera      2023-11-24  14727  				vsi = vsi_it;

Do we always find a vsi?  Presumably, yes, but it's not obvious just
from reading this function.

41c445ff0f482bb Jesse Brandeburg 2013-09-11  14728  			n++;
41c445ff0f482bb Jesse Brandeburg 2013-09-11  14729  		}
0aab77d67d37d09 Ivan Vecera      2023-11-24  14730  
93a1bc91a1ccc5a Ivan Vecera      2023-11-24  14731  	/* Floating VEB has to be empty and regular one must have
93a1bc91a1ccc5a Ivan Vecera      2023-11-24  14732  	 * single owner VSI.
93a1bc91a1ccc5a Ivan Vecera      2023-11-24  14733  	 */
93a1bc91a1ccc5a Ivan Vecera      2023-11-24  14734  	if ((veb->uplink_seid && n != 1) || (!veb->uplink_seid && n != 0)) {
41c445ff0f482bb Jesse Brandeburg 2013-09-11  14735  		dev_info(&pf->pdev->dev,
41c445ff0f482bb Jesse Brandeburg 2013-09-11  14736  			 "can't remove VEB %d with %d VSIs left\n",
41c445ff0f482bb Jesse Brandeburg 2013-09-11  14737  			 veb->seid, n);
41c445ff0f482bb Jesse Brandeburg 2013-09-11  14738  		return;
41c445ff0f482bb Jesse Brandeburg 2013-09-11  14739  	}
41c445ff0f482bb Jesse Brandeburg 2013-09-11  14740  
93a1bc91a1ccc5a Ivan Vecera      2023-11-24  14741  	/* For regular VEB move the owner VSI to uplink VEB */
41c445ff0f482bb Jesse Brandeburg 2013-09-11  14742  	if (veb->uplink_seid) {
93a1bc91a1ccc5a Ivan Vecera      2023-11-24 @14743  		vsi->flags &= ~I40E_VSI_FLAG_VEB_OWNER;
                                                                ^^^^^^^^^^

41c445ff0f482bb Jesse Brandeburg 2013-09-11  14744  		vsi->uplink_seid = veb->uplink_seid;
41c445ff0f482bb Jesse Brandeburg 2013-09-11  14745  		if (veb->uplink_seid == pf->mac_seid)
41c445ff0f482bb Jesse Brandeburg 2013-09-11  14746  			vsi->veb_idx = I40E_NO_VEB;
41c445ff0f482bb Jesse Brandeburg 2013-09-11  14747  		else
41c445ff0f482bb Jesse Brandeburg 2013-09-11  14748  			vsi->veb_idx = veb->veb_idx;
41c445ff0f482bb Jesse Brandeburg 2013-09-11  14749  	}
41c445ff0f482bb Jesse Brandeburg 2013-09-11  14750  
41c445ff0f482bb Jesse Brandeburg 2013-09-11  14751  	i40e_aq_delete_element(&pf->hw, veb->seid, NULL);
41c445ff0f482bb Jesse Brandeburg 2013-09-11  14752  	i40e_veb_clear(veb);
41c445ff0f482bb Jesse Brandeburg 2013-09-11  14753  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

