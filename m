Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDABF7D1075
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 15:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377417AbjJTNYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 09:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377002AbjJTNYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 09:24:41 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E29D1A4;
        Fri, 20 Oct 2023 06:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697808279; x=1729344279;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=n9FPj37TUa187KHzBLooUs4gDeQupW8sJoyGo3Mm6Yw=;
  b=Qmk8fTcmjSTcbH4EFYwbONXXjDCTedR0dul8UCdtq5mBcz1kGOoj/Gnq
   BKXyA0EZaHgGHhZMq7s4l/csWCAY2+5B/8Pj9Y27m4vSdce5Jplqk0gGx
   Yq8R1t8KaDbUKj4y0KymajqcmFVtnPz1KeGrtl9UBnOS++WmPyf/MStTn
   ClhlzWEmOTW+MtE83KTBiRhDfZGLJ2dEyHY3hdpOtsFB/UGoUkShfg46r
   VR81AY4UlXeO22T01IniXHOtS/8f/I071r6x64BKs2169hiG6iRarH4RD
   WTKq0VJlNGnqY81sfHKHIStlZHY4IFVIlD3von5FaoYOTYvYp2/MSE1OK
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="385372627"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="385372627"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 06:24:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="881083831"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="881083831"
Received: from mtadesse-mobl.amr.corp.intel.com (HELO [10.209.140.77]) ([10.209.140.77])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 06:24:37 -0700
Message-ID: <1840ba70-279b-499a-ad42-e7659a9a6ad1@linux.intel.com>
Date:   Thu, 19 Oct 2023 15:39:26 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 30/34] ASoC: qcom: qdsp6: Add SND kcontrol for fetching
 offload status
Content-Language: en-US
To:     Wesley Cheng <quic_wcheng@quicinc.com>, mathias.nyman@intel.com,
        gregkh@linuxfoundation.org, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, srinivas.kandagatla@linaro.org,
        bgoswami@quicinc.com, Thinh.Nguyen@synopsys.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20231017200109.11407-1-quic_wcheng@quicinc.com>
 <20231017200109.11407-31-quic_wcheng@quicinc.com>
 <92971bbf-b890-4e41-8ef1-9213e15d81b2@linux.intel.com>
 <c9c5f13f-b3e7-6591-f277-cd86162152e4@quicinc.com>
 <2e300bef-3722-8b00-2bdf-e9386796f38f@quicinc.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <2e300bef-3722-8b00-2bdf-e9386796f38f@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>>> Add a kcontrol to the platform sound card to fetch the current offload
>>>> status.  This can allow for userspace to ensure/check which USB SND
>>>> resources are actually busy versus having to attempt opening the USB
>>>> SND
>>>> devices, which will result in an error if offloading is active.
>>>
>>> I think I mentioned this a while back, but why not add the status in the
>>> USB card itself? That's a generic component that all userspace agent
>>> could query. Having a QCOM-specific control doesn't make the life of
>>> userspace easier IMHO.
>>>
>>>
>>
>> Will take a look at this based on the comments you had in the other
>> kcontrol patch.  Seeing if we can move it to a more generic layer.
>>
> 
> I think it would make more sense to see if we can keep all the offload
> kcontrols under the sound card exposed by the platform.  Especially, if
> we are going to modify the components string of the card to signify that
> it supports USB offload.

A two-way relationship would be ideal, i.e.
- the USB card has an indicator that it's currently bound with another
"platform" card that offers optimized offloaded capabilities.
- the platform card has a indicator that it exposes one or more PCM
devices routed to the USB card endpoint.

Android/HAL would typically start with the latter while other more
generic solutions would start from the former.
