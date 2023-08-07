Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7CF771CED
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 11:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbjHGJNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 05:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjHGJND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 05:13:03 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8F8EEE70;
        Mon,  7 Aug 2023 02:13:01 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 183351FB;
        Mon,  7 Aug 2023 02:13:44 -0700 (PDT)
Received: from [10.57.90.63] (unknown [10.57.90.63])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5157B3F59C;
        Mon,  7 Aug 2023 02:12:58 -0700 (PDT)
Message-ID: <43d94873-53be-d142-9075-a781b9de9f69@arm.com>
Date:   Mon, 7 Aug 2023 10:12:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v7 04/13] coresight-tpda: Add DSB dataset support
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     Tao Zhang <quic_taozha@quicinc.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Jinlong Mao <quic_jinlmao@quicinc.com>,
        Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org
References: <1690269353-10829-1-git-send-email-quic_taozha@quicinc.com>
 <1690269353-10829-5-git-send-email-quic_taozha@quicinc.com>
 <94b9ae0f-b6ed-1d72-f86a-d33842527681@arm.com>
In-Reply-To: <94b9ae0f-b6ed-1d72-f86a-d33842527681@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/08/2023 16:02, Suzuki K Poulose wrote:
> On 25/07/2023 08:15, Tao Zhang wrote:
>> Read the DSB element size from the device tree. Set the register
>> bit that controls the DSB element size of the corresponding port.
>>
>> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
>> ---
>>   drivers/hwtracing/coresight/coresight-tpda.c | 96 
>> +++++++++++++++++++++++++---
>>   drivers/hwtracing/coresight/coresight-tpda.h |  4 ++
>>   2 files changed, 90 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-tpda.c 
>> b/drivers/hwtracing/coresight/coresight-tpda.c
>> index 8d2b9d2..7c71342 100644
>> --- a/drivers/hwtracing/coresight/coresight-tpda.c
>> +++ b/drivers/hwtracing/coresight/coresight-tpda.c
>> @@ -21,6 +21,58 @@
>>   DEFINE_CORESIGHT_DEVLIST(tpda_devs, "tpda");
>> +/* Search and read element data size from the TPDM node in
> 
> minor nit:
> 
> /*
>   * Search ...
> 
>> + * the devicetree. Each input port of TPDA is connected to
>> + * a TPDM. Different TPDM supports different types of dataset,
>> + * and some may support more than one type of dataset.
>> + * Parameter "inport" is used to pass in the input port number
>> + * of TPDA, and it is set to 0 in the recursize call.
> 
>> + * Parameter "parent" is used to pass in the original call.
> 
> Please remove references to the past and describe "match_inport"
> 
>> + */
>> +static int tpda_set_element_size(struct tpda_drvdata *drvdata,
>> +               struct coresight_device *csdev, int inport, bool 
>> match_inport)
> 
> May be we could switch the order of the parameters:
> 
> match_inport, int port
> 
> Or even inport < 0, implies, port wont be matched.
> 
> i.e.,
> 
> tpda_set_element_size(drvdata, child, inport)
> 
>> +{
>> +    static int nr_inport;
>> +    int i;
>> +    static bool tpdm_found;
>> +    struct coresight_device *in_csdev;
>> +
>> +    if (inport > (TPDA_MAX_INPORTS - 1))
>> +        return -EINVAL;
>> +
>> +    if (match_inport) {
>> +        nr_inport = inport;
>> +        tpdm_found = false;
>> +    }
> 
> Could we not avoid the static variables and this dance by making the 
> function return the dsb_size ? See further down.
> 
> 
>> +
>> +    for (i = 0; i < csdev->pdata->nr_inconns; i++) {
>> +        in_csdev = csdev->pdata->in_conns[i]->src_dev;
>> +        if (!in_csdev)
>> +            break;
>          continue ?
>> +
>> +        if (match_inport)
>> +            if (csdev->pdata->in_conns[i]->dest_port != inport)
>> +                continue;
>> +
>> +        if ((in_csdev->type == CORESIGHT_DEV_TYPE_SOURCE) &&
>> +                (in_csdev->subtype.source_subtype
>> +                == CORESIGHT_DEV_SUBTYPE_SOURCE_TPDM)) {
> 
> Please provide a helper :
> 
> static bool coresight_device_is_tpdm(csdev) {
>      return
>       (csdev->type == CORESIGHT_DEV_TYPE_SOURCE) &&
>       (in_csdev->subtype.source_subtype ==
>          CORESIGHT_DEV_SUBTYPE_SOURCE_TPDM);
> }
> 
> 
> 
>> +            of_property_read_u8(in_csdev->dev.parent->of_node,
>> +                    "qcom,dsb-element-size", 
>> &drvdata->dsb_esize[nr_inport]);
> 
> 
> 
>> +            if (!tpdm_found)
>> +                tpdm_found = true;
>> +            else
>> +                dev_warn(drvdata->dev,
>> +                    "More than one TPDM is mapped to the TPDA input 
>> port %d.\n",
>> +                    nr_inport);
>> +            continue;
>> +        }
>> +        tpda_set_element_size(drvdata, in_csdev, 0, false);
>> +    }
>> +
> 
> /*
>   * Read the DSB element size from the TPDM device
>   * Returns
>   *    the size read from the firmware if available.
>   *    0 - Otherwise, with a Warning once.
>   */
> static int tpdm_read_dsb_element_size(struct coresight_device *csdev)
> {
>      int rc, size = 0;
> 
>      rc = fwnode_property_read_u8(dev_fwnode(csdev->dev.parent),
>                       "qcom,dsb-element-size", &size);
>      if (rc)
>          dev_warn_once(&in->dev, "Failed to read TPDM DSB Element size: 
> %d\n",
>          rc);
>      return size;
> }
> 
> static int tpda_get_element_size(struct coresight_device *csdev,
>                   int inport)
> {
>      int dsb_size = -ENOENT;
> 
>      for (i = 0; i < csdev->pdata->nr_inconns; i++) {
>          in = csdev->pdata->in_conns[i]->src_dev;
>          if (!in)
>              continue;
>          if (coresight_device_is_tpdm(in)) {
>              /* Ignore the TPDMs that do not match port */
>              if (inport > 0 &&
>                  (csdev->pdata->in_conns[i]->dest_port !=
>                  inport))
>                  continue;
>              size = tpdm_read_dsb_element_size(csdev);
>          } else {
>              /* Recurse down the path */
>              size = tpda_set_element_size(in, -1);
>          }
> 
>          if (size < 0)
>              return size;
>          /* We have found a size, save it. */
>          if (dsb_size < 0) {
>              dsb_size = size;
>          } else {
>              /* We have duplicate TPDMs */
>              return -EEXIST;
>          }
>      }
>      return dsb_size;
> }
> 
> 
> 
> 
>> +    return 0;
>> +}
>> +
>>   /* Settings pre enabling port control register */
>>   static void tpda_enable_pre_port(struct tpda_drvdata *drvdata)
>>   {
>> @@ -32,26 +84,43 @@ static void tpda_enable_pre_port(struct 
>> tpda_drvdata *drvdata)
>>       writel_relaxed(val, drvdata->base + TPDA_CR);
>>   }
>> -static void tpda_enable_port(struct tpda_drvdata *drvdata, int port)
>> +static int tpda_enable_port(struct tpda_drvdata *drvdata, int port)
>>   {
>>       u32 val;
>>       val = readl_relaxed(drvdata->base + TPDA_Pn_CR(port));
>> +    /*
>> +     * Configure aggregator port n DSB data set element size
>> +     * Set the bit to 0 if the size is 32
>> +     * Set the bit to 1 if the size is 64
>> +     */
>> +    if (drvdata->dsb_esize[port] == 32)
>> +        val &= ~TPDA_Pn_CR_DSBSIZE;
>> +    else if (drvdata->dsb_esize[port] == 64)
>> +        val |= TPDA_Pn_CR_DSBSIZE;
> 
> Couldn't this be detected via tpda_get_element_size()? see below.
> 
>> +    else
>> +        return -EINVAL;
>> +
>>       /* Enable the port */
>>       val |= TPDA_Pn_CR_ENA;
>>       writel_relaxed(val, drvdata->base + TPDA_Pn_CR(port));
>> +
>> +    return 0;
>>   }
>> -static void __tpda_enable(struct tpda_drvdata *drvdata, int port)
>> +static int __tpda_enable(struct tpda_drvdata *drvdata, int port)
>>   {
>> +    int ret;
>> +
>>       CS_UNLOCK(drvdata->base);
>>       if (!drvdata->csdev->enable)
>>           tpda_enable_pre_port(drvdata);
>> -    tpda_enable_port(drvdata, port);
>> -
>> +    ret = tpda_enable_port(drvdata, port);
>>       CS_LOCK(drvdata->base);
>> +
>> +    return ret;
>>   }
>>   static int tpda_enable(struct coresight_device *csdev,
>> @@ -59,16 +128,23 @@ static int tpda_enable(struct coresight_device 
>> *csdev,
>>                  struct coresight_connection *out)
>>   {
>>       struct tpda_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>> +    int ret;
>> +
>> +    ret = tpda_set_element_size(drvdata, csdev, in->dest_port, true);
> 
>      size  = tpda_get_element_size(csdev, in->dest_port);
>      switch (size) {
>      case 32:
>      case 64:
>          break;

We also need :

	case 0:
		return -ENOENT;

Suzuki


>      case -EEXIST:
>          dev_warn_once("Detected multiple TPDMs on port %d", ..)
>          fallthrough;
>      default:
>          return size;
>      }
> 
>      drvdata->dsb_esize[in->dest_port] = size;
> 
> Suzuki
> 
> 
> 
>> +    if (ret)
>> +        return ret;
>>       spin_lock(&drvdata->spinlock);
>> -    if (atomic_read(&in->dest_refcnt) == 0)
>> -        __tpda_enable(drvdata, in->dest_port);
>> +    if (atomic_read(&in->dest_refcnt) == 0) {
>> +        ret = __tpda_enable(drvdata, in->dest_port);
>> +        if (!ret) {
>> +            atomic_inc(&in->dest_refcnt);
>> +            dev_dbg(drvdata->dev, "TPDA inport %d enabled.\n", 
>> in->dest_port);
>> +        }
>> +    }
>> -    atomic_inc(&in->dest_refcnt);
>>       spin_unlock(&drvdata->spinlock);
>> -
>> -    dev_dbg(drvdata->dev, "TPDA inport %d enabled.\n", in->dest_port);
>> -    return 0;
>> +    return ret;
>>   }
>>   static void __tpda_disable(struct tpda_drvdata *drvdata, int port)
>> diff --git a/drivers/hwtracing/coresight/coresight-tpda.h 
>> b/drivers/hwtracing/coresight/coresight-tpda.h
>> index 0399678..12a1472 100644
>> --- a/drivers/hwtracing/coresight/coresight-tpda.h
>> +++ b/drivers/hwtracing/coresight/coresight-tpda.h
>> @@ -10,6 +10,8 @@
>>   #define TPDA_Pn_CR(n)        (0x004 + (n * 4))
>>   /* Aggregator port enable bit */
>>   #define TPDA_Pn_CR_ENA        BIT(0)
>> +/* Aggregator port DSB data set element size bit */
>> +#define TPDA_Pn_CR_DSBSIZE        BIT(8)
>>   #define TPDA_MAX_INPORTS    32
>> @@ -23,6 +25,7 @@
>>    * @csdev:      component vitals needed by the framework.
>>    * @spinlock:   lock for the drvdata value.
>>    * @enable:     enable status of the component.
>> + * @dsb_esize:  DSB element size for each inport, it must be 32 or 64.
>>    */
>>   struct tpda_drvdata {
>>       void __iomem        *base;
>> @@ -30,6 +33,7 @@ struct tpda_drvdata {
>>       struct coresight_device    *csdev;
>>       spinlock_t        spinlock;
>>       u8            atid;
>> +    u8            dsb_esize[TPDA_MAX_INPORTS];
>>   };
>>   #endif  /* _CORESIGHT_CORESIGHT_TPDA_H */
> 

