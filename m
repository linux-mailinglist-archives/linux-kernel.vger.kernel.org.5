Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 985FE77EF8F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 05:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347861AbjHQDb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 23:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347857AbjHQDb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 23:31:29 -0400
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 410FE2686;
        Wed, 16 Aug 2023 20:31:27 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=guangguan.wang@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0VpyH6Nq_1692243083;
Received: from 30.221.109.120(mailfrom:guangguan.wang@linux.alibaba.com fp:SMTPD_---0VpyH6Nq_1692243083)
          by smtp.aliyun-inc.com;
          Thu, 17 Aug 2023 11:31:24 +0800
Message-ID: <e6847761-af77-6673-9e06-cc08eb4ba483@linux.alibaba.com>
Date:   Thu, 17 Aug 2023 11:31:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH net-next 3/6] net/smc: support smc v2.x features validate
Content-Language: en-US
To:     Vadim Fedorenko <vadim.fedorenko@linux.dev>, wenjia@linux.ibm.com,
        jaka@linux.ibm.com, kgraul@linux.ibm.com, tonylu@linux.alibaba.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     horms@kernel.org, alibuda@linux.alibaba.com,
        guwen@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230816083328.95746-1-guangguan.wang@linux.alibaba.com>
 <20230816083328.95746-4-guangguan.wang@linux.alibaba.com>
 <5421115a-a8d0-0eae-78b1-a2c5977e2ba1@linux.dev>
From:   Guangguan Wang <guangguan.wang@linux.alibaba.com>
In-Reply-To: <5421115a-a8d0-0eae-78b1-a2c5977e2ba1@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-13.1 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/8/16 20:49, Vadim Fedorenko wrote:
> On 16/08/2023 09:33, Guangguan Wang wrote:

>> +
>> +int smc_clc_cli_v2x_features_validate(struct smc_clc_first_contact_ext *fce,
>> +                      struct smc_init_info *ini)
>> +{
>> +    if (ini->release_nr < SMC_RELEASE_1)
>> +        return 0;
>> +
>> +    return 0;
>> +}
> 
> This function always returns 0. Is it really what expected?
> 

This patch is a frame code of v2x features validate.
Please read the next 2 patches, where will fill more code logic in this function.


[PATCH net-next 4/6] net/smc: support max connections per lgr negotiation
 int smc_clc_cli_v2x_features_validate(struct smc_clc_first_contact_ext *fce,
 				      struct smc_init_info *ini)
 {
+	struct smc_clc_first_contact_ext_v2x *fce_v2x =
+		(struct smc_clc_first_contact_ext_v2x *)fce;
+
 	if (ini->release_nr < SMC_RELEASE_1)
 		return 0;
 
+	if (!ini->is_smcd) {
+		if (fce_v2x->max_conns < SMC_CONN_PER_LGR_MIN)
+			return SMC_CLC_DECL_MAXCONNERR;
+		ini->max_conns = fce_v2x->max_conns;
+	}
+
 	return 0;
 }


[PATCH net-next 5/6] net/smc: support max links per lgr negotiation in clc handshake
@@ -1208,6 +1216,11 @@ int smc_clc_cli_v2x_features_validate(struct smc_clc_first_contact_ext *fce,
 		if (fce_v2x->max_conns < SMC_CONN_PER_LGR_MIN)
 			return SMC_CLC_DECL_MAXCONNERR;
 		ini->max_conns = fce_v2x->max_conns;
+
+		if (fce_v2x->max_links > SMC_LINKS_ADD_LNK_MAX ||
+		    fce_v2x->max_links < SMC_LINKS_ADD_LNK_MIN)
+			return SMC_CLC_DECL_MAXLINKERR;
+		ini->max_links = fce_v2x->max_links;
 	}
 
 	return 0;


Thanks,
Guangguan Wang
