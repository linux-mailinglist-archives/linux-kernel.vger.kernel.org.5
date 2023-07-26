Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0167641F8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 00:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbjGZWOt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 26 Jul 2023 18:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbjGZWOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 18:14:46 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BCDB270D;
        Wed, 26 Jul 2023 15:14:44 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 1CE5724DB83;
        Thu, 27 Jul 2023 06:14:42 +0800 (CST)
Received: from EXMBX073.cuchost.com (172.16.6.83) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 27 Jul
 2023 06:14:42 +0800
Received: from [192.168.60.107] (180.164.60.184) by EXMBX073.cuchost.com
 (172.16.6.83) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 27 Jul
 2023 06:14:41 +0800
Message-ID: <995e6991-6635-0c0e-d50c-5b6fe2ce6655@starfivetech.com>
Date:   Thu, 27 Jul 2023 06:14:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v7 3/6] media: starfive: camss: Add basic driver
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Eugen Hristev <eugen.hristev@collabora.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
CC:     <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <changhuang.liang@starfivetech.com>
References: <20230619112838.19797-1-jack.zhu@starfivetech.com>
 <20230619112838.19797-4-jack.zhu@starfivetech.com>
 <eb8ff364-1c49-28b4-242d-168828ca7094@linaro.org>
Content-Language: en-US
From:   Jack Zhu <jack.zhu@starfivetech.com>
In-Reply-To: <eb8ff364-1c49-28b4-242d-168828ca7094@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [180.164.60.184]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX073.cuchost.com
 (172.16.6.83)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bryan,

Thank you for your comments.

On 2023/7/26 18:55, Bryan O'Donoghue wrote:
> On 19/06/2023 12:28, Jack Zhu wrote:
> 
>> +static int stfcamss_of_parse_ports(struct stfcamss *stfcamss)
>> +{
>> +    struct device *dev = stfcamss->dev;
>> +    struct device_node *node = NULL;
>> +    int ret, num_subdevs = 0;
>> +
>> +    for_each_endpoint_of_node(dev->of_node, node) {
>> +        struct stfcamss_async_subdev *csd;
>> +
>> +        if (!of_device_is_available(node))
>> +            continue;
>> +
>> +        csd = v4l2_async_nf_add_fwnode_remote(&stfcamss->notifier,
>> +                              of_fwnode_handle(node),
>> +                              struct stfcamss_async_subdev);
>> +        if (IS_ERR(csd)) {
>> +            ret = PTR_ERR(csd);
>> +            goto err_cleanup;
>> +        }
>> +
>> +        ret = stfcamss_of_parse_endpoint_node(dev, node, csd);
>> +        if (ret < 0)
>> +            goto err_cleanup;
>> +
>> +        num_subdevs++;
>> +    }
>> +
>> +    return num_subdevs;
>> +
>> +err_cleanup:
>> +    of_node_put(node);
> 
> Where is the _get() for this and if you are releasing it on the error path when is the _get() released on the non-error path ?
> 

OK, I will fix it.

>> +    return ret;
>> +}
>> +
>> +static int stfcamss_subdev_notifier_bound(struct v4l2_async_notifier *async,
>> +                      struct v4l2_subdev *subdev,
>> +                      struct v4l2_async_subdev *asd)
>> +{
>> +    struct media_pad *pad[STF_PADS_NUM];
>> +    unsigned int i, pad_num = 0;
>> +
>> +    for (i = 0; i < pad_num; ++i) {
> 
> Does this loop ever run ?
> I don't see how it can..
> 

OK, I will fix it, although there are modifications to this code in patch 5 and patch 6.

> ---
> bod

-- 
Regards,

Jack Zhu
