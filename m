Return-Path: <linux-kernel+bounces-85449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F35A786B629
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:37:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADBD0288CD2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 17:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5CA215D5B7;
	Wed, 28 Feb 2024 17:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AGWiRe3y"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3538415A4A6
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 17:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709141858; cv=none; b=dtbMgw21fNyJnKz2Gpbz6vQjtYdgQEneeNJ9+IGUoRYZxwOod+cOuPGJPtlSacymGHAzSEuQlwpyJ3gmI7l7Cq7FdA01bwS5H8uDlZh6NKp/LUb0ottp3t/F1sfKIsV9c5GmAQ8aZcR6bF2ZVp7vgF/H3NgCTm67De++gjw5dLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709141858; c=relaxed/simple;
	bh=K5vXjWuFzqfXiQHwIYXn6UrdW4N4s1//MOqtXlU6ELY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iWkbiyZQLuVuHOPdrqYQtkTih4RpfytAexmR648TgZZKM+vlvvHeMxZDi4Mh8/s+8b1gG87DEV4WPdC4rfPmbYmF1tj/DsIHG/+dbn/5jJcR0tigUBOKslLOLil3Xie876/+yvCGeLwXyXZ/ibn2143atcFuvcAGh2G7iRaV60I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AGWiRe3y; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d2509c66daso81092131fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 09:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709141854; x=1709746654; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NEJOcmSJyiHovminq4Z6drN0TN3lAqEbQkVdApRDykY=;
        b=AGWiRe3yT+QUXe/s3GQK26+8khmaFmA9/nOG7A7LItlXARU7wjXOL2bi5D+MnIIUH8
         OygDcxxfRywiI8emRv0R2n+XTLHOQCSMfBOBCkknlAgSFoINQP/VUPcR3oaDcrLDS2AQ
         klq0pihWLhMLc+Tnfm9cmBBVjViWMTJ43p3PaG1DaUCLOOdHuOnqRCHOL38tkTnzSkWs
         +hT5vmc4nQxwQBzbo3GmJwZaY/2StKKtwTDhp/KL2JCUsZzQXULnPCP41pxP7PUycKKp
         MjUkhQxw/ZbxVchHQ9Qf+HM26LqTFEvcdmdRcmA1h/UK4bSjuthKcVCV1SvbeeUjL+mo
         qDbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709141854; x=1709746654;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NEJOcmSJyiHovminq4Z6drN0TN3lAqEbQkVdApRDykY=;
        b=IiamN/M6HRR52l2NBm4k9EEgJFtb/IPE3FKXoa09RQxja8cqFtTWHOxFE093gAdybK
         qyVNniD4LQ59tdaxFHfcSQMZL4zEx8PyAC11HNd3N7zViBx40IARV1DqlCCUyRIElamf
         3cZyvQyXcGE/F0JP5RtUDUdauxKZ69IRt298KpG2G4aqk5zkVuOwGJ+ltK+G69wDREll
         FJyM7KP5JSuVEN9MdSU3KMRd22coSJWGCIFL9FET65YaYMn0hT1odnhe7IEC9oj5eCd1
         0gqQZLl05A654W936ry9UAJKJJnMZaaGvAF1/ePzoeZPXHZf4lUlcNCcrLVQtFYdpI6g
         OT3w==
X-Forwarded-Encrypted: i=1; AJvYcCUk8oKGXWostMABqKcGSgSbOQbzuYDvO9xsC4q/etpNIZhcYKdRrv4s+8URs6hpoSfUid8hJTF6qumskpeAog2GJCsRGrX+lec2QIQf
X-Gm-Message-State: AOJu0YwrkBof4Tm+DmzlNi+r+0M6taPp32I6UBChCv/YcQwjM94AWYYY
	PQTmF64Uis4Q/DsvcA9/OHVj1dRaMGdoq+PBaSgWGRiaKeDSvtgYmRsndOFi0F8=
X-Google-Smtp-Source: AGHT+IGz9IXs2Xd0N+YFoFclcN3AUCQsChwc/prVkO3luVK398kFo39V3bxxNXGsfGus6d/7m97xMw==
X-Received: by 2002:a2e:b057:0:b0:2d2:e784:abbe with SMTP id d23-20020a2eb057000000b002d2e784abbemr429146ljl.42.1709141854368;
        Wed, 28 Feb 2024 09:37:34 -0800 (PST)
Received: from [172.30.205.146] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id o14-20020a2e9b4e000000b002d2e63069a8sm81831ljj.63.2024.02.28.09.37.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 09:37:33 -0800 (PST)
Message-ID: <be2e475a-349f-4e98-b238-262dd7117a4e@linaro.org>
Date: Wed, 28 Feb 2024 18:37:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/7] dt-bindings: mailbox: qcom: Add CPUCP mailbox
 controller bindings
Content-Language: en-US
To: Rob Herring <robh@kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>
Cc: sudeep.holla@arm.com, cristian.marussi@arm.com, andersson@kernel.org,
 jassisinghbrar@gmail.com, krzysztof.kozlowski+dt@linaro.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, quic_rgottimu@quicinc.com,
 quic_kshivnan@quicinc.com, conor+dt@kernel.org
References: <20240117173458.2312669-1-quic_sibis@quicinc.com>
 <20240117173458.2312669-2-quic_sibis@quicinc.com>
 <20240130171240.GA1929440-robh@kernel.org>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240130171240.GA1929440-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/30/24 18:12, Rob Herring wrote:
> On Wed, Jan 17, 2024 at 11:04:52PM +0530, Sibi Sankar wrote:
>> Add devicetree binding for CPUSS Control Processor (CPUCP) mailbox
>> controller.
>>
>> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
>> ---
>>   .../bindings/mailbox/qcom,cpucp-mbox.yaml     | 51 +++++++++++++++++++
>>   1 file changed, 51 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/mailbox/qcom,cpucp-mbox.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/mailbox/qcom,cpucp-mbox.yaml b/Documentation/devicetree/bindings/mailbox/qcom,cpucp-mbox.yaml
>> new file mode 100644
>> index 000000000000..2617e5555acb
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mailbox/qcom,cpucp-mbox.yaml
>> @@ -0,0 +1,51 @@
>> +# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/mailbox/qcom,cpucp-mbox.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm Technologies, Inc. CPUCP Mailbox Controller
>> +
>> +maintainers:
>> +  - Sibi Sankar <quic_sibis@qti.qualcomm.com>
>> +
>> +description:
>> +  The CPUSS Control Processor (CPUCP) mailbox controller enables communication
>> +  between AP and CPUCP by acting as a doorbell between them.
>> +
>> +properties:
>> +  compatible:
>> +    items:
>> +      - enum:
>> +          - qcom,x1e80100-cpucp-mbox
>> +      - const: qcom,cpucp-mbox
> 
> A generic fallback implies multiple devices use the same unchanged
> block. That seems doubtful given you have not defined any others and
> given Konrad's comments.

FWIW Sibi and I talked about this a bit off-list, this mailbox is
apparently new and has nothing to do with what I mentioned on other
platforms

Konrad

