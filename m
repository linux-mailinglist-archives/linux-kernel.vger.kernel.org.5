Return-Path: <linux-kernel+bounces-4877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C942F81833A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 09:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 285E9B22CF9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 08:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE66125CC;
	Tue, 19 Dec 2023 08:19:01 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C0B13FE3;
	Tue, 19 Dec 2023 08:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0VyqA-Ko_1702973928;
Received: from 30.221.130.243(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0VyqA-Ko_1702973928)
          by smtp.aliyun-inc.com;
          Tue, 19 Dec 2023 16:18:49 +0800
Message-ID: <e1c819b9-a088-8284-9083-90408c78eb2e@linux.alibaba.com>
Date: Tue, 19 Dec 2023 16:18:46 +0800
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
 <32c7fbda-297b-76a7-9da3-e136b49a63b5@linux.alibaba.com>
 <c9d908e3-5147-4c54-a2de-ef9254ac5c4f@linux.ibm.com>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <c9d908e3-5147-4c54-a2de-ef9254ac5c4f@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2023/12/19 01:40, Alexandra Winter wrote:
> 
> 
> On 18.12.23 13:21, Wen Gu wrote:
>> The fields in smcr_clc_msg_accept_confirm and smcd_clc_msg_accept_confirm_common
>> seem to have not changed since SMCDv1. So I guess there is no v2-only fields
>> in this two struct. I tried to confirm this in some documents but didn't find
>> the message format for v1.
> 
> V1 is documented in
> https://datatracker.ietf.org/doc/html/draft-fox-tcpm-shared-memory-rdma-03
> 

Thank you, Sandy. It clearly shows the SMC-Rv1 message format. I guess SMC-Dv1
message format is not publicly documented?

>>
>> If the smcr_clc_msg_accept_confirm and smcd_clc_msg_accept_confirm_common
>> is inherited from v1, should we still put the fields of v2 into these two structures?
> 
> You are right, they do not contain v2 fields, I guess I was confused.
> 
> I still think, it would be better for readability and maintainability to avoid
> +#define r0	r1._r0
> +#define d0	d1._d0
> 

I agree. Macros may cause some unexpected substitutions. I will remove them.

> I guess you and previous editors wanted to avoid changing all the instances that use r0 and d0.
> But then.. it is a rather simple search/replace..
> 

Yes, but not exactly. clc->r1.r0.xxx is somewhat strange for me, compared to clc->r0.xxx.
So I try to avoid it.

>>
>> If still, I will change these structures as
>>
>> diff --git a/net/smc/smc_clc.h b/net/smc/smc_clc.h
>> index 614fa2f298f5..18157aeb14ec 100644
>> --- a/net/smc/smc_clc.h
>> +++ b/net/smc/smc_clc.h
>> @@ -201,9 +201,12 @@ struct smcr_clc_msg_accept_confirm {       /* SMCR accept/confirm */
>>          __be64 rmb_dma_addr;    /* RMB virtual address */
>>          u8 reserved2;
>>          u8 psn[3];              /* packet sequence number */
>> +       /* v2 only, reserved and ignored in v1: */
>> +       u8 eid[SMC_MAX_EID_LEN];
>> +       u8 reserved6[8];
>>   } __packed;
>>
>> -struct smcd_clc_msg_accept_confirm_common {    /* SMCD accept/confirm */
>> +struct smcd_clc_msg_accept_confirm {   /* SMCD accept/confirm */
>>          __be64 gid;             /* Sender GID */
>>          __be64 token;           /* DMB token */
>>          u8 dmbe_idx;            /* DMBE index */
>> @@ -216,6 +219,10 @@ struct smcd_clc_msg_accept_confirm_common {        /* SMCD accept/confirm */
>>   #endif
>>          u16 reserved4;
>>          __be32 linkid;          /* Link identifier */
>> +       /* v2 only, reserved and ignored in v1: */
>> +       __be16 chid;
>> +       u8 eid[SMC_MAX_EID_LEN];
>> +       u8 reserved5[8];
>>   } __packed;
>>
>>   #define SMC_CLC_OS_ZOS         1
>> @@ -259,22 +266,9 @@ struct smc_clc_fce_gid_ext {
>>   struct smc_clc_msg_accept_confirm {    /* clc accept / confirm message */
>>          struct smc_clc_msg_hdr hdr;
>>          union {
>> -               struct { /* SMC-R */
>> -                       struct smcr_clc_msg_accept_confirm _r0;
>> -                       /* v2 only, reserved and ignored in v1: */
> 
> ^^ Actually these commetns are not fully correct. The fields are not reserved in V1.
> (my bad) The message length is shorter in V1.
> So /* v2 only: */ would be more correct.
> 
>> -                       u8 eid[SMC_MAX_EID_LEN];
>> -                       u8 reserved6[8];
>> -               } r1;
>> -               struct { /* SMC-D */
>> -                       struct smcd_clc_msg_accept_confirm_common _d0;
>> -                       /* v2 only, reserved and ignored in v1: */
> 
> same here: /* v2 only: */
> 
>> -                       __be16 chid;
>> -                       u8 eid[SMC_MAX_EID_LEN];
>> -                       u8 reserved5[8];
>> -               } d1;
>> +               struct smcr_clc_msg_accept_confirm r0; /* SMC-R */
>> +               struct smcd_clc_msg_accept_confirm d0; /* SMC-D */
>>          };
>> -#define r0     r1._r0
>> -#define d0     d1._d0
>>   };
>>
>>>
>>>>    };
> 
> Yes, I like that solution better.
> But I have no strong feelings. At least the duplicate declarations are gone.
> So, if you prefer the #defines , it's ok with me.
> 

After wrestling with several options, I decided to go with this definition.

  struct smc_clc_msg_accept_confirm {    /* clc accept / confirm message */
-       struct smc_clc_msg_hdr hdr;
-       union {
-               struct smcr_clc_msg_accept_confirm r0; /* SMC-R */
-               struct { /* SMC-D */
-                       struct smcd_clc_msg_accept_confirm_common d0;
-                       u32 reserved5[3];
-               };
-       };
-} __packed;                    /* format defined in RFC7609 */
-
-struct smc_clc_msg_accept_confirm_v2 { /* clc accept / confirm message */
         struct smc_clc_msg_hdr hdr;
         union {
                 struct { /* SMC-R */
                         struct smcr_clc_msg_accept_confirm r0;
-                       u8 eid[SMC_MAX_EID_LEN];
-                       u8 reserved6[8];
-               } r1;
+                       struct { /* v2 only */
+                               u8 eid[SMC_MAX_EID_LEN];
+                               u8 reserved6[8];
+                       } __packed r1;
+               };
                 struct { /* SMC-D */
                         struct smcd_clc_msg_accept_confirm_common d0;
-                       __be16 chid;
-                       u8 eid[SMC_MAX_EID_LEN];
-                       u8 reserved5[8];
-               } d1;
+                       struct { /* v2 only, but 12 bytes reserved in v1 */
+                               __be16 chid;
+                               u8 eid[SMC_MAX_EID_LEN];
+                               u8 reserved5[8];
+                       } __packed d1;
+               };
         };
  };

Based on these considerations:
- smcr_clc_msg_accept_confirm and smcd_clc_msg_accept_confirm_common are inherited
   from v1 or common with v1, I think it's better to reflect this in the definition.
   So I didn't put the v2 fields into them.
- d1 and r1 is used as name of following v2 fields, so that no need to change the
   instances that use r0/d0/r1/d1, and no need to use macro.
- __packed is added in d1 and r1 since smc_clc_msg_hdr, smcr_clc_msg_accept_confirm
   and smcd_clc_msg_accept_confirm_common is packed, and the subsequent modifications
   will most likely occur on d1 and r1 (e.g. using the reserved fields).
- Add the comment 'but 12 bytes reserved in v1' since I guess people may wonder why
   SMCD_CLC_ACCEPT_CONFIRM_LEN is defined as 48. The comments could be a explanation.
   (I have also considered using a union to show the 12 bytes, but this would make the
    structure appear complicated. Given that the length of the SMCDv2 field has already
    exceeded 12 bytes and cannot be shortened, I think it is fine as it is.)

> 
> 
>>>
>>> You have removed the __packed attribute.
>>> patch 07/10 adds it back for the SMC-D case, but the SMC-R case needs it as well.
>>>
>>
>> r1 and d1 in smc_clc_msg_accept_confirm_v2 (smc_clc_msg_accept_confirm now in
>> this patch) is aligned well. In patch 07/10 I replaced reserved5[8] with u64 gid_ext,
>> thus making a hole before gid_ext, so I added __packed attribute to SMC-D.
>>
>> If it is to avoid potential mistakes in future expansion, I can also add __packed to SMC-R.
>>
> 
> Yes, __packed is not only about preventing misalignement today.
> IMU, without __packed, there is no guarantee that a future compile run will not insert unused bytes.
> (highly unlikely, I admit). But __packed makes it visible that this needs to go to hardware in exactly
> this layout.
> 

Agree. I will add them to r1 and d1 definition.

Thank you.
Wen Gu

> 
>> Thanks.

