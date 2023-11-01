Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DFC17DE064
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 12:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235287AbjKALgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 07:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235212AbjKALgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 07:36:38 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 53C72F4;
        Wed,  1 Nov 2023 04:36:35 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BC42C2F4;
        Wed,  1 Nov 2023 04:37:16 -0700 (PDT)
Received: from [192.168.1.100] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 24ACA3F67D;
        Wed,  1 Nov 2023 04:36:31 -0700 (PDT)
Message-ID: <f79adb8e-6545-f43b-c685-bc6b0d755702@arm.com>
Date:   Wed, 1 Nov 2023 11:36:29 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
From:   James Clark <james.clark@arm.com>
Subject: Re: [PATCH v2 2/8] coresight-tpda: Add support to configure CMB
 element
To:     Tao Zhang <quic_taozha@quicinc.com>
Cc:     Jinlong Mao <quic_jinlmao@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Song Chai <quic_songchai@quicinc.com>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <1698202408-14608-1-git-send-email-quic_taozha@quicinc.com>
 <1698202408-14608-3-git-send-email-quic_taozha@quicinc.com>
 <197007e5-e334-cd7e-0bbd-b84c828f5f7b@arm.com>
 <c1a46885-2dd0-4280-9318-798c873a0c78@quicinc.com>
Content-Language: en-US
In-Reply-To: <c1a46885-2dd0-4280-9318-798c873a0c78@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/11/2023 08:53, Tao Zhang wrote:
> 
> On 10/30/2023 7:11 PM, James Clark wrote:
>>
>> On 25/10/2023 03:53, Tao Zhang wrote:
>>> Read the CMB element size from the device tree. Set the register
>>> bit that controls the CMB element size of the corresponding port.
>>>
>>> Signed-off-by: Tao Zhang<quic_taozha@quicinc.com>
>>> Signed-off-by: Mao Jinlong<quic_jinlmao@quicinc.com>
>>> ---
>>>   drivers/hwtracing/coresight/coresight-tpda.c | 108
>>> ++++++++++++++++-----------
>>>   drivers/hwtracing/coresight/coresight-tpda.h |   6 ++
>>>   2 files changed, 69 insertions(+), 45 deletions(-)
>>>
>>> diff --git a/drivers/hwtracing/coresight/coresight-tpda.c
>>> b/drivers/hwtracing/coresight/coresight-tpda.c
>>> index 5f82737..3101d2a 100644
>>> --- a/drivers/hwtracing/coresight/coresight-tpda.c
>>> +++ b/drivers/hwtracing/coresight/coresight-tpda.c
>>> @@ -28,24 +28,54 @@ static bool coresight_device_is_tpdm(struct
>>> coresight_device *csdev)
>>>               CORESIGHT_DEV_SUBTYPE_SOURCE_TPDM);
>>>   }
>>>   +static void tpdm_clear_element_size(struct coresight_device *csdev)
>>> +{
>>> +    struct tpda_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>>> +
>>> +    if (drvdata->dsb_esize)
>>> +        drvdata->dsb_esize = 0;
>>> +    if (drvdata->cmb_esize)
>>> +        drvdata->cmb_esize = 0;

The ifs don't do anything here, it's just the same as always setting to 0.

>>> +}
>>> +
>>> +static void tpda_set_element_size(struct tpda_drvdata *drvdata, u32
>>> *val)
>>> +{
>>> +
>>> +    if (drvdata->dsb_esize == 64)
>>> +        *val |= TPDA_Pn_CR_DSBSIZE;
>>> +    else if (drvdata->dsb_esize == 32)
>>> +        *val &= ~TPDA_Pn_CR_DSBSIZE;
>>> +
>>> +    if (drvdata->cmb_esize == 64)
>>> +        *val |= FIELD_PREP(TPDA_Pn_CR_CMBSIZE, 0x2);
>>> +    else if (drvdata->cmb_esize == 32)
>>> +        *val |= FIELD_PREP(TPDA_Pn_CR_CMBSIZE, 0x1);
>>> +    else if (drvdata->cmb_esize == 8)
>>> +        *val &= ~TPDA_Pn_CR_CMBSIZE;
>>> +}
>>> +
>>>   /*
>>>    * Read the DSB element size from the TPDM device
>>>    * Returns
>>>    *    The dsb element size read from the devicetree if available.
>> Hi Tao,
>>
>> I think the function description and the return value description above
>> need updating now.
> I will update this in the next patch series.
>>
>>>    *    0 - Otherwise, with a warning once.
>>>    */
>>> -static int tpdm_read_dsb_element_size(struct coresight_device *csdev)
>>> +static int tpdm_read_element_size(struct tpda_drvdata *drvdata,
>>> +                  struct coresight_device *csdev)
>>>   {
>>> -    int rc = 0;
>>> -    u8 size = 0;
>>> -
>>> -    rc = fwnode_property_read_u8(dev_fwnode(csdev->dev.parent),
>>> -            "qcom,dsb-element-size", &size);
>>> +    int rc = -EEXIST;
>>> +
>>> +    if (!fwnode_property_read_u8(dev_fwnode(csdev->dev.parent),
>>> +            "qcom,dsb-element-size", &drvdata->dsb_esize))
>>> +        rc &= 0;
>> Is &= 0 significant? Why not = 0?
> I will update this in the next patch series.
>>
>>> +    if (!fwnode_property_read_u8(dev_fwnode(csdev->dev.parent),
>>> +            "qcom,cmb-element-size", &drvdata->cmb_esize))
>>> +        rc &= 0;
>>>       if (rc)
>>>           dev_warn_once(&csdev->dev,
>>> -            "Failed to read TPDM DSB Element size: %d\n", rc);
>>> +            "Failed to read TPDM Element size: %d\n", rc);
>>>   -    return size;
>>> +    return rc;
>>>   }
>>>     /*
>>> @@ -56,13 +86,17 @@ static int tpdm_read_dsb_element_size(struct
>>> coresight_device *csdev)
>>>    * Parameter "inport" is used to pass in the input port number
>>>    * of TPDA, and it is set to -1 in the recursize call.
>>>    */
>>> -static int tpda_get_element_size(struct coresight_device *csdev,
>>> +static int tpda_get_element_size(struct tpda_drvdata *drvdata,
>>> +                 struct coresight_device *csdev,
>>>                    int inport)
>>>   {
>>> -    int dsb_size = -ENOENT;
>>> -    int i, size;
>>> +    int rc = -ENOENT;
>>> +    int i;
>>>       struct coresight_device *in;
>>>   +    if (inport > 0)
>>> +        tpdm_clear_element_size(csdev);
>>> +
>>>       for (i = 0; i < csdev->pdata->nr_inconns; i++) {
>>>           in = csdev->pdata->in_conns[i]->src_dev;
>>>           if (!in)
>>> @@ -74,25 +108,20 @@ static int tpda_get_element_size(struct
>>> coresight_device *csdev,
>>>               continue;
>>>             if (coresight_device_is_tpdm(in)) {
>>> -            size = tpdm_read_dsb_element_size(in);
>>> +            if (rc)
>>> +                rc = tpdm_read_element_size(drvdata, in);
>>> +            else
>>> +                return -EINVAL;
>> This is quite hard to follow, is checking rc here before calling
>> tpdm_read_element_size() some kind of way of only calling it once?
> 
> Yes, there can only be one TPDM on one input port of TPDA. If
> "tpdm_read_element_size" is called
> 
> twice, it means that two TPDMs are found on one input port of TPDA.
> 
>> rc isn't actually a return value at this point, it's just default
>> initialised to -ENOENT.
> 
> In this loop, "tpdm_read_element_size" will be called for the first time
> TPDM found. If rc equals to
> 
> 0, it means that at lease one TPDM has been found on the input port.
> Does it make sense?
> 
>> Then it's not clear why the else condition returns an error?
> The same as the above.
>>
>>>           } else {
>>>               /* Recurse down the path */
>>> -            size = tpda_get_element_size(in, -1);
>>> -        }
>>> -
>>> -        if (size < 0)
>>> -            return size;
>>> -
>>> -        if (dsb_size < 0) {
>>> -            /* Found a size, save it. */
>>> -            dsb_size = size;
>>> -        } else {
>>> -            /* Found duplicate TPDMs */
>>> -            return -EEXIST;
>>> +            rc = tpda_get_element_size(drvdata, in, -1);
>> And then why it's assigned here but not checked for an error in this
>> case?
> 
> |Remote ETM|                           |TPDM|
> 
>             |    branch0                           | branch1
> 
>                         --------------------------
> 
>                                     funnel1
> 
>                         ---------------------------
> 
>                                           | input port 1
> 
> -----------------------------
> 
>                                                        TPDA1
> 
> -----------------------------
> 
> The  branches on some TPDA's input ports may not have TPDM. For example,
> branch 0 doesn't has a
> 
> TPDM connected, tpda_get_element_size will not return 0 here. This is a
> normal situation. We need to
> 
> continue to find TPDM on branch1 through recursion.
> 
>>
>> Maybe some comments explaining the flow would help. Or to me it seems
>> like a second variable to track the thing that's actually intended could
>> be used as well. Like "bool found_element" or something, rather than
>> re-using rc to also track another thing.
> 
> Do you prefer to use "static bool found_element" to mark if we already
> have read an element size in
> 
> the recursion function?
> 

You could add a static, or you could use whether a set dsb or cmb size
exists to mark that one was found, which I think is already partially done.

My confusion comes from the fact that instead of just a recursive
search, the function doesn't stop at the first found one, it continues
to sanity check that there is only one connected across all ports.

And instead of just checking the error condition at the very end, it
does it mid recursion, relying on the rc value from a previous
iteration. IMO the following is a simplification because it always
returns at the first error found, and checks the final condition outside
of the recursive function. But you could probably leave it as you have
but with some comments explaining why:


diff --git a/drivers/hwtracing/coresight/coresight-tpda.c b/drivers/hwtracing/coresight/coresight-tpda.c
index 3101d2a0671d..00b7607d36be 100644
--- a/drivers/hwtracing/coresight/coresight-tpda.c
+++ b/drivers/hwtracing/coresight/coresight-tpda.c
@@ -90,13 +90,10 @@ static int tpda_get_element_size(struct tpda_drvdata *drvdata,
                                  struct coresight_device *csdev,
                                  int inport)
  {
-       int rc = -ENOENT;
+       int rc = 0;
         int i;
         struct coresight_device *in;
  
-       if (inport > 0)
-               tpdm_clear_element_size(csdev);
-
         for (i = 0; i < csdev->pdata->nr_inconns; i++) {
                 in = csdev->pdata->in_conns[i]->src_dev;
                 if (!in)
@@ -108,19 +105,23 @@ static int tpda_get_element_size(struct tpda_drvdata *drvdata,
                         continue;
  
                 if (coresight_device_is_tpdm(in)) {
-                       if (rc)
-                               rc = tpdm_read_element_size(drvdata, in);
-                       else
+                       if ((drvdata->dsb_esize) || (drvdata->cmb_esize)) {
+                               /* Error if already previously found and initialised one */
+                               dev_warn_once(&drvdata->csdev->dev,
+                                       "Detected multiple TPDMs on port %d", -EEXIST);
                                 return -EINVAL;
+                       }
+                       rc = tpdm_read_element_size(drvdata, in);
+                       if (rc)
+                               return rc;
                 } else {
                         /* Recurse down the path */
                         rc = tpda_get_element_size(drvdata, in, -1);
+                       if (rc)
+                               return rc;
                 }
         }
  
-       if ((drvdata->dsb_esize) || (drvdata->cmb_esize))
-               rc = 0;
-
         return rc;
  }
  
@@ -146,15 +147,17 @@ static int tpda_enable_port(struct tpda_drvdata *drvdata, int port)
          * Set the bit to 0 if the size is 32
          * Set the bit to 1 if the size is 64
          */
+       tpdm_clear_element_size(drvdata->csdev);
         rc = tpda_get_element_size(drvdata, drvdata->csdev, port);
-       if (!rc) {
+       if (!rc && ((drvdata->dsb_esize) || (drvdata->cmb_esize)))
+       {
                 tpda_set_element_size(drvdata, &val);
                 /* Enable the port */
                 val |= TPDA_Pn_CR_ENA;
                 writel_relaxed(val, drvdata->base + TPDA_Pn_CR(port));
-       } else if (rc == -EINVAL) {
-               dev_warn_once(&drvdata->csdev->dev,
-                       "Detected multiple TPDMs on port %d", -EEXIST);
+       } else {
+               dev_warn_once(&drvdata->csdev->dev, "Didn't find TPDM elem size");
+               rc = -EINVAL;
         }
  
         return rc;


