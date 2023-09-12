Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AABA79CACD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 11:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233135AbjILJAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 05:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233117AbjILJAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 05:00:14 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E2DA9;
        Tue, 12 Sep 2023 02:00:10 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38C4OcMw001858;
        Tue, 12 Sep 2023 08:59:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=E89geItkUqH/cKueZHtRw065IAyLmJuQaD/AAZu+cqA=;
 b=gXDletRHeI87yse2gdV3wXYZV8ionJoL2L/Rt3Pz0/mHJigXjTN4aoi6Gb7ugVyY5IRu
 zS2V/6LsVJltTmTel6/lTQIDusyDS3LalvYjYcN4fshIoaWyUMFfPetY0zGPpStnONDG
 +nJuWALhJeMvnzCp6eM7nZZk5ThSz4Qu9G7SFV3Dln2V3RDqLe7gdPFVr3P87mthKicd
 MDomgb/K0RL6ndbTWXNMMCOfUTkgBoa4YIsJmy9lhXJ63l1S6GpxTfKuMxy/1iOJ6M8M
 0feY7kFEGXSwAfqggUAwmxQz4neajoEd5BDP5LzQASQePSKlkqItgQKj3jxP6c7NSPSR Jw== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t22kpjgqk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Sep 2023 08:59:55 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38C8xsRI016164
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Sep 2023 08:59:54 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Tue, 12 Sep 2023 01:59:48 -0700
Date:   Tue, 12 Sep 2023 14:29:45 +0530
From:   Varadarajan Narayanan <quic_varada@quicinc.com>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     <ilia.lin@kernel.org>, <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <quic_kathirav@quicinc.com>, <linux-pm@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
Subject: Re: [PATCH v1 04/10] clk: qcom: apss-ipq6018: ipq5332: add safe
 source switch for a53pll
Message-ID: <20230912085944.GA25503@varda-linux.qualcomm.com>
References: <cover.1693996662.git.quic_varada@quicinc.com>
 <5e3c29df2b42cceb8072b00546a78e1b99b2d374.1693996662.git.quic_varada@quicinc.com>
 <CAA8EJppXxiX7+6nhfKyJYDU0i2pkBzXL5J3EQUapLJXxx3b=HA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAA8EJppXxiX7+6nhfKyJYDU0i2pkBzXL5J3EQUapLJXxx3b=HA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: e2jtLxXIhdDwgNkw2o5L3kssm-0Bzteb
X-Proofpoint-GUID: e2jtLxXIhdDwgNkw2o5L3kssm-0Bzteb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-12_06,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=999
 spamscore=0 clxscore=1015 phishscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309120076
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2023 at 04:54:56PM +0300, Dmitry Baryshkov wrote:
> On Thu, 7 Sept 2023 at 08:22, Varadarajan Narayanan
> <quic_varada@quicinc.com> wrote:
> >
> > Stromer Plus PLL found on IPQ53xx doesn't support dynamic
> > frequency scaling. To achieve the same, we need to park the APPS
> > PLL source to GPLL0, re configure the PLL and then switch the
> > source to APSS_PLL_EARLY.
> >
> > To support this, register a clock notifier to get the PRE_RATE
> > and POST_RATE notification. Change the APSS PLL source to GPLL0
> > when PRE_RATE notification is received, then configure the PLL
> > and then change back the source to APSS_PLL_EARLY.
>
> This means that we are changing the parents behind the back of CCF,
> which is not great.

Unfortunately, we are not aware of any other way to do this.
Please let me know if there is a better way to do this, will
implement that and post a revision.

> > Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
> > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > ---
> >  drivers/clk/qcom/apss-ipq6018.c | 54 ++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 53 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/clk/qcom/apss-ipq6018.c b/drivers/clk/qcom/apss-ipq6018.c
> > index 4e13a08..ffb6ab5 100644
> > --- a/drivers/clk/qcom/apss-ipq6018.c
> > +++ b/drivers/clk/qcom/apss-ipq6018.c
> > @@ -9,8 +9,11 @@
> >  #include <linux/clk-provider.h>
> >  #include <linux/regmap.h>
> >  #include <linux/module.h>
> > +#include <linux/clk.h>
> > +#include <linux/soc/qcom/smem.h>
> >
> >  #include <dt-bindings/clock/qcom,apss-ipq.h>
> > +#include <dt-bindings/arm/qcom,ids.h>
> >
> >  #include "common.h"
> >  #include "clk-regmap.h"
> > @@ -84,15 +87,64 @@ static const struct qcom_cc_desc apss_ipq6018_desc = {
> >         .num_clks = ARRAY_SIZE(apss_ipq6018_clks),
> >  };
> >
> > +static int cpu_clk_notifier_fn(struct notifier_block *nb, unsigned long action,
> > +                               void *data)
> > +{
> > +       u8 index;
> > +       int err;
> > +
> > +       if (action == PRE_RATE_CHANGE)
> > +               index = P_GPLL0;
>
> I don't see P_GPLL0 being supported in the ipq6018 driver.

This comes from one of the dependency patches mentioned in the
cover letter [https://lore.kernel.org/linux-arm-msm/20230904-gpll_cleanup-v1-0-de2c448f1188@quicinc.com/].
Please refer to patch https://lore.kernel.org/linux-arm-msm/20230904-gpll_cleanup-v1-6-de2c448f1188@quicinc.com/.

>
> > +       else if (action == POST_RATE_CHANGE)
> > +               index = P_APSS_PLL_EARLY;
>
> You also have to handle ABORT_RATE_CHANGE here.

ok.

> > +       else
> > +               return 0;
> > +
> > +       err = clk_rcg2_mux_closest_ops.set_parent(&apcs_alias0_clk_src.clkr.hw,
> > +                                                 index);
> > +
> > +       return notifier_from_errno(err);
> > +}
> > +
> > +static struct notifier_block cpu_clk_notifier = {
> > +       .notifier_call = cpu_clk_notifier_fn,
> > +};
> > +
> >  static int apss_ipq6018_probe(struct platform_device *pdev)
> >  {
> >         struct regmap *regmap;
> > +       u32 soc_id;
> > +       int ret;
> > +
> > +       ret = qcom_smem_get_soc_id(&soc_id);
> > +       if (ret)
> > +               return ret;
> >
> >         regmap = dev_get_regmap(pdev->dev.parent, NULL);
> >         if (!regmap)
> >                 return -ENODEV;
> >
> > -       return qcom_cc_really_probe(pdev, &apss_ipq6018_desc, regmap);
> > +       ret = qcom_cc_really_probe(pdev, &apss_ipq6018_desc, regmap);
> > +       if (ret)
> > +               return ret;
> > +
> > +       switch (soc_id) {
> > +       /*
> > +        * Only below variants of IPQ53xx support scaling
> > +        */
> > +       case QCOM_ID_IPQ5332:
> > +       case QCOM_ID_IPQ5322:
> > +       case QCOM_ID_IPQ5300:
>
> Please use compat strings instead of using the soc-id.

We have a common compatible string for all IPQ53xx CPUs across
boards.  The CPU variant is identified from fuse settings. Not
sure how we can differentiate between the variants using compat
strings. Can you kindly help.

Thanks
varada

> > +               ret = clk_notifier_register(apcs_alias0_clk_src.clkr.hw.clk,
> > +                                               &cpu_clk_notifier);
> > +               if (ret)
> > +                       return ret;
> > +               break;
> > +       default:
> > +               break;
> > +       }
> > +
> > +       return 0;
> >  }
> >
> >  static struct platform_driver apss_ipq6018_driver = {
> > --
> > 2.7.4
> >
>
>
> --
> With best wishes
>
> Dmitry
