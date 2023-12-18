Return-Path: <linux-kernel+bounces-3560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0153816DD7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:22:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97C151C21D07
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0405C4B146;
	Mon, 18 Dec 2023 12:21:39 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E311C200A7;
	Mon, 18 Dec 2023 12:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0VymXdc3_1702902090;
Received: from 30.221.129.204(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0VymXdc3_1702902090)
          by smtp.aliyun-inc.com;
          Mon, 18 Dec 2023 20:21:31 +0800
Message-ID: <32c7fbda-297b-76a7-9da3-e136b49a63b5@linux.alibaba.com>
Date: Mon, 18 Dec 2023 20:21:28 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net-next v6 03/10] net/smc: unify the structs of accept or
 confirm message for v1 and v2
To: Alexandra Winter <wintera@linux.ibm.com>, wenjia@linux.ibm.com,
 hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, kgraul@linux.ibm.com, jaka@linux.ibm.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com,
 alibuda@linux.alibaba.com, tonylu@linux.alibaba.com, raspl@linux.ibm.com,
 schnelle@linux.ibm.com, guangguan.wang@linux.alibaba.com,
 linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <1702371151-125258-1-git-send-email-guwen@linux.alibaba.com>
 <1702371151-125258-4-git-send-email-guwen@linux.alibaba.com>
 <63aa2995-7980-430d-84be-58ce204f5172@linux.ibm.com>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <63aa2995-7980-430d-84be-58ce204f5172@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2023/12/18 16:39, Alexandra Winter wrote:
> 
> 
> On 12.12.23 09:52, Wen Gu wrote:
>> The structs of CLC accept and confirm messages for SMCv1 and SMCv2 are
>> separately defined and often casted to each other in the code, which may
>> increase the risk of errors caused by future divergence of them. So
>> unify them into one struct for better maintainability.
>>
>> Suggested-by: Alexandra Winter <wintera@linux.ibm.com>
>> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
>> ---
>>   net/smc/af_smc.c  | 50 +++++++++++++++---------------------------
>>   net/smc/smc_clc.c | 65 ++++++++++++++++++++++++-------------------------------
>>   net/smc/smc_clc.h | 32 ++++++++++-----------------
>>   3 files changed, 57 insertions(+), 90 deletions(-)
>>
> 
> [...]
> Thank you very much, Wen Gu. I think this makes it much easier to spot the
> places in the accept/confirm code code where v1 vs v2 really make a difference.
> I understand that this is not really related to v2.1, but I feel it is worth
> simplifying the already complex strucutres before adding even more complexity.
> 
> 
> 
>> diff --git a/net/smc/smc_clc.h b/net/smc/smc_clc.h
>> index 1697b84..614fa2f 100644
>> --- a/net/smc/smc_clc.h
>> +++ b/net/smc/smc_clc.h
>> @@ -259,29 +259,22 @@ struct smc_clc_fce_gid_ext {
>>   struct smc_clc_msg_accept_confirm {	/* clc accept / confirm message */
>>   	struct smc_clc_msg_hdr hdr;
>>   	union {
>> -		struct smcr_clc_msg_accept_confirm r0; /* SMC-R */
>> -		struct { /* SMC-D */
>> -			struct smcd_clc_msg_accept_confirm_common d0;
>> -			u32 reserved5[3];
>> -		};
>> -	};
>> -} __packed;			/* format defined in RFC7609 */
>> -
>> -struct smc_clc_msg_accept_confirm_v2 {	/* clc accept / confirm message */
>> -	struct smc_clc_msg_hdr hdr;
>> -	union {
>>   		struct { /* SMC-R */
>> -			struct smcr_clc_msg_accept_confirm r0;
>> +			struct smcr_clc_msg_accept_confirm _r0;
>> +			/* v2 only, reserved and ignored in v1: */
>>   			u8 eid[SMC_MAX_EID_LEN];
>>   			u8 reserved6[8];
>>   		} r1;
>>   		struct { /* SMC-D */
>> -			struct smcd_clc_msg_accept_confirm_common d0;
>> +			struct smcd_clc_msg_accept_confirm_common _d0;
>> +			/* v2 only, reserved and ignored in v1: */
>>   			__be16 chid;
>>   			u8 eid[SMC_MAX_EID_LEN];
>>   			u8 reserved5[8];
>>   		} d1;
>>   	};
>> +#define r0	r1._r0
>> +#define d0	d1._d0
> 
> This adds complexity.
> If you add the v2-only fields to struct smcr_clc_msg_accept_confirm and
> struct smcd_clc_msg_accept_confirm_common respectively, you can avoid the
> #define and the extra layer in the struct.
> Actually there are already v2-only fields in smcd_clc_msg_accept_confirm_common
> and smcd_clc_msg_accept_confirm_common (gid and others). So you could add the
> correct informative comments there.

Thank you very much for the suggestions, Sandy.

I checked the history commits:
c758dfddc1b5 ("net/smc: add SMC-D support in CLC messages")
3d9725a6a133 ("net/smc: common routine for CLC accept and confirm")
a7c9c5f4af7f ("net/smc: CLC accept / confirm V2")
e5c4744cfb59 ("net/smc: add SMC-Rv2 connection establishment")

The fields in smcr_clc_msg_accept_confirm and smcd_clc_msg_accept_confirm_common
seem to have not changed since SMCDv1. So I guess there is no v2-only fields
in this two struct. I tried to confirm this in some documents but didn't find
the message format for v1.

If the smcr_clc_msg_accept_confirm and smcd_clc_msg_accept_confirm_common
is inherited from v1, should we still put the fields of v2 into these two structures?

If still, I will change these structures as

diff --git a/net/smc/smc_clc.h b/net/smc/smc_clc.h
index 614fa2f298f5..18157aeb14ec 100644
--- a/net/smc/smc_clc.h
+++ b/net/smc/smc_clc.h
@@ -201,9 +201,12 @@ struct smcr_clc_msg_accept_confirm {       /* SMCR accept/confirm */
         __be64 rmb_dma_addr;    /* RMB virtual address */
         u8 reserved2;
         u8 psn[3];              /* packet sequence number */
+       /* v2 only, reserved and ignored in v1: */
+       u8 eid[SMC_MAX_EID_LEN];
+       u8 reserved6[8];
  } __packed;

-struct smcd_clc_msg_accept_confirm_common {    /* SMCD accept/confirm */
+struct smcd_clc_msg_accept_confirm {   /* SMCD accept/confirm */
         __be64 gid;             /* Sender GID */
         __be64 token;           /* DMB token */
         u8 dmbe_idx;            /* DMBE index */
@@ -216,6 +219,10 @@ struct smcd_clc_msg_accept_confirm_common {        /* SMCD accept/confirm */
  #endif
         u16 reserved4;
         __be32 linkid;          /* Link identifier */
+       /* v2 only, reserved and ignored in v1: */
+       __be16 chid;
+       u8 eid[SMC_MAX_EID_LEN];
+       u8 reserved5[8];
  } __packed;

  #define SMC_CLC_OS_ZOS         1
@@ -259,22 +266,9 @@ struct smc_clc_fce_gid_ext {
  struct smc_clc_msg_accept_confirm {    /* clc accept / confirm message */
         struct smc_clc_msg_hdr hdr;
         union {
-               struct { /* SMC-R */
-                       struct smcr_clc_msg_accept_confirm _r0;
-                       /* v2 only, reserved and ignored in v1: */
-                       u8 eid[SMC_MAX_EID_LEN];
-                       u8 reserved6[8];
-               } r1;
-               struct { /* SMC-D */
-                       struct smcd_clc_msg_accept_confirm_common _d0;
-                       /* v2 only, reserved and ignored in v1: */
-                       __be16 chid;
-                       u8 eid[SMC_MAX_EID_LEN];
-                       u8 reserved5[8];
-               } d1;
+               struct smcr_clc_msg_accept_confirm r0; /* SMC-R */
+               struct smcd_clc_msg_accept_confirm d0; /* SMC-D */
         };
-#define r0     r1._r0
-#define d0     d1._d0
  };

> 
>>   };
> 
> You have removed the __packed attribute.
> patch 07/10 adds it back for the SMC-D case, but the SMC-R case needs it as well.
> 

r1 and d1 in smc_clc_msg_accept_confirm_v2 (smc_clc_msg_accept_confirm now in
this patch) is aligned well. In patch 07/10 I replaced reserved5[8] with u64 gid_ext,
thus making a hole before gid_ext, so I added __packed attribute to SMC-D.

If it is to avoid potential mistakes in future expansion, I can also add __packed to SMC-R.

Thanks.
> 
> [...]

