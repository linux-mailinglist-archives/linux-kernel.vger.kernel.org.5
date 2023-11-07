Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5AB87E3ACE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 12:11:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234144AbjKGLLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 06:11:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjKGLL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 06:11:29 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1AE791;
        Tue,  7 Nov 2023 03:11:24 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id C2F5D42037;
        Tue,  7 Nov 2023 11:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1699355482; bh=Frk6PkhJ+dLZC75biS7hjdNdSbrr/RAauRBXiXUvqLM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=qHl4kDTaNAypkYFDLItTWtXAKKot5SRMZjhy4PGrWvd5cPKKhyeiXD+lwVtF+Jj4v
         iT9ouP6py42HEN0OskzYuu2MscRmcnOop+Iw0pCejRFO2/GWSh8VeZ1HrmYJJpvf4F
         z5vWUiz2r+lxg3av7Fl45z2TLsYCAC/0m0aiuaeO8ZkgBSqCCUh40CUw8kJQnOqJ/i
         /VQ/aGZWW8koFPz5YFg8WkLTkhgtTwOIMEUZhhYzm7NQzzY0l6xhHKvsdWY2gx8Quc
         NwJdrS4+EQkhBb4Rg9LlaN0/J43O817uiQzwfJOhTf1uJvT0K74AyXb1tfYsgOftJB
         8CwvW7UAEyANw==
Message-ID: <26a081e6-032a-b58d-851c-eaac745e7c87@marcan.st>
Date:   Tue, 7 Nov 2023 20:11:16 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 4/5] wifi: brcmfmac: Support bss_info up to v112
Content-Language: en-US
To:     Arend van Spriel <arend.vanspriel@broadcom.com>,
        Daniel Berlin <dberlin@dberlin.org>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>
Cc:     linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, linux-kernel@vger.kernel.org
References: <cover.1697650207.git.dberlin@dberlin.org>
 <079882bf4a7c026547ecf8ad50a2b7a49ade7130.1697650207.git.dberlin@dberlin.org>
 <b907f696-c966-54ef-3267-12833c6f5d91@broadcom.com>
From:   Hector Martin <marcan@marcan.st>
In-Reply-To: <b907f696-c966-54ef-3267-12833c6f5d91@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/10/2023 18.59, Arend van Spriel wrote:
> On 10/19/2023 3:42 AM, Daniel Berlin wrote:
>> From: Hector Martin <marcan@marcan.st>
>>
>> The structures are compatible and just add fields, so we can just treat
>> it as always v112. If we start using new fields, that will have to be
>> gated on the version.
> 
> Seems EHT is creeping in here.
> 
> Having doubts about compatibility statement (see below)...
> 
>> Signed-off-by: Hector Martin <marcan@marcan.st>
>> ---
>>   .../broadcom/brcm80211/brcmfmac/cfg80211.c    |  5 ++-
>>   .../broadcom/brcm80211/brcmfmac/fwil_types.h  | 37 +++++++++++++++++--
>>   2 files changed, 36 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
>> index 4cf728368892..bc8355d7f9b5 100644
>> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
>> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
>> @@ -3496,8 +3496,9 @@ static s32 brcmf_inform_bss(struct brcmf_cfg80211_info *cfg)
>>   
>>   	bss_list = (struct brcmf_scan_results *)cfg->escan_info.escan_buf;
>>   	if (bss_list->count != 0 &&
>> -	    bss_list->version != BRCMF_BSS_INFO_VERSION) {
>> -		bphy_err(drvr, "Version %d != WL_BSS_INFO_VERSION\n",
>> +	    (bss_list->version < BRCMF_BSS_INFO_MIN_VERSION ||
>> +	    bss_list->version > BRCMF_BSS_INFO_MAX_VERSION)) {
>> +		bphy_err(drvr, "BSS info version %d unsupported\n",
>>   			 bss_list->version);
>>   		return -EOPNOTSUPP;
>>   	}
>> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.h
>> index 1077e6f1d61a..81f2d77cb004 100644
>> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.h
>> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.h
>> @@ -18,7 +18,8 @@
>>   #define BRCMF_ARP_OL_HOST_AUTO_REPLY	0x00000004
>>   #define BRCMF_ARP_OL_PEER_AUTO_REPLY	0x00000008
>>   
>> -#define	BRCMF_BSS_INFO_VERSION	109 /* curr ver of brcmf_bss_info_le struct */
>> +#define	BRCMF_BSS_INFO_MIN_VERSION	109 /* min ver of brcmf_bss_info_le struct */
>> +#define	BRCMF_BSS_INFO_MAX_VERSION	112 /* max ver of brcmf_bss_info_le struct */
>>   #define BRCMF_BSS_RSSI_ON_CHANNEL	0x0004
>>   
>>   #define BRCMF_STA_BRCM			0x00000001	/* Running a Broadcom driver */
>> @@ -323,28 +324,56 @@ struct brcmf_bss_info_le {
>>   	__le16 capability;	/* Capability information */
>>   	u8 SSID_len;
>>   	u8 SSID[32];
>> +	u8 bcnflags;		/* additional flags w.r.t. beacon */
> 
> Ehm. Coming back to your statement "structures are compatible and just 
> add fields". How are they compatible? You now treat v109 struct as v112 
> so fields below are shifted because of bcnflags. So you read invalid 
> information. This does not fly or I am missing something here.

bcmflags was previously an implied padding byte. If you actually check
the offsets of the subsequent fields, you'll see they haven't changed.
In fact this was added at some point in the past and just missing here,
and is a general case of "padding bytes were not explicitly specified"
which is arguably an anti-pattern and should never have been the case.

Had all the padding been specified correctly from the get go, it would
have been clear that this field was taking over an existing padding
byte, not adding anything nor shifting the offsets of subsequent fields.

> 
>>   	struct {
>>   		__le32 count;   /* # rates in this set */
>>   		u8 rates[16]; /* rates in 500kbps units w/hi bit set if basic */
>>   	} rateset;		/* supported rates */
>>   	__le16 chanspec;	/* chanspec for bss */
>>   	__le16 atim_window;	/* units are Kusec */
> 
> [...]

- Hector

