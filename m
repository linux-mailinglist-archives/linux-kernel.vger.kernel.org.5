Return-Path: <linux-kernel+bounces-148363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A8F28A8181
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 12:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B74C281B88
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BCA313C667;
	Wed, 17 Apr 2024 10:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fWfIklpk"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D636A339;
	Wed, 17 Apr 2024 10:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713351518; cv=none; b=XkVlRAnKONR7gOdRA1aaTZ8THf6kiYvUq6d6gh5jz3jMNvKkwnEc0On+JJnwcp5PRY7xMrcXaRRQkwetbq5ktI6WDZ76OhftS5Mv1jlm+E2AF2RibClt50LyQl0aN2GoZ7fgGOa+Z+0bx3pbamZFaOPPpZSm8RFIi/9UOFILRAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713351518; c=relaxed/simple;
	bh=SNVazwiMQ5C8eyrrteSEPc4mZUs9cG4xmzqvfMFTSpE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jsIEgbLt+HQ1gpTVTy+M1gLgsA/iPnI2MEIrwyKFNlgiiLfX3+P8W4ZwI4bbLV0pjgg5gzsex+bLrCAyXYjpOGu0sexPI2vWFo7aOG5FZb4ewANmNdNvxKzMqooTmoeUaBREcgLX+cjj7Dw8Ga7A4evV6KIWwsmufbjvYSNwDRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fWfIklpk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43H4uIWR006244;
	Wed, 17 Apr 2024 10:58:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=0FA6D6EwooxpxC4s55Atr
	J31my9cp0N6vLFBY6dE2mw=; b=fWfIklpkhWMkrw8FwPEfr3Aq7LQ1FRWiJdBEC
	IHA4NDM6EGxzicEB9UPu4N0/rwqqq/VfCSnnPeXOlUWW1LY0qVmLaykNqZwhmXOX
	UDwcSQ44BryjRwnrikRumhwFl61mpgKKVU1+81m9pGE0VBTuJepTyZcqD9Xzj3cO
	/cfHon/ZQblXQMocTSqmcHM5gzyax5wgeSl2C3XRJaN1sUajaO9l+S3qb/zRsoB9
	uzQQlcIOEFZ3ZhH0qgW5iKng1HXppkZaRTFZ16nqZUOQSbsoSOfIe3oAqyGQc0ie
	PLXu6yMawGq2wjplDVekQYTL5BjQQilv2ntkr7lqBva+5MWXQ==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xj7tr0rfr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 10:58:32 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43HAwVQS019648
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 10:58:31 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 17 Apr 2024 03:58:26 -0700
Date: Wed, 17 Apr 2024 16:28:22 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Konrad Dybcio <konrad.dybcio@linaro.org>, <andersson@kernel.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <djakov@kernel.org>,
        <dmitry.baryshkov@linaro.org>, <quic_anusha@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v7 1/5] dt-bindings: interconnect: Add Qualcomm IPQ9574
 support
Message-ID: <Zh+rThVyLZr0wovp@hu-varada-blr.qualcomm.com>
References: <Zg5q6mnWtK6hmPBT@hu-varada-blr.qualcomm.com>
 <ZhTxFVDH0xTSkw7r@hu-varada-blr.qualcomm.com>
 <1ec401be-11cb-416a-9eae-d72ea8acf06f@kernel.org>
 <ZhUghsa5Do5m7wrX@hu-varada-blr.qualcomm.com>
 <a0173a13-5f20-4e24-8417-afce5fdbda0e@kernel.org>
 <ZhZjuCkJrtPbwtS/@hu-varada-blr.qualcomm.com>
 <70d0afa7-4990-4180-8dfa-cdf267e4c7a2@kernel.org>
 <f1b0d280-6986-4055-a611-2caceb15867d@linaro.org>
 <82e5503c-0710-4b17-af79-8dece4794ec8@kernel.org>
 <Zhj/v+AfzHlUCwRg@hu-varada-blr.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Zhj/v+AfzHlUCwRg@hu-varada-blr.qualcomm.com>
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Z1drpk5lpOkUn-HsXe6z5rTxwDPrASnp
X-Proofpoint-GUID: Z1drpk5lpOkUn-HsXe6z5rTxwDPrASnp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-17_08,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 adultscore=0 suspectscore=0 impostorscore=0 phishscore=0 mlxlogscore=999
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404170075

On Fri, Apr 12, 2024 at 03:02:47PM +0530, Varadarajan Narayanan wrote:
> On Wed, Apr 10, 2024 at 02:01:00PM +0200, Krzysztof Kozlowski wrote:
> > On 10/04/2024 13:48, Konrad Dybcio wrote:
> > >
> > >
> > > On 4/10/24 13:15, Krzysztof Kozlowski wrote:
> > >> On 10/04/2024 12:02, Varadarajan Narayanan wrote:
> > >>>> Okay, so what happens if icc-clk way of generating them changes a bit?
> > >>>> It can change, why not, driver implementation is not an ABI.
> > >>>>
> > >>>>>
> > >>>>> 	2. These auto-generated id-numbers have to be correctly
> > >>>>> 	   tied to the DT nodes. Else, the relevant clocks may
> > >>>>> 	   not get enabled.
> > >>>>
> > >>>> Sorry, I don't get, how auto generated ID number is tied to DT node.
> > >>>> What DT node?
> > >>>
> > >>> I meant the following usage for the 'interconnects' entry of the
> > >>> consumer peripheral's node.
> > >>>
> > >>> 	interconnects = <&gcc MASTER_ANOC_PCIE0 &gcc SLAVE_ANOC_PCIE0>,
> > >>> 			      ^^^^^^^^^^^^^^^^^      ^^^^^^^^^^^^^^^^
> > >>> 			<&gcc MASTER_SNOC_PCIE0 &gcc SLAVE_SNOC_PCIE0>;
> > >>> 			      ^^^^^^^^^^^^^^^^^      ^^^^^^^^^^^^^^^^
> > >>>
> > >>>>> Since ICC-CLK creates two ids per clock entry (one MASTER_xxx and
> > >>>>> one SLAVE_xxx), using those MASTER/SLAVE_xxx macros as indices in
> > >>>>> the below array would create holes.
> > >>>>>
> > >>>>> 	static int icc_ipq9574_hws[] = {
> > >>>>> 		[MASTER_ANOC_PCIE0] = GCC_ANOC_PCIE0_1LANE_M_CLK,
> > >>>>> 		[MASTER_SNOC_PCIE0] = GCC_SNOC_PCIE0_1LANE_S_CLK,
> > >>>>> 		[MASTER_ANOC_PCIE1] = GCC_ANOC_PCIE1_1LANE_M_CLK,
> > >>>>> 		[MASTER_SNOC_PCIE1] = GCC_SNOC_PCIE1_1LANE_S_CLK,
> > >>>>> 		. . .
> > >>>>> 	};
> > >>>>>
> > >>>>> Other Qualcomm drivers don't have this issue and they can
> > >>>>> directly use the MASTER/SLAVE_xxx macros.
> > >>>>
> > >>>> I understand, thanks, yet your last patch keeps adding fake IDs, means
> > >>>> IDs which are not part of ABI.
> > >>>>
> > >>>>>
> > >>>>> As the MASTER_xxx macros cannot be used, have to define a new set
> > >>>>> of macros that can be used for indices in the above array. This
> > >>>>> is the reason for the ICC_BINDING_NAME macros.
> > >>>>
> > >>>> Then maybe fix the driver, instead of adding something which is not an
> > >>>> ABI to bindings and completely skipping the actual ABI.
> > >>>
> > >>> Will remove the ICC_xxx defines from the header. And in the
> > >>> driver will change the declaration as follows. Will that be
> > >>> acceptable?
> > >>>
> > >>> 	static int icc_ipq9574_hws[] = {
> > >>> 		[MASTER_ANOC_PCIE0 / 2] = GCC_ANOC_PCIE0_1LANE_M_CLK,
> > >>
> > >> What is the binding in such case? What exactly do you bind between
> > >> driver and DTS?
> > >
> > > I think what Krzysztof is trying to say here is "the icc-clk API is tragic"
> > > and the best solution would be to make it such that the interconnect indices
> > > are set explicitly, instead of (master, slave), (master, slave) etc.
> > >
> > > Does that sound good, Krzysztof?
> >
> > Yes, I think earlier I expressed that icc-clk might needs fixes.
>
> Ok
>
> > The indices you define in the binding must be used by DTS and by the driver.
>
> There are 3 drivers in play here.
> 	1. The icc-clk driver
> 	2. The gcc (i.e. the interconnect driver)
> 	3. The consumer peripheral's driver
>
> By 'driver' I assume, you mean the icc-clk driver.
>
> > Directly, otherwise it is error-prone and not really an ABI...
>
> To address this, will modify the icc-clk driver as follows.
>
> 	==========================================
> 	diff --git a/include/linux/interconnect-clk.h b/include/linux/interconnect-clk.h
> 	index 5c611a8b0892..9bcee3e9c56c 100644
> 	--- a/include/linux/interconnect-clk.h
> 	+++ b/include/linux/interconnect-clk.h
> 	@@ -11,6 +11,8 @@ struct device;
> 	 struct icc_clk_data {
> 		struct clk *clk;
> 		const char *name;
> 	+	unsigned int master_id;
> 	+	unsigned int slave_id;
> 	 };
>
>
> 	diff --git a/drivers/interconnect/icc-clk.c b/drivers/interconnect/icc-clk.c
> 	index bce946592c98..f788db15cd76 100644
> 	--- a/drivers/interconnect/icc-clk.c
> 	+++ b/drivers/interconnect/icc-clk.c
> 	@@ -108,7 +108,7 @@ struct icc_provider *icc_clk_register(struct device *dev,
> 		for (i = 0, j = 0; i < num_clocks; i++) {
> 			qp->clocks[i].clk = data[i].clk;
>
> 	-		node = icc_node_create(first_id + j);
> 	+		node = icc_node_create(first_id + data[i].master_id);
> 			if (IS_ERR(node)) {
> 				ret = PTR_ERR(node);
> 				goto err;
> 	@@ -118,10 +118,10 @@ struct icc_provider *icc_clk_register(struct device *dev,
> 			node->data = &qp->clocks[i];
> 			icc_node_add(node, provider);
> 			/* link to the next node, slave */
> 	-		icc_link_create(node, first_id + j + 1);
> 	+		icc_link_create(node, first_id + data[i].slave_id);
> 			onecell->nodes[j++] = node;
>
> 	-		node = icc_node_create(first_id + j);
> 	+		node = icc_node_create(first_id + data[i].slave_id);
> 			if (IS_ERR(node)) {
> 				ret = PTR_ERR(node);
> 				goto err;
> 	==========================================
>
> And update the inputs going from gcc-ipq9574.c accordingly
> to use the MASTER_xxx and SLAVE_xxx defines. Will this be ok?
>
> Konrad & Krzysztof kindly let me know.

Have addressed these and other comments and posted v8.
Please review.

Thanks
Varada

