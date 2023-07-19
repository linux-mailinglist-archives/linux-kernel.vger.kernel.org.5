Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14C44758FEB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 10:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbjGSILW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 04:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjGSILT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 04:11:19 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D7D1B6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 01:10:53 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fbea147034so61417275e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 01:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1689754252; x=1690359052;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DB8criZo6AbFo5qjEs0dVBSfJlNbNWGYcf/cf1O+Q8E=;
        b=JT/wM98mQbJ6ia2uQQPCmPE6EnHODf6qSp3Fn5jk+PJun5XjQCksasfNWUWVQ8OhD+
         rmxUvnuEdLSrCdv4j79PBCzvoYFMQmjLNUfHsePnysaFTHtzqHCT4i1ybRLQTCvTKZso
         ss/jbIj9tXnMEe3L7Qrwxm2zsJQpF4FnEjGytizn6s3zcF+xdQTfd0+wRB1pWyoisuFy
         PSWgUE6Z0DSqoCfSZRlLedDbcQDbkoziVT2GMy6w5qrZMTe8UJLGwv7VjGhDqu1K3WSh
         HR/FqU+b7YPbxNIK32Hnj+XHe7HzvMdixJpL8UHCBoQmdletTr3vMVEYaE8SPt621+nl
         FHBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689754252; x=1690359052;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DB8criZo6AbFo5qjEs0dVBSfJlNbNWGYcf/cf1O+Q8E=;
        b=UoQEM7fUT4jYEVAbgpRXKxWSOCyfkog/g1S6XW9O7Xp6jamKZE8sNGNrcMBZfziivZ
         lKYVZGU22b7CsP/XVwfr7BEX7qtcHywPvtEDdLfIN6j3n/1Kdr+CHCkz+xFohKL6r6S6
         Wcizeb8dnnzHAvHJ5jAI7AEEU4+knhe2hB2lGkeKLtZE/5Ad4tZjoZzEqhEu3LR6Q7KT
         yRORuey7cQ+3Ps6Pe3iSLKxQSq5gOIrEcAzfoy36zEKa7fQO6lZdMuNTbuBbrx1N59t1
         awBDu/GYb2cQA7O6IcgsgyXuJDKP486FiNOHs3CPNhBfvpy+KgJA1AX2+E4qAJE/RfuK
         k4qg==
X-Gm-Message-State: ABy/qLbknnfMKEuwhp1KJ9IYyGnc6nM1gxdSYri/i1NCxBGZKKIbP5m7
        /Pba/FrVrgCZ7M13+Q2ZnoJpLg==
X-Google-Smtp-Source: APBJJlEBFVOmFB+WVGVADDPKUznecdigzGyP+Ynvi9/LBFS6Ki5yO1dCyRU/KhCg1u1K5YNfCmCCLA==
X-Received: by 2002:a1c:7709:0:b0:3f5:878:c0c2 with SMTP id t9-20020a1c7709000000b003f50878c0c2mr1335024wmi.3.1689754252431;
        Wed, 19 Jul 2023 01:10:52 -0700 (PDT)
Received: from localhost ([95.148.15.113])
        by smtp.gmail.com with ESMTPSA id n19-20020a7bc5d3000000b003fc02e8ea68sm1073654wmk.13.2023.07.19.01.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 01:10:52 -0700 (PDT)
From:   Punit Agrawal <punit.agrawal@bytedance.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Punit Agrawal <punit.agrawal@bytedance.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Vikram Sethi <vsethi@nvidia.com>,
        Shanker Donthineni <sdonthineni@nvidia.com>
Subject: Re: [External] Re: [PATCH] firmware: smccc: Fix use of
 uninitialised results structure
In-Reply-To: <20230718084842.6edna54m5njijdiz@bogus> (Sudeep Holla's message
        of "Tue, 18 Jul 2023 09:48:42 +0100")
References: <20230717171702.424253-1-punit.agrawal@bytedance.com>
        <86351lvcl9.wl-maz@kernel.org> <20230718084842.6edna54m5njijdiz@bogus>
Date:   Wed, 19 Jul 2023 09:10:51 +0100
Message-ID: <87a5vsb9tg.fsf@bytedance.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sudeep Holla <sudeep.holla@arm.com> writes:

> On Tue, Jul 18, 2023 at 09:38:26AM +0100, Marc Zyngier wrote:
>> On Mon, 17 Jul 2023 18:17:02 +0100,
>> Punit Agrawal <punit.agrawal@bytedance.com> wrote:
>> > 
>> > Commit 35727af2b15d ("irqchip/gicv3: Workaround for NVIDIA erratum
>> > T241-FABRIC-4") moved the initialisation of the SoC version to
>> > arm_smccc_version_init() but forgot to update the results structure
>> > and it's usage.
>> > 
>> > Fix the use of the uninitialised results structure and update the
>> > error strings.
>> > 
>> > Fixes: 35727af2b15d ("irqchip/gicv3: Workaround for NVIDIA erratum T241-FABRIC-4")
>> > Signed-off-by: Punit Agrawal <punit.agrawal@bytedance.com>
>> > Cc: Sudeep Holla <sudeep.holla@arm.com>
>> > Cc: Marc Zyngier <maz@kernel.org>
>> > Cc: Vikram Sethi <vsethi@nvidia.com>
>> > Cc: Shanker Donthineni <sdonthineni@nvidia.com>
>> > ---
>> >  drivers/firmware/smccc/soc_id.c | 5 ++---
>> >  1 file changed, 2 insertions(+), 3 deletions(-)
>> > 
>> > diff --git a/drivers/firmware/smccc/soc_id.c b/drivers/firmware/smccc/soc_id.c
>> > index 890eb454599a..1990263fbba0 100644
>> > --- a/drivers/firmware/smccc/soc_id.c
>> > +++ b/drivers/firmware/smccc/soc_id.c
>> > @@ -34,7 +34,6 @@ static struct soc_device_attribute *soc_dev_attr;
>> >  
>> >  static int __init smccc_soc_init(void)
>> >  {
>> > -	struct arm_smccc_res res;
>> >  	int soc_id_rev, soc_id_version;
>> >  	static char soc_id_str[20], soc_id_rev_str[12];
>> >  	static char soc_id_jep106_id_str[12];
>> > @@ -49,13 +48,13 @@ static int __init smccc_soc_init(void)
>> >  	}
>> >  
>> >  	if (soc_id_version < 0) {
>> > -		pr_err("ARCH_SOC_ID(0) returned error: %lx\n", res.a0);
>> > +		pr_err("Invalid SoC Version: %x\n", soc_id_version);
>> >  		return -EINVAL;
>> >  	}
>> >  
>> >  	soc_id_rev = arm_smccc_get_soc_id_revision();
>> >  	if (soc_id_rev < 0) {
>> > -		pr_err("ARCH_SOC_ID(1) returned error: %lx\n", res.a0);
>> > +		pr_err("Invalid SoC Revision: %x\n", soc_id_rev);
>> >  		return -EINVAL;
>> >  	}
>> >  
>> 
>> Ah, indeed. Well caught. FWIW:
>> 
>> Acked-by: Marc Zyngier <maz@kernel.org>

Thanks Marc.

>> Sudeep, I assume you'll take that one directly?
>> 
>
> Sure I will route it via (arm-)soc team.

Sudeep, hope you can add the tag while applying. Let me know if you'd
like me to resend.
