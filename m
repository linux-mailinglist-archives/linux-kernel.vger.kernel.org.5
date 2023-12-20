Return-Path: <linux-kernel+bounces-6884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFEC1819EDF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 13:17:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C3172842AA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 12:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A54A225DD;
	Wed, 20 Dec 2023 12:17:08 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45AD7225D6;
	Wed, 20 Dec 2023 12:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R371e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0VyuTIO4_1703074615;
Received: from 30.221.130.111(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0VyuTIO4_1703074615)
          by smtp.aliyun-inc.com;
          Wed, 20 Dec 2023 20:16:56 +0800
Message-ID: <38f06cfb-2d68-2b10-f82b-62a44c25b8f8@linux.alibaba.com>
Date: Wed, 20 Dec 2023 20:16:50 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net-next v8 03/10] net/smc: unify the structs of accept or
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
References: <20231219142616.80697-1-guwen@linux.alibaba.com>
 <20231219142616.80697-4-guwen@linux.alibaba.com>
 <ab835e29-ad4a-4377-b80a-8ef6bb35ef7b@linux.ibm.com>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <ab835e29-ad4a-4377-b80a-8ef6bb35ef7b@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2023/12/20 19:37, Alexandra Winter wrote:
> 
> 
> On 19.12.23 15:26, Wen Gu wrote:
>>   struct smc_clc_msg_accept_confirm {	/* clc accept / confirm message */
>> -	struct smc_clc_msg_hdr hdr;
>> -	union {
>> -		struct smcr_clc_msg_accept_confirm r0; /* SMC-R */
>> -		struct { /* SMC-D */
>> -			struct smcd_clc_msg_accept_confirm_common d0;
>> -			u32 reserved5[3];
>> -		};
>> -	};
>> -} __packed;			/* format defined in RFC7609 */
>> -
>> -struct smc_clc_msg_accept_confirm_v2 {	/* clc accept / confirm message */
>>   	struct smc_clc_msg_hdr hdr;
>>   	union {
>>   		struct { /* SMC-R */
>>   			struct smcr_clc_msg_accept_confirm r0;
>> -			u8 eid[SMC_MAX_EID_LEN];
>> -			u8 reserved6[8];
>> -		} r1;
>> +			struct { /* v2 only */
>> +				u8 eid[SMC_MAX_EID_LEN];
>> +				u8 reserved6[8];
>> +			} __packed r1;
>> +		};
>>   		struct { /* SMC-D */
>>   			struct smcd_clc_msg_accept_confirm_common d0;
>> -			__be16 chid;
>> -			u8 eid[SMC_MAX_EID_LEN];
>> -			u8 reserved5[8];
>> -		} d1;
>> +			struct { /* v2 only, but 12 bytes reserved in v1 */
>> +				__be16 chid;
>> +				u8 eid[SMC_MAX_EID_LEN];
>> +				u8 reserved5[8];
>> +			} __packed d1;
>> +		};
>>   	};
>>   };
> 
> 
> I still think the __packed at the outmost level is the safest place.
> Like you have it now the compiler could place unused memory between
> ro and r1 or between d0 and d1.
> Afaik compilers don't do that, if the blocks are word-aligned, but
> there is no guarantee.
> 
> Up to you. My R-b still applies.
> Sandy

Thank you, Sandy.

IIUC, if only outmost level has __packed, it won't work for the inner block.

e.g.

If __packed is added at d1 and r1:

struct smc_clc_msg_accept_confirm {     /* clc accept / confirm message */
         struct smc_clc_msg_hdr hdr;
         union {
                 struct { /* SMC-R */
                         struct smcr_clc_msg_accept_confirm r0;
                         struct { /* v2 only */
                                 u8 eid[SMC_MAX_EID_LEN];
                                 u8 reserved6[8];
                         } __packed r1;
                 };
                 struct { /* SMC-D */
                         struct smcd_clc_msg_accept_confirm_common d0;
                         struct { /* v2 only, but 12 bytes reserved in v1 */
                                 __be16 chid;
                                 u8 eid[SMC_MAX_EID_LEN];
                                 u64 gid_ext;
                         } __packed d1;
                 };
         };
};

According to pahole, it will be:

struct smc_clc_msg_accept_confirm {
         struct smc_clc_msg_hdr     hdr;                  /*     0     8 */
         union {
                 struct {
                         struct smcr_clc_msg_accept_confirm r0; /*     8    56 */
                         /* --- cacheline 1 boundary (64 bytes) --- */
                         struct {
                                 u8 eid[32];              /*    64    32 */
                                 u8 reserved6[8];         /*    96     8 */
                         } r1;                            /*    64    40 */
                 };                                       /*     8    96 */
                 struct {
                         struct smcd_clc_msg_accept_confirm_common d0; /*     8    24 */
                         struct {
                                 __be16 chid;             /*    32     2 */
                                 u8 eid[32];              /*    34    32 */
                                 /* --- cacheline 1 boundary (64 bytes) was 2 bytes ago --- */
                                 u64 gid_ext;             /*    66     8 */
                         } __attribute__((__packed__)) d1; /*    32    42 */
                 } __attribute__((__packed__));           /*     8    66 */
         };                                               /*     8    96 */

         /* size: 104, cachelines: 2, members: 2 */
         /* last cacheline: 40 bytes */
};


If __packed is added at outmost level:

struct smc_clc_msg_accept_confirm {     /* clc accept / confirm message */
         struct smc_clc_msg_hdr hdr;
         union {
                 struct { /* SMC-R */
                         struct smcr_clc_msg_accept_confirm r0;
                         struct { /* v2 only */
                                 u8 eid[SMC_MAX_EID_LEN];
                                 u8 reserved6[8];
                         } r1;
                 };
                 struct { /* SMC-D */
                         struct smcd_clc_msg_accept_confirm_common d0;
                         struct { /* v2 only, but 12 bytes reserved in v1 */
                                 __be16 chid;
                                 u8 eid[SMC_MAX_EID_LEN];
                                 u64 gid_ext;
                         } d1;
                 };
         };
} __packed;

According to pahole, it will be:

struct smc_clc_msg_accept_confirm {
         struct smc_clc_msg_hdr     hdr;                  /*     0     8 */
         union {
                 struct {
                         struct smcr_clc_msg_accept_confirm r0; /*     8    56 */
                         /* --- cacheline 1 boundary (64 bytes) --- */
                         struct {
                                 u8 eid[32];              /*    64    32 */
                                 u8 reserved6[8];         /*    96     8 */
                         } r1;                            /*    64    40 */
                 };                                       /*     8    96 */
                 struct {
                         struct smcd_clc_msg_accept_confirm_common d0; /*     8    24 */
                         struct {
                                 __be16 chid;             /*    32     2 */
                                 u8 eid[32];              /*    34    32 */

                                 /* XXX 6 bytes hole, try to pack */

                                 /* --- cacheline 1 boundary (64 bytes) was 8 bytes ago --- */
                                 u64 gid_ext;             /*    72     8 */
                         } d1;                            /*    32    48 */   <- doesn't work for inner d1.
                 };                                       /*     8    72 */
         };                                               /*     8    96 */

         /* size: 104, cachelines: 2, members: 2 */
         /* last cacheline: 40 bytes */
};


I also considered add them all:

struct smc_clc_msg_accept_confirm {     /* clc accept / confirm message */
         struct smc_clc_msg_hdr hdr;
         union {
                 struct { /* SMC-R */
                         struct smcr_clc_msg_accept_confirm r0;
                         struct { /* v2 only */
                                 u8 eid[SMC_MAX_EID_LEN];
                                 u8 reserved6[8];
                         } __packed r1;
                 } __packed;
                 struct { /* SMC-D */
                         struct smcd_clc_msg_accept_confirm_common d0;
                         struct { /* v2 only, but 12 bytes reserved in v1 */
                                 __be16 chid;
                                 u8 eid[SMC_MAX_EID_LEN];
                                 u64 gid_ext;
                         } __packed d1;
                 } __packed;
         };
} __packed;

but a little bit strange since for only d1 needs to packed, so I kept it as it is now.

Thanks,
Wen Gu

