Return-Path: <linux-kernel+bounces-59264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A8484F427
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 12:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C93841C24605
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 11:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E374328DBC;
	Fri,  9 Feb 2024 11:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EzvTMC9L"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDDF286AF
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 11:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707476787; cv=none; b=WQi0t0V+s0OFTyzaH0SqULEZPmVMoTomT3PbiYJGc7kHPLJKmQ4H9YmY5ShV1dvUw7m400PkbR5GYCo81gXehjjabQ/8Hlch++Cw2GbrGeUMieaom4LPSoA0VE5bu4fu9vkED87AqoKhGzrbGgTRulPD+Gh5iTcNXOEY3qADnZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707476787; c=relaxed/simple;
	bh=0zJEqkTAGocV9Q4tDm4JAX76xe+S9BxvwQRBRuTetPs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jm1TtJ/fzIO5s2FLQARjAtHzOAHikzNR6o2uQY9XPeo8LTdxCXQvhq+B2dkpoJtAE38lKmg0tU0d0zKihNK20k2s/FQ8ajPaka5oVK5At2yRD9H81pEJqfA38iO+oe4nQ3KKUSOUcHzJJ8+EjM1yT5F29wufwjyKHNx9dIVC5II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EzvTMC9L; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-51171c9f4c0so944824e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 03:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707476783; x=1708081583; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dNIMeDELEsgEmpHqgGVZK/F6ni2JqtV13kYmgPwfag4=;
        b=EzvTMC9L6qNLVxNU2e/7xjKk8uiaNZ9v94lqSTs/vB48Kh0dhuCTiWMrsHQdJ3ULyh
         nUc5OAsVSjNAofevlFX3+9PXZ4CKfycIv7cTRHb6cIKlEEevBncrVOnHJknhjgI9OOTm
         wrthAPgkJz7XqRr5N557brRQMCg1NEHfLzVz9kOcJn5LfzhISNhNLxYEi+9xNZg4YLIw
         SZZniUOF+UOLH8szCm2HOB5NAYoeBC0r5J+Q3ldu28gljbRD6+esKvRlhqnhipqQNAl7
         dEYmHnDcYX5hoGODoASBIjYLxEizDk5E+vRrg+KtwZy50heuMuW5oyqKehUeWTyqay7k
         vT1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707476783; x=1708081583;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dNIMeDELEsgEmpHqgGVZK/F6ni2JqtV13kYmgPwfag4=;
        b=taP1D2APjKnIrSBXaM5q2dUa0W77AkWCfmrMSm6RR9GjJ+0ljwzaJVNwqfkOQLLYEJ
         0Y6eqMmQma0ZVvmrxPXp+KGIBD2bAspqoKPL3jWN6D33WHCWGbabPnt+g27X5EbAfl1g
         uo4FU1W2mvBFfVVz3ck7uxYQOzQjMRz6CXqXAOFQ+v7YUlN2Gjt2NQRYATNZ7h0J0K3Q
         gSNxYfjiv15ead2IjQYWSX570ZUIuo8YrmGfEXaYyeWkITHEfpKyGtwbEG0erocN22VM
         eRFu3YV2QzabZBPg8Hjt+0QaS2sjC9shafqy3RzyVg13zu8Zygz8eOwiy17Oyq4sQMWa
         fsLg==
X-Gm-Message-State: AOJu0Yy0nXhsUD5jVPAD3k4J2FJ5aexNQIUqHJlbBPXP+pNXBv3bfZp+
	wnryeON1sbq9HJuhiZYTH0VMnv8CRKMIL3HrkLUvHK8iVONWcJrlxZF58QLsJOM=
X-Google-Smtp-Source: AGHT+IGZ4YeLwzzx9v2KEXYku9ce24n0sGchhrnQap39oaCPrLkoUAU1Sl/NMvrZ3PlAMCjfJ+TRmA==
X-Received: by 2002:a05:6512:1381:b0:511:5afc:f186 with SMTP id fc1-20020a056512138100b005115afcf186mr1088963lfb.26.1707476783128;
        Fri, 09 Feb 2024 03:06:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWNKk5u18t/ut/bsH1vOixwQcHhTy21s9IglMiX84N0gidC2hfcol35fdyB7F9vbD9O/XHeL8U9dHFzqTVbF74/jtEF0J67IVcVVzN6A/xBrNHbHyseqF5qrHIM+nk4P17gMax9XNcKsn7oQX5ECeEEx09GIHmTiplTmEQ8O9v2OR6xHA1Gt2cRqxJ0D4g4UaAbLt8MBB6tNA5/zLpg+9lqjO7VhJBROSXOdecuwgn7IV7M9YNXmc7z5OXM0S8os4PtV/3v5VO8sNUKC6Sm6vUw/TUN/rZrJITgzvplSJpoTCUwRSOv3PRT1ecLmHOfEUGWNRIIGEyLmGjm+M9wvwwOO676IrPctx/o1f9XOFd0VBCLvQNKIuReFh5XAFBqV6ukRXHMpdOca11H5oodx+Sa7CDi8ZaZAjA2ShcbLuVwMtf8wBr8XGuJQiguif4aoG3KEJ7ET+i6cFJXmqbJh7aPWnz0zFDy/epMJkve68hf+UB10h6NVSOYrOmLup25V1nOFBCyFiHQ/xp5oayvNuhB0UgDB8kovb2scqg9Q9ibijpgEvpA5veRYNib5JEvl7dWPW4R0WtaMHIYD6w/MJb2ikEL4/k4pDHPuJ4dVd6X8EW6q3UN3BLrYITa4fKDJfJ+RU1p0GxWsFlc8QGMS6GrKlQ36mVYy13e9Bd8EIAXMKWGQrTNDBpfX9sJM6Ax4nurkJot2JSc8f/rThLpO1iIQenMbiHg3V9ILKX4KtJy4+ADbNWVL/2nvd5WXDuuPR7/Nacb/IM3HuDPDZC15nx2/WZZqmEud4CbV2kDl0K0lgnT6zs5fWloKAwmBf5wlhfHppCJZtLN+0iZaRJEUiFxkFH9SgunzlMFTTZj26GPnnqAcuwIbcShmSx3Orzxn9QMUWe/lK0j23HuP/cacgY2OHKW8RVucqw0hNOHUDKWowf5
Received: from [192.168.2.107] ([79.115.63.202])
        by smtp.gmail.com with ESMTPSA id l9-20020a1c7909000000b0040e527602c8sm285252wme.9.2024.02.09.03.06.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Feb 2024 03:06:22 -0800 (PST)
Message-ID: <c6f209c8-47da-4881-921d-683464b9ddd5@linaro.org>
Date: Fri, 9 Feb 2024 11:06:20 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 07/10] mtd: spi-nor: Add stacked memories support in
 spi-nor
Content-Language: en-US
To: "Mahapatra, Amit Kumar" <amit.kumar-mahapatra@amd.com>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "pratyush@kernel.org" <pratyush@kernel.org>,
 "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
 "richard@nod.at" <richard@nod.at>, "vigneshr@ti.com" <vigneshr@ti.com>,
 "sbinding@opensource.cirrus.com" <sbinding@opensource.cirrus.com>,
 "lee@kernel.org" <lee@kernel.org>,
 "james.schulman@cirrus.com" <james.schulman@cirrus.com>,
 "david.rhodes@cirrus.com" <david.rhodes@cirrus.com>,
 "rf@opensource.cirrus.com" <rf@opensource.cirrus.com>,
 "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com" <tiwai@suse.com>
Cc: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "michael@walle.cc" <michael@walle.cc>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
 "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
 "claudiu.beznea@tuxon.dev" <claudiu.beznea@tuxon.dev>,
 "Simek, Michal" <michal.simek@amd.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "patches@opensource.cirrus.com" <patches@opensource.cirrus.com>,
 "linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
 "git (AMD-Xilinx)" <git@amd.com>,
 "amitrkcian2002@gmail.com" <amitrkcian2002@gmail.com>,
 Conor Dooley <conor.dooley@microchip.com>, beanhuo@micron.com
References: <20231125092137.2948-1-amit.kumar-mahapatra@amd.com>
 <e2305642-55f1-4893-bea3-b170ac0a5348@linaro.org>
 <BN7PR12MB2802BEDFB821A1748185794CDC8AA@BN7PR12MB2802.namprd12.prod.outlook.com>
 <f5a47024-514a-4846-bc16-08cf0f9af912@linaro.org>
 <BN7PR12MB2802BB3DA682D9C13EF7DE08DC8FA@BN7PR12MB2802.namprd12.prod.outlook.com>
 <5a6f6764-6779-42b0-b6c6-3f638b85ef78@linaro.org>
 <BN7PR12MB28029EB1A7D09882878499A2DC8FA@BN7PR12MB2802.namprd12.prod.outlook.com>
 <c3fa1e04-92ed-48ab-a509-98e43abd5cd6@linaro.org>
 <BN7PR12MB2802E87F1A6CD22D904CAEACDC93A@BN7PR12MB2802.namprd12.prod.outlook.com>
 <b3d3c457-a43b-478a-85b3-52558227d139@linaro.org>
 <BN7PR12MB28027E62D66460A374E3CFEADC93A@BN7PR12MB2802.namprd12.prod.outlook.com>
 <e212f9fa-83c5-4b9e-8636-c8c6183096ab@linaro.org>
 <BN7PR12MB280237CDD7BB148479932874DC93A@BN7PR12MB2802.namprd12.prod.outlook.com>
 <576d56ed-d24b-40f9-9ae4-a02c50eea2ab@linaro.org>
 <BN7PR12MB2802F288C6A6B1580CF07959DC95A@BN7PR12MB2802.namprd12.prod.outlook.com>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <BN7PR12MB2802F288C6A6B1580CF07959DC95A@BN7PR12MB2802.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/21/23 06:54, Mahapatra, Amit Kumar wrote:
>> Something else to consider: I see that Micron has a twin quad mode:
>> https://media-www.micron.com/-
>> /media/client/global/documents/products/data-sheet/nor-flash/serial-
>> nor/mt25t/generation-
>> b/mt25t_qljs_l_512_xba_0.pdf?rev=de70b770c5dc4da8b8ead06b57c03500
>>
>> The micron's "Separate Chip-Select and Clock Signals" resembles the AMD's
>> dual parallel 8-bit.
> Yes, I agree.
> 
>> Micron's "Shared Chip-Select and Clock Signals" differs from the AMD's
>> stacked mode, as Micron uses DQ[3:0] and DQ[7:4], whereas AMD considers
>> both as DQ[3:0].
> Yes, correct.

Amit, please help me to assess this. I assume Micron and Microchip is
using the same concepts as AMD uses for the "Dual Parallel 8-bit IO
mode", but they call it "Twin Quad Mode".

I was wrong, the AMD datasheet [1] was misleading [2], it described the
IOs for both flashes as IO[3:0], but later on in the "Table QSPI
Interface Signals" the second flash is described with IO[7:4].

The AMD's 8-bit Dual Flash Parallel Interface is using dedicated CS# and
CLK# lines for each flash. As Micron does, isn't it?

Micron says [3] that:
"The device contains two quad I/O die, each able to operate
independently for a total of eight I/Os. The memory map applies to each
die. Each die has internal registers for status, configuration, and
device protection that can be set and read independently from one other.
Micron recommends that internal configuration settings for the two die
be set identically."

it also says that:
"When using quad commands in XIO-SPI or when using QIO-SPI,
DQ[3:0]/DQ[7:4] are I/O."

So I guess the upper layers just ask for a chunk of memory to be written
and the controller handles the cs# lines automatically. How is the AMD
controller working, do you have to drive the cs# lines manually, or you
just set the parallel mode and the controller takes care of everything?

I assume this is how mchp is handling things, they seem to just set a
bit the protocol into the QSPI_IFR.PROTTYP register field and that's all
[4]. They even seem to write the registers of both flashes at the same time.

In what regards the AMD's "dual stack interface", AMD is sharing the
clock and IO lines and uses dedicated CS# lines for the flashes, whereas
Micron shares the CS# and CLK# lines with different IO lines.

Amit, please study the architectures used by mchp, micron and amd and
let us know if they are the same or they differ, and if they differ what
are the differences.

I added Conor from mchp in cc, I see Nicolas is already there, and Bean
from micron.

Thanks,
ta

[1]
https://docs.xilinx.com/r/en-US/am011-versal-acap-trm/QSPI-Flash-Interface-Signals
[2]
https://docs.xilinx.com/viewer/attachment/dwmjhDJGICdJqD4swyVzcQ/fD8nv4ry78xM0_EF5kv4mA
[3]
https://media-www.micron.com/-/media/client/global/documents/products/data-sheet/nor-flash/serial-nor/mt25t/generation-b/mt25t_qljs_l_512_xba_0.pdf?rev=de70b770c5dc4da8b8ead06b57c03500
[4]
https://ww1.microchip.com/downloads/aemDocuments/documents/MPU32/ProductDocuments/DataSheets/SAMA7G5-Series-Data-Sheet-DS60001765.pdf

