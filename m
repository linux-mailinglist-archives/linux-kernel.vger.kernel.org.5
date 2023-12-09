Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 488A380B1CD
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 03:50:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234194AbjLICuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 21:50:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjLICua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 21:50:30 -0500
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958EF10FC;
        Fri,  8 Dec 2023 18:50:36 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R501e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0Vy4ds9j_1702090232;
Received: from 192.168.0.103(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0Vy4ds9j_1702090232)
          by smtp.aliyun-inc.com;
          Sat, 09 Dec 2023 10:50:34 +0800
Message-ID: <4ad3a168-f506-fc21-582d-fe8764f404c0@linux.alibaba.com>
Date:   Sat, 9 Dec 2023 10:50:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net-next v5 2/9] net/smc: introduce sub-functions for
 smc_clc_send_confirm_accept()
To:     wintera@linux.ibm.com, wenjia@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        kgraul@linux.ibm.com, jaka@linux.ibm.com
Cc:     borntraeger@linux.ibm.com, svens@linux.ibm.com,
        alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        raspl@linux.ibm.com, schnelle@linux.ibm.com,
        guangguan.wang@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1702021259-41504-1-git-send-email-guwen@linux.alibaba.com>
 <1702021259-41504-3-git-send-email-guwen@linux.alibaba.com>
From:   Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <1702021259-41504-3-git-send-email-guwen@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-12.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/12/8 15:40, Wen Gu wrote:

> There is a large if-else block in smc_clc_send_confirm_accept() and it
> is better to split it into two sub-functions.
> 
> Suggested-by: Alexandra Winter <wintera@linux.ibm.com>
> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
> ---
>   net/smc/smc_clc.c | 196 +++++++++++++++++++++++++++++++-----------------------
>   1 file changed, 114 insertions(+), 82 deletions(-)
> 
> diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
> index 0fcb035..52b4ea9 100644
> --- a/net/smc/smc_clc.c
> +++ b/net/smc/smc_clc.c
> @@ -998,6 +998,111 @@ int smc_clc_send_proposal(struct smc_sock *smc, struct smc_init_info *ini)
>   	return reason_code;
>   }
>   
> +static void smcd_clc_prep_confirm_accept(struct smc_connection *conn,
> +				struct smc_clc_msg_accept_confirm_v2 *clc_v2,

checkpatch will complain 'Alignment should match open parenthesis' here.
But in order to make the length less than 80 columns, there seems to be
no other good way.

> +				int first_contact, u8 version,
> +				u8 *eid, struct smc_init_info *ini,
> +				int *fce_len,
> +				struct smc_clc_first_contact_ext_v2x *fce_v2x,
> +				struct smc_clc_msg_trail *trl)
> +{
<...>

> +
> +static void smcr_clc_prep_confirm_accept(struct smc_connection *conn,
> +				struct smc_clc_msg_accept_confirm_v2 *clc_v2,

And here.

> +				int first_contact, u8 version,
> +				u8 *eid, struct smc_init_info *ini,
> +				int *fce_len,
> +				struct smc_clc_first_contact_ext_v2x *fce_v2x,
> +				struct smc_clc_fce_gid_ext *gle,
> +				struct smc_clc_msg_trail *trl)
> +{
<...>
