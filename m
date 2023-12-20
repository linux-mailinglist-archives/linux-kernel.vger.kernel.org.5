Return-Path: <linux-kernel+bounces-6965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E50819FE0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 14:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B891D1C2241A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 13:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59DE6358A4;
	Wed, 20 Dec 2023 13:34:56 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0812324B34;
	Wed, 20 Dec 2023 13:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R431e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0VyuUlv0_1703079283;
Received: from 30.221.130.111(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0VyuUlv0_1703079283)
          by smtp.aliyun-inc.com;
          Wed, 20 Dec 2023 21:34:44 +0800
Message-ID: <dc63027d-1caa-12d4-0078-42549f77078d@linux.alibaba.com>
Date: Wed, 20 Dec 2023 21:34:38 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net-next v8 00/10] net/smc: implement SMCv2.1 virtual ISM
 device support
To: wintera@linux.ibm.com, wenjia@linux.ibm.com, hca@linux.ibm.com,
 gor@linux.ibm.com, agordeev@linux.ibm.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 kgraul@linux.ibm.com, jaka@linux.ibm.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com,
 alibuda@linux.alibaba.com, tonylu@linux.alibaba.com, raspl@linux.ibm.com,
 schnelle@linux.ibm.com, guangguan.wang@linux.alibaba.com,
 linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20231219142616.80697-1-guwen@linux.alibaba.com>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <20231219142616.80697-1-guwen@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2023/12/19 22:26, Wen Gu wrote:
> The fourth edition of SMCv2 adds the SMC version 2.1 feature updates for
> SMC-Dv2 with virtual ISM. Virtual ISM are created and supported mainly by
> OS or hypervisor software, comparable to IBM ISM which is based on platform
> firmware or hardware.
> 
> With the introduction of virtual ISM, SMCv2.1 makes some updates:
> 
> - Introduce feature bitmask to indicate supplemental features.
> - Reserve a range of CHIDs for virtual ISM.
> - Support extended GIDs (128 bits) in CLC handshake.
> 
> So this patch set aims to implement these updates in Linux kernel. And it
> acts as the first part of SMC-D virtual ISM extension & loopback-ism [1].
> 
> [1] https://lore.kernel.org/netdev/1695568613-125057-1-git-send-email-guwen@linux.alibaba.com/
> 

Thank you very much for your valuable time and help in this and past versions, Sandy, Wenjia and Jan.



I guess there are only Patch #1 #5 #8 left now:

- Patch #1: Some minor changes in subject and fix the format issue
   (length exceeds 80 columns) compared to v3.
- Patch #5: removes useless ini->feature_mask assignment in __smc_connect()
   and smc_listen_v2_check() compared to v4.
- Patch #8: new added, compared to v3.

Looking forward to any feedback. Thanks. :)

Best regards,
Wen Gu

> v8->v7:
> - Patch #7: v7 mistakenly changed the type of gid_ext in
>    smc_clc_msg_accept_confirm to u64 instead of __be64 as previous versions
>    when fixing the rebase conflicts. So fix this mistake.
> 
> v7->v6:
> Link: https://lore.kernel.org/netdev/20231219084536.8158-1-guwen@linux.alibaba.com/
> - Collect the Reviewed-by tag in v6;
> - Patch #3: redefine the struct smc_clc_msg_accept_confirm;
> - Patch #7: Because that the Patch #3 already adds '__packed' to
>    smc_clc_msg_accept_confirm, so Patch #7 doesn't need to do the same thing.
>    But this is a minor change, so I kept the 'Reviewed-by' tag.
> 
> Other changes in previous versions but not yet acked:
> - Patch #1: Some minor changes in subject and fix the format issue
>    (length exceeds 80 columns) compared to v3.
> - Patch #5: removes useless ini->feature_mask assignment in __smc_connect()
>    and smc_listen_v2_check() compared to v4.
> - Patch #8: new added, compared to v3.
> 
> v6->v5:
> Link: https://lore.kernel.org/netdev/1702371151-125258-1-git-send-email-guwen@linux.alibaba.com/
> - Add 'Reviewed-by' label given in the previous versions:
>    * Patch #4, #6, #9, #10 have nothing changed since v3;
> - Patch #2:
>    * fix the format issue (Alignment should match open parenthesis) compared to v5;
>    * remove useless clc->hdr.length assignment in smcr_clc_prep_confirm_accept()
>      compared to v5;
> - Patch #3: new added compared to v5.
> - Patch #7: some minor changes like aclc_v2->aclc or clc_v2->clc compared to v5
>    due to the introduction of Patch #3. Since there were no major changes, I kept
>    the 'Reviewed-by' label.
> 
> Other changes in previous versions but not yet acked:
> - Patch #1: Some minor changes in subject and fix the format issue
>    (length exceeds 80 columns) compared to v3.
> - Patch #5: removes useless ini->feature_mask assignment in __smc_connect()
>    and smc_listen_v2_check() compared to v4.
> - Patch #8: new added, compared to v3.
> 
> v5->v4:
> Link: https://lore.kernel.org/netdev/1702021259-41504-1-git-send-email-guwen@linux.alibaba.com/
> - Patch #6: improve the comment of SMCD_CLC_MAX_V2_GID_ENTRIES;
> - Patch #4: remove useless ini->feature_mask assignment;
> 
> v4->v3:
> https://lore.kernel.org/netdev/1701920994-73705-1-git-send-email-guwen@linux.alibaba.com/
> - Patch #6: use SMCD_CLC_MAX_V2_GID_ENTRIES to indicate the max gid
>    entries in CLC proposal and using SMC_MAX_V2_ISM_DEVS to indicate the
>    max devices to propose;
> - Patch #6: use i and i+1 in smc_find_ism_v2_device_serv();
> - Patch #2: replace the large if-else block in smc_clc_send_confirm_accept()
>    with 2 subfunctions;
> - Fix missing byte order conversion of GID and token in CLC handshake,
>    which is in a separate patch sending to net:
>    https://lore.kernel.org/netdev/1701882157-87956-1-git-send-email-guwen@linux.alibaba.com/
> - Patch #7: add extended GID in SMC-D lgr netlink attribute;
> 
> v3->v2:
> https://lore.kernel.org/netdev/1701343695-122657-1-git-send-email-guwen@linux.alibaba.com/
> - Rename smc_clc_fill_fce as smc_clc_fill_fce_v2x;
> - Remove ISM_IDENT_MASK from drivers/s390/net/ism.h;
> - Add explicitly assigning 'false' to ism_v2_capable in ism_dev_init();
> - Remove smc_ism_set_v2_capable() helper for now, and introduce it in
>    later loopback-ism implementation;
> 
> v2->v1:
> - Fix sparse complaint;
> - Rebase to the latest net-next;
> 
> Wen Gu (10):
>    net/smc: rename some 'fce' to 'fce_v2x' for clarity
>    net/smc: introduce sub-functions for smc_clc_send_confirm_accept()
>    net/smc: unify the structs of accept or confirm message for v1 and v2
>    net/smc: support SMCv2.x supplemental features negotiation
>    net/smc: introduce virtual ISM device support feature
>    net/smc: define a reserved CHID range for virtual ISM devices
>    net/smc: compatible with 128-bits extended GID of virtual ISM device
>    net/smc: support extended GID in SMC-D lgr netlink attribute
>    net/smc: disable SEID on non-s390 archs where virtual ISM may be used
>    net/smc: manage system EID in SMC stack instead of ISM driver
> 
>   drivers/s390/net/ism.h        |   7 -
>   drivers/s390/net/ism_drv.c    |  57 ++----
>   include/linux/ism.h           |   1 -
>   include/net/smc.h             |  16 +-
>   include/uapi/linux/smc.h      |   2 +
>   include/uapi/linux/smc_diag.h |   2 +
>   net/smc/af_smc.c              | 118 ++++++++-----
>   net/smc/smc.h                 |  10 +-
>   net/smc/smc_clc.c             | 318 +++++++++++++++++++++-------------
>   net/smc/smc_clc.h             |  64 +++----
>   net/smc/smc_core.c            |  37 ++--
>   net/smc/smc_core.h            |  18 +-
>   net/smc/smc_diag.c            |   9 +-
>   net/smc/smc_ism.c             |  50 ++++--
>   net/smc/smc_ism.h             |  30 +++-
>   net/smc/smc_pnet.c            |   4 +-
>   16 files changed, 448 insertions(+), 295 deletions(-)
> 

