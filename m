Return-Path: <linux-kernel+bounces-132839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 079FD899B00
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 12:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 229EFB226F1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 10:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2BB715FA85;
	Fri,  5 Apr 2024 10:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=luigi311.com header.i=@luigi311.com header.b="pATTLDVL"
Received: from mail-108-mta111.mxroute.com (mail-108-mta111.mxroute.com [136.175.108.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEA71CD03
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 10:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712313538; cv=none; b=HdkOyePxQ93WMh0pyCqqKIZ03hRh2u67JEpSL5TVcvY5ZR9eT19RtmMSTp7dwB3s8UJeb8WRhtWelh/N3c10HtEjVuPPytyn5nIJLkZA48nC+jBt26zh5vi2lV8ETBUwZ/jvdnmfQR2ITlrwhufSHZs2TsLBOkGPhbdd+GNW8dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712313538; c=relaxed/simple;
	bh=xLI22zriJDENRfnsRmIjvn6POO6xOPVHd6HwhyKlUrk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jn/Ob/kYsAwTX3VIVWNS/DA5J9Jss19s2btYsT/KZfU0FuXXz9u0yMeGXURpKdQ1hxBJJXFz7m1a97I0lxVrAng0hTWUziFxbf2jw1N0kpx+x4is9Co8HQzlZ4C25PMEvRM919aqhXjGCpc1L2JBrYkP7q8kE0W5DoPUnp/fWZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=luigi311.com; spf=pass smtp.mailfrom=luigi311.com; dkim=pass (2048-bit key) header.d=luigi311.com header.i=@luigi311.com header.b=pATTLDVL; arc=none smtp.client-ip=136.175.108.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=luigi311.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=luigi311.com
Received: from filter006.mxroute.com ([136.175.111.2] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta111.mxroute.com (ZoneMTA) with ESMTPSA id 18eadd248db0003bea.010
 for <linux-kernel@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Fri, 05 Apr 2024 10:33:43 +0000
X-Zone-Loop: 0b5db6c4603024265795f5a8aa1c9d4fd257db595b0c
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=luigi311.com; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
	From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=vfGoyAWCyKZOHSAUcGDkEoz4paY7t5qH+0okM64n3Do=; b=pATTLDVLYKydxuA4/oMU+IXM8X
	evupdRWiPyqRs4QJYB3u83H2KriInjeFUXtv7UFyjn6jkcDdJywE8kQQFpc+NqypqFdtPp/GqgeSd
	/JArjSTKWOw4SHSRhZtEcsmwMEB27salHAMo/GhT7wMAzmOnETj//CUNv+jnhskVyBq40F4+UH5UH
	7OJ7pX+RVUagog04vV55RXxUCrj1Yzra14eOEvWyRmA7JrKFBfxmFmQE8Ra7esLdGtQ/ZyM94ymdX
	Ztl/Ad9Q6l8RKhYyN45hZ/K36FNA5jhYIhMrhkxuoUbDzmOduRhdl/cAIENpmkLIPPR9hNlD+gaZK
	UpvwQaAw==;
Message-ID: <082190a8-7ac5-4240-9a16-6b9168c67d57@luigi311.com>
Date: Fri, 5 Apr 2024 04:33:38 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 21/25] drivers: media: i2c: imx258: Use macros
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-media@vger.kernel.org, dave.stevenson@raspberrypi.com,
 jacopo.mondi@ideasonboard.com, mchehab@kernel.org, robh@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, shawnguo@kernel.org,
 s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
 devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 pavel@ucw.cz, phone-devel@vger.kernel.org, Ondrej Jirman <megi@xff.cz>
References: <20240403150355.189229-1-git@luigi311.com>
 <20240403150355.189229-22-git@luigi311.com>
 <Zg2CirmwL3JfjA8s@kekkonen.localdomain>
 <df8c245a-40e9-4bf5-b870-7efe321d820a@luigi311.com>
 <Zg5Mz0QSqNDXzY4o@kekkonen.localdomain>
Content-Language: en-US
From: Luis Garcia <git@luigi311.com>
In-Reply-To: <Zg5Mz0QSqNDXzY4o@kekkonen.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authenticated-Id: git@luigi311.com

On 4/4/24 00:46, Sakari Ailus wrote:
> On Wed, Apr 03, 2024 at 01:17:26PM -0600, Luigi311 wrote:
>> On 4/3/24 10:23, Sakari Ailus wrote:
>>> Hi Luis,
>>>
>>> On Wed, Apr 03, 2024 at 09:03:50AM -0600, git@luigi311.com wrote:
>>>> From: Luis Garcia <git@luigi311.com>
>>>>
>>>> Use understandable macros instead of raw values.
>>>>
>>>> Signed-off-by: Ondrej Jirman <megi@xff.cz>
>>>> Signed-off-by: Luis Garcia <git@luigi311.com>
>>>> ---
>>>>  drivers/media/i2c/imx258.c | 434 ++++++++++++++++++-------------------
>>>>  1 file changed, 207 insertions(+), 227 deletions(-)
>>>>
>>>> diff --git a/drivers/media/i2c/imx258.c b/drivers/media/i2c/imx258.c
>>>> index e2ecf6109516..30352c33f63c 100644
>>>> --- a/drivers/media/i2c/imx258.c
>>>> +++ b/drivers/media/i2c/imx258.c
>>>> @@ -33,8 +33,6 @@
>>>>  #define IMX258_VTS_30FPS_VGA		0x034c
>>>>  #define IMX258_VTS_MAX			65525
>>>>  
>>>> -#define IMX258_REG_VTS			0x0340
>>>> -
>>>>  /* HBLANK control - read only */
>>>>  #define IMX258_PPL_DEFAULT		5352
>>>>  
>>>> @@ -90,6 +88,53 @@
>>>>  #define IMX258_PIXEL_ARRAY_WIDTH	4208U
>>>>  #define IMX258_PIXEL_ARRAY_HEIGHT	3120U
>>>>  
>>>> +/* regs */
>>>> +#define IMX258_REG_PLL_MULT_DRIV                  0x0310
>>>> +#define IMX258_REG_IVTPXCK_DIV                    0x0301
>>>> +#define IMX258_REG_IVTSYCK_DIV                    0x0303
>>>> +#define IMX258_REG_PREPLLCK_VT_DIV                0x0305
>>>> +#define IMX258_REG_IOPPXCK_DIV                    0x0309
>>>> +#define IMX258_REG_IOPSYCK_DIV                    0x030b
>>>> +#define IMX258_REG_PREPLLCK_OP_DIV                0x030d
>>>> +#define IMX258_REG_PHASE_PIX_OUTEN                0x3030
>>>> +#define IMX258_REG_PDPIX_DATA_RATE                0x3032
>>>> +#define IMX258_REG_SCALE_MODE                     0x0401
>>>> +#define IMX258_REG_SCALE_MODE_EXT                 0x3038
>>>> +#define IMX258_REG_AF_WINDOW_MODE                 0x7bcd
>>>> +#define IMX258_REG_FRM_LENGTH_CTL                 0x0350
>>>> +#define IMX258_REG_CSI_LANE_MODE                  0x0114
>>>> +#define IMX258_REG_X_EVN_INC                      0x0381
>>>> +#define IMX258_REG_X_ODD_INC                      0x0383
>>>> +#define IMX258_REG_Y_EVN_INC                      0x0385
>>>> +#define IMX258_REG_Y_ODD_INC                      0x0387
>>>> +#define IMX258_REG_BINNING_MODE                   0x0900
>>>> +#define IMX258_REG_BINNING_TYPE_V                 0x0901
>>>> +#define IMX258_REG_FORCE_FD_SUM                   0x300d
>>>> +#define IMX258_REG_DIG_CROP_X_OFFSET              0x0408
>>>> +#define IMX258_REG_DIG_CROP_Y_OFFSET              0x040a
>>>> +#define IMX258_REG_DIG_CROP_IMAGE_WIDTH           0x040c
>>>> +#define IMX258_REG_DIG_CROP_IMAGE_HEIGHT          0x040e
>>>> +#define IMX258_REG_SCALE_M                        0x0404
>>>> +#define IMX258_REG_X_OUT_SIZE                     0x034c
>>>> +#define IMX258_REG_Y_OUT_SIZE                     0x034e
>>>> +#define IMX258_REG_X_ADD_STA                      0x0344
>>>> +#define IMX258_REG_Y_ADD_STA                      0x0346
>>>> +#define IMX258_REG_X_ADD_END                      0x0348
>>>> +#define IMX258_REG_Y_ADD_END                      0x034a
>>>> +#define IMX258_REG_EXCK_FREQ                      0x0136
>>>> +#define IMX258_REG_CSI_DT_FMT                     0x0112
>>>> +#define IMX258_REG_LINE_LENGTH_PCK                0x0342
>>>> +#define IMX258_REG_SCALE_M_EXT                    0x303a
>>>> +#define IMX258_REG_FRM_LENGTH_LINES               0x0340
>>>> +#define IMX258_REG_FINE_INTEG_TIME                0x0200
>>>> +#define IMX258_REG_PLL_IVT_MPY                    0x0306
>>>> +#define IMX258_REG_PLL_IOP_MPY                    0x030e
>>>> +#define IMX258_REG_REQ_LINK_BIT_RATE_MBPS_H       0x0820
>>>> +#define IMX258_REG_REQ_LINK_BIT_RATE_MBPS_L       0x0822
>>>> +
>>>> +#define REG8(a, v) { a, v }
>>>> +#define REG16(a, v) { a, ((v) >> 8) & 0xff }, { (a) + 1, (v) & 0xff }
>>>
>>> The patch is nice but these macros are better replaced by the V4L2 CCI
>>> helper that also offers register access functions. Could you add a patch to
>>> convert the driver to use it (maybe after this one)?
>>>
>>
>> Ohh perfect, using something else would be great. Ill go ahead and see
>> if I can get that working.
> 
> Thanks. It may be easier to just do it in this one actually. Up to you.
> 

I've made the swap but looks like its not playing nice with my ppp,
its causing a crash and showing a call trace as soon as it does its
first read to check the identity. I went in and dropped the cci_read
and left it with the original implementation and I'm getting a very
similar crash with cci_write too so it looks like its not liking
how I'm implementing it. Looking at the few other drivers that were
swapped over to use that, I don't seem to be missing anything. It's
a big change so its not really something I can describe what I've
changed but I do have the change on my github here
https://github.com/luigi311/linux/commit/840593acb20eee87ce361e6929edf51eefbbe737
if you can provide some guidance, if not I can skip this change
all together and we can do a separate attempt at swapping over to it.

