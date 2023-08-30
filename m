Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1417A78DE15
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344126AbjH3S5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245710AbjH3P4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 11:56:24 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27645193;
        Wed, 30 Aug 2023 08:56:22 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37U6pHfg024626;
        Wed, 30 Aug 2023 10:55:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        PODMain02222019; bh=3dzD33JpTIb1IXTJYjGhku5OWoUY4QPiqST5/HxVc5E=; b=
        A5P3fCv344ZfEcILzif6wwUNn+lfKIwYlJoH5t2jPJ2XQhLSK5Bw+/Pbn8lzNqsk
        JlFCvN/YlcUOyMeerHoq7gkZ3YbJUERSYxTFgPbMz7y9Cx92xEeWECrdLG8tOndD
        dIeZ4kW+FZ8j/dJxTY+IbKBXRo95w2H2p5ZxULjmeOttVk2AhSi0ud28bUcjKrQP
        yM4wexvPspQvHaUKC7+D7BPmi7CNhuaudWbInhcb+zEdWI/5ZdVRiFtiXUmPyT+l
        x6oB3bhmv20As4mWjo5Odj7kQQhfUSXg2uFTRltlHhnJjuYQtHM4Pnlyd+pD4TRz
        sf0gwLwkwbkHec2pgbOShw==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3sqesyd5yy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Aug 2023 10:55:56 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Wed, 30 Aug
 2023 16:55:54 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.37 via Frontend Transport; Wed, 30 Aug 2023 16:55:54 +0100
Received: from [141.131.145.49] (vkarpovich-ThinkStation-P620.ad.cirrus.com [141.131.145.49])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 8BB6B3561;
        Wed, 30 Aug 2023 15:55:52 +0000 (UTC)
Message-ID: <d1ed5bf6-24e7-53d7-512b-ceab9e0a7e3d@opensource.cirrus.com>
Date:   Wed, 30 Aug 2023 10:55:51 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 4/7] ASoC: cs35l45: Analog PCM Volume and Amplifier Mode
 controls
To:     Mark Brown <broonie@kernel.org>
CC:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20230828170525.335671-1-vkarpovi@opensource.cirrus.com>
 <20230828170525.335671-4-vkarpovi@opensource.cirrus.com>
 <ZOz35ABAsLYROJ4c@finisterre.sirena.org.uk>
Content-Language: en-US
From:   Vlad Karpovich <vkarpovi@opensource.cirrus.com>
In-Reply-To: <ZOz35ABAsLYROJ4c@finisterre.sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: e2iMeLiTaODRK9vNMFprx6UEquKePOdE
X-Proofpoint-GUID: e2iMeLiTaODRK9vNMFprx6UEquKePOdE
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/28/23 14:39, Mark Brown wrote:
> On Mon, Aug 28, 2023 at 12:05:22PM -0500, Vlad Karpovich wrote:
>
>> +static int cs35l45_amplifier_mode_put(struct snd_kcontrol *kcontrol,
>> +				      struct snd_ctl_elem_value *ucontrol)
>> +{
>> +	snd_soc_component_enable_pin_unlocked(component, "SPK");
>> +	snd_soc_dapm_sync_unlocked(dapm);
>> +	snd_soc_dapm_mutex_unlock(dapm);
>> +	cs35l45->amplifier_mode = ucontrol->value.integer.value[0];
>> +	return 0;
>> +}
> This should return 1 on change (I did see that there's some code which
> generates notifications but it would still be better to flag changes
> here, it makes review a lot easier).
Thanks. I will update patch.
