Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13E647A757B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 10:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232937AbjITILw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 04:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbjITILv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 04:11:51 -0400
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A62F1A1;
        Wed, 20 Sep 2023 01:11:43 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VsUU1SX_1695197499;
Received: from 30.221.128.235(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0VsUU1SX_1695197499)
          by smtp.aliyun-inc.com;
          Wed, 20 Sep 2023 16:11:40 +0800
Message-ID: <50feb145-c658-b9a1-7261-b67bb82767dc@linux.alibaba.com>
Date:   Wed, 20 Sep 2023 16:11:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH net-next 06/18] net/smc: extend GID to 128bits for virtual
 ISM device
To:     kernel test robot <lkp@intel.com>, kgraul@linux.ibm.com,
        wenjia@linux.ibm.com, jaka@linux.ibm.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc:     oe-kbuild-all@lists.linux.dev, alibuda@linux.alibaba.com,
        tonylu@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1695134522-126655-7-git-send-email-guwen@linux.alibaba.com>
 <202309201408.95QRxHEl-lkp@intel.com>
From:   Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <202309201408.95QRxHEl-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.4 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/9/20 15:02, kernel test robot wrote:
> Hi Wen,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on net-next/main]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Wen-Gu/net-smc-decouple-ism_dev-from-SMC-D-device-dump/20230920-010019
> base:   net-next/main
> patch link:    https://lore.kernel.org/r/1695134522-126655-7-git-send-email-guwen%40linux.alibaba.com
> patch subject: [PATCH net-next 06/18] net/smc: extend GID to 128bits for virtual ISM device
> config: s390-defconfig (https://download.01.org/0day-ci/archive/20230920/202309201408.95QRxHEl-lkp@intel.com/config)
> compiler: s390-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230920/202309201408.95QRxHEl-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202309201408.95QRxHEl-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>     net/smc/smc_ism.c: In function 'smc_ism_signal_shutdown':
>>> net/smc/smc_ism.c:539:57: error: incompatible type for argument 2 of 'lgr-><U72f8>.<U7260>.smcd->ops->signal_event'
>       539 |         rc = lgr->smcd->ops->signal_event(lgr->smcd, lgr->peer_gid,
>           |                                                      ~~~^~~~~~~~~~
>           |                                                         |
>           |                                                         struct smcd_gid
>     net/smc/smc_ism.c:539:57: note: expected 'u64' {aka 'long long unsigned int'} but argument is of type 'struct smcd_gid'
> 
> 
> vim +539 net/smc/smc_ism.c
> 
> 820f21009f1bc7a Stefan Raspl 2023-01-23  526
> 820f21009f1bc7a Stefan Raspl 2023-01-23  527  int smc_ism_signal_shutdown(struct smc_link_group *lgr)
> 820f21009f1bc7a Stefan Raspl 2023-01-23  528  {
> 820f21009f1bc7a Stefan Raspl 2023-01-23  529  	int rc = 0;
> 820f21009f1bc7a Stefan Raspl 2023-01-23  530  #if IS_ENABLED(CONFIG_ISM)
> 820f21009f1bc7a Stefan Raspl 2023-01-23  531  	union smcd_sw_event_info ev_info;
> 820f21009f1bc7a Stefan Raspl 2023-01-23  532
> 820f21009f1bc7a Stefan Raspl 2023-01-23  533  	if (lgr->peer_shutdown)
> 820f21009f1bc7a Stefan Raspl 2023-01-23  534  		return 0;
> 820f21009f1bc7a Stefan Raspl 2023-01-23  535
> 820f21009f1bc7a Stefan Raspl 2023-01-23  536  	memcpy(ev_info.uid, lgr->id, SMC_LGR_ID_SIZE);
> 820f21009f1bc7a Stefan Raspl 2023-01-23  537  	ev_info.vlan_id = lgr->vlan_id;
> 820f21009f1bc7a Stefan Raspl 2023-01-23  538  	ev_info.code = ISM_EVENT_REQUEST;
> 820f21009f1bc7a Stefan Raspl 2023-01-23 @539  	rc = lgr->smcd->ops->signal_event(lgr->smcd, lgr->peer_gid,
> 820f21009f1bc7a Stefan Raspl 2023-01-23  540  					  ISM_EVENT_REQUEST_IR,
> 820f21009f1bc7a Stefan Raspl 2023-01-23  541  					  ISM_EVENT_CODE_SHUTDOWN,
> 820f21009f1bc7a Stefan Raspl 2023-01-23  542  					  ev_info.info);
> 820f21009f1bc7a Stefan Raspl 2023-01-23  543  #endif
> 820f21009f1bc7a Stefan Raspl 2023-01-23  544  	return rc;
> 820f21009f1bc7a Stefan Raspl 2023-01-23  545  }
> 201091ebb2a161a Ursula Braun 2020-09-26  546
> 

I do not have a local compilation environment for s390 (IBM Z) architecture. But I think
it can be fixed by the following patch.

After this v1 exceeds 24 hours, I will send a v2 with this fix. Thanks.



Fix:


diff --git a/drivers/s390/net/ism_drv.c b/drivers/s390/net/ism_drv.c
index 1b714f6..7801a6a 100644
--- a/drivers/s390/net/ism_drv.c
+++ b/drivers/s390/net/ism_drv.c
@@ -811,10 +811,10 @@ static int smcd_reset_vlan_required(struct smcd_dev *smcd)
         return ism_cmd_simple(smcd->priv, ISM_RESET_VLAN);
  }

-static int smcd_signal_ieq(struct smcd_dev *smcd, u64 rgid, u32 trigger_irq,
-                          u32 event_code, u64 info)
+static int smcd_signal_ieq(struct smcd_dev *smcd, struct smcd_gid *rgid,
+                          u32 trigger_irq, u32 event_code, u64 info)
  {
-       return ism_signal_ieq(smcd->priv, rgid, trigger_irq, event_code, info);
+       return ism_signal_ieq(smcd->priv, rgid->gid, trigger_irq, event_code, info);
  }

  static int smcd_move(struct smcd_dev *smcd, u64 dmb_tok, unsigned int idx,
diff --git a/include/net/smc.h b/include/net/smc.h
index 04dbaa4..39a21ed 100644
--- a/include/net/smc.h
+++ b/include/net/smc.h
@@ -78,8 +78,8 @@ struct smcd_ops {
         int (*del_vlan_id)(struct smcd_dev *dev, u64 vlan_id);
         int (*set_vlan_required)(struct smcd_dev *dev);
         int (*reset_vlan_required)(struct smcd_dev *dev);
-       int (*signal_event)(struct smcd_dev *dev, u64 rgid, u32 trigger_irq,
-                           u32 event_code, u64 info);
+       int (*signal_event)(struct smcd_dev *dev, struct smcd_gid *rgid,
+                           u32 trigger_irq, u32 event_code, u64 info);
         int (*move_data)(struct smcd_dev *dev, u64 dmb_tok, unsigned int idx,
                          bool sf, unsigned int offset, void *data,
                          unsigned int size);
diff --git a/net/smc/smc_ism.c b/net/smc/smc_ism.c
index 0c20745..3d9588e 100644
--- a/net/smc/smc_ism.c
+++ b/net/smc/smc_ism.c
@@ -404,10 +404,11 @@ static void smcd_handle_sw_event(struct smc_ism_event_work *wrk)
                 smc_smcd_terminate(wrk->smcd, &peer_gid, ev_info.vlan_id);
                 break;
         case ISM_EVENT_CODE_TESTLINK:   /* Activity timer */
+               peer_gid.gid = wrk->event.tok;
                 if (ev_info.code == ISM_EVENT_REQUEST) {
                         ev_info.code = ISM_EVENT_RESPONSE;
                         wrk->smcd->ops->signal_event(wrk->smcd,
-                                                    wrk->event.tok,
+                                                    &peer_gid,
                                                      ISM_EVENT_REQUEST_IR,
                                                      ISM_EVENT_CODE_TESTLINK,
                                                      ev_info.info);
@@ -575,7 +576,7 @@ int smc_ism_signal_shutdown(struct smc_link_group *lgr)
         memcpy(ev_info.uid, lgr->id, SMC_LGR_ID_SIZE);
         ev_info.vlan_id = lgr->vlan_id;
         ev_info.code = ISM_EVENT_REQUEST;
-       rc = lgr->smcd->ops->signal_event(lgr->smcd, lgr->peer_gid,
+       rc = lgr->smcd->ops->signal_event(lgr->smcd, &lgr->peer_gid,
                                           ISM_EVENT_REQUEST_IR,
                                           ISM_EVENT_CODE_SHUTDOWN,
                                           ev_info.info);
diff --git a/net/smc/smc_loopback.c b/net/smc/smc_loopback.c
index 611998b..8b249a5 100644
--- a/net/smc/smc_loopback.c
+++ b/net/smc/smc_loopback.c
@@ -253,8 +253,8 @@ static int smc_lo_reset_vlan_required(struct smcd_dev *smcd)
         return -EOPNOTSUPP;
  }

-static int smc_lo_signal_event(struct smcd_dev *dev, u64 rgid, u32 trigger_irq,
-                              u32 event_code, u64 info)
+static int smc_lo_signal_event(struct smcd_dev *dev, struct smcd_gid *rgid,
+                              u32 trigger_irq, u32 event_code, u64 info)
  {
         return 0;
  }
