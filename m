Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6AD279DD31
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 02:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237934AbjIMAi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 20:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232115AbjIMAiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 20:38:55 -0400
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B55B1706
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 17:38:51 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VryHc6B_1694565526;
Received: from 192.168.3.4(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VryHc6B_1694565526)
          by smtp.aliyun-inc.com;
          Wed, 13 Sep 2023 08:38:48 +0800
Message-ID: <7f11496e-ef18-1dcd-bd85-68663531f50d@linux.alibaba.com>
Date:   Wed, 13 Sep 2023 08:38:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: kernel BUG in erofs_iget
To:     Sanan Hasanov <Sanan.Hasanov@ucf.edu>,
        "xiang@kernel.org" <xiang@kernel.org>,
        "chao@kernel.org" <chao@kernel.org>,
        "huyue2@coolpad.com" <huyue2@coolpad.com>,
        "jefflexu@linux.alibaba.com" <jefflexu@linux.alibaba.com>,
        "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "syzkaller@googlegroups.com" <syzkaller@googlegroups.com>,
        "contact@pgazz.com" <contact@pgazz.com>
References: <BL0PR11MB3106CA52AA8E2978AF2756B6E1EEA@BL0PR11MB3106.namprd11.prod.outlook.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <BL0PR11MB3106CA52AA8E2978AF2756B6E1EEA@BL0PR11MB3106.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/9/13 07:02, Sanan Hasanov wrote:
> Good day, dear maintainers,
> 
> We found a bug using a modified kernel configuration file used by syzbot.
> 
> We enhanced the coverage of the configuration file using our tool, klocalizer.

1) Please don't enable CONFIG_EROFS_FS_DEBUG=y when fuzzing.  This configuration
    is just for developper debugging, not for daily use or fuzzing.

2) Please don't use random -next version, I don't even find this version in
    https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/refs/tags
    now.  Although it seems

198 bogusimode:
199 	erofs_err(inode->i_sb, "bogus i_mode (%o) @ nid %llu",
200 		  inode->i_mode, vi->nid);
201 	err = -EFSCORRUPTED;
202 err_out:
203>	DBG_BUGON(1);
204 	kfree(copied);
205 	erofs_put_metabuf(buf);
206 	return ERR_PTR(err);

    when I check Linux v6.3 source code.  Please use upstream or latest tree for
    fuzzing, thanks!

Thanks,
Gao Xiang

> 
> Kernel Branch: 6.3.0-next-20230426
> Kernel Config: https://drive.google.com/file/d/1rGIKWTEfoMed0JL5jWFws4GJ0VNSVgw8/view?usp=sharing
> Reproducer: https://drive.google.com/file/d/1ceAFcx9hhevq_ivDNPkXmEGYsr26yB4N/view?usp=sharing
> Thank you!
> 
> Best regards,
> Sanan Hasanov
> 
