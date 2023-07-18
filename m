Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6155B7570C9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 02:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbjGRAJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 20:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbjGRAJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 20:09:31 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A5C1EA;
        Mon, 17 Jul 2023 17:09:30 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36HNrVci019674;
        Tue, 18 Jul 2023 00:09:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=XYvbXZFQHNWDhtdSXvuSd3d1HErz25XrAxXaXudI3P0=;
 b=Gc8Q5FwomTsuBU0YVWnTedAl7lNRs6AQwLiWw4ZCBWTtlsmWor6ok3RP+YYlMfVxblbe
 QXe41f3GeY53qoTLYlD5F7UifLa1Wx7/0PA+N6Twpoas+b0hutryap0A6dWgH8muoZVm
 WiJHvVYYSyKjmXD3jlgNZVOa4GydxaLxoE+oK2DXN0H5JskxiN4f1bh4z3Kry6dKYbw/
 JiXiW3rlZuz+mpEFjAHSF+jYXZHppgTgbVnjbo5WPzMUFKyDVhl5zafXpaGhgs+yuziI
 UdrZM7HnpsR5eSINzHJPT7gP97pauWhn1K1HV3PhlyAz/F0ts2zFhZRE1InfzxM8EMSn IQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rw33mhrwt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jul 2023 00:09:25 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36I09Oet005700
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Jul 2023 00:09:24 GMT
Received: from abhinavk-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 17 Jul 2023 17:09:24 -0700
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
To:     <freedreno@lists.freedesktop.org>,
        Jonathan Marek <jonathan@marek.ca>
CC:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        "Sean Paul" <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kalyan Thota <quic_kalyant@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/msm/dpu: add missing flush and fetch bits for DMA4/DMA5 planes
Date:   Mon, 17 Jul 2023 17:09:00 -0700
Message-ID: <168963883881.11551.17496142185890829441.b4-ty@quicinc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230704160106.26055-1-jonathan@marek.ca>
References: <20230704160106.26055-1-jonathan@marek.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Kd-Tuqz3TLdMe98Jz9xnsYIRjaKOxN-s
X-Proofpoint-ORIG-GUID: Kd-Tuqz3TLdMe98Jz9xnsYIRjaKOxN-s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-17_15,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 clxscore=1011 lowpriorityscore=0 bulkscore=0
 adultscore=0 phishscore=0 spamscore=0 mlxlogscore=545 suspectscore=0
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307170219
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 04 Jul 2023 12:01:04 -0400, Jonathan Marek wrote:
> Note that with this, DMA4/DMA5 are still non-functional, but at least
> display *something* in modetest instead of nothing or underflow.
> 
> 

Applied, thanks!

[1/1] drm/msm/dpu: add missing flush and fetch bits for DMA4/DMA5 planes
      https://gitlab.freedesktop.org/drm/msm/-/commit/ba7a94ea7312

Best regards,
-- 
Abhinav Kumar <quic_abhinavk@quicinc.com>
