Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22F967DD141
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 17:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344953AbjJaQKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 12:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344890AbjJaQKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 12:10:16 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03olkn2027.outbound.protection.outlook.com [40.92.58.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3748BA6;
        Tue, 31 Oct 2023 09:10:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bUWEzCX2yLvUiXi0lvKujfKsrspl90piFWQk5prehXbbvI+otCGKyETQqpgvEvW0EoPgOlbjOSuIXu0wEjxrlG3R1cetyFTrTWka7CKg1dRRq19nY+0y0fGC7iCqkFoWn1/YACtIEWk0k07CoZa5EEJiTHcGVUl3VUuVJC/si+Zvey2yv/z+If7JCQjSNKbuHAgAdzPlXz5MD3V3HpC9Z5+iOfDbD44v04yfj8MnSlCdyFADJu4pkVV5SIfV9lPHF9dta86LcAzdcmMukJKGGNkmvW5GfqPGv6hhJvHgWVAm5UMw9A4lChzf7qDLbECAn65e6I98ngGpLmpexqR7Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0gfmPxWwXeaM6QWXK4y4FDkrdgrE/dEuHe+DiD9zSqk=;
 b=eq3c6UatFlcMgRddrMi/nHWq8L4KksR4ViVWTnRHkFpgtsODzYBMDZQUfoynR8Wz4tPDCIBdkz4+3XZ9IYsnwDWnmhTvLl5PJrL2HZoIqORX2F+lKMyyJcS9ARgU/w0Crqip02hzJS6IYefCASWsbSyxFHzPd+qYhcqx+cLgyMulg6F37PP5boKSbozKgIw0xjT4GvOryOqlaHMUgbnsGsJRUGqogr95mkvbAZS+S6x2hMbO/yrd+fqKDZLUUrtmjoSiNTwyDThwVzi6Wb42laZ9SJe0VLEKkQiOSnSq4OvlHv27vEx0JM+OI8ZhZ23OAa+wX3WFJShoLd/22V+8Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from AS8P193MB1285.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:333::21)
 by DB9P193MB1177.EURP193.PROD.OUTLOOK.COM (2603:10a6:10:23c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.29; Tue, 31 Oct
 2023 16:10:12 +0000
Received: from AS8P193MB1285.EURP193.PROD.OUTLOOK.COM
 ([fe80::b89e:5e18:1a08:409d]) by AS8P193MB1285.EURP193.PROD.OUTLOOK.COM
 ([fe80::b89e:5e18:1a08:409d%6]) with mapi id 15.20.6933.029; Tue, 31 Oct 2023
 16:10:12 +0000
Message-ID: <AS8P193MB1285473EE92FEDB65C08C131E4A0A@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
Date:   Tue, 31 Oct 2023 17:10:24 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: stmmac: Wait a bit for the reset to take effect
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <AS8P193MB1285DECD77863E02EF45828BE4A1A@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
 <j37ktiug7vwbb7h7s44zmng5a2bjzbd663p7pfowbehapjv3by@vrxfmapscaln>
Content-Language: en-US
From:   Bernd Edlinger <bernd.edlinger@hotmail.de>
In-Reply-To: <j37ktiug7vwbb7h7s44zmng5a2bjzbd663p7pfowbehapjv3by@vrxfmapscaln>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TMN:  [6BUMgrm7791Q8ukIitnp+kUXt4NXH5ko7uCO9WIm+B+8QZ39lD9bhPkZw20dpltg]
X-ClientProxiedBy: FR4P281CA0400.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::20) To AS8P193MB1285.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:333::21)
X-Microsoft-Original-Message-ID: <9fbb31ed-5164-4869-ab18-0a4a93591f53@hotmail.de>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P193MB1285:EE_|DB9P193MB1177:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f3a2d28-bb3e-4be5-227e-08dbda2bdc3a
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YUuRZFdzgSQNqTzmAMxBDixU6J0QC3TjL2f+WWSj1EtSHPJW+veijF/RPY7X2cEEP4curW13L7gPE+VWh4ncwEYxBoNEe+o+Uxqor6RV3Ms36ZQPp+wrC5w+Qd3JJPlpSPFJLvcP7tGbEj4LCWnEjdSgctxtj5IOtfAyOnpfEtCupOHU4L4Z/jG6vmsNkBLb+19wy127KweQhGYgp8ymRFoV8d6iNEEOZgSHr3GssB19cEtw9swD4QEU+rZWss9hW5iE25dhnJ0GnAh/ti8M7yL7Rce1W3AXTcHyREyqBzUk7cYQQodqRwEm3anGKxiymzVVkcNhgZ2o9O5YVf/wjG4aN5AanY1iqHezSbjMDoz/nCvDQvfhQalh4VdJWHl1JZoKsCOzT173r9l+RXy1tY9CNu/G5An2uOeQGJtASvEUe9nxYeU2Q9crt4zh1kxDZr/UGpblXgsuU940Wv4cWTMrPlpO1xsTtWB487ZLtK0e+4diFQeku87yHVBxz4nDm/hSgdmJsBHdnrVT8FC52ZPYwZ9EbjrovNHxhG4oqt3NTWYrNRS8AYxPqd/B94ae
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHpXS0xUeHdGcU45THpFWm5rL25lQS9wVVR2a0hTcHdwWWE2eEpqYkNicmhp?=
 =?utf-8?B?WkJueE9HUG14TkNheGtJNFkwNmIxTjFBYTBVSVUwejlhZTEwdDBsU1FidGNF?=
 =?utf-8?B?eEZMa1d1b3h6QTdWZTNxZEM4VE9nMTRkVjRqLzgzNFRRd2pDTGFDcEYzTWdE?=
 =?utf-8?B?bnNGYU5HUEMzY2FWRmFCNGUwRWRpZ0F4NHAxSW9pZC9yMEVDdkN5TlcxcFBn?=
 =?utf-8?B?Zm03cEJxNU9DRkdtQnY3WmdsWitYWjU2VU5wSXlOWmZnb3p6TGVHbjliRUpS?=
 =?utf-8?B?RGxxL1YzSTByNy9ISFNkdzNNMzI5YXhhcG5YY3BvajNDc1pMSWV5a3I0cTh1?=
 =?utf-8?B?aEVuQUQ4eDVZTjNLNUMxNTNjNWdTRkpSYVJ4RVFBRjllcisvdXczMUZITlk0?=
 =?utf-8?B?VXFaZng4U3lIeUwySXY2K3YwRUpBN2VuZXR0d3BlMEZ1cFNqZ3U1WmRzaExi?=
 =?utf-8?B?UzNBRlhXb0dXbDZGL0YvdmlyVGNkN1g3ZDhmWUo3M2xkNXl6dGluNnFxN2pD?=
 =?utf-8?B?TkI3N0dJejNTUDdjRzBsSTIwT3l5aDh5bXZxTTRaa2lOY3pZV24wSURiY2RG?=
 =?utf-8?B?THo3VVVJejhHVlBKRkdvOEZsUEtySDYydk1HcVR3L2pOQUFUS0U1cmd3MjN4?=
 =?utf-8?B?YVRhU3VBSjdFRWtmM1BXYk9Vc3Z0UTZvbnVEaEVSemY1Q0JreFg3K0lXMnFY?=
 =?utf-8?B?cWNKbW9IekpESVE5czNxdHo4UDI4VkREbFpHLzBUS1I3YTRYdG85NkpCcEVr?=
 =?utf-8?B?c2JWS3Y0Z0t5OWRTdnhsZ21YeUhjaStQQnhlQnBFNXRBZ3REUytNcTNrSWQr?=
 =?utf-8?B?dWFuRWl0bHA1Z2ZyUEppVHJQdndOYVl0Y1ZaaFlJc3h4eGtrQkI3MDh5aGRr?=
 =?utf-8?B?VmUvZlJkV2N2RzQwWTRPUFdsSXlFaEVBY0RKYVVYRmhMNWMvMXpIRGhWblRQ?=
 =?utf-8?B?eXUxZ3lsSm44Q2hzUVl3UHZlT2JiZlBXamowVkJMMkRjSHhIcFpMczZlSTVq?=
 =?utf-8?B?RXZUTUpaVkZSZXUvb1YwNjFLcm1YaW1wWXlIN3VZbzhxN0YvNFQrR1ZDZFBm?=
 =?utf-8?B?QVIwVkVqZzFXRVJYcXg2UHNEWXZMS1JTNGZ3eDNIRjlQclExNC9CRktLdTha?=
 =?utf-8?B?ZGdKTjRLd1lXT0E5aytTNFk3UWZ5QS9yc1BDZEVIVHA3bHdmNWE2R0ZaWHJS?=
 =?utf-8?B?dDRJclljeERZRHBLTmVpejJuSFJKS1oyOVZrcThQTmlHVlNjVEQ3M0ZyYjBy?=
 =?utf-8?B?WDZKQWxUMnFCQVJ0aVFqZ3Azai9PWHc2ZFYxL3hiSXhjL3h6NjRwdmM0OFhM?=
 =?utf-8?B?cGNjSnpDaG9WNzNnaGlkS2xqeFlDYSs4QzA3b3NiTURzZ1U4U2ZlempZUXVO?=
 =?utf-8?B?NHJWTzdMS2xuR3d1N1dOSnNISVhZamxFZkh2V1NxZG9ZSHAzNTl3ZXQxSEo0?=
 =?utf-8?B?UW50VkhFVHo4cmlqM1RldnJhTEVOdWFrWVVYaVM3ajVwZnVvTXpXRUF1aDRn?=
 =?utf-8?B?NHYyUVRPVkhOaE9tcjNTMjV5OEpCalJkaWlpU0JYSytnWEZPbmg5U3VVZlVL?=
 =?utf-8?B?bEVUS1pvdDMxMVBMNEFFMjhlTXBYOUdaMW9RRmVYMjJWUmZNR1dLV0cyaURo?=
 =?utf-8?B?dUpTYWZSeGhSZ1NlMlU0c1ZlbDdWaWF4QUtXS2xXdmlGMXdNSjlvYkVnMHU4?=
 =?utf-8?B?VTBPb2VycDlIYllhdC9FQWFhNUZWZi9BK0c2clZ4em5pMHk1TnEzeHdPaWIx?=
 =?utf-8?Q?sAnUoVdoHeWPNyyAI8=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-80ceb.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f3a2d28-bb3e-4be5-227e-08dbda2bdc3a
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB1285.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 16:10:12.0736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P193MB1177
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/31/23 11:32, Serge Semin wrote:
> On Mon, Oct 30, 2023 at 07:01:11AM +0100, Bernd Edlinger wrote:
>> otherwise the synopsys_id value may be read out wrong,
>> because the GMAC_VERSION register might still be in reset
>> state, for at least 1 us after the reset is de-asserted.
> 
> From what have you got that delay value?
> 

Just try and error, with very old linux versions and old gcc versions
the synopsys_id was read out correctly most of the time (but not always),
with recent linux versions and recnet gcc versions it was read out
wrongly most of the time, but again not always.
I don't have access to the VHDL code in question, so I cannot
tell why it takes so long to get the correct values, I also do not
have more than a few hardware samples, so I cannot tell how long
this timeout must be in worst case.
Experimentally I can tell that the register is read several times
as zero immediately after the reset is de-asserted, also adding several
no-ops is not enough, adding a printk is enough, also udelay(1) seems to
be enough but I tried that not very often, and I have not access to many
hardware samples to be 100% sure about the necessary delay.
And since the udelay here is only executed once per device instance,
it seems acceptable to delay the boot for 10 us.

BTW: my hardware's synopsys id is 0x37.


Bernd.

> -Serge(y)
> 
>>
>> Add a wait for 10 us before continuing to be on the safe side.
>>
>> Signed-off-by: Bernd Edlinger <bernd.edlinger@hotmail.de>
>> ---
>>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> index 5801f4d50f95..e485f4db3605 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>> @@ -7398,6 +7398,9 @@ int stmmac_dvr_probe(struct device *device,
>>  		dev_err(priv->device, "unable to bring out of ahb reset: %pe\n",
>>  			ERR_PTR(ret));
>>  
>> +	/* Wait a bit for the reset to take effect */
>> +	udelay(10);
>> +
>>  	/* Init MAC and get the capabilities */
>>  	ret = stmmac_hw_init(priv);
>>  	if (ret)
>> -- 
>> 2.39.2
>>
>>
