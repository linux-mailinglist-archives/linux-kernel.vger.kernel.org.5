Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 741A375878B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 23:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbjGRV51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 17:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbjGRV5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 17:57:23 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF6119B3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 14:57:19 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36IJpWSE005541;
        Tue, 18 Jul 2023 21:57:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=GVaq+PdwX2VNJlf8NniGRbxdpezOsxIk6YErOSJFz58=;
 b=SNL8GGJMnzWWdRnEJDRq0Jg/hUNpooktQLd+nWK5JSJF5fJYVcIYb1GaIYbOL1Hzp63j
 kZyuJBNwkOkmd1MX+A8fvUhp1ILFglZH2uOTMKsC2q58gXIvAMEjla8YeYHJKciuZ4EL
 GVH8sRBhxyRGC+WfzWPyJ2HthoGp7cXgt/eqNuQfrPqaYYiiO7qgsWxOeTvdgq330otN
 7v1ygmAtVM0rPw/H+oJ/5Jb2uetehT04IOEHdXw59c564fRFRGgTQDkPgk6i4qE2PyQl
 hoPCcPWBwzSNSOYBQyffPdsEpv1P7cvsSD/Tdnq0Vp02yPM5pnb0RxZw3ygLmh99QE3K vQ== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rx05mceav-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jul 2023 21:57:04 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36IIShDP007434;
        Tue, 18 Jul 2023 21:57:03 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3rv80j4acj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jul 2023 21:57:03 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
        by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36ILv28P2032304
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jul 2023 21:57:03 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 906F658061;
        Tue, 18 Jul 2023 21:57:02 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2E69558043;
        Tue, 18 Jul 2023 21:57:02 +0000 (GMT)
Received: from [9.61.1.152] (unknown [9.61.1.152])
        by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 18 Jul 2023 21:57:02 +0000 (GMT)
Message-ID: <ac9bff47-8e2f-a6f3-8a59-e92fc7eb1199@linux.ibm.com>
Date:   Tue, 18 Jul 2023 16:57:01 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] fsi: Use of_property_read_reg() to parse "reg"
To:     Rob Herring <robh@kernel.org>, Jeremy Kerr <jk@ozlabs.org>,
        Joel Stanley <joel@jms.id.au>,
        Alistar Popple <alistair@popple.id.au>
Cc:     linux-fsi@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20230609183056.1765183-1-robh@kernel.org>
 <CAL_JsqLTc_9Yujp=wJjjn7P5YwAFZ9fn2SU6ey1q_gY3MFp9TA@mail.gmail.com>
 <CAL_JsqLNg00Z81cpSAOtwVWnfuQMoy2veBcHUHNby1Qh35mLTw@mail.gmail.com>
Content-Language: en-US
From:   Eddie James <eajames@linux.ibm.com>
In-Reply-To: <CAL_JsqLNg00Z81cpSAOtwVWnfuQMoy2veBcHUHNby1Qh35mLTw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: q9QNyFgEN1FmzDRqApVTlobi5fK-Sq9J
X-Proofpoint-GUID: q9QNyFgEN1FmzDRqApVTlobi5fK-Sq9J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-18_17,2023-07-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1011
 mlxscore=0 bulkscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307180196
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/18/23 14:03, Rob Herring wrote:
> On Fri, Jun 30, 2023 at 3:02 PM Rob Herring <robh@kernel.org> wrote:
>> On Fri, Jun 9, 2023 at 12:31 PM Rob Herring <robh@kernel.org> wrote:
>>> Use the recently added of_property_read_reg() helper to get the
>>> untranslated "reg" address value.
>>>
>>> Signed-off-by: Rob Herring <robh@kernel.org>
>>> ---
>>>   drivers/fsi/fsi-core.c | 39 +++++++++------------------------------
>>>   1 file changed, 9 insertions(+), 30 deletions(-)
>> Ping!
> Is FSI still maintained or should we just remove it?


Yes, it is.


Reviewed-by: Eddie James <eajames@linux.ibm.com>


>
>>> diff --git a/drivers/fsi/fsi-core.c b/drivers/fsi/fsi-core.c
>>> index 0b927c9f4267..19c4d5b3bde9 100644
>>> --- a/drivers/fsi/fsi-core.c
>>> +++ b/drivers/fsi/fsi-core.c
>>> @@ -16,6 +16,7 @@
>>>   #include <linux/idr.h>
>>>   #include <linux/module.h>
>>>   #include <linux/of.h>
>>> +#include <linux/of_address.h>
>>>   #include <linux/slab.h>
>>>   #include <linux/bitops.h>
>>>   #include <linux/cdev.h>
>>> @@ -415,28 +416,18 @@ EXPORT_SYMBOL_GPL(fsi_slave_release_range);
>>>   static bool fsi_device_node_matches(struct device *dev, struct device_node *np,
>>>                  uint32_t addr, uint32_t size)
>>>   {
>>> -       unsigned int len, na, ns;
>>> -       const __be32 *prop;
>>> -       uint32_t psize;
>>> +       u64 paddr, psize;
>>>
>>> -       na = of_n_addr_cells(np);
>>> -       ns = of_n_size_cells(np);
>>> -
>>> -       if (na != 1 || ns != 1)
>>> -               return false;
>>> -
>>> -       prop = of_get_property(np, "reg", &len);
>>> -       if (!prop || len != 8)
>>> +       if (of_property_read_reg(np, 0, &paddr, &psize))
>>>                  return false;
>>>
>>> -       if (of_read_number(prop, 1) != addr)
>>> +       if (paddr != addr)
>>>                  return false;
>>>
>>> -       psize = of_read_number(prop + 1, 1);
>>>          if (psize != size) {
>>>                  dev_warn(dev,
>>> -                       "node %s matches probed address, but not size (got 0x%x, expected 0x%x)",
>>> -                       of_node_full_name(np), psize, size);
>>> +                       "node %pOF matches probed address, but not size (got 0x%llx, expected 0x%x)",
>>> +                       np, psize, size);
>>>          }
>>>
>>>          return true;
>>> @@ -653,24 +644,12 @@ static void fsi_slave_release(struct device *dev)
>>>   static bool fsi_slave_node_matches(struct device_node *np,
>>>                  int link, uint8_t id)
>>>   {
>>> -       unsigned int len, na, ns;
>>> -       const __be32 *prop;
>>> -
>>> -       na = of_n_addr_cells(np);
>>> -       ns = of_n_size_cells(np);
>>> -
>>> -       /* Ensure we have the correct format for addresses and sizes in
>>> -        * reg properties
>>> -        */
>>> -       if (na != 2 || ns != 0)
>>> -               return false;
>>> +       u64 addr;
>>>
>>> -       prop = of_get_property(np, "reg", &len);
>>> -       if (!prop || len != 8)
>>> +       if (of_property_read_reg(np, 0, &addr, NULL))
>>>                  return false;
>>>
>>> -       return (of_read_number(prop, 1) == link) &&
>>> -               (of_read_number(prop + 1, 1) == id);
>>> +       return addr == (((u64)link << 32) | id);
>>>   }
>>>
>>>   /* Find a matching node for the slave at (link, id). Returns NULL if none
>>> --
>>> 2.39.2
>>>
