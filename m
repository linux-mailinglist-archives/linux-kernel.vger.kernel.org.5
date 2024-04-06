Return-Path: <linux-kernel+bounces-133812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D78789A923
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 07:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5EB0282D57
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 05:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409861EA6E;
	Sat,  6 Apr 2024 05:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=luigi311.com header.i=@luigi311.com header.b="yRxZ3zyb"
Received: from mail-108-mta70.mxroute.com (mail-108-mta70.mxroute.com [136.175.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141DE22EED
	for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2024 05:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712381156; cv=none; b=S2qOatob07BM1EUmV94LuFjWuZNfPARrcQv0d30V+ptUZ1Fr6ECFZfPGxqxJZf6Hwk18DixWgltbkBPHS2ApFNAVkzCArbXgkI05rg9QZh1aA960bQQhUmz5hDQzQki5U1P5v1jhLXfTj1JfP3coO1xYdvZgjHpPpRd2ilOd5lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712381156; c=relaxed/simple;
	bh=PcVc0enR4j7Fu4qIcJTJAGfb9eIbRBk+MbR+x31n5Z4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gZTAZhadm3llKe58GfNHXPSgTXyPYvlABkWCcmJAJlF/6Buwvzj7/4kf0SN517eopunc4ypyJzNcCX1s3ZuWs9nvQNdWJqROzTDWDyiT7LHQjd8VxyIreL6PuJ3B2ZwdYh1wrMd+BFW28JsDzj3lCMHY/0RfChpoas74syoeHPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=luigi311.com; spf=pass smtp.mailfrom=luigi311.com; dkim=pass (2048-bit key) header.d=luigi311.com header.i=@luigi311.com header.b=yRxZ3zyb; arc=none smtp.client-ip=136.175.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=luigi311.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=luigi311.com
Received: from filter006.mxroute.com ([136.175.111.2] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta70.mxroute.com (ZoneMTA) with ESMTPSA id 18eb1deb1d70003bea.010
 for <linux-kernel@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Sat, 06 Apr 2024 05:25:45 +0000
X-Zone-Loop: 5ab61b7ab5c7c6611faf13b08fd7b9380eaff5a76c04
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=luigi311.com; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
	From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=sz1o3+H/QzcFhJgMgxzNEIq38+fbX0fuDgjyR3Z3QQc=; b=yRxZ3zybwPCDOXYc6dTeGjFcrD
	oJ/ez3YSCH/U3R+W7HZ+fcllfTNo6nDrKK/J6LtIS+6pGlvAFrg1BKy+05tElSeHU+XVi9lLN7Jjq
	N9wWf/YR2FfU3yz4kxdskDLVFCSxd7zRrbZErNyZKiZ8MEh3oScdzDZhatOoB/q3+riVjlqTrkRy7
	Hqeh+nMcad2X60AuJoWOblCKmKuwLSR4xq2i1LF1f++LiJf/cQxwpQUlP0h1QbgLNhKUUez/MFVEI
	p5YxnOGH1HDkg3IQGhGvjSPxDKypqt8FcRQbW50njJ2QApLlk+PAT2yoMCtocDpSVBdl4iJWE7/by
	Vyq36ttA==;
Message-ID: <803b0bd3-e615-41c1-888e-69b6ecca0b8a@luigi311.com>
Date: Fri, 5 Apr 2024 23:25:41 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/25] media: i2c: imx258: Add support for running on 2
 CSI data lanes
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-media@vger.kernel.org, dave.stevenson@raspberrypi.com,
 jacopo.mondi@ideasonboard.com, mchehab@kernel.org, robh@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, shawnguo@kernel.org,
 s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
 sakari.ailus@linux.intel.com, devicetree@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org
References: <20240403150355.189229-1-git@luigi311.com>
 <20240403150355.189229-10-git@luigi311.com> <Zg2jvUDFnY83drlg@duo.ucw.cz>
Content-Language: en-US
From: Luis Garcia <git@luigi311.com>
In-Reply-To: <Zg2jvUDFnY83drlg@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authenticated-Id: git@luigi311.com

On 4/3/24 12:45, Pavel Machek wrote:
> Hi!
> 
>> +/*
>> + * 4208x3120 @ 30 fps needs 1267Mbps/lane, 4 lanes.
>> + * To avoid further computation of clock settings, adopt the same per
>> + * lane data rate when using 2 lanes, thus allowing a maximum of 15fps.
>> + */
>> +static const struct imx258_reg mipi_1267mbps_19_2mhz_2l[] = {
>> +	{ 0x0136, 0x13 },
>> +	{ 0x0137, 0x33 },
>> +	{ 0x0301, 0x0A },
>> +	{ 0x0303, 0x02 },
>> +	{ 0x0305, 0x03 },
>> +	{ 0x0306, 0x00 },
>> +	{ 0x0307, 0xC6 },
>> +	{ 0x0309, 0x0A },
>> +	{ 0x030B, 0x01 },
>> +	{ 0x030D, 0x02 },
>> +	{ 0x030E, 0x00 },
>> +	{ 0x030F, 0xD8 },
>> +	{ 0x0310, 0x00 },
>> +
>> +	{ 0x0114, 0x01 },
>> +	{ 0x0820, 0x09 },
>> +	{ 0x0821, 0xa6 },
>> +	{ 0x0822, 0x66 },
>> +	{ 0x0823, 0x66 },
>> +};
>> +
>> +static const struct imx258_reg mipi_1267mbps_19_2mhz_4l[] = {
>>  	{ 0x0136, 0x13 },
>>  	{ 0x0137, 0x33 },
>>  	{ 0x0301, 0x05 },
> 
> I wish we did not have to copy all the magic values like this.
> 
> Best regards,
> 								Pavel
> 								

no kidding, magic values everywhere.... it makes it annoying
for me to move things around because they all start to look
similar. Down the line we added in more defined names so its
not as bad but still its bad lol.

