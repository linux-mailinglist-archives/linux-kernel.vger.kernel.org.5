Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 772958107F5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 03:07:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378249AbjLMCGy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 12 Dec 2023 21:06:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235180AbjLMCGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 21:06:53 -0500
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA2BAA;
        Tue, 12 Dec 2023 18:06:58 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=guanjun@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VyO8iev_1702433215;
Received: from smtpclient.apple(mailfrom:guanjun@linux.alibaba.com fp:SMTPD_---0VyO8iev_1702433215)
          by smtp.aliyun-inc.com;
          Wed, 13 Dec 2023 10:06:56 +0800
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [PATCH 1/1] soc: qcom: Fix compile error caused by uncorrectable
 definition of TRACE_INCLUDE_PATH
From:   guanjun <guanjun@linux.alibaba.com>
In-Reply-To: <kulysgxsa2lazwpbmovqtide3kvt6qq2dwtxmmi3ugznteo233@67ayvx2lduhi>
Date:   Wed, 13 Dec 2023 10:06:54 +0800
Cc:     neil.armstrong@linaro.org, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <3C315830-A476-4B85-A132-6BEC7E1983AD@linux.alibaba.com>
References: <20231209074716.2689401-1-guanjun@linux.alibaba.com>
 <kulysgxsa2lazwpbmovqtide3kvt6qq2dwtxmmi3ugznteo233@67ayvx2lduhi>
To:     Andrew Halaney <ahalaney@redhat.com>
X-Mailer: Apple Mail (2.3693.40.0.1.81)
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> 2023年12月12日 下午10:44，Andrew Halaney <ahalaney@redhat.com> 写道：
> 
> On Sat, Dec 09, 2023 at 03:47:16PM +0800, 'Guanjun' wrote:
>> From: Guanjun <guanjun@linux.alibaba.com>
>> 
>> Compiler reports the error message when compiling the file drivers/soc/qcom/pmic_pdcharger_ulog.c:
>>  - ./include/trace/define_trace.h:95:42: fatal error: ./pmic_pdcharger_ulog.h: No such file or directory
>>      95 | #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
>> 
>> TRACE_INCLUDE_PATH shoule be relative to the path include/trace/define_trace.h, not
>> the file including it. Fix it.
>> 
>> Fixes: 086fdb48bc65d(soc: qcom: add ADSP PDCharger ULOG driver)
>> Signed-off-by: Guanjun <guanjun@linux.alibaba.com>
> 
> For what it is worth I sent a similar patch (which handled this by using
> the CFLAG -I recommendation) over here about a week ago:
> 
>    https://lore.kernel.org/linux-arm-msm/20231205-pmicpdcharger-ulog-fixups-v1-1-71c95162cb84@redhat.com/

Sorry. I didn’t check you have already sent the fixed patch. Please ignore this email

> 
> I keep disabling this driver locally when developing (or picking up that
> patch) until something gets scooped up.
> 
>> ---
>> drivers/soc/qcom/pmic_pdcharger_ulog.h | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/drivers/soc/qcom/pmic_pdcharger_ulog.h b/drivers/soc/qcom/pmic_pdcharger_ulog.h
>> index 9d5d9af4fbe4..3ac994d160bd 100644
>> --- a/drivers/soc/qcom/pmic_pdcharger_ulog.h
>> +++ b/drivers/soc/qcom/pmic_pdcharger_ulog.h
>> @@ -28,7 +28,7 @@ TRACE_EVENT(pmic_pdcharger_ulog_msg,
>> /* This part must be outside protection */
>> 
>> #undef TRACE_INCLUDE_PATH
>> -#define TRACE_INCLUDE_PATH .
>> +#define TRACE_INCLUDE_PATH ../../../drivers/soc/qcom/
>> 
>> #undef TRACE_INCLUDE_FILE
>> #define TRACE_INCLUDE_FILE pmic_pdcharger_ulog
>> -- 
>> 2.39.3
>> 
>> 

